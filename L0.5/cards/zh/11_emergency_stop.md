# Agentech.emergency_stop

**L0.5 · 安全** — 触发紧急停止并进入阻尼模式。

## 调用形式

```matlab
Agentech.emergency_stop()
Agentech.emergency_stop(Reason="low clearance", Latch=true)
```

## 参数

| 参数 | 默认值 | 范围 | 含义 |
|---|---|---|---|
| `Reason` | `"Agentech emergency stop"` | short string | 操作员可读原因 |
| `Latch` | `true` | `true | false` | 是否锁存急停状态 |
| `Mode` | `damping` | approved modes | 急停后的安全模式 |

**执行内容：**抢占任意活动调用，并进入急停阻尼状态。

**返回类型：**`SkillResult(status, trace_id, error_code, message)`

**约束：**不诊断原因，不恢复机器人，不自动继续执行。
