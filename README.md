# Agentech SDK

This repository organizes Agentech SDK cards by development status, SDK layer,
robot, language, and website category.

## Repository Structure

```text
Agentech_SDK/
├── README.md
├── Unclassify/
│   ├── En/
│   └── Ch/
├── L0.0/
├── L0.5/
├── L1.0/
├── profiles/
└── manifest.json
```

`Unclassify/` is the top-level working inbox. Cards remain there until their
layer, robot, language, and website category are confirmed.

Formal classified cards will use:

```text
<Layer>/<robot>/<language>/<website-category>/<card>.md
```

Example:

```text
L0.5/ff.navi/En/athletics/jump_forward.md
L0.5/ff.navi/Ch/athletics/jump_forward.md
```

## SDK Layers

| Layer | Responsibility |
| --- | --- |
| `L0.0` | Raw device, driver, or telemetry read without Agentech interpretation. |
| `L0.5` | Direct bounded SDK action, state read, configuration call, image operation, transform lookup, or adapter call. |
| `L1.0` | Narrow deterministic primitive with typed input/output and bounded side effects. |

Layer classification must be decided before robot and website-category
placement.

## Robot Namespaces

| Namespace | Meaning |
| --- | --- |
| `ff.aegis` | Aegis robot SDK cards |
| `ff.navi` | Navi robot SDK cards |
| `ff.master` | FF Master robot SDK cards; testing has not started |

Do not infer FF Master capabilities from Aegis or Navi.

## Language Rule

English and Chinese cards must remain paired:

```text
En/<same-card>.md
Ch/<same-card>.md
```

Function name, layer, parameters, constraints, defaults, behavior, and return
schema must match across both languages.

## Profiles

`profiles/` stores robot-grounding data used by SDK contracts, including:

- upstream robot methods;
- command ranges and units;
- coordinate signs;
- public wrapper mappings;
- defaults and rejection rules;
- return codes and control modes;
- source provenance and unresolved `TBD` fields.

These profiles are the intended bottom-level data source for SDK definitions,
but their values still require ongoing source and hardware review.
An existing value must not be treated as accurate merely because it appears in
a profile.

## Current Status

- The Aegis `forward` and `backward` bilingual cards are classified under
  `L0.5/ff.aegis/<language>/movement/`.
- The remaining 22 card files are in `Unclassify/`.
- The current SDK layer structures are `L0.0`, `L0.5`, and `L1.0`.
- `ff.master` remains empty because testing has not started.
- Only this root README is maintained.

## 记忆总结

当前已确认 Aegis 的 `forward` 和 `backward` 属于 `L0.5/movement`，
中英文共四张卡已移入正式层级；其余 22 张卡继续放在最外层
`Unclassify/En` 和 `Unclassify/Ch` 等待逐张确认。`profiles/` 位于
最外层，保存机器人底层接口和参数依据，但其中数据仍需要继续核验和补充。
