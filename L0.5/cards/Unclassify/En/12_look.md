# `Agentech.look(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Posture** — Preserve the Agentech `look` API name while applying a bounded body-pitch rate through ZSL-1 `attitudeControl`.

ZSL-1 documents body attitude rate control but no camera-pitch actuator or absolute look-angle command. Only the body-rate form is currently executable; the existing unsupported forms remain documented as `TBD`.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.look(direction: str)
Agentech.look(target: str, direction: str, pitch_rate_rad_s: float, duration_s: float)
Agentech.look(target: str, direction: str, pitch_rate_rad_s: float, duration_s: float, hold_s: float, return_to_neutral: bool)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `direction` is `"up"` or `"down"`; `pitch_rate_rad_s` is a positive magnitude.
2. The only executable target is `target="body"`. `"auto"` and `"camera"` remain `TBD`.
3. The executable form accepts rate and duration only; ZSL-1 does not document absolute body-pitch limits.
4. `return_to_neutral=True` means an equal-duration inverse-rate command, not closed-loop absolute-pose recovery.
5. ZSL-1 `attitudeControl` may be entered only from standing state.
6. Robot and simulator backends must execute the same `attitudeControl` command sequence.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

`Agentech.look(direction=...)` resolves to `target="body"`, `pitch_rate_rad_s=0.2`, `duration_s=0.5`, `hold_s=0.0`, and `return_to_neutral=True`.
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Default | Range / values |
| --- | ---: | --- |
| `target` | `"body"` | currently only `"body"` |
| `direction` | required | `"up"` or `"down"` |
| `pitch_rate_rad_s` | `0.2` | `0.02 <= pitch_rate_rad_s <= 0.2` |
| `duration_s` | `0.5` | `0 < duration_s <= 2.0` |
| `hold_s` | `0.0` | `0 <= hold_s <= 3.0` |
| `return_to_neutral` | `True` | boolean |

In the documented body frame (`X` forward, `Y` left, `Z` up), right-hand-rule positive pitch moves the nose down; therefore down is positive and up is negative. The upstream pitch-rate envelope is `-0.5..+0.5 rad/s`; Agentech publishes the narrower `0.02..0.2 rad/s` magnitude range.

### Reserved TBD parameters

`target="auto"`, `target="camera"`, `angle_deg`, `angle_percent`, and `look_level` remain `TBD`. Passing one currently returns `rejected(E_TBD_PARAMETER)` before command emission; no range or simulated behavior may be invented for them.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

For the body target, down sends `attitudeControl(0, +rate, 0, 0)` and up sends `attitudeControl(0, -rate, 0, 0)` for `duration_s`, followed by zeros. After `hold_s`, `return_to_neutral=True` sends the opposite signed rate for the same duration and then zeros. Simulation uses the identical sequence.
<!-- END: Behavior -->

<!-- START: Return -->
## Return

```python
SkillResult(status, trace_id, error_code, message)
```

`status` is `"succeeded"`, `"rejected"`, `"preempted"`, `"estopped"`, or `"timeout"`. Upstream return codes are translated through `profiles/aegis/zsl1.yaml`; the numeric code remains in the command trace.
<!-- END: Return -->

<!-- START: Example -->
## Example

```python
result = Agentech.look(direction="up")
result = Agentech.look(target="body", direction="down", pitch_rate_rad_s=0.1, duration_s=1.0)
result = Agentech.look(target="body", direction="up", pitch_rate_rad_s=0.15, duration_s=0.5, hold_s=1.0, return_to_neutral=True)
```
<!-- END: Example -->
