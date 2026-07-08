# Agentech.turn

**L0.5 · Movement** — Rotate heading left or right; no final-heading verification.

## Syntax

```matlab
Agentech.turn(Direction="left")
Agentech.turn(Direction="right", AngleDeg=45, YawRateRadS=0.35)
Agentech.turn(Direction="left", AnglePercent=25)
Agentech.turn(Direction="right", TurnLevel=2)
Agentech.turn(Direction="left", QuarterTurns=1)
Agentech.turn(Direction="right", DurationS=1.0, YawRateRadS=0.35)
```

## Parameter Profiles

| profile | selector | auxiliary/default | range |
|---|---|---|---|
| direction | - | `Direction` required | `left | right` |
| angle-rate (canonical) | `AngleDeg` (omittable, default `45`) | `YawRateRadS=0.35` | `0 < AngleDeg <= 360`; `0.05..2.09 rad/s` |
| percent-angle | `AnglePercent` | - | `1..100`, relative to 360 deg |
| level | `TurnLevel` | - | `1..5` |
| quarter-turns | `QuarterTurns` | - | `1..4` |
| time-rate | `DurationS` | `YawRateRadS=0.35` | `0 < DurationS <= 10.0` |

**Behavior:** rotate toward `Direction`, then stop.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** `Direction` is required; at most one selector per call; omitting everything except `Direction` executes canonical defaults.
