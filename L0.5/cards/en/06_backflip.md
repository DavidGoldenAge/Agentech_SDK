# `Agentech.backflip(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Movement** — Execute one approved Aegis backflip motion profile.

This is a high-risk preset motion interface. The SDK only accepts motion variants that have been safety-reviewed and device-calibrated.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.backflip()
Agentech.backflip(variant: str)
Agentech.backflip(variant: str, stabilize_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `variant` must be an approved motion variant; unknown variants return `rejected(E_UNSUPPORTED)`.
2. SafetyGate must pass before execution; failure returns `rejected(E_SAFETY_GATE)`.
3. `stabilize_s` is post-motion wait time, not recovery verification.
4. The command is not automatically retried.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Default behavior |
| --- | --- |
| `Agentech.backflip()` | Equivalent to `Agentech.backflip(variant="standard", stabilize_s=5.0)` |
| `Agentech.backflip(variant=...)` | `stabilize_s` defaults to `5.0` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Default | Range / Rule | Description |
| --- | --- | --- | --- |
| `variant` | `"standard"` | approved variants | Selects a preset backflip motion profile. |
| `stabilize_s` | `5.0` | `0 <= stabilize_s <= 10.0` | Stable wait time after the motion. |

### Parameter Notes

`variant` is a motion profile name, not free-form style text. Unknown variants must be rejected rather than silently falling back.

`stabilize_s` is a wait window. It does not check that the robot has recovered into a task-ready state.

SafetyGate should check emergency-stop state, battery, posture, ground/space conditions, device capability, and high-risk action permission.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK runs SafetyGate, triggers one backflip motion profile, waits for `stabilize_s`, then returns the result.
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
result = Agentech.backflip()
result = Agentech.backflip(variant="standard", stabilize_s=5.0)
```
<!-- END: Example -->
