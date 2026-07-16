# `Agentech.lateral(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · 移动** — 在机身坐标系向左或向右发送有时限的 `vy` 指令，结束时发送零运动指令。

这是 ZSL-1 `move(vx, vy, yaw_rate)` 的开环封装。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.lateral(direction: str)
Agentech.lateral(direction: str, speed_mps: float, duration_s: float)
Agentech.lateral(direction: str, speed_percent: int, duration_s: float)
Agentech.lateral(direction: str, speed_level: int, duration_s: float)
Agentech.lateral(direction: str, distance_m: float, speed_mps: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. `direction` 为 `"left"` 或 `"right"`；速度输入均为正的速度大小。
2. 速度表达只能选择 `speed_mps`、`speed_percent` 或 `speed_level` 中的一种；`distance_m` 只能和 `speed_mps` 组合。
3. 混用速度表达返回 `rejected(E_PROFILE_MIXED)`；越界返回 `rejected(E_RANGE)`。
4. 距离调用仅在 `distance_m / speed_mps <= 10.0 s` 时合法。
5. ZSL-1 `move` 只能从站立状态切入。
6. 真机后端和模拟器后端必须共用同一个参数解析器。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 确定性解析结果 |
| --- | --- |
| `Agentech.lateral(direction=...)` | `speed_mps=0.2`，`duration_s=1.0` |
| 速度表达未给 `duration_s` | `duration_s=1.0` |
| `Agentech.lateral(direction=..., distance_m=...)` | `speed_mps=0.2`；时长为 `distance_m / 0.2` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 / 模式 | 范围 / 可选值 | 解析结果 |
| --- | --- | --- |
| `direction` | `"left"`、`"right"` | 左为正 `vy`；右为负 `vy` |
| `speed_mps` | `0.1 <= speed_mps <= 0.5` | 原值 |
| `speed_percent` | 整数 `20..100` | `speed_percent / 100 * 0.5 m/s` |
| `speed_level` | 整数 `1..5` | `{1:0.1, 2:0.2, 3:0.3, 4:0.4, 5:0.5} m/s` |
| `distance_m` | `0 < distance_m <= 2.0` | 时长 = `distance_m / speed_mps` |
| `duration_s` | `0 < duration_s <= 10.0` | 指令持续时间 |

ZSL-1 底层接受的非零 `|vy|` 为 `0.1..1.0 m/s`；Agentech 公开封装范围为 `0.1..0.5 m/s`。百分比和档位是确定性的 Agentech 映射，不是上游参数，也不是实测速度。

### 保留的 TBD 参数

| 已设计字段 | 状态 |
| --- | --- |
| `step_count` | `TBD` — 未找到 ZSL-1 步数指令或换算依据 |
| `step_rate_hz` | `TBD` — 未找到 ZSL-1 步频参数 |
| `gait` | `TBD` — 未找到 ZSL-1 步态选择参数 |

当前传入任意 TBD 字段都会在发送指令前返回 `rejected(E_TBD_PARAMETER)`。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

向左解析为 `move(0, +speed_mps, 0)`，向右解析为 `move(0, -speed_mps, 0)`；到达时长后发送 `move(0, 0, 0)`。模拟器必须接收完全相同的数值和时序。
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
result = Agentech.lateral(direction="left", speed_level=3, duration_s=1.0)    # move(0, +0.3, 0)
result = Agentech.lateral(direction="right", speed_percent=40, duration_s=1) # move(0, -0.2, 0)
result = Agentech.lateral(direction="left", distance_m=0.4, speed_mps=0.2)   # 2.0 s
```
<!-- END: Example -->
