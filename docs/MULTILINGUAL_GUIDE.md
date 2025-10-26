# 🌐 多语言网站开发指南

**版本**: 1.0  
**创建时间**: 2025-10-26  
**语言支持**: 中文（简体） + 英文

---

## ✅ 配置完成确认

### 已完成配置

1. ✅ **语言配置文件**: `config/_default/languages.toml`
   - 英文（默认）: `en` - weight: 1
   - 中文: `zh` - weight: 2

2. ✅ **启用语言切换器**: `config/_default/params.toml`
   - `show_language = true`

3. ✅ **中文语言包**: 主题自带
   - `themes/hugo-blox-builder/modules/blox-tailwind/i18n/zh.yaml`

4. ✅ **内容目录结构**:
   ```
   content/
   ├── _index.md          # 英文主页
   ├── research/          # 英文研究页面
   ├── people/            # 英文团队页面
   ├── publications/      # 英文出版物
   └── zh/                # 中文内容目录
       └── _index.md      # 中文主页
   ```

---

## 🌍 多语言工作原理

### URL结构

Hugo会自动为不同语言创建不同的URL路径：

```
英文（默认）:
https://autobrainlab.github.io/yuzhang-lab-website/
https://autobrainlab.github.io/yuzhang-lab-website/research/
https://autobrainlab.github.io/yuzhang-lab-website/publications/

中文:
https://autobrainlab.github.io/yuzhang-lab-website/zh/
https://autobrainlab.github.io/yuzhang-lab-website/zh/research/
https://autobrainlab.github.io/yuzhang-lab-website/zh/publications/
```

### 内容对应关系

```
content/_index.md           →  /en/                （英文主页）
content/zh/_index.md        →  /zh/                （中文主页）

content/research/_index.md  →  /en/research/       （英文研究）
content/zh/research/_index.md → /zh/research/      （中文研究）
```

---

## 📝 双语内容创建流程

### 方法1: 同步创建（推荐）

**工作流**:
1. 先创建英文内容
2. 立即创建对应的中文内容
3. 确保两者结构一致

**示例 - 创建研究页面**:

```bash
# 1. 创建英文版本
vim website/content/research/_index.md

# 2. 立即创建中文版本
vim website/content/zh/research/_index.md
```

**好处**:
- 避免遗漏
- 内容同步
- 结构一致

### 方法2: 先英文后中文

**工作流**:
1. Phase 1: 完成所有英文内容
2. Phase 2: 批量翻译为中文

**好处**:
- 快速上线英文版
- 集中翻译效率高

**适用场景**:
- MVP快速发布
- 有专业翻译资源

---

## 🗂️ 内容文件组织

### 目录结构

```
website/content/
├── _index.md                    # 英文主页
├── research/
│   └── _index.md                # 英文研究页面
├── people/
│   └── _index.md                # 英文团队页面
├── publications/
│   ├── _index.md                # 英文出版物列表
│   ├── paper1.md                # 英文论文1
│   └── paper2.md                # 英文论文2
├── resources/
│   └── _index.md                # 英文资源页面
├── join-us/
│   └── _index.md                # 英文招聘页面
└── zh/                          # 中文内容目录
    ├── _index.md                # 中文主页
    ├── research/
    │   └── _index.md            # 中文研究页面
    ├── people/
    │   └── _index.md            # 中文团队页面
    ├── publications/
    │   ├── _index.md            # 中文出版物列表
    │   ├── paper1.md            # 中文论文1（可选）
    │   └── paper2.md            # 中文论文2（可选）
    ├── resources/
    │   └── _index.md            # 中文资源页面
    └── join-us/
        └── _index.md            # 中文招聘页面
```

### 文件命名规则

**规则**:
- 英文内容: 直接放在 `content/` 目录
- 中文内容: 放在 `content/zh/` 目录
- **文件名保持一致**（除了路径不同）

**示例**:
```
✅ 正确:
content/research/_index.md
content/zh/research/_index.md

✅ 正确:
content/publications/li2025topographic.md
content/zh/publications/li2025topographic.md

❌ 错误:
content/research/_index.md
content/zh/research/index.md         ← 文件名不一致
```

---

## ✍️ 内容编写模板

### 主页模板

#### 英文版 (`content/_index.md`)

```markdown
---
title: "Yuzhang Neuro+AI Lab"
description: "Reverse-engineering intelligent algorithms, fostering global talent, and advancing the frontiers of NeuroAI research."
---

# Welcome to Yuzhang Neuro+AI Lab

## 🧠 Our Mission

We are dedicated to reverse-engineering intelligent algorithms...

## 🔬 Research Focus

1. **Brain-Inspired AI Algorithms**
2. **Computational Neuroscience**
3. **AI for Neuroscience**

## 📰 Latest News

- **October 2025**: Lab established at Tsinghua University
- **Recruiting**: PhD students and postdocs

---

*Last updated: October 26, 2025*
```

#### 中文版 (`content/zh/_index.md`)

```markdown
---
title: "张瑜 脑智计算实验室"
description: "逆向工程智能算法，培养全球人才，推进脑智融合前沿研究。"
---

# 欢迎来到张瑜脑智计算实验室

## 🧠 我们的使命

我们致力于逆向工程智能算法...

## 🔬 研究方向

1. **类脑人工智能算法**
2. **计算神经科学**
3. **人工智能赋能神经科学**

## 📰 最新动态

- **2025年10月**：实验室在清华大学正式成立
- **招聘中**：博士生和博士后

---

*最后更新：2025年10月26日*
```

### 研究页面模板

#### 英文版 (`content/research/_index.md`)

```markdown
---
title: "Research"
description: "Our research focuses on brain-inspired AI and computational neuroscience."
---

# Research Directions

## 1. Brain-Inspired AI Algorithms

### Overview
We develop next-generation AI systems inspired by neuroscience principles...

### Key Projects
- Project A: Neural network architecture design
- Project B: Learning algorithms

### Representative Publications
- Li et al. (2025). Topographic deep learning. *Nature*.

---

## 2. Computational Neuroscience

### Overview
Understanding brain function through computational modeling...

### Key Projects
- Project C: Brain connectome analysis
- Project D: Neural dynamics modeling

---

## 3. AI for Neuroscience

### Overview
Applying AI to decode brain mechanisms...
```

#### 中文版 (`content/zh/research/_index.md`)

```markdown
---
title: "研究方向"
description: "我们的研究聚焦类脑人工智能和计算神经科学。"
---

# 研究方向

## 1. 类脑人工智能算法

### 概述
我们开发受神经科学原理启发的下一代人工智能系统...

### 主要项目
- 项目A：神经网络架构设计
- 项目B：学习算法

### 代表性论文
- Li et al. (2025). 拓扑深度学习. *Nature*.

---

## 2. 计算神经科学

### 概述
通过计算建模理解大脑功能...

### 主要项目
- 项目C：脑连接组分析
- 项目D：神经动力学建模

---

## 3. 人工智能赋能神经科学

### 概述
应用人工智能技术解码大脑机制...
```

---

## 🛠️ 开发工作流

### 创建新页面

```bash
# 1. 创建英文版本
vim website/content/new-page/_index.md

# 内容示例:
---
title: "New Page"
description: "Page description"
---

# New Page Content

Your English content here...

# 2. 创建对应中文版本
mkdir -p website/content/zh/new-page
vim website/content/zh/new-page/_index.md

# 内容示例:
---
title: "新页面"
description: "页面描述"
---

# 新页面内容

您的中文内容...

# 3. 本地预览
# 英文版: http://localhost:1313/yuzhang-lab-website/new-page/
# 中文版: http://localhost:1313/yuzhang-lab-website/zh/new-page/
```

### 编辑现有页面

```bash
# 1. 编辑英文版本
vim website/content/research/_index.md

# 2. 同步更新中文版本
vim website/content/zh/research/_index.md

# 3. 保存后浏览器自动刷新（开发服务器运行中）
```

### 本地预览双语内容

```bash
# 启动开发服务器
./dev.sh

# 浏览器访问:
# 英文主页: http://localhost:1313/yuzhang-lab-website/
# 中文主页: http://localhost:1313/yuzhang-lab-website/zh/

# 语言切换:
# 网站右上角有语言切换按钮（地球图标）
```

---

## 📋 双语内容核对清单

### Phase 1.1 核心页面

| 页面 | 英文路径 | 中文路径 | 状态 |
|-----|---------|---------|-----|
| 主页 | `content/_index.md` | `content/zh/_index.md` | ✅ 已创建 |
| 研究方向 | `content/research/_index.md` | `content/zh/research/_index.md` | ⏳ 待创建 |
| 团队成员 | `content/people/_index.md` | `content/zh/people/_index.md` | ⏳ 待创建 |
| 出版物 | `content/publications/_index.md` | `content/zh/publications/_index.md` | ⏳ 待创建 |
| 招聘信息 | `content/join-us/_index.md` | `content/zh/join-us/_index.md` | ⏳ 待创建 |
| 资源 | `content/resources/_index.md` | `content/zh/resources/_index.md` | ⏳ 待创建 |

### 验证双语内容

```bash
# 检查页面数量
cd /mnt/data/hyf/yu_lab/website
hugo list all | grep -E "(EN|ZH)"

# 预期输出:
# EN: 26 pages
# ZH: 7+ pages (随着内容增加)

# 验证特定页面
hugo list all | grep "_index.md"
```

---

## 🎨 样式和显示

### 语言切换器

配置已启用（`params.toml`）:
```toml
[header.navbar]
show_language = true  # ✅ 已启用
```

**显示位置**: 网站右上角导航栏

**图标**: 地球 🌐 图标

**功能**: 点击切换英文/中文

### 字体设置

主题会自动根据语言选择合适字体：
- **英文**: Classic serif字体
- **中文**: 系统默认中文字体（如思源黑体）

---

## 💡 最佳实践

### 1. 内容翻译策略

**学术术语**:
- ✅ 保持一致：Brain-Inspired AI → 类脑人工智能
- ✅ 括号注释：计算神经科学 (Computational Neuroscience)
- ❌ 避免机翻：使用专业术语

**人名地名**:
- ✅ 英文原名：Yu Zhang
- ✅ 中文全名：张瑜 (Yu Zhang)
- ✅ 机构：Tsinghua University / 清华大学

### 2. 内容同步检查

**提交前检查**:
```bash
# 检查文件配对
ls content/ | while read file; do
  if [ ! -f "content/zh/$file" ]; then
    echo "缺少中文版本: $file"
  fi
done
```

### 3. 出版物双语处理

**建议**: 论文详情页保持英文，列表页双语

**原因**:
- 论文标题、摘要通常是英文
- 减少翻译工作量
- 保持学术规范

**实现**:
```
✅ 双语:
content/publications/_index.md        # 英文列表页
content/zh/publications/_index.md     # 中文列表页

✅ 仅英文:
content/publications/paper1.md        # 论文详情（英文即可）
content/publications/paper2.md
```

---

## 🚀 快速命令

### 创建双语页面脚本

```bash
#!/bin/bash
# 使用方法: ./create-bilingual-page.sh page-name "English Title" "中文标题"

PAGE_NAME=$1
EN_TITLE=$2
ZH_TITLE=$3

# 创建英文页面
mkdir -p website/content/$PAGE_NAME
cat > website/content/$PAGE_NAME/_index.md << EOF
---
title: "$EN_TITLE"
description: ""
---

# $EN_TITLE

Your English content here...
EOF

# 创建中文页面
mkdir -p website/content/zh/$PAGE_NAME
cat > website/content/zh/$PAGE_NAME/_index.md << EOF
---
title: "$ZH_TITLE"
description: ""
---

# $ZH_TITLE

您的中文内容...
EOF

echo "✅ 已创建双语页面:"
echo "   英文: content/$PAGE_NAME/_index.md"
echo "   中文: content/zh/$PAGE_NAME/_index.md"
```

**使用**:
```bash
chmod +x create-bilingual-page.sh
./create-bilingual-page.sh "courses" "Courses" "课程"
```

---

## 🧪 测试验证

### 本地测试

```bash
# 1. 启动开发服务器
./dev.sh

# 2. 测试英文版
curl http://localhost:1313/yuzhang-lab-website/ | grep "Welcome"

# 3. 测试中文版
curl http://localhost:1313/yuzhang-lab-website/zh/ | grep "欢迎"

# 4. 检查语言切换器
# 浏览器访问，点击右上角语言切换
```

### 构建测试

```bash
# 生产构建
./build.sh

# 检查输出
ls website/public/zh/  # 应该看到中文页面

# 验证双语页面数量
find website/public -name "index.html" | wc -l
```

---

## 📊 当前状态

### ✅ 已完成

- [x] 双语配置文件 (`languages.toml`)
- [x] 启用语言切换器 (`show_language = true`)
- [x] 英文主页内容
- [x] 中文主页内容
- [x] 中文内容目录结构

### ⏳ 待完成

- [ ] 研究页面（英文+中文）
- [ ] 团队页面（英文+中文）
- [ ] 出版物页面（英文+中文列表）
- [ ] 招聘页面（英文+中文）
- [ ] 资源页面（英文+中文）

---

## 🎯 下一步行动

### 推荐工作流程

**Option A: 双语同步开发**（推荐）

```
Day 1-2: 主页（已完成 ✅）
  ├─ 英文主页 ✅
  └─ 中文主页 ✅

Day 3-4: 研究页面
  ├─ 英文研究页面
  └─ 中文研究页面

Day 5-6: 出版物页面
  ├─ 英文列表
  └─ 中文列表

Day 7: 团队页面
  ├─ 英文团队
  └─ 中文团队
```

**提交频率**: 每完成一组双语页面提交一次

**Option B: 先英文后中文**

```
Week 1: 完成所有英文内容
Week 2: 批量翻译为中文
```

---

## 📞 相关资源

- **Hugo多语言文档**: https://gohugo.io/content-management/multilingual/
- **Hugo Blox多语言**: https://docs.hugoblox.com/reference/
- **中文语言包**: `themes/hugo-blox-builder/modules/blox-tailwind/i18n/zh.yaml`

---

**最后更新**: 2025-10-26  
**适用版本**: Hugo v0.152.2 + Hugo Blox Builder
