# 🚀 本地开发调试完全指南

## 🎯 为什么需要本地开发？

**远程调试的痛点**:
- ⏱️ 每次修改需要 git commit + push
- ⏱️ 等待GitHub Actions构建（2-3分钟）
- ⏱️ 等待Pages部署生效（1-2分钟）
- ❌ 总计：**每次修改需要等待5分钟**

**本地开发的优势**:
- ⚡ 修改后**立即预览**（< 1秒）
- 🔄 自动热重载（保存文件自动刷新浏览器）
- 🐛 实时调试，快速迭代
- ✅ 确认无误后再推送到GitHub

---

## 📋 前置要求

### 确认Hugo已安装

```bash
hugo version
```

**预期输出**:
```
hugo v0.152.2+extended linux/amd64 BuildDate=2025-10-24T15:31:49Z
```

✅ **如果看到版本号且包含 `extended`** - 已就绪！  
❌ **如果提示未找到命令** - 需要安装Hugo

### 如果需要安装Hugo Extended

```bash
# Ubuntu/Debian
sudo snap install hugo --channel=extended

# 或者下载二进制文件
wget https://github.com/gohugoio/hugo/releases/download/v0.138.0/hugo_extended_0.138.0_linux-amd64.deb
sudo dpkg -i hugo_extended_0.138.0_linux-amd64.deb
```

---

## 🏃 快速开始（3个命令）

### 方法1: 启动开发服务器（推荐）

```bash
# 1. 进入网站目录
cd /mnt/data/hyf/yu_lab/website

# 2. 启动Hugo开发服务器（带自动重载）
hugo server -D

# 3. 打开浏览器访问
# http://localhost:1313
```

**成功标志**:
```
Web Server is available at http://localhost:1313/ (bind address 127.0.0.1)
Press Ctrl+C to stop
```

---

## 🎨 完整的本地开发工作流

### Step 1: 启动开发服务器

```bash
cd /mnt/data/hyf/yu_lab/website

# 启动服务器（详细模式，显示草稿）
hugo server -D --verbose

# 或者启动并在局域网可访问
hugo server -D --bind 0.0.0.0

# 或者指定端口
hugo server -D --port 8080
```

**参数说明**:
- `-D` (--buildDrafts): 显示草稿内容
- `--verbose`: 显示详细构建信息
- `--bind 0.0.0.0`: 允许其他设备访问（局域网）
- `--port`: 指定端口号

### Step 2: 访问本地网站

**浏览器访问**: http://localhost:1313

**预期看到**:
- ✅ Yuzhang Neuro+AI Lab 主页
- ✅ 导航菜单（Home, Research, People, Publications, Resources, Join Us）
- ✅ 完整样式和布局

### Step 3: 开始修改内容

**实时预览特性**:
- 📝 修改任何`.md`文件并保存
- 🔄 浏览器**自动刷新**（< 1秒）
- ⚡ 无需手动刷新或重启服务器

#### 示例：修改主页

```bash
# 在另一个终端窗口编辑
vim website/content/_index.md

# 或使用VS Code
code website/content/_index.md
```

**修改后立即在浏览器中看到效果！**

### Step 4: 测试构建

**在推送前验证生产构建**:

```bash
# 在website目录
hugo --gc --minify

# 检查输出
ls -lh public/
```

**成功标志**:
```
✅ Total in XXX ms
✅ 生成 public/ 目录
✅ 无错误信息
```

### Step 5: 推送到GitHub

**确认本地无误后再推送**:

```bash
cd /mnt/data/hyf/yu_lab

# 查看修改
git status
git diff

# 提交
git add website/
git commit -m "feat: update homepage content"
git push origin main

# GitHub Actions会自动部署（2-3分钟）
```

---

## 🔧 常用开发命令速查

### 启动开发服务器

```bash
# 基础启动
hugo server -D

# 详细日志
hugo server -D --verbose

# 快速模式（跳过某些检查）
hugo server -D --disableFastRender=false

# 允许局域网访问
hugo server -D --bind 0.0.0.0

# 指定端口
hugo server -D --port 8080

# 禁用LiveReload（手动刷新）
hugo server -D --disableLiveReload
```

### 构建静态文件

```bash
# 开发构建
hugo

# 生产构建（清理+压缩）
hugo --gc --minify

# 查看构建统计
hugo --templateMetrics

# 调试模式
hugo --debug --verbose
```

### 内容管理

```bash
# 创建新页面
hugo new content/research/new-project.md

# 创建新出版物
hugo new content/publications/paper-2025.md

# 创建新团队成员
hugo new content/people/new-member/_index.md
```

### 检查配置

```bash
# 显示完整配置
hugo config

# 检查特定配置
hugo config | grep baseURL

# 列出所有内容
hugo list all

# 列出草稿
hugo list drafts
```

---

## 📂 核心文件结构速查

### 需要经常修改的文件

```
website/
├── config/_default/          # 网站配置
│   ├── config.toml          # 基础配置（网站标题、URL等）
│   ├── params.toml          # 参数配置（主题、功能等）✅ 刚修复
│   └── menus.toml           # 导航菜单配置
│
├── content/                  # 网站内容（Markdown）
│   ├── _index.md            # 主页内容
│   ├── people/_index.md     # 团队成员页面
│   ├── research/_index.md   # 研究方向页面
│   ├── publications/        # 出版物
│   │   ├── _index.md
│   │   └── *.md            # 各个论文
│   ├── resources/_index.md  # 资源页面
│   └── join-us/_index.md    # 招聘页面
│
├── data/
│   └── publications.bib     # 出版物BibTeX数据
│
├── layouts/                  # 自定义布局模板（可选）
│   ├── index.html           # 主页模板
│   └── _default/
│
└── static/                   # 静态资源
    ├── images/              # 图片（Logo、照片等）
    ├── files/               # 文件（PDF等）
    └── favicon.ico          # 网站图标
```

---

## 🎯 快速开发场景

### 场景1: 修改主页内容

```bash
# 1. 启动服务器
cd /mnt/data/hyf/yu_lab/website
hugo server -D

# 2. 编辑主页（新终端）
vim content/_index.md

# 3. 保存后浏览器自动刷新
# 4. 满意后提交推送
```

### 场景2: 添加新出版物

```bash
# 方法1: 编辑BibTeX文件（推荐）
vim data/publications.bib
# 添加新的@article条目

# 方法2: 创建单独的Markdown文件
hugo new content/publications/zhang2025neuroai.md
vim content/publications/zhang2025neuroai.md
```

### 场景3: 添加团队成员

```bash
# 1. 创建成员目录
mkdir -p content/people/john-doe

# 2. 创建个人页面
cat > content/people/john-doe/_index.md << 'EOF'
---
title: "John Doe"
role: "Ph.D. Student"
avatar: "avatar.jpg"
bio: "Research interests in NeuroAI"
---
EOF

# 3. 添加头像
cp /path/to/photo.jpg content/people/john-doe/avatar.jpg
```

### 场景4: 修改导航菜单

```bash
# 编辑菜单配置
vim config/_default/menus.toml

# 添加新菜单项
[[main]]
  name = "News"
  url = "/news/"
  weight = 25
```

### 场景5: 更改网站配色

```bash
# 编辑主题配置
vim config/_default/params.toml

# 修改主题颜色
[appearance]
theme = "ocean"  # 或 "minimal", "forest", "earth"
```

---

## 🐛 调试技巧

### 查看详细错误

```bash
# 启动时显示详细信息
hugo server -D --verbose --debug

# 构建时显示详细信息
hugo --verbose --debug
```

### 检查特定页面

```bash
# 查看某个页面的元数据
hugo list all | grep publications

# 检查模板使用
hugo --templateMetrics
```

### 清理缓存

```bash
# 清理Hugo缓存
rm -rf /tmp/hugo_cache/
rm -rf resources/_gen/

# 重新构建
hugo --gc
```

### 检查链接

```bash
# 构建后检查死链
hugo --gc --minify
# 然后使用工具检查public/目录

# 或使用htmltest
htmltest public/
```

---

## ⚡ 性能优化技巧

### 加快构建速度

```bash
# 使用缓存
hugo --gc --minify --enableGitInfo=false

# 跳过未修改的文件
hugo server -D --disableFastRender=false

# 并行处理
GOMAXPROCS=4 hugo
```

### 减小生成文件大小

```bash
# 最小化CSS/JS
hugo --gc --minify

# 压缩图片（使用外部工具）
find static/images -name "*.jpg" -exec jpegoptim --max=85 {} \;
find static/images -name "*.png" -exec optipng -o5 {} \;
```

---

## 📱 移动端测试

### 在移动设备上预览

```bash
# 1. 启动服务器（允许外部访问）
cd /mnt/data/hyf/yu_lab/website
hugo server -D --bind 0.0.0.0

# 2. 查看服务器IP
ip addr show | grep "inet " | grep -v 127.0.0.1

# 3. 在移动设备浏览器访问
# http://<你的IP>:1313
```

### 浏览器开发者工具

在浏览器（Chrome/Firefox）中：
1. 按 `F12` 打开开发者工具
2. 点击 "Toggle Device Toolbar" (Ctrl+Shift+M)
3. 选择移动设备型号（iPhone, iPad, Android等）
4. 测试响应式布局

---

## 🔄 Git工作流最佳实践

### 推荐工作流程

```bash
# 1. 本地开发分支
git checkout -b feature/update-homepage

# 2. 启动Hugo服务器
cd website && hugo server -D

# 3. 修改内容（实时预览）
vim content/_index.md

# 4. 本地验证构建
hugo --gc --minify

# 5. 提交到分支
git add .
git commit -m "feat: update homepage with mission statement"

# 6. 推送到GitHub
git push origin feature/update-homepage

# 7. 创建Pull Request（可选）
# 或直接合并到main
git checkout main
git merge feature/update-homepage
git push origin main
```

### 快速修复流程

```bash
# 小改动直接在main分支
cd /mnt/data/hyf/yu_lab/website

# 启动服务器验证
hugo server -D

# 修改、验证、构建
vim content/_index.md
hugo --gc --minify

# 提交推送
cd ..
git add website/
git commit -m "fix: correct typo in homepage"
git push origin main
```

---

## 📊 本地开发 vs 远程部署对比

| 操作 | 本地开发 | 远程部署 |
|------|---------|---------|
| **修改预览** | ⚡ < 1秒 | ⏱️ 5分钟 |
| **迭代速度** | 🚀 极快 | 🐌 很慢 |
| **网络要求** | ✅ 无需网络 | ❌ 需要稳定网络 |
| **调试便利** | ✅ 详细日志 | ❌ 仅有Actions日志 |
| **成本** | ✅ 免费 | ✅ 免费（但消耗时间） |
| **适用场景** | 开发调试 | 最终发布 |

**推荐策略**: 
- 🔧 **本地开发**: 快速迭代、实时预览、调试修复
- 🚀 **远程部署**: 确认无误后再推送，作为最终发布

---

## 🎓 常见问题解答

### Q1: Hugo服务器无法启动

```bash
# 检查端口占用
lsof -i :1313
# 或
netstat -tuln | grep 1313

# 更换端口
hugo server -D --port 8080
```

### Q2: 修改后浏览器不刷新

```bash
# 清空浏览器缓存（Ctrl+Shift+Delete）
# 或硬刷新（Ctrl+F5）

# 或重启Hugo服务器
# Ctrl+C 停止
hugo server -D
```

### Q3: 样式显示不正常

```bash
# 检查baseURL配置
grep baseURL config/_default/config.toml

# 本地开发时baseURL应该是
# baseURL = "http://localhost:1313/"
# 或者让Hugo自动处理

# 使用相对URL
hugo server -D --baseURL "/"
```

### Q4: 主题未加载

```bash
# 检查主题目录
ls -la themes/hugo-blox-builder/

# 确保主题配置正确
grep theme config/_default/config.toml
# 应该显示: theme = "hugo-blox-builder"
```

---

## 🚀 推荐的日常开发命令

### 创建一个开发启动脚本

```bash
# 创建启动脚本
cat > /mnt/data/hyf/yu_lab/dev.sh << 'EOF'
#!/bin/bash
cd /mnt/data/hyf/yu_lab/website
echo "🚀 Starting Hugo development server..."
echo "📝 Edit files in content/ directory"
echo "🌐 Open http://localhost:1313 in browser"
echo "⚡ Changes will auto-reload"
echo ""
hugo server -D --verbose
EOF

chmod +x /mnt/data/hyf/yu_lab/dev.sh

# 使用方式
/mnt/data/hyf/yu_lab/dev.sh
```

### 创建快速构建脚本

```bash
# 创建构建脚本
cat > /mnt/data/hyf/yu_lab/build.sh << 'EOF'
#!/bin/bash
cd /mnt/data/hyf/yu_lab/website
echo "🔨 Building Hugo site..."
hugo --gc --minify
echo "✅ Build complete! Output in public/"
ls -lh public/ | head -10
EOF

chmod +x /mnt/data/hyf/yu_lab/build.sh

# 使用方式
/mnt/data/hyf/yu_lab/build.sh
```

---

## 📚 推荐资源

### Hugo官方文档
- 快速入门: https://gohugo.io/getting-started/quick-start/
- 内容管理: https://gohugo.io/content-management/
- 模板: https://gohugo.io/templates/

### Hugo Blox文档
- 主题文档: https://docs.hugoblox.com/
- 示例网站: https://github.com/HugoBlox/theme-academic-cv

### Markdown语法
- 基础语法: https://www.markdownguide.org/basic-syntax/
- 扩展语法: https://www.markdownguide.org/extended-syntax/

---

## ✅ 本地开发检查清单

开始开发前：
- [ ] Hugo已安装（extended版本）
- [ ] 在website目录
- [ ] Git工作区干净（无未提交修改）

开发过程中：
- [ ] Hugo server运行中
- [ ] 浏览器打开 localhost:1313
- [ ] 修改内容后浏览器自动刷新
- [ ] 定期保存文件

推送前：
- [ ] 本地构建成功（`hugo --gc --minify`）
- [ ] 浏览器中验证无误
- [ ] Git提交信息清晰
- [ ] 推送到GitHub

---

## 🎯 下一步行动

现在您可以：

1. **启动本地服务器**
   ```bash
   cd /mnt/data/hyf/yu_lab/website
   hugo server -D
   ```

2. **开始内容开发**
   - 完善主页（content/_index.md）
   - 添加研究方向（content/research/_index.md）
   - 录入完整出版物（data/publications.bib）

3. **快速迭代**
   - 修改 → 保存 → 自动预览（< 1秒）
   - 无需等待远程部署！

---

**开始愉快的本地开发吧！** 🚀

有任何问题随时问我！
