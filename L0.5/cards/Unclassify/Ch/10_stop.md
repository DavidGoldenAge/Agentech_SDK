# `Agentech.stop(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · 安全** — 抢占普通运动输出，发送 ZSL-1 零运动指令 `move(0, 0, 0)`，并在有限时间内等待遥测确认。

ZSL-1 高层移动指令没有公开可选减速策略。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.stop()
Agentech.stop(timeout_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. `stop` 抢占当前普通运动指令，但不调用 `passive()`。
2. 底层指令始终严格为 `move(0.0, 0.0, 0.0)`。
3. `timeout_s` 只改变确认等待时间，不改变减速过程。
4. 急停状态优先级更高。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

`Agentech.stop()` 等同于 `Agentech.stop(timeout_s=2.0)`。
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 默认值 | 范围 | 含义 |
| --- | ---: | --- | --- |
| `timeout_s` | `2.0` | `0.1 <= timeout_s <= 5.0` | 等待遥测进入软件停止阈值的最长时间。 |

Agentech 确认阈值为机身线速度 `<= 0.05 m/s`、机身偏航角速度 `<= 0.02 rad/s`。它们是 `profiles/aegis/zsl1.yaml` 中的软件验收阈值，不是实测硬件极限。

原有 `mode` 和 `decel_level` 参数保留为 `TBD`；ZSL-1 高层运动接口没有公开这两个输入。当前传入任一字段都会在发送零指令前返回 `rejected(E_TBD_PARAMETER)`。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

SDK 发送 `move(0, 0, 0)`，并检查 ZSL-1 机身速度和机身陀螺仪遥测，直到满足 profile 阈值或超时。模拟器接收相同的零指令并使用相同阈值。
<!-- END: Behavior -->

<!-- START: Return -->
## 返回

```python
SkillResult(status, trace_id, error_code, message)
```

确认后返回 `"succeeded"`，超时返回 `"timeout"`，底层拒绝则返回翻译后的错误；上游原始数值码保留在 trace 中。
<!-- END: Return -->

<!-- START: Example -->
## 示例

```python
result = Agentech.stop()
result = Agentech.stop(timeout_s=3.0)
```
<!-- END: Example -->
