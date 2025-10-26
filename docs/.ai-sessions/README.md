# .ai-sessions 使用指南

本目录用于存储AI辅助开发过程中的所有会话日志，遵循GEMINI框架的会话驱动开发理念。

---

## 📂 目录结构

```
.ai-sessions/
├── templates/           # 会话模板文件
│   ├── progress-template.md
│   ├── content-template.md
│   ├── debug-template.md
│   ├── plan-template.md
│   ├── analysis-template.md
│   └── summary-template.md
│
├── development/         # 功能开发类会话
│   └── phase-X.Y/      # 按阶段组织
│
├── content/            # 内容创作类会话
│   ├── homepage/
│   ├── research/
│   └── publications/
│
├── debugging/          # 问题修复类会话
│
├── analysis/           # 分析优化类会话
│
├── PROGRESS_TRACKER.md # 项目进度总表
└── README.md          # 本文件
```

---

## 📝 会话文件命名规范

**格式**: `YYYY-MM-DD-HHmm-phase-X.Y-<category>-<description>.md`

**示例**:
- `2025-10-27-0900-phase-1.1-progress-homepage-dev.md`
- `2025-10-27-1430-phase-1.1-debug-build-error.md`
- `2025-10-28-1000-phase-1.1-analysis-progress-review.md`

---

## 🔖 会话类别

| 类别 | 目录 | 用途 |
|------|------|------|
| `plan` | `development/` | 阶段规划 |
| `progress` | `development/` | 日常开发进度 |
| `content` | `content/` | 内容创作记录 |
| `debug` | `debugging/` | 问题调试 |
| `test` | `development/` | 测试报告 |
| `analysis` | `analysis/` | 进度/性能分析 |
| `summary` | `development/` | 阶段总结 |

---

## 🚀 快速开始

### 创建新会话

```bash
# 1. 选择合适的模板
cp docs/.ai-sessions/templates/progress-template.md \
   docs/.ai-sessions/development/phase-1.1/2025-10-27-0900-phase-1.1-progress-day1.md

# 2. 编辑会话文件
vim docs/.ai-sessions/development/phase-1.1/2025-10-27-0900-phase-1.1-progress-day1.md

# 3. 提交到Git
git add docs/.ai-sessions/
git commit -m "session: start day 1 homepage development"
```

### 查找会话

```bash
# 查看某个阶段的所有会话
ls -lt docs/.ai-sessions/development/phase-1.1/

# 搜索调试类会话
find docs/.ai-sessions -name "*-debug-*"

# 查看最近的会话
ls -t docs/.ai-sessions/**/*.md | head -5
```

---

## 📋 当前项目状态

**当前阶段**: Phase 1.1 - Week 1 核心内容开发  
**开始日期**: 2025-10-27  
**进度**: 参见 `PROGRESS_TRACKER.md`

---

## 📚 相关文档

- [AI协作开发框架](../AI_COLLABORATION_FRAMEWORK.md) - 完整的框架说明
- [下一步开发计划](../NEXT_STEPS_DEVELOPMENT_PLAN.md) - 详细的开发路线图
- [快速行动清单](../NEXT_STEPS_ACTION_CHECKLIST.md) - MVP任务清单

---

**最后更新**: 2025-10-26
