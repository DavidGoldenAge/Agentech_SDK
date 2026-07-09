# `Agentech.stand(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · Posture** — 让 Aegis 机器狗进入稳定站立姿态，并在需要时保持一段稳定等待时间。

这是姿态指令，用于把机器人切换到可运动的站立状态。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.stand()
Agentech.stand(stabilize_s: float)
Agentech.stand(height_level: int)
Agentech.stand(height_level: int, stabilize_s: float)
Agentech.stand(posture: str)
Agentech.stand(posture: str, stabilize_s: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. `height_level` 和 `posture` 是两种表达同一类站立高度/姿态的方式，不能同时传。
2. 如果机器人已经处于兼容的站立姿态，调用应作为幂等成功处理。
3. `stabilize_s` 是站立完成后的等待时间，不是站立超时时间。
4. 当前姿态、电量或急停状态不允许站立时返回 `rejected(E_NOT_READY)` 或对应安全错误。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 默认反应 |
| --- | --- |
| `Agentech.stand()` | 等价于 `Agentech.stand(posture="neutral", stabilize_s=5.0)` |
| `Agentech.stand(stabilize_s=...)` | `posture` 默认 `"neutral"` |
| `Agentech.stand(height_level=...)` | `stabilize_s` 默认 `5.0` |
| `Agentech.stand(posture=...)` | `stabilize_s` 默认 `5.0` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 默认值 | 范围 / 规则 | 说明 |
| --- | --- | --- | --- |
| `stabilize_s` | `5.0` | `0 <= stabilize_s <= 10.0` | 站立完成后的稳定等待时间。 |
| `height_level` | `None` | `1`、`2` 或 `3` | 用档位选择站立高度。 |
| `posture` | `"neutral"` | `"low"`、`"neutral"` 或 `"tall"` | 用可读名称选择站立姿态。 |

### 参数解释

`height_level=1` 对应低站姿，`height_level=2` 对应标准站姿，`height_level=3` 对应高站姿。

`posture` 是 `height_level` 的可读别名：`"low"` 对应 `1`，`"neutral"` 对应 `2`，`"tall"` 对应 `3`。

`stabilize_s` 是站立后的稳定等待窗口。它不替代状态快照验证。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

SDK 会请求机器人进入指定站立姿态，等待站立状态稳定，然后按 `stabilize_s` 保持。
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
result = Agentech.stand()
result = Agentech.stand(stabilize_s=5.0)
result = Agentech.stand(height_level=2)
result = Agentech.stand(height_level=2, stabilize_s=5.0)
result = Agentech.stand(posture="neutral")
result = Agentech.stand(posture="neutral", stabilize_s=5.0)
```
<!-- END: Example -->
