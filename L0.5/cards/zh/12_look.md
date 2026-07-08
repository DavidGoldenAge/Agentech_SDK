# Agentech.look

**L0.5 · 感知/姿态** — 向上或向下调整机身或相机俯仰；不拍摄图像。

## 调用形式

```matlab
Agentech.look(Direction="up")
Agentech.look(Direction="down", AngleDeg=15, PitchRateRadS=0.12)
Agentech.look(Target="camera", Direction="up", AngleDeg=10)
Agentech.look(Direction="down", AnglePercent=60)
Agentech.look(Direction="up", LookLevel=2)
```

## 参数表达

| profile | selector | 辅助参数/默认值 | 范围 |
|---|---|---|---|
| direction | - | `Direction` 必填 | `up | down` |
| target | - | `Target=auto` | `auto | body | camera` |
| angle-rate（canonical） | `AngleDeg`（可省略，默认 `15`） | `PitchRateRadS=0.12` | `0 < AngleDeg <= 25`; `0.03..0.5 rad/s` |
| percent-angle | `AnglePercent` | - | `1..100`，相对 25 deg |
| level | `LookLevel` | - | `1..5` |

**执行内容：**将选定 `Target` 朝 `Direction` 方向俯仰调整。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**除 `Direction`、`Target` 外全部省略时按 canonical 默认执行；不支持 `camera` 的机型返回 `rejected(E_UNSUPPORTED)`；不捕获图像。
