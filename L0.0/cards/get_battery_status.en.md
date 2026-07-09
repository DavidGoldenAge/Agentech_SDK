# `Agentech.get_battery_status(parameters)`

<!-- START: Definition -->
## Definition

**L0.0 · Telemetry** — Read one current Aegis battery-status snapshot and return battery percentage, voltage, current, temperature, charging state, and timestamp fields.

This is an L0.0 data-read API. Its scope is one state snapshot.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.get_battery_status()
Agentech.get_battery_status(fields: list[str])
Agentech.get_battery_status(max_age_s: float)
Agentech.get_battery_status(timeout_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. Each call reads one battery-status snapshot.
2. `fields` may only include known fields; unknown fields return `rejected(E_FIELD_UNKNOWN)`.
3. `max_age_s=0` requests current data and does not accept cached data.
4. If `timeout_s` expires before data is available, return `timeout(E_TIMEOUT)`.
5. The return value is telemetry data and does not include task-safety decisions.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Default behavior |
| --- | --- |
| `Agentech.get_battery_status()` | Read current battery snapshot and return all public fields |
| `Agentech.get_battery_status(fields=...)` | `max_age_s` defaults to `0`; `timeout_s` defaults to `0.5` |
| `Agentech.get_battery_status(max_age_s=...)` | `fields` defaults to all available; `timeout_s` defaults to `0.5` |
| `Agentech.get_battery_status(timeout_s=...)` | `fields` defaults to all available; `max_age_s` defaults to `0` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

| Parameter | Default | Range / Rule | Description |
| --- | --- | --- | --- |
| `fields` | all available | known fields only | Output field filter. |
| `max_age_s` | `0` | `0 <= max_age_s <= 5.0` | Maximum acceptable cache age. |
| `timeout_s` | `0.5` | `0.1 <= timeout_s <= 2.0` | Maximum wait time for read completion. |

### Fields

| Field | Meaning |
| --- | --- |
| `battery_percent` | Current battery percentage. |
| `voltage_v` | Current battery voltage, in V. |
| `current_a` | Current battery current, in A. |
| `temperature_c` | Battery temperature, in Celsius. |
| `is_charging` | Whether the battery is currently charging. |
| `timestamp_s` | Snapshot timestamp. |

### Parameter Notes

`fields` reduces returned fields for UI or lightweight polling.

`max_age_s` controls cache acceptance. Default `0` requests a current read.

`timeout_s` controls how long the SDK waits for the telemetry response.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK reads one battery-status snapshot, filters public fields by `fields`, and returns a `BatteryStatus` result.
<!-- END: Behavior -->

<!-- START: Return -->
## Return

```python
BatteryStatus(
    status,
    trace_id,
    timestamp_s,
    battery_percent,
    voltage_v,
    current_a,
    temperature_c,
    is_charging,
)
```

| Field | Meaning |
| --- | --- |
| `status` | Read state, such as `"succeeded"`, `"rejected"`, or `"timeout"` |
| `trace_id` | Read ID used to correlate SDK logs and device logs |
| `timestamp_s` | Telemetry snapshot timestamp |
| `battery_percent` | Current battery percentage |
| `voltage_v` | Current voltage |
| `current_a` | Current current |
| `temperature_c` | Current temperature |
| `is_charging` | Whether the battery is charging |
<!-- END: Return -->

<!-- START: Example -->
## Example

```python
battery = Agentech.get_battery_status()

battery = Agentech.get_battery_status(
    fields=["battery_percent", "voltage_v"],
)

battery = Agentech.get_battery_status(max_age_s=1.0)

battery = Agentech.get_battery_status(timeout_s=0.5)
```
<!-- END: Example -->
