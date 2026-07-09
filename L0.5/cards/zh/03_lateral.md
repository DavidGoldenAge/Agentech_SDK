# `Agentech.lateral(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · Movement** — 让 Aegis 机器狗进入站立状态，然后沿机身坐标系向左或向右侧移一段有限时间，最后主动停止。

作用范围限定为开环侧移动作：方向以机器人当前机身坐标系为准。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.lateral(direction: str)
Agentech.lateral(direction: str, speed_mps: float, duration_s: float)
Agentech.lateral(direction: str, speed_percent: int, duration_s: float)
Agentech.lateral(direction: str, speed_level: int, duration_s: float)
Agentech.lateral(direction: str, step_count: int, step_rate_hz: float)
Agentech.lateral(direction: str, distance_m: float, speed_mps: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. `direction` 必填，只能是 `"left"` 或 `"right"`；它不是 profile selector。
2. 每次调用最多只能使用一个选择参数：`speed_mps`、`speed_percent`、`speed_level`、`step_count` 或 `distance_m`。
3. `distance_m + speed_mps` 选择 distance-speed 模式；其他跨模式组合返回 `rejected(E_PROFILE_MIXED)`。
4. 超出范围的参数返回 `rejected(E_RANGE)`。
5. 每次侧移都必须尝试受控停止；如果 emergency stop 接管，以急停状态为准。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 默认反应 |
| --- | --- |
| `Agentech.lateral(direction=...)` | 等价于 `Agentech.lateral(direction=..., speed_mps=0.2, duration_s=1.0)` |
| `Agentech.lateral(direction=..., speed_mps=...)` | `duration_s` 默认 `1.0` |
| `Agentech.lateral(direction=..., speed_percent=...)` | `duration_s` 默认 `1.0` |
| `Agentech.lateral(direction=..., speed_level=...)` | `duration_s` 默认 `1.0` |
| `Agentech.lateral(direction=..., step_count=...)` | `step_rate_hz` 默认 `1.5`，`gait` 默认 `"auto"` |
| `Agentech.lateral(direction=..., distance_m=...)` | `speed_mps` 默认 `0.2` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

### 参数模式

| 模式 | 选择参数 | 辅助参数 / 默认值 | 范围 / 规则 |
| --- | --- | --- | --- |
| direction | - | `direction` 必填 | `"left"` 或 `"right"` |
| speed-time | `speed_mps` | `duration_s=1.0` | `0 < speed_mps <= 0.78`; `0 < duration_s <= 10.0` |
| percent-time | `speed_percent` | `duration_s=1.0` | `1 <= speed_percent <= 100`，相对当前 lateral 标定全速 |
| level-time | `speed_level` | `duration_s=1.0` | `speed_level` 为 `1`、`2`、`3`、`4` 或 `5` |
| steps | `step_count` | `gait="auto"`, `step_rate_hz=1.5` | `1 <= step_count <= 10`; `0.5 <= step_rate_hz <= 3.0` |
| distance-speed | `distance_m` | `speed_mps=0.2` | `0 < distance_m <= 2.0`; `0 < speed_mps <= 0.78` |

### 参数解释

`direction` 决定侧移方向，基准是机器人当前机身坐标系。

`speed_mps` 是绝对侧移速度，单位是 m/s。`speed_percent` 和 `speed_level` 使用 lateral 的产品标定速度。

当前 lateral 标定全速按 `0.5 m/s` 记录。`speed_percent=100` 对应 `0.5 m/s`，`speed_percent=40` 对应 `0.2 m/s`。

| `speed_level` | 对应速度 |
| --- | --- |
| `1` | `0.1 m/s` |
| `2` | `0.2 m/s` |
| `3` | `0.3 m/s` |
| `4` | `0.4 m/s` |
| `5` | `0.5 m/s` |

`step_count` 表示侧移步数，不代表横向距离。

`distance_m` 会按 `distance_m / speed_mps` 换算成侧移时长。它是开环估算，不是横向位置确认。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

SDK 会解析 `direction` 和参数模式，让机器人进入站立可运动状态，执行左/右侧移，然后发送受控停止。
<!-- END: Behavior -->

<!-- START: Return -->
## 返回

```python
SkillResult(status, trace_id, error_code, message)
```

| 字段 | 含义 |
| --- | --- |
| `status` | 本次调用的最终状态：`"succeeded"`、`"rejected"`、`"preempted"`、`"estopped"` 或 `"timeout"` |
| `trace_id` | 用来关联 SDK 日志和设备日志的命令 ID |
| `error_code` | 成功时为 `None`；失败时返回稳定错误码 |
| `message` | 给开发者看的错误或状态说明，不建议用于程序分支判断 |
<!-- END: Return -->

<!-- START: Example -->
## 示例

```python
result = Agentech.lateral(direction="left")
result = Agentech.lateral(direction="right", speed_mps=0.2, duration_s=1.0)
result = Agentech.lateral(direction="left", speed_percent=40, duration_s=1.0)
result = Agentech.lateral(direction="left", speed_level=3, duration_s=1.0)
result = Agentech.lateral(direction="left", step_count=2, step_rate_hz=1.5)
result = Agentech.lateral(direction="right", distance_m=0.3, speed_mps=0.2)
```
<!-- END: Example -->
