# `Agentech.backward(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Movement** — Send a bounded negative body-frame `vx` command, then send the zero-motion command.

This is an open-loop wrapper around ZSL-1 `move(vx, vy, yaw_rate)`. It does not claim measured distance or odometry completion.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.backward()
Agentech.backward(speed_mps: float, duration_s: float)
Agentech.backward(speed_percent: int, duration_s: float)
Agentech.backward(speed_level: int, duration_s: float)
Agentech.backward(pace: str, duration_s: float)
Agentech.backward(distance_m: float, speed_mps: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. Public speed inputs are positive magnitudes. The wrapper applies the negative `vx` sign.
2. Select exactly one speed representation: `speed_mps`, `speed_percent`, `speed_level`, or `pace`. `distance_m` may be paired only with `speed_mps`.
3. Mixed speed representations return `rejected(E_PROFILE_MIXED)`; out-of-range values return `rejected(E_RANGE)`.
4. A distance call is accepted only when `distance_m / speed_mps <= 10.0 s`.
5. ZSL-1 `move` may be entered only from standing state.
6. The same profile resolver must be used by robot and simulator backends.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Deterministic resolution |
| --- | --- |
| `Agentech.backward()` | `speed_mps=0.4`, `duration_s=1.0` |
| Any speed selector without `duration_s` | `duration_s=1.0` |
| `Agentech.backward(distance_m=...)` | `speed_mps=0.4`; duration is `distance_m / 0.4` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Profile | Range / values | Resolution to speed magnitude |
| --- | --- | --- |
| `speed_mps` | `0.05 <= speed_mps <= 1.0` | unchanged |
| `speed_percent` | integer `5..100` | `speed_percent / 100 * 1.0 m/s` |
| `speed_level` | integer `1..5` | `{1:0.2, 2:0.4, 3:0.6, 4:0.8, 5:1.0} m/s` |
| `pace` | `"slow"`, `"normal"`, `"fast"` | `{slow:0.2, normal:0.4, fast:0.8} m/s` |
| `distance_m` | `0 < distance_m <= 3.0` | duration = `distance_m / speed_mps` |
| `duration_s` | `0 < duration_s <= 10.0` | command duration |

The ZSL-1 backend accepts nonzero `|vx|` from `0.05` through `3.0 m/s`. Agentech publishes the narrower `0.05..1.0 m/s` wrapper range. Aliases are deterministic Agentech mappings, not upstream parameters or measured speeds.

### Reserved TBD parameters

| Previously designed field | Status |
| --- | --- |
| `step_count` | `TBD` — no ZSL-1 step-count command or conversion source found |
| `step_rate_hz` | `TBD` — no ZSL-1 step-rate parameter found |
| `gait` | `TBD` — no ZSL-1 gait selector found |

Passing a TBD field currently returns `rejected(E_TBD_PARAMETER)` before any command is emitted.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The resolved command is `move(-speed_mps, 0, 0)`. At the resolved duration the SDK sends `move(0, 0, 0)`. A simulator must receive these same numeric commands and timing.
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
result = Agentech.backward(speed_percent=40, duration_s=1.0) # move(-0.4, 0, 0)
result = Agentech.backward(pace="slow", duration_s=2.0)      # move(-0.2, 0, 0)
result = Agentech.backward(distance_m=0.5, speed_mps=0.25)   # 2.0 s
```
<!-- END: Example -->
