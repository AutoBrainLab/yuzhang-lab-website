# 📋 网站页面优化方案

**日期**: 2025年10月26日  
**问题**: 标题重复、内容冗长、缺乏组织  
**目标**: 简洁、清晰、易读

---

## 🔍 问题分析

### 问题1: 标题重复（三个相同标题）

**现状**:
```
研究资源页面出现3次"研究资源"：
1. <title>研究资源 | 张瑜实验室</title>  (浏览器标签)
2. <h1>研究资源</h1>                    (页面自动标题)
3. <h1 id="研究资源">研究资源</h1>       (Markdown内容)
```

**根本原因**: 
- Hugo主题自动从frontmatter的`title`生成`<h1>`标题
- 用户又在Markdown内容中手动写了`# 研究资源`
- 造成视觉上的重复

---

### 问题2: 页面内容过长缺乏组织

**页面行数统计**:
| 页面 | 行数 | 评估 |
|------|------|------|
| join-us | 286行 | 🔴 过长 |
| research | 277行 | 🔴 过长 |
| people | 237行 | 🟡 较长 |
| resources | 195行 | 🟡 较长 |
| publications | 162行 | 🟢 适中 |
| news | 17行 | 🟢 简洁 |

**内容问题**:
1. **结构扁平**: 所有内容堆在一个页面，没有分层
2. **信息密集**: 大段文字，缺少视觉喘息空间
3. **层级混乱**: H2、H3标题过多，信息层次不清
4. **缺少引导**: 没有快速导航或总览

---

## ✅ 优化方案

### 方案1: 移除Markdown中的重复H1标题 (立即实施)

**原理**: 
- Hugo会自动从`title: "研究资源"`生成页面标题
- 删除Markdown内容开头的`# 研究资源`

**修改前**:
```markdown
---
title: "研究资源"
---

# 研究资源  ← 删除这一行

我们致力于开放科学...
```

**修改后**:
```markdown
---
title: "研究资源"
---

我们致力于开放科学...  ← 直接从简介开始
```

**影响**: 
- ✅ 去除视觉重复
- ✅ 页面更简洁
- ✅ 符合Hugo最佳实践

---

### 方案2: 内容重组 - 卡片式布局 (推荐)

**设计思路**: 将长内容拆分为视觉卡片，每个卡片包含：
- 图标/图片
- 简短标题
- 2-3句摘要
- "了解更多"链接（可选）

**示例 - Resources页面重组**:

**修改前** (195行长文):
```markdown
## 💻 软件与代码

### 脑成像分析工具
即将发布：用于多模态脑成像分析的开源工具

功能特性:
- 基于连接的脑分区
- 多模态数据整合
- 个体水平脑图谱绘制
- 图神经网络实现

### 脑图谱平台
即将发布：交互式脑图谱可视化和查询平台

核心能力:
- 3D脑图谱可视化
- 跨模态数据整合
...
(继续很多内容)
```

**修改后** (使用Bootstrap卡片):
```markdown
---
title: "研究资源"
description: "开源工具、数据集和教程"
---

<p class="lead text-muted">
我们致力于开放科学，与学术界分享研究工具、代码和数据集。
</p>

<div class="row mt-4">
  
  <!-- 软件工具卡片 -->
  <div class="col-md-6 mb-4">
    <div class="card h-100 shadow-sm">
      <div class="card-body">
        <h3 class="card-title">
          <i class="fas fa-code text-primary"></i> 软件与代码
        </h3>
        <p class="card-text">
          多模态脑成像分析工具、脑图谱可视化平台、图神经网络工具箱。
        </p>
        <ul class="list-unstyled">
          <li>✓ 脑成像分析工具</li>
          <li>✓ 交互式脑图谱平台</li>
          <li>✓ 图神经网络库</li>
        </ul>
        <span class="badge bg-info">即将发布</span>
      </div>
    </div>
  </div>

  <!-- 数据集卡片 -->
  <div class="col-md-6 mb-4">
    <div class="card h-100 shadow-sm">
      <div class="card-body">
        <h3 class="card-title">
          <i class="fas fa-database text-success"></i> 数据集
        </h3>
        <p class="card-text">
          神经影像数据、脑图谱分区方案、临床认知数据。
        </p>
        <ul class="list-unstyled">
          <li>✓ 多模态MRI数据</li>
          <li>✓ MEG/EEG数据</li>
          <li>✓ 脑图谱模板</li>
        </ul>
        <span class="badge bg-warning">研究发表后开放</span>
      </div>
    </div>
  </div>

  <!-- 教程文档卡片 -->
  <div class="col-md-6 mb-4">
    <div class="card h-100 shadow-sm">
      <div class="card-body">
        <h3 class="card-title">
          <i class="fas fa-book text-warning"></i> 教程与文档
        </h3>
        <p class="card-text">
          分析流程、工作坊材料、最佳实践指南。
        </p>
        <ul class="list-unstyled">
          <li>✓ 脑成像预处理流程</li>
          <li>✓ 图神经网络教程</li>
          <li>✓ 临床数据分析</li>
        </ul>
      </div>
    </div>
  </div>

  <!-- 开发中工具卡片 -->
  <div class="col-md-6 mb-4">
    <div class="card h-100 shadow-sm">
      <div class="card-body">
        <h3 class="card-title">
          <i class="fas fa-flask text-danger"></i> 开发中
        </h3>
        <p class="card-text">
          基础模型、图神经网络、编码/解码框架。
        </p>
        <ul class="list-unstyled">
          <li>🔬 神经影像基础模型</li>
          <li>🔬 脑连接GNN工具</li>
          <li>🔬 认知解码框架</li>
        </ul>
        <span class="badge bg-secondary">开发中</span>
      </div>
    </div>
  </div>

</div>

---

## 📬 获取资源

如需访问我们的工具和数据，请通过以下方式联系：

- 📧 Email: yuzhang2@sjtu.edu.cn
- 💬 GitHub: 即将发布
```

**优势**:
- ✅ 内容减少70% (从195行 → 约60行)
- ✅ 视觉层次清晰（网格布局）
- ✅ 快速扫描（卡片+图标）
- ✅ 移动端友好（Bootstrap响应式）

---

### 方案3: 折叠/手风琴式内容 (适合超长页面)

**适用页面**: Research (277行), Join-us (286行)

**示例 - Research页面**:

```markdown
---
title: "研究方向"
description: "脑图谱、大数据、类脑AI"
---

<p class="lead">
我们聚焦于脑图谱与类脑智能，将神经科学与人工智能相结合。
</p>

<div class="accordion mt-4" id="researchAccordion">
  
  <!-- 研究方向1 -->
  <div class="accordion-item">
    <h2 class="accordion-header" id="heading1">
      <button class="accordion-button" type="button" data-bs-toggle="collapse" 
              data-bs-target="#collapse1">
        🧠 全生命周期的人脑图谱绘制
      </button>
    </h2>
    <div id="collapse1" class="accordion-collapse collapse show">
      <div class="accordion-body">
        <p><strong>研究概述</strong>: 结合多模态脑成像技术和连接组学...</p>
        
        <h4>研究目标</h4>
        <ul>
          <li>精细功能分区</li>
          <li>时空演化规律</li>
          <li>个体化脑模型</li>
        </ul>
        
        <h4>核心技术</h4>
        <ul>
          <li>多模态脑成像</li>
          <li>连接组学与网络分析</li>
        </ul>
      </div>
    </div>
  </div>

  <!-- 研究方向2 -->
  <div class="accordion-item">
    <h2 class="accordion-header" id="heading2">
      <button class="accordion-button collapsed" type="button" 
              data-bs-toggle="collapse" data-bs-target="#collapse2">
        📊 脑图谱大数据分析与建模
      </button>
    </h2>
    <div id="collapse2" class="accordion-collapse collapse">
      <div class="accordion-body">
        ...
      </div>
    </div>
  </div>

  <!-- 研究方向3 -->
  <div class="accordion-item">
    <h2 class="accordion-header" id="heading3">
      <button class="accordion-button collapsed" type="button" 
              data-bs-toggle="collapse" data-bs-target="#collapse3">
        🤖 脑科学与人工智能交叉研究
      </button>
    </h2>
    <div id="collapse3" class="accordion-collapse collapse">
      <div class="accordion-body">
        ...
      </div>
    </div>
  </div>

</div>
```

**优势**:
- ✅ 初始加载只显示标题
- ✅ 用户按需展开感兴趣的内容
- ✅ 页面不会"无限长"
- ✅ 保留完整信息

---

### 方案4: 添加目录导航 (TOC)

**适用**: 所有长页面

**实现**:
```markdown
---
title: "研究方向"
toc: true  # 启用目录
---

<!-- 目录会自动生成在页面右侧或顶部 -->
```

或手动添加锚点导航：

```markdown
<nav class="toc mb-4 p-3 bg-light rounded">
  <h5>快速导航</h5>
  <ul class="list-unstyled">
    <li><a href="#brain-atlas">🧠 脑图谱绘制</a></li>
    <li><a href="#big-data">📊 大数据分析</a></li>
    <li><a href="#brain-ai">🤖 脑科学与AI</a></li>
  </ul>
</nav>
```

---

### 方案5: 视觉优化技巧

#### 5.1 增加留白
```markdown
<!-- 之前: 密集排列 -->
## 标题
内容内容内容
## 下一个标题

<!-- 之后: 添加分隔 -->
## 标题

内容内容内容

---

## 下一个标题
```

#### 5.2 使用信息提示框
```markdown
<div class="alert alert-info" role="alert">
  <strong>💡 提示</strong>: 这是重要信息
</div>

<div class="alert alert-success">
  <strong>✅ 已完成</strong>: 项目已上线
</div>

<div class="alert alert-warning">
  <strong>⚠️ 即将发布</strong>: 敬请期待
</div>
```

#### 5.3 使用列表而非段落
```markdown
<!-- 之前: 大段文字 -->
我们的实验室有以下特点：首先我们注重开放科学，其次我们强调国际合作，第三我们培养跨学科人才。

<!-- 之后: 简洁列表 -->
我们的实验室特点：
- ✓ 开放科学
- ✓ 国际合作  
- ✓ 跨学科培养
```

---

## 📊 优化优先级

### P0 - 立即修复（5分钟）
1. **移除重复H1标题**
   - 删除所有页面Markdown开头的`# 页面标题`
   - 保留frontmatter的`title`即可

### P1 - 快速优化（30分钟）
2. **Resources页面改为卡片布局**
   - 视觉效果最显著
   - 内容减少70%

3. **增加视觉留白**
   - 添加`---`分隔符
   - 调整段落间距

### P2 - 深度优化（2小时）
4. **Research页面使用折叠式布局**
   - 解决277行过长问题
   - 改善用户体验

5. **Join-us页面重组**
   - 拆分为"博士生"、"硕士生"、"访问学者"标签页
   - 或使用卡片布局

### P3 - 长期改进（未来迭代）
6. **创建子页面**
   - 将大页面拆分为多个小页面
   - 添加"了解更多"链接

7. **添加搜索和过滤**
   - Publications页面添加年份过滤
   - Resources页面添加类型筛选

---

## 🎯 最佳实践参考

### 学术网站参考案例

1. **MIT CSAIL**: https://www.csail.mit.edu/
   - 卡片式项目展示
   - 简洁的研究方向页面

2. **Stanford HAI**: https://hai.stanford.edu/
   - 清晰的视觉层次
   - 折叠式详细内容

3. **DeepMind**: https://www.deepmind.com/research
   - 网格布局
   - 图标+简短描述

### 设计原则

1. **F-Pattern阅读**: 用户眼睛呈F型扫描
   - 重要信息放左上
   - 使用标题和列表

2. **3秒规则**: 用户3秒内应理解页面内容
   - 清晰的标题
   - 简短的介绍段落

3. **7±2原则**: 一次展示5-9个项目
   - 超过9个使用分组或分页
   - Resources页面4个卡片 ✓

4. **移动优先**: 50%+流量来自手机
   - 使用响应式布局
   - 避免超宽表格

---

## 📝 实施建议

### 第一步: 快速修复（今天）
```bash
# 修改所有页面，删除重复H1
sed -i '1,10s/^# .*$//' content/zh/*/_index.md
```

### 第二步: 重组Resources（明天）
- 使用提供的卡片式模板
- 测试移动端显示

### 第三步: 渐进优化（本周）
- Research页面折叠式
- 增加视觉留白
- 添加导航锚点

### 第四步: 用户测试（下周）
- 请5-10人试用
- 收集反馈
- 迭代改进

---

## ✅ 预期效果

### 修复前
- ❌ 3个重复标题
- ❌ 195-286行长页面
- ❌ 信息密集，难以扫描
- ❌ 缺少视觉层次

### 修复后
- ✅ 1个清晰标题
- ✅ 50-100行紧凑页面
- ✅ 卡片/折叠布局，易扫描
- ✅ 清晰的视觉层次

---

**开始实施？我可以帮您逐个页面优化！**
