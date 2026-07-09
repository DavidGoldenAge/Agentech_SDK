# `Agentech.get_battery_status(parameters)`

<!-- START: Definition -->
## 定义

**L0.0 · Telemetry** — 读取一次 Aegis 当前电池状态快照，并返回电量、电压、电流、温度和充电状态等字段。

这是 L0.0 数据读取接口，作用范围限定为一次状态读取。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.get_battery_status()
Agentech.get_battery_status(fields: list[str])
Agentech.get_battery_status(max_age_s: float)
Agentech.get_battery_status(timeout_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. 每次调用读取一次电池状态快照。
2. `fields` 只能包含已知字段；未知字段返回 `rejected(E_FIELD_UNKNOWN)`。
3. `max_age_s=0` 表示读取当前数据，不接受缓存。
4. `timeout_s` 到期仍未获得数据时返回 `timeout(E_TIMEOUT)`。
5. 返回值是遥测数据，不包含任务安全判断。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 默认反应 |
| --- | --- |
| `Agentech.get_battery_status()` | 读取当前电池快照，返回所有公开字段 |
| `Agentech.get_battery_status(fields=...)` | `max_age_s` 默认 `0`，`timeout_s` 默认 `0.5` |
| `Agentech.get_battery_status(max_age_s=...)` | `fields` 默认 all available，`timeout_s` 默认 `0.5` |
| `Agentech.get_battery_status(timeout_s=...)` | `fields` 默认 all available，`max_age_s` 默认 `0` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 默认值 | 范围 / 规则 | 说明 |
| --- | --- | --- | --- |
| `fields` | all available | known fields only | 输出字段筛选。 |
| `max_age_s` | `0` | `0 <= max_age_s <= 5.0` | 可接受缓存数据的最大年龄。 |
| `timeout_s` | `0.5` | `0.1 <= timeout_s <= 2.0` | 等待读取完成的最长时间。 |

### 字段

| 字段 | 含义 |
| --- | --- |
| `battery_percent` | 当前电量百分比。 |
| `voltage_v` | 当前电池电压，单位 V。 |
| `current_a` | 当前电流，单位 A。 |
| `temperature_c` | 电池温度，单位摄氏度。 |
| `is_charging` | 当前是否处于充电状态。 |
| `timestamp_s` | 快照时间戳。 |

### 参数解释

`fields` 用于减少返回字段，适合 UI 或轻量轮询。

`max_age_s` 控制缓存接受度。默认 `0` 会要求当前读取。

`timeout_s` 控制 SDK 等待底层遥测响应的时间窗口。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

SDK 会读取一次电池状态快照，按 `fields` 过滤公开字段，并返回一个 `BatteryStatus` 结果。
<!-- END: Behavior -->

<!-- START: Return -->
## 返回

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

| 字段 | 含义 |
| --- | --- |
| `status` | 读取状态，例如 `"succeeded"`、`"rejected"` 或 `"timeout"` |
| `trace_id` | 用来关联 SDK 日志和设备日志的读取 ID |
| `timestamp_s` | 遥测快照时间戳 |
| `battery_percent` | 当前电量百分比 |
| `voltage_v` | 当前电压 |
| `current_a` | 当前电流 |
| `temperature_c` | 当前温度 |
| `is_charging` | 是否正在充电 |
<!-- END: Return -->

<!-- START: Example -->
## 示例

```python
battery = Agentech.get_battery_status()

battery = Agentech.get_battery_status(
    fields=["battery_percent", "voltage_v"],
)

battery = Agentech.get_battery_status(max_age_s=1.0)

battery = Agentech.get_battery_status(timeout_s=0.5)
```
<!-- END: Example -->
