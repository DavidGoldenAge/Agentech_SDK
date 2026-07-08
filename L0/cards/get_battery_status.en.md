# Agentech.get_battery_status

**L0 · Telemetry** — Read one current battery-status snapshot; does not make safety decisions.

## Syntax

```matlab
battery = Agentech.get_battery_status()
battery = Agentech.get_battery_status(Fields=["battery_percent","voltage_v"])
battery = Agentech.get_battery_status(MaxAgeS=1.0)
battery = Agentech.get_battery_status(TimeoutS=0.5)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `Fields` | all available | known fields only | output field filter |
| `MaxAgeS` | `0` | `0..5.0` | maximum accepted cache age |
| `TimeoutS` | `0.5` | `0.1..2.0` | read timeout |

**Return:** `BatteryStatus(status, trace_id, timestamp_s, battery_percent, voltage_v, current_a, temperature_c, is_charging)`

**Constraints:** snapshot read only; no stream, runtime estimate, charging decision, or execution-safety decision.
