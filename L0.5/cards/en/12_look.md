# `Agentech.look(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Sensing/Posture** — Adjust body or camera pitch so the robot looks up or down.

This posture/sensing-orientation command changes the observation direction.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.look(direction: str)
Agentech.look(direction: str, angle_deg: float, pitch_rate_rad_s: float)
Agentech.look(target: str, direction: str, angle_deg: float)
Agentech.look(direction: str, angle_percent: int)
Agentech.look(direction: str, look_level: int)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `direction` is required and must be `"up"` or `"down"`.
2. `target` defaults to `"auto"` and may be `"body"` or `"camera"`.
3. Each call may use at most one selector: `angle_deg`, `angle_percent`, or `look_level`.
4. Unsupported `target` values for the device return `rejected(E_UNSUPPORTED)`.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Default behavior |
| --- | --- |
| `Agentech.look(direction=...)` | Equivalent to `Agentech.look(target="auto", direction=..., angle_deg=10, pitch_rate_rad_s=0.12)` |
| `Agentech.look(direction=..., angle_deg=...)` | `target` defaults to `"auto"`; `pitch_rate_rad_s` defaults to `0.12` |
| `Agentech.look(target=..., direction=...)` | `angle_deg` defaults to `10`; `pitch_rate_rad_s` defaults to `0.12` |
| `Agentech.look(direction=..., angle_percent=...)` | `target` defaults to `"auto"` |
| `Agentech.look(direction=..., look_level=...)` | `target` defaults to `"auto"` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

### Parameter Profiles

| Profile | Selector | Auxiliary / Default | Range / Rule |
| --- | --- | --- | --- |
| direction | - | `direction` required | `"up"` or `"down"` |
| target | - | `target="auto"` | `"auto"`, `"body"`, or `"camera"` |
| angle-rate | `angle_deg` | `pitch_rate_rad_s=0.12` | `0 < angle_deg <= 25`; `0.03 <= pitch_rate_rad_s <= 0.5` |
| percent-angle | `angle_percent` | - | `1 <= angle_percent <= 100`, relative to `25 deg` |
| level | `look_level` | - | `look_level` is `1`, `2`, `3`, `4`, or `5` |

### Parameter Notes

`target="auto"` lets the SDK select body or camera based on device capability.

`angle_deg` is the pitch adjustment angle. `angle_percent=100` maps to `25 deg`.

| `look_level` | Angle |
| --- | --- |
| `1` | `5 deg` |
| `2` | `10 deg` |
| `3` | `15 deg` |
| `4` | `20 deg` |
| `5` | `25 deg` |

`look` adjusts observation direction. Image capture belongs to capture APIs.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK selects the target actuator and adjusts the chosen `target` toward `direction` by the requested pitch angle.
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
result = Agentech.look(direction="up")
result = Agentech.look(direction="down", angle_deg=15, pitch_rate_rad_s=0.12)
result = Agentech.look(target="camera", direction="up", angle_deg=10)
result = Agentech.look(direction="down", angle_percent=60)
result = Agentech.look(direction="up", look_level=2)
```
<!-- END: Example -->
