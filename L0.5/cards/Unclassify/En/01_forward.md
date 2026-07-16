# `Agentech.forward(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Movement** — Send a bounded positive body-frame `vx` command, then send the zero-motion command.

This is an open-loop wrapper around ZSL-1 `move(vx, vy, yaw_rate)`. It does not claim measured distance or odometry completion.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.forward()
Agentech.forward(speed_mps: float, duration_s: float)
Agentech.forward(speed_percent: int, duration_s: float)
Agentech.forward(speed_level: int, duration_s: float)
Agentech.forward(pace: str, duration_s: float)
Agentech.forward(distance_m: float, speed_mps: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. Select exactly one speed representation: `speed_mps`, `speed_percent`, `speed_level`, or `pace`. `distance_m` may be paired only with `speed_mps`.
2. Mixed speed representations return `rejected(E_PROFILE_MIXED)`.
3. Values outside the published range return `rejected(E_RANGE)`; the SDK does not clamp them.
4. A distance call is accepted only when `distance_m / speed_mps <= 10.0 s`.
5. ZSL-1 `move` may be entered only from standing state.
6. The same profile resolver must be used by robot and simulator backends.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Deterministic resolution |
| --- | --- |
| `Agentech.forward()` | `speed_mps=0.4`, `duration_s=1.0` |
| Any speed selector without `duration_s` | `duration_s=1.0` |
| `Agentech.forward(distance_m=...)` | `speed_mps=0.4`; duration is `distance_m / 0.4` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Profile | Range / values | Resolution to speed |
| --- | --- | --- |
| `speed_mps` | `0.05 <= speed_mps <= 1.0` | unchanged |
| `speed_percent` | integer `5..100` | `speed_percent / 100 * 1.0 m/s` |
| `speed_level` | integer `1..5` | `{1:0.2, 2:0.4, 3:0.6, 4:0.8, 5:1.0} m/s` |
| `pace` | `"slow"`, `"normal"`, `"fast"` | `{slow:0.2, normal:0.4, fast:0.8} m/s` |
| `distance_m` | `0 < distance_m <= 5.0` | duration = `distance_m / speed_mps` |
| `duration_s` | `0 < duration_s <= 10.0` | command duration |

The ZSL-1 backend accepts nonzero `|vx|` from `0.05` through `3.0 m/s`. Agentech publishes the narrower `0.05..1.0 m/s` wrapper range. `speed_percent`, `speed_level`, and `pace` are Agentech aliases with the exact mappings above; they are not upstream ZSL-1 parameters or measured speeds.

### Reserved TBD parameters

| Previously designed field | Status |
| --- | --- |
| `step_count` | `TBD` — no ZSL-1 step-count command or conversion source found |
| `step_rate_hz` | `TBD` — no ZSL-1 step-rate parameter found |
| `gait` | `TBD` — no ZSL-1 gait selector found |

These fields remain reserved for compatibility planning. Passing any of them currently returns `rejected(E_TBD_PARAMETER)` before a robot or simulator command is emitted.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

After the robot is motion-ready, the resolved command is `move(+speed_mps, 0, 0)`. At the resolved duration the SDK sends `move(0, 0, 0)`. A simulator must receive these same numeric commands and timing; it must not reinterpret a level or pace independently.
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
result = Agentech.forward(speed_level=3, duration_s=1.0)  # move(+0.6, 0, 0)
result = Agentech.forward(pace="fast", duration_s=1.0)   # move(+0.8, 0, 0)
result = Agentech.forward(distance_m=0.5, speed_mps=0.25) # 2.0 s
```
<!-- END: Example -->
