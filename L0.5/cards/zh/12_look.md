# `Agentech.look(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · Sensing/Posture** — 调整机身或相机的俯仰方向，让机器人向上或向下看。

这是姿态/感知朝向调整指令，用于改变观察方向。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.look(direction: str)
Agentech.look(direction: str, angle_deg: float, pitch_rate_rad_s: float)
Agentech.look(target: str, direction: str, angle_deg: float)
Agentech.look(direction: str, angle_percent: int)
Agentech.look(direction: str, look_level: int)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. `direction` 必填，只能是 `"up"` 或 `"down"`。
2. `target` 默认 `"auto"`，可选择 `"body"` 或 `"camera"`。
3. 每次调用最多只能使用一个选择参数：`angle_deg`、`angle_percent` 或 `look_level`。
4. 设备不支持目标 `target` 时返回 `rejected(E_UNSUPPORTED)`。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 默认反应 |
| --- | --- |
| `Agentech.look(direction=...)` | 等价于 `Agentech.look(target="auto", direction=..., angle_deg=10, pitch_rate_rad_s=0.12)` |
| `Agentech.look(direction=..., angle_deg=...)` | `target` 默认 `"auto"`，`pitch_rate_rad_s` 默认 `0.12` |
| `Agentech.look(target=..., direction=...)` | `angle_deg` 默认 `10`，`pitch_rate_rad_s` 默认 `0.12` |
| `Agentech.look(direction=..., angle_percent=...)` | `target` 默认 `"auto"` |
| `Agentech.look(direction=..., look_level=...)` | `target` 默认 `"auto"` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

### 参数模式

| 模式 | 选择参数 | 辅助参数 / 默认值 | 范围 / 规则 |
| --- | --- | --- | --- |
| direction | - | `direction` 必填 | `"up"` 或 `"down"` |
| target | - | `target="auto"` | `"auto"`、`"body"` 或 `"camera"` |
| angle-rate | `angle_deg` | `pitch_rate_rad_s=0.12` | `0 < angle_deg <= 25`; `0.03 <= pitch_rate_rad_s <= 0.5` |
| percent-angle | `angle_percent` | - | `1 <= angle_percent <= 100`，相对 `25 deg` |
| level | `look_level` | - | `look_level` 为 `1`、`2`、`3`、`4` 或 `5` |

### 参数解释

`target="auto"` 由 SDK 根据设备能力选择 body 或 camera。

`angle_deg` 是俯仰调整角度。`angle_percent=100` 对应 `25 deg`。

| `look_level` | 对应角度 |
| --- | --- |
| `1` | `5 deg` |
| `2` | `10 deg` |
| `3` | `15 deg` |
| `4` | `20 deg` |
| `5` | `25 deg` |

`look` 只调整观察方向。图像采集由 capture 类接口负责。
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

SDK 会选择目标执行器，将选定 `target` 朝 `direction` 方向调整指定俯仰角度。
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
result = Agentech.look(direction="up")
result = Agentech.look(direction="down", angle_deg=15, pitch_rate_rad_s=0.12)
result = Agentech.look(target="camera", direction="up", angle_deg=10)
result = Agentech.look(direction="down", angle_percent=60)
result = Agentech.look(direction="up", look_level=2)
```
<!-- END: Example -->
