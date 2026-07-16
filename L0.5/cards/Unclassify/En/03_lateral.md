# `Agentech.lateral(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Movement** — Send a bounded body-frame `vy` command to the left or right, then send the zero-motion command.

This is an open-loop wrapper around ZSL-1 `move(vx, vy, yaw_rate)`.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.lateral(direction: str)
Agentech.lateral(direction: str, speed_mps: float, duration_s: float)
Agentech.lateral(direction: str, speed_percent: int, duration_s: float)
Agentech.lateral(direction: str, speed_level: int, duration_s: float)
Agentech.lateral(direction: str, distance_m: float, speed_mps: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `direction` is `"left"` or `"right"`; speed inputs are positive magnitudes.
2. Select exactly one speed representation: `speed_mps`, `speed_percent`, or `speed_level`. `distance_m` may be paired only with `speed_mps`.
3. Mixed speed representations return `rejected(E_PROFILE_MIXED)`; out-of-range values return `rejected(E_RANGE)`.
4. A distance call is accepted only when `distance_m / speed_mps <= 10.0 s`.
5. ZSL-1 `move` may be entered only from standing state.
6. The same profile resolver must be used by robot and simulator backends.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Deterministic resolution |
| --- | --- |
| `Agentech.lateral(direction=...)` | `speed_mps=0.2`, `duration_s=1.0` |
| Any speed selector without `duration_s` | `duration_s=1.0` |
| `Agentech.lateral(direction=..., distance_m=...)` | `speed_mps=0.2`; duration is `distance_m / 0.2` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter/profile | Range / values | Resolution |
| --- | --- | --- |
| `direction` | `"left"`, `"right"` | left = positive `vy`; right = negative `vy` |
| `speed_mps` | `0.1 <= speed_mps <= 0.5` | unchanged |
| `speed_percent` | integer `20..100` | `speed_percent / 100 * 0.5 m/s` |
| `speed_level` | integer `1..5` | `{1:0.1, 2:0.2, 3:0.3, 4:0.4, 5:0.5} m/s` |
| `distance_m` | `0 < distance_m <= 2.0` | duration = `distance_m / speed_mps` |
| `duration_s` | `0 < duration_s <= 10.0` | command duration |

The ZSL-1 backend accepts nonzero `|vy|` from `0.1` through `1.0 m/s`. Agentech publishes the narrower `0.1..0.5 m/s` wrapper range. Percentage and level are deterministic Agentech mappings, not upstream parameters or measured speeds.

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

Left resolves to `move(0, +speed_mps, 0)` and right to `move(0, -speed_mps, 0)`. At the resolved duration the SDK sends `move(0, 0, 0)`. A simulator must receive these same numeric commands and timing.
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
result = Agentech.lateral(direction="left", speed_level=3, duration_s=1.0)    # move(0, +0.3, 0)
result = Agentech.lateral(direction="right", speed_percent=40, duration_s=1) # move(0, -0.2, 0)
result = Agentech.lateral(direction="left", distance_m=0.4, speed_mps=0.2)   # 2.0 s
```
<!-- END: Example -->
