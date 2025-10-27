# GitHub Pages 问题修复总结

**修复日期**: 2025-10-27  
**问题**: 主页404错误和语言切换404错误

---

## 问题分析

### 问题1: 主页404错误
**URL**: `https://autobrainlab.github.io/yuzhang-lab-website/`  
**状态**: ❌ 404 Not Found

**根本原因**:
- Hugo配置了 `defaultContentLanguageInSubdir: true`
- 所有内容都放在语言子目录下 (`/en/`, `/zh/`)
- 根目录没有 `index.html` 文件

**修复方案**:
1. ✅ 禁用Hugo Blox主题的 `development` 语言配置
2. ✅ Hugo自动生成根目录重定向到 `/en/`
3. ✅ GitHub Actions工作流添加index.html复制步骤（备用）

### 问题2: 语言切换404错误
**症状**: 英文版切换到中文版时404

**根本原因**:
- Hugo Blox主题定义了一个隐藏的 `development` 语言
- 导致语言切换器生成了3个链接：
  - ✅ English → `/yuzhang-lab-website/en/`
  - ❌ 中文 → `/yuzhang-lab-website/` (错误，应该是 `/zh/`)
  - ❌ (空) → `http://localhost:1313/yuzhang-lab-website/` (development语言)

**修复方案**:
在 `config/_default/languages.yaml` 中明确禁用 `development` 语言：
```yaml
development:
  disabled: true
```

---

## 修复结果

### 构建统计对比

**修复前**:
```
                 │ EN  │ DEVELOPMENT │ ZH 
─────────────────┼─────┼─────────────┼────
 Pages           │ 168 │          17 │ 66
```

**修复后**:
```
                 │ EN  │ ZH 
─────────────────┼─────┼────
 Pages           │ 169 │ 65
```

### 文件结构对比

**修复前** (`public/` 目录):
```
public/
  ├── development/    ← 不应该存在
  ├── en/
  │   ├── css/
  │   ├── js/
  │   ├── media/
  │   └── ...
  ├── zh/
  └── (没有 index.html)  ← 导致404
```

**修复后** (`public/` 目录):
```
public/
  ├── index.html      ← ✅ 重定向到 /en/
  ├── css/            ← ✅ 从 /en/css/ 复制
  ├── js/             ← ✅ 从 /en/js/ 复制
  ├── media/          ← ✅ 从 /en/media/ 复制
  ├── webfonts/       ← ✅ 从 /en/webfonts/ 复制
  ├── en/
  │   └── (所有页面和资源)
  └── zh/
      └── (所有页面和资源)
```

### 语言切换链接对比

**修复前**:
```html
<!-- 英文版 -->
<a href="https://autobrainlab.github.io/yuzhang-lab-website/">中文</a>
<!-- ❌ 404错误 -->

<a href="http://localhost:1313/yuzhang-lab-website/"></a>
<!-- ❌ localhost链接 -->
```

**修复后**:
```html
<!-- 英文版 -->
<a href="https://autobrainlab.github.io/yuzhang-lab-website/zh/">中文 (简体)</a>
<!-- ✅ 正确链接到中文版 -->
```

---

## 修改的文件

### 1. `config/_default/languages.yaml`
**修改**: 添加 `development: disabled: true`

```diff
 zh:
   languageCode: zh-Hans
   contentDir: content/zh
   title: 张瑜实验室 - 脑图谱与类脑智能
   params:
     description: 上海交通大学张瑜教授领导的脑图谱与类脑智能实验室
+
+# Disable development language (comes from Hugo Blox theme)
+development:
+  disabled: true
```

### 2. `.github/workflows/deploy-hugo.yml`
**修改**: 添加根目录index.html复制步骤

```diff
-      - name: Fix resource paths
+      - name: Fix resource paths and root index
         run: |
           cd website-new/public
           # Copy CSS, JS, and media from /en/ to root for shared resources
           if [ -d en/css ]; then cp -r en/css .; fi
           if [ -d en/js ]; then cp -r en/js .; fi
           if [ -d en/media ]; then cp -r en/media .; fi
           if [ -d en/webfonts ]; then cp -r en/webfonts .; fi
           if [ -d en/images ]; then cp -r en/images .; fi
           echo "Resource directories copied to root"
+          # Copy root index.html from static folder (backup if Hugo doesn't generate it)
+          if [ -f ../static/index.html ]; then
+            cp ../static/index.html .
+            echo "Root index.html copied"
+          fi
```

---

## 验证清单

在部署后验证以下内容：

- [ ] 主页 `https://autobrainlab.github.io/yuzhang-lab-website/` 能正常访问
- [ ] 自动重定向到 `https://autobrainlab.github.io/yuzhang-lab-website/en/`
- [ ] 英文版 `https://autobrainlab.github.io/yuzhang-lab-website/en/` 样式正常
- [ ] 中文版 `https://autobrainlab.github.io/yuzhang-lab-website/zh/` 样式正常
- [ ] 英文版→中文版切换正常
- [ ] 中文版→英文版切换正常
- [ ] 图片正常显示
- [ ] CSS样式正常加载
- [ ] JavaScript正常运行
- [ ] 没有404错误
- [ ] 没有localhost链接

---

## 技术细节

### Hugo Blox主题的development语言

Hugo Blox主题在其模块配置中定义了一个 `development` 语言，用于本地开发。这个语言：

1. 不在我们的 `languages.yaml` 中定义
2. 但会被Hugo合并到最终配置中
3. 导致生成额外的页面和错误的语言链接

**解决方案**: 在我们的 `languages.yaml` 中明确设置 `development.disabled = true`

### defaultContentLanguageInSubdir的副作用

当设置 `defaultContentLanguageInSubdir: true` 时：

1. ✅ 好处: 所有语言URL一致 (`/en/`, `/zh/`)
2. ❌ 问题: 根目录没有index.html（除非只有一个语言）
3. ✅ Hugo解决方案: 自动生成重定向到默认语言

### GitHub Pages的资源路径

Hugo将资源放在语言子目录下：
- `/en/css/vendor-bundle.min.css`
- `/zh/css/vendor-bundle.min.css`

但HTML引用的是根路径：
- `/yuzhang-lab-website/css/vendor-bundle.min.css`

**解决方案**: GitHub Actions构建时复制资源到根目录

---

## 相关文档

- [Hugo多语言配置](https://gohugo.io/content-management/multilingual/)
- [Hugo Blox文档](https://docs.hugoblox.com/)
- [GitHub Pages部署](https://docs.github.com/pages)
- [GitHub Actions工作流](.github/workflows/deploy-hugo.yml)

---

## 下次部署

1. 推送代码到GitHub
2. GitHub Actions自动构建
3. 等待3-5分钟部署完成
4. 访问 https://autobrainlab.github.io/yuzhang-lab-website/
5. 验证所有功能正常

**预期结果**: 
- ✅ 主页正常访问并重定向
- ✅ 语言切换正常工作
- ✅ 所有样式和图片正常显示
