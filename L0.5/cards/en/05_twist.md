# `Agentech.twist(parameters)`

<!-- START: Definition -->
## Definition

**L0.5 · Posture** — Twist the Aegis robot dog’s body to the left or right while standing, optionally hold the posture, then return to a stable standing posture.

Use this function to adjust the robot’s body-yaw posture without intentionally commanding locomotion. It is not a route-turning command and does not replace `Agentech.turn()`.

Angle-based twists use open-loop timing. They do not guarantee an exact measured body angle.
<!-- END: Definition -->

<!-- START: Syntax -->
## Syntax

```python
Agentech.twist(direction: str)
Agentech.twist(direction: str, angle_deg: float)
Agentech.twist(
    direction: str,
    angle_deg: float,
    yaw_rate_rad_s: float,
    hold_s: float,
    return_to_neutral: bool,
)
Agentech.twist(
    direction: str,
    duration_s: float,
    yaw_rate_rad_s: float,
    hold_s: float,
    return_to_neutral: bool,
)
```
<!-- END: Syntax -->

<!-- START: Constraints -->
## Constraints

1. `direction` is required and must be `"left"` or `"right"`.
2. Use either `angle_deg` or `duration_s`, but not both.
3. `yaw_rate_rad_s` is an auxiliary parameter and may be used with either `angle_deg` or `duration_s`.
4. `yaw_rate_rad_s` represents a positive magnitude. The SDK applies the direction separately.
5. Negative yaw-rate values return `rejected(E_RANGE)` and are not automatically converted into a direction.
6. `angle_deg` must not exceed the measured Agentech body-yaw limit of `30°`.
7. For an angle-based call, duration is estimated using `radians(angle_deg) / yaw_rate_rad_s`.
8. For a duration-based call, the estimated body-yaw change must not exceed `30°`.
9. Values outside the supported ranges return `rejected(E_RANGE)` and are not automatically adjusted.
10. Mixing incompatible parameter profiles returns `rejected(E_PROFILE_MIXED)`.
11. The robot must be standing before body-yaw posture control begins.
12. Emergency-stop state always takes precedence.
<!-- END: Constraints -->

<!-- START: Defaults -->
## Defaults

The following are Agentech wrapper defaults. Agibot does not publish default values for `attitudeControl()`.

| Parameter | Default | Meaning |
| --- | ---: | --- |
| `angle_deg` | `15°` | Half of the measured `30°` body-yaw limit |
| `yaw_rate_rad_s` | `0.1 rad/s` | Default body-yaw command rate |
| `hold_s` | `0.0 s` | No additional host-side hold |
| `return_to_neutral` | `True` | Restore a stable standing posture after the twist |

| Call | Default behavior |
| --- | --- |
| `Agentech.twist(direction=...)` | Requests an approximate `15°` body twist at `0.1 rad/s`, then returns to standing |
| `Agentech.twist(direction=..., angle_deg=...)` | `yaw_rate_rad_s=0.1`, `hold_s=0.0`, and `return_to_neutral=True` |
| `Agentech.twist(direction=..., duration_s=...)` | `yaw_rate_rad_s=0.1`, `hold_s=0.0`, and `return_to_neutral=True` |
| Any twist without `hold_s` | `hold_s` defaults to `0.0` |
| Any twist without `return_to_neutral` | `return_to_neutral` defaults to `True` |

For the default call, the estimated command duration is:

```text
duration_s = radians(15) / 0.1
           ≈ 2.618 s
```
<!-- END: Defaults -->

<!-- START: Parameters -->
## Parameters

### Parameter Profiles

| Profile | Main parameter | Additional parameters | Supported range |
| --- | --- | --- | --- |
| Direction | `direction` | Required | `"left"` or `"right"` |
| Angle and rate | `angle_deg` | `yaw_rate_rad_s=0.1` | `0 < angle_deg <= 30`; `0 < yaw_rate_rad_s <= 0.5` |
| Time and rate | `duration_s` | `yaw_rate_rad_s=0.1` | `0 < duration_s <= 10.0`; `0 < yaw_rate_rad_s <= 0.5`; estimated angle must not exceed `30°` |
| Hold | `hold_s` | `0.0` | `0 <= hold_s <= 3.0` |
| Recovery | `return_to_neutral` | `True` | Boolean |

### `direction`

Sets the body-twist direction relative to the robot’s current posture.

| Value | Body posture change |
| --- | --- |
| `"left"` | Twist the body to the robot’s left |
| `"right"` | Twist the body to the robot’s right |

The SDK uses a positive body-yaw command for `"left"` and a negative body-yaw command for `"right"`.

This sign mapping follows the Agentech body-frame convention. It should remain covered by robot integration tests because the Agibot documentation does not provide a labeled left/right `attitudeControl()` example.

### `yaw_rate_rad_s`

Sets the commanded body-yaw posture rate in radians per second.

```text
0 < yaw_rate_rad_s <= 0.5
```

Agibot publishes the native `yaw_vel` range as:

```text
-0.5 <= yaw_vel <= 0.5 rad/s
```

A value of `0` means that no yaw posture control is requested. Agibot does not publish a minimum nonzero yaw posture rate.

The public Agentech parameter is a positive magnitude. Direction determines the sign sent to the robot:

```text
left  -> +yaw_rate_rad_s
right -> -yaw_rate_rad_s
```

This parameter is sent through the Agibot posture-control interface:

```text
attitudeControl(0, 0, signed_yaw_rate_rad_s, 0)
```

### `angle_deg`

Requests an approximate body-yaw posture change in degrees.

```text
0 < angle_deg <= 30
```

The `30°` maximum is an Agentech measured body-twist limit. It is not a limit published by Agibot.

Because Agibot accepts a rate rather than an absolute angle, the SDK estimates the command duration using:

```text
duration_s = radians(angle_deg) / yaw_rate_rad_s
```

For example:

```text
angle_deg = 15
yaw_rate_rad_s = 0.1

duration_s = radians(15) / 0.1
           ≈ 2.618 s
```

This is an open-loop estimate. The SDK does not claim that the measured body angle will exactly equal `angle_deg`.

The calculated duration must not exceed `10.0` seconds. Otherwise, the call returns `rejected(E_RANGE)`.

### `duration_s`

Sets how long the body-yaw rate command remains active.

```text
0 < duration_s <= 10.0
```

The estimated body-yaw change is:

```text
estimated_angle_deg =
    duration_s × yaw_rate_rad_s × 180 / π
```

The estimated angle must not exceed the measured `30°` limit:

```text
duration_s × yaw_rate_rad_s <= radians(30)
```

For example:

```text
duration_s = 1.0
yaw_rate_rad_s = 0.5

estimated_angle_deg =
    1.0 × 0.5 × 180 / π
    ≈ 28.65°
```

The estimate describes command integration, not measured posture completion.

### `hold_s`

Sets the host-side wait after the active body-yaw command ends.

```text
0 <= hold_s <= 3.0
```

Before the hold begins, the SDK sends:

```text
attitudeControl(0, 0, 0, 0)
```

`hold_s` does not confirm that a requested angle was reached or that the body remained at an exact angle. It is not a timeout or stability check.

### `return_to_neutral`

Controls whether the SDK requests a stable standing posture after the twist and optional hold.

| Value | Behavior |
| --- | --- |
| `True` | Call `standUp()` after the twist and hold sequence |
| `False` | End after sending the zero posture-rate command |

The default is `True`.

Agibot’s example uses `standUp()` after `attitudeControl()` to return the robot to a stable state. This is a posture reset, not an inverse-rate reconstruction of the original angle.

### Measured Body-Yaw Limit

Agentech treats the following as the measured body-yaw posture envelope:

```text
-30° <= body yaw offset <= 30°
```

This is an Agentech measured safety value, not an Agibot-published mechanical specification.

### Reserved Parameters

The following parameters are reserved but are not currently supported:

| Parameter | Status |
| --- | --- |
| `angle_percent` | `TBD` — no approved percentage-to-body-angle contract is defined |
| `twist_level` | `TBD` — no verified level-to-body-angle mapping is defined |

Passing a reserved parameter returns `rejected(E_TBD_PARAMETER)` before a robot or simulator command is emitted.
<!-- END: Parameters -->

<!-- START: Behavior -->
## Behavior

The SDK first makes sure the robot is standing and ready for posture control. It then resolves the requested direction, yaw-rate magnitude, and duration.

For a left twist, the SDK sends:

```text
attitudeControl(0, 0, +yaw_rate_rad_s, 0)
```

For a right twist, it sends:

```text
attitudeControl(0, 0, -yaw_rate_rad_s, 0)
```

At the end of the requested or calculated duration, the SDK sends:

```text
attitudeControl(0, 0, 0, 0)
```

The SDK then waits for `hold_s`.

If `return_to_neutral=True`, the SDK calls:

```text
standUp()
```

to request a stable standing posture.

The call waits until the action succeeds, is rejected, is interrupted, reaches an emergency stop, or times out.

This action changes body posture. It does not intentionally command base locomotion or change the robot’s navigation route.

Robot and simulator backends must use the same signed rate, resolved duration, hold time, and recovery sequence.
<!-- END: Behavior -->

<!-- START: Return -->
## Return

```python
SkillResult(status, trace_id, error_code, message)
```

| Field | Meaning |
| --- | --- |
| `status` | Final state: `"succeeded"`, `"rejected"`, `"preempted"`, `"estopped"`, or `"timeout"` |
| `trace_id` | Command ID used to find related SDK, simulator, and device logs |
| `error_code` | `None` on success; otherwise a stable error code describing the failure |
| `message` | Developer-readable details; do not use this string for application logic |
<!-- END: Return -->

<!-- START: Example -->
## Example

```python
# Request an approximate 15-degree left body twist using Agentech defaults.
result = Agentech.twist(direction="left")

# Request an approximate 10-degree right body twist.
result = Agentech.twist(
    direction="right",
    angle_deg=10,
    yaw_rate_rad_s=0.1,
)

# Apply a left body-yaw command for 1 second.
# The estimated body-yaw change is approximately 11.46 degrees.
result = Agentech.twist(
    direction="left",
    duration_s=1.0,
    yaw_rate_rad_s=0.2,
)

# Request an approximate 20-degree left twist, hold for 0.5 seconds,
# then return to a stable standing posture.
result = Agentech.twist(
    direction="left",
    angle_deg=20,
    yaw_rate_rad_s=0.2,
    hold_s=0.5,
    return_to_neutral=True,
)

# End after the active twist without calling standUp().
result = Agentech.twist(
    direction="right",
    duration_s=0.5,
    yaw_rate_rad_s=0.1,
    hold_s=0.0,
    return_to_neutral=False,
)
```
<!-- END: Example -->
