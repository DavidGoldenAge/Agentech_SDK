# `Agentech.stop(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Safety** — Preempt normal motion output, send the ZSL-1 zero-motion command `move(0, 0, 0)`, and wait for bounded telemetry confirmation.

ZSL-1 does not expose selectable deceleration strategies in this high-level command.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.stop()
Agentech.stop(timeout_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `stop` preempts the active normal motion command but does not call `passive()`.
2. The backend command is always exactly `move(0.0, 0.0, 0.0)`.
3. `timeout_s` changes only the confirmation wait; it does not change deceleration.
4. Emergency-stop state has higher priority.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

`Agentech.stop()` is equivalent to `Agentech.stop(timeout_s=2.0)`.
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Default | Range | Meaning |
| --- | ---: | --- | --- |
| `timeout_s` | `2.0` | `0.1 <= timeout_s <= 5.0` | Maximum wait for telemetry to enter the software stop thresholds. |

The Agentech confirmation thresholds are body linear speed `<= 0.05 m/s` and body yaw rate `<= 0.02 rad/s`. They are software acceptance thresholds in `profiles/aegis/zsl1.yaml`, not measured hardware limits.

The previously designed `mode` and `decel_level` parameters remain `TBD`; the ZSL-1 high-level motion API exposes neither. Passing either currently returns `rejected(E_TBD_PARAMETER)` before the zero command is emitted.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK sends `move(0, 0, 0)` and checks ZSL-1 body velocity and body gyro telemetry until the profile thresholds are met or the timeout expires. The simulator receives the same zero command and uses the same thresholds.
<!-- END: Behavior -->

<!-- START: Return -->
## Return

```python
SkillResult(status, trace_id, error_code, message)
```

Return `"succeeded"` after confirmation, `"timeout"` on expiry, or the translated upstream rejection. The numeric upstream code remains in the trace.
<!-- END: Return -->

<!-- START: Example -->
## Example

```python
result = Agentech.stop()
result = Agentech.stop(timeout_s=3.0)
```
<!-- END: Example -->
