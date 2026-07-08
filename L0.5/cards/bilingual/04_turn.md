# 04_turn

## English

# Agentech.turn

**L0.5 · Movement** — Rotate heading left or right; no final-heading verification.

## Syntax

```matlab
Agentech.turn(Direction="left")
Agentech.turn(Direction="right", AngleDeg=45, YawRateRadS=0.35)
Agentech.turn(Direction="left", AnglePercent=25)
Agentech.turn(Direction="right", TurnLevel=2)
Agentech.turn(Direction="left", QuarterTurns=1)
Agentech.turn(Direction="right", DurationS=1.0, YawRateRadS=0.35)
```

## Parameter Profiles

| profile | selector | auxiliary/default | range |
|---|---|---|---|
| direction | - | `Direction` required | `left | right` |
| angle-rate (canonical) | `AngleDeg` (omittable, default `45`) | `YawRateRadS=0.35` | `0 < AngleDeg <= 360`; `0.05..2.09 rad/s` |
| percent-angle | `AnglePercent` | - | `1..100`, relative to 360 deg |
| level | `TurnLevel` | - | `1..5` |
| quarter-turns | `QuarterTurns` | - | `1..4` |
| time-rate | `DurationS` | `YawRateRadS=0.35` | `0 < DurationS <= 10.0` |

**Behavior:** rotate toward `Direction`, then stop.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** `Direction` is required; at most one selector per call; omitting everything except `Direction` executes canonical defaults.

## 中文

# Agentech.turn

**L0.5 · 移动** — 向左或向右旋转机器人朝向；不验证最终航向。

## 调用形式

```matlab
Agentech.turn(Direction="left")
Agentech.turn(Direction="right", AngleDeg=45, YawRateRadS=0.35)
Agentech.turn(Direction="left", AnglePercent=25)
Agentech.turn(Direction="right", TurnLevel=2)
Agentech.turn(Direction="left", QuarterTurns=1)
Agentech.turn(Direction="right", DurationS=1.0, YawRateRadS=0.35)
```

## 参数表达

| profile | selector | 辅助参数/默认值 | 范围 |
|---|---|---|---|
| direction | - | `Direction` 必填 | `left | right` |
| angle-rate（canonical） | `AngleDeg`（可省略，默认 `45`） | `YawRateRadS=0.35` | `0 < AngleDeg <= 360`; `0.05..2.09 rad/s` |
| percent-angle | `AnglePercent` | - | `1..100`，相对 360 deg |
| level | `TurnLevel` | - | `1..5` |
| quarter-turns | `QuarterTurns` | - | `1..4` |
| time-rate | `DurationS` | `YawRateRadS=0.35` | `0 < DurationS <= 10.0` |

**执行内容：**朝 `Direction` 指定方向旋转，然后停止。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**`Direction` 必填；每次调用最多一个 selector；除 `Direction` 外全部省略时按 canonical 默认执行。
