# Agentech.forward

**L0.5 · Movement** — Move forward in the robot body frame; no obstacle avoidance or arrival verification.

## Syntax

```matlab
Agentech.forward()
Agentech.forward(SpeedMps=0.3, DurationS=1.0)
Agentech.forward(SpeedPercent=30, DurationS=1.0)
Agentech.forward(SpeedLevel=3, DurationS=1.0)
Agentech.forward(Pace="normal", DurationS=1.0)
Agentech.forward(StepCount=4, StepRateHz=1.5)
Agentech.forward(DistanceM=0.5, SpeedMps=0.3)
```

## Parameter Profiles

| profile | selector | auxiliary/default | range |
|---|---|---|---|
| speed-time (canonical) | `SpeedMps` (omittable, default `0.3`) | `DurationS=1.0` | `0 < SpeedMps <= 2.37`; `0 < DurationS <= 10.0` |
| percent-time | `SpeedPercent` | `DurationS=1.0` | `1..100`, relative to forward `SafeMax` |
| level-time | `SpeedLevel` | `DurationS=1.0` | `1..5` |
| pace-time | `Pace` | `DurationS=1.0` | `slow | normal | fast` |
| steps | `StepCount` | `Gait=auto`, `StepRateHz=1.5` | `1..20`; `0.5..3.0 Hz` |
| distance-speed | `DistanceM` | `SpeedMps=0.3` | `0 < DistanceM <= 5.0` |

**Behavior:** execute the selected forward profile, then controlled stop.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** at most one selector per call; omitting all selectors executes canonical defaults; `DistanceM + SpeedMps` selects `distance-speed`; mixed profiles return `rejected(E_PROFILE_MIXED)`, out-of-range values return `rejected(E_RANGE)`.
