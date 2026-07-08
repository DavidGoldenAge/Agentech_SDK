# Agentech.stop

**L0.5 · 安全** — 停止当前运动指令，但不进入急停阻尼模式。

## 调用形式

```matlab
Agentech.stop()
Agentech.stop(Mode="controlled")
Agentech.stop(DecelLevel=3)
Agentech.stop(TimeoutS=2.0)
```

## 参数

| 参数 | 默认值 | 范围 | 含义 |
|---|---|---|---|
| `Mode` | `controlled` | `controlled | quick` | 停止模式 |
| `DecelLevel` | `3` | `1..5` | 减速强度 |
| `TimeoutS` | `2.0` | `0.1..5.0` | 停止超时时间 |

**执行内容：**抢占并停止当前运动指令。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**超时返回 `timeout(E_TIMEOUT)`；不自动升级为 `emergency_stop`，由调用方决定是否升级。
