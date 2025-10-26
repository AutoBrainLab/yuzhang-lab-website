# 🚀 下一步开发最佳实践计划

**创建时间**: 2025-10-26  
**当前状态**: MVP双语网站已完成 (6个主要页面)  
**目标**: 增强内容质量，优化用户体验，完善学术展示

---

## 📊 当前状态分析

### ✅ 已完成 (MVP v1.0)

**网站结构** (100%)
- ✅ 双语配置 (English + 中文)
- ✅ 语言切换器
- ✅ 6个主要页面 (主页、研究、团队、招聘、出版物、资源)
- ✅ 响应式导航菜单
- ✅ GitHub Pages自动部署

**内容完整度** (80%)
- ✅ 主页：实验室简介、使命、研究亮点、PI信息
- ✅ 研究：三大研究方向（含通俗解释）
- ✅ 团队：完整PI履历（300+行）
- ✅ 招聘：博士后(2-3)、科研助理(3-5)详细信息
- ✅ 出版物：40+论文指标、精选论文列表
- ✅ 资源：软件工具、数据集、外部链接

**技术质量**
- ✅ 构建时间: 120-180ms
- ✅ 零错误
- ✅ Git提交: 规范化提交信息
- ✅ 最新提交: acd02ad (职位信息修正)

### 🔄 需要优化的方面

**内容增强** (优先级)
1. **视觉素材** 🎨 P0
   - ❌ 实验室Logo
   - ❌ PI头像
   - ❌ 研究配图
   - ❌ 团队合影

2. **出版物展示** 📚 P1
   - ⚠️ 目前只有5篇样例详情页
   - ⚠️ 需要完整40+篇论文页面
   - ⚠️ 缺少分类标签系统
   - ⚠️ 缺少年份筛选功能

3. **SEO优化** 🔍 P1
   - ⚠️ 缺少meta描述
   - ⚠️ 缺少Open Graph标签
   - ⚠️ 缺少Google Scholar链接
   - ⚠️ 缺少结构化数据

4. **用户体验** ✨ P2
   - ⚠️ 缺少搜索功能
   - ⚠️ 缺少面包屑导航
   - ⚠️ 缺少返回顶部按钮
   - ⚠️ 缺少社交媒体链接

5. **功能扩展** 🚀 P3
   - ❌ 新闻/博客模块
   - ❌ 研究项目详情页
   - ❌ 课程教学页面
   - ❌ 联系表单

---

## 🎯 推荐的开发路线

### 阶段一：视觉优化 (1-2天) 🎨 **立即开始**

**目标**: 提升网站专业性和视觉吸引力

#### 任务1.1: 添加Logo和Favicon
```bash
# 创建静态资源目录
mkdir -p website/static/images/
mkdir -p website/static/favicon/

# 需要准备的文件：
# - logo.png (建议尺寸: 300x80px)
# - logo-square.png (建议尺寸: 512x512px)
# - favicon.ico (16x16, 32x32, 48x48)
# - apple-touch-icon.png (180x180px)
```

**配置更新**:
- `config/_default/params.toml`: 添加logo路径
- `layouts/partials/site_head.html`: 添加favicon链接

**提交时机**: Logo和favicon都配置完成且本地验证无误后，提交一次
```bash
git commit -m "feat: add lab logo and favicon for brand identity"
```

---

#### 任务1.2: 添加PI头像和研究配图
```bash
# 目录结构
website/static/images/
├── team/
│   └── yuzhang.jpg          # PI头像 (400x400px)
├── research/
│   ├── brain-atlas.jpg      # 研究方向1配图
│   ├── big-data.jpg         # 研究方向2配图
│   └── brain-ai.jpg         # 研究方向3配图
└── publications/
    └── featured/            # 精选论文配图
```

**内容更新**:
1. `content/people/_index.md`: 添加PI头像
2. `content/zh/people/_index.md`: 添加PI头像
3. `content/research/_index.md`: 为每个研究方向添加配图
4. `content/zh/research/_index.md`: 为每个研究方向添加配图

**提交时机**: 所有图片添加完成且页面显示正常后，提交一次
```bash
git commit -m "feat: add PI profile photo and research direction illustrations"
```

---

### 阶段二：出版物完善 (2-3天) 📚

**目标**: 展示完整学术成果，提升学术影响力展示

#### 任务2.1: 导入完整论文列表

**方法A: 从Google Scholar导出** (推荐)
```bash
# 1. 访问Google Scholar个人主页
# 2. 导出BibTeX格式
# 3. 保存到 website/data/publications.bib

# 4. 使用Hugo的data功能自动生成论文列表
# 创建模板: layouts/publications/list.html
```

**方法B: 手动创建论文页面**
```bash
# 为每篇论文创建Markdown文件
hugo new publications/author2025title.md

# 批量创建脚本
./scripts/create-publications.sh publications.csv
```

**提交时机**: 完整论文列表导入且预览正常后，提交一次
```bash
git commit -m "feat: import complete publication list (40+ papers) with BibTeX integration"
```

---

#### 任务2.2: 添加出版物分类和筛选

**实现功能**:
1. 按年份分组 (2025, 2024, 2023...)
2. 按类别标签 (Brain Atlas, AI, Clinical...)
3. 按期刊影响因子排序
4. 高被引论文高亮显示

**技术方案**:
```toml
# 在每篇论文的front matter中添加
[params]
  year = 2025
  categories = ["Brain Atlas", "Neuroimaging"]
  journal_if = 5.7
  citations = 42
  featured = true
```

**提交时机**: 分类系统实现且筛选功能正常后，提交一次
```bash
git commit -m "feat: add publication filtering by year, category, and impact"
```

---

### 阶段三：SEO和可发现性优化 (1-2天) 🔍

**目标**: 提高搜索引擎排名，增加网站流量

#### 任务3.1: 添加SEO元数据

**更新文件**: `config/_default/params.toml`
```toml
# SEO优化
[seo]
  title_suffix = " - Yu Zhang Lab | Brain Atlas & AI"
  description = "Brain Atlas and Brain-Inspired AI Laboratory led by Prof. Yu Zhang at Shanghai Jiao Tong University. Research in brain mapping, brain development, and computational neuroscience."
  keywords = ["brain atlas", "neuroimaging", "brain-inspired AI", "computational neuroscience", "fMRI"]
  
[social]
  twitter = "@YuZhangLab"  # 如果有
  google_scholar = "https://scholar.google.com/citations?user=YOUR_ID"
  github = "https://github.com/AutoBrainLab"
```

**创建sitemap和robots.txt**:
```bash
# Hugo会自动生成sitemap.xml
# 手动创建 static/robots.txt
```

**提交时机**: SEO配置完成且验证工具检查通过后，提交一次
```bash
git commit -m "feat: add comprehensive SEO metadata and social sharing tags"
```

---

#### 任务3.2: 添加Google Scholar和学术链接

**在主页和团队页面添加**:
- Google Scholar个人主页链接
- ResearchGate链接
- ORCID链接
- GitHub组织链接

**提交时机**: 所有学术链接添加完成后，提交一次
```bash
git commit -m "feat: add academic profile links (Google Scholar, ORCID, ResearchGate)"
```

---

### 阶段四：用户体验增强 (2-3天) ✨

**目标**: 改善导航和交互，提升访问体验

#### 任务4.1: 添加站内搜索

**技术方案**: 使用Fuse.js实现客户端搜索
```bash
# 1. 生成搜索索引
# layouts/_default/index.json

# 2. 添加搜索组件
# layouts/partials/search.html

# 3. 配置搜索功能
# config/_default/params.toml
[search]
  enable = true
  provider = "fuse"
```

**提交时机**: 搜索功能完整实现且测试通过后，提交一次
```bash
git commit -m "feat: implement site-wide search with Fuse.js"
```

---

#### 任务4.2: 改善导航和辅助功能

**实现功能**:
1. 面包屑导航 (Breadcrumbs)
2. 返回顶部按钮 (Back to Top)
3. 页面目录 (Table of Contents for long pages)
4. 相关内容推荐

**提交时机**: 所有导航增强完成后，提交一次
```bash
git commit -m "feat: add breadcrumbs, back-to-top, and TOC for better navigation"
```

---

### 阶段五：功能扩展 (持续进行) 🚀

**目标**: 添加动态内容，保持网站活跃度

#### 任务5.1: 创建新闻/博客模块

**目录结构**:
```bash
website/content/news/
├── _index.md
├── 2025/
│   ├── lab-opening.md
│   ├── first-paper-published.md
│   └── conference-presentation.md
└── zh/
    └── 2025/
        ├── lab-opening.md
        └── ...
```

**提交时机**: 新闻模块框架搭建完成且发布3-5篇新闻后，提交一次
```bash
git commit -m "feat: add news/blog module with initial posts"
```

---

#### 任务5.2: 添加研究项目详情页

**每个项目包含**:
- 项目名称和简介
- 研究目标和方法
- 团队成员
- 发表论文
- 项目进展时间线
- 资助来源

**提交时机**: 2-3个项目详情页完成后，提交一次
```bash
git commit -m "feat: add detailed research project pages"
```

---

## 📋 推荐的实施优先级

### 本周重点 (Week 1)

**Day 1-2: 视觉优化** 🎨 P0
```bash
□ 设计或选择实验室Logo
□ 准备PI头像 (专业证件照)
□ 添加favicon
□ 为研究方向准备配图
□ 本地测试所有图片显示
✓ 提交: feat: add visual identity (logo, photos, illustrations)
```

**Day 3-4: 出版物完善** 📚 P0
```bash
□ 从Google Scholar导出完整论文BibTeX
□ 创建或更新publications.bib
□ 为5-10篇重要论文创建详情页
□ 添加分类标签和年份属性
□ 测试论文列表和详情页显示
✓ 提交: feat: complete publication list with categorization
```

**Day 5: SEO优化** 🔍 P1
```bash
□ 配置SEO元数据
□ 添加Google Scholar等学术链接
□ 生成并验证sitemap
□ 测试社交媒体分享预览
✓ 提交: feat: add SEO optimization and academic links
```

**Day 6-7: 用户体验** ✨ P1
```bash
□ 实现站内搜索
□ 添加面包屑导航
□ 添加返回顶部按钮
□ 优化移动端体验
✓ 提交: feat: enhance navigation and search functionality
```

---

### 下周重点 (Week 2)

**内容扩展** 📝 P2
```bash
□ 创建新闻/博客模块
□ 发布实验室开业公告
□ 添加2-3个研究项目详情页
□ 准备教学/课程页面框架
✓ 提交: feat: add news module and research project details
```

**高级功能** 🚀 P3
```bash
□ 添加联系表单 (使用Formspree或类似服务)
□ 集成Google Analytics (如需要)
□ 添加评论系统 (Disqus或utterances for blog)
□ 创建RSS订阅
✓ 提交: feat: add contact form and analytics integration
```

---

## 🛠️ 开发工作流最佳实践

### 单个功能开发流程

```bash
# 1. 本地开发 (实时预览)
cd /mnt/data/hyf/yu_lab/website
hugo server -D --bind 0.0.0.0

# 2. 迭代修改 (保存即刷新)
# 在编辑器中修改内容，浏览器自动刷新

# 3. 完成后构建测试
hugo --gc

# 4. 检查构建输出
# - 无错误
# - 构建时间合理 (<500ms)
# - 页面数量正确

# 5. 提交更改
git add -A
git commit -m "feat: clear description of what was added"
git push origin main

# 6. 等待GitHub Actions部署 (~1-2分钟)

# 7. 验证线上网站
# 访问 https://autobrainlab.github.io/yuzhang-lab-website/
```

---

### Git提交信息规范

**遵循Conventional Commits**:
```bash
# 格式: <type>: <subject>

# 常用类型:
feat:     # 新功能
fix:      # Bug修复
docs:     # 文档更新
style:    # 格式调整 (不影响代码功能)
refactor: # 重构 (既不是新功能也不是Bug修复)
perf:     # 性能优化
test:     # 测试相关
chore:    # 构建/工具配置

# 示例:
git commit -m "feat: add PI profile photo and research illustrations"
git commit -m "fix: correct publication year for Li et al. 2025"
git commit -m "docs: update recruitment requirements"
git commit -m "refactor: reorganize navigation menu structure"
```

---

## 📊 质量检查清单

### 每次提交前检查

```bash
□ 本地构建无错误 (hugo --gc)
□ 所有链接有效 (hugo check)
□ 图片正常显示 (如有)
□ 双语内容一致 (EN + ZH)
□ 移动端显示正常
□ 提交信息清晰明确
□ 无敏感信息泄露 (邮箱、密钥等)
```

### 每周验证

```bash
□ 在线网站正常访问
□ GitHub Actions构建成功
□ 所有页面加载速度 <3秒
□ SEO元数据完整
□ 语言切换功能正常
□ 导航菜单在所有页面正常
```

---

## 🎯 成功指标

### MVP v1.0 达成标准 ✅ (已完成)
- [x] 6个主要页面双语版本
- [x] 完整PI履历和联系方式
- [x] 三大研究方向介绍
- [x] 招聘信息详细说明
- [x] 出版物列表和指标
- [x] 网站可稳定访问

### MVP v1.5 目标 (2周内)
- [ ] Logo和favicon
- [ ] PI头像和研究配图
- [ ] 完整40+篇论文页面
- [ ] SEO优化完成
- [ ] 站内搜索功能
- [ ] Google Scholar等学术链接

### 完整版 v2.0 目标 (1个月内)
- [ ] 新闻/博客模块
- [ ] 研究项目详情页
- [ ] 团队成员逐步添加
- [ ] 联系表单
- [ ] 访问统计
- [ ] RSS订阅

---

## 🚀 立即行动建议

### 今天可以开始的工作 (无需编程)

**1. 准备视觉素材** 🎨
```bash
□ 设计实验室Logo
  - 方案A: 使用Canva/Figma自己设计
  - 方案B: 委托设计师
  - 方案C: 使用大脑图标 + 实验室名称简洁组合

□ 准备PI头像
  - 专业证件照 (400x400px, JPG)
  - 背景纯色或虚化

□ 收集研究配图
  - 脑图谱可视化图片
  - 研究成果示意图
  - 或使用高质量免费图库 (Unsplash, Pexels)
```

**2. 整理学术资料** 📚
```bash
□ 导出Google Scholar BibTeX
  - 访问个人主页
  - 选择所有论文
  - 导出为BibTeX格式

□ 准备学术链接
  - Google Scholar URL
  - ORCID ID
  - ResearchGate URL
  - GitHub Organization URL
```

**3. 撰写新闻内容** 📝
```bash
□ 实验室成立公告
□ 招聘信息更新
□ 近期研究成果分享
□ 学术会议参会报道
```

---

## 💡 下一步行动

**立即可做** (优先级P0):
1. 准备Logo和PI头像
2. 导出Google Scholar论文列表
3. 准备3-5篇新闻稿件

**本周内完成** (优先级P1):
1. 添加所有视觉素材
2. 完善出版物展示
3. 配置SEO优化

**两周内完成** (优先级P2):
1. 实现站内搜索
2. 创建新闻模块
3. 添加研究项目页面

---

**需要我帮助开始哪个任务？建议从视觉优化开始，先创建Logo和添加PI头像！** 🚀
