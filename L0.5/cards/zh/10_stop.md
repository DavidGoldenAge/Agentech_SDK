# `Agentech.stop(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · Safety** — 抢占当前普通运动指令，并以指定减速策略进入停止状态。

这是受控停止指令，用于结束当前运动控制输出。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.stop()
Agentech.stop(mode: str)
Agentech.stop(decel_level: int)
Agentech.stop(timeout_s: float)
Agentech.stop(mode: str, decel_level: int)
Agentech.stop(mode: str, decel_level: int, timeout_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. `stop` 抢占当前普通运动指令。
2. `mode` 和 `decel_level` 可以同时使用；`mode` 决定停止策略，`decel_level` 决定减速强度。
3. `timeout_s` 到期仍未完成停止时返回 `timeout(E_TIMEOUT)`。
4. emergency stop 拥有更高优先级。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 默认反应 |
| --- | --- |
| `Agentech.stop()` | 等价于 `Agentech.stop(mode="controlled", decel_level=3, timeout_s=2.0)` |
| `Agentech.stop(mode=...)` | `decel_level` 默认 `3`，`timeout_s` 默认 `2.0` |
| `Agentech.stop(decel_level=...)` | `mode` 默认 `"controlled"`，`timeout_s` 默认 `2.0` |
| `Agentech.stop(timeout_s=...)` | `mode` 默认 `"controlled"`，`decel_level` 默认 `3` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 默认值 | 范围 / 规则 | 说明 |
| --- | --- | --- | --- |
| `mode` | `"controlled"` | `"controlled"` 或 `"quick"` | 停止策略。 |
| `decel_level` | `3` | `1`、`2`、`3`、`4` 或 `5` | 减速强度，数值越大越快停止。 |
| `timeout_s` | `2.0` | `0.1 <= timeout_s <= 5.0` | 等待停止完成的最长时间。 |

### 参数解释

`mode="controlled"` 用于常规受控停止。`mode="quick"` 用于更快收敛的停止策略。

`decel_level` 是产品档位，不是物理加速度单位。

`timeout_s` 控制 SDK 等待停止完成的时间窗口。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

SDK 会抢占当前普通运动指令，发送停止请求，并等待机器人进入停止状态或超时。
<!-- END: Behavior -->

<!-- START: Return -->
## 返回

```python
SkillResult(status, trace_id, error_code, message)
```

| 字段 | 含义 |
| --- | --- |
| `status` | 本次调用的最终状态：`"succeeded"`、`"rejected"`、`"preempted"`、`"estopped"` 或 `"timeout"` |
| `trace_id` | 用来关联 SDK 日志和设备日志的命令 ID |
| `error_code` | 成功时为 `None`；失败时返回稳定错误码 |
| `message` | 给开发者看的错误或状态说明，不建议用于程序分支判断 |
<!-- END: Return -->

<!-- START: Example -->
## 示例

```python
result = Agentech.stop()
result = Agentech.stop(mode="controlled")
result = Agentech.stop(decel_level=3)
result = Agentech.stop(timeout_s=2.0)
result = Agentech.stop(mode="controlled", decel_level=3)
result = Agentech.stop(mode="quick", decel_level=5, timeout_s=2.0)
```
<!-- END: Example -->
