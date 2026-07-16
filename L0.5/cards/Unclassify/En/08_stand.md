# `Agentech.stand(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Posture** — Request the parameterless ZSL-1 `standUp()` transition and optionally wait on the Agentech host after acceptance.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.stand()
Agentech.stand(stabilize_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. ZSL-1 `standUp()` accepts no height or posture parameter.
2. The upstream documentation does not allow a direct transition from moving to standing; callers must stop motion first.
3. `stabilize_s` is a host wait and is never forwarded to `standUp()`.
4. Upstream state-transition rejection is returned without inventing recovery steps or retrying automatically.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

`Agentech.stand()` is equivalent to `Agentech.stand(stabilize_s=3.0)`. The `3.0 s` wrapper wait follows the upstream demo sequence; it is not a `standUp()` parameter or measured transition time.
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Default | Range | Meaning |
| --- | ---: | --- | --- |
| `stabilize_s` | `3.0` | `0 <= stabilize_s <= 10.0` | Host-side wait after an accepted stand request. |

The previously designed `height_level` and `posture` parameters remain `TBD`; ZSL-1 `standUp()` exposes neither input. Passing either currently returns `rejected(E_TBD_PARAMETER)` before `standUp()` is called.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The robot backend calls `standUp()` with no arguments and records the return code. If accepted, it waits `stabilize_s`. The simulator emits the same parameterless `standUp` event and applies the same host wait.
<!-- END: Behavior -->

<!-- START: Return -->
## Return

```python
SkillResult(status, trace_id, error_code, message)
```

Upstream return codes are translated through `profiles/aegis/zsl1.yaml`; the numeric code remains in the trace.
<!-- END: Return -->

<!-- START: Example -->
## Example

```python
result = Agentech.stand()
result = Agentech.stand(stabilize_s=3.0)
```
<!-- END: Example -->
