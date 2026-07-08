# Agentech.emergency_stop

**L0.5 · Safety** — Trigger emergency stop and enter damping mode.

## Syntax

```matlab
Agentech.emergency_stop()
Agentech.emergency_stop(Reason="low clearance", Latch=true)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `Reason` | `"Agentech emergency stop"` | short string | operator-readable reason |
| `Latch` | `true` | `true | false` | whether the emergency state remains latched |
| `Mode` | `damping` | approved modes | safe mode after emergency stop |

**Behavior:** preempt any active call and enter emergency damping state.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** does not diagnose, recover, or resume execution.
