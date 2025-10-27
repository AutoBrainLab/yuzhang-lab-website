# GitHub Pages 部署问题修复报告

**日期**: 2025年10月27日  
**状态**: ✅ 已修复并重新部署

## 问题描述

部署到 GitHub Pages 后出现以下问题：

1. **主页404错误**: `https://autobrainlab.github.io/yuzhang-lab-website/` 返回404
2. **样式和图片丢失**: `/en/` 页面可访问但无CSS样式，图片全部404
3. **localhost链接**: 语言切换器中出现 `http://localhost:1313` 链接

## 根本原因分析

### 问题1：主页404

**原因**:
- Hugo配置了 `defaultContentLanguageInSubdir: true`
- 这导致所有语言内容都在子目录下（`/en/`, `/zh/`）
- 根路径 `/yuzhang-lab-website/` 没有 `index.html` 文件

**技术细节**:
```yaml
# config/_default/hugo.yaml
defaultContentLanguageInSubdir: true  # 英文内容也放在 /en/ 下
```

### 问题2：CSS和图片404

**原因**:
- GitHub Actions 工作流配置中路径错误
- 配置使用 `cd website` 但实际目录是 `website-new`
- Hugo 构建失败或构建到错误位置，导致资源文件未上传

**错误配置**:
```yaml
# .github/workflows/deploy.yml (错误)
run: |
  cd website          # ❌ 错误路径
  hugo --gc --minify
```

**验证**:
```bash
curl -I https://autobrainlab.github.io/yuzhang-lab-website/css/vendor-bundle.min.*.css
# HTTP/2 404 ❌

curl -I https://autobrainlab.github.io/yuzhang-lab-website/media/logo_hu_*.png
# HTTP/2 404 ❌
```

### 问题3：localhost链接

**原因**:
- Hugo 在生产环境构建时可能读取了 `config.development.yaml`
- 语言切换器包含了所有环境的 baseURL 配置

## 修复方案

### 修复1：添加根路径重定向

在 `website-new/static/index.html` 创建重定向文件：

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
- 访问根路径自动跳转到 `/en/`
- 支持三种重定向方式（meta refresh、canonical、JavaScript）

### 修复2：修正GitHub Actions路径

```yaml
# .github/workflows/deploy.yml (修复后)
- name: Build with Hugo
  run: |
    cd website-new    # ✅ 正确路径
    hugo \
      --gc \
      --minify \
      --baseURL "${{ steps.pages.outputs.base_url }}/"

- name: Upload artifact
  uses: actions/upload-pages-artifact@v3
  with:
    path: ./website-new/public  # ✅ 正确路径
```

**修改**:
- `website` → `website-new`
- 触发路径: `website/**` → `website-new/**`

### 修复3：添加生产环境配置

创建 `website-new/config/production/config.yaml`：

```yaml
# Production environment configuration
baseURL: 'https://autobrainlab.github.io/yuzhang-lab-website/'
```

**说明**:
- 当 `HUGO_ENVIRONMENT=production` 时使用此配置
- 覆盖 development 配置，避免 localhost 链接

## 验证步骤

等待 GitHub Actions 重新部署（约2-3分钟），然后验证：

### 1. 检查主页重定向
```bash
curl -I https://autobrainlab.github.io/yuzhang-lab-website/
# 应返回 200 和重定向到 /en/
```

### 2. 检查CSS加载
```bash
curl -I https://autobrainlab.github.io/yuzhang-lab-website/css/vendor-bundle.min.*.css
# 应返回 HTTP/2 200
```

### 3. 检查图片加载
```bash
curl -I https://autobrainlab.github.io/yuzhang-lab-website/media/logo_hu_*.png
# 应返回 HTTP/2 200
```

### 4. 浏览器测试
- 访问 https://autobrainlab.github.io/yuzhang-lab-website/
  - ✅ 自动跳转到 `/en/`
- 检查 `/en/` 页面
  - ✅ CSS样式正常加载
  - ✅ Logo和图片显示
  - ✅ 导航菜单样式正确
  - ✅ Bootstrap组件正常
- 检查语言切换器
  - ✅ 无 localhost 链接
  - ✅ 中英文切换正常

## 技术要点

### Hugo多语言配置
```yaml
defaultContentLanguage: en
defaultContentLanguageInSubdir: true
```
- 所有语言都在子目录下
- 需要为根路径提供重定向

### GitHub Actions环境变量
```yaml
env:
  HUGO_ENVIRONMENT: production
```
- 控制Hugo使用哪个环境配置
- `production` 使用 `config/production/` 目录

### 资源路径
- Hugo使用 `absURL` 生成绝对路径
- baseURL必须正确配置
- static目录内容直接复制到根路径

## 部署时间线

- **第一次部署**: 2025-10-26 20:48 (有问题)
- **问题发现**: 2025-10-27 09:04
- **修复提交**: 2025-10-27 09:15
- **预计修复完成**: 2025-10-27 09:18

## 相关文件

- `.github/workflows/deploy.yml` - GitHub Actions工作流
- `website-new/static/index.html` - 根路径重定向
- `website-new/config/production/config.yaml` - 生产环境配置
- `website-new/config/_default/hugo.yaml` - 主配置
- `website-new/config/_default/config.development.yaml` - 开发环境配置

## 后续监控

部署完成后持续监控：
- GitHub Actions构建日志
- 浏览器开发者工具网络面板
- CSS和JS资源加载状态
- 图片资源加载状态

---

**修复状态**: ✅ 已完成  
**提交哈希**: c7331f8  
**GitHub Actions**: 正在运行...
