# `Agentech.twist(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · Movement** — 让 Aegis 机器狗在足端保持支撑的情况下，向左或向右扭转机身一小段角度。

作用范围限定为原地躯干动作：它调整机身姿态，不作为路线转向指令。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.twist(direction: str)
Agentech.twist(direction: str, angle_deg: float, yaw_rate_rad_s: float)
Agentech.twist(direction: str, angle_percent: int)
Agentech.twist(direction: str, twist_level: int)
Agentech.twist(direction: str, hold_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. `direction` 必填，只能是 `"left"` 或 `"right"`；它不是 profile selector。
2. 每次调用最多只能使用一个选择参数：`angle_deg`、`angle_percent` 或 `twist_level`。
3. `hold_s` 是辅助参数，可以和任意 twist profile 搭配。
4. 超出范围的参数返回 `rejected(E_RANGE)`；混合 profile 返回 `rejected(E_PROFILE_MIXED)`。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 默认反应 |
| --- | --- |
| `Agentech.twist(direction=...)` | 等价于 `Agentech.twist(direction=..., angle_deg=15, yaw_rate_rad_s=0.35, hold_s=0)` |
| `Agentech.twist(direction=..., angle_deg=...)` | `yaw_rate_rad_s` 默认 `0.35`，`hold_s` 默认 `0` |
| `Agentech.twist(direction=..., angle_percent=...)` | `hold_s` 默认 `0` |
| `Agentech.twist(direction=..., twist_level=...)` | `hold_s` 默认 `0` |
| `Agentech.twist(direction=..., hold_s=...)` | 使用默认 `angle_deg=15`，`yaw_rate_rad_s=0.35` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

### 参数模式

| 模式 | 选择参数 | 辅助参数 / 默认值 | 范围 / 规则 |
| --- | --- | --- | --- |
| direction | - | `direction` 必填 | `"left"` 或 `"right"` |
| angle-rate | `angle_deg` | `yaw_rate_rad_s=0.35`, `hold_s=0` | `0 < angle_deg <= 30`; `0.05 <= yaw_rate_rad_s <= 2.09` |
| percent-angle | `angle_percent` | `hold_s=0` | `1 <= angle_percent <= 100`，相对 `30 deg` |
| level | `twist_level` | `hold_s=0` | `twist_level` 为 `1`、`2`、`3`、`4` 或 `5` |
| hold | - | `hold_s=0` | `0 <= hold_s <= 3.0` |

### 参数解释

`angle_deg` 是机身扭转角度，不是机器人底盘转向角度。

`angle_percent` 以最大扭转角 `30 deg` 为 100%，例如 `angle_percent=50` 对应 `15 deg`。

| `twist_level` | 对应角度 |
| --- | --- |
| `1` | `6 deg` |
| `2` | `12 deg` |
| `3` | `18 deg` |
| `4` | `24 deg` |
| `5` | `30 deg` |

`hold_s` 是扭转到目标角度后的保持时间。它不是超时时间，也不是稳定性验证。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

SDK 会解析 `direction` 和 twist profile，让机器人执行原地躯干扭转，并在需要时保持 `hold_s`。
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
result = Agentech.twist(direction="left")
result = Agentech.twist(direction="right", angle_deg=28, yaw_rate_rad_s=0.35)
result = Agentech.twist(direction="left", angle_percent=50)
result = Agentech.twist(direction="right", twist_level=3)
result = Agentech.twist(direction="left", hold_s=0.5)
```
<!-- END: Example -->
