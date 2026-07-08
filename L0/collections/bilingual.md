# 13_get_battery_status

## English

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

## 中文

# Agentech.get_battery_status

**L0 · 遥测数据** — 读取一次当前电池状态快照；不做安全判断。

## 调用形式

```matlab
battery = Agentech.get_battery_status()
battery = Agentech.get_battery_status(Fields=["battery_percent","voltage_v"])
battery = Agentech.get_battery_status(MaxAgeS=1.0)
battery = Agentech.get_battery_status(TimeoutS=0.5)
```

## 参数

| 参数 | 默认值 | 范围 | 含义 |
|---|---|---|---|
| `Fields` | all available | known fields only | 输出字段筛选 |
| `MaxAgeS` | `0` | `0..5.0` | 可接受缓存数据的最大年龄 |
| `TimeoutS` | `0.5` | `0.1..2.0` | 读取超时时间 |

**返回类型：**`BatteryStatus(status, trace_id, timestamp_s, battery_percent, voltage_v, current_a, temperature_c, is_charging)`

**约束：**只读取一次快照；不 stream，不估算续航，不决定是否安全执行，不调度充电。
