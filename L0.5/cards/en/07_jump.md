# `Agentech.jump(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Movement** — Execute one approved Aegis jump motion profile.

This is a high-risk preset motion interface. Developers choose from calibrated jump variants or height levels.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.jump()
Agentech.jump(height_level: int)
Agentech.jump(variant: str, stabilize_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `variant` and `height_level` are alternate selectors; passing both returns `rejected(E_PROFILE_MIXED)`.
2. SafetyGate must pass before execution; failure returns `rejected(E_SAFETY_GATE)`.
3. `height_level` selects a calibrated jump profile, not meters or centimeters.
4. `stabilize_s` is post-motion wait time, not recovery verification.
5. Unsupported devices or simulators return `rejected(E_UNSUPPORTED)`.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Default behavior |
| --- | --- |
| `Agentech.jump()` | Equivalent to `Agentech.jump(variant="standard", stabilize_s=5.0)` |
| `Agentech.jump(height_level=...)` | `stabilize_s` defaults to `5.0` |
| `Agentech.jump(variant=...)` | `stabilize_s` defaults to `5.0` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Default | Range / Rule | Description |
| --- | --- | --- | --- |
| `variant` | `"standard"` | approved variants | Selects a preset jump motion profile. |
| `height_level` | `None` | `1`, `2`, or `3` | Selects low, medium, or high calibrated jump profile. |
| `stabilize_s` | `5.0` | `0 <= stabilize_s <= 10.0` | Stable wait time after the motion. |

### Parameter Notes

`variant` is for named motion profiles such as `"standard"`.

`height_level=1` means low jump, `2` means medium jump, and `3` means the highest currently approved jump profile.

`stabilize_s` is a wait window. It does not check landing readiness for the next task.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK runs SafetyGate, triggers one jump motion profile, waits for `stabilize_s`, then returns the result.
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
result = Agentech.jump()
result = Agentech.jump(height_level=1)
result = Agentech.jump(variant="standard", stabilize_s=5.0)
```
<!-- END: Example -->
