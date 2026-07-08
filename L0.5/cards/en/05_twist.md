# Agentech.twist

**L0.5 · Movement** — Twist the torso in place with feet planted.

## Syntax

```matlab
Agentech.twist(Direction="left")
Agentech.twist(Direction="right", AngleDeg=28, YawRateRadS=0.35)
Agentech.twist(Direction="left", AnglePercent=90)
Agentech.twist(Direction="right", TwistLevel=3)
Agentech.twist(Direction="left", HoldS=0.5)
```

## Parameter Profiles

| profile | selector | auxiliary/default | range |
|---|---|---|---|
| direction | - | `Direction` required | `left | right` |
| angle-rate (canonical) | `AngleDeg` (omittable, default `28`) | `YawRateRadS=0.35`, `HoldS=0` | `0 < AngleDeg <= 30`; `0.05..2.09 rad/s` |
| percent-angle | `AnglePercent` | `HoldS=0` | `1..100`, relative to 30 deg |
| level | `TwistLevel` | `HoldS=0` | `1..5` |
| hold | - | `HoldS` auxiliary | `0..3.0` |

**Behavior:** twist toward `Direction`; optionally hold after the twist.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** `HoldS` is auxiliary and may be combined with one twist profile; omitting everything except `Direction` executes canonical defaults; no translation.
