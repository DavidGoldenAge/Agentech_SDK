# Agentech.forward

**L0.5 · 移动** — 沿机器人自身坐标系向前移动；不避障，不验证是否到达指定距离。

## 调用形式

```matlab
Agentech.forward()
Agentech.forward(SpeedMps=0.3, DurationS=1.0)
Agentech.forward(SpeedPercent=30, DurationS=1.0)
Agentech.forward(SpeedLevel=3, DurationS=1.0)
Agentech.forward(Pace="normal", DurationS=1.0)
Agentech.forward(StepCount=4, StepRateHz=1.5)
Agentech.forward(DistanceM=0.5, SpeedMps=0.3)
```

## 参数表达

| profile | selector | 辅助参数/默认值 | 范围 |
|---|---|---|---|
| speed-time（canonical） | `SpeedMps`（可省略，默认 `0.3`） | `DurationS=1.0` | `0 < SpeedMps <= 2.37`; `0 < DurationS <= 10.0` |
| percent-time | `SpeedPercent` | `DurationS=1.0` | `1..100`，相对 forward `SafeMax` |
| level-time | `SpeedLevel` | `DurationS=1.0` | `1..5` |
| pace-time | `Pace` | `DurationS=1.0` | `slow | normal | fast` |
| steps | `StepCount` | `Gait=auto`, `StepRateHz=1.5` | `1..20`; `0.5..3.0 Hz` |
| distance-speed | `DistanceM` | `SpeedMps=0.3` | `0 < DistanceM <= 5.0` |

**执行内容：**按选定 profile 前进，结束后受控停止。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**每次调用最多一个 selector；全部省略时按 canonical 默认执行；`DistanceM + SpeedMps` 选择 `distance-speed`；混合 profile 返回 `rejected(E_PROFILE_MIXED)`，越界返回 `rejected(E_RANGE)`。
