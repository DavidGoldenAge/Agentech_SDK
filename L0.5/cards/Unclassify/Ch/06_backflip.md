# `Agentech.backflip(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · 离散动作** — 请求 ZSL-1 `backflip()` 动作；请求被接受后可由 Agentech 主机额外等待。

ZSL-1 把后空翻公开为无参数离散动作，而不是可调轨迹。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.backflip()
Agentech.backflip(stabilize_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. 上游动作不接受高度、速度、样式或轨迹参数。
2. ZSL-1 只允许从站立状态切入，移动中禁止切换。
3. 上游文档明确警告：高频使用会加速电机和关节磨损，并可能降低性能或缩短寿命。
4. `stabilize_s` 是 Agentech 主机等待时间，绝不传给 `backflip()`。
5. 越界值返回 `rejected(E_RANGE)`；上游状态转换拒绝会直接返回，不自动重试。
6. 成功只表示上游请求成功且主机等待结束，不代表通过实测姿态证明动作完成。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

`Agentech.backflip()` 等同于 `Agentech.backflip(stabilize_s=4.0)`。`4.0 s` 来自上游示例的调用等待，不是硬件参数，也不是实测动作时长。
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 默认值 | 范围 | 含义 |
| --- | ---: | --- | --- |
| `stabilize_s` | `4.0` | `0 <= stabilize_s <= 10.0` | 动作请求被接受后的主机侧等待时间。 |

原有 `variant` 参数保留为 `TBD`；ZSL-1 没有公开后空翻样式选择。当前传入该字段会在调用 `backflip()` 前返回 `rejected(E_TBD_PARAMETER)`。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

真机后端无参数调用 `backflip()`，记录返回码；请求成功后再等待 `stabilize_s`。模拟器发出同一个无参数动作事件，并执行相同主机等待。
<!-- END: Behavior -->

<!-- START: Return -->
## 返回

```python
SkillResult(status, trace_id, error_code, message)
```

包括状态转换和电机故障在内的上游返回码按 `profiles/aegis/zsl1.yaml` 翻译，原始数值保留在 trace 中。
<!-- END: Return -->

<!-- START: Example -->
## 示例

```python
result = Agentech.backflip()
result = Agentech.backflip(stabilize_s=4.0)
```
<!-- END: Example -->
