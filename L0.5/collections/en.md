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
