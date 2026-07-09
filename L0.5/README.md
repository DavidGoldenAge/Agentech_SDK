# L0.5 Package

`L0.5` contains bounded atomic SDK skill cards for movement, posture, safety, and sensing/posture adjustment.

L0.5 cards expose direct robot actions with explicit parameter profiles, defaults, runtime behavior, and return semantics. Each card is available in English and Chinese.

## Cards

| # | API | Category | English | Chinese |
| ---: | --- | --- | --- | --- |
| 01 | `Agentech.forward(parameters)` | Movement | `cards/en/01_forward.md` | `cards/zh/01_forward.md` |
| 02 | `Agentech.backward(parameters)` | Movement | `cards/en/02_backward.md` | `cards/zh/02_backward.md` |
| 03 | `Agentech.lateral(parameters)` | Movement | `cards/en/03_lateral.md` | `cards/zh/03_lateral.md` |
| 04 | `Agentech.turn(parameters)` | Movement | `cards/en/04_turn.md` | `cards/zh/04_turn.md` |
| 05 | `Agentech.twist(parameters)` | Movement | `cards/en/05_twist.md` | `cards/zh/05_twist.md` |
| 06 | `Agentech.backflip(parameters)` | Movement | `cards/en/06_backflip.md` | `cards/zh/06_backflip.md` |
| 07 | `Agentech.jump(parameters)` | Movement | `cards/en/07_jump.md` | `cards/zh/07_jump.md` |
| 08 | `Agentech.stand(parameters)` | Posture | `cards/en/08_stand.md` | `cards/zh/08_stand.md` |
| 09 | `Agentech.sit(parameters)` | Posture | `cards/en/09_sit.md` | `cards/zh/09_sit.md` |
| 10 | `Agentech.stop(parameters)` | Safety | `cards/en/10_stop.md` | `cards/zh/10_stop.md` |
| 11 | `Agentech.emergency_stop(parameters)` | Safety | `cards/en/11_emergency_stop.md` | `cards/zh/11_emergency_stop.md` |
| 12 | `Agentech.look(parameters)` | Sensing/Posture | `cards/en/12_look.md` | `cards/zh/12_look.md` |

## Card Modules

Every card follows the same module order:

1. `Definition`
2. `Syntax`
3. `Constraints`
4. `Defaults`
5. `Parameters`
6. `Behavior`
7. `Return`
8. `Example`

## Profile Rule

Each call may select one parameter profile. The selector parameter chooses the profile, and auxiliary parameters configure that profile.

Example:

```python
Agentech.forward(speed_percent=40, duration_s=1.0)
```

`speed_percent` selects the `percent-time` profile. `duration_s` is the duration auxiliary parameter.

Mixed selectors return `rejected(E_PROFILE_MIXED)`.
