# `Agentech.forward(parameters)`

<!-- START: Definition -->
## 定义

**L0.5 · 移动** — 使用一种正向速度大小模式向前移动，并在结束时执行受控停止。

该动作采用开环控制。加速、稳定和停止过程可能导致实际移动距离或完成时间与简单计算结果不同。
<!-- END: Definition -->

<!-- START: Syntax -->
## 调用方式

```python
Agentech.forward()
Agentech.forward(speed_mps: float, duration_s: float)
Agentech.forward(distance_m: float, speed_mps: float)
Agentech.forward(speed_percent: float, duration_s: float)
Agentech.forward(speed_level: int, duration_s: float)
Agentech.forward(pace: str, duration_s: float)
Agentech.forward(step_count: int, step_rate_hz: float)         # 开发中
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## 约束

1. `speed_mps` 是正的前进速度大小；超出闭区间范围的值会被拒绝。
2. `duration_s` 必须大于 `0` 且不超过 `10` 秒。
3. `distance_m` 采用开环控制，请求距离及由此计算的完成时间都是估计值，不是保证值。
4. `speed_percent` 表示相对速度请求，不承诺对应到某个精确的米每秒数值。
5. `speed_level` 从 512 个整数档位中选择；本卡不承诺每个档位对应固定的米每秒数值。
6. `pace` 按最大支持速度的百分比解析：`slow=20%`、`normal=40%`、`fast=80%`。
7. `step_count` 和 `step_rate_hz` 仍处于开发及真机验证阶段。
<!-- END: Constraints -->

<!-- START: Defaults -->
## 默认设定

| 调用 | 默认值 |
| --- | --- |
| `Agentech.forward()` | `speed_mps=1.0`，`duration_s=1.0` |
| `Agentech.forward(speed_mps=...)` | 未填写时使用 `duration_s=1.0` |
| `Agentech.forward(step_count=...)` | 未填写时使用 `step_rate_hz=1.5`；开发中 |
<!-- END: Defaults -->

<!-- START: Parameters -->
## 参数

| 参数 | 类型 / 范围 | 含义 |
| --- | --- | --- |
| `speed_mps` | float `[0.05, 3.00]` | 直接指定正向前进速度，单位为米每秒 |
| `duration_s` | float `(0, 10]` | 保持移动指令的时间 |
| `distance_m` | float `[0, 2]` | 请求的开环移动距离 |
| `speed_percent` | float `[0, 100]` | 相对速度请求，允许小数百分比 |
| `speed_level` | int `[0, 511]` | 共 512 档：`0` 是最低运动速度档，`511` 是最高档 |
| `pace` | enum `{slow, normal, fast}` | 最大速度比例：`{slow:20%, normal:40%, fast:80%}` |
| `step_count` | int `[1, 20]` | 估计步数，不代表精确测量的足部接触次数；开发中 |
| `step_rate_hz` | float `[0.5, 3.0]` | 估计步频；开发中 |
<!-- END: Parameters -->

<!-- START: Behavior -->
## 行为

SDK 按请求时长应用所选正向速度模式；若使用距离模式，则按估计时间执行，随后受控停止。距离为 `0` 时不产生前进移动。
<!-- END: Behavior -->

<!-- START: Return -->
## 返回

```python
SkillResult(status, trace_id, error_code, message)
```

结果说明请求是成功、被拒绝、被中断还是超时。
<!-- END: Return -->

<!-- START: Example -->
## 示例

```python
Agentech.forward()
Agentech.forward(speed_mps=0.4, duration_s=1.0)
Agentech.forward(distance_m=1.0, speed_mps=0.4)
Agentech.forward(speed_percent=40, duration_s=1.0)
Agentech.forward(speed_level=100, duration_s=1.0)
Agentech.forward(pace="slow", duration_s=1.0)    # 最大速度的 20%
Agentech.forward(pace="normal", duration_s=1.0)  # 最大速度的 40%
Agentech.forward(pace="fast", duration_s=1.0)    # 最大速度的 80%
```
<!-- END: Example -->
