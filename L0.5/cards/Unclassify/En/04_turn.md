# `Agentech.turn(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Movement** — Send a bounded locomotion yaw-rate command to turn left or right, then send the zero-motion command.

The angle form is open-loop time integration of ZSL-1 `move(0, 0, yaw_rate)`; it is not closed-loop heading control.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.turn(direction: str)
Agentech.turn(direction: str, angle_deg: float, yaw_rate_rad_s: float)
Agentech.turn(direction: str, duration_s: float, yaw_rate_rad_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `direction` is `"left"` or `"right"`; `yaw_rate_rad_s` is a positive magnitude.
2. Use `angle_deg` or `duration_s`, never both.
3. For an angle call, `duration_s = radians(angle_deg) / yaw_rate_rad_s` and must not exceed `10.0 s`.
4. Out-of-range values return `rejected(E_RANGE)`; the SDK does not clamp them.
5. ZSL-1 `move` may be entered only from standing state.
6. The same resolver and signed yaw-rate command must be used by robot and simulator backends.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Deterministic resolution |
| --- | --- |
| `Agentech.turn(direction=...)` | `angle_deg=45.0`, `yaw_rate_rad_s=1.0`; duration = `pi/4 s` |
| Angle or duration without yaw rate | `yaw_rate_rad_s=1.0` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Range / values | Meaning |
| --- | --- | --- |
| `direction` | `"left"`, `"right"` | left = positive yaw; right = negative yaw |
| `angle_deg` | `0 < angle_deg <= 360.0` | open-loop requested angle |
| `duration_s` | `0 < duration_s <= 10.0` | direct command duration |
| `yaw_rate_rad_s` | `0.02 <= yaw_rate_rad_s <= 1.0` | yaw-rate magnitude |

The ZSL-1 locomotion backend accepts nonzero `|yaw_rate|` from `0.02` through `3.0 rad/s`. Agentech publishes the narrower `0.02..1.0 rad/s` wrapper range. Angle is converted only by the formula above; no measured turn calibration is implied.

### Reserved TBD parameters

`angle_percent`, `turn_level`, and `quarter_turns` remain `TBD`: no authoritative mapping for these previously designed aliases was found. Passing one currently returns `rejected(E_TBD_PARAMETER)` before command emission.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

Left resolves to `move(0, 0, +yaw_rate_rad_s)` and right to `move(0, 0, -yaw_rate_rad_s)`. After the resolved duration the SDK sends `move(0, 0, 0)`. Simulation uses the identical signed command trace.
<!-- END: Behavior -->

<!-- START: Return -->
## Return

```python
SkillResult(status, trace_id, error_code, message)
```

`status` is `"succeeded"`, `"rejected"`, `"preempted"`, `"estopped"`, or `"timeout"`. Upstream return codes are translated through `profiles/aegis/zsl1.yaml`; the numeric upstream code remains in the command trace.
<!-- END: Return -->

<!-- START: Example -->
## Example

```python
result = Agentech.turn(direction="left")
result = Agentech.turn(direction="right", angle_deg=90, yaw_rate_rad_s=0.5) # pi s
result = Agentech.turn(direction="left", duration_s=2.0, yaw_rate_rad_s=0.3)
```
<!-- END: Example -->
