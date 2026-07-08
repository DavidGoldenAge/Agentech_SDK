# Agentech.backward

**L0.5 · Movement** — Move backward in the robot body frame; conservative by default, with no arrival verification.

## Syntax

```matlab
Agentech.backward()
Agentech.backward(SpeedMps=0.3, DurationS=1.0)
Agentech.backward(SpeedPercent=20, DurationS=1.0)
Agentech.backward(SpeedLevel=2, DurationS=1.0)
Agentech.backward(Pace="slow", DurationS=1.0)
Agentech.backward(StepCount=2)
Agentech.backward(DistanceM=0.3, SpeedMps=0.2)
```

## Parameter Profiles

| profile | selector | auxiliary/default | range |
|---|---|---|---|
| speed-time (canonical) | `SpeedMps` (omittable, default `0.3`) | `DurationS=1.0` | `0 < SpeedMps <= 2.365`; `0 < DurationS <= 10.0` |
| percent-time | `SpeedPercent` | `DurationS=1.0` | `1..100`, relative to backward `SafeMax` |
| level-time | `SpeedLevel` | `DurationS=1.0` | `1..5` |
| pace-time | `Pace` | `DurationS=1.0` | `slow | normal | fast` |
| steps | `StepCount` | `Gait=auto`, `StepRateHz=1.5` | `1..10`; `0.5..3.0 Hz` |
| distance-speed | `DistanceM` | `SpeedMps=0.2` | `0 < DistanceM <= 3.0` |

**Behavior:** execute the selected backward profile, then controlled stop.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** at most one selector per call; omitting all selectors executes canonical defaults; `DistanceM + SpeedMps` selects `distance-speed`; mixed profiles return `rejected(E_PROFILE_MIXED)`; out-of-range values return `rejected(E_RANGE)`.
