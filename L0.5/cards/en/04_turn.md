# `Agentech.turn(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Movement** — Rotate the Aegis robot dog left or right in place, then stop.

The function scope is an open-loop rotation action. The SDK issues a turn command from angle, duration, or level parameters.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.turn(direction: str)
Agentech.turn(direction: str, angle_deg: float, yaw_rate_rad_s: float)
Agentech.turn(direction: str, angle_percent: int)
Agentech.turn(direction: str, turn_level: int)
Agentech.turn(direction: str, quarter_turns: int)
Agentech.turn(direction: str, duration_s: float, yaw_rate_rad_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `direction` is required and must be `"left"` or `"right"`; it is not a profile selector.
2. Each call may use at most one selector: `angle_deg`, `angle_percent`, `turn_level`, `quarter_turns`, or `duration_s`.
3. `yaw_rate_rad_s` is auxiliary and may only be used with `angle_deg` or `duration_s`.
4. Out-of-range values return `rejected(E_RANGE)`; mixed profiles return `rejected(E_PROFILE_MIXED)`.
5. Every turn attempts controlled stop; emergency stop state takes precedence.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Default behavior |
| --- | --- |
| `Agentech.turn(direction=...)` | Equivalent to `Agentech.turn(direction=..., angle_deg=45, yaw_rate_rad_s=0.35)` |
| `Agentech.turn(direction=..., angle_deg=...)` | `yaw_rate_rad_s` defaults to `0.35` |
| `Agentech.turn(direction=..., duration_s=...)` | `yaw_rate_rad_s` defaults to `0.35` |
| `Agentech.turn(direction=..., angle_percent=...)` | Angle is computed as a percent of `360 deg` |
| `Agentech.turn(direction=..., quarter_turns=...)` | Each quarter turn is `90 deg` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

### Parameter Profiles

| Profile | Selector | Auxiliary / Default | Range / Rule |
| --- | --- | --- | --- |
| direction | - | `direction` required | `"left"` or `"right"` |
| angle-rate | `angle_deg` | `yaw_rate_rad_s=0.35` | `0 < angle_deg <= 360`; `0.05 <= yaw_rate_rad_s <= 2.09` |
| percent-angle | `angle_percent` | - | `1 <= angle_percent <= 100`, relative to `360 deg` |
| level | `turn_level` | - | `turn_level` is `1`, `2`, `3`, `4`, or `5` |
| quarter-turns | `quarter_turns` | - | `1 <= quarter_turns <= 4`; each is `90 deg` |
| time-rate | `duration_s` | `yaw_rate_rad_s=0.35` | `0 < duration_s <= 10.0`; `0.05 <= yaw_rate_rad_s <= 2.09` |

### Parameter Notes

`direction` is relative to the robot's current heading.

`angle_deg` is the commanded rotation angle. It is not final-heading verification.

`angle_percent` uses a full circle as `100%`; `angle_percent=25` maps to `90 deg`.

| `turn_level` | Angle |
| --- | --- |
| `1` | `15 deg` |
| `2` | `30 deg` |
| `3` | `45 deg` |
| `4` | `60 deg` |
| `5` | `90 deg` |

`yaw_rate_rad_s` is measured in rad/s. `duration_s + yaw_rate_rad_s` executes open-loop rotation, and the estimated angle must be converted to degrees: `estimated_angle_deg = duration_s * yaw_rate_rad_s * 180 / pi`. The default `0.35 rad/s` is about `20 deg/s`.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK resolves `direction` and the selected profile, executes in-place left/right turn, then sends controlled stop.
<!-- END: Behavior -->

<!-- START: Return -->
## Return

```python
SkillResult(status, trace_id, error_code, message)
```

| Field | Meaning |
| --- | --- |
| `status` | Final call state: `"succeeded"`, `"rejected"`, `"preempted"`, `"estopped"`, or `"timeout"` |
| `trace_id` | Command ID used to correlate SDK logs and device logs |
| `error_code` | `None` on success; stable error code on failure |
| `message` | Developer-facing detail; do not branch program logic on this string |
<!-- END: Return -->

<!-- START: Example -->
## Example

```python
result = Agentech.turn(direction="left")
result = Agentech.turn(direction="right", angle_deg=45, yaw_rate_rad_s=0.35)
result = Agentech.turn(direction="left", angle_percent=25)
result = Agentech.turn(direction="right", turn_level=3)
result = Agentech.turn(direction="left", quarter_turns=1)
result = Agentech.turn(direction="right", duration_s=1.0, yaw_rate_rad_s=0.35)
```
<!-- END: Example -->
