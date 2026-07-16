# `Agentech.backward(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Movement** — Move backward using one positive speed-magnitude profile; the SDK applies the backward direction internally and then performs a controlled stop.

This is an open-loop movement. Acceleration, stabilization, and stopping can cause the actual travel distance or completion time to differ from a simple calculation.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.backward()
Agentech.backward(speed_mps: float, duration_s: float)
Agentech.backward(distance_m: float, speed_mps: float)
Agentech.backward(speed_percent: float, duration_s: float)
Agentech.backward(speed_level: int, duration_s: float)
Agentech.backward(pace: str, duration_s: float)
Agentech.backward(step_count: int, step_rate_hz: float)        # development
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. Public speed inputs are positive magnitudes. Negative values are rejected; the SDK applies the backward body-X direction internally.
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
| `Agentech.backward()` | `speed_mps=1.0`, `duration_s=1.0` |
| `Agentech.backward(speed_mps=...)` | `duration_s=1.0` when omitted |
| `Agentech.backward(step_count=...)` | `step_rate_hz=1.5` when omitted; development |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Type / range | Meaning |
| --- | --- | --- |
| `speed_mps` | float `[0.05, 3.00]` | Positive backward speed magnitude; direction is applied internally |
| `duration_s` | float `(0, 10]` | Time to hold the movement command |
| `distance_m` | float `[0, 2]` | Requested open-loop travel distance |
| `speed_percent` | float `[0, 100]` | Relative speed request; decimal percentages are accepted |
| `speed_level` | int `[0, 511]` | 512 levels: `0` is the lowest moving-speed level and `511` is the highest |
| `pace` | enum `{slow, normal, fast}` | Maximum-speed ratio: `{slow:20%, normal:40%, fast:80%}` |
| `step_count` | int `[1, 10]` | Estimated steps, not physically counted; development |
| `step_rate_hz` | float `[0.5, 3.0]` | Estimated cadence; development |
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK applies the selected positive speed magnitude in the backward direction for the requested duration, or for the estimated time associated with a distance request, and then issues a controlled stop. A zero-distance request produces no backward travel.
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
Agentech.backward()
Agentech.backward(speed_mps=0.4, duration_s=1.0)
Agentech.backward(distance_m=1.0, speed_mps=0.4)
Agentech.backward(speed_percent=40, duration_s=1.0)
Agentech.backward(speed_level=100, duration_s=1.0)
Agentech.backward(pace="slow", duration_s=1.0)    # 20% of maximum
Agentech.backward(pace="normal", duration_s=1.0)  # 40% of maximum
Agentech.backward(pace="fast", duration_s=1.0)    # 80% of maximum
```
<!-- END: Example -->
