# `Agentech.twist(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Posture** — Apply a bounded body-yaw posture rate through ZSL-1 `attitudeControl`, optionally hold, and optionally apply the inverse rate for the same duration.

This changes body posture; it is not the locomotion turn command and does not promise an absolute yaw angle.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.twist(direction: str)
Agentech.twist(direction: str, yaw_rate_rad_s: float, duration_s: float)
Agentech.twist(direction: str, yaw_rate_rad_s: float, duration_s: float, hold_s: float, return_to_neutral: bool)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `direction` is `"left"` or `"right"`; `yaw_rate_rad_s` is a positive magnitude.
2. This API accepts rate and duration only; absolute body-yaw limits are not documented by ZSL-1.
3. Out-of-range values return `rejected(E_RANGE)`; the SDK does not clamp them.
4. `return_to_neutral=True` means an equal-duration inverse-rate command, not closed-loop absolute-pose recovery.
5. ZSL-1 `attitudeControl` may be entered only from standing state.
6. Robot and simulator backends must execute the same `attitudeControl` command sequence.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

`Agentech.twist(direction=...)` resolves to `yaw_rate_rad_s=0.2`, `duration_s=0.5`, `hold_s=0.0`, and `return_to_neutral=True`.
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Default | Range / values |
| --- | ---: | --- |
| `direction` | required | `"left"` or `"right"` |
| `yaw_rate_rad_s` | `0.2` | `0.02 <= yaw_rate_rad_s <= 0.2` |
| `duration_s` | `0.5` | `0 < duration_s <= 2.0` |
| `hold_s` | `0.0` | `0 <= hold_s <= 3.0` |
| `return_to_neutral` | `True` | boolean |

The upstream attitude yaw-rate envelope is `-0.5..+0.5 rad/s`. Agentech publishes a narrower magnitude range of `0.02..0.2 rad/s`; these are software contract values, not measured posture angles.

### Reserved TBD parameters

`angle_deg`, `angle_percent`, and `twist_level` remain `TBD` because ZSL-1 does not publish the absolute body-yaw limit or a mapping for those previously designed inputs. Passing one currently returns `rejected(E_TBD_PARAMETER)` before command emission.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

Left sends `attitudeControl(0, 0, +rate, 0)` and right sends `attitudeControl(0, 0, -rate, 0)` for `duration_s`, followed by zeros. After `hold_s`, `return_to_neutral=True` sends the opposite signed rate for the same duration and then zeros. Simulation uses the identical sequence.
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
result = Agentech.twist(direction="left")
result = Agentech.twist(direction="right", yaw_rate_rad_s=0.1, duration_s=1.0)
result = Agentech.twist(direction="left", yaw_rate_rad_s=0.15, duration_s=0.5, hold_s=1.0, return_to_neutral=True)
```
<!-- END: Example -->
