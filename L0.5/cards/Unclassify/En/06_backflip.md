# `Agentech.backflip(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Discrete action** — Request the ZSL-1 `backflip()` action and optionally wait on the Agentech host after the request is accepted.

ZSL-1 exposes backflip as a parameterless discrete action, not as a tunable trajectory.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.backflip()
Agentech.backflip(stabilize_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. The upstream action accepts no height, speed, style, or trajectory parameters.
2. ZSL-1 permits entry only from standing state and forbids transition while moving.
3. The upstream documentation warns that frequent use accelerates motor and joint wear and may reduce performance or service life.
4. `stabilize_s` is an Agentech host wait and is never forwarded to `backflip()`.
5. Out-of-range values return `rejected(E_RANGE)`; upstream state-transition rejection is returned without automatic retry.
6. Success means the upstream request succeeded and the host wait elapsed; it does not prove maneuver completion from measured pose data.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

`Agentech.backflip()` is equivalent to `Agentech.backflip(stabilize_s=4.0)`. The `4.0 s` wrapper wait follows the upstream demo sequence; it is not a hardware parameter or measured maneuver duration.
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Default | Range | Meaning |
| --- | ---: | --- | --- |
| `stabilize_s` | `4.0` | `0 <= stabilize_s <= 10.0` | Host-side wait after an accepted action request. |

The previously designed `variant` parameter remains `TBD`; ZSL-1 exposes no backflip style selector. Passing it currently returns `rejected(E_TBD_PARAMETER)` before `backflip()` is called.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The robot backend calls `backflip()` with no arguments, records its return code, then waits `stabilize_s` if accepted. The simulator emits the same parameterless action event and applies the same host wait.
<!-- END: Behavior -->

<!-- START: Return -->
## Return

```python
SkillResult(status, trace_id, error_code, message)
```

Upstream return codes, including state-transition and motor faults, are translated through `profiles/aegis/zsl1.yaml`; the numeric code remains in the trace.
<!-- END: Return -->

<!-- START: Example -->
## Example

```python
result = Agentech.backflip()
result = Agentech.backflip(stabilize_s=4.0)
```
<!-- END: Example -->
