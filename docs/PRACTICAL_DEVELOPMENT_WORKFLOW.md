# 🚀 实用开发工作流指南

**版本**: 1.0  
**创建时间**: 2025-10-26  
**适用场景**: Hugo网站内容开发与功能迭代

---

## 📋 Git提交最佳实践

### 合理的提交频率

**原则**: 按**功能完成度**提交，而非按**时间**或**文件数量**提交

```
❌ 不推荐的提交方式：
- 每改一个文件就提交
- 每小时提交一次
- 把所有工作积累到最后一次提交

✅ 推荐的提交方式：
- 完成一个完整功能后提交
- 达到一个可验证的里程碑时提交
- 一天工作结束前，完成的部分合并提交
```

### 提交粒度建议

| 开发场景 | 提交时机 | 示例 |
|---------|---------|------|
| **内容创作** | 完成整个页面的内容 | 主页全部内容完成后提交 |
| **功能开发** | 功能可用且测试通过 | 导航菜单重构完成后提交 |
| **Bug修复** | 问题解决并验证 | TOML错误修复并部署成功后提交 |
| **文档编写** | 完成一组相关文档 | 所有开发指南完成后提交 |
| **配置调整** | 配置生效且验证通过 | SEO配置优化完成后提交 |

---

## 🎯 推荐的开发工作流

### 工作流程概览

```
1. 规划阶段（不提交）
   ├─ 创建会话文件
   ├─ 制定计划
   └─ 准备素材

2. 开发阶段（本地迭代）
   ├─ 编写内容
   ├─ 本地预览
   ├─ 迭代优化
   └─ 功能测试

3. 验证阶段（本地完成）
   ├─ 完整性检查
   ├─ 质量审查
   └─ 构建测试

4. 提交阶段（一次提交）
   ├─ 暂存所有更改
   ├─ 编写清晰的提交信息
   └─ 推送到远程

5. 部署验证（远程）
   ├─ GitHub Actions构建
   ├─ 自动部署
   └─ 线上验证
```

---

## 📝 具体实施方案

### Phase 1.1 (Week 1) 建议的提交节奏

#### 方案A: 按天提交（推荐用于MVP阶段）

```
Day 1-2: 主页开发
├─ 本地开发：Hero Section + 研究亮点 + 最新动态
├─ 本地测试：./dev.sh 实时预览
├─ 本地构建：./build.sh 验证无误
└─ 提交一次：feat: complete homepage content with hero, research highlights, and news

Day 3-4: 研究方向页面
├─ 本地开发：3个研究方向详细内容
├─ 本地测试：预览效果
├─ 本地构建：确保无错误
└─ 提交一次：feat: add comprehensive research directions page

Day 5-6: 出版物导入
├─ 本地开发：导入BibTeX，创建论文页面
├─ 本地测试：检查显示效果
├─ 本地构建：验证链接
└─ 提交一次：feat: import complete publication list (40+ papers)

Day 7: 团队成员页面
├─ 本地开发：完善PI信息，添加头像
├─ 本地测试：检查布局
└─ 提交一次：feat: enhance team page with PI profile and photo
```

**结果**: Week 1 总共 **4次提交**

#### 方案B: 按里程碑提交（推荐用于稳定阶段）

```
Milestone 1: 核心内容页面（Day 1-4）
├─ 主页全部内容
├─ 研究方向页面
└─ 提交一次：feat: complete core content pages (homepage + research)

Milestone 2: 数据内容（Day 5-7）
├─ 完整出版物列表
├─ 团队成员信息
└─ 提交一次：feat: add publications and team member data
```

**结果**: Week 1 总共 **2次提交**

---

## 💻 本地开发工作流详解

### 1. 启动开发环境（仅一次）

```bash
# 早上开始工作时
cd /mnt/data/hyf/yu_lab

# 启动Hugo开发服务器（保持运行）
./dev.sh

# 服务器会持续运行，自动检测文件变化并刷新浏览器
```

### 2. 迭代式内容开发（多次，无提交）

```bash
# 编辑主页
vim website/content/_index.md
# 保存后浏览器自动刷新 ← 实时预览

# 继续编辑
vim website/content/_index.md
# 再次保存，再次预览

# 可以这样反复迭代N次，直到满意
```

**关键点**: 
- ⚡ 每次保存文件，浏览器 < 1秒 自动刷新
- 🔄 可以无限次迭代，无需重启服务器
- 💾 **不需要**每次都Git提交

### 3. 功能完成后验证（一次）

```bash
# 所有内容编辑完成后，测试生产构建
./build.sh

# 预期输出：
# ✅ Start building sites …
# ✅ Total in XXX ms
# ✅ Pages: 23

# 如果有错误，继续修改直到构建成功
```

### 4. 准备提交（一次）

```bash
# 查看修改了哪些文件
git status

# 查看具体修改内容
git diff

# 暂存所有相关文件
git add website/content/_index.md
git add website/content/research/_index.md
# 或者一次性添加所有website变更
git add website/

# 编写清晰的提交信息
git commit -m "feat: complete homepage and research pages

- Add Hero section with mission statement
- Add 3 research highlights with descriptions
- Add latest news section
- Create comprehensive research directions page
- Include 3 detailed research topics (200-300 words each)
- Link representative publications

Tested locally with hugo server and build script."

# 推送到GitHub
git push origin main
```

### 5. 远程部署验证（自动）

```bash
# 推送后，GitHub Actions自动触发
# 访问查看部署状态：
# https://github.com/AutoBrainLab/yuzhang-lab-website/actions

# 等待2-3分钟后，访问网站验证：
# https://autobrainlab.github.io/yuzhang-lab-website/
```

---

## 📊 会话日志的使用方式

### 会话文件：本地工作记录（不急于提交）

```bash
# 创建会话文件记录工作计划
vim docs/.ai-sessions/development/phase-1.1/2025-10-27-0900-phase-1.1-progress-day1.md

# 在会话文件中记录：
# - 今天的工作目标
# - 执行步骤
# - 遇到的问题
# - 解决方案
# - 最终结果

# 工作过程中持续更新会话文件（本地保存）
```

### 会话文件：适时提交到Git

```bash
# 选项1: 每天结束时提交会话文件（推荐）
git add docs/.ai-sessions/development/phase-1.1/2025-10-27-*.md
git commit -m "session: day 1 homepage development log"

# 选项2: 与功能一起提交
git add website/ docs/.ai-sessions/
git commit -m "feat: complete homepage

Session log: docs/.ai-sessions/development/phase-1.1/2025-10-27-0900-phase-1.1-progress-day1.md"

# 选项3: 一周结束统一提交所有会话文件
git add docs/.ai-sessions/development/phase-1.1/
git commit -m "session: week 1 development logs"
```

**建议**: 功能提交与会话提交**分离**，保持功能提交的清晰

---

## 🎨 实战示例：Day 1-2 主页开发

### 完整工作流程

```bash
# ==================
# 早上 9:00 - 启动
# ==================

cd /mnt/data/hyf/yu_lab

# 启动开发服务器（保持运行）
./dev.sh
# 浏览器自动打开 http://localhost:1313/yuzhang-lab-website/

# 创建今日会话文件（记录计划）
vim docs/.ai-sessions/development/phase-1.1/2025-10-27-0900-phase-1.1-progress-homepage.md

# ==================
# 9:30 - 12:00 上午工作
# ==================

# 编辑主页Hero Section
vim website/content/_index.md
# 保存 → 浏览器自动刷新 → 查看效果

# 不满意，继续修改
vim website/content/_index.md
# 保存 → 再次预览

# 满意后，继续添加研究亮点
vim website/content/_index.md
# 保存 → 预览

# ... 反复迭代多次 ...

# ==================
# 12:00 - 午休
# ==================

# 保存所有文件，无需提交
# Hugo服务器可以保持运行

# ==================
# 14:00 - 18:00 下午工作
# ==================

# 继续完善主页内容
vim website/content/_index.md
# 添加最新动态

vim website/content/_index.md
# 添加数据展示

# ... 继续迭代 ...

# ==================
# 18:00 - 完成验证
# ==================

# 1. 测试构建
./build.sh
# ✅ 输出: Total in 390 ms

# 2. 查看修改
git status
git diff website/content/_index.md

# 3. 暂存更改
git add website/content/_index.md

# 4. 提交（一天的成果）
git commit -m "feat: complete homepage content

- Add Hero section with lab mission and vision
- Add 3 research highlights with emoji icons
- Add latest news section (5 items)
- Add stats section (publications, team, collaborations)
- Add collaborators section

All content tested locally and rendering correctly."

# 5. 推送
git push origin main

# 6. 更新会话文件
vim docs/.ai-sessions/development/phase-1.1/2025-10-27-0900-phase-1.1-progress-homepage.md
# 标记任务完成，记录最终结果

# 7. 提交会话文件（可选，或周末统一提交）
git add docs/.ai-sessions/
git commit -m "session: day 1 homepage development completed"
git push origin main
```

**结果**: 一整天的工作，**1-2次Git提交**

---

## 🔧 常见场景的提交策略

### 场景1: 内容创作（主页、研究页面）

```
工作模式：
├─ 启动开发服务器
├─ 编辑内容（迭代N次）
├─ 本地预览验证
├─ 构建测试通过
└─ 提交一次（包含整个页面）

提交频率：1次/页面 或 1次/天
```

### 场景2: 数据导入（出版物BibTeX）

```
工作模式：
├─ 准备数据文件
├─ 导入并格式化
├─ 本地测试显示效果
├─ 修复格式问题（迭代）
├─ 全部验证通过
└─ 提交一次（包含数据+相关页面）

提交频率：1次/数据集
```

### 场景3: Bug修复

```
工作模式：
├─ 创建调试会话
├─ 诊断问题
├─ 尝试修复（可能多次）
├─ 本地验证通过
├─ 远程测试通过
└─ 提交一次（包含修复+会话日志）

提交频率：1次/问题
提交信息：fix: [问题描述]
```

### 场景4: 文档编写

```
工作模式：
├─ 规划文档结构
├─ 编写内容（分段完成）
├─ 本地预览
├─ 所有相关文档完成
└─ 提交一次（一组文档）

提交频率：1次/文档组 或 1次/周

示例：
- ✅ 一次提交：所有开发指南（5个文档）
- ❌ 避免：每个文档单独提交
```

---

## 📅 Week 1 推荐的提交计划

### 选项A: 每日提交（适合快速迭代）

```
Monday:
  commit: "feat: complete homepage content"
  
Tuesday:
  commit: "feat: add research directions page"
  
Wednesday:
  commit: "feat: import complete publications (40+ papers)"
  
Thursday:
  commit: "feat: enhance team page with PI profile"
  
Friday:
  commit: "session: week 1 development logs"
```

**总计**: 5次提交/周

### 选项B: 里程碑提交（适合稳定开发）

```
Monday-Wednesday:
  (本地开发：主页 + 研究页面)
  
Wednesday EOD:
  commit: "feat: complete core content pages (homepage + research)"
  
Thursday-Friday:
  (本地开发：出版物 + 团队)
  
Friday EOD:
  commit: "feat: add publications and team data"
  commit: "session: week 1 development summary"
```

**总计**: 3次提交/周

### 选项C: 批量提交（适合集中工作）

```
Monday-Friday:
  (本地持续开发所有内容)
  
Friday EOD:
  commit: "feat: complete Phase 1.1 core content
  
  - Homepage with hero, research highlights, news, stats
  - Research directions page with 3 detailed topics
  - Complete publication list (40+ papers)
  - Enhanced team page with PI profile and photo
  
  All pages tested and verified locally."
```

**总计**: 1-2次提交/周

---

## 💡 提交信息最佳实践

### Conventional Commits 规范

```
<type>(<scope>): <subject>

<body>

<footer>
```

### 常用类型

```
feat:     新功能
fix:      Bug修复
docs:     文档更新
style:    格式调整（不影响功能）
refactor: 重构代码
perf:     性能优化
test:     测试相关
chore:    构建/工具配置
session:  会话日志
content:  内容更新
```

### 好的提交信息示例

```bash
# ✅ 好的提交信息
git commit -m "feat: complete homepage with hero and research sections

- Add Hero section with mission statement and CTA buttons
- Add 3 research highlights with emoji icons and descriptions
- Add latest news section with 5 recent updates
- Add stats section showing publication count and team size
- Add collaborators section listing partner institutions

Tested locally with hugo server, build successful in 390ms."

# ✅ 好的提交信息（简洁版）
git commit -m "feat(homepage): add hero, research highlights, and news sections"

# ❌ 差的提交信息
git commit -m "update files"
git commit -m "fix"
git commit -m "WIP"
```

---

## 🎯 总结：推荐的工作方式

### 日常开发流程

1. **早上启动开发环境**
   ```bash
   ./dev.sh  # 一次启动，全天使用
   ```

2. **专注本地开发**
   - 编辑 → 保存 → 自动预览（< 1秒）
   - 迭代N次直到满意
   - **不频繁提交**

3. **阶段性验证**
   ```bash
   ./build.sh  # 测试生产构建
   ```

4. **完成后提交**
   ```bash
   git add website/
   git commit -m "feat: [清晰的功能描述]"
   git push origin main
   ```

5. **远程验证**
   - GitHub Actions自动部署
   - 访问线上网站检查

### 推荐提交频率

- **MVP开发阶段**: **1-2次/天** 或 **3-5次/周**
- **稳定维护阶段**: **1-2次/周**
- **紧急修复**: **立即提交**（但完成验证后）

### 关键原则

```
✅ DO:
- 本地充分测试后再提交
- 一次提交一个完整功能
- 编写清晰的提交信息
- 功能提交与会话分离

❌ DON'T:
- 每改一个文件就提交
- 提交未测试的代码
- 提交信息含糊不清
- 把所有工作积压到一次提交
```

---

## 🚀 立即开始

按照上述流程，您现在可以：

1. **启动开发环境**
   ```bash
   ./dev.sh
   ```

2. **开始Day 1工作**（主页开发）
   - 编辑 `website/content/_index.md`
   - 保存后立即看到效果
   - 反复迭代直到满意

3. **今天结束时提交一次**
   ```bash
   ./build.sh  # 验证
   git add website/
   git commit -m "feat: complete homepage content"
   git push origin main
   ```

**开始愉快的开发吧！** 🎉

---

**最后更新**: 2025-10-26  
**适用版本**: Phase 1.1 MVP开发
