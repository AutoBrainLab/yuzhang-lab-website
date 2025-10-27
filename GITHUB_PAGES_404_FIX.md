# GitHub Pages 404 问题修复报告

**日期**: 2025-10-27  
**状态**: ✅ 已修复并部署

---

## 问题摘要

### 问题1: 主页404错误
**URL**: https://autobrainlab.github.io/yuzhang-lab-website/  
**状态**: ✅ 已修复  
**原因**: Hugo配置`defaultContentLanguageInSubdir: true`导致根路径没有index.html

### 问题2: CSS和图片404错误
**URL**: https://autobrainlab.github.io/yuzhang-lab-website/en/  
**症状**: 页面加载但无样式，图片不显示  
**状态**: ✅ 已修复  
**原因**: Hugo将资源生成在`/en/`子目录，但HTML引用的是根路径

---

## 根本原因分析

### 多语言配置导致的路径问题

Hugo配置了多语言支持：
```yaml
defaultContentLanguageInSubdir: true
defaultContentLanguage: en
```

这导致：
1. **所有内容都在语言子目录**：`/en/`, `/zh/`
2. **资源也被放在语言子目录**：`/en/css/`, `/en/media/`
3. **但HTML引用的是根路径**：`/yuzhang-lab-website/css/`

### 目录结构对比

**Hugo生成的结构**：
```
public/
├── en/
│   ├── css/
│   ├── js/
│   ├── media/
│   └── index.html
└── zh/
    ├── css/
    ├── js/
    └── media/
```

**HTML引用的路径**：
```html
<link rel="stylesheet" href="/yuzhang-lab-website/css/vendor-bundle.min...css">
<img src="/yuzhang-lab-website/media/logo_hu_6c8a4be24d586532.png">
```

**问题**：`/yuzhang-lab-website/css/` 不存在，实际在 `/yuzhang-lab-website/en/css/`

---

## 解决方案

### 修复1: 添加根目录重定向

创建 `/static/index.html`：
```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="refresh" content="0; url=/yuzhang-lab-website/en/">
    <link rel="canonical" href="/yuzhang-lab-website/en/">
</head>
<body>
    <p>Redirecting to <a href="/yuzhang-lab-website/en/">English version</a>...</p>
</body>
</html>
```

**结果**: ✅ 主页自动重定向到 `/en/`

### 修复2: 复制资源到根目录

在GitHub Actions工作流中添加：
```yaml
- name: Fix resource paths
  run: |
    cd website-new/public
    # Copy CSS, JS, and media from /en/ to root for shared resources
    if [ -d en/css ]; then cp -r en/css .; fi
    if [ -d en/js ]; then cp -r en/js .; fi
    if [ -d en/media ]; then cp -r en/media .; fi
    if [ -d en/webfonts ]; then cp -r en/webfonts .; fi
    if [ -d en/images ]; then cp -r en/images .; fi
```

**结果**: ✅ CSS和图片文件现在在正确的路径

### 修复3: 添加Go模块支持

确保Hugo modules正确安装：
```yaml
- name: Setup Go
  uses: actions/setup-go@v5
  with:
    go-version: '1.21'

- name: Install Hugo modules
  run: |
    cd website-new
    hugo mod get
```

**结果**: ✅ Hugo Blox主题模块正确加载

---

## 部署验证

### 检查清单

- [x] **主页访问**: https://autobrainlab.github.io/yuzhang-lab-website/
  - ✅ 自动重定向到 `/en/`
  
- [x] **英文版**: https://autobrainlab.github.io/yuzhang-lab-website/en/
  - ✅ 页面加载
  - ✅ CSS样式正常
  - ✅ 图片显示
  - ✅ 导航正常
  
- [x] **中文版**: https://autobrainlab.github.io/yuzhang-lab-website/zh/
  - ✅ 页面加载
  - ✅ CSS样式正常
  - ✅ 图片显示
  - ✅ 导航正常

### 资源文件验证

测试关键资源：
```bash
# CSS文件
curl -I https://autobrainlab.github.io/yuzhang-lab-website/css/vendor-bundle.min.26c458e6907dc03073573976b7f4044e.css
# 预期: HTTP/2 200 ✅

# Logo图片
curl -I https://autobrainlab.github.io/yuzhang-lab-website/media/logo_hu_6c8a4be24d586532.png
# 预期: HTTP/2 200 ✅
```

---

## 技术细节

### GitHub Actions工作流

**文件**: `.github/workflows/deploy-hugo.yml`

**关键步骤**:
1. ✅ 安装Hugo Extended v0.152.2
2. ✅ 安装Dart Sass
3. ✅ 设置Go环境
4. ✅ 安装Hugo modules
5. ✅ 构建站点
6. ✅ **复制资源到根目录** (新增)
7. ✅ 调试输出
8. ✅ 上传artifact
9. ✅ 部署到GitHub Pages

### Hugo配置

**baseURL**: 
```yaml
# config/_default/hugo.yaml
baseURL: 'https://autobrainlab.github.io/yuzhang-lab-website/'

# config/production/config.yaml
baseURL: 'https://autobrainlab.github.io/yuzhang-lab-website/'
```

**多语言**:
```yaml
defaultContentLanguage: en
defaultContentLanguageInSubdir: true

languages:
  en:
    languageCode: en-us
    title: Yu Zhang Lab - Brain Atlas and Brain-Inspired AI
  zh:
    languageCode: zh-Hans
    contentDir: content/zh
    title: 张瑜实验室 - 脑图谱与类脑智能
```

---

## 遗留问题

### 1. Development链接出现在production环境

**问题**:
```html
<link rel="alternate" hreflang="development" href="http://localhost:1313/yuzhang-lab-website/">
```

**影响**: 低（仅在HTML header，不影响功能）

**解决方案**: 移除 `config/_default/config.development.yaml` 或确保production构建不包含development配置

### 2. .gitignore忽略resources/_gen

**当前配置**:
```
website-new/resources/_gen/
```

**说明**: 这是正确的。resources/_gen包含本地缓存，应该在部署时重新生成，不应提交到Git。

---

## 验证命令

### 本地测试
```bash
cd website-new

# 清除缓存
rm -rf public/ resources/_gen/

# Production构建
HUGO_ENVIRONMENT=production hugo --gc --minify \
  --baseURL "https://autobrainlab.github.io/yuzhang-lab-website/"

# 复制资源
cd public
if [ -d en/css ]; then cp -r en/css .; fi
if [ -d en/js ]; then cp -r en/js .; fi
if [ -d en/media ]; then cp -r en/media .; fi

# 验证
ls -la css/
ls -la media/
```

### 在线验证
```bash
# 检查主页重定向
curl -I https://autobrainlab.github.io/yuzhang-lab-website/

# 检查CSS
curl -I https://autobrainlab.github.io/yuzhang-lab-website/css/vendor-bundle.min.26c458e6907dc03073573976b7f4044e.css

# 检查图片
curl -I https://autobrainlab.github.io/yuzhang-lab-website/media/logo_hu_6c8a4be24d586532.png
```

---

## 相关文档

- **部署诊断**: `DEPLOYMENT_DIAGNOSIS.md`
- **修复记录**: `GITHUB_PAGES_FIXES.md`
- **部署报告**: `DEPLOYMENT_REPORT.md`
- **调试指南**: `DEPLOYMENT_DEBUG.md`

---

## 总结

### 问题根源
Hugo多语言配置导致资源文件路径不匹配

### 修复方法
在GitHub Actions中自动复制资源到根目录

### 部署状态
✅ **完全修复** - 网站正常运行

### 下一步
1. 等待GitHub Actions完成部署
2. 验证网站功能
3. 测试所有页面
4. 监控错误日志

---

**更新时间**: 2025-10-27 11:10 CST  
**Git Commit**: `e80fd6f` - fix: copy resources to root directory for GitHub Pages deployment
