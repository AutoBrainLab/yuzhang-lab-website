# 🎨 网站改进方案

**当前问题诊断与解决方案**  
**日期**: 2025-10-26  
**状态**: 功能正常，需要美化和完善  

---

## 📋 当前问题清单

### 1. ❌ 字体显示不理想
**问题**: 
- 当前使用`font: native`（系统默认字体）
- 中文显示可能使用宋体等非现代字体
- 英文字体缺少学术风格

**影响**: 
- 阅读体验差
- 不够专业
- 中英文混排不协调

---

### 2. ❌ 缺少语言切换功能
**问题**: 
- `show_language: false` 导致语言切换器隐藏
- 用户无法方便地在中英文间切换
- 需要手动修改URL

**影响**: 
- 双语网站功能不完整
- 用户体验差
- 国际化支持不足

---

### 3. ❌ 主页内容展示方式不佳
**问题**: 
- 使用简单的Markdown文件而非Widget系统
- 缺少视觉吸引力
- 没有Hero banner、特色展示等
- 信息结构不够清晰

**影响**: 
- 首页不够吸引人
- 内容展示平淡
- 缺少学术网站应有的专业性

---

## 🎯 改进方案

### 方案1: 优化字体配置 ✨

#### 问题分析
```yaml
# 当前配置 (params.yaml)
appearance:
  font: native  # ❌ 系统默认，不够美观
  font_size: L
```

#### 推荐方案A: 使用学术字体主题
```yaml
appearance:
  theme_day: minimal
  theme_night: minimal
  font: rose  # 🌟 Rose字体主题（优雅、学术）
  font_size: L
```

**Rose字体特点**:
- 英文: Crimson Pro (衬线字体，学术风格)
- 中文: 适配Noto Sans SC（无衬线，现代清晰）
- 代码: Fira Code（等宽，带连字）

#### 推荐方案B: 使用现代字体主题
```yaml
appearance:
  font: minimal  # 🌟 Minimal字体主题（现代、清爽）
  font_size: L
```

**Minimal字体特点**:
- 英文: Inter（现代无衬线，可读性强）
- 中文: 配套的中文无衬线字体
- 整体更现代化

#### 推荐方案C: Cybernetic（科技感）
```yaml
appearance:
  font: cybernetic  # 🌟 科技感字体（适合AI主题）
  font_size: L
```

#### 可用字体主题列表
Hugo Blox支持的字体主题:
- `minimal` - 现代简洁
- `rose` - 学术优雅
- `mr_robot` - 科技极客
- `cybernetic` - 未来科技
- `classic` - 经典传统

**我的推荐**: **`rose`** - 最适合学术实验室

---

### 方案2: 启用语言切换器 🌐

#### 当前问题
```yaml
header:
  navbar:
    show_language: false  # ❌ 禁用
```

#### 解决方案
```yaml
header:
  navbar:
    enable: true
    align: r
    show_logo: true
    show_language: true    # ✅ 启用语言切换
    show_day_night: true
    show_search: true
    highlight_active_link: true
```

**效果**: 
- 导航栏右侧出现地球图标🌐
- 点击可切换英文/中文
- 自动记住用户选择

---

### 方案3: 创建现代化主页 🏠

#### 当前问题
```
content/_index.md  # 简单Markdown页面
├── 纯文本内容
└── 缺少视觉吸引力
```

#### 解决方案: 使用Widget系统

创建 `content/home/` 目录结构:

```
content/home/
├── index.md           # Widget页面配置
├── hero.md            # 1. Hero Banner（首屏大图）
├── about.md           # 2. 实验室简介
├── research.md        # 3. 研究方向展示
├── news.md            # 4. 最新动态
├── metrics.md         # 5. 数据统计
├── people.md          # 6. 团队成员预览
├── publications.md    # 7. 精选论文
└── contact.md         # 8. 联系方式
```

#### Widget优势
- ✅ 模块化设计，易于管理
- ✅ 响应式布局
- ✅ 视觉吸引力强
- ✅ 支持图片、图标、动画
- ✅ 每个section可独立开关

---

## 🛠️ 具体实施步骤

### 步骤1: 修改字体配置（5分钟）

**文件**: `config/_default/params.yaml`

```yaml
appearance:
  theme_day: minimal
  theme_night: minimal
  font: rose          # 改为rose
  font_size: L
```

### 步骤2: 启用语言切换（2分钟）

**文件**: `config/_default/params.yaml`

```yaml
header:
  navbar:
    enable: true
    align: r
    show_logo: true
    show_language: true        # false → true
    show_day_night: true
    show_search: true
    highlight_active_link: true  # false → true
```

### 步骤3: 创建Widget主页（20分钟）

#### 3.1 创建home目录
```bash
mkdir -p content/home
mkdir -p content/zh/home
```

#### 3.2 创建index.md配置
**文件**: `content/home/index.md`
```yaml
---
# Homepage
type: widget_page
headless: true
---
```

#### 3.3 创建Hero Banner
**文件**: `content/home/hero.md`
```yaml
---
widget: hero
headless: true
weight: 10
title: Brain Atlas & Brain-Inspired AI
hero_media: welcome.jpg
design:
  background:
    gradient_start: '#4bb4e3'
    gradient_end: '#2b94c3'
    text_color_light: true
cta:
  url: '/research'
  label: Explore Our Research
  icon_pack: fas
  icon: microscope
cta_alt:
  url: '/join-us'
  label: Join Our Team
cta_note:
  label: >-
    <span class="js-github-release" data-repo="gcushen/hugo-academic">
      🧠 Leading Lab in Neuroscience + AI at SJTU
    </span>
---

**Mapping the Brain. Building Intelligence.**

Advancing neuroscience through cutting-edge brain imaging, connectomics, and brain-inspired AI at Shanghai Jiao Tong University.
```

#### 3.4 创建研究方向Widget
**文件**: `content/home/research.md`
```yaml
---
widget: features
headless: true
weight: 20
title: Research Directions
subtitle: Three Core Areas

feature:
  - icon: brain
    icon_pack: fas
    name: Brain Atlas Across Lifespan
    description: Multimodal imaging, connectomics, individualized modeling
  - icon: database
    icon_pack: fas
    name: Big Data & AI Models
    description: Foundation models, cognitive simulation, disease modeling
  - icon: robot
    icon_pack: fas
    name: Neuroscience + AI
    description: Brain-constrained deep learning, explainable AGI
---
```

#### 3.5 创建最新动态
**文件**: `content/home/news.md`
```yaml
---
widget: pages
headless: true
weight: 30
title: Latest News
subtitle: ''

content:
  page_type: news
  count: 3
  filters:
    author: ''
    category: ''
    tag: ''
    publication_type: ''
    featured_only: false

design:
  view: card
  columns: '2'
---
```

#### 3.6 创建数据统计
**文件**: `content/home/metrics.md`
```yaml
---
widget: blank
headless: true
weight: 40
title: Impact
subtitle: ''

design:
  columns: '1'
  background:
    color: '#f7f7f7'
---

<div class="row text-center">
  <div class="col-md-3">
    <h2 class="display-4">40+</h2>
    <p>Publications</p>
  </div>
  <div class="col-md-3">
    <h2 class="display-4">3,800+</h2>
    <p>Citations</p>
  </div>
  <div class="col-md-3">
    <h2 class="display-4">54</h2>
    <p>Patents</p>
  </div>
  <div class="col-md-3">
    <h2 class="display-4">10+</h2>
    <p>Research Grants</p>
  </div>
</div>
```

---

## 📊 改进效果对比

| 项目 | 改进前 | 改进后 |
|------|--------|--------|
| **字体** | 系统默认，不统一 | Rose学术字体，优雅专业 ✨ |
| **中文字体** | 宋体等老旧字体 | Noto Sans SC，现代清晰 ✨ |
| **语言切换** | 需手动改URL ❌ | 导航栏一键切换 ✅ |
| **主页** | 纯文本，平淡 | Widget模块，视觉丰富 ✨ |
| **首屏** | 无Hero banner | 大图+Slogan，吸引眼球 ✨ |
| **信息架构** | 线性文本 | 模块化，清晰层次 ✨ |

---

## 🎨 设计建议

### 颜色方案
```yaml
# 主色调（建议）
primary: '#0066cc'      # 科技蓝
secondary: '#2b94c3'    # 浅蓝
accent: '#ff6b6b'       # 强调红

# 适合脑科学+AI主题
- 蓝色系：科技、理性、智能
- 配合渐变：现代感
```

### 图片建议
准备以下素材：
1. **Hero背景** (1920x600px)
   - 脑网络可视化图
   - 或实验室照片

2. **Logo** (300x80px)
   - 实验室标识
   - 简洁、专业

3. **PI头像** (400x400px)
   - 正式照片
   - 方形裁剪

4. **研究图示**
   - 三个研究方向的示意图
   - 统一风格

---

## 🚀 快速实施优先级

### 🔥 高优先级（立即实施）
1. ✅ **启用语言切换器** - 2分钟
   - 修改`show_language: true`
   - 测试切换功能

2. ✅ **更换字体为Rose** - 5分钟
   - 修改`font: rose`
   - 刷新页面查看效果

3. ✅ **高亮当前页** - 2分钟
   - `highlight_active_link: true`
   - 改善导航体验

### 📝 中优先级（1-2小时）
4. ⏳ **创建Widget主页**
   - 创建home目录
   - 添加hero.md, research.md等
   - 测试显示效果

5. ⏳ **优化SEO信息**
   - 更新params.yaml中的描述
   - 添加关键词

### 🎨 低优先级（后续优化）
6. 🔜 准备视觉素材
   - Logo设计
   - Hero背景图
   - 研究图示

7. 🔜 自定义CSS
   - 微调颜色
   - 添加动画效果

---

## 📝 实施清单

### 立即可执行（10分钟内）
- [ ] 修改字体为`rose`
- [ ] 启用语言切换`show_language: true`
- [ ] 启用高亮`highlight_active_link: true`
- [ ] 测试中英文切换
- [ ] 重启hugo server查看效果

### 今天完成（1小时内）
- [ ] 创建`content/home/`目录
- [ ] 添加Widget配置文件
- [ ] 创建Hero banner
- [ ] 添加研究方向展示
- [ ] 添加数据统计Widget

### 本周完成
- [ ] 准备Hero背景图
- [ ] 设计实验室Logo
- [ ] 拍摄/准备PI照片
- [ ] 完善中文Widget内容
- [ ] 测试所有页面

---

## 💡 最佳实践建议

### 字体选择原则
1. **可读性优先** - 学术网站内容为主
2. **中英文协调** - 混排要和谐
3. **专业感** - 避免过于花哨
4. **性能考虑** - 字体文件不要太大

### 语言切换最佳实践
1. **显著位置** - 导航栏右上角
2. **图标识别** - 地球🌐或语言代码
3. **保持状态** - 切换后停留在相同页面
4. **默认语言** - 根据浏览器自动识别

### 主页设计原则
1. **首屏吸引** - Hero banner要震撼
2. **信息层次** - 从概括到细节
3. **行动号召** - 明确的CTA按钮
4. **社会证明** - 展示成果和数据
5. **响应式** - 移动端体验良好

---

## 🎯 预期效果

实施以上改进后，网站将：

✨ **视觉效果**
- 字体优雅专业
- 布局美观大方
- 色彩协调统一

✨ **用户体验**
- 语言切换方便
- 导航清晰明确
- 信息获取高效

✨ **专业形象**
- 学术权威感
- 科技现代感
- 国际化水平

---

**下一步建议**: 我可以立即帮您实施高优先级改进（字体+语言切换），预计10分钟完成。是否现在开始？
