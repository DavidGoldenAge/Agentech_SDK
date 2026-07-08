# 02_backward

## English

# Agentech.backward

**L0.5 · Movement** — Move backward in the robot body frame; conservative by default, with no arrival verification.

## Syntax

```matlab
Agentech.backward()
Agentech.backward(SpeedMps=0.3, DurationS=1.0)
Agentech.backward(SpeedPercent=20, DurationS=1.0)
Agentech.backward(SpeedLevel=2, DurationS=1.0)
Agentech.backward(Pace="slow", DurationS=1.0)
Agentech.backward(StepCount=2)
Agentech.backward(DistanceM=0.3, SpeedMps=0.2)
```

## Parameter Profiles

| profile | selector | auxiliary/default | range |
|---|---|---|---|
| speed-time (canonical) | `SpeedMps` (omittable, default `0.3`) | `DurationS=1.0` | `0 < SpeedMps <= 2.365`; `0 < DurationS <= 10.0` |
| percent-time | `SpeedPercent` | `DurationS=1.0` | `1..100`, relative to backward `SafeMax` |
| level-time | `SpeedLevel` | `DurationS=1.0` | `1..5` |
| pace-time | `Pace` | `DurationS=1.0` | `slow | normal | fast` |
| steps | `StepCount` | `Gait=auto`, `StepRateHz=1.5` | `1..10`; `0.5..3.0 Hz` |
| distance-speed | `DistanceM` | `SpeedMps=0.2` | `0 < DistanceM <= 3.0` |

**Behavior:** execute the selected backward profile, then controlled stop.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** at most one selector per call; omitting all selectors executes canonical defaults; `DistanceM + SpeedMps` selects `distance-speed`; mixed profiles return `rejected(E_PROFILE_MIXED)`; out-of-range values return `rejected(E_RANGE)`.

## 中文

# Agentech.backward

**L0.5 · 移动** — 沿机器人自身坐标系向后移动；默认更保守，不验证是否到达指定距离。

## 调用形式

```matlab
Agentech.backward()
Agentech.backward(SpeedMps=0.3, DurationS=1.0)
Agentech.backward(SpeedPercent=20, DurationS=1.0)
Agentech.backward(SpeedLevel=2, DurationS=1.0)
Agentech.backward(Pace="slow", DurationS=1.0)
Agentech.backward(StepCount=2)
Agentech.backward(DistanceM=0.3, SpeedMps=0.2)
```

## 参数表达

| profile | selector | 辅助参数/默认值 | 范围 |
|---|---|---|---|
| speed-time（canonical） | `SpeedMps`（可省略，默认 `0.3`） | `DurationS=1.0` | `0 < SpeedMps <= 2.365`; `0 < DurationS <= 10.0` |
| percent-time | `SpeedPercent` | `DurationS=1.0` | `1..100`，相对 backward `SafeMax` |
| level-time | `SpeedLevel` | `DurationS=1.0` | `1..5` |
| pace-time | `Pace` | `DurationS=1.0` | `slow | normal | fast` |
| steps | `StepCount` | `Gait=auto`, `StepRateHz=1.5` | `1..10`; `0.5..3.0 Hz` |
| distance-speed | `DistanceM` | `SpeedMps=0.2` | `0 < DistanceM <= 3.0` |

**执行内容：**按选定 profile 后退，结束后受控停止。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**每次调用最多一个 selector；全部省略时按 canonical 默认执行；`DistanceM + SpeedMps` 选择 `distance-speed`；混合 profile 返回 `rejected(E_PROFILE_MIXED)`，越界返回 `rejected(E_RANGE)`。
