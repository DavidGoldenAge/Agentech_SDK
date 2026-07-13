# `Agentech.forward(parameters)`

<!-- START: Definition -->
Definition
L0.5 · Movement — Move the Aegis robot dog straight forward at a specified speed, for a specified duration or approximate distance, then stop.
Use this function for simple forward movement. Speed can be provided directly or expressed as a percentage, level, or named pace such as "slow", "normal", or "fast".
Distance-based movement is estimated from speed and time. It does not guarantee that the robot travels the exact requested distance.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.forward()
Agentech.forward(speed_mps: float, duration_s: float)
Agentech.forward(speed_percent: int, duration_s: float)
Agentech.forward(speed_level: int, duration_s: float)
Agentech.forward(pace: str, duration_s: float)
Agentech.forward(distance_m: float, speed_mps: float)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. Use only one speed format in each call: `speed_mps`, `speed_percent`, `speed_level`, or `pace`.
2. `distance_m` may be used only with `speed_mps`.
3. Mixing multiple speed formats returns `rejected(E_PROFILE_MIXED)`.
4. Values outside the supported ranges return `rejected(E_RANGE)` and are not automatically adjusted.
5. For distance-based movement, `distance_m / speed_mps` must not exceed `10.0` seconds.
6. The robot must be standing and ready before forward movement begins.
7. Every accepted movement ends with a controlled stop. An emergency stop always takes precedence.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

| Call | Default behavior |
| --- | --- |
| `Agentech.forward()` | Moves at `1.2 m/s` for `1.0 s` |
| `Agentech.forward(speed_mps=...)` | `duration_s` defaults to `1.0` |
| `Agentech.forward(speed_percent=...)` | `duration_s` defaults to `1.0` |
| `Agentech.forward(speed_level=...)` | `duration_s` defaults to `1.0` |
| `Agentech.forward(pace=...)` | `duration_s` defaults to `1.0` |
| `Agentech.forward(distance_m=...)` | `speed_mps` defaults to `1.2` |
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

### Parameter Profiles

| Profile | Main parameter | Additional parameter | Supported range |
| --- | --- | --- | --- |
| Speed and time | `speed_mps` | `duration_s=1.0` | `0.05 <= speed_mps <= 3.0`; `0 < duration_s <= 10.0` |
| Percentage and time | `speed_percent` | `duration_s=1.0` | Integer from `2` to `100` |
| Level and time | `speed_level` | `duration_s=1.0` | Integer from `0` to `512` |
| Pace and time | `pace` | `duration_s=1.0` | `"slow"`, `"normal"`, or `"fast"` |
| Distance and speed | `distance_m` | `speed_mps=1.2` | `0 < distance_m <= 5.0`; calculated duration must not exceed `10.0 s` |

### `speed_mps`

Sets the forward speed directly in meters per second.

The supported movement range is `0.05..3.0 m/s`.

### `speed_percent`

Sets the speed as a percentage of the maximum supported forward speed of `3.0 m/s`.

```text
speed_mps = speed_percent / 100 × 3.0
```

| `speed_percent` | Forward speed |
| ---: | ---: |
| `20` | `0.6 m/s` |
| `40` | `1.2 m/s` |
| `80` | `2.4 m/s` |
| `100` | `3.0 m/s` |

### `speed_level`

Sets the speed using an integer level from `0` to `512`.

- Level `0` means stop.
- Levels `1..512` increase evenly from `0.05 m/s` to `3.0 m/s`.

For levels `1..512`, the speed is calculated as:

```text
speed_mps = 0.05 + (speed_level - 1) × 2.95 / 511
```

| `speed_level` | Forward speed |
| ---: | ---: |
| `0` | `0.0 m/s` |
| `1` | `0.05 m/s` |
| `256` | Approximately `1.522 m/s` |
| `512` | `3.0 m/s` |

### `pace`

Sets the speed using a simple named pace.

| `pace` | Forward speed |
| --- | ---: |
| `"slow"` | `0.6 m/s` |
| `"normal"` | `1.2 m/s` |
| `"fast"` | `2.4 m/s` |

### `duration_s`

Sets how long the robot moves, in seconds.

The supported range is:

```text
0 < duration_s <= 10.0
```

If omitted from a speed-based call, it defaults to `1.0` second.

### `distance_m`

Requests an approximate forward distance in meters.

The SDK estimates the required movement time using:

```text
duration_s = distance_m / speed_mps
```

For example, `distance_m=0.5` with `speed_mps=0.25` produces a movement duration of `2.0` seconds.

This is an open-loop estimate based on the requested speed and time. The robot does not use odometry to confirm that it traveled the exact distance.

### Reserved Parameters

The following parameters are reserved but are not currently supported:

| Parameter | Status |
| --- | --- |
| `step_count` | `TBD` — step-count movement is not supported by the current robot interface |
| `step_rate_hz` | `TBD` — step-rate control is not supported by the current robot interface |
| `gait` | `TBD` — gait selection is not supported by the current robot interface |

Passing any reserved parameter returns `rejected(E_TBD_PARAMETER)` before movement begins.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK first makes sure the robot is standing and ready to move. It then converts the requested percentage, level, or pace into a forward speed and starts the movement.

The robot moves straight forward for the requested or calculated duration, then performs a controlled stop.

If `speed_level=0`, the robot does not move and receives only the stop command.

The call waits until the action succeeds, is rejected, is interrupted, reaches an emergency stop, or times out.

Robot and simulator backends use the same speed values and timing so that the same call behaves consistently in both environments.
<!-- END: Behavior -->

<!-- START: Return -->
## Return

```python
SkillResult(status, trace_id, error_code, message)
```

| Field | Meaning |
| --- | --- |
| `status` | Final state of the call: `"succeeded"`, `"rejected"`, `"preempted"`, `"estopped"`, or `"timeout"` |
| `trace_id` | Command ID used to find related SDK, simulator, and device logs |
| `error_code` | `None` on success; otherwise a stable error code describing the failure |
| `message` | Developer-readable details about the result; do not use this string for application logic |
<!-- END: Return -->

<!-- START: Example -->
## Example

```python
# Move at the default speed of 1.2 m/s for 1 second.
result = Agentech.forward()

# Move at 0.4 m/s for 1 second.
result = Agentech.forward(
    speed_mps=0.4,
    duration_s=1.0,
)

# Move at 40% of the maximum speed: 1.2 m/s.
result = Agentech.forward(
    speed_percent=40,
    duration_s=1.0,
)

# Move at level 256: approximately 1.522 m/s.
result = Agentech.forward(
    speed_level=256,
    duration_s=1.0,
)

# Move at the "fast" pace: 2.4 m/s.
result = Agentech.forward(
    pace="fast",
    duration_s=1.0,
)

# Move forward approximately 0.5 meters.
# At 0.25 m/s, the calculated duration is 2 seconds.
result = Agentech.forward(
    distance_m=0.5,
    speed_mps=0.25,
)

# Send a stop command without moving forward.
result = Agentech.forward(speed_level=0)
```
<!-- END: Example -->
