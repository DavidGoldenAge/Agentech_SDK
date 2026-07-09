# `Agentech.forward(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Movement** — Put the Aegis robot dog into standing posture, move forward in the robot body frame for a bounded duration, then stop.

The function scope is an open-loop forward action. The SDK issues the motion command from the provided parameters and ends the action with controlled stop.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.forward()
Agentech.forward(speed_mps: float, duration_s: float)
Agentech.forward(speed_percent: int, duration_s: float)
Agentech.forward(speed_level: int, duration_s: float)
Agentech.forward(pace: str, duration_s: float)
Agentech.forward(step_count: int, step_rate_hz: float)
Agentech.forward(distance_m: float, speed_mps: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. Each call may use at most one selector: `speed_mps`, `speed_percent`, `speed_level`, `pace`, `step_count`, or `distance_m`.
2. `distance_m + speed_mps` selects the distance-speed profile; other cross-profile combinations return `rejected(E_PROFILE_MIXED)`.
3. Out-of-range values return `rejected(E_RANGE)` and are not clamped.
4. Every motion attempts controlled stop; emergency stop state takes precedence.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Default behavior |
| --- | --- |
| `Agentech.forward()` | Equivalent to `Agentech.forward(speed_mps=0.4, duration_s=1.0)` |
| `Agentech.forward(speed_mps=...)` | `duration_s` defaults to `1.0` |
| `Agentech.forward(speed_percent=...)` | `duration_s` defaults to `1.0` |
| `Agentech.forward(speed_level=...)` | `duration_s` defaults to `1.0` |
| `Agentech.forward(pace=...)` | `duration_s` defaults to `1.0` |
| `Agentech.forward(step_count=...)` | `step_rate_hz` defaults to `1.5`; `gait` defaults to `"auto"` |
| `Agentech.forward(distance_m=...)` | `speed_mps` defaults to `0.4` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

### Parameter Profiles

| Profile | Selector | Auxiliary / Default | Range / Rule |
| --- | --- | --- | --- |
| speed-time | `speed_mps` | `duration_s=1.0` | `0 < speed_mps <= 1.0`; `0 < duration_s <= 10.0` |
| percent-time | `speed_percent` | `duration_s=1.0` | `1 <= speed_percent <= 100`, relative to calibrated forward full speed |
| level-time | `speed_level` | `duration_s=1.0` | `speed_level` is `1`, `2`, `3`, `4`, or `5` |
| pace-time | `pace` | `duration_s=1.0` | `pace` is `"slow"`, `"normal"`, or `"fast"` |
| steps | `step_count` | `gait="auto"`, `step_rate_hz=1.5` | `1 <= step_count <= 20`; `0.5 <= step_rate_hz <= 3.0` |
| distance-speed | `distance_m` | `speed_mps=0.4` | `0 < distance_m <= 5.0`; `0 < speed_mps <= 1.0` |

### Parameter Notes

`speed_mps` is the public safe-speed parameter in m/s. `speed_percent`, `speed_level`, and `pace` are product-calibrated speed expressions.

Current calibrated forward full speed is recorded as `1.0 m/s`. `speed_percent=100` maps to `1.0 m/s`, `speed_percent=40` maps to `0.4 m/s`, and `speed_percent=20` maps to `0.2 m/s`.

| `speed_level` | Speed |
| --- | --- |
| `1` | `0.2 m/s` |
| `2` | `0.4 m/s` |
| `3` | `0.6 m/s` |
| `4` | `0.8 m/s` |
| `5` | `1.0 m/s` |

| `pace` | Speed |
| --- | --- |
| `"slow"` | `0.2 m/s` |
| `"normal"` | `0.4 m/s` |
| `"fast"` | `0.8 m/s` |

`step_count` requests a number of steps. It is not a distance guarantee.

`distance_m` is converted to duration by `distance_m / speed_mps`. This is an open-loop estimate, not odometry confirmation.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK resolves the selected profile, puts the robot into a standing motion-ready state, executes forward motion, then sends controlled stop. The call blocks until completion, rejection, preemption, emergency stop, or timeout.
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
result = Agentech.forward()
result = Agentech.forward(speed_mps=0.4, duration_s=1.0)
result = Agentech.forward(speed_percent=40, duration_s=1.0)
result = Agentech.forward(speed_level=3, duration_s=1.0)
result = Agentech.forward(pace="fast", duration_s=1.0)
result = Agentech.forward(step_count=4, step_rate_hz=1.5)
result = Agentech.forward(distance_m=0.5, speed_mps=0.4)
```
<!-- END: Example -->
