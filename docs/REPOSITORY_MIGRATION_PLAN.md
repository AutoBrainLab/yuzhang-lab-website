# Git仓库架构升级方案 - 从子目录到统一根目录

## 📋 当前状态分析

### 现有结构
```
/mnt/data/hyf/yu_lab/
├── PROJECT_ANALYSIS_AND_DEVELOPMENT_PLAN.md  # 项目规划文档
├── hugo.tar.gz                                # Hugo压缩包（可删除）
├── doc/                                       # 文档目录
│   ├── CV_yuzhang_update_June2025.pdf
│   ├── CV_yuzhang_update_June2025.txt
│   ├── GEMINI.md
│   ├── Neuro+AI 实验室网站建设指南.md
│   └── PROJECT_DEVELOPMENT_DOCUMENT.md
└── yuzhang-lab-website/                       # 网站代码（当前Git根目录）
    ├── .git/                                  # 子目录Git仓库
    ├── hugo.toml
    ├── config/
    ├── content/
    └── ...
```

### 问题识别
1. ✅ Git仓库在 `yuzhang-lab-website/` 子目录
2. ❌ 文档和网站代码分离，管理不便
3. ❌ `hugo.tar.gz` 冗余文件
4. ❌ 项目规划文档不在版本控制中

---

## 🎯 升级目标架构

### 推荐的新结构
```
/mnt/data/hyf/yu_lab/  (新的Git根目录)
├── .git/                              # 根目录Git仓库
├── .github/
│   └── workflows/
│       └── deploy.yml                 # Hugo自动部署配置
├── .gitignore                         # 统一的Git忽略规则
├── README.md                          # 项目总览
├── docs/                              # 重命名：文档目录
│   ├── PROJECT_ANALYSIS.md
│   ├── DEVELOPMENT_PLAN.md
│   ├── WEBSITE_GUIDE.md
│   ├── CV_yuzhang_2025.pdf
│   └── references/                    # 参考资料
│       └── GEMINI.md
├── website/                           # 重命名：Hugo网站源码
│   ├── hugo.toml
│   ├── config/
│   ├── content/
│   ├── layouts/
│   ├── static/
│   ├── themes/
│   └── public/                        # (Git忽略)
└── scripts/                           # 新增：辅助脚本
    ├── deploy.sh
    ├── update_publications.py
    └── backup.sh
```

### 设计原则
1. **单一职责**: 每个目录功能明确
2. **版本控制**: 所有重要文件纳入Git管理
3. **自动化**: CI/CD在根目录配置，管理Hugo构建
4. **可扩展**: 预留scripts、assets等目录
5. **清晰命名**: 使用英文目录名，符合国际规范

---

## 📝 详细迁移步骤

### Phase 1: 准备工作（安全第一）

#### Step 1.1: 备份当前数据
```bash
cd /mnt/data/hyf
tar -czf yu_lab_backup_$(date +%Y%m%d_%H%M%S).tar.gz yu_lab/
```

#### Step 1.2: 检查远程仓库配置
```bash
cd /mnt/data/hyf/yu_lab/yuzhang-lab-website
git remote -v
# 确认：origin git@github.com:AutoBrainLab/yuzhang-lab-website.git
```

### Phase 2: 目录重构

#### Step 2.1: 重命名目录
```bash
cd /mnt/data/hyf/yu_lab

# 重命名文档目录
mv doc docs

# 重命名网站目录（保留子目录Git历史）
mv yuzhang-lab-website website
```

#### Step 2.2: 清理冗余文件
```bash
# 删除Hugo安装包（已不需要）
rm -f hugo.tar.gz

# 清理Hugo缓存
rm -f website/.hugo_build.lock
rm -rf website/public
```

### Phase 3: Git仓库重组

#### Step 3.1: 保存子仓库的远程配置
```bash
cd /mnt/data/hyf/yu_lab/website
REMOTE_URL=$(git remote get-url origin)
echo "保存的远程仓库: $REMOTE_URL"
```

#### Step 3.2: 移除子目录的Git配置
```bash
# 移除website子目录的Git仓库（保留文件）
cd /mnt/data/hyf/yu_lab/website
rm -rf .git

# 处理主题子模块（保留文件，移除Git）
cd themes/hugo-blox-builder
rm -rf .git
cd /mnt/data/hyf/yu_lab
```

#### Step 3.3: 在根目录初始化新Git仓库
```bash
cd /mnt/data/hyf/yu_lab

# 初始化Git
git init

# 添加远程仓库
git remote add origin git@github.com:AutoBrainLab/yuzhang-lab-website.git

# 设置主分支
git branch -M main
```

### Phase 4: 配置文件创建

#### Step 4.1: 创建 `.gitignore`
```gitignore
# Hugo generated files
website/public/
website/resources/_gen/
website/.hugo_build.lock

# OS files
.DS_Store
Thumbs.db
*.swp
*.swo
*~

# Editor
.vscode/
.idea/
*.code-workspace

# Temporary files
*.log
*.tmp
node_modules/
__pycache__/
*.pyc

# Backups
*.tar.gz
*.zip
*.bak

# Personal notes (if any)
NOTES_PRIVATE.md
```

#### Step 4.2: 创建根目录 `README.md`
```markdown
# Yuzhang Neuro+AI Lab - Digital Assets Repository

Official repository for the Yuzhang Neuro+AI Laboratory's digital presence and documentation.

## 📁 Repository Structure

```
yu_lab/
├── .github/workflows/     # CI/CD automation
├── docs/                  # Project documentation
├── website/               # Hugo-based lab website
└── scripts/               # Utility scripts
```

## 🌐 Website

**Live URL**: https://autobrainlab.github.io/yuzhang-lab-website/

**Technology Stack**:
- Hugo (Static Site Generator)
- Hugo Blox Builder Theme
- GitHub Pages (Hosting)
- GitHub Actions (CI/CD)

## 🚀 Quick Start

### Prerequisites
- Hugo Extended v0.138.0+
- Git

### Local Development
```bash
cd website
hugo server -D
# Visit http://localhost:1313
```

### Build for Production
```bash
cd website
hugo --gc --minify
```

## 📚 Documentation

- [Project Analysis & Development Plan](docs/PROJECT_ANALYSIS.md)
- [Website Building Guide](docs/WEBSITE_GUIDE.md)

## 🔄 Deployment

The website is automatically deployed to GitHub Pages when changes are pushed to the `main` branch.

## 📧 Contact

**Principal Investigator**: Dr. Yu Zhang  
**Email**: yuzhang2bic@gmail.com  
**Lab Website**: https://autobrainlab.github.io/yuzhang-lab-website/

## 📄 License

Copyright © 2025 Yuzhang Neuro+AI Lab. All rights reserved.
```

#### Step 4.3: 创建 `.github/workflows/deploy.yml`
```yaml
name: Deploy Hugo Website to GitHub Pages

on:
  push:
    branches: ["main"]
    paths:
      - 'website/**'
      - '.github/workflows/deploy.yml'
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

defaults:
  run:
    shell: bash

jobs:
  build:
    runs-on: ubuntu-latest
    env:
      HUGO_VERSION: 0.138.0
    steps:
      - name: Install Hugo CLI
        run: |
          wget -O ${{ runner.temp }}/hugo.deb https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb \
          && sudo dpkg -i ${{ runner.temp }}/hugo.deb
      
      - name: Checkout
        uses: actions/checkout@v4
        with:
          submodules: recursive
          fetch-depth: 0
      
      - name: Setup Pages
        id: pages
        uses: actions/configure-pages@v5
      
      - name: Build with Hugo
        env:
          HUGO_CACHEDIR: ${{ runner.temp }}/hugo_cache
          HUGO_ENVIRONMENT: production
        run: |
          cd website
          hugo \
            --gc \
            --minify \
            --baseURL "${{ steps.pages.outputs.base_url }}/"
      
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./website/public

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

### Phase 5: 文档整理

#### Step 5.1: 重组文档文件
```bash
cd /mnt/data/hyf/yu_lab/docs

# 重命名文档以保持一致性
mv "Neuro+AI 实验室网站建设指南.md" WEBSITE_GUIDE.md
mv PROJECT_DEVELOPMENT_DOCUMENT.md DEVELOPMENT_PLAN.md
mv ../PROJECT_ANALYSIS_AND_DEVELOPMENT_PLAN.md PROJECT_ANALYSIS.md

# 重命名CV文件
mv CV_yuzhang_update_June2025.pdf CV_yuzhang_2025.pdf
mv CV_yuzhang_update_June2025.txt CV_yuzhang_2025.txt

# 创建参考资料子目录
mkdir -p references
mv GEMINI.md references/
```

### Phase 6: 首次提交

#### Step 6.1: 添加所有文件
```bash
cd /mnt/data/hyf/yu_lab

# 查看将被添加的文件
git status

# 分阶段添加（便于检查）
git add .gitignore
git add .github/
git add README.md
git add docs/
git add website/
```

#### Step 6.2: 创建有意义的提交
```bash
git commit -m "chore: migrate repository structure to unified root directory

- Restructure repository with docs/ and website/ subdirectories
- Add GitHub Actions workflow for automated Hugo deployment
- Create comprehensive .gitignore for Hugo and general files
- Add root-level README with project overview
- Organize documentation in docs/ directory
- Rename website directory for clarity

Breaking Change: Repository structure changed from yuzhang-lab-website/
to yu_lab/ root with website/ subdirectory. Update local clones accordingly.
"
```

#### Step 6.3: 推送到GitHub（强制更新）
```bash
# 由于仓库结构完全改变，需要强制推送
git push -f origin main

# 注意：这会覆盖远程仓库的历史！
# 如果团队有其他成员，务必提前通知
```

### Phase 7: GitHub仓库设置

#### Step 7.1: 更新GitHub Pages配置
1. 访问: https://github.com/AutoBrainLab/yuzhang-lab-website/settings/pages
2. Source: 选择 "GitHub Actions"
3. 保存设置

#### Step 7.2: 触发首次部署
```bash
# 做一个小改动触发部署
cd /mnt/data/hyf/yu_lab/website
echo "# Test deployment" >> content/_index.md
cd ..
git add website/content/_index.md
git commit -m "test: trigger first deployment"
git push origin main
```

#### Step 7.3: 验证部署
1. 访问 Actions 页面查看工作流运行
2. 等待部署完成（约2-3分钟）
3. 访问网站: https://autobrainlab.github.io/yuzhang-lab-website/

---

## ✅ 迁移后验证清单

### 文件结构验证
- [ ] `yu_lab/` 是Git根目录
- [ ] `.github/workflows/deploy.yml` 存在
- [ ] `website/` 包含完整Hugo网站
- [ ] `docs/` 包含所有文档
- [ ] `README.md` 在根目录
- [ ] `.gitignore` 配置正确

### Git配置验证
```bash
cd /mnt/data/hyf/yu_lab
git remote -v  # 应显示正确的origin
git branch     # 应显示main分支
git log -1     # 应显示最近提交
```

### 部署验证
- [ ] GitHub Actions工作流运行成功
- [ ] 网站可以访问
- [ ] 网站内容正确显示
- [ ] 无broken links

### 功能验证
```bash
# 本地构建测试
cd website
hugo server -D
# 访问 http://localhost:1313 确认正常
```

---

## 🔄 团队成员迁移指南

如果有其他团队成员正在使用此仓库：

### 对于已clone的成员
```bash
# 备份本地更改（如有）
cd path/to/yuzhang-lab-website
git stash

# 删除旧仓库
cd ..
rm -rf yuzhang-lab-website

# 重新克隆新结构
git clone git@github.com:AutoBrainLab/yuzhang-lab-website.git yu_lab
cd yu_lab

# 现在工作目录是 yu_lab/website/
```

---

## 📊 迁移前后对比

| 方面 | 迁移前 | 迁移后 | 改进 |
|-----|--------|--------|------|
| **Git根目录** | `yuzhang-lab-website/` | `yu_lab/` | ✅ 统一管理 |
| **文档管理** | 不在版本控制 | `docs/` 纳入Git | ✅ 版本追踪 |
| **CI/CD配置** | 无 | `.github/workflows/` | ✅ 自动化部署 |
| **目录结构** | 单一功能 | 多功能组织 | ✅ 可扩展性 |
| **项目README** | 无 | 根目录完整说明 | ✅ 新人友好 |
| **备份便利性** | 需手动备份多处 | 一键备份根目录 | ✅ 操作简化 |

---

## 🎯 迁移后的工作流程

### 日常开发
```bash
cd /mnt/data/hyf/yu_lab

# 修改网站内容
cd website
vim content/publications/_index.md

# 本地预览
hugo server -D

# 提交更改
cd ..
git add website/content/
git commit -m "feat: add new publication"
git push origin main

# 自动触发部署！
```

### 文档更新
```bash
cd /mnt/data/hyf/yu_lab/docs
vim PROJECT_ANALYSIS.md

cd ..
git add docs/
git commit -m "docs: update project analysis"
git push origin main
```

### 添加脚本
```bash
cd /mnt/data/hyf/yu_lab
mkdir -p scripts

# 创建发布脚本
cat > scripts/deploy.sh << 'EOF'
#!/bin/bash
cd website
hugo --gc --minify
echo "Build completed!"
EOF

chmod +x scripts/deploy.sh
git add scripts/
git commit -m "chore: add deployment script"
git push origin main
```

---

## ⚠️ 重要注意事项

### 1. 强制推送警告
- ⚠️ `git push -f` 会覆盖远程历史
- ✅ 本项目目前只有您一人，安全执行
- ⚠️ 如有团队成员，需提前同步

### 2. GitHub Pages设置
- 部署源必须改为 "GitHub Actions"
- 旧的 `gh-pages` 分支可以删除

### 3. Hugo配置调整
```toml
# website/hugo.toml 可能需要更新
baseURL = "https://autobrainlab.github.io/yuzhang-lab-website/"
# 保持不变，因为GitHub仓库名未改变
```

### 4. 主题作为普通目录
- Hugo Blox主题不再作为Git子模块
- 直接包含在仓库中，便于自定义
- 缺点：无法自动更新主题（需手动）

---

## 🚀 执行时间估算

| 阶段 | 预计时间 | 复杂度 |
|-----|---------|--------|
| Phase 1: 备份与检查 | 5分钟 | 低 |
| Phase 2: 目录重构 | 10分钟 | 低 |
| Phase 3: Git重组 | 15分钟 | 中 |
| Phase 4: 配置文件 | 20分钟 | 中 |
| Phase 5: 文档整理 | 10分钟 | 低 |
| Phase 6: 首次提交 | 10分钟 | 低 |
| Phase 7: GitHub设置 | 10分钟 | 低 |
| **总计** | **80分钟** | - |

---

## 📋 执行检查清单

### 迁移前
- [ ] 阅读完整迁移计划
- [ ] 备份当前数据
- [ ] 确认无其他团队成员正在工作
- [ ] 准备好GitHub访问权限

### 迁移中
- [ ] 完成目录重命名
- [ ] 移除子Git配置
- [ ] 创建根Git仓库
- [ ] 添加所有配置文件
- [ ] 执行首次提交

### 迁移后
- [ ] 验证Git配置
- [ ] 测试本地Hugo构建
- [ ] 确认GitHub Actions运行
- [ ] 访问网站验证部署
- [ ] 更新本地工作流程

---

## 🆘 故障排查

### 问题1: 推送被拒绝
```bash
# 如果遇到 "Updates were rejected"
git push -f origin main  # 强制推送
```

### 问题2: GitHub Actions失败
- 检查 `website/` 路径是否正确
- 确认Hugo配置文件完整
- 查看Actions日志详细错误

### 问题3: 网站404
- 检查GitHub Pages设置
- 确认部署已完成
- 检查baseURL配置

### 问题4: 本地构建失败
```bash
cd website
hugo version  # 确认Hugo版本
hugo --debug  # 查看详细错误
```

---

## 📅 建议执行时间

**最佳时间**: 
- 工作日下午（有完整时间处理问题）
- 非紧急期（避免影响招聘等关键活动）
- 确保网络稳定

**准备事项**:
1. 预留2小时不被打断的时间
2. 确保Git和SSH配置正确
3. 准备好查看GitHub Actions日志

---

## ✨ 迁移完成后的优势

1. ✅ **统一管理**: 所有资料在一个仓库
2. ✅ **版本控制**: 文档、网站代码全部追踪
3. ✅ **自动部署**: 推送即部署，无需手动
4. ✅ **结构清晰**: 目录职责分明
5. ✅ **易于扩展**: 可轻松添加新功能目录
6. ✅ **团队友好**: 完整README和文档
7. ✅ **备份简单**: 一个目录打包所有
8. ✅ **专业形象**: 符合开源项目最佳实践

---

**准备好开始迁移了吗？** 🚀

建议：我可以帮您逐步执行，或者您可以先在测试目录练习一次。
