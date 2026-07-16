# `Agentech.sit(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · 姿态** — 保留 Agentech `sit` API 名称，并将其作为无参数 ZSL-1 `lieDown()` 卧倒状态转换的兼容封装。

这是正常姿态指令，与 `emergency_stop` 使用的 ZSL-1 `passive()` 明确分离。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.sit()
Agentech.sit(stabilize_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. 当前可用调用始终无参数执行 `lieDown()`。
2. ZSL-1 不允许移动中直接切入 `lieDown()`；调用者必须先停止。
3. `stabilize_s` 是主机等待时间，绝不传给 `lieDown()`。
4. 实现不得用 `passive()` 代替 `lieDown()`。
5. 上游状态转换拒绝会直接返回，不自动重试。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

`Agentech.sit()` 等同于 `Agentech.sit(stabilize_s=3.0)`。`3.0 s` 来自上游示例的调用等待，不是 `lieDown()` 参数，也不是实测转换时长。
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 默认值 | 范围 | 含义 |
| --- | ---: | --- | --- |
| `stabilize_s` | `3.0` | `0 <= stabilize_s <= 10.0` | `lieDown()` 请求被接受后的主机侧等待时间。 |

原有 `mode` 参数保留为 `TBD`；ZSL-1 `lieDown()` 没有模式输入。当前传入 `mode` 会在发送任何姿态指令前返回 `rejected(E_TBD_PARAMETER)`。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

真机后端把 `sit()` 编译为无参数 `lieDown()` 调用并记录返回码；请求成功后等待 `stabilize_s`。模拟器发出相同的 `lieDown` 事件，并执行相同主机等待。
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
result = Agentech.sit()
result = Agentech.sit(stabilize_s=3.0)
```
<!-- END: Example -->
