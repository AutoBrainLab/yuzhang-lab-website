# GitHub Pages 部署问题诊断总结

## 问题概述

**报告时间**: 2025-10-27 09:04  
**修复时间**: 2025-10-27 09:15  
**状态**: ✅ 已修复，等待部署

---

## 🔴 问题清单

| # | 问题描述 | 严重性 | 状态 |
|---|---------|--------|------|
| 1 | 主页404错误 | 🔴 高 | ✅ 已修复 |
| 2 | CSS样式丢失 | 🔴 高 | ✅ 已修复 |
| 3 | 图片无法显示 | 🔴 高 | ✅ 已修复 |
| 4 | localhost链接 | 🟡 中 | ✅ 已修复 |

---

## 📊 问题分析

### 问题1: 主页404错误

**URL**: `https://autobrainlab.github.io/yuzhang-lab-website/`

**症状**:
```bash
curl -I https://autobrainlab.github.io/yuzhang-lab-website/
HTTP/2 404 ❌
```

**根本原因**:
- Hugo配置 `defaultContentLanguageInSubdir: true`
- 根路径没有index.html
- 所有内容都在 `/en/` 和 `/zh/` 子目录

**修复方案**:
- 在 `static/` 目录创建重定向 `index.html`
- 自动跳转到 `/en/`

---

### 问题2&3: CSS和图片404

**症状**:
```bash
# CSS文件
curl -I .../css/vendor-bundle.min.*.css
HTTP/2 404 ❌

# Logo图片
curl -I .../media/logo_hu_*.png
HTTP/2 404 ❌
```

**页面表现**:
- 页面HTML正常加载
- 完全无样式（白底黑字）
- 所有图片显示失败

**根本原因**:
```yaml
# .github/workflows/deploy.yml (错误配置)
run: |
  cd website          # ❌ 目录不存在
  hugo --gc --minify
```

**为什么会404**:
1. GitHub Actions进入 `website/` 目录（不存在）
2. Hugo命令失败或在错误位置运行
3. `public/` 目录为空或不完整
4. 上传的artifact缺少CSS/JS/图片

**修复方案**:
```yaml
# 修复后的配置
run: |
  cd website-new      # ✅ 正确目录
  hugo --gc --minify
```

---

### 问题4: localhost链接

**症状**:
```html
<!-- 语言切换器中出现 -->
<a href="http://localhost:1313/yuzhang-lab-website/">...</a>
```

**根本原因**:
- Hugo在生产构建时读取了所有配置文件
- `config.development.yaml` 包含localhost
- 语言切换器列出所有语言的所有URL

**修复方案**:
- 创建 `config/production/config.yaml`
- 显式设置生产环境的baseURL
- 通过 `HUGO_ENVIRONMENT=production` 使用正确配置

---

## 🔧 修复详情

### 修复1: 添加根路径重定向

**文件**: `website-new/static/index.html`

```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Redirecting...</title>
    <meta http-equiv="refresh" content="0; url=/yuzhang-lab-website/en/">
    <link rel="canonical" href="/yuzhang-lab-website/en/">
</head>
<body>
    <p>Redirecting to <a href="/yuzhang-lab-website/en/">English version</a>...</p>
    <script>
        window.location.href = "/yuzhang-lab-website/en/";
    </script>
</body>
</html>
```

**效果**:
- ✅ 三种重定向方式（meta、canonical、JS）
- ✅ SEO友好
- ✅ 无JavaScript时也能工作

---

### 修复2: 修正部署路径

**文件**: `.github/workflows/deploy.yml`

**修改前**:
```yaml
paths:
  - 'website/**'      # ❌

run: |
  cd website          # ❌
  hugo --gc --minify

with:
  path: ./website/public  # ❌
```

**修改后**:
```yaml
paths:
  - 'website-new/**'  # ✅

run: |
  cd website-new      # ✅
  hugo --gc --minify

with:
  path: ./website-new/public  # ✅
```

**影响**:
- ✅ Hugo正确构建所有资源
- ✅ CSS/JS/图片正确生成
- ✅ public目录完整上传

---

### 修复3: 添加生产配置

**文件**: `website-new/config/production/config.yaml`

```yaml
# Production environment configuration
baseURL: 'https://autobrainlab.github.io/yuzhang-lab-website/'
```

**工作流中的使用**:
```yaml
env:
  HUGO_ENVIRONMENT: production  # 使用production配置
```

**效果**:
- ✅ 覆盖development配置
- ✅ 语言切换器无localhost链接
- ✅ 所有URL使用正确的baseURL

---

## ✅ 验证清单

### 自动验证
```bash
# 运行验证脚本（等待部署完成后）
./verify-deployment.sh
```

### 手动验证

#### 1. 检查根路径
- [ ] 访问 `https://autobrainlab.github.io/yuzhang-lab-website/`
- [ ] 自动跳转到 `/en/`
- [ ] 无404错误

#### 2. 检查英文版
- [ ] 访问 `https://autobrainlab.github.io/yuzhang-lab-website/en/`
- [ ] CSS样式正常（导航栏、字体、颜色）
- [ ] Logo图片显示
- [ ] Hero图片显示
- [ ] 导航菜单可点击
- [ ] Bootstrap组件正常（按钮、卡片等）

#### 3. 检查中文版
- [ ] 访问 `https://autobrainlab.github.io/yuzhang-lab-website/zh/`
- [ ] 中文内容显示
- [ ] 样式正常
- [ ] 图片显示

#### 4. 检查资源加载
**打开浏览器开发者工具（F12）→ Network标签**:
- [ ] 所有CSS文件返回200
- [ ] 所有JS文件返回200
- [ ] 所有图片返回200
- [ ] 无404错误

#### 5. 检查语言切换
- [ ] 点击语言切换器
- [ ] 英文 ↔ 中文切换正常
- [ ] 无localhost链接
- [ ] URL正确（github.io域名）

#### 6. 检查各子页面
- [ ] `/en/research/` - Research页面样式正常
- [ ] `/en/people/` - People页面图片显示
- [ ] `/en/publications/` - Publications列表正常
- [ ] `/en/news/` - News页面正常
- [ ] `/zh/research/` - 中文Research页面

---

## 📈 预期结果

### HTTP状态码
```
✅ /                           → 200 (重定向到/en/)
✅ /en/                        → 200
✅ /zh/                        → 200
✅ /css/vendor-bundle.min.*.css → 200
✅ /media/logo_hu_*.png        → 200
✅ /media/hero_hu_*.webp       → 200
```

### 页面表现
- ✅ 样式完整（Bootstrap、自定义CSS）
- ✅ 响应式布局正常
- ✅ 图片清晰显示
- ✅ 字体正确加载
- ✅ 动画效果正常
- ✅ 交互功能正常

### SEO和性能
- ✅ 正确的canonical URL
- ✅ 语言标签正确（hreflang）
- ✅ 资源压缩（minify）
- ✅ 缓存头设置

---

## 🚀 部署时间线

| 时间 | 事件 | 状态 |
|------|------|------|
| 10-26 20:48 | 首次部署 | ❌ 有问题 |
| 10-27 09:04 | 问题报告 | 🔍 诊断中 |
| 10-27 09:10 | 原因分析 | 📊 已定位 |
| 10-27 09:15 | 修复提交 | ✅ 已推送 |
| 10-27 09:18 | 预计完成 | ⏳ 构建中 |

---

## 📝 经验总结

### 容易犯的错误
1. **路径不一致**: 仓库结构和CI配置不匹配
2. **环境配置混淆**: development配置影响production
3. **多语言重定向**: 忘记为根路径提供入口

### 最佳实践
1. ✅ 使用环境特定的配置文件
2. ✅ CI/CD路径使用变量而非硬编码
3. ✅ 多语言站点提供根路径重定向
4. ✅ 部署前在本地验证production构建
5. ✅ 使用验证脚本自动化检查

### 调试技巧
1. **检查HTTP状态码**: `curl -I <URL>`
2. **查看HTML源码**: 确认资源路径
3. **浏览器Network面板**: 查看404资源
4. **GitHub Actions日志**: 查看构建错误
5. **对比本地构建**: 验证配置差异

---

## 📚 相关文档

- [Hugo多语言配置](https://gohugo.io/content-management/multilingual/)
- [GitHub Pages部署](https://docs.github.com/en/pages)
- [Hugo环境配置](https://gohugo.io/getting-started/configuration/#configuration-directory)
- [GitHub Actions工作流](https://docs.github.com/en/actions/using-workflows)

---

## 🎯 下一步

1. **等待部署完成** (2-3分钟)
2. **运行验证脚本**: `./verify-deployment.sh`
3. **浏览器测试**: 访问所有主要页面
4. **性能优化**: 检查加载速度
5. **SEO验证**: Google Search Console

---

**修复者**: GitHub Copilot  
**提交哈希**: c7331f8  
**验证状态**: ⏳ 等待部署完成
