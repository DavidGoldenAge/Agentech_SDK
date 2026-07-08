# Agentech.look

**L0.5 · Sensing/Posture** — Tilt the body or camera up/down; does not capture images.

## Syntax

```matlab
Agentech.look(Direction="up")
Agentech.look(Direction="down", AngleDeg=15, PitchRateRadS=0.12)
Agentech.look(Target="camera", Direction="up", AngleDeg=10)
Agentech.look(Direction="down", AnglePercent=60)
Agentech.look(Direction="up", LookLevel=2)
```

## Parameter Profiles

| profile | selector | auxiliary/default | range |
|---|---|---|---|
| direction | - | `Direction` required | `up | down` |
| target | - | `Target=auto` | `auto | body | camera` |
| angle-rate (canonical) | `AngleDeg` (omittable, default `15`) | `PitchRateRadS=0.12` | `0 < AngleDeg <= 25`; `0.03..0.5 rad/s` |
| percent-angle | `AnglePercent` | - | `1..100`, relative to 25 deg |
| level | `LookLevel` | - | `1..5` |

**Behavior:** tilt the selected `Target` toward `Direction`.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** omitting everything except `Direction` and `Target` executes canonical defaults; unsupported `camera` target returns `rejected(E_UNSUPPORTED)`; no image capture.
