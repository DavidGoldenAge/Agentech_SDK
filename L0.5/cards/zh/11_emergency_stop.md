# `Agentech.emergency_stop(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · Safety** — 触发紧急停止，抢占所有活动动作，并进入急停后的安全模式。

这是最高优先级安全指令，用于把机器人立即切入急停处理路径。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.emergency_stop()
Agentech.emergency_stop(reason: str, latch: bool)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. `emergency_stop` 抢占任意活动调用。
2. `latch=True` 时，急停状态保持到外部系统显式复位。
3. `reason` 用于日志和操作员界面，不作为程序分支条件。
4. 调用结果只表示急停请求是否进入处理路径。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 默认反应 |
| --- | --- |
| `Agentech.emergency_stop()` | 等价于 `Agentech.emergency_stop(reason="Agentech emergency stop", latch=True)` |
| `Agentech.emergency_stop(reason=...)` | `latch` 默认 `True` |
| `Agentech.emergency_stop(latch=...)` | `reason` 默认 `"Agentech emergency stop"` |
| 所有调用 | 急停后安全模式默认 `"damping"` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 默认值 | 范围 / 规则 | 说明 |
| --- | --- | --- | --- |
| `reason` | `"Agentech emergency stop"` | short string | 操作员可读原因，会进入日志。 |
| `latch` | `True` | `True` 或 `False` | 是否锁存急停状态。 |
| `mode` | `"damping"` | 已批准模式 | 急停后的安全模式，当前由 SDK 固定。 |

### 参数解释

`reason` 应该短、具体、便于日志检索。

`latch=True` 用于需要人工或上层系统确认后才能恢复的急停场景。

`mode="damping"` 是当前急停后的默认安全模式。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

SDK 会立即请求急停，抢占当前活动动作，并进入急停后的安全模式。
<!-- END: Behavior -->

<!-- START: Return -->
## 返回

```python
SkillResult(status, trace_id, error_code, message)
```

| 字段 | 含义 |
| --- | --- |
| `status` | 本次调用的最终状态：`"estopped"`、`"rejected"` 或 `"timeout"` |
| `trace_id` | 用来关联 SDK 日志和设备日志的命令 ID |
| `error_code` | 成功时为 `None`；失败时返回稳定错误码 |
| `message` | 给开发者看的错误或状态说明，不建议用于程序分支判断 |

急停请求成功进入处理路径时返回 `status="estopped"` 且 `error_code=None`。`"rejected"` 表示请求未被接受；`"timeout"` 表示 SDK 未在 `timeout_s` 窗口内确认急停处理路径。
<!-- END: Return -->

<!-- START: Example -->
## 示例

```python
result = Agentech.emergency_stop()
result = Agentech.emergency_stop(reason="low clearance", latch=True)
```
<!-- END: Example -->
