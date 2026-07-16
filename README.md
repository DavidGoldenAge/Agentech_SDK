# Agentech Inc SDK

Agentech SDK cards define the public API contracts for three robot families:
`ff.aegis`, `ff.navi`, and `ff.master`.

The purpose of this repository is to make every SDK capability readable by two audiences at the same time:

- developers who need clear function contracts before writing code;
- code-generation agents that need stable, machine-readable sections before calling an SDK function.

Current version: `0.3.0`

## SDK Layer Entry Points

The repository starts with the SDK layer. This makes the layer boundary visible
before robot model, language, website category, or individual card.

```text
L0.0/
L0.5/
L1.0/
L1.5/
L2.0/
L2.5/
L3.0/
```

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
| One parameter truth | `profiles/aegis/zsl1.yaml` holds upstream limits and every Agentech mapping used by robot and simulator backends. |

## Strict Layer Model

Layer classification is decided before category placement. Website categories
such as `movement` or `posture` do not determine the SDK layer.

| Layer | Strict responsibility |
| --- | --- |
| `L0.0` | One raw device, driver, or telemetry read with no Agentech interpretation. |
| `L0.5` | One direct bounded SDK action, state read, configuration call, image operation, transform lookup, or adapter call. |
| `L1.0` | One narrow deterministic primitive with typed input/output, bounded side effects, and primitive-level validation or evidence. |
| `L1.5` | A reusable skill that composes multiple primitives into a typed measurement, detection, verification, localization, relation, monitoring, or planning result. |
| `L2.0` | One domain-level semantic decision using records, policy, evidence, adapters, or human review. |
| `L2.5` | A workflow or work-package layer that prepares an execution-ready plan, checklist, route package, or task bundle without completing the physical mission. |
| `L3.0` | An end-to-end business or customer mission with execution, validation, evidence, recovery, and final status. |

## Repository Structure

```text
Agentech_SDK/
├── README.md
├── L0.0/
├── L0.5/
├── L1.0/
├── L1.5/
├── L2.0/
├── L2.5/
└── L3.0/
```

Every layer follows this path order:

```text
Layer → cards → robot → language → category → SDK card
```

Cards that have not yet completed robot and category review use a temporary
staging path:

```text
Layer → cards → Unclassify → language → SDK card
```

`Unclassify` is an inbox, not an SDK category or robot. A card leaves this
directory only after its layer, robot namespace, website category, public
name, and bilingual pairing have been reviewed.

Canonical example:

```text
L0.5/
└── cards/
    ├── ff.navi/
    │   ├── En/
    │   │   ├── README.md
    │   │   ├── movement/
    │   │   ├── athletics/
    │   │   ├── actions/
    │   │   ├── posture/
    │   │   ├── configuration/
    │   │   ├── safety/
    │   │   └── sensing/
    │   └── Ch/
    │       └── <Chinese mirror>
    ├── ff.aegis/
    │   ├── En/
    │   └── Ch/
    └── ff.master/
        ├── En/
        └── Ch/
    └── Unclassify/
        ├── En/
        └── Ch/
```

Inside each robot-language directory, cards are grouped by the public
categories used by the website:

```text
movement/
posture/
safety/
sensing/
athletics/
actions/
configuration/
```

Not every robot or layer must use every category. `ff.master` has not started
testing, so its language directories remain empty except for their README
files.

Examples:

```text
L0.5/cards/ff.navi/En/athletics/jump_forward.md
L0.5/cards/ff.navi/Ch/athletics/jump_forward.md
L0.5/cards/ff.aegis/En/movement/forward.md
L0.5/cards/ff.aegis/Ch/movement/forward.md
```

## Robot Namespace Rules

| Namespace | Meaning |
| --- | --- |
| `ff.navi` | Navi-only contracts, parameters, limits, verification, and behavior. |
| `ff.aegis` | Aegis-only contracts, parameters, limits, verification, and behavior. |
| `ff.master` | FF Master robot SDK cards. This robot has not started capability testing. |

`ff.master` is an independent robot namespace, not a shared contract layer and
not an inheritance parent for Aegis or Navi.

Until FF Master testing begins:

- its seven layer folders may exist;
- no Aegis or Navi card may be copied into it as an assumed capability;
- no parameter range, default, return behavior, safety limit, or hardware
  support status may be inferred;
- future cards must be marked unverified until grounded in FF Master source
  material or physical testing.

## Card Placement Order

Every card must pass these decisions in order:

1. Assign exactly one SDK layer.
2. Put an existing unreviewed card in `cards/Unclassify/En|Ch/`.
3. Review the public name and bilingual pair.
4. Assign exactly one robot namespace: `ff.navi`, `ff.aegis`, or `ff.master`.
5. Assign one website category.
6. Move the card from `Unclassify` into its canonical robot/category path.
7. Use one stable semantic filename such as `forward.md`.

## Unclassified Card Policy

All existing cards that have not completed the new structural review live in:

```text
<Layer>/cards/Unclassify/En/
<Layer>/cards/Unclassify/Ch/
```

Do not classify a card while building the directory structure. First preserve
it in `Unclassify`; then review and migrate cards one at a time.

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

modules = extract_modules("L0.5/cards/ff.aegis/En/movement/forward.md")
print(modules["Syntax"])
```

## API Naming

Python SDK parameters use `snake_case`.

| Parameter | Meaning |
| --- | --- |
| `speed_mps` | Speed in meters per second |
| `duration_s` | Duration in seconds |
| `speed_percent` | Deterministic percentage of the public wrapper maximum |
| `yaw_rate_rad_s` | Yaw-rate magnitude in radians per second |

## Parameter Profiles

A parameter profile is one supported way to express the same SDK action. A selector parameter chooses the profile, and auxiliary parameters configure that selected profile.

```python
Agentech.forward(speed_percent=40, duration_s=1.0)
```

In this call, `speed_percent` selects the percent-time profile and resolves by the formula in `profiles/aegis/zsl1.yaml`; `duration_s` configures the command time.

Mixed selectors are rejected:

```python
Agentech.forward(speed_percent=40, speed_level=3)
```

This returns `rejected(E_PROFILE_MIXED)`.

Aliases such as `speed_level` and `pace` are Agentech product inputs. They are accepted only where the profile defines a complete numeric mapping. They are not presented as Agibot parameters or measured robot performance. Physical and simulation backends must consume the same resolved bottom-level command trace.

## TBD Parameter Policy

Previously designed parameters are not erased merely because the current Agibot source does not define them. They remain visible as `TBD`, without invented defaults, ranges, or simulator behavior. Passing a TBD parameter returns `rejected(E_TBD_PARAMETER)` before any backend command is emitted. The central list is `profiles/aegis/zsl1.yaml` under `tbd_policy`.
