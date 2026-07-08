# Agentech.twist

**L0.5 · 移动** — 足端保持原地支撑，原地扭转躯干。

## 调用形式

```matlab
Agentech.twist(Direction="left")
Agentech.twist(Direction="right", AngleDeg=28, YawRateRadS=0.35)
Agentech.twist(Direction="left", AnglePercent=90)
Agentech.twist(Direction="right", TwistLevel=3)
Agentech.twist(Direction="left", HoldS=0.5)
```

## 参数表达

| profile | selector | 辅助参数/默认值 | 范围 |
|---|---|---|---|
| direction | - | `Direction` 必填 | `left | right` |
| angle-rate（canonical） | `AngleDeg`（可省略，默认 `28`） | `YawRateRadS=0.35`, `HoldS=0` | `0 < AngleDeg <= 30`; `0.05..2.09 rad/s` |
| percent-angle | `AnglePercent` | `HoldS=0` | `1..100`，相对 30 deg |
| level | `TwistLevel` | `HoldS=0` | `1..5` |
| hold | - | `HoldS` 辅助参数 | `0..3.0` |

**执行内容：**朝 `Direction` 指定方向扭转躯干；可在扭转后保持 `HoldS`。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**`HoldS` 是辅助参数，可与一个 twist profile 组合；除 `Direction` 外全部省略时按 canonical 默认执行；不产生平移。
