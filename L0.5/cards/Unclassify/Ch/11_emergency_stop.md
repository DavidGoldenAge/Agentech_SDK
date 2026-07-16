# `Agentech.emergency_stop(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · 安全** — 抢占 SDK 动作，调用无参数的 ZSL-1 `passive()`，并可锁住 Agentech 运行时以拒绝后续运动调用。

该锁存是 Agentech 软件互锁，不是 ZSL-1 参数，也不是硬件锁存急停。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.emergency_stop()
Agentech.emergency_stop(reason: str, latch: bool, timeout_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. 本调用在 Agentech 运行时内优先级最高，会抢占正在执行的 SDK 动作。
2. `reason`、`latch`、`timeout_s` 都是封装层输入，不传给 `passive()`。
3. `latch=True` 会拒绝之后的非安全调用，直到显式重置 Agentech 运行时。
4. 本 API 不宣称存在物理急停回路或硬件锁存。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

`Agentech.emergency_stop()` 解析为 `reason="Agentech emergency stop"`、`latch=True`、`timeout_s=0.5`。
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 默认值 | 范围 / 可选值 | 含义 |
| --- | --- | --- | --- |
| `reason` | `"Agentech emergency stop"` | 非空短字符串 | 主机日志元数据。 |
| `latch` | `True` | 布尔值 | Agentech 运行时互锁。 |
| `timeout_s` | `0.5` | `0.1 <= timeout_s <= 2.0` | 等待被动控制模式确认的最长时间。 |

原先描述的急停后 `mode` 字段保留为 `TBD`；`passive()` 没有模式参数。当前传入 `mode` 会在 passive 请求前返回 `rejected(E_TBD_PARAMETER)`。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

SDK 抢占活动调用，无参数执行 `passive()`，并等待 ZSL-1 控制模式 `0` 或超时；如有要求，再保持 Agentech 运行时锁存。模拟器接收相同的无参数 passive 事件和锁存状态变化。
<!-- END: Behavior -->

<!-- START: Return -->
## 返回

```python
SkillResult(status, trace_id, error_code, message)
```

确认被动模式后返回 `status="estopped"`。拒绝与超时保持区分；上游原始返回码保留在 trace 中。
<!-- END: Return -->

<!-- START: Example -->
## 示例

```python
result = Agentech.emergency_stop()
result = Agentech.emergency_stop(reason="operator request", latch=True, timeout_s=0.5)
```
<!-- END: Example -->
