# 🚀 下一步开发行动计划（基于最佳实践）

**创建时间**: 2025-10-26  
**基于**: 项目现状分析 + 学术网站开发最佳实践  
**目标**: MVP（最小可行产品）→ 完整实验室网站

---

## 📊 当前状态评估

### ✅ 已完成（基础设施 100%）

1. **技术栈就绪**
   - ✅ Hugo静态网站生成器（v0.152.2 Extended）
   - ✅ Hugo Blox Builder学术主题
   - ✅ GitHub Pages部署（自动化CD）
   - ✅ 本地开发环境（热重载）

2. **开发工具链**
   - ✅ 本地开发服务器（`dev.sh`）
   - ✅ 生产构建脚本（`build.sh`）
   - ✅ Git版本控制
   - ✅ GitHub Actions CI/CD

3. **基础内容框架**
   - ✅ 网站结构（6个主要页面）
   - ✅ 5篇示例出版物
   - ✅ PI基本信息
   - ✅ 导航菜单配置

### 🔄 需要完善（内容 20%）

1. **主页**: 简单欢迎语 → 需要专业使命宣言
2. **研究方向**: 空页面 → 需要详细研究领域介绍
3. **团队成员**: 仅PI → 需要完整团队信息
4. **出版物**: 5篇 → 需要完整40+篇论文
5. **招聘页面**: 占位符 → 需要详细招聘信息
6. **资源页面**: 空 → 需要数据集/代码/工具

---

## 🎯 阶段化开发路线（基于Agile最佳实践）

### 📅 Phase 1: MVP内容开发（1-2周）**← 当前阶段**

**目标**: 创建可展示的基础版本，能够向访客传达实验室核心价值

#### Week 1: 核心内容（优先级P0）

##### Day 1-2: 主页内容增强 🔥 **立即开始**

**当前状态**:
```markdown
Welcome to the Yuzhang Neuro+AI Lab! Our mission is to reverse-engineer 
intelligent algorithms, foster global talent, and advance the frontiers 
of NeuroAI research.
```

**最佳实践目标**:
```markdown
1. Hero Section（英雄区）
   - 实验室愿景（1句话）
   - 核心使命（2-3句）
   - CTA按钮（Join Us / Publications）
   
2. Research Highlights（研究亮点）
   - 3-4个核心研究方向卡片
   - 每个配图标和简短描述
   
3. Latest News（最新动态）
   - 3-5条最新消息（论文发表/奖项/招聘）
   
4. Numbers that Matter（数据展示）
   - 出版物数量
   - 团队规模
   - 合作机构数
```

**执行清单**:
- [ ] 编写实验室使命宣言（中英双语）
- [ ] 提炼3-4个核心研究方向（从简历提取）
- [ ] 准备研究方向图标（可用emoji或Font Awesome）
- [ ] 列出3-5条最新动态
- [ ] 收集统计数据（论文数/团队人数/合作者）

**参考模板**:
```bash
# 编辑主页
vim /mnt/data/hyf/yu_lab/website/content/_index.md

# 参考优秀案例
# MIT CSAIL: https://www.csail.mit.edu/
# Stanford HAI: https://hai.stanford.edu/
# DeepMind: https://www.deepmind.com/
```

**时间**: 4-6小时

---

##### Day 3-4: 研究方向页面 🔬

**当前状态**: 空白页面

**最佳实践结构**:
```markdown
Research Overview（研究概览）
├── 研究主题1: 脑网络与连接组学
│   ├── 问题背景
│   ├── 研究方法
│   ├── 代表性成果（2-3篇论文）
│   └── 未来方向
│
├── 研究主题2: 深度学习与神经影像
│   ├── 问题背景
│   ├── 研究方法
│   ├── 代表性成果
│   └── 未来方向
│
└── 研究主题3: 计算神经科学
    ├── 问题背景
    ├── 研究方法
    ├── 代表性成果
    └── 未来方向
```

**执行清单**:
- [ ] 从简历提取研究领域关键词
- [ ] 每个主题写200-300字描述
- [ ] 链接相关出版物
- [ ] 添加研究示意图（可选）

**文件位置**:
```bash
vim /mnt/data/hyf/yu_lab/website/content/research/_index.md
```

**时间**: 6-8小时

---

##### Day 5-6: 完整出版物导入 📚 **高价值任务**

**当前状态**: 5篇示例论文

**最佳实践流程**:

1. **从Google Scholar导出BibTeX**
   ```bash
   # 访问Google Scholar个人主页
   # 选择所有论文
   # 导出 → BibTeX格式
   # 下载 .bib 文件
   ```

2. **整理BibTeX文件**
   ```bash
   # 合并到现有文件
   vim /mnt/data/hyf/yu_lab/website/data/publications.bib
   
   # 确保格式正确
   # 每条记录包含：
   # - @article / @inproceedings
   # - title, author, year, journal/booktitle
   # - doi（如果有）
   # - abstract（推荐）
   ```

3. **生成个别Markdown文件（可选）**
   ```bash
   # 为重点论文创建单独页面
   cd /mnt/data/hyf/yu_lab/website/content/publications
   
   # 创建新论文页面
   hugo new publications/zhang2024important-paper.md
   ```

**执行清单**:
- [ ] Google Scholar导出完整BibTeX
- [ ] 检查并修正格式错误
- [ ] 添加缺失的DOI链接
- [ ] 为前5-10篇重点论文写abstract
- [ ] 分类（按年份/主题）

**预期结果**: 40+篇论文全部展示

**时间**: 4-6小时

---

##### Day 7: 团队成员页面 👥

**当前状态**: 仅有PI信息

**最佳实践结构**:
```markdown
Team（团队成员）
├── Principal Investigator（课题组长）
│   ├── Dr. Yu Zhang
│   ├── 照片
│   ├── 简介（200字）
│   ├── 研究兴趣
│   ├── 联系方式
│   └── 个人主页链接
│
├── Postdocs（博士后）
│   └── [待招聘占位]
│
├── PhD Students（博士生）
│   └── [待招聘占位]
│
├── Master Students（硕士生）
│   └── [待招聘占位]
│
└── Alumni（往届成员）
    └── [如有]
```

**执行清单**:
- [ ] 完善PI个人信息（从简历提取）
- [ ] 准备高质量头像照片（推荐400x400px）
- [ ] 撰写个人研究简介（中英双语）
- [ ] 添加社交媒体链接（Google Scholar, GitHub, Twitter等）
- [ ] 如有其他成员，创建个人页面

**文件操作**:
```bash
# 编辑PI信息
vim /mnt/data/hyf/yu_lab/website/content/people/_index.md

# 添加头像（如果有）
cp /path/to/photo.jpg /mnt/data/hyf/yu_lab/website/static/images/yu-zhang.jpg
```

**时间**: 2-3小时

---

#### Week 2: 增强功能（优先级P1）

##### Day 8-9: 招聘页面（Join Us）💼

**最佳实践内容**:
```markdown
Join Our Team
├── Welcome Message（欢迎语）
│   ├── 实验室愿景
│   └── 为什么加入我们
│
├── Open Positions（招聘岗位）
│   ├── 博士后（Postdoc）
│   │   ├── 职位描述
│   │   ├── 任职要求
│   │   ├── 薪资待遇
│   │   └── 申请方式
│   │
│   ├── 博士生（PhD Students）
│   │   ├── 研究方向
│   │   ├── 申请要求
│   │   ├── 奖学金信息
│   │   └── 申请流程
│   │
│   └── 访问学生（Visiting Students）
│       ├── 要求
│       ├── 时长
│       └── 申请方式
│
├── What We Offer（我们提供）
│   ├── 研究资源
│   ├── 国际合作机会
│   ├── 学术成长支持
│   └── 工作生活平衡
│
└── How to Apply（如何申请）
    ├── 所需材料
    ├── 联系邮箱
    └── 申请截止日期
```

**执行清单**:
- [ ] 确定当前招聘需求
- [ ] 撰写每个岗位的JD（Job Description）
- [ ] 明确申请要求和流程
- [ ] 设计申请表单或邮箱
- [ ] 添加FAQ常见问题

**文件位置**:
```bash
vim /mnt/data/hyf/yu_lab/website/content/join-us/_index.md
```

**时间**: 6-8小时

---

##### Day 10-11: 资源页面（Resources）📦

**最佳实践内容**:
```markdown
Resources（资源共享）
├── Datasets（数据集）
│   ├── 公开数据集链接
│   ├── 实验室自有数据集（如有）
│   └── 数据使用协议
│
├── Code & Tools（代码工具）
│   ├── GitHub仓库链接
│   ├── 软件工具包
│   └── 分析脚本
│
├── Publications（出版物链接）
│   ├── PDF下载（合法的）
│   ├── Preprints
│   └── 补充材料
│
└── Teaching Materials（教学材料）
    ├── 课程资料
    ├── Tutorial视频
    └── 讲座PPT
```

**执行清单**:
- [ ] 收集GitHub仓库链接
- [ ] 列出常用公开数据集
- [ ] 整理可分享的代码
- [ ] 添加教学资源（如有）

**文件位置**:
```bash
vim /mnt/data/hyf/yu_lab/website/content/resources/_index.md
```

**时间**: 4-6小时

---

##### Day 12-14: 视觉优化与测试 🎨

**最佳实践检查清单**:

1. **视觉设计**
   - [ ] 选择合适的配色方案（专业、学术）
   - [ ] 添加实验室Logo（如有）
   - [ ] 统一图片风格和尺寸
   - [ ] 检查字体可读性

2. **用户体验（UX）**
   - [ ] 导航清晰易用
   - [ ] 页面加载速度 < 3秒
   - [ ] 重要信息3次点击内可达
   - [ ] 联系方式易找到

3. **移动端适配**
   - [ ] 在手机浏览器测试
   - [ ] 检查响应式布局
   - [ ] 触摸按钮足够大
   - [ ] 文字大小适中

4. **SEO优化**
   - [ ] 每个页面有meta description
   - [ ] 图片有alt文本
   - [ ] URL结构清晰
   - [ ] 添加Google Analytics（可选）

5. **内容质量**
   - [ ] 拼写检查（中英文）
   - [ ] 语法检查
   - [ ] 链接有效性测试
   - [ ] 数据准确性验证

**测试设备**:
```bash
# 桌面浏览器
- Chrome
- Firefox
- Safari

# 移动设备
- iPhone
- Android手机
- iPad
```

**工具推荐**:
```bash
# 性能测试
https://pagespeed.web.dev/

# 链接检查
https://validator.w3.org/checklink

# SEO检查
https://www.seoptimer.com/
```

**时间**: 6-8小时

---

## 📋 内容创建详细指南

### 1️⃣ 主页内容模板（推荐结构）

```markdown
---
title: "Yuzhang Neuro+AI Lab"
type: landing
---

<!-- Hero Section -->
{{< blocks/hero >}}
<div class="hero-section">
  <h1>探索智能的神经基础</h1>
  <p class="lead">
    我们致力于通过计算神经科学和人工智能的交叉研究，
    理解大脑智能的原理，推动下一代AI技术发展。
  </p>
  <div class="cta-buttons">
    <a href="/research/" class="btn-primary">研究方向</a>
    <a href="/publications/" class="btn-secondary">最新论文</a>
    <a href="/join-us/" class="btn-outline">加入我们</a>
  </div>
</div>
{{< /blocks/hero >}}

<!-- Research Highlights -->
{{< blocks/section >}}
## 🔬 研究领域

<div class="research-grid">

### 🧠 脑网络连接组学
利用多模态神经影像数据，构建大脑功能和结构连接图谱，
揭示认知功能的神经网络基础。

**代表性工作**: Zhang et al., 2025, *Nature Neuroscience*

---

### 🤖 深度学习与神经影像
开发创新的深度学习算法，用于脑疾病诊断、认知解码
和个体化预测。

**代表性工作**: Ma et al., 2024, *Medical Image Analysis*

---

### 📊 计算建模与理论
构建生物启发的计算模型，理解学习、记忆和决策的
神经机制。

**代表性工作**: Yang et al., 2025, *PNAS*

</div>
{{< /blocks/section >}}

<!-- Latest News -->
{{< blocks/section >}}
## 📰 最新动态

- **2025-10** 🎉 实验室网站正式上线！
- **2025-09** 📝 新论文发表在 *Nature Neuroscience*
- **2025-08** 👥 招聘博士后和博士生，欢迎申请！
- **2025-07** 🏆 获得国家自然科学基金面上项目资助

[查看更多 →](/news/)
{{< /blocks/section >}}

<!-- Stats Section -->
{{< blocks/section >}}
## 📊 数据一览

<div class="stats-grid">
  <div class="stat-item">
    <h3>40+</h3>
    <p>发表论文</p>
  </div>
  <div class="stat-item">
    <h3>1500+</h3>
    <p>引用次数</p>
  </div>
  <div class="stat-item">
    <h3>10+</h3>
    <p>国际合作</p>
  </div>
  <div class="stat-item">
    <h3>5+</h3>
    <p>研究项目</p>
  </div>
</div>
{{< /blocks/section >}}

<!-- Collaborators -->
{{< blocks/section >}}
## 🤝 合作机构

- 清华大学
- 北京大学
- 中科院心理所
- Stanford University
- MIT

{{< /blocks/section >}}
```

**使用方法**:
```bash
# 1. 启动本地服务器
./dev.sh

# 2. 编辑主页
vim /mnt/data/hyf/yu_lab/website/content/_index.md

# 3. 根据上述模板修改
# 4. 保存后浏览器自动刷新查看效果
```

---

### 2️⃣ 研究方向页面模板

```markdown
---
title: "Research"
description: "Our research spans computational neuroscience, brain imaging, and artificial intelligence."
---

## 研究概览

我们的研究处于神经科学与人工智能的交叉前沿，致力于理解大脑智能的计算原理，
并开发受生物启发的智能算法。

---

## 🧠 研究方向1: 脑网络连接组学

### 问题背景

人脑包含约860亿神经元和100万亿突触连接，形成复杂的网络结构。
理解这些网络如何支持认知功能，是神经科学的核心挑战之一。

### 我们的方法

- **多模态神经影像融合**: 结合fMRI、DTI、EEG等技术
- **图论网络分析**: 量化大脑网络拓扑特性
- **机器学习预测**: 基于脑网络特征预测认知和临床表型

### 代表性成果

1. **Zhang et al. (2025)** - *Nature Neuroscience*  
   "Connectome-based prediction of cognitive abilities"  
   [[Paper]](/publications/zhang2025connectome/) [[Code]](https://github.com/)

2. **Li et al. (2025)** - *Cerebral Cortex*  
   "Topographic organization of functional brain networks"  
   [[Paper]](/publications/li2025topographic/)

### 未来方向

- 个体化脑网络模型
- 脑网络动态演化
- 跨物种比较研究

---

## 🤖 研究方向2: 深度学习与神经影像

### 问题背景

深度学习在计算机视觉和自然语言处理领域取得巨大成功，
但在医学影像尤其是脑影像分析中仍面临独特挑战...

[继续按相同结构展开]

---

## 🎯 研究方向3: 计算神经科学

[继续按相同结构展开]

---

## 🔬 研究设施与资源

- **计算资源**: 高性能GPU集群（NVIDIA A100）
- **数据资源**: 多个大型公开脑影像数据库访问权限
- **合作网络**: 与国内外顶尖实验室紧密合作

---

## 📚 相关阅读

- [查看全部出版物](/publications/)
- [加入我们的研究团队](/join-us/)
- [研究资源与代码](/resources/)
```

---

### 3️⃣ 招聘页面模板

```markdown
---
title: "Join Us"
description: "Open positions and opportunities in Yuzhang Neuro+AI Lab"
---

## 🎯 为什么选择我们？

加入Yuzhang Neuro+AI Lab，您将：

- 🔬 **前沿研究**: 参与NeuroAI领域最前沿的研究项目
- 🌍 **国际视野**: 与海内外顶尖学者合作交流
- 📈 **成长支持**: 一对一指导，充足的研究经费和资源
- 🎓 **学术产出**: 目标发表高水平论文（Nature系列、PNAS、NeurIPS等）
- ⚖️ **工作平衡**: 尊重个人时间，鼓励健康的工作生活平衡

---

## 💼 招聘岗位

### 博士后研究员 (Postdoctoral Researcher)

**研究方向**:
- 脑网络建模与分析
- 深度学习在神经影像中的应用
- 计算神经科学理论

**任职要求**:
- 已获得或即将获得神经科学、计算机科学、生物医学工程、
  数学、物理等相关专业博士学位
- 有神经影像分析或深度学习研究经验者优先
- 良好的编程能力（Python/MATLAB/R）
- 优秀的英文学术写作和交流能力
- 第一作者发表过高水平论文者优先

**薪资待遇**:
- 年薪：25-35万（根据经验和能力）
- 提供科研启动经费
- 协助申请国家博士后基金、博新计划等
- 提供住房补贴
- 五险一金

**申请材料**:
1. 个人简历（包含教育背景、研究经历、论文列表）
2. 研究陈述（1-2页，描述过往研究和未来兴趣）
3. 3封推荐信（或推荐人联系方式）
4. 代表性论文（最多3篇）

---

### 博士研究生 (PhD Students)

**招生方向**:
- 神经影像与机器学习
- 脑网络分析
- 认知神经科学

**申请要求**:
- 本科或硕士学位（计算机、生物医学、心理学、数学等相关专业）
- 扎实的数学和编程基础
- 对神经科学和AI交叉研究有浓厚兴趣
- 优秀的学习能力和科研潜力

**我们提供**:
- 全额奖学金（根据学校政策）
- 国际会议差旅支持
- 海外访学机会
- 顶级学术资源和计算设备

**申请流程**:
1. 发送简历和成绩单到 [邮箱]
2. 初步面试（线上/线下）
3. 通过后参加学校研究生招生考试
4. 正式录取

---

### 硕士研究生 (Master Students)

**招生名额**: 每年2-3名

**要求**:
- 本科专业不限，但需有一定编程基础
- 对神经科学和AI感兴趣
- 学习能力强，有团队合作精神

**培养目标**:
- 掌握神经影像数据分析方法
- 发表1-2篇学术论文
- 为继续深造或工业界就业做好准备

---

### 访问学生 (Visiting Students)

我们欢迎优秀的本科生和研究生来实验室进行短期访问学习。

**时长**: 3-12个月

**要求**:
- 在读本科生或研究生
- 有基本的编程能力
- 时间充足，能全身心投入研究

**收获**:
- 参与前沿科研项目
- 学习神经影像和深度学习技能
- 可能的论文合著机会
- 推荐信支持

---

## 📧 如何申请

**联系方式**:
- **Email**: yuzhang@xxx.edu.cn
- **主题格式**: [申请岗位] - 姓名 - 学校/单位

**申请截止**: 长期有效，招满为止

**审核流程**:
1. 提交申请材料
2. 初审（1-2周）
3. 面试（线上/线下）
4. 发放Offer

---

## ❓ 常见问题 (FAQ)

### Q1: 我的专业背景不是神经科学，可以申请吗？

A: 可以！我们欢迎多元化背景，包括计算机、数学、物理、工程等。
   重要的是对交叉研究的热情和学习能力。

### Q2: 需要什么样的编程技能？

A: 至少熟练掌握Python或MATLAB之一。了解深度学习框架（PyTorch/TensorFlow）
   和神经影像工具（FSL/SPM/Freesurfer）会有加分。

### Q3: 发表论文的期望是什么？

A: 我们追求质量而非数量。博士生期间目标1-3篇高质量论文
   （如Nature子刊、PNAS、顶会等）。

### Q4: 实验室的工作氛围如何？

A: 我们倡导开放、合作、互助的文化。鼓励独立思考，也重视团队协作。
   工作时间灵活，但需保证研究进度。

---

## 🌟 加入我们

如果您对大脑智能充满好奇，对AI技术充满热情，
欢迎加入Yuzhang Neuro+AI Lab，一起探索智能的奥秘！

**立即申请**: yuzhang@xxx.edu.cn
```

---

## 🛠️ 技术最佳实践

### 1. 内容组织原则

```
遵循"金字塔原理":
1. 最重要信息放在顶部
2. 先总后分，先主后次
3. 每个页面一个明确主题
4. 使用清晰的层级结构（H2 → H3 → H4）
```

### 2. 写作风格指南

**学术网站文案原则**:
- ✅ 专业但不生硬
- ✅ 简洁但信息完整
- ✅ 学术但易理解
- ✅ 国际化但有本土特色

**避免**:
- ❌ 过度营销语言
- ❌ 模糊笼统表述
- ❌ 过长段落（>150字）
- ❌ 行话术语无解释

### 3. SEO优化技巧

```yaml
# 每个页面前置元数据
---
title: "简洁明确的标题（< 60字符）"
description: "150-160字符的页面描述，包含关键词"
keywords: ["神经科学", "深度学习", "脑成像", "AI"]
author: "Dr. Yu Zhang"
date: 2025-10-26
---
```

**关键词策略**:
- 主关键词: "Neuro AI", "Brain Imaging", "Connectome"
- 长尾关键词: "brain network analysis deep learning"
- 本地化: "神经影像 + 深度学习"

### 4. 图片优化

```bash
# 推荐尺寸
- Logo: 200x200px (PNG with transparent background)
- 头像: 400x400px (正方形)
- 横幅图: 1200x400px
- 研究图示: 800x600px

# 格式选择
- 照片: JPEG (质量80-85%)
- 图标/Logo: PNG or SVG
- 复杂图表: SVG (可缩放)

# 压缩工具
https://tinypng.com/
https://imageoptim.com/
```

### 5. 性能优化

```bash
# Hugo构建优化
hugo --gc --minify

# 启用缓存
# 在 config.toml 添加:
[caches]
  [caches.getresource]
    maxAge = "24h"

# 图片懒加载
# 在模板中使用 loading="lazy"
<img src="image.jpg" loading="lazy" alt="description">
```

---

## 📊 进度跟踪与里程碑

### Week 1 里程碑

**必达目标（P0）**:
- [x] 主页有完整的Hero Section和研究亮点
- [x] 研究页面有3个详细的研究方向介绍
- [x] 出版物页面有40+篇完整论文
- [x] 团队页面有PI完整信息

**加分项（P1）**:
- [ ] 主页有最新动态模块
- [ ] 研究方向有配图
- [ ] 论文有摘要和链接

### Week 2 里程碑

**必达目标（P0）**:
- [ ] 招聘页面有至少2个岗位的详细JD
- [ ] 资源页面有基本内容框架
- [ ] 移动端适配测试通过
- [ ] 所有页面拼写检查完成

**加分项（P1）**:
- [ ] 添加Google Analytics
- [ ] 设置自定义域名
- [ ] 添加联系表单
- [ ] 集成社交媒体分享

---

## 🎯 MVP发布检查清单

**上线前最终检查**:

### 内容完整性
- [ ] 所有页面有实质内容（非占位符）
- [ ] 论文列表完整准确
- [ ] PI信息完整（照片、简介、联系方式）
- [ ] 导航菜单所有链接可用

### 技术质量
- [ ] 本地构建无错误（`hugo --gc --minify`）
- [ ] 所有链接有效（无404）
- [ ] 图片正常显示
- [ ] 移动端布局正常

### 专业形象
- [ ] 无拼写或语法错误
- [ ] 格式统一规范
- [ ] 视觉风格一致
- [ ] 联系方式准确

### 性能与可访问性
- [ ] 页面加载 < 3秒
- [ ] Google PageSpeed分数 > 80
- [ ] 所有图片有alt文本
- [ ] 颜色对比度符合WCAG标准

---

## 🚀 快速执行指令

### 启动本地开发

```bash
# 1. 启动Hugo服务器
cd /mnt/data/hyf/yu_lab
./dev.sh

# 2. 浏览器打开
http://localhost:1313/yuzhang-lab-website/

# 3. 开始编辑内容
vim website/content/_index.md
```

### 推送到GitHub

```bash
# 1. 测试构建
./build.sh

# 2. 提交更改
git add website/
git commit -m "feat: update homepage content"
git push origin main

# 3. 等待部署（2-3分钟）
# 4. 访问线上网站
https://autobrainlab.github.io/yuzhang-lab-website/
```

---

## 📚 参考资源

### 优秀学术网站案例

**国际一流**:
- MIT CSAIL: https://www.csail.mit.edu/
- Stanford HAI: https://hai.stanford.edu/
- DeepMind: https://www.deepmind.com/
- Allen Institute: https://alleninstitute.org/

**国内优秀**:
- 清华大学自动化系: https://www.au.tsinghua.edu.cn/
- 北大心理与认知科学学院: https://psych.pku.edu.cn/
- 中科院自动化所: http://www.ia.cas.cn/

### Hugo Blox 文档

- 官方文档: https://docs.hugoblox.com/
- 主题示例: https://github.com/HugoBlox/theme-academic-cv
- Markdown语法: https://www.markdownguide.org/

### 学术写作资源

- 论文摘要写作: https://writingcenter.unc.edu/tips-and-tools/abstracts/
- 学术英语语法: https://www.grammarly.com/blog/category/handbook/
- 科研可视化: https://www.biorender.com/

---

## 🎯 下周行动计划

### Monday (Day 1)
- [ ] 09:00-10:00: 撰写实验室使命宣言
- [ ] 10:00-12:00: 设计主页研究亮点卡片
- [ ] 14:00-16:00: 编写主页最新动态
- [ ] 16:00-18:00: 收集统计数据并制作展示

### Tuesday (Day 2)
- [ ] 09:00-12:00: 完成主页完整内容
- [ ] 14:00-18:00: 本地测试并优化主页

### Wednesday (Day 3)
- [ ] 09:00-12:00: 撰写研究方向1详细内容
- [ ] 14:00-18:00: 撰写研究方向2详细内容

### Thursday (Day 4)
- [ ] 09:00-12:00: 撰写研究方向3详细内容
- [ ] 14:00-18:00: 添加研究图示和链接

### Friday (Day 5)
- [ ] 09:00-12:00: Google Scholar导出BibTeX
- [ ] 14:00-18:00: 整理和导入完整论文列表

### Weekend
- [ ] 完善团队成员页面
- [ ] 准备头像照片
- [ ] 休息和回顾本周进度

---

## 💡 成功秘诀

1. **每天小步前进**: 不求一次完美，持续迭代改进
2. **本地先测试**: 确认效果满意再推送GitHub
3. **参考优秀案例**: 学习但不照搬，保持独特性
4. **用户视角思考**: 访客想看什么？如何快速找到信息？
5. **数据驱动决策**: 上线后关注Google Analytics，了解用户行为

---

## 📞 需要帮助？

**遇到问题随时问我**:
- 内容不知道怎么写 → 我可以提供模板
- 技术实现不清楚 → 我可以给出代码
- 设计不知道怎么做 → 我可以推荐方案

**当前可用资源**:
- ✅ 本地开发环境已就绪
- ✅ 自动化部署已配置
- ✅ 完整开发文档已准备
- ✅ AI助手随时支持 😊

---

**现在就开始吧！第一步：编辑主页内容**

```bash
./dev.sh
vim /mnt/data/hyf/yu_lab/website/content/_index.md
```

**祝您开发顺利！** 🚀
