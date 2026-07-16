# `Agentech.jump(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Discrete action** — Request the ZSL-1 vertical `jump()` action and optionally wait on the Agentech host after acceptance.

ZSL-1 exposes `jump()` as a parameterless action. `frontJump()` is a separate upstream action and is not a mode of this function.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.jump()
Agentech.jump(stabilize_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. The upstream action accepts no height, speed, direction, or trajectory parameters.
2. ZSL-1 permits entry only from standing state and forbids transition while moving.
3. `stabilize_s` is an Agentech host wait and is never forwarded to `jump()`.
4. Out-of-range values return `rejected(E_RANGE)`; upstream state-transition rejection is returned without automatic retry.
5. Success means the request succeeded and the host wait elapsed; it does not prove a measured jump height or landing pose.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

`Agentech.jump()` is equivalent to `Agentech.jump(stabilize_s=4.0)`. The `4.0 s` wrapper wait follows the upstream demo sequence; it is not a hardware parameter or measured jump duration.
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Default | Range | Meaning |
| --- | ---: | --- | --- |
| `stabilize_s` | `4.0` | `0 <= stabilize_s <= 10.0` | Host-side wait after an accepted action request. |

The previously designed `variant` and `height_level` parameters remain `TBD`; ZSL-1 `jump()` exposes neither input. Passing either currently returns `rejected(E_TBD_PARAMETER)` before `jump()` is called.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The robot backend calls `jump()` with no arguments, records its return code, then waits `stabilize_s` if accepted. The simulator emits the same parameterless vertical-jump event and applies the same host wait.
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
result = Agentech.jump()
result = Agentech.jump(stabilize_s=4.0)
```
<!-- END: Example -->
