# Language Filtering Issue Analysis

## 问题分析报告
**时间**: 2025-10-26 19:50

## 症状
英文版首页Latest News部分显示了中文新闻"实验室正式成立"

## 根本原因

### Hugo页面重复生成
运行`hugo list all`发现中文新闻**被生成两次**：

```
✅ 正确：
content/zh/news/2025-lab-opening.md 
→ http://localhost:1313/yuzhang-lab-website/zh/news/2025-lab-opening/
   Lang: zh, Type: news

❌ 错误：
content/zh/news/2025-lab-opening.md 
→ http://localhost:1313/yuzhang-lab-website/en/zh/news/2025-lab-opening/
   Lang: en, Type: zh  ← 注意！被当作en语言的zh section
```

### 为什么会重复？

Hugo的多语言内容识别机制：

1. **正确识别** (`defaultContentLanguageInSubdir: true`时):
   ```
   content/news/          → en语言内容
   content/zh/news/       → zh语言内容
   ```

2. **错误识别** (当语言未正确配置时):
   ```
   content/zh/news/       → 被当作en语言下的zh section
   ```

Hugo将`content/zh/`**同时解释为**：
- `zh`语言的根目录 (`/zh/news/`)
- `en`语言的`zh` section (`/en/zh/news/`)

这导致同一个文件生成两个页面！

### languages.yaml配置检查

检查`config/_default/languages.yaml`...
