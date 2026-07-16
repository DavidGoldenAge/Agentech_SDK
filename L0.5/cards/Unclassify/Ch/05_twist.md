# `Agentech.twist(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · 姿态** — 通过 ZSL-1 `attitudeControl` 施加有时限的机身偏航姿态速率，可选保持，再可选用等时反向速率返回。

这是机身姿态变化，不是移动转向指令，也不承诺绝对偏航角。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.twist(direction: str)
Agentech.twist(direction: str, yaw_rate_rad_s: float, duration_s: float)
Agentech.twist(direction: str, yaw_rate_rad_s: float, duration_s: float, hold_s: float, return_to_neutral: bool)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. `direction` 为 `"left"` 或 `"right"`；`yaw_rate_rad_s` 是正的角速度大小。
2. 本接口只接受速率和时长；ZSL-1 没有公开绝对机身偏航角限制。
3. 越界值返回 `rejected(E_RANGE)`，SDK 不做截断。
4. `return_to_neutral=True` 表示发送等时反向速率，不代表绝对姿态闭环恢复。
5. ZSL-1 `attitudeControl` 只能从站立状态切入。
6. 真机和模拟器后端必须执行相同的 `attitudeControl` 指令序列。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

`Agentech.twist(direction=...)` 解析为 `yaw_rate_rad_s=0.2`、`duration_s=0.5`、`hold_s=0.0`、`return_to_neutral=True`。
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 默认值 | 范围 / 可选值 |
| --- | ---: | --- |
| `direction` | 必填 | `"left"` 或 `"right"` |
| `yaw_rate_rad_s` | `0.2` | `0.02 <= yaw_rate_rad_s <= 0.2` |
| `duration_s` | `0.5` | `0 < duration_s <= 2.0` |
| `hold_s` | `0.0` | `0 <= hold_s <= 3.0` |
| `return_to_neutral` | `True` | 布尔值 |

上游姿态偏航角速度范围为 `-0.5..+0.5 rad/s`。Agentech 公开的角速度大小范围为 `0.02..0.2 rad/s`；这是软件合约值，不是实测姿态角。

### 保留的 TBD 参数

`angle_deg`、`angle_percent`、`twist_level` 保留为 `TBD`，因为 ZSL-1 没有公开绝对机身偏航范围，也没有这些既有输入的映射。当前传入其中任意字段都会在发送指令前返回 `rejected(E_TBD_PARAMETER)`。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

向左在 `duration_s` 内发送 `attitudeControl(0, 0, +rate, 0)`，向右发送 `attitudeControl(0, 0, -rate, 0)`，随后发送全零。保持 `hold_s` 后，若 `return_to_neutral=True`，则以相反符号发送相同时长，再发送全零。模拟器使用完全相同的序列。
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
result = Agentech.twist(direction="left")
result = Agentech.twist(direction="right", yaw_rate_rad_s=0.1, duration_s=1.0)
result = Agentech.twist(direction="left", yaw_rate_rad_s=0.15, duration_s=0.5, hold_s=1.0, return_to_neutral=True)
```
<!-- END: Example -->
