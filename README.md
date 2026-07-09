# Agentech Inc SDK

Agentech SDK card specifications for Aegis robot-dog telemetry and bounded atomic skills.

Current version: `0.2.0`

This repository contains 13 SDK cards:

| Layer | Count | Responsibility | Entry |
| --- | ---: | --- | --- |
| `L0.0` | 1 | Direct telemetry snapshot reads | `L0.0/` |
| `L0.5` | 12 | Bounded atomic movement, posture, safety, and sensing/posture skills | `L0.5/` |

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

## Layer Model

Agentech SDK uses level folders to keep API responsibility explicit.

| Layer | Definition | Typical Return |
| --- | --- | --- |
| `L0.0` | Reads one direct device telemetry snapshot. | Typed telemetry snapshot |
| `L0.5` | Executes one bounded SDK skill or safety/posture command. | `SkillResult` |
| `L1.0` | Builds a narrow primitive from lower-level actions. | Typed primitive result |
| `L1.5` | Combines primitives into reusable measurement, verification, or observation. | Evidence-backed skill result |
| `L2.0` | Answers one domain-level scene question. | Domain decision |
| `L2.5` | Prepares a workflow package, route package, or checklist. | Execution-ready package |

## Card Anatomy

Each card is written for both developers and code-generation agents. The visible sections explain the API, while stable comments let scripts extract a section without guessing.

Required modules:

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

Module markers:

```md
<!-- START: Parameters -->
## Parameters

...
<!-- END: Parameters -->
```

Extraction example:

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

## Main Entry Points

| Package | English | Chinese |
| --- | --- | --- |
| `L0.0` | `L0.0/cards/get_battery_status.en.md` | `L0.0/cards/get_battery_status.zh.md` |
| `L0.5` | `L0.5/cards/en/` | `L0.5/cards/zh/` |

## Parameter Profile Rule

A parameter profile is one supported way to express the same SDK action. A selector parameter chooses the profile, and auxiliary parameters configure that selected profile.

Example:

```python
Agentech.forward(speed_percent=40, duration_s=1.0)
```

`speed_percent` selects the `percent-time` profile. `duration_s` configures that profile.

Mixed profile example:

```python
Agentech.forward(speed_percent=40, speed_level=3)
```

This returns `rejected(E_PROFILE_MIXED)`.
