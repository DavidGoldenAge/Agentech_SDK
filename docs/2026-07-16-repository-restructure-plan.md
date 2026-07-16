# SDK Repository Restructure Plan — 2026-07-16

## Today's Objective

Make the Agentech SDK repository the internal source of truth for the SDK
catalog already shown on the company website.

The repository should own:

- the SDK function inventory;
- layer classification;
- robot support and robot-specific limits;
- parameter contracts and defaults;
- English and Chinese documentation;
- examples and reference media metadata;
- the machine-readable catalog consumed by the website.

The website should render generated repository data. It should not maintain a
second hand-written SDK catalog.

## Baseline Found Today

### Website inventory

The website's `View SDK` page currently contains its SDK catalog directly in
the frontend application bundle.

| Robot | Website reference cards |
| --- | ---: |
| Aegis | 21 |
| Navi | 37 |

### Repository inventory

| Layer | Repository contract items | Language files |
| --- | ---: | ---: |
| `L0.0` | 1 | 2 |
| `L0.5` | 12 | 24 |
| Total | 13 | 26 |

The current repository validator passes:

```text
SDK contract valid: 26 cards, deterministic mappings, and preserved TBD fields.
```

This proves that the existing 13 bilingual items are internally consistent. It
does not prove that the repository matches the website.

## Main Structural Problems

1. **Two sources of truth**
   - Website SDK data is hard-coded in the frontend.
   - Repository SDK data is stored separately in Markdown and JSON.
   - A change on one side does not automatically update the other.

2. **Robot identity is not a first-class dimension**
   - The repository is mainly organized around Aegis ZSL-1.
   - The website already exposes both Aegis and Navi.
   - Shared API names can have different limits, behavior, verification, and
     safety boundaries on each robot.

3. **The SDK layer must be the first visible repository boundary**
   - The approved top-level entries are the seven SDK layers.
   - Robot, language, category, and card placement happen inside the selected
     layer.

4. **Numbered filenames are unstable identifiers**
   - Names such as `01_forward.md` encode display order in the filename.
   - Adding or reordering capabilities can create unnecessary renames.
   - The stable identifier should be semantic, for example
     `movement.forward`.

5. **Layer naming and boundaries need one strict repository contract**
   - The approved folder sequence is `L0.0`, `L0.5`, `L1.0`, `L1.5`,
     `L2.0`, `L2.5`, and `L3.0`.
   - Folder spelling and decimal notation must be identical throughout the
     repository.
   - Layer selection must happen before website category placement.

6. **Website and repository API surfaces have drifted**
   - Website Aegis has `diagonal`, squat locomotion, `yaw`, `pitch`, `roll`,
     `stay`, and `squat`.
   - Repository Aegis has `twist` and `look`, which do not map one-to-one to the
     website names.
   - These are contract decisions, not simple file-copy decisions.

## Architecture Decision

Use a layer-first reading structure. Within each layer, organize cards by
robot namespace, language, website category, and SDK card.

Existing cards are not classified during structure construction. They first
move into `cards/Unclassify/En|Ch/`, which acts as a temporary inbox.

`ff.master` is the independent FF Master robot, whose capability testing has
not started. It is not a shared-contract namespace.

### Proposed canonical structure

```text
Agentech_SDK/
├── README.md
├── L0.0/
├── L0.5/
│   └── cards/
│       ├── ff.navi/
│       │   ├── En/
│       │   │   ├── README.md
│       │   │   ├── movement/
│       │   │   ├── athletics/
│       │   │   ├── actions/
│       │   │   ├── posture/
│       │   │   ├── configuration/
│       │   │   ├── safety/
│       │   │   └── sensing/
│       │   └── Ch/
│       │       └── <Chinese mirror>
│       ├── ff.aegis/
│       │   ├── En/
│       │   └── Ch/
│       └── ff.master/
│           ├── En/
│           └── Ch/
│       └── Unclassify/
│           ├── En/
│           └── Ch/
├── L1.0/
├── L1.5/
├── L2.0/
├── L2.5/
└── L3.0/
```

## Capability Contract Shape

Each Markdown SDK card remains the readable contract. A later manifest may
index these paths for website generation, but it must not replace the approved
layer-first reading structure.

```yaml
L0.5/cards/ff.aegis/En/movement/forward.md
L0.5/cards/ff.aegis/Ch/movement/forward.md
```

Do not populate `ff.master` from Aegis or Navi assumptions. Its cards may be
created only when FF Master source material or testing grounds the function,
layer, parameters, behavior, limits, and verification status.

## Source-of-Truth Rules

1. The seven SDK layers are the canonical repository entry points.
2. Every card path follows layer → cards → robot → language → category → card.
3. English and Chinese directories must mirror each other inside one robot and
   layer.
4. `ff.master` is an independent, currently untested robot namespace.
5. Existing unreviewed cards stay in
   `<layer>/cards/Unclassify/<language>/` until classification begins.
6. `Unclassify` is neither a robot nor a website category.
7. `generated/website/sdk-catalog.json` is built from repository sources and is
   never edited by hand.
8. The website imports the generated catalog.
9. CI fails when generated files are stale, translations reference missing
   parameters, or website and repository inventories differ.

## Website-to-Repository Reconciliation

### Aegis website inventory: 21

```text
forward
backward
lateral
diagonal
squat_forward
squat_backward
squat_lateral
squat_diagonal
turn
yaw
pitch
roll
stay
backflip
jump
stand
squat
sit
stop
emergency_stop
get_battery_status
```

### Navi website inventory: 37

```text
forward
backward
lateral
turn
crawl
jump
jump_round
jump_forward
frontflip
sideflip
kick
sway
pee
shake_hand
hip_shake
dance
stand
squat
sit
lie_down
lie_on_elbows
stand_high
recovery_stand
set_gait
set_foot_height
set_collision_protect
set_friction
set_jump_distance
set_jump_angle
stop
emergency_stop
damping
get_status
get_battery_status
body_status
joint_states
diagnose
```

### Contract decisions required before migration

| Website name | Current repository name | Decision |
| --- | --- | --- |
| `yaw` | `twist` | Decide canonical public name and alias policy. |
| `pitch` | part of `look` | Decide whether `look` remains a public composite/alias. |
| `roll` | not present as a card | Add a contract or mark unsupported. |
| `squat` | no matching repository card | Define posture semantics separately from `sit`. |
| `get_battery_status` | currently `L0.0` | Move canonically to `L0.5/sensing` with a legacy path mapping. |
| Same names on Aegis/Navi | Aegis-only repository contracts | Create separately grounded Aegis and Navi cards; do not route them through `ff.master`. |

No website item should be copied into the canonical catalog until its name,
layer, boundary, and robot grounding are explicit.

## Migration Plan

### Phase 1 — Freeze and inventory

- Export the website Aegis and Navi catalogs into a reviewable snapshot.
- Record source date and website build identifier.
- Compare every website function with repository manifests.
- Label each item `matched`, `rename`, `missing`, `conflict`, or `website-only`.

### Phase 2 — Add canonical schema without breaking old links

- Add the seven approved layer folders at the repository root.
- Inside each layer's `cards/`, add `ff.navi`, `ff.aegis`, and `ff.master`,
  then matching `En` and `Ch` directories.
- Move all existing cards into each layer's `cards/Unclassify/En|Ch/` inbox
  without deciding robot or category.
- Add legacy-to-canonical path mappings.
- Extend validation before moving existing files.

### Phase 3 — Migrate the current 13 repository contracts

- Convert each existing item to `contract.yaml`.
- Move Aegis limits and backend mappings into the Aegis robot profile.
- Preserve English and Chinese prose.
- Generate the old Markdown card layout for compatibility.

### Phase 4 — Import website-only SDK items

- Reconcile the 21 Aegis website items.
- Add the 37 Navi website items.
- Classify all direct actions, posture commands, configuration calls, and
  sensor reads as `L0.5` unless they add higher-level typed semantics.
- Mark unsupported or unverified behavior explicitly; do not infer hardware
  behavior from names.

### Phase 5 — Connect the website

- Generate `generated/website/sdk-catalog.json`.
- Replace the website's hard-coded arrays with the generated artifact.
- Show repository version and generation timestamp on the internal SDK page.
- Add a CI drift check.

### Phase 6 — Remove compatibility structure

- Remove legacy generated paths only after all internal and website consumers
  have migrated.
- Publish a path and API rename table.

## Today's Recommended Deliverables

1. Approve the canonical directory architecture.
2. Create the capability and robot-profile schemas.
3. Export the website inventory into a committed snapshot.
4. Create a reconciliation table for Aegis 21 and Navi 37.
5. Migrate one representative cross-robot API name, `movement.forward`, as
   separately grounded Aegis and Navi cards.
6. Generate one website JSON artifact from that capability.
7. Add validation proving that the generated website entry matches the
   repository contract.

Do not move all existing cards today. First prove the full pipeline with one
API name that exists on both Aegis and Navi while preserving their independent
robot contracts.

## Definition of Done

Today's restructuring work is complete when:

- one repository contract generates one website SDK entry;
- Aegis and Navi differences are represented as robot profiles;
- English and Chinese docs link to the same canonical contract;
- old card paths still resolve or are generated;
- validation catches an intentionally introduced range or inventory mismatch;
- the remaining website functions have an explicit reconciliation status.

## Memory Summary

On July 16, 2026, the approved repository reading structure became:
`SDK layer → cards → ff.navi|ff.aegis|ff.master → En|Ch → website category →
SDK card`. The repository root uses `L0.0`, `L0.5`, `L1.0`, `L1.5`, `L2.0`,
`L2.5`, and `L3.0`. English and Chinese paths must mirror each other inside
the same robot and layer. `ff.master` is the independent FF Master robot and
has not started capability testing, so it must remain unpopulated rather than
inheriting Aegis or Navi cards. Existing cards are first collected in
`cards/Unclassify/En|Ch/`; classification happens later, one card at a time,
after the complete directory structure is stable.
