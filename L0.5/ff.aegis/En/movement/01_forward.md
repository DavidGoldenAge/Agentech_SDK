# `Agentech.forward(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Movement** — Move forward using one positive speed-magnitude profile, then perform a controlled stop.

This is an open-loop movement. Acceleration, stabilization, and stopping can cause the actual travel distance or completion time to differ from a simple calculation.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.forward()
Agentech.forward(speed_mps: float, duration_s: float)
Agentech.forward(distance_m: float, speed_mps: float)
Agentech.forward(speed_percent: float, duration_s: float)
Agentech.forward(speed_level: int, duration_s: float)
Agentech.forward(pace: str, duration_s: float)
Agentech.forward(step_count: int, step_rate_hz: float)         # development
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `speed_mps` is a positive forward speed magnitude; values outside its inclusive range are rejected.
2. `duration_s` must be greater than `0` and no more than `10` seconds.
3. `distance_m` is open loop. The requested distance and any calculated completion time are estimates, not guarantees.
4. `speed_percent` is a relative request and does not promise an exact meters-per-second conversion.
5. `speed_level` selects one of 512 integer levels. The card does not promise a fixed meters-per-second value for each level.
6. `pace` resolves to a percentage of the maximum supported speed: `slow=20%`, `normal=40%`, and `fast=80%`.
7. `step_count` and `step_rate_hz` are still under development and physical validation.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Default |
| --- | --- |
| `Agentech.forward()` | `speed_mps=1.0`, `duration_s=1.0` |
| `Agentech.forward(speed_mps=...)` | `duration_s=1.0` when omitted |
| `Agentech.forward(step_count=...)` | `step_rate_hz=1.5` when omitted; development |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Type / range | Meaning |
| --- | --- | --- |
| `speed_mps` | float `[0.05, 3.00]` | Direct positive forward speed in meters per second |
| `duration_s` | float `(0, 10]` | Time to hold the movement command |
| `distance_m` | float `[0, 2]` | Requested open-loop travel distance |
| `speed_percent` | float `[0, 100]` | Relative speed request; decimal percentages are accepted |
| `speed_level` | int `[0, 511]` | 512 levels: `0` is the lowest moving-speed level and `511` is the highest |
| `pace` | enum `{slow, normal, fast}` | Maximum-speed ratio: `{slow:20%, normal:40%, fast:80%}` |
| `step_count` | int `[1, 20]` | Estimated steps, not exact measured foot contacts; development |
| `step_rate_hz` | float `[0.5, 3.0]` | Estimated cadence; development |
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK applies the selected positive forward-speed profile for the requested duration, or for the estimated time associated with a distance request, and then issues a controlled stop. A zero-distance request produces no forward travel.
<!-- END: Behavior -->

<!-- START: Return -->
## Return

```python
SkillResult(status, trace_id, error_code, message)
```

The result reports whether the request succeeded, was rejected, was interrupted, or timed out.
<!-- END: Return -->

<!-- START: Example -->
## Example

```python
Agentech.forward()
Agentech.forward(speed_mps=0.4, duration_s=1.0)
Agentech.forward(distance_m=1.0, speed_mps=0.4)
Agentech.forward(speed_percent=40, duration_s=1.0)
Agentech.forward(speed_level=100, duration_s=1.0)
Agentech.forward(pace="slow", duration_s=1.0)    # 20% of maximum
Agentech.forward(pace="normal", duration_s=1.0)  # 40% of maximum
Agentech.forward(pace="fast", duration_s=1.0)    # 80% of maximum
```
<!-- END: Example -->
