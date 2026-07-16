# `Agentech.get_battery_status(parameters)`

<!-- START: Definition -->
## Definition

**L0.0 · Telemetry** — Read one current Aegis battery-percentage snapshot from the upstream ZSL-1 high-level API.

This is an L0.0 data-read API. Its public device value is limited to `battery_percent`; `captured_at_s` is added by the Agentech host when the upstream response is received.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.get_battery_status()
Agentech.get_battery_status(max_age_s: float)
Agentech.get_battery_status(timeout_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. Each call reads one battery-status snapshot.
2. `battery_percent` must be the upstream `getBatteryPower()` value in the inclusive range `0–100`.
3. `max_age_s=0` requests current data and does not accept cached data.
4. If `timeout_s` expires before data is available, return `timeout(E_TIMEOUT)`.
5. The return value does not expose pack voltage, pack current, pack temperature, or charging state because ZSL-1 does not publish those battery-pack fields through the high-level API.
6. The return value is telemetry data and does not include task-safety decisions.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Default behavior |
| --- | --- |
| `Agentech.get_battery_status()` | Read current battery percentage; `max_age_s=0`, `timeout_s=0.5` |
| `Agentech.get_battery_status(max_age_s=...)` | `timeout_s` defaults to `0.5` |
| `Agentech.get_battery_status(timeout_s=...)` | `max_age_s` defaults to `0` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Default | Range / Rule | Description |
| --- | --- | --- | --- |
| `max_age_s` | `0` | `0 <= max_age_s <= 5.0` | Maximum acceptable cache age. |
| `timeout_s` | `0.5` | `0.1 <= timeout_s <= 2.0` | Maximum wait time for read completion. |

### Fields

| Field | Meaning |
| --- | --- |
| `battery_percent` | Current battery percentage. |
| `captured_at_s` | Agentech host receipt timestamp for the upstream response. |

### Parameter Notes

`max_age_s` controls cache acceptance. Default `0` requests a current read.

`timeout_s` controls how long the SDK waits for the telemetry response.

The upstream source is ZSL-1 `getBatteryPower()`. Per-motor voltage or temperature flags must not be presented as battery-pack telemetry.

### Reserved TBD fields

`voltage_v`, `current_a`, `temperature_c`, and `is_charging` remain in the SDK design as `TBD`. ZSL-1 `getBatteryPower()` does not provide them, so they are not returned and must not be synthesized by a simulator. A future `fields` request containing one of them must return `rejected(E_TBD_PARAMETER)` until an authoritative source is defined.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK reads `getBatteryPower()`, records the host receipt time, and returns a `BatteryStatus` result.
<!-- END: Behavior -->

<!-- START: Return -->
## Return

```python
BatteryStatus(
    status,
    trace_id,
    captured_at_s,
    battery_percent,
)
```

| Field | Meaning |
| --- | --- |
| `status` | Read state, such as `"succeeded"`, `"rejected"`, or `"timeout"` |
| `trace_id` | Read ID used to correlate SDK logs and device logs |
| `captured_at_s` | Agentech host receipt timestamp |
| `battery_percent` | Current battery percentage |
<!-- END: Return -->

<!-- START: Example -->
## Example

```python
battery = Agentech.get_battery_status()
battery = Agentech.get_battery_status(max_age_s=1.0)
battery = Agentech.get_battery_status(timeout_s=0.5)
```
<!-- END: Example -->
