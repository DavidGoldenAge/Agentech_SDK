# `Agentech.get_battery_status(parameters)`

<!-- START: Definition -->
## 定义

**L0.0 · Telemetry** — 通过上游 ZSL-1 高层接口读取一次 Aegis 当前电量百分比快照。

这是 L0.0 数据读取接口。公开的设备值只包含 `battery_percent`；`captured_at_s` 由 Agentech 主机在收到上游响应时记录。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.get_battery_status()
Agentech.get_battery_status(max_age_s: float)
Agentech.get_battery_status(timeout_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. 每次调用读取一次电池状态快照。
2. `battery_percent` 必须直接使用上游 `getBatteryPower()` 返回值，合法范围为 `0–100`（含边界）。
3. `max_age_s=0` 表示读取当前数据，不接受缓存。
4. `timeout_s` 到期仍未获得数据时返回 `timeout(E_TIMEOUT)`。
5. ZSL-1 高层接口没有公开电池包电压、电流、温度或充电状态，因此本卡不返回这些字段。
6. 返回值是遥测数据，不包含任务安全判断。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 默认反应 |
| --- | --- |
| `Agentech.get_battery_status()` | 读取当前电量百分比；`max_age_s=0`，`timeout_s=0.5` |
| `Agentech.get_battery_status(max_age_s=...)` | `timeout_s` 默认 `0.5` |
| `Agentech.get_battery_status(timeout_s=...)` | `max_age_s` 默认 `0` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 默认值 | 范围 / 规则 | 说明 |
| --- | --- | --- | --- |
| `max_age_s` | `0` | `0 <= max_age_s <= 5.0` | 可接受缓存数据的最大年龄。 |
| `timeout_s` | `0.5` | `0.1 <= timeout_s <= 2.0` | 等待读取完成的最长时间。 |

### 字段

| 字段 | 含义 |
| --- | --- |
| `battery_percent` | 当前电量百分比。 |
| `captured_at_s` | Agentech 主机收到上游响应的时间戳。 |

### 参数解释

`max_age_s` 控制缓存接受度。默认 `0` 会要求当前读取。

`timeout_s` 控制 SDK 等待底层遥测响应的时间窗口。

上游数据源是 ZSL-1 `getBatteryPower()`。电机状态中的电压或温度标志不能当作电池包遥测公开。

### 保留的 TBD 字段

`voltage_v`、`current_a`、`temperature_c`、`is_charging` 继续保留在 SDK 设计中并标记为 `TBD`。ZSL-1 `getBatteryPower()` 不提供这些值，因此当前不返回，模拟器也不得合成。未来若 `fields` 请求包含其中任一字段，在定义权威数据源之前必须返回 `rejected(E_TBD_PARAMETER)`。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

SDK 调用 `getBatteryPower()`，记录主机接收时间，并返回一个 `BatteryStatus` 结果。
<!-- END: Behavior -->

<!-- START: Return -->
## 返回

```python
BatteryStatus(
    status,
    trace_id,
    captured_at_s,
    battery_percent,
)
```

| 字段 | 含义 |
| --- | --- |
| `status` | 读取状态，例如 `"succeeded"`、`"rejected"` 或 `"timeout"` |
| `trace_id` | 用来关联 SDK 日志和设备日志的读取 ID |
| `captured_at_s` | Agentech 主机收到响应的时间戳 |
| `battery_percent` | 当前电量百分比 |
<!-- END: Return -->

<!-- START: Example -->
## 示例

```python
battery = Agentech.get_battery_status()
battery = Agentech.get_battery_status(max_age_s=1.0)
battery = Agentech.get_battery_status(timeout_s=0.5)
```
<!-- END: Example -->
