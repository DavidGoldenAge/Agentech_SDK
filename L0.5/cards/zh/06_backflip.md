# `Agentech.backflip(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · Movement** — 执行一次已批准的 Aegis 后空翻动作 profile。

这是高风险预置动作接口。SDK 只允许调用经过安全审核和设备标定的动作变体。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.backflip()
Agentech.backflip(variant: str)
Agentech.backflip(variant: str, stabilize_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. `variant` 只能使用已批准的动作变体；未知变体返回 `rejected(E_UNSUPPORTED)`。
2. 执行动作前必须通过 SafetyGate；未通过返回 `rejected(E_SAFETY_GATE)`。
3. `stabilize_s` 是动作结束后的等待时间，不代表恢复验证。
4. 不自动重试。失败后由上层决定恢复流程。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 默认反应 |
| --- | --- |
| `Agentech.backflip()` | 等价于 `Agentech.backflip(variant="standard", stabilize_s=5.0)` |
| `Agentech.backflip(variant=...)` | `stabilize_s` 默认 `5.0` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 默认值 | 范围 / 规则 | 说明 |
| --- | --- | --- | --- |
| `variant` | `"standard"` | 已批准变体 | 选择一个预置后空翻动作 profile。 |
| `stabilize_s` | `5.0` | `0 <= stabilize_s <= 10.0` | 动作结束后的稳定等待时间。 |

### 参数解释

`variant` 是动作 profile 名，不是风格自由文本。未知变体必须拒绝，不能回退到默认动作。

`stabilize_s` 只是等待窗口。它不检查机器人是否真正恢复到可继续任务的状态。

SafetyGate 至少应检查急停状态、电量、姿态、地面/空间条件、设备能力和当前是否允许执行高风险动作。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

SDK 会先执行 SafetyGate，然后触发一次后空翻动作 profile。动作结束后等待 `stabilize_s`，再返回结果。
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
result = Agentech.backflip()
result = Agentech.backflip(variant="standard", stabilize_s=5.0)
```
<!-- END: Example -->
