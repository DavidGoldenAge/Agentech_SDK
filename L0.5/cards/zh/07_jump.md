# `Agentech.jump(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · Movement** — 执行一次已批准的 Aegis 跳跃动作 profile。

这是高风险预置动作接口。开发者只能选择已标定的跳跃变体或高度档位。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.jump()
Agentech.jump(height_level: int)
Agentech.jump(variant: str, stabilize_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. `variant` 和 `height_level` 是两种选择方式，不能同时传；同时传返回 `rejected(E_PROFILE_MIXED)`。
2. 执行动作前必须通过 SafetyGate；未通过返回 `rejected(E_SAFETY_GATE)`。
3. `height_level` 选择的是已标定跳跃 profile，不是米或厘米。
4. `stabilize_s` 是动作结束后的等待时间，不代表恢复验证。
5. 不自动重试。设备或模拟器不支持该动作时返回 `rejected(E_UNSUPPORTED)`。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 默认反应 |
| --- | --- |
| `Agentech.jump()` | 等价于 `Agentech.jump(variant="standard", stabilize_s=5.0)` |
| `Agentech.jump(height_level=...)` | `stabilize_s` 默认 `5.0` |
| `Agentech.jump(variant=...)` | `stabilize_s` 默认 `5.0` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 默认值 | 范围 / 规则 | 说明 |
| --- | --- | --- | --- |
| `variant` | `"standard"` | 已批准变体 | 选择一个预置跳跃动作 profile。 |
| `height_level` | `None` | `1`、`2` 或 `3` | 选择低/中/高三个已标定高度档位。 |
| `stabilize_s` | `5.0` | `0 <= stabilize_s <= 10.0` | 动作结束后的稳定等待时间。 |

### 参数解释

`variant` 适合直接调用命名动作 profile，例如 `"standard"`。

`height_level=1` 表示低跳，`2` 表示中等高度，`3` 表示当前批准的最高跳跃 profile。

`stabilize_s` 只是等待窗口。它不检查落地是否满足继续任务的条件。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

SDK 会先执行 SafetyGate，然后触发一次跳跃动作 profile。动作结束后等待 `stabilize_s`，再返回结果。
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
result = Agentech.jump()
result = Agentech.jump(height_level=1)
result = Agentech.jump(variant="standard", stabilize_s=5.0)
```
<!-- END: Example -->
