# Agentech.stand

**L0.5 · Posture** — Move into a stable standing posture and hold.

## Syntax

```matlab
Agentech.stand()
Agentech.stand(StabilizeS=5.0)
Agentech.stand(HeightLevel=2)
Agentech.stand(Posture="neutral", StabilizeS=5.0)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `StabilizeS` | `5.0` | `0..10.0` | stabilization wait after standing |
| `HeightLevel` | - | `1..3` | standing height level (1=low, 2=neutral, 3=tall); mutually exclusive with `Posture` |
| `Posture` | `neutral` | `low | neutral | tall` | standing posture preset |

**Behavior:** enter standing posture and stabilize.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** `HeightLevel` and `Posture` are mutually exclusive, passing both returns `rejected(E_PROFILE_MIXED)`; omitting both uses `Posture="neutral"`; no translation.
