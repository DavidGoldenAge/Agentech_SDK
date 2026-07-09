# `Agentech.sit(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Posture** — Put the Aegis robot dog into floor-sit damping posture and optionally hold for a stabilization window.

This posture command transitions the robot from standing or motion-ready state into sit/damping state.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.sit()
Agentech.sit(mode: str)
Agentech.sit(stabilize_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `mode` must be an approved mode.
2. `stabilize_s` is post-transition wait time, not sit timeout.
3. If the current posture cannot safely transition to sit, return `rejected(E_NOT_READY)` or the relevant safety error.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Default behavior |
| --- | --- |
| `Agentech.sit()` | Equivalent to `Agentech.sit(mode="damping", stabilize_s=2.0)` |
| `Agentech.sit(mode=...)` | `stabilize_s` defaults to `2.0` |
| `Agentech.sit(stabilize_s=...)` | `mode` defaults to `"damping"` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Default | Range / Rule | Description |
| --- | --- | --- | --- |
| `mode` | `"damping"` | approved modes | Sit/damping mode. |
| `stabilize_s` | `2.0` | `0 <= stabilize_s <= 10.0` | Stable wait time after posture transition. |

### Parameter Notes

`mode="damping"` enters sit damping state to reduce subsequent motion output.

`stabilize_s` is a wait window. It does not replace posture state validation.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK requests sit/damping posture, waits for posture transition, then holds for `stabilize_s`.
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
result = Agentech.sit()
result = Agentech.sit(mode="damping")
result = Agentech.sit(stabilize_s=2.0)
```
<!-- END: Example -->
