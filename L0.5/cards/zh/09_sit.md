# `Agentech.sit(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · Posture** — 让 Aegis 机器狗进入地面坐姿阻尼状态，并在需要时保持一段稳定等待时间。

这是姿态切换指令，用于从站立或运动准备状态切换到坐姿/阻尼状态。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.sit()
Agentech.sit(mode: str)
Agentech.sit(stabilize_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. `mode` 只能使用已批准模式。
2. `stabilize_s` 是姿态切换后的等待时间，不是坐下超时时间。
3. 当前姿态不适合切换到坐姿时返回 `rejected(E_NOT_READY)` 或对应安全错误。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 默认反应 |
| --- | --- |
| `Agentech.sit()` | 等价于 `Agentech.sit(mode="damping", stabilize_s=2.0)` |
| `Agentech.sit(mode=...)` | `stabilize_s` 默认 `2.0` |
| `Agentech.sit(stabilize_s=...)` | `mode` 默认 `"damping"` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 默认值 | 范围 / 规则 | 说明 |
| --- | --- | --- | --- |
| `mode` | `"damping"` | 已批准模式 | 坐姿/阻尼模式。 |
| `stabilize_s` | `2.0` | `0 <= stabilize_s <= 10.0` | 姿态切换后的稳定等待时间。 |

### 参数解释

`mode="damping"` 表示进入坐姿阻尼状态，用于降低后续运动输出。

`stabilize_s` 是等待窗口。它不替代姿态状态验证。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

SDK 会请求机器人进入坐姿/阻尼状态，等待姿态切换完成，然后按 `stabilize_s` 保持。
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
result = Agentech.sit()
result = Agentech.sit(mode="damping")
result = Agentech.sit(stabilize_s=2.0)
```
<!-- END: Example -->
