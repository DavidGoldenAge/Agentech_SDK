# Agentech Inc SDK

Agentech SDK cards define the public API contract for Aegis robot-dog telemetry and bounded atomic skills.

The purpose of this repository is to make every SDK capability readable by two audiences at the same time:

- developers who need clear function contracts before writing code;
- code-generation agents that need stable, machine-readable sections before calling an SDK function.

Current version: `0.2.0`

## Current Scope

| Layer | Count | Responsibility | Entry |
| --- | ---: | --- | --- |
| `L0.0` | 1 | Direct telemetry snapshot reads | `L0.0/` |
| `L0.5` | 12 | Bounded atomic movement, posture, safety, and sensing/posture skills | `L0.5/` |

English and Chinese cards are indexed in this README. Card files stay inside the layer folders.

## SDK Philosophy

Each SDK card is a contract, not a tutorial page. A card should tell a developer exactly what can be called, which parameters are legal, what defaults apply, how the robot behaves, and what the caller receives back.

The design goal is small, stable, composable capability descriptions:

| Principle | Meaning |
| --- | --- |
| Explicit layer | Every API declares the responsibility level it belongs to. |
| Small action surface | Each card describes one bounded capability. |
| Typed call shapes | `Syntax` shows callable shapes with parameter names and types. |
| No hidden defaults | `Defaults` states exactly what happens when optional parameters are omitted. |
| Stable failure model | `Constraints` and `Return` describe rejection, timeout, preemption, and emergency-stop behavior. |
| Machine extraction | HTML comments mark every card section so tools can extract modules reliably. |

## Layer Model

Agentech SDK uses level folders to keep responsibility boundaries explicit.

| Layer | Responsibility | Typical Return | Current Status |
| --- | --- | --- | --- |
| `L0.0` | Read one direct device telemetry snapshot. | Typed telemetry snapshot | Active |
| `L0.5` | Execute one bounded SDK skill or safety/posture command. | `SkillResult` | Active |
| `L1.0` | Build a narrow primitive from lower-level actions. | Typed primitive result | Planned |
| `L1.5` | Combine primitives into reusable measurement, verification, or observation. | Evidence-backed skill result | Planned |
| `L2.0` | Answer one domain-level scene question. | Domain decision | Planned |
| `L2.5` | Prepare a workflow package, route package, or checklist. | Execution-ready package | Planned |

## Repository Structure

| Path | Content |
| --- | --- |
| `L0.0/README.md` | L0.0 package index |
| `L0.0/cards/` | English and Chinese L0.0 telemetry cards |
| `L0.5/README.md` | L0.5 package index |
| `L0.5/cards/en/` | English L0.5 cards |
| `L0.5/cards/zh/` | Chinese L0.5 cards |
| `manifest.json` | Repository-level card index |
| `version history.md` | Version history |

## Card Index

English:

| # | API | Category | Card |
| ---: | --- | --- | --- |
| 00 | `Agentech.get_battery_status(parameters)` | Telemetry | `L0.0/cards/get_battery_status.en.md` |
| 01 | `Agentech.forward(parameters)` | Movement | `L0.5/cards/en/01_forward.md` |
| 02 | `Agentech.backward(parameters)` | Movement | `L0.5/cards/en/02_backward.md` |
| 03 | `Agentech.lateral(parameters)` | Movement | `L0.5/cards/en/03_lateral.md` |
| 04 | `Agentech.turn(parameters)` | Movement | `L0.5/cards/en/04_turn.md` |
| 05 | `Agentech.twist(parameters)` | Movement | `L0.5/cards/en/05_twist.md` |
| 06 | `Agentech.backflip(parameters)` | Movement | `L0.5/cards/en/06_backflip.md` |
| 07 | `Agentech.jump(parameters)` | Movement | `L0.5/cards/en/07_jump.md` |
| 08 | `Agentech.stand(parameters)` | Posture | `L0.5/cards/en/08_stand.md` |
| 09 | `Agentech.sit(parameters)` | Posture | `L0.5/cards/en/09_sit.md` |
| 10 | `Agentech.stop(parameters)` | Safety | `L0.5/cards/en/10_stop.md` |
| 11 | `Agentech.emergency_stop(parameters)` | Safety | `L0.5/cards/en/11_emergency_stop.md` |
| 12 | `Agentech.look(parameters)` | Sensing/Posture | `L0.5/cards/en/12_look.md` |

中文：

| # | API | 类别 | 卡片 |
| ---: | --- | --- | --- |
| 00 | `Agentech.get_battery_status(parameters)` | 遥测 | `L0.0/cards/get_battery_status.zh.md` |
| 01 | `Agentech.forward(parameters)` | 移动 | `L0.5/cards/zh/01_forward.md` |
| 02 | `Agentech.backward(parameters)` | 移动 | `L0.5/cards/zh/02_backward.md` |
| 03 | `Agentech.lateral(parameters)` | 移动 | `L0.5/cards/zh/03_lateral.md` |
| 04 | `Agentech.turn(parameters)` | 移动 | `L0.5/cards/zh/04_turn.md` |
| 05 | `Agentech.twist(parameters)` | 移动 | `L0.5/cards/zh/05_twist.md` |
| 06 | `Agentech.backflip(parameters)` | 移动 | `L0.5/cards/zh/06_backflip.md` |
| 07 | `Agentech.jump(parameters)` | 移动 | `L0.5/cards/zh/07_jump.md` |
| 08 | `Agentech.stand(parameters)` | 姿态 | `L0.5/cards/zh/08_stand.md` |
| 09 | `Agentech.sit(parameters)` | 姿态 | `L0.5/cards/zh/09_sit.md` |
| 10 | `Agentech.stop(parameters)` | 安全 | `L0.5/cards/zh/10_stop.md` |
| 11 | `Agentech.emergency_stop(parameters)` | 安全 | `L0.5/cards/zh/11_emergency_stop.md` |
| 12 | `Agentech.look(parameters)` | 感知/姿态 | `L0.5/cards/zh/12_look.md` |

## Card Anatomy

Every card follows the same module order:

| Module | Purpose |
| --- | --- |
| `Definition` | Layer, category, and function purpose |
| `Syntax` | Callable shapes with parameter names and types |
| `Constraints` | Legal combinations, selector rules, and rejection behavior |
| `Defaults` | Exact behavior when optional parameters are omitted |
| `Parameters` | Ranges, units, mappings, and engineering notes |
| `Behavior` | Runtime execution semantics |
| `Return` | Return type and stable fields |
| `Example` | Concrete calls with values |

Module markers are part of the contract:

```md
<!-- START: Parameters -->
## Parameters

...
<!-- END: Parameters -->
```

## Extracting Card Modules

Developers can extract a single module by marker name:

```python
from pathlib import Path
import re

MODULE_RE = re.compile(
    r"<!-- START: ([A-Za-z0-9_-]+) -->(.*?)<!-- END: \1 -->",
    re.DOTALL,
)

def extract_modules(path: str) -> dict[str, str]:
    text = Path(path).read_text(encoding="utf-8")
    return {name: body.strip() for name, body in MODULE_RE.findall(text)}

modules = extract_modules("L0.5/cards/en/01_forward.md")
print(modules["Syntax"])
```

## API Naming

Python SDK parameters use `snake_case`.

| Parameter | Meaning |
| --- | --- |
| `speed_mps` | Speed in meters per second |
| `duration_s` | Duration in seconds |
| `speed_percent` | Product-calibrated speed percentage |
| `step_rate_hz` | Step rate in hertz |

## Parameter Profiles

A parameter profile is one supported way to express the same SDK action. A selector parameter chooses the profile, and auxiliary parameters configure that selected profile.

```python
Agentech.forward(speed_percent=40, duration_s=1.0)
```

In this call, `speed_percent` selects the `percent-time` profile and `duration_s` configures that profile.

Mixed selectors are rejected:

```python
Agentech.forward(speed_percent=40, speed_level=3)
```

This returns `rejected(E_PROFILE_MIXED)`.
