# Agentech.stop

**L0.5 · Safety** — Stop the current motion command without entering emergency damping mode.

## Syntax

```matlab
Agentech.stop()
Agentech.stop(Mode="controlled")
Agentech.stop(DecelLevel=3)
Agentech.stop(TimeoutS=2.0)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `Mode` | `controlled` | `controlled | quick` | stop mode |
| `DecelLevel` | `3` | `1..5` | deceleration intensity |
| `TimeoutS` | `2.0` | `0.1..5.0` | stop timeout |

**Behavior:** preempt and stop the current motion command.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** timeout returns `timeout(E_TIMEOUT)`; does not auto-escalate to `emergency_stop`; escalation is the caller's decision.
