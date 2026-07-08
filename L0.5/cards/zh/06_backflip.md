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
