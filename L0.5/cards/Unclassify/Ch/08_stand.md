# `Agentech.stand(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · 姿态** — 请求无参数的 ZSL-1 `standUp()` 状态转换；请求被接受后可由 Agentech 主机额外等待。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.stand()
Agentech.stand(stabilize_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. ZSL-1 `standUp()` 不接受高度或姿态参数。
2. 上游文档不允许从移动状态直接切换到站立；调用者必须先停止运动。
3. `stabilize_s` 是主机等待时间，绝不传给 `standUp()`。
4. 上游状态转换拒绝会直接返回；SDK 不虚构恢复步骤，也不自动重试。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

`Agentech.stand()` 等同于 `Agentech.stand(stabilize_s=3.0)`。`3.0 s` 来自上游示例的调用等待，不是 `standUp()` 参数，也不是实测转换时长。
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 默认值 | 范围 | 含义 |
| --- | ---: | --- | --- |
| `stabilize_s` | `3.0` | `0 <= stabilize_s <= 10.0` | 站立请求被接受后的主机侧等待时间。 |

原有 `height_level` 和 `posture` 参数保留为 `TBD`；ZSL-1 `standUp()` 没有公开这两个输入。当前传入任一字段都会在调用 `standUp()` 前返回 `rejected(E_TBD_PARAMETER)`。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

真机后端无参数调用 `standUp()` 并记录返回码；请求成功后等待 `stabilize_s`。模拟器发出同一个无参数 `standUp` 事件，并执行相同主机等待。
<!-- END: Behavior -->

<!-- START: Return -->
## 返回

```python
SkillResult(status, trace_id, error_code, message)
```

上游返回码按 `profiles/aegis/zsl1.yaml` 翻译，原始数值保留在 trace 中。
<!-- END: Return -->

<!-- START: Example -->
## 示例

```python
result = Agentech.stand()
result = Agentech.stand(stabilize_s=3.0)
```
<!-- END: Example -->
