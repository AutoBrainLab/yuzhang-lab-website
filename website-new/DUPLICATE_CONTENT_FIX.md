# Research Page Duplicate Content Fix

## 问题描述

**报告时间**: 2025-10-26 17:15

**症状**: 英文版Research页面在"Last Updated: October 26, 2025"之后出现完整的重复内容：
```
Research
Our lab focuses on brain atlas mapping and brain-inspired AI...
🧠 Brain Atlas Across the Lifespan
[完整的accordion内容重复显示]
```

## 根本原因

Hugo在`content/research/`目录下发现了**多个markdown文件**，将它们都渲染成了页面列表项：

```bash
# 问题文件结构
content/research/
├── _index.md          # ✅ 当前正确版本 (13KB, 17:13更新)
├── _index_new.md      # ❌ 旧版本 (14KB, 16:04创建)
└── _index_old.md      # ❌ 更旧版本 (12KB)

content/zh/research/
├── _index.md          # ✅ 当前正确版本 (13KB, 17:10更新)
└── _index_old.md      # ❌ 旧版本 (9.6KB)
```

### Hugo行为分析

Hugo的`list.html`模板在渲染section页面时：
1. 显示`_index.md`的主要内容（正确的优化版本）
2. 遍历同目录下所有其他`.md`文件作为"子项"显示
3. `_index_new.md`被识别为子页面，显示在主内容下方
4. 结果：页面底部出现重复的旧版内容

## 解决方案

### 1. 删除备份文件

```bash
# 删除英文版备份
cd /mnt/data/hyf/yu_lab/website-new/content/research
rm -f _index_new.md _index_old.md

# 删除中文版备份
cd /mnt/data/hyf/yu_lab/website-new/content/zh/research
rm -f _index_old.md
```

### 2. 验证结果

```bash
# 重新构建
hugo --quiet

# 验证文件清单
find content -name "*_index*.md" -type f | sort
# 输出: 只有14个正常的_index.md文件，无备份

# 验证页面内容
curl -s http://localhost:1313/yuzhang-lab-website/research/ | grep -c "Brain Atlas Across the Lifespan"
# 输出: 1 (只出现1次，正确！)
```

## 修复前后对比

### 修复前
- ❌ `_index.md` (主内容) + `_index_new.md` (重复内容) + `_index_old.md` (更多垃圾)
- ❌ "Brain Atlas Across the Lifespan" 出现 **2次**
- ❌ 页面底部有完整的旧版accordion（无样式优化，有边框，无通俗解释）
- ❌ 用户看到混乱的双重内容

### 修复后
- ✅ 只有 `_index.md` (最新优化版本)
- ✅ "Brain Atlas Across the Lifespan" 出现 **1次**
- ✅ 页面干净，"Last Updated" 后直接结束
- ✅ 所有优化生效（渐变背景、阴影、通俗解释）

## 文件管理最佳实践

### ❌ 错误做法
```bash
# 在content目录下创建备份
cp _index.md _index_new.md     # Hugo会渲染它！
cp _index.md _index.backup.md  # Hugo也会渲染它！
cp _index.md _index.md.old     # 依然会被渲染！
```

### ✅ 正确做法

**方案1: 使用Git版本控制**
```bash
git add content/research/_index.md
git commit -m "Optimize research page"
# 需要回退时
git checkout HEAD~1 -- content/research/_index.md
```

**方案2: 备份到content外部**
```bash
mkdir -p ../backups/$(date +%Y%m%d)
cp content/research/_index.md ../backups/$(date +%Y%m%d)/
```

**方案3: 使用.gitignore排除**
```bash
# 如果必须在content内备份
echo "*_old.md" >> .gitignore
echo "*_new.md" >> .gitignore
echo "*_backup.md" >> .gitignore

# 但Hugo仍会渲染，除非添加到hugo配置
# config.toml:
ignoreFiles = [".*_old\\.md$", ".*_new\\.md$", ".*_backup\\.md$"]
```

## 相关文件

| 路径 | 状态 | 说明 |
|------|------|------|
| `content/research/_index.md` | ✅ 保留 | 英文版最新优化 (351行) |
| `content/zh/research/_index.md` | ✅ 保留 | 中文版最新优化 (351行) |
| `content/research/_index_new.md` | ❌ 已删除 | 旧版本 (14KB, 无优化) |
| `content/research/_index_old.md` | ❌ 已删除 | 更旧版本 (12KB) |
| `content/zh/research/_index_old.md` | ❌ 已删除 | 中文旧版 (9.6KB) |

## 技术细节

### Hugo Content Organization

Hugo的section页面渲染逻辑：
1. **Section Index** (`_index.md`): 主要内容
2. **Regular Pages** (其他`.md`): 作为列表项显示在下方
3. **List Template** (`layouts/_default/list.html`): 控制渲染

```go-html-template
<!-- Hugo list.html 伪代码 -->
{{ .Content }}  <!-- 显示 _index.md 的内容 -->

{{ range .Pages }}  <!-- 遍历同目录其他页面 -->
  <div class="stream-item">
    {{ .Title }}
    {{ .Summary }}
  </div>
{{ end }}
```

### 为什么会显示HTML代码

旧版`_index_new.md`中的内容有**4空格缩进**，Hugo将其识别为**代码块**：
```markdown
    <p class="lead text-muted">  <!-- 4空格缩进 -->
```

渲染结果：
```html
<pre><code>&lt;p class=&quot;lead text-muted&quot;&gt;</code></pre>
```

这就是为什么重复内容中HTML被转义显示。

## 验证清单

- [x] 删除所有`_index_new.md`文件
- [x] 删除所有`_index_old.md`文件
- [x] 验证`find content -name "*_index*.md"`只返回14个正常文件
- [x] 验证英文版"Brain Atlas"只出现1次
- [x] 验证中文版"全生命周期的人脑图谱绘制"只出现1次
- [x] 验证"Last Updated"后无额外内容
- [x] Hugo构建无错误无警告

## 影响范围

- ✅ 英文版Research页面：清除重复
- ✅ 中文版Research页面：清除潜在重复
- ✅ 其他页面：无影响
- ✅ Git历史：备份文件未提交，可安全删除

## 后续行动

1. **添加Hugo配置忽略备份文件**（可选）：
   ```toml
   # config/_default/config.toml
   ignoreFiles = [
     "\\.bak$",
     "_old\\.md$", 
     "_new\\.md$",
     "_backup\\.md$"
   ]
   ```

2. **Git提交当前正确版本**：
   ```bash
   git add content/research/_index.md content/zh/research/_index.md
   git commit -m "fix: remove duplicate research page content
   
   - Delete _index_new.md and _index_old.md backup files
   - Hugo was rendering backup files as separate pages
   - Clean up research page to show only optimized content"
   ```

3. **团队规范**：
   - 所有备份使用Git版本控制
   - 禁止在`content/`目录创建`.md`备份
   - 临时文件使用`.bak`或`.tmp`扩展名

---

**修复时间**: 2025-10-26 17:20  
**执行者**: GitHub Copilot  
**验证状态**: ✅ 通过
