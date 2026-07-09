# `Agentech.emergency_stop(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Safety** — Trigger emergency stop, preempt all active actions, and enter the post-emergency safe mode.

This is the highest-priority safety command for immediately entering the emergency-stop path.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.emergency_stop()
Agentech.emergency_stop(reason: str, latch: bool)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `emergency_stop` preempts any active call.
2. With `latch=True`, emergency-stop state remains until an external system explicitly resets it.
3. `reason` is for logs and operator UI, not program branching.
4. The result indicates whether the emergency-stop request entered the handling path.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Default behavior |
| --- | --- |
| `Agentech.emergency_stop()` | Equivalent to `Agentech.emergency_stop(reason="Agentech emergency stop", latch=True)` |
| `Agentech.emergency_stop(reason=...)` | `latch` defaults to `True` |
| `Agentech.emergency_stop(latch=...)` | `reason` defaults to `"Agentech emergency stop"` |
| All calls | Post-emergency safe mode defaults to `"damping"` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Default | Range / Rule | Description |
| --- | --- | --- | --- |
| `reason` | `"Agentech emergency stop"` | short string | Operator-readable reason written to logs. |
| `latch` | `True` | `True` or `False` | Whether emergency state remains latched. |
| `mode` | `"damping"` | approved modes | Post-emergency safe mode, currently fixed by SDK. |

### Parameter Notes

`reason` should be short, specific, and log-searchable.

`latch=True` is for emergency-stop scenarios that require human or supervisor confirmation before resume.

`mode="damping"` is the current default safe mode after emergency stop.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK immediately requests emergency stop, preempts current active actions, and enters the post-emergency safe mode.
<!-- END: Behavior -->

<!-- START: Return -->
## Return

```python
SkillResult(status, trace_id, error_code, message)
```

| Field | Meaning |
| --- | --- |
| `status` | Final call state: `"estopped"`, `"rejected"`, or `"timeout"` |
| `trace_id` | Command ID used to correlate SDK logs and device logs |
| `error_code` | `None` on success; stable error code on failure |
| `message` | Developer-facing detail; do not branch program logic on this string |

When the emergency-stop request enters the emergency handling path, return `status="estopped"` and `error_code=None`. `"rejected"` means the request was not accepted; `"timeout"` means the SDK did not confirm the emergency handling path within the `timeout_s` window.
<!-- END: Return -->

<!-- START: Example -->
## Example

```python
result = Agentech.emergency_stop()
result = Agentech.emergency_stop(reason="low clearance", latch=True)
```
<!-- END: Example -->
