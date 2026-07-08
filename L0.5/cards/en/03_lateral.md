# Agentech.lateral

**L0.5 · Movement** — Sidestep left or right in the robot body frame; no lateral arrival verification.

## Syntax

```matlab
Agentech.lateral(Direction="left")
Agentech.lateral(Direction="right", SpeedMps=0.2, DurationS=1.0)
Agentech.lateral(Direction="left", SpeedPercent=30, DurationS=1.0)
Agentech.lateral(Direction="left", SpeedLevel=2, DurationS=1.0)
Agentech.lateral(Direction="left", StepCount=2)
Agentech.lateral(Direction="right", DistanceM=0.3, SpeedMps=0.2)
```

## Parameter Profiles

| profile | selector | auxiliary/default | range |
|---|---|---|---|
| direction | - | `Direction` required | `left | right` |
| speed-time (canonical) | `SpeedMps` (omittable, default `0.2`) | `DurationS=1.0` | `0 < SpeedMps <= 0.78`; `0 < DurationS <= 10.0` |
| percent-time | `SpeedPercent` | `DurationS=1.0` | `1..100`, relative to lateral `SafeMax` |
| level-time | `SpeedLevel` | `DurationS=1.0` | `1..5` |
| steps | `StepCount` | `Gait=auto`, `StepRateHz=1.5` | `1..10`; `0.5..3.0 Hz` |
| distance-speed | `DistanceM` | `SpeedMps=0.2` | `0 < DistanceM <= 2.0` |

**Behavior:** sidestep toward `Direction`, then controlled stop.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** `Direction` is required and is not a selector; at most one profile selector per call; omitting everything except `Direction` executes canonical defaults; `DistanceM + SpeedMps` selects `distance-speed`.
