# 07_jump

## English

# Agentech.jump

**L0.5 · Movement** — Execute one approved jump motion.

## Syntax

```matlab
Agentech.jump()
Agentech.jump(HeightLevel=1)
Agentech.jump(Variant="standard", StabilizeS=5.0)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `Variant` | `standard` | approved variants | approved motion variant |
| `HeightLevel` | - | `1..3` | calibrated jump height level; mutually exclusive with `Variant` |
| `StabilizeS` | `5.0` | `0..10.0` | stabilization wait after motion |

**Behavior:** execute one approved jump motion.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** SafetyGate is implicit; `Variant` and `HeightLevel` are mutually exclusive, passing both returns `rejected(E_PROFILE_MIXED)`; omitting both executes `Variant="standard"`.

## 中文

# Agentech.jump

**L0.5 · 移动** — 执行一次已批准的跳跃动作。

## 调用形式

```matlab
Agentech.jump()
Agentech.jump(HeightLevel=1)
Agentech.jump(Variant="standard", StabilizeS=5.0)
```

## 参数

| 参数 | 默认值 | 范围 | 含义 |
|---|---|---|---|
| `Variant` | `standard` | approved variants | 已批准动作变体 |
| `HeightLevel` | - | `1..3` | 已标定的跳跃高度档位；与 `Variant` 互斥 |
| `StabilizeS` | `5.0` | `0..10.0` | 动作后稳定等待时间 |

**执行内容：**执行一次已批准的跳跃动作。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**SafetyGate 是隐式前置条件；`Variant` 和 `HeightLevel` 互斥，同时传入返回 `rejected(E_PROFILE_MIXED)`；均省略时执行 `Variant="standard"`。
