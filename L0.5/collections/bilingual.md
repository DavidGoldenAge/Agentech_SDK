# 01_forward

## English

# Agentech.forward

**L0.5 · Movement** — Move forward in the robot body frame; no obstacle avoidance or arrival verification.

## Syntax

```matlab
Agentech.forward()
Agentech.forward(SpeedMps=0.3, DurationS=1.0)
Agentech.forward(SpeedPercent=30, DurationS=1.0)
Agentech.forward(SpeedLevel=3, DurationS=1.0)
Agentech.forward(Pace="normal", DurationS=1.0)
Agentech.forward(StepCount=4, StepRateHz=1.5)
Agentech.forward(DistanceM=0.5, SpeedMps=0.3)
```

## Parameter Profiles

| profile | selector | auxiliary/default | range |
|---|---|---|---|
| speed-time (canonical) | `SpeedMps` (omittable, default `0.3`) | `DurationS=1.0` | `0 < SpeedMps <= 2.37`; `0 < DurationS <= 10.0` |
| percent-time | `SpeedPercent` | `DurationS=1.0` | `1..100`, relative to forward `SafeMax` |
| level-time | `SpeedLevel` | `DurationS=1.0` | `1..5` |
| pace-time | `Pace` | `DurationS=1.0` | `slow | normal | fast` |
| steps | `StepCount` | `Gait=auto`, `StepRateHz=1.5` | `1..20`; `0.5..3.0 Hz` |
| distance-speed | `DistanceM` | `SpeedMps=0.3` | `0 < DistanceM <= 5.0` |

**Behavior:** execute the selected forward profile, then controlled stop.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** at most one selector per call; omitting all selectors executes canonical defaults; `DistanceM + SpeedMps` selects `distance-speed`; mixed profiles return `rejected(E_PROFILE_MIXED)`, out-of-range values return `rejected(E_RANGE)`.

## 中文

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
# 03_lateral

## English

# Agentech.lateral

**L0.5 · Movement** — Sidestep left or right in the robot body frame; no lateral arrival verification.

## Syntax

```matlab
Agentech.lateral(Direction="left")
Agentech.lateral(Direction="right", SpeedMps=0.2, DurationS=1.0)
Agentech.lateral(Direction="left", SpeedPercent=30, DurationS=1.0)
Agentech.lateral(Direction="left", SpeedLevel=2, DurationS=1.0)
Agentech.lateral(Direction="left", StepCount=2)
Agentech.lateral(Direction="right", DistanceM=0.3, SpeedMps=0.2)
```

## Parameter Profiles

| profile | selector | auxiliary/default | range |
|---|---|---|---|
| direction | - | `Direction` required | `left | right` |
| speed-time (canonical) | `SpeedMps` (omittable, default `0.2`) | `DurationS=1.0` | `0 < SpeedMps <= 0.78`; `0 < DurationS <= 10.0` |
| percent-time | `SpeedPercent` | `DurationS=1.0` | `1..100`, relative to lateral `SafeMax` |
| level-time | `SpeedLevel` | `DurationS=1.0` | `1..5` |
| steps | `StepCount` | `Gait=auto`, `StepRateHz=1.5` | `1..10`; `0.5..3.0 Hz` |
| distance-speed | `DistanceM` | `SpeedMps=0.2` | `0 < DistanceM <= 2.0` |

**Behavior:** sidestep toward `Direction`, then controlled stop.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** `Direction` is required and is not a selector; at most one profile selector per call; omitting everything except `Direction` executes canonical defaults; `DistanceM + SpeedMps` selects `distance-speed`.

## 中文

# Agentech.lateral

**L0.5 · 移动** — 沿机器人自身坐标系向左或向右侧移；不验证横向到达结果。

## 调用形式

```matlab
Agentech.lateral(Direction="left")
Agentech.lateral(Direction="right", SpeedMps=0.2, DurationS=1.0)
Agentech.lateral(Direction="left", SpeedPercent=30, DurationS=1.0)
Agentech.lateral(Direction="left", SpeedLevel=2, DurationS=1.0)
Agentech.lateral(Direction="left", StepCount=2)
Agentech.lateral(Direction="right", DistanceM=0.3, SpeedMps=0.2)
```

## 参数表达

| profile | selector | 辅助参数/默认值 | 范围 |
|---|---|---|---|
| direction | - | `Direction` 必填 | `left | right` |
| speed-time（canonical） | `SpeedMps`（可省略，默认 `0.2`） | `DurationS=1.0` | `0 < SpeedMps <= 0.78`; `0 < DurationS <= 10.0` |
| percent-time | `SpeedPercent` | `DurationS=1.0` | `1..100`，相对 lateral `SafeMax` |
| level-time | `SpeedLevel` | `DurationS=1.0` | `1..5` |
| steps | `StepCount` | `Gait=auto`, `StepRateHz=1.5` | `1..10`; `0.5..3.0 Hz` |
| distance-speed | `DistanceM` | `SpeedMps=0.2` | `0 < DistanceM <= 2.0` |

**执行内容：**朝 `Direction` 指定方向侧移，结束后受控停止。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**`Direction` 必填且不是 selector；每次调用最多一个 profile selector；除 `Direction` 外全部省略时按 canonical 默认执行；`DistanceM + SpeedMps` 选择 `distance-speed`。
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
# 05_twist

## English

# Agentech.twist

**L0.5 · Movement** — Twist the torso in place with feet planted.

## Syntax

```matlab
Agentech.twist(Direction="left")
Agentech.twist(Direction="right", AngleDeg=28, YawRateRadS=0.35)
Agentech.twist(Direction="left", AnglePercent=90)
Agentech.twist(Direction="right", TwistLevel=3)
Agentech.twist(Direction="left", HoldS=0.5)
```

## Parameter Profiles

| profile | selector | auxiliary/default | range |
|---|---|---|---|
| direction | - | `Direction` required | `left | right` |
| angle-rate (canonical) | `AngleDeg` (omittable, default `28`) | `YawRateRadS=0.35`, `HoldS=0` | `0 < AngleDeg <= 30`; `0.05..2.09 rad/s` |
| percent-angle | `AnglePercent` | `HoldS=0` | `1..100`, relative to 30 deg |
| level | `TwistLevel` | `HoldS=0` | `1..5` |
| hold | - | `HoldS` auxiliary | `0..3.0` |

**Behavior:** twist toward `Direction`; optionally hold after the twist.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** `HoldS` is auxiliary and may be combined with one twist profile; omitting everything except `Direction` executes canonical defaults; no translation.

## 中文

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
# 06_backflip

## English

# Agentech.backflip

**L0.5 · Movement** — Execute one approved backflip motion.

## Syntax

```matlab
Agentech.backflip()
Agentech.backflip(Variant="standard")
Agentech.backflip(Variant="standard", StabilizeS=5.0)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `Variant` | `standard` | approved variants | approved motion variant |
| `StabilizeS` | `5.0` | `0..10.0` | stabilization wait after motion |

**Behavior:** execute one approved backflip motion.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** SafetyGate is an implicit precondition; failure returns `rejected(E_SAFETY_GATE)`; no style parameters.

## 中文

# Agentech.backflip

**L0.5 · 移动** — 执行一次已批准的后空翻动作。

## 调用形式

```matlab
Agentech.backflip()
Agentech.backflip(Variant="standard")
Agentech.backflip(Variant="standard", StabilizeS=5.0)
```

## 参数

| 参数 | 默认值 | 范围 | 含义 |
|---|---|---|---|
| `Variant` | `standard` | approved variants | 已批准动作变体 |
| `StabilizeS` | `5.0` | `0..10.0` | 动作后稳定等待时间 |

**执行内容：**执行一次已批准的后空翻动作。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**SafetyGate 是隐式前置条件；未通过返回 `rejected(E_SAFETY_GATE)`；不暴露风格参数。
# 07_jump

## English

# Agentech.jump

**L0.5 · Movement** — Execute one approved jump motion.

## Syntax

```matlab
Agentech.jump()
Agentech.jump(HeightLevel=1)
Agentech.jump(Variant="standard", StabilizeS=5.0)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `Variant` | `standard` | approved variants | approved motion variant |
| `HeightLevel` | - | `1..3` | calibrated jump height level; mutually exclusive with `Variant` |
| `StabilizeS` | `5.0` | `0..10.0` | stabilization wait after motion |

**Behavior:** execute one approved jump motion.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** SafetyGate is implicit; `Variant` and `HeightLevel` are mutually exclusive, passing both returns `rejected(E_PROFILE_MIXED)`; omitting both executes `Variant="standard"`.

## 中文

# Agentech.jump

**L0.5 · 移动** — 执行一次已批准的跳跃动作。

## 调用形式

```matlab
Agentech.jump()
Agentech.jump(HeightLevel=1)
Agentech.jump(Variant="standard", StabilizeS=5.0)
```

## 参数

| 参数 | 默认值 | 范围 | 含义 |
|---|---|---|---|
| `Variant` | `standard` | approved variants | 已批准动作变体 |
| `HeightLevel` | - | `1..3` | 已标定的跳跃高度档位；与 `Variant` 互斥 |
| `StabilizeS` | `5.0` | `0..10.0` | 动作后稳定等待时间 |

**执行内容：**执行一次已批准的跳跃动作。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**SafetyGate 是隐式前置条件；`Variant` 和 `HeightLevel` 互斥，同时传入返回 `rejected(E_PROFILE_MIXED)`；均省略时执行 `Variant="standard"`。
# 08_stand

## English

# Agentech.stand

**L0.5 · Posture** — Move into a stable standing posture and hold.

## Syntax

```matlab
Agentech.stand()
Agentech.stand(StabilizeS=5.0)
Agentech.stand(HeightLevel=2)
Agentech.stand(Posture="neutral", StabilizeS=5.0)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `StabilizeS` | `5.0` | `0..10.0` | stabilization wait after standing |
| `HeightLevel` | - | `1..3` | standing height level (1=low, 2=neutral, 3=tall); mutually exclusive with `Posture` |
| `Posture` | `neutral` | `low | neutral | tall` | standing posture preset |

**Behavior:** enter standing posture and stabilize.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** `HeightLevel` and `Posture` are mutually exclusive, passing both returns `rejected(E_PROFILE_MIXED)`; omitting both uses `Posture="neutral"`; no translation.

## 中文

# Agentech.stand

**L0.5 · 姿态** — 进入稳定站立姿态并保持。

## 调用形式

```matlab
Agentech.stand()
Agentech.stand(StabilizeS=5.0)
Agentech.stand(HeightLevel=2)
Agentech.stand(Posture="neutral", StabilizeS=5.0)
```

## 参数

| 参数 | 默认值 | 范围 | 含义 |
|---|---|---|---|
| `StabilizeS` | `5.0` | `0..10.0` | 站立后稳定等待时间 |
| `HeightLevel` | - | `1..3` | 站立高度档位（1=low, 2=neutral, 3=tall）；与 `Posture` 互斥 |
| `Posture` | `neutral` | `low | neutral | tall` | 站立姿态预设 |

**执行内容：**进入站立姿态并稳定。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**`HeightLevel` 和 `Posture` 互斥，同时传入返回 `rejected(E_PROFILE_MIXED)`；均省略时使用 `Posture="neutral"`；不产生平移。
# 09_sit

## English

# Agentech.sit

**L0.5 · Posture** — Enter floor-sit damping posture.

## Syntax

```matlab
Agentech.sit()
Agentech.sit(Mode="damping")
Agentech.sit(StabilizeS=2.0)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `Mode` | `damping` | approved modes | sit/damping mode |
| `StabilizeS` | `2.0` | `0..10.0` | stabilization wait after posture change |

**Behavior:** enter floor-sit damping posture.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** requires a safe posture state; otherwise returns `rejected(E_STATE)`.

## 中文

# Agentech.sit

**L0.5 · 姿态** — 进入地面坐姿阻尼状态。

## 调用形式

```matlab
Agentech.sit()
Agentech.sit(Mode="damping")
Agentech.sit(StabilizeS=2.0)
```

## 参数

| 参数 | 默认值 | 范围 | 含义 |
|---|---|---|---|
| `Mode` | `damping` | approved modes | 坐姿/阻尼模式 |
| `StabilizeS` | `2.0` | `0..10.0` | 姿态切换后稳定等待时间 |

**执行内容：**进入地面坐姿阻尼状态。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**要求当前姿态安全；否则返回 `rejected(E_STATE)`。
# 10_stop

## English

# Agentech.stop

**L0.5 · Safety** — Stop the current motion command without entering emergency damping mode.

## Syntax

```matlab
Agentech.stop()
Agentech.stop(Mode="controlled")
Agentech.stop(DecelLevel=3)
Agentech.stop(TimeoutS=2.0)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `Mode` | `controlled` | `controlled | quick` | stop mode |
| `DecelLevel` | `3` | `1..5` | deceleration intensity |
| `TimeoutS` | `2.0` | `0.1..5.0` | stop timeout |

**Behavior:** preempt and stop the current motion command.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** timeout returns `timeout(E_TIMEOUT)`; does not auto-escalate to `emergency_stop`; escalation is the caller's decision.

## 中文

# Agentech.stop

**L0.5 · 安全** — 停止当前运动指令，但不进入急停阻尼模式。

## 调用形式

```matlab
Agentech.stop()
Agentech.stop(Mode="controlled")
Agentech.stop(DecelLevel=3)
Agentech.stop(TimeoutS=2.0)
```

## 参数

| 参数 | 默认值 | 范围 | 含义 |
|---|---|---|---|
| `Mode` | `controlled` | `controlled | quick` | 停止模式 |
| `DecelLevel` | `3` | `1..5` | 减速强度 |
| `TimeoutS` | `2.0` | `0.1..5.0` | 停止超时时间 |

**执行内容：**抢占并停止当前运动指令。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**超时返回 `timeout(E_TIMEOUT)`；不自动升级为 `emergency_stop`，由调用方决定是否升级。
# 11_emergency_stop

## English

# Agentech.emergency_stop

**L0.5 · Safety** — Trigger emergency stop and enter damping mode.

## Syntax

```matlab
Agentech.emergency_stop()
Agentech.emergency_stop(Reason="low clearance", Latch=true)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `Reason` | `"Agentech emergency stop"` | short string | operator-readable reason |
| `Latch` | `true` | `true | false` | whether the emergency state remains latched |
| `Mode` | `damping` | approved modes | safe mode after emergency stop |

**Behavior:** preempt any active call and enter emergency damping state.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** does not diagnose, recover, or resume execution.

## 中文

# Agentech.emergency_stop

**L0.5 · 安全** — 触发紧急停止并进入阻尼模式。

## 调用形式

```matlab
Agentech.emergency_stop()
Agentech.emergency_stop(Reason="low clearance", Latch=true)
```

## 参数

| 参数 | 默认值 | 范围 | 含义 |
|---|---|---|---|
| `Reason` | `"Agentech emergency stop"` | short string | 操作员可读原因 |
| `Latch` | `true` | `true | false` | 是否锁存急停状态 |
| `Mode` | `damping` | approved modes | 急停后的安全模式 |

**执行内容：**抢占任意活动调用，并进入急停阻尼状态。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**不诊断原因，不恢复机器人，不自动继续执行。
# 12_look

## English

# Agentech.look

**L0.5 · Sensing/Posture** — Tilt the body or camera up/down; does not capture images.

## Syntax

```matlab
Agentech.look(Direction="up")
Agentech.look(Direction="down", AngleDeg=15, PitchRateRadS=0.12)
Agentech.look(Target="camera", Direction="up", AngleDeg=10)
Agentech.look(Direction="down", AnglePercent=60)
Agentech.look(Direction="up", LookLevel=2)
```

## Parameter Profiles

| profile | selector | auxiliary/default | range |
|---|---|---|---|
| direction | - | `Direction` required | `up | down` |
| target | - | `Target=auto` | `auto | body | camera` |
| angle-rate (canonical) | `AngleDeg` (omittable, default `15`) | `PitchRateRadS=0.12` | `0 < AngleDeg <= 25`; `0.03..0.5 rad/s` |
| percent-angle | `AnglePercent` | - | `1..100`, relative to 25 deg |
| level | `LookLevel` | - | `1..5` |

**Behavior:** tilt the selected `Target` toward `Direction`.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** omitting everything except `Direction` and `Target` executes canonical defaults; unsupported `camera` target returns `rejected(E_UNSUPPORTED)`; no image capture.

## 中文

# Agentech.look

**L0.5 · 感知/姿态** — 向上或向下调整机身或相机俯仰；不拍摄图像。

## 调用形式

```matlab
Agentech.look(Direction="up")
Agentech.look(Direction="down", AngleDeg=15, PitchRateRadS=0.12)
Agentech.look(Target="camera", Direction="up", AngleDeg=10)
Agentech.look(Direction="down", AnglePercent=60)
Agentech.look(Direction="up", LookLevel=2)
```

## 参数表达

| profile | selector | 辅助参数/默认值 | 范围 |
|---|---|---|---|
| direction | - | `Direction` 必填 | `up | down` |
| target | - | `Target=auto` | `auto | body | camera` |
| angle-rate（canonical） | `AngleDeg`（可省略，默认 `15`） | `PitchRateRadS=0.12` | `0 < AngleDeg <= 25`; `0.03..0.5 rad/s` |
| percent-angle | `AnglePercent` | - | `1..100`，相对 25 deg |
| level | `LookLevel` | - | `1..5` |

**执行内容：**将选定 `Target` 朝 `Direction` 方向俯仰调整。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**除 `Direction`、`Target` 外全部省略时按 canonical 默认执行；不支持 `camera` 的机型返回 `rejected(E_UNSUPPORTED)`；不捕获图像。
