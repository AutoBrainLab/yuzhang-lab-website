# ⚡ 快速开始指南

## 🎯 本地开发（推荐用于日常编辑）

### 一键启动开发服务器

```bash
# 方法1: 使用便捷脚本（推荐）
/mnt/data/hyf/yu_lab/dev.sh

# 方法2: 直接命令
cd /mnt/data/hyf/yu_lab/website
hugo server -D
```

**浏览器访问**: http://localhost:1313

**特性**:
- ⚡ 修改保存后 < 1秒 自动刷新浏览器
- 🔄 无需重启服务器
- 🚀 快速迭代，立即看到效果

---

## 📝 编辑内容

### 主页内容

```bash
vim /mnt/data/hyf/yu_lab/website/content/_index.md
# 或
code /mnt/data/hyf/yu_lab/website/content/_index.md
```

### 研究方向

```bash
vim /mnt/data/hyf/yu_lab/website/content/research/_index.md
```

### 添加出版物

```bash
# 方法1: 编辑BibTeX文件（推荐）
vim /mnt/data/hyf/yu_lab/website/data/publications.bib

# 方法2: 创建单独的Markdown
vim /mnt/data/hyf/yu_lab/website/content/publications/new-paper.md
```

### 团队成员

```bash
vim /mnt/data/hyf/yu_lab/website/content/people/_index.md
```

---

## ✅ 测试构建（推送前验证）

```bash
# 方法1: 使用便捷脚本
/mnt/data/hyf/yu_lab/build.sh

# 方法2: 直接命令
cd /mnt/data/hyf/yu_lab/website
hugo --gc --minify
```

**成功标志**: 显示 "Total in XXX ms"，无错误

---

## 🚀 推送到GitHub

```bash
cd /mnt/data/hyf/yu_lab

# 查看修改
git status

# 提交并推送
git add website/
git commit -m "feat: update content"
git push origin main
```

**自动部署**: 2-3分钟后访问 https://autobrainlab.github.io/yuzhang-lab-website/

---

## 📂 核心文件位置

```
/mnt/data/hyf/yu_lab/
├── dev.sh              # 🚀 开发服务器启动脚本
├── build.sh            # 🔨 构建测试脚本
├── website/
│   ├── content/        # 📝 网站内容（Markdown）
│   │   ├── _index.md           # 主页
│   │   ├── research/_index.md   # 研究方向
│   │   ├── people/_index.md     # 团队成员
│   │   ├── publications/        # 出版物
│   │   └── join-us/_index.md    # 招聘信息
│   ├── config/_default/         # ⚙️ 配置
│   │   ├── config.toml
│   │   ├── params.toml
│   │   └── menus.toml
│   └── data/
│       └── publications.bib     # 📚 出版物BibTeX
└── docs/
    └── LOCAL_DEVELOPMENT_GUIDE.md  # 📖 完整开发文档
```

---

## 🔥 常用命令速查

| 操作 | 命令 |
|------|------|
| **启动开发服务器** | `./dev.sh` 或 `hugo server -D` |
| **测试构建** | `./build.sh` 或 `hugo --gc --minify` |
| **停止服务器** | `Ctrl + C` |
| **查看修改** | `git status` |
| **提交推送** | `git add . && git commit -m "xxx" && git push` |

---

## 💡 开发工作流

```
1. 启动服务器        → ./dev.sh
2. 打开浏览器        → http://localhost:1313
3. 编辑内容文件      → vim website/content/_index.md
4. 保存查看效果      → 浏览器自动刷新
5. 满意后测试构建    → ./build.sh
6. 推送到GitHub     → git add . && git commit && git push
7. 等待2-3分钟      → 网站自动更新
```

---

## 🎓 下一步

- 📖 查看完整文档: [LOCAL_DEVELOPMENT_GUIDE.md](LOCAL_DEVELOPMENT_GUIDE.md)
- 📋 项目规划: [PROJECT_ANALYSIS.md](PROJECT_ANALYSIS.md)
- 🚀 部署指南: [GITHUB_PAGES_SETUP_GUIDE.md](GITHUB_PAGES_SETUP_GUIDE.md)

---

**现在就开始本地开发吧！** 🚀

```bash
./dev.sh
```
