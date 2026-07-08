# 06_backflip

## English

# Agentech.backflip

**L0.5 · Movement** — Execute one approved backflip motion.

## Syntax

```matlab
Agentech.backflip()
Agentech.backflip(Variant="standard")
Agentech.backflip(Variant="standard", StabilizeS=5.0)
```

## Parameters

| parameter | default | range | meaning |
|---|---|---|---|
| `Variant` | `standard` | approved variants | approved motion variant |
| `StabilizeS` | `5.0` | `0..10.0` | stabilization wait after motion |

**Behavior:** execute one approved backflip motion.

**Return:** `SkillResult(status, trace_id, error_code, message)`

**Constraints:** SafetyGate is an implicit precondition; failure returns `rejected(E_SAFETY_GATE)`; no style parameters.

## 中文

# Agentech.backflip

**L0.5 · 移动** — 执行一次已批准的后空翻动作。

## 调用形式

```matlab
Agentech.backflip()
Agentech.backflip(Variant="standard")
Agentech.backflip(Variant="standard", StabilizeS=5.0)
```

## 参数

| 参数 | 默认值 | 范围 | 含义 |
|---|---|---|---|
| `Variant` | `standard` | approved variants | 已批准动作变体 |
| `StabilizeS` | `5.0` | `0..10.0` | 动作后稳定等待时间 |

**执行内容：**执行一次已批准的后空翻动作。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**SafetyGate 是隐式前置条件；未通过返回 `rejected(E_SAFETY_GATE)`；不暴露风格参数。
