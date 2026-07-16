#!/usr/bin/env ruby

require "json"
require "pathname"
require "yaml"

ROOT = Pathname.new(__dir__).parent

def assert(condition, message)
  raise "CONTRACT ERROR: #{message}" unless condition
end

def close?(left, right, epsilon = 1e-9)
  (left.to_f - right.to_f).abs <= epsilon
end

profile_path = ROOT.join("profiles/aegis/zsl1.yaml")
profile = YAML.safe_load(profile_path.read, aliases: false, filename: profile_path.to_s)
backend = profile.fetch("backend")
public_contract = profile.fetch("public_contract")

assert(profile.fetch("sdk_version") == "0.3.0", "profile SDK version must be 0.3.0")
assert(profile.dig("provenance", "value_policy").include?("not measured robot data"), "profile must reject measured-data claims")
assert(profile.dig("provenance", "hardware_model_mapping") == "TBD", "hardware model mapping must remain TBD until sourced")

move_axes = backend.dig("move", "axes")
longitudinal = public_contract.fetch("longitudinal")
lateral = public_contract.fetch("lateral")
turn = public_contract.fetch("turn")

[
  [longitudinal, move_axes.fetch("vx_mps"), "public_abs_min_mps", "public_abs_max_mps", "longitudinal"],
  [lateral, move_axes.fetch("vy_mps"), "public_abs_min_mps", "public_abs_max_mps", "lateral"],
  [turn, move_axes.fetch("yaw_rate_rad_s"), "public_abs_min_rad_s", "public_abs_max_rad_s", "turn"]
].each do |public_axis, backend_axis, public_min_key, public_max_key, name|
  assert(public_axis.fetch(public_min_key) >= backend_axis.fetch("nonzero_abs_min"), "#{name} public minimum is below backend minimum")
  assert(public_axis.fetch(public_max_key) <= backend_axis.fetch("abs_max"), "#{name} public maximum exceeds backend maximum")
end

{
  "longitudinal" => longitudinal,
  "lateral" => lateral
}.each do |name, axis|
  levels = axis.fetch("speed_levels_mps").sort_by { |key, _value| key.to_i }.map(&:last)
  assert(levels.each_cons(2).all? { |left, right| left < right }, "#{name} speed levels must be strictly increasing")
  assert(levels.all? { |value| value >= axis.fetch("public_abs_min_mps") && value <= axis.fetch("public_abs_max_mps") }, "#{name} speed level outside public range")

  percent = axis.fetch("speed_percent")
  mapped_min = percent.fetch("min") / 100.0 * axis.fetch("public_abs_max_mps")
  assert(close?(mapped_min, axis.fetch("public_abs_min_mps")), "#{name} minimum percentage must resolve to public minimum")
end

assert(longitudinal.fetch("speed_levels_mps") == { 1 => 0.2, 2 => 0.4, 3 => 0.6, 4 => 0.8, 5 => 1.0 }, "longitudinal speed-level mapping changed")
assert(longitudinal.fetch("pace_mps") == { "slow" => 0.2, "normal" => 0.4, "fast" => 0.8 }, "pace mapping changed")
assert(lateral.fetch("speed_levels_mps") == { 1 => 0.1, 2 => 0.2, 3 => 0.3, 4 => 0.4, 5 => 0.5 }, "lateral speed-level mapping changed")
assert(longitudinal.fetch("signs") == { "forward" => 1, "backward" => -1 }, "longitudinal signs changed")
assert(lateral.fetch("signs") == { "left" => 1, "right" => -1 }, "lateral signs changed")
assert(turn.fetch("signs") == { "left" => 1, "right" => -1 }, "turn signs changed")

attitude_axes = backend.dig("attitude_control", "axes")
{
  "twist" => [public_contract.fetch("twist"), "yaw_rate_rad_s"],
  "look_body" => [public_contract.fetch("look_body"), "pitch_rate_rad_s"]
}.each do |name, (public_axis, backend_axis_name)|
  backend_axis = attitude_axes.fetch(backend_axis_name)
  assert(public_axis.fetch("public_abs_max_rad_s") <= backend_axis.fetch("max"), "#{name} public maximum exceeds attitude backend")
  assert(-public_axis.fetch("public_abs_max_rad_s") >= backend_axis.fetch("min"), "#{name} public negative maximum exceeds attitude backend")
end
assert(public_contract.dig("look_body", "signs") == { "down" => 1, "up" => -1 }, "body-pitch signs changed")

expected_actions = {
  "stand" => "standUp",
  "lie_down" => "lieDown",
  "passive" => "passive",
  "jump" => "jump",
  "front_jump" => "frontJump",
  "backflip" => "backflip"
}
expected_actions.each do |name, method|
  action = backend.dig("actions", name)
  assert(action.fetch("method") == method, "#{name} method changed")
  assert(action.fetch("arguments") == [], "#{name} must remain parameterless")
  assert(action.fetch("return_type") == "uint32", "#{name} return type changed")
end
two_leg = backend.dig("actions", "two_leg_stand")
assert(two_leg.fetch("arguments") == %w[vx_mps yaw_rate_rad_s], "twoLegStand arguments changed")
assert(two_leg.dig("axes", "vx_mps") == { "zero_allowed" => true, "nonzero_abs_min" => 0.2, "abs_max" => 0.5 }, "twoLegStand vx range changed")
assert(two_leg.dig("axes", "yaw_rate_rad_s") == { "zero_allowed" => true, "nonzero_abs_min" => 0.2, "abs_max" => 1.0 }, "twoLegStand yaw range changed")
assert(backend.dig("actions", "cancel_two_leg_stand", "return_type") == "void", "cancelTwoLegStand return type changed")
assert(backend.dig("telemetry", "battery_percent") == { "method" => "getBatteryPower", "type" => "uint32", "min" => 0, "max" => 100 }, "battery source contract changed")
expected_telemetry_methods = %w[
  getQuaternion getRPY getBodyAcc getBodyGyro getPosition getWorldVelocity
  getBodyVelocity getBatteryPower getCurrentCtrlmode getLegAbadJoint
  getLegHipJoint getLegKneeJoint getLegAbadJointVel getLegHipJointVel
  getLegKneeJointVel getLegAbadJointTorque getLegHipJointTorque
  getLegKneeJointTorque
]
actual_telemetry_methods = backend.fetch("telemetry").to_s.scan(/get[A-Za-z]+/).uniq
assert((expected_telemetry_methods - actual_telemetry_methods).empty?, "profile is missing high-level telemetry methods: #{expected_telemetry_methods - actual_telemetry_methods}")
assert(backend.fetch("return_codes") == {
  0x0000 => "success",
  0x3007 => "state_transition_failed",
  0x3009 => "motor_angle_limit",
  0x3010 => "motor_disabled",
  0x3011 => "motor_fault",
  0x3012 => "motor_data_loss",
  0x3013 => "speed_command_too_large"
}, "upstream return-code map changed")
assert(backend.fetch("control_modes") == {
  0 => "passive_or_damping",
  1 => "standing_or_greeting",
  10 => "lie_or_free_after_delay",
  18 => "moving",
  21 => "action",
  51 => "lie_down"
}, "upstream control-mode map changed")
assert(public_contract.dig("stop", "backend_command") == [0.0, 0.0, 0.0], "stop must compile to the zero move command")
assert(public_contract.dig("emergency_stop", "backend_method") == "passive", "emergency stop must compile to passive")

expected_modules = %w[Definition Syntax Constraints Defaults Parameters Behavior Return Example]
card_files = Dir[
  ROOT.join("L0.5/cards/Unclassify/En/*.md").to_s,
  ROOT.join("L0.5/cards/Unclassify/Ch/*.md").to_s,
  ROOT.join("L0.0/cards/Unclassify/En/*.md").to_s,
  ROOT.join("L0.0/cards/Unclassify/Ch/*.md").to_s
].reject { |path| path.end_with?("README.md") }.sort
assert(card_files.length == 26, "expected 26 bilingual card files, found #{card_files.length}")

card_files.each do |path|
  text = File.read(path, encoding: "UTF-8")
  starts = text.scan(/<!-- START: ([A-Za-z0-9_-]+) -->/).flatten
  ends = text.scan(/<!-- END: ([A-Za-z0-9_-]+) -->/).flatten
  assert(starts == expected_modules, "#{Pathname.new(path).relative_path_from(ROOT)} has incorrect module order")
  assert(ends == expected_modules, "#{Pathname.new(path).relative_path_from(ROOT)} has unmatched module markers")
end

manifests = {
  "L0.0" => JSON.parse(ROOT.join("L0.0/manifest.json").read),
  "L0.5" => JSON.parse(ROOT.join("L0.5/manifest.json").read)
}
manifests.each do |package, manifest|
  manifest.fetch("cards").each do |card|
    card.fetch("paths").each_value do |relative_path|
      path = ROOT.join(package, relative_path)
      assert(path.file?, "manifest path does not exist: #{path.relative_path_from(ROOT)}")
      heading = path.each_line.first
      assert(heading.include?(card.fetch("function")), "#{path.relative_path_from(ROOT)} heading does not match manifest function")
    end
  end
end

tbd_policy = profile.fetch("tbd_policy")
assert(tbd_policy.fetch("status") == "documented_not_callable", "TBD fields must remain documented but non-callable")
assert(tbd_policy.fetch("error_code") == "E_TBD_PARAMETER", "TBD error code changed")
assert(tbd_policy.fetch("command_emission") == "none", "TBD fields must not emit commands")
["unresolved_capabilities", "unresolved_limits"].each do |section|
  assert(tbd_policy.fetch(section).values.all? { |value| value == "TBD" }, "#{section} contains an invented value")
end
assert(profile.fetch("verification").values.all? { |value| value == "TBD" }, "unsourced verification fields must remain TBD")

tbd_card_paths = {
  "forward" => "01_forward.md",
  "backward" => "02_backward.md",
  "lateral" => "03_lateral.md",
  "turn" => "04_turn.md",
  "twist" => "05_twist.md",
  "backflip" => "06_backflip.md",
  "jump" => "07_jump.md",
  "stand" => "08_stand.md",
  "sit" => "09_sit.md",
  "stop" => "10_stop.md",
  "emergency_stop" => "11_emergency_stop.md",
  "look" => "12_look.md"
}
tbd_policy.fetch("parameters").each do |card_name, fields|
  paths = if card_name == "battery_fields"
            %w[
              L0.0/cards/Unclassify/En/get_battery_status.en.md
              L0.0/cards/Unclassify/Ch/get_battery_status.zh.md
            ]
          else
            filename = tbd_card_paths.fetch(card_name)
            [
              "L0.5/cards/Unclassify/En/#{filename}",
              "L0.5/cards/Unclassify/Ch/#{filename}"
            ]
          end

  paths.each do |relative_path|
    text = ROOT.join(relative_path).read
    assert(text.include?("TBD"), "#{relative_path} must explain its TBD entries")
    fields.each do |field|
      field.to_s.split(".").each do |term|
        assert(text.include?(term), "#{relative_path} is missing reserved TBD field #{field}")
      end
    end
  end
end

callable_tbd_patterns = {
  "01_forward.md" => %w[step_count= step_rate_hz= gait=],
  "02_backward.md" => %w[step_count= step_rate_hz= gait=],
  "03_lateral.md" => %w[step_count= step_rate_hz= gait=],
  "04_turn.md" => %w[angle_percent= turn_level= quarter_turns=],
  "05_twist.md" => %w[angle_deg= angle_percent= twist_level=],
  "06_backflip.md" => %w[variant=],
  "07_jump.md" => %w[variant= height_level=],
  "08_stand.md" => %w[height_level= posture=],
  "09_sit.md" => %w[mode=],
  "10_stop.md" => %w[mode= decel_level=]
}
callable_tbd_patterns.each do |filename, patterns|
  %w[En Ch].each do |language|
    text = ROOT.join("L0.5/cards/Unclassify", language, filename).read
    patterns.each do |pattern|
      assert(!text.include?(pattern), "#{filename} makes TBD field callable: #{pattern}")
    end
  end
end

root_manifest = JSON.parse(ROOT.join("manifest.json").read)
assert(root_manifest.fetch("version") == profile.fetch("sdk_version"), "root manifest and profile versions differ")
assert(!ROOT.join("L0.5/cards/Unclassify/En/09_lie_down.md").exist?, "compatibility sit card was unexpectedly renamed")
assert(!ROOT.join("L0.5/cards/Unclassify/En/12_pitch_body.md").exist?, "compatibility look card was unexpectedly renamed")

puts "SDK contract valid: #{card_files.length} cards, deterministic mappings, and preserved TBD fields."
