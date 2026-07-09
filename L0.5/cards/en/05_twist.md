# `Agentech.twist(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Movement** — Twist the Aegis robot dog's torso left or right by a small angle while the feet stay planted.

The function scope is an in-place torso action. It adjusts body posture and is not a route-turning command.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.twist(direction: str)
Agentech.twist(direction: str, angle_deg: float, yaw_rate_rad_s: float)
Agentech.twist(direction: str, angle_percent: int)
Agentech.twist(direction: str, twist_level: int)
Agentech.twist(direction: str, hold_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `direction` is required and must be `"left"` or `"right"`; it is not a profile selector.
2. Each call may use at most one selector: `angle_deg`, `angle_percent`, or `twist_level`.
3. `hold_s` is auxiliary and may be combined with any twist profile.
4. Out-of-range values return `rejected(E_RANGE)`; mixed profiles return `rejected(E_PROFILE_MIXED)`.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Default behavior |
| --- | --- |
| `Agentech.twist(direction=...)` | Equivalent to `Agentech.twist(direction=..., angle_deg=15, yaw_rate_rad_s=0.35, hold_s=0)` |
| `Agentech.twist(direction=..., angle_deg=...)` | `yaw_rate_rad_s` defaults to `0.35`; `hold_s` defaults to `0` |
| `Agentech.twist(direction=..., angle_percent=...)` | `hold_s` defaults to `0` |
| `Agentech.twist(direction=..., twist_level=...)` | `hold_s` defaults to `0` |
| `Agentech.twist(direction=..., hold_s=...)` | Uses default `angle_deg=15`, `yaw_rate_rad_s=0.35` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

### Parameter Profiles

| Profile | Selector | Auxiliary / Default | Range / Rule |
| --- | --- | --- | --- |
| direction | - | `direction` required | `"left"` or `"right"` |
| angle-rate | `angle_deg` | `yaw_rate_rad_s=0.35`, `hold_s=0` | `0 < angle_deg <= 30`; `0.05 <= yaw_rate_rad_s <= 2.09` |
| percent-angle | `angle_percent` | `hold_s=0` | `1 <= angle_percent <= 100`, relative to `30 deg` |
| level | `twist_level` | `hold_s=0` | `twist_level` is `1`, `2`, `3`, `4`, or `5` |
| hold | - | `hold_s=0` | `0 <= hold_s <= 3.0` |

### Parameter Notes

`angle_deg` is torso twist angle, not base heading angle.

`angle_percent` uses `30 deg` as `100%`; `angle_percent=50` maps to `15 deg`.

| `twist_level` | Angle |
| --- | --- |
| `1` | `6 deg` |
| `2` | `12 deg` |
| `3` | `18 deg` |
| `4` | `24 deg` |
| `5` | `30 deg` |

`hold_s` is the hold time after reaching the requested twist. It is not a timeout or stability check.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK resolves `direction` and the selected twist profile, executes in-place torso twist, and holds for `hold_s` when requested.
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
result = Agentech.twist(direction="left")
result = Agentech.twist(direction="right", angle_deg=28, yaw_rate_rad_s=0.35)
result = Agentech.twist(direction="left", angle_percent=50)
result = Agentech.twist(direction="right", twist_level=3)
result = Agentech.twist(direction="left", hold_s=0.5)
```
<!-- END: Example -->
