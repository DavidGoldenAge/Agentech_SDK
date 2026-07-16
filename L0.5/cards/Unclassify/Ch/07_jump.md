# `Agentech.jump(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · 离散动作** — 请求 ZSL-1 垂直 `jump()` 动作；请求被接受后可由 Agentech 主机额外等待。

ZSL-1 把 `jump()` 公开为无参数动作。`frontJump()` 是另一个独立的上游动作，不是本函数的一种模式。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.jump()
Agentech.jump(stabilize_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. 上游动作不接受高度、速度、方向或轨迹参数。
2. ZSL-1 只允许从站立状态切入，移动中禁止切换。
3. `stabilize_s` 是 Agentech 主机等待时间，绝不传给 `jump()`。
4. 越界值返回 `rejected(E_RANGE)`；上游状态转换拒绝会直接返回，不自动重试。
5. 成功只表示请求成功且主机等待结束，不代表实测跳跃高度或落地姿态得到验证。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

`Agentech.jump()` 等同于 `Agentech.jump(stabilize_s=4.0)`。`4.0 s` 来自上游示例的调用等待，不是硬件参数，也不是实测动作时长。
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 默认值 | 范围 | 含义 |
| --- | ---: | --- | --- |
| `stabilize_s` | `4.0` | `0 <= stabilize_s <= 10.0` | 动作请求被接受后的主机侧等待时间。 |

原有 `variant` 和 `height_level` 参数保留为 `TBD`；ZSL-1 `jump()` 没有公开这两个输入。当前传入任一字段都会在调用 `jump()` 前返回 `rejected(E_TBD_PARAMETER)`。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

真机后端无参数调用 `jump()`，记录返回码；请求成功后再等待 `stabilize_s`。模拟器发出同一个无参数垂直跳跃事件，并执行相同主机等待。
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
result = Agentech.jump()
result = Agentech.jump(stabilize_s=4.0)
```
<!-- END: Example -->
