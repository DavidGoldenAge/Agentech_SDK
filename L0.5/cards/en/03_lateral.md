# `Agentech.lateral(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Movement** — Put the Aegis robot dog into standing posture, sidestep left or right in the robot body frame for a bounded duration, then stop.

The function scope is an open-loop lateral action. Direction is interpreted in the robot's current body frame.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.lateral(direction: str)
Agentech.lateral(direction: str, speed_mps: float, duration_s: float)
Agentech.lateral(direction: str, speed_percent: int, duration_s: float)
Agentech.lateral(direction: str, speed_level: int, duration_s: float)
Agentech.lateral(direction: str, step_count: int, step_rate_hz: float)
Agentech.lateral(direction: str, distance_m: float, speed_mps: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `direction` is required and must be `"left"` or `"right"`; it is not a profile selector.
2. Each call may use at most one selector: `speed_mps`, `speed_percent`, `speed_level`, `step_count`, or `distance_m`.
3. `distance_m + speed_mps` selects the distance-speed profile; other cross-profile combinations return `rejected(E_PROFILE_MIXED)`.
4. Out-of-range values return `rejected(E_RANGE)`.
5. Every sidestep attempts controlled stop; emergency stop state takes precedence.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Default behavior |
| --- | --- |
| `Agentech.lateral(direction=...)` | Equivalent to `Agentech.lateral(direction=..., speed_mps=0.2, duration_s=1.0)` |
| `Agentech.lateral(direction=..., speed_mps=...)` | `duration_s` defaults to `1.0` |
| `Agentech.lateral(direction=..., speed_percent=...)` | `duration_s` defaults to `1.0` |
| `Agentech.lateral(direction=..., speed_level=...)` | `duration_s` defaults to `1.0` |
| `Agentech.lateral(direction=..., step_count=...)` | `step_rate_hz` defaults to `1.5`; `gait` defaults to `"auto"` |
| `Agentech.lateral(direction=..., distance_m=...)` | `speed_mps` defaults to `0.2` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

### Parameter Profiles

| Profile | Selector | Auxiliary / Default | Range / Rule |
| --- | --- | --- | --- |
| direction | - | `direction` required | `"left"` or `"right"` |
| speed-time | `speed_mps` | `duration_s=1.0` | `0 < speed_mps <= 0.78`; `0 < duration_s <= 10.0` |
| percent-time | `speed_percent` | `duration_s=1.0` | `1 <= speed_percent <= 100`, relative to calibrated lateral full speed |
| level-time | `speed_level` | `duration_s=1.0` | `speed_level` is `1`, `2`, `3`, `4`, or `5` |
| steps | `step_count` | `gait="auto"`, `step_rate_hz=1.5` | `1 <= step_count <= 10`; `0.5 <= step_rate_hz <= 3.0` |
| distance-speed | `distance_m` | `speed_mps=0.2` | `0 < distance_m <= 2.0`; `0 < speed_mps <= 0.78` |

### Parameter Notes

`direction` uses the robot body frame.

Current calibrated lateral full speed is recorded as `0.5 m/s`. `speed_percent=100` maps to `0.5 m/s`, and `speed_percent=40` maps to `0.2 m/s`.

| `speed_level` | Speed |
| --- | --- |
| `1` | `0.1 m/s` |
| `2` | `0.2 m/s` |
| `3` | `0.3 m/s` |
| `4` | `0.4 m/s` |
| `5` | `0.5 m/s` |

`step_count` requests a number of sidesteps. It is not a lateral-distance guarantee.

`distance_m` is converted to duration by `distance_m / speed_mps`. This is an open-loop estimate, not lateral-position confirmation.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK resolves `direction` and the selected profile, puts the robot into a standing motion-ready state, executes left/right sidestep, then sends controlled stop.
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
result = Agentech.lateral(direction="left")
result = Agentech.lateral(direction="right", speed_mps=0.2, duration_s=1.0)
result = Agentech.lateral(direction="left", speed_percent=40, duration_s=1.0)
result = Agentech.lateral(direction="left", speed_level=3, duration_s=1.0)
result = Agentech.lateral(direction="left", step_count=2, step_rate_hz=1.5)
result = Agentech.lateral(direction="right", distance_m=0.3, speed_mps=0.2)
```
<!-- END: Example -->
