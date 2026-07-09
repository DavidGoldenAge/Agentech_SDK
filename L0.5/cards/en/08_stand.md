# `Agentech.stand(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Posture** — Put the Aegis robot dog into a stable standing posture and optionally hold for a stabilization window.

This posture command moves the robot into a standing state suitable for subsequent motion.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.stand()
Agentech.stand(stabilize_s: float)
Agentech.stand(height_level: int)
Agentech.stand(height_level: int, stabilize_s: float)
Agentech.stand(posture: str)
Agentech.stand(posture: str, stabilize_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `height_level` and `posture` are alternate ways to express standing height/posture; passing both returns `rejected(E_PROFILE_MIXED)`.
2. If the robot is already in a compatible standing posture, the call should be treated as idempotent success.
3. `stabilize_s` is post-stand wait time, not stand timeout.
4. If current posture, battery, or emergency-stop state blocks standing, return `rejected(E_NOT_READY)` or the relevant safety error.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Default behavior |
| --- | --- |
| `Agentech.stand()` | Equivalent to `Agentech.stand(posture="neutral", stabilize_s=5.0)` |
| `Agentech.stand(stabilize_s=...)` | `posture` defaults to `"neutral"` |
| `Agentech.stand(height_level=...)` | `stabilize_s` defaults to `5.0` |
| `Agentech.stand(posture=...)` | `stabilize_s` defaults to `5.0` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Default | Range / Rule | Description |
| --- | --- | --- | --- |
| `stabilize_s` | `5.0` | `0 <= stabilize_s <= 10.0` | Stable wait time after standing. |
| `height_level` | `None` | `1`, `2`, or `3` | Selects standing height by level. |
| `posture` | `"neutral"` | `"low"`, `"neutral"`, or `"tall"` | Selects standing posture by readable name. |

### Parameter Notes

`height_level=1` maps to low stand, `height_level=2` maps to neutral stand, and `height_level=3` maps to tall stand.

`posture` is the readable alias for `height_level`: `"low"` maps to `1`, `"neutral"` maps to `2`, and `"tall"` maps to `3`.

`stabilize_s` is the wait window after standing. It does not replace status snapshot validation.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK requests the selected standing posture, waits until the stand state is stable, then holds for `stabilize_s`.
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
result = Agentech.stand()
result = Agentech.stand(stabilize_s=5.0)
result = Agentech.stand(height_level=2)
result = Agentech.stand(height_level=2, stabilize_s=5.0)
result = Agentech.stand(posture="neutral")
result = Agentech.stand(posture="neutral", stabilize_s=5.0)
```
<!-- END: Example -->
