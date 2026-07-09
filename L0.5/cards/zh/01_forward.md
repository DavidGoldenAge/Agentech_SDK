# `Agentech.forward(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · Movement** — 让 Aegis 机器狗进入站立状态，然后沿机身坐标系的前方运动一段有限时间，最后主动停止。

作用范围限定为开环前进动作：SDK 根据参数发出运动指令，并用受控停止结束本次动作。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.forward()
Agentech.forward(speed_mps: float, duration_s: float)
Agentech.forward(speed_percent: int, duration_s: float)
Agentech.forward(speed_level: int, duration_s: float)
Agentech.forward(pace: str, duration_s: float)
Agentech.forward(step_count: int, step_rate_hz: float)
Agentech.forward(distance_m: float, speed_mps: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. 每次调用最多只能使用一个选择参数：`speed_mps`、`speed_percent`、`speed_level`、`pace`、`step_count` 或 `distance_m`。
2. `distance_m + speed_mps` 选择 distance-speed 模式；其他跨模式组合返回 `rejected(E_PROFILE_MIXED)`。
3. 超出范围的参数返回 `rejected(E_RANGE)`，不会自动夹到合法范围。
4. 每次运动都必须尝试受控停止；如果 emergency stop 接管，以急停状态为准。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 默认反应 |
| --- | --- |
| `Agentech.forward()` | 等价于 `Agentech.forward(speed_mps=0.4, duration_s=1.0)` |
| `Agentech.forward(speed_mps=...)` | `duration_s` 默认 `1.0` |
| `Agentech.forward(speed_percent=...)` | `duration_s` 默认 `1.0` |
| `Agentech.forward(speed_level=...)` | `duration_s` 默认 `1.0` |
| `Agentech.forward(pace=...)` | `duration_s` 默认 `1.0` |
| `Agentech.forward(step_count=...)` | `step_rate_hz` 默认 `1.5`，`gait` 默认 `"auto"` |
| `Agentech.forward(distance_m=...)` | `speed_mps` 默认 `0.4` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

### 参数模式

| 模式 | 选择参数 | 辅助参数 / 默认值 | 范围 / 规则 |
| --- | --- | --- | --- |
| speed-time | `speed_mps` | `duration_s=1.0` | `0 < speed_mps <= 1.0`; `0 < duration_s <= 10.0` |
| percent-time | `speed_percent` | `duration_s=1.0` | `1 <= speed_percent <= 100`，相对当前 forward 标定全速 |
| level-time | `speed_level` | `duration_s=1.0` | `speed_level` 为 `1`、`2`、`3`、`4` 或 `5` |
| pace-time | `pace` | `duration_s=1.0` | `pace` 为 `"slow"`、`"normal"` 或 `"fast"` |
| steps | `step_count` | `gait="auto"`, `step_rate_hz=1.5` | `1 <= step_count <= 20`; `0.5 <= step_rate_hz <= 3.0` |
| distance-speed | `distance_m` | `speed_mps=0.4` | `0 < distance_m <= 5.0`; `0 < speed_mps <= 1.0` |

### 参数解释

`speed_mps` 是公开安全速度参数，单位是 m/s。`speed_percent`、`speed_level` 和 `pace` 是产品标定参数，对应真实测试出来的 forward 速度档位。

当前 forward 标定全速按 `1.0 m/s` 记录。`speed_percent=100` 对应 `1.0 m/s`，`speed_percent=40` 对应 `0.4 m/s`，`speed_percent=20` 对应 `0.2 m/s`。

| `speed_level` | 对应速度 |
| --- | --- |
| `1` | `0.2 m/s` |
| `2` | `0.4 m/s` |
| `3` | `0.6 m/s` |
| `4` | `0.8 m/s` |
| `5` | `1.0 m/s` |

| `pace` | 对应速度 |
| --- | --- |
| `"slow"` | `0.2 m/s` |
| `"normal"` | `0.4 m/s` |
| `"fast"` | `0.8 m/s` |

`step_count` 表示执行多少步，不代表走了多少米。实际位移会受步态、地面、打滑和姿态影响。

`distance_m` 会按 `distance_m / speed_mps` 换算成运动时长。它是开环估算，不是里程计确认。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

SDK 会解析参数模式，让机器人进入站立可运动状态，执行前进运动，然后发送受控停止。调用会阻塞到动作完成、被拒绝、被抢占、急停或超时。
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
result = Agentech.forward()
result = Agentech.forward(speed_mps=0.4, duration_s=1.0)
result = Agentech.forward(speed_percent=40, duration_s=1.0)
result = Agentech.forward(speed_level=3, duration_s=1.0)
result = Agentech.forward(pace="fast", duration_s=1.0)
result = Agentech.forward(step_count=4, step_rate_hz=1.5)
result = Agentech.forward(distance_m=0.5, speed_mps=0.4)
```
<!-- END: Example -->
