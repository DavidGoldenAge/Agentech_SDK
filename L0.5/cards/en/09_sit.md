# Agentech.sit

**L0.5 · Posture** — Enter floor-sit damping posture.

## Syntax

```matlab
Agentech.sit()
Agentech.sit(Mode="damping")
Agentech.sit(StabilizeS=2.0)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `Mode` | `damping` | approved modes | sit/damping mode |
| `StabilizeS` | `2.0` | `0..10.0` | stabilization wait after posture change |

**Behavior:** enter floor-sit damping posture.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** requires a safe posture state; otherwise returns `rejected(E_STATE)`.
