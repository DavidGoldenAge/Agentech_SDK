# Agentech Inc SDK

Agentech SDK skill-card specifications for robot-dog control, telemetry, posture, safety, and sensing.

This repository contains 13 bilingual SDK cards:

- 1 L0 telemetry card
- 12 L0.5 atomic skill cards
- English, Chinese, and bilingual Markdown versions

## Repository Structure

| path | content |
|---|---|
| `L0/` | L0 telemetry/data-read package |
| `L0.5/` | L0.5 atomic skill-card package |
| `L0.5.md` | bilingual L0.5 card file |
| `docs/` | global semantics and complete collections |
| `manifest.json` | repository index |

## L0 Package

`L0/` contains direct telemetry/data-read cards.

Current card:

- `Agentech.get_battery_status`

L0 cards read state only. They do not command motion, stream over time, make safety decisions, or schedule tasks.

## L0.5 Package

`L0.5/` contains bounded atomic skill cards.

Current cards:

- `Agentech.forward`
- `Agentech.backward`
- `Agentech.lateral`
- `Agentech.turn`
- `Agentech.twist`
- `Agentech.backflip`
- `Agentech.jump`
- `Agentech.stand`
- `Agentech.sit`
- `Agentech.stop`
- `Agentech.emergency_stop`
- `Agentech.look`

L0.5 cards are direct, bounded SDK skills. They do not perform obstacle avoidance, target selection, arrival verification, recovery, scheduling, or task planning.

## Parameter Profile Constraint

Each function may support multiple parameter profiles, but each call may select at most one profile.

Example:

```matlab
Agentech.forward(SpeedPercent=30, DurationS=1.0)
```

`SpeedPercent` selects the `percent-time` profile. `DurationS` is an auxiliary parameter.

Invalid mixed-profile call:

```matlab
Agentech.forward(SpeedPercent=30, SpeedLevel=3)
```

This returns `rejected(E_PROFILE_MIXED)`.

## Main Entry Points

| file | purpose |
|---|---|
| `L0/collections/bilingual.md` | bilingual L0 package |
| `L0.5.md` | bilingual L0.5 skill-card file |
| `L0.5/collections/bilingual.md` | bilingual L0.5 package |
| `docs/all_cards_bilingual.md` | all 13 bilingual cards |
| `docs/global_semantics_en.md` | English global execution semantics |
| `docs/global_semantics_zh.md` | Chinese global execution semantics |
