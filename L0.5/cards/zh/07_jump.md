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
