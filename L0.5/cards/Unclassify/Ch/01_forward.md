# `Agentech.forward(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · 移动** — 在机身坐标系发送有时限的正向 `vx` 指令，结束时发送零运动指令。

这是 ZSL-1 `move(vx, vy, yaw_rate)` 的开环封装，不代表实测距离，也不承诺里程计闭环到位。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.forward()
Agentech.forward(speed_mps: float, duration_s: float)
Agentech.forward(speed_percent: int, duration_s: float)
Agentech.forward(speed_level: int, duration_s: float)
Agentech.forward(pace: str, duration_s: float)
Agentech.forward(distance_m: float, speed_mps: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. 速度表达只能选择 `speed_mps`、`speed_percent`、`speed_level` 或 `pace` 中的一种；`distance_m` 只能和 `speed_mps` 组合。
2. 混用速度表达返回 `rejected(E_PROFILE_MIXED)`。
3. 越界值返回 `rejected(E_RANGE)`，SDK 不做截断。
4. 距离调用仅在 `distance_m / speed_mps <= 10.0 s` 时合法。
5. ZSL-1 `move` 只能从站立状态切入。
6. 真机后端和模拟器后端必须共用同一个参数解析器。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 确定性解析结果 |
| --- | --- |
| `Agentech.forward()` | `speed_mps=0.4`，`duration_s=1.0` |
| 速度表达未给 `duration_s` | `duration_s=1.0` |
| `Agentech.forward(distance_m=...)` | `speed_mps=0.4`；时长为 `distance_m / 0.4` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数模式 | 范围 / 可选值 | 解析后的速度 |
| --- | --- | --- |
| `speed_mps` | `0.05 <= speed_mps <= 1.0` | 原值 |
| `speed_percent` | 整数 `5..100` | `speed_percent / 100 * 1.0 m/s` |
| `speed_level` | 整数 `1..5` | `{1:0.2, 2:0.4, 3:0.6, 4:0.8, 5:1.0} m/s` |
| `pace` | `"slow"`、`"normal"`、`"fast"` | `{slow:0.2, normal:0.4, fast:0.8} m/s` |
| `distance_m` | `0 < distance_m <= 5.0` | 时长 = `distance_m / speed_mps` |
| `duration_s` | `0 < duration_s <= 10.0` | 指令持续时间 |

ZSL-1 底层接受的非零 `|vx|` 为 `0.05..3.0 m/s`；Agentech 公开封装范围为 `0.05..1.0 m/s`。`speed_percent`、`speed_level`、`pace` 是严格按上表换算的 Agentech 别名，不是 ZSL-1 原生参数，也不是实测速度。

### 保留的 TBD 参数

| 已设计字段 | 状态 |
| --- | --- |
| `step_count` | `TBD` — 未找到 ZSL-1 步数指令或换算依据 |
| `step_rate_hz` | `TBD` — 未找到 ZSL-1 步频参数 |
| `gait` | `TBD` — 未找到 ZSL-1 步态选择参数 |

这些字段保留用于兼容性规划；当前只要传入其中任意字段，就会在发送真机或模拟器指令前返回 `rejected(E_TBD_PARAMETER)`。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

机器人进入可运动状态后，解析结果编译为 `move(+speed_mps, 0, 0)`；到达时长后发送 `move(0, 0, 0)`。模拟器必须收到完全相同的数值和时序，不能自行重新解释档位或 pace。
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
result = Agentech.forward(speed_level=3, duration_s=1.0)  # move(+0.6, 0, 0)
result = Agentech.forward(pace="fast", duration_s=1.0)   # move(+0.8, 0, 0)
result = Agentech.forward(distance_m=0.5, speed_mps=0.25) # 2.0 s
```
<!-- END: Example -->
