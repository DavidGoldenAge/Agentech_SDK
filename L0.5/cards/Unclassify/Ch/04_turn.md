# `Agentech.turn(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · 移动** — 发送有时限的移动偏航角速度指令，使机器人向左或向右转，结束时发送零运动指令。

角度调用是对 ZSL-1 `move(0, 0, yaw_rate)` 做开环时间积分，并非闭环航向控制。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.turn(direction: str)
Agentech.turn(direction: str, angle_deg: float, yaw_rate_rad_s: float)
Agentech.turn(direction: str, duration_s: float, yaw_rate_rad_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. `direction` 为 `"left"` 或 `"right"`；`yaw_rate_rad_s` 是正的角速度大小。
2. `angle_deg` 和 `duration_s` 二选一，不能同时提供。
3. 角度调用按 `duration_s = radians(angle_deg) / yaw_rate_rad_s` 计算，结果不能超过 `10.0 s`。
4. 越界值返回 `rejected(E_RANGE)`，SDK 不做截断。
5. ZSL-1 `move` 只能从站立状态切入。
6. 真机和模拟器后端必须使用同一个解析器和带符号的偏航角速度指令。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 确定性解析结果 |
| --- | --- |
| `Agentech.turn(direction=...)` | `angle_deg=45.0`，`yaw_rate_rad_s=1.0`；时长为 `pi/4 s` |
| 角度或时长调用未给角速度 | `yaw_rate_rad_s=1.0` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 范围 / 可选值 | 含义 |
| --- | --- | --- |
| `direction` | `"left"`、`"right"` | 左转为正偏航；右转为负偏航 |
| `angle_deg` | `0 < angle_deg <= 360.0` | 开环目标角度 |
| `duration_s` | `0 < duration_s <= 10.0` | 直接指定指令时长 |
| `yaw_rate_rad_s` | `0.02 <= yaw_rate_rad_s <= 1.0` | 偏航角速度大小 |

ZSL-1 移动接口接受的非零 `|yaw_rate|` 为 `0.02..3.0 rad/s`；Agentech 公开封装范围为 `0.02..1.0 rad/s`。角度只按上面的公式换算，不代表实测转向标定。

### 保留的 TBD 参数

`angle_percent`、`turn_level`、`quarter_turns` 保留为 `TBD`：目前没有找到这些既有别名的权威映射。当前传入其中任意字段都会在发送指令前返回 `rejected(E_TBD_PARAMETER)`。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

左转解析为 `move(0, 0, +yaw_rate_rad_s)`，右转解析为 `move(0, 0, -yaw_rate_rad_s)`；到达解析时长后发送 `move(0, 0, 0)`。模拟器使用完全相同的带符号指令 trace。
<!-- END: Behavior -->

<!-- START: Return -->
## 返回

```python
SkillResult(status, trace_id, error_code, message)
```

`status` 为 `"succeeded"`、`"rejected"`、`"preempted"`、`"estopped"` 或 `"timeout"`。上游返回码按 `profiles/aegis/zsl1.yaml` 翻译，原始数值保留在指令 trace 中。
<!-- END: Return -->

<!-- START: Example -->
## 示例

```python
result = Agentech.turn(direction="left")
result = Agentech.turn(direction="right", angle_deg=90, yaw_rate_rad_s=0.5) # pi s
result = Agentech.turn(direction="left", duration_s=2.0, yaw_rate_rad_s=0.3)
```
<!-- END: Example -->
