# `Agentech.look(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · 姿态** — 保留 Agentech `look` API 名称，并通过 ZSL-1 `attitudeControl` 施加有时限的机身俯仰速率。

ZSL-1 只公开机身姿态速率控制，没有公开相机俯仰执行器或绝对视角指令。当前只有机身速率形式可执行，已有但不受支持的形式继续以 `TBD` 保留。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.look(direction: str)
Agentech.look(target: str, direction: str, pitch_rate_rad_s: float, duration_s: float)
Agentech.look(target: str, direction: str, pitch_rate_rad_s: float, duration_s: float, hold_s: float, return_to_neutral: bool)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. `direction` 为 `"up"` 或 `"down"`；`pitch_rate_rad_s` 是正的角速度大小。
2. 当前唯一可执行目标是 `target="body"`；`"auto"` 和 `"camera"` 保留为 `TBD`。
3. 可执行形式只接受速率和时长；ZSL-1 没有公开绝对机身俯仰角限制。
4. `return_to_neutral=True` 表示发送等时反向速率，不代表绝对姿态闭环恢复。
5. ZSL-1 `attitudeControl` 只能从站立状态切入。
6. 真机和模拟器后端必须执行相同的 `attitudeControl` 指令序列。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

`Agentech.look(direction=...)` 解析为 `target="body"`、`pitch_rate_rad_s=0.2`、`duration_s=0.5`、`hold_s=0.0`、`return_to_neutral=True`。
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 默认值 | 范围 / 可选值 |
| --- | ---: | --- |
| `target` | `"body"` | 当前仅 `"body"` |
| `direction` | 必填 | `"up"` 或 `"down"` |
| `pitch_rate_rad_s` | `0.2` | `0.02 <= pitch_rate_rad_s <= 0.2` |
| `duration_s` | `0.5` | `0 < duration_s <= 2.0` |
| `hold_s` | `0.0` | `0 <= hold_s <= 3.0` |
| `return_to_neutral` | `True` | 布尔值 |

按上游机身坐标系（`X` 前、`Y` 左、`Z` 上）和右手定则，正俯仰会使机头向下，因此 down 为正、up 为负。上游俯仰角速度范围为 `-0.5..+0.5 rad/s`；Agentech 公开的角速度大小范围为 `0.02..0.2 rad/s`。

### 保留的 TBD 参数

`target="auto"`、`target="camera"`、`angle_deg`、`angle_percent`、`look_level` 保留为 `TBD`。当前传入其中任意字段都会在发送指令前返回 `rejected(E_TBD_PARAMETER)`；不得为它们虚构范围或模拟行为。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

对 body 目标，向下在 `duration_s` 内发送 `attitudeControl(0, +rate, 0, 0)`，向上发送 `attitudeControl(0, -rate, 0, 0)`，随后发送全零。保持 `hold_s` 后，若 `return_to_neutral=True`，则以相反符号发送相同时长，再发送全零。模拟器使用完全相同的序列。
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
result = Agentech.look(direction="up")
result = Agentech.look(target="body", direction="down", pitch_rate_rad_s=0.1, duration_s=1.0)
result = Agentech.look(target="body", direction="up", pitch_rate_rad_s=0.15, duration_s=0.5, hold_s=1.0, return_to_neutral=True)
```
<!-- END: Example -->
