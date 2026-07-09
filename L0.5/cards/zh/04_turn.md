# `Agentech.turn(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · Movement** — 让 Aegis 机器狗以原地转向的方式向左或向右改变朝向，完成后主动停止。

作用范围限定为开环旋转动作：SDK 根据角度、时间或档位发出转向指令。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.turn(direction: str)
Agentech.turn(direction: str, angle_deg: float, yaw_rate_rad_s: float)
Agentech.turn(direction: str, angle_percent: int)
Agentech.turn(direction: str, turn_level: int)
Agentech.turn(direction: str, quarter_turns: int)
Agentech.turn(direction: str, duration_s: float, yaw_rate_rad_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. `direction` 必填，只能是 `"left"` 或 `"right"`；它不是 profile selector。
2. 每次调用最多只能使用一个选择参数：`angle_deg`、`angle_percent`、`turn_level`、`quarter_turns` 或 `duration_s`。
3. `yaw_rate_rad_s` 是辅助参数，只能和 `angle_deg` 或 `duration_s` 搭配。
4. 超出范围的参数返回 `rejected(E_RANGE)`；混合 profile 返回 `rejected(E_PROFILE_MIXED)`。
5. 每次转向都必须尝试受控停止；如果 emergency stop 接管，以急停状态为准。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 默认反应 |
| --- | --- |
| `Agentech.turn(direction=...)` | 等价于 `Agentech.turn(direction=..., angle_deg=45, yaw_rate_rad_s=0.35)` |
| `Agentech.turn(direction=..., angle_deg=...)` | `yaw_rate_rad_s` 默认 `0.35` |
| `Agentech.turn(direction=..., duration_s=...)` | `yaw_rate_rad_s` 默认 `0.35` |
| `Agentech.turn(direction=..., angle_percent=...)` | 按 `360 deg` 百分比换算角度 |
| `Agentech.turn(direction=..., quarter_turns=...)` | 每个 quarter turn 等于 `90 deg` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

### 参数模式

| 模式 | 选择参数 | 辅助参数 / 默认值 | 范围 / 规则 |
| --- | --- | --- | --- |
| direction | - | `direction` 必填 | `"left"` 或 `"right"` |
| angle-rate | `angle_deg` | `yaw_rate_rad_s=0.35` | `0 < angle_deg <= 360`; `0.05 <= yaw_rate_rad_s <= 2.09` |
| percent-angle | `angle_percent` | - | `1 <= angle_percent <= 100`，相对 `360 deg` |
| level | `turn_level` | - | `turn_level` 为 `1`、`2`、`3`、`4` 或 `5` |
| quarter-turns | `quarter_turns` | - | `1 <= quarter_turns <= 4`，每档为 `90 deg` |
| time-rate | `duration_s` | `yaw_rate_rad_s=0.35` | `0 < duration_s <= 10.0`; `0.05 <= yaw_rate_rad_s <= 2.09` |

### 参数解释

`direction` 是相对机器人当前朝向的左转或右转。

`angle_deg` 表示期望转过的角度。它是运动指令参数，不是最终航向验证。

`angle_percent` 以一整圈 `360 deg` 为 100%，例如 `angle_percent=25` 对应 `90 deg`。

| `turn_level` | 对应角度 |
| --- | --- |
| `1` | `15 deg` |
| `2` | `30 deg` |
| `3` | `45 deg` |
| `4` | `60 deg` |
| `5` | `90 deg` |

`yaw_rate_rad_s` 的单位是 rad/s。`duration_s + yaw_rate_rad_s` 会按时间和角速度执行开环旋转，估算角度需要换算成度：`estimated_angle_deg = duration_s * yaw_rate_rad_s * 180 / pi`。默认 `0.35 rad/s` 约等于 `20 deg/s`。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

SDK 会解析 `direction` 和参数模式，让机器人执行原地左转或右转，然后发送受控停止。
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
result = Agentech.turn(direction="left")
result = Agentech.turn(direction="right", angle_deg=45, yaw_rate_rad_s=0.35)
result = Agentech.turn(direction="left", angle_percent=25)
result = Agentech.turn(direction="right", turn_level=3)
result = Agentech.turn(direction="left", quarter_turns=1)
result = Agentech.turn(direction="right", duration_s=1.0, yaw_rate_rad_s=0.35)
```
<!-- END: Example -->
