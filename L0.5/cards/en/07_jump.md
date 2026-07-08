# Agentech.jump

**L0.5 · Movement** — Execute one approved jump motion.

## Syntax

```matlab
Agentech.jump()
Agentech.jump(HeightLevel=1)
Agentech.jump(Variant="standard", StabilizeS=5.0)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `Variant` | `standard` | approved variants | approved motion variant |
| `HeightLevel` | - | `1..3` | calibrated jump height level; mutually exclusive with `Variant` |
| `StabilizeS` | `5.0` | `0..10.0` | stabilization wait after motion |

**Behavior:** execute one approved jump motion.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** SafetyGate is implicit; `Variant` and `HeightLevel` are mutually exclusive, passing both returns `rejected(E_PROFILE_MIXED)`; omitting both executes `Variant="standard"`.
