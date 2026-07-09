# `Agentech.stop(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Safety** — Preempt the current normal motion command and enter stopped state with a selected deceleration strategy.

This controlled stop command ends active motion-control output.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.stop()
Agentech.stop(mode: str)
Agentech.stop(decel_level: int)
Agentech.stop(timeout_s: float)
Agentech.stop(mode: str, decel_level: int)
Agentech.stop(mode: str, decel_level: int, timeout_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `stop` preempts the current normal motion command.
2. `mode` and `decel_level` may be used together; `mode` selects stop strategy and `decel_level` selects deceleration intensity.
3. If `timeout_s` expires before stop completion, return `timeout(E_TIMEOUT)`.
4. Emergency stop has higher priority.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Default behavior |
| --- | --- |
| `Agentech.stop()` | Equivalent to `Agentech.stop(mode="controlled", decel_level=3, timeout_s=2.0)` |
| `Agentech.stop(mode=...)` | `decel_level` defaults to `3`; `timeout_s` defaults to `2.0` |
| `Agentech.stop(decel_level=...)` | `mode` defaults to `"controlled"`; `timeout_s` defaults to `2.0` |
| `Agentech.stop(timeout_s=...)` | `mode` defaults to `"controlled"`; `decel_level` defaults to `3` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Default | Range / Rule | Description |
| --- | --- | --- | --- |
| `mode` | `"controlled"` | `"controlled"` or `"quick"` | Stop strategy. |
| `decel_level` | `3` | `1`, `2`, `3`, `4`, or `5` | Deceleration intensity; higher values stop faster. |
| `timeout_s` | `2.0` | `0.1 <= timeout_s <= 5.0` | Maximum wait time for stop completion. |

### Parameter Notes

`mode="controlled"` is the regular controlled-stop strategy. `mode="quick"` uses a faster convergence strategy.

`decel_level` is a product level, not a physical acceleration unit.

`timeout_s` controls how long the SDK waits for stop completion.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK preempts the current normal motion command, sends stop request, and waits until the robot reports stopped state or timeout.
<!-- END: Behavior -->

<!-- START: Return -->
## Return

```python
SkillResult(status, trace_id, error_code, message)
```

| Field | Meaning |
| --- | --- |
| `status` | Final call state: `"succeeded"`, `"rejected"`, `"preempted"`, `"estopped"`, or `"timeout"` |
| `trace_id` | Command ID used to correlate SDK logs and device logs |
| `error_code` | `None` on success; stable error code on failure |
| `message` | Developer-facing detail; do not branch program logic on this string |
<!-- END: Return -->

<!-- START: Example -->
## Example

```python
result = Agentech.stop()
result = Agentech.stop(mode="controlled")
result = Agentech.stop(decel_level=3)
result = Agentech.stop(timeout_s=2.0)
result = Agentech.stop(mode="controlled", decel_level=3)
result = Agentech.stop(mode="quick", decel_level=5, timeout_s=2.0)
```
<!-- END: Example -->
