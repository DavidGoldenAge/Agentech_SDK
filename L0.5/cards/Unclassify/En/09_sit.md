# `Agentech.sit(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Posture** — Preserve the Agentech `sit` API name as a compatibility wrapper for the parameterless ZSL-1 `lieDown()` posture transition.

This is a normal posture command. It is intentionally separate from ZSL-1 `passive()`, which is used by `emergency_stop`.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.sit()
Agentech.sit(stabilize_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. The current supported form always calls `lieDown()` with no arguments.
2. ZSL-1 does not allow direct entry into `lieDown()` while moving; callers must stop first.
3. `stabilize_s` is a host wait and is never forwarded to `lieDown()`.
4. The implementation must not substitute `passive()` for `lieDown()`.
5. Upstream state-transition rejection is returned without automatic retry.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

`Agentech.sit()` is equivalent to `Agentech.sit(stabilize_s=3.0)`. The `3.0 s` wrapper wait follows the upstream demo sequence; it is not a `lieDown()` parameter or measured transition time.
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Default | Range | Meaning |
| --- | ---: | --- | --- |
| `stabilize_s` | `3.0` | `0 <= stabilize_s <= 10.0` | Host-side wait after an accepted `lieDown()` request. |

The previously designed `mode` parameter remains `TBD`; ZSL-1 `lieDown()` has no mode input. Passing `mode` currently returns `rejected(E_TBD_PARAMETER)` before any posture command is emitted.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The robot backend compiles `sit()` to a parameterless `lieDown()` call and records the return code. If accepted, it waits `stabilize_s`. The simulator emits the same `lieDown` event and applies the same host wait.
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
result = Agentech.sit()
result = Agentech.sit(stabilize_s=3.0)
```
<!-- END: Example -->
