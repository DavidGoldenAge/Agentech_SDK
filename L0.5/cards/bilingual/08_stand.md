# 08_stand

## English

# Agentech.stand

**L0.5 · Posture** — Move into a stable standing posture and hold.

## Syntax

```matlab
Agentech.stand()
Agentech.stand(StabilizeS=5.0)
Agentech.stand(HeightLevel=2)
Agentech.stand(Posture="neutral", StabilizeS=5.0)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `StabilizeS` | `5.0` | `0..10.0` | stabilization wait after standing |
| `HeightLevel` | - | `1..3` | standing height level (1=low, 2=neutral, 3=tall); mutually exclusive with `Posture` |
| `Posture` | `neutral` | `low | neutral | tall` | standing posture preset |

**Behavior:** enter standing posture and stabilize.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** `HeightLevel` and `Posture` are mutually exclusive, passing both returns `rejected(E_PROFILE_MIXED)`; omitting both uses `Posture="neutral"`; no translation.

## 中文

# Agentech.stand

**L0.5 · 姿态** — 进入稳定站立姿态并保持。

## 调用形式

```matlab
Agentech.stand()
Agentech.stand(StabilizeS=5.0)
Agentech.stand(HeightLevel=2)
Agentech.stand(Posture="neutral", StabilizeS=5.0)
```

## 参数

| 参数 | 默认值 | 范围 | 含义 |
|---|---|---|---|
| `StabilizeS` | `5.0` | `0..10.0` | 站立后稳定等待时间 |
| `HeightLevel` | - | `1..3` | 站立高度档位（1=low, 2=neutral, 3=tall）；与 `Posture` 互斥 |
| `Posture` | `neutral` | `low | neutral | tall` | 站立姿态预设 |

**执行内容：**进入站立姿态并稳定。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**`HeightLevel` 和 `Posture` 互斥，同时传入返回 `rejected(E_PROFILE_MIXED)`；均省略时使用 `Posture="neutral"`；不产生平移。
