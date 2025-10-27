# GitHub Pages 部署调试指南

## 当前问题
1. ✅ 主页404 - 已通过index.html重定向解决
2. ❌ CSS和图片404 - 资源未正确生成或部署

## 根本原因分析

### 问题1: resources/_gen 被忽略
**.gitignore中包含：**
```
website-new/resources/_gen/
```

这会忽略本地生成的CSS和图片，但GitHub Actions应该重新生成这些文件。

### 问题2: Hugo模块可能未正确安装
Hugo使用Go modules引入主题，需要确保：
1. Go环境正确设置
2. `hugo mod get` 成功运行
3. 模块缓存可用

### 问题3: 构建配置
需要确保：
- Hugo版本匹配（0.152.2）
- Extended版本（用于SCSS编译）
- Dart Sass已安装

## 修复步骤

### 1. 更新GitHub Actions工作流
已添加：
- Go环境设置（v1.21）
- Hugo模块安装步骤

### 2. 验证配置文件
- ✅ baseURL: 'https://autobrainlab.github.io/yuzhang-lab-website/'
- ✅ production/config.yaml存在
- ✅ go.mod正确配置模块

### 3. 检查清单

#### 本地测试
```bash
cd website-new
# 清除缓存
rm -rf public/ resources/_gen/
# 安装模块
hugo mod get
# 构建
HUGO_ENVIRONMENT=production hugo --gc --minify --baseURL "https://autobrainlab.github.io/yuzhang-lab-website/"
# 检查生成的文件
ls -la public/css/
ls -la public/media/
```

#### GitHub Actions检查
1. 查看Actions运行日志
2. 检查"Install Hugo modules"步骤是否成功
3. 检查"Build with Hugo"是否有错误
4. 查看artifact中的public目录内容

## 下一步

1. **提交工作流更新**
2. **触发新的部署**
3. **检查Actions日志**
4. **验证资源文件生成**

## 调试命令

```bash
# 在GitHub Actions中添加调试步骤
- name: Debug - List public directory
  run: |
    cd website-new
    echo "=== CSS files ==="
    find public -name "*.css" | head -5
    echo "=== JS files ==="
    find public -name "*.js" | head -5
    echo "=== Media files ==="
    find public/media -type f | head -10
```

---
**更新时间**: 2025-10-27
