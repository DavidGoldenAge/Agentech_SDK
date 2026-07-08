# Agentech.backflip

**L0.5 · Movement** — Execute one approved backflip motion.

## Syntax

```matlab
Agentech.backflip()
Agentech.backflip(Variant="standard")
Agentech.backflip(Variant="standard", StabilizeS=5.0)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `Variant` | `standard` | approved variants | approved motion variant |
| `StabilizeS` | `5.0` | `0..10.0` | stabilization wait after motion |

**Behavior:** execute one approved backflip motion.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** SafetyGate is an implicit precondition; failure returns `rejected(E_SAFETY_GATE)`; no style parameters.
