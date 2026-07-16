# `Agentech.emergency_stop(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Safety** — Preempt SDK actions, call the parameterless ZSL-1 `passive()` method, and optionally latch the Agentech runtime against subsequent motion calls.

The latch is a software interlock in Agentech, not a ZSL-1 or hardware-latched emergency-stop parameter.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.emergency_stop()
Agentech.emergency_stop(reason: str, latch: bool, timeout_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. The call has highest priority within the Agentech runtime and preempts active SDK actions.
2. `reason`, `latch`, and `timeout_s` are wrapper inputs; none is forwarded to `passive()`.
3. `latch=True` blocks later non-safety calls until the Agentech runtime is explicitly reset.
4. The API does not claim a physical emergency-stop circuit or hardware latch.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

`Agentech.emergency_stop()` resolves to `reason="Agentech emergency stop"`, `latch=True`, and `timeout_s=0.5`.
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Default | Range / values | Meaning |
| --- | --- | --- | --- |
| `reason` | `"Agentech emergency stop"` | non-empty short string | Host log metadata. |
| `latch` | `True` | boolean | Agentech runtime interlock. |
| `timeout_s` | `0.5` | `0.1 <= timeout_s <= 2.0` | Maximum wait to confirm passive control mode. |

The previously described post-emergency `mode` field remains `TBD`; `passive()` has no mode argument. Passing `mode` currently returns `rejected(E_TBD_PARAMETER)` before the passive request.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK preempts its active calls, invokes `passive()` with no arguments, and waits for ZSL-1 control mode `0` or timeout. If requested, it then keeps the Agentech runtime latch set. The simulator receives the same parameterless passive event and latch transition.
<!-- END: Behavior -->

<!-- START: Return -->
## Return

```python
SkillResult(status, trace_id, error_code, message)
```

Return `status="estopped"` after passive-mode confirmation. Rejection and timeout remain distinct; the numeric upstream return code is retained in the trace.
<!-- END: Return -->

<!-- START: Example -->
## Example

```python
result = Agentech.emergency_stop()
result = Agentech.emergency_stop(reason="operator request", latch=True, timeout_s=0.5)
```
<!-- END: Example -->
