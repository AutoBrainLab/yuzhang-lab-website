# GitHub Pages 配置与验证指南

## 🎯 配置目标

验证并启用GitHub Pages自动部署，确保网站可以从GitHub Actions自动发布。

---

## 📋 配置步骤（需要3-5分钟）

### Step 1: 访问仓库设置

**URL**: https://github.com/AutoBrainLab/yuzhang-lab-website/settings/pages

**具体操作**:
1. 打开浏览器
2. 访问上述URL
3. 如果需要登录，使用您的GitHub账号

---

### Step 2: 配置Pages源

在 **Build and deployment** 部分：

#### 当前可能的状态

**场景A: 如果显示 "Source: Deploy from a branch"**
```
需要更改为：
Source: GitHub Actions ← 选择这个
```

**场景B: 如果显示 "Source: GitHub Actions"**
```
✅ 已正确配置！无需更改
```

#### 正确的配置

```
Build and deployment
├── Source: [GitHub Actions] ← 必须选择此项
└── (不需要选择分支)
```

**为什么选择GitHub Actions**:
- ✅ 我们的工作流 `.github/workflows/deploy.yml` 会自动构建Hugo
- ✅ 自动部署到Pages
- ✅ 每次推送到main分支自动触发

---

### Step 3: 保存设置

1. 确认 **Source** 为 "GitHub Actions"
2. 如果修改了，页面会自动保存
3. 等待几秒钟，页面可能会刷新

---

### Step 4: 检查Actions运行状态

**URL**: https://github.com/AutoBrainLab/yuzhang-lab-website/actions

#### 预期看到的内容

```
工作流列表：
├── Deploy Hugo Website to GitHub Pages
│   └── chore: migrate repository structure... (最新运行)
│       ├── 状态: ⏳ In progress (正在运行)
│       │      或 ✅ Success (成功)
│       │      或 ❌ Failure (失败)
│       └── 触发者: push to main
```

#### 如果工作流尚未运行

**原因**: 工作流配置了路径过滤器 `paths: ['website/**']`，只有website目录变化才触发

**解决方案**: 触发一次手动部署

```bash
# 方法1: 在website目录做一个小改动
cd /mnt/data/hyf/yu_lab/website
echo "# Updated on $(date)" >> content/_index.md
cd ..
git add website/content/_index.md
git commit -m "chore: trigger initial deployment"
git push origin main
```

**或者使用GitHub网页手动触发**:
1. 访问 Actions 页面
2. 点击左侧 "Deploy Hugo Website to GitHub Pages"
3. 点击右侧 "Run workflow" 按钮
4. 点击绿色 "Run workflow" 确认

---

### Step 5: 监控部署进度

点击进入正在运行的工作流：

#### 构建阶段 (build)
```
预期步骤：
✅ Install Hugo CLI
✅ Checkout
✅ Setup Pages
✅ Build with Hugo
✅ Upload artifact
```

**预计时间**: 1-2分钟

#### 部署阶段 (deploy)
```
预期步骤：
✅ Deploy to GitHub Pages
```

**预计时间**: 30秒-1分钟

#### 成功标志
```
✅ 两个任务都显示绿色对勾
✅ 显示 "This workflow run completed successfully"
```

---

### Step 6: 验证网站访问

**等待时间**: 部署成功后30秒-2分钟

**网站URL**: https://autobrainlab.github.io/yuzhang-lab-website/

#### 检查清单

访问网站后，检查：

1. **✅ 网站可以访问** (没有404错误)
2. **✅ 主页显示**
   - 标题: "Yuzhang Neuro+AI Lab"
   - 欢迎语: "Welcome to the Yuzhang Neuro+AI Lab!"
   
3. **✅ 导航菜单存在**
   - Home
   - Research
   - People
   - Publications
   - Resources
   - Join Us

4. **✅ Publications页面**
   - 访问: https://autobrainlab.github.io/yuzhang-lab-website/publications/
   - 应该看到5篇论文列表

5. **✅ People页面**
   - 访问: https://autobrainlab.github.io/yuzhang-lab-website/people/
   - 应该看到Dr. Yu Zhang的信息

---

## 🔍 常见问题排查

### 问题1: Actions页面没有工作流运行

**原因**: 
- 工作流只监听 `website/**` 路径的变化
- 首次推送的提交没有修改website目录

**解决**:
```bash
cd /mnt/data/hyf/yu_lab
# 触发一个小改动
echo "" >> website/content/_index.md
git add website/content/_index.md
git commit -m "chore: trigger deployment"
git push origin main
```

---

### 问题2: 工作流运行失败

**检查步骤**:
1. 点击失败的工作流
2. 查看具体哪个步骤失败
3. 展开失败步骤查看错误日志

**常见错误及解决**:

#### 错误: "Hugo command not found"
```
原因: Hugo未正确安装
解决: 检查 .github/workflows/deploy.yml 中Hugo版本配置
```

#### 错误: "Error building site"
```
原因: Hugo网站配置错误
解决: 本地测试
cd website
hugo --gc --minify
```

#### 错误: "Permission denied"
```
原因: GitHub Pages权限未设置
解决: 
1. Settings → Actions → General
2. Workflow permissions
3. 选择 "Read and write permissions"
4. 勾选 "Allow GitHub Actions to create and approve pull requests"
5. Save
```

---

### 问题3: 部署成功但网站404

**可能原因**:

#### A. GitHub Pages未启用
```
解决: 
Settings → Pages → Source → GitHub Actions
```

#### B. baseURL配置错误
```
检查: website/hugo.toml
应该是: baseURL = "https://autobrainlab.github.io/yuzhang-lab-website/"
```

#### C. 等待时间不够
```
解决: 等待2-5分钟，GitHub Pages需要时间生效
```

---

### 问题4: 网站显示但样式丢失

**原因**: CSS/JS路径问题

**检查**:
```bash
cd /mnt/data/hyf/yu_lab/website
grep baseURL hugo.toml
# 应该看到: baseURL = "https://autobrainlab.github.io/yuzhang-lab-website/"
```

---

## 📊 验证清单

请按照以下清单逐项检查：

### GitHub仓库配置
- [ ] Settings → Pages → Source 设置为 "GitHub Actions"
- [ ] Settings → Actions → General → Workflow permissions 为 "Read and write"

### GitHub Actions
- [ ] Actions页面能看到工作流
- [ ] 工作流已触发运行（或手动触发）
- [ ] build任务成功 ✅
- [ ] deploy任务成功 ✅

### 网站访问
- [ ] https://autobrainlab.github.io/yuzhang-lab-website/ 可访问
- [ ] 主页内容正常显示
- [ ] 导航菜单工作正常
- [ ] Publications页面显示5篇论文
- [ ] People页面显示PI信息
- [ ] 样式和格式正确（无CSS丢失）

### 功能测试
- [ ] 点击导航菜单可以切换页面
- [ ] 移动端访问正常（可选）
- [ ] 页面加载速度 < 3秒

---

## 🚀 触发首次部署的推荐方法

如果工作流还未运行，执行以下命令：

```bash
cd /mnt/data/hyf/yu_lab

# 在主页添加一行空白（触发website目录变化）
echo "" >> website/content/_index.md

# 提交并推送
git add website/content/_index.md
git commit -m "chore: trigger initial GitHub Pages deployment"
git push origin main

# 然后访问Actions页面查看部署进度
```

**预期时间线**:
- 0:00 - 推送到GitHub
- 0:10 - 工作流开始运行
- 1:30 - 构建完成
- 2:00 - 部署完成
- 2:30 - 网站可访问

---

## 📸 预期截图说明

### GitHub Pages设置页面应该显示：

```
GitHub Pages
├── Your site is live at 
│   https://autobrainlab.github.io/yuzhang-lab-website/
│
└── Build and deployment
    └── Source: [GitHub Actions]
```

### Actions页面应该显示：

```
All workflows
└── Deploy Hugo Website to GitHub Pages
    └── ✅ chore: trigger initial deployment
        ├── Triggered: push
        ├── Duration: ~2 minutes
        └── Status: Success
```

---

## 🎯 成功标准

完成后您应该能：

1. ✅ 访问 https://autobrainlab.github.io/yuzhang-lab-website/
2. ✅ 看到完整的实验室网站
3. ✅ 每次推送website目录变化自动部署
4. ✅ 2-3分钟内更新生效

---

## 📞 如需帮助

如果遇到问题：

1. **检查Actions日志** - 查看具体错误信息
2. **参考文档**:
   - PROJECT_ANALYSIS.md - 完整开发规划
   - REPOSITORY_MIGRATION_PLAN.md - 仓库结构说明
3. **常见解决方案**: 
   - 清空浏览器缓存
   - 等待5分钟后重试
   - 检查GitHub服务状态: https://www.githubstatus.com/

---

## ✅ 下一步

验证成功后：

1. **开始内容开发** - 完善主页、添加研究方向
2. **录入完整出版物** - 从5篇扩展到40+篇  
3. **创建团队页面** - 添加成员信息
4. **设计视觉元素** - Logo、配色方案

参考: [PROJECT_ANALYSIS.md](PROJECT_ANALYSIS.md) 第一阶段MVP开发计划

---

**创建时间**: 2025-10-26  
**适用版本**: 迁移后的统一仓库结构  
**预计完成时间**: 3-5分钟
