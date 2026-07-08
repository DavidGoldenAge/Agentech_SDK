# 09_sit

## English

# Agentech.sit

**L0.5 · Posture** — Enter floor-sit damping posture.

## Syntax

```matlab
Agentech.sit()
Agentech.sit(Mode="damping")
Agentech.sit(StabilizeS=2.0)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `Mode` | `damping` | approved modes | sit/damping mode |
| `StabilizeS` | `2.0` | `0..10.0` | stabilization wait after posture change |

**Behavior:** enter floor-sit damping posture.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** requires a safe posture state; otherwise returns `rejected(E_STATE)`.

## 中文

# Agentech.sit

**L0.5 · 姿态** — 进入地面坐姿阻尼状态。

## 调用形式

```matlab
Agentech.sit()
Agentech.sit(Mode="damping")
Agentech.sit(StabilizeS=2.0)
```

## 参数

| 参数 | 默认值 | 范围 | 含义 |
|---|---|---|---|
| `Mode` | `damping` | approved modes | 坐姿/阻尼模式 |
| `StabilizeS` | `2.0` | `0..10.0` | 姿态切换后稳定等待时间 |

**执行内容：**进入地面坐姿阻尼状态。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**要求当前姿态安全；否则返回 `rejected(E_STATE)`。
