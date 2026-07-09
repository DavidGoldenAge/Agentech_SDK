# L0.0 Package

`L0.0` contains direct telemetry/data-read SDK cards.

L0.0 cards return typed state snapshots from the device layer. They are used by developers and agents that need current robot state before deciding whether to call higher-level actions.

## Cards

| API | Category | English | Chinese |
| --- | --- | --- | --- |
| `Agentech.get_battery_status(parameters)` | Telemetry | `cards/get_battery_status.en.md` | `cards/get_battery_status.zh.md` |

## Card Modules

Every card uses the same machine-readable module markers:

| Module | Meaning |
| --- | --- |
| `Definition` | What this API is responsible for |
| `Syntax` | Callable shapes and parameter types |
| `Constraints` | Rules that affect acceptance or rejection |
| `Defaults` | Behavior when optional parameters are omitted |
| `Parameters` | Field names, ranges, units, and notes |
| `Behavior` | Runtime read semantics |
| `Return` | Typed result fields |
| `Example` | Concrete calls |
