# Hugo Configuration & News Filtering Fix

## 修复时间
2025年10月26日 18:00

## 问题诊断

### 问题1: 中文链接404错误

**症状**:
```
错误链接: http://localhost:1313/zh/yuzhang-lab-website/zh/people
正确链接: http://localhost:1313/yuzhang-lab-website/zh/people/
```

**根本原因**:

```yaml
# config/_default/hugo.yaml (旧配置)
baseURL: '/'
defaultContentLanguageInSubdir: false
```

**Hugo路径生成逻辑**:
1. `baseURL: '/'` → 所有链接从根路径开始
2. `defaultContentLanguageInSubdir: false` → 默认语言(en)不加路径前缀
3. 中文版路径: `/zh/people/`
4. 但菜单生成时可能拼接为: `/zh/yuzhang-lab-website/zh/people`

---

### 问题2: 英文主页显示中英文两版新闻

**症状**:
```markdown
Latest News:
1. Lab Opening Announcement (英文)
2. 实验室正式成立 (中文)
```

**根本原因**:

```bash
# 文件结构
content/news/2025-lab-opening.md       # 英文新闻
content/zh/news/2025-lab-opening.md    # 中文新闻

# Hugo的 .Pages 逻辑
{{ range .Site.RegularPages }}  # 遍历所有页面
  # 包括 en/news 和 zh/news
{{ end }}
```

**Hugo多语言内容规则**:
- `content/news/` → 英文内容
- `content/zh/news/` → 中文内容
- 但如果没有语言过滤，两者都会被列出

---

## 解决方案

### 修复1: baseURL配置

**修改 `config/_default/hugo.yaml`**:

```yaml
# BEFORE
title: Yu Zhang Lab - Brain Atlas and Brain-Inspired AI
baseURL: '/'
defaultContentLanguage: en
hasCJKLanguage: true
defaultContentLanguageInSubdir: false

# AFTER
title: Yu Zhang Lab - Brain Atlas and Brain-Inspired AI
baseURL: 'http://localhost:1313/yuzhang-lab-website/'
defaultContentLanguage: en
hasCJKLanguage: true
defaultContentLanguageInSubdir: true  # 改为 true
```

**关键变更**:
1. `baseURL: 'http://localhost:1313/yuzhang-lab-website/'` 
   - 明确设置完整baseURL
   - 与Hugo Server的`--baseURL`参数一致

2. `defaultContentLanguageInSubdir: true`
   - 英文版URL: `/en/people/` (不是 `/people/`)
   - 中文版URL: `/zh/people/`
   - **统一路径结构**

**为什么要改**:
- `baseURL: '/'` 在本地开发时会导致路径混乱
- `defaultContentLanguageInSubdir: false` 导致英文版无前缀，中文版有`/zh/`前缀，不对称

---

### 修复2: 新闻语言过滤 (Hugo Blox主题自动处理)

**Hugo Blox主题已经内置语言过滤**:

查看主题源码 `themes/hugo-blox-builder/modules/blox-bootstrap/layouts/partials/blocks/collection.html`:

```go-html-template
{{ $items := where site.RegularPages "Type" "news" }}
{{ if .CurrentSection.Lang }}
  {{ $items = where $items ".Lang" .CurrentSection.Lang }}
{{ end }}
```

**问题原因**: 
- 当前可能使用的是自定义首页
- 没有调用Blox的collection模块
- 或者collection配置缺少语言过滤

**解决方案A: 使用Blox Collection Widget** (推荐)

在 `content/_index.md` 中添加:

```yaml
---
title: "Yu Zhang Lab"
sections:
  - block: collection
    content:
      title: Latest News
      subtitle: ''
      text: ''
      count: 3
      filters:
        folders:
          - news
        tag: ''
        category: ''
        publication_type: ''
        author: ''
        exclude_featured: false
        exclude_future: false
        exclude_past: false
    design:
      view: compact
      columns: '2'
---
```

**解决方案B: 手动过滤** (如果使用自定义模板)

创建 `layouts/index.html`:

```go-html-template
{{ $news := where site.RegularPages "Section" "news" }}
{{ $news = where $news ".Lang" site.Language.Lang }}
{{ $news = $news | first 5 }}

<h2>Latest News</h2>
<ul>
{{ range $news }}
  <li>
    <a href="{{ .Permalink }}">{{ .Title }}</a>
    <span>{{ .Date.Format "January 2, 2006" }}</span>
  </li>
{{ end }}
</ul>
```

**关键语句**:
```go
{{ $news = where $news ".Lang" site.Language.Lang }}
```
- 筛选出与当前页面语言相同的新闻
- `site.Language.Lang` 在英文版是`"en"`，中文版是`"zh"`

---

## 配置变更对比

### hugo.yaml

| 配置项 | 旧值 | 新值 | 说明 |
|--------|------|------|------|
| `baseURL` | `'/'` | `'http://localhost:1313/yuzhang-lab-website/'` | 明确baseURL |
| `defaultContentLanguageInSubdir` | `false` | `true` | 英文版也加`/en/`前缀 |

---

## 路径生成逻辑

### 修复前

```
英文版:
  Home: http://localhost:1313/
  People: http://localhost:1313/people/
  
中文版:
  Home: http://localhost:1313/zh/
  People: http://localhost:1313/zh/people/
  
问题: 路径不对称，可能导致拼接错误
```

### 修复后

```
英文版:
  Home: http://localhost:1313/yuzhang-lab-website/en/
  People: http://localhost:1313/yuzhang-lab-website/en/people/
  
中文版:
  Home: http://localhost:1313/yuzhang-lab-website/zh/
  People: http://localhost:1313/yuzhang-lab-website/zh/people/
  
优点: 完全对称，路径清晰
```

---

## Hugo Server启动命令

### 旧命令 (有问题)

```bash
cd /mnt/data/hyf/yu_lab/website-new && \
hugo server -D --bind 0.0.0.0 --port 1313 \
  --baseURL http://localhost:1313/yuzhang-lab-website/ \
  --appendPort=false
```

**问题**: 
- `--baseURL` 与 `config/hugo.yaml` 中的 `baseURL: '/'` 冲突
- Hugo会优先使用命令行参数
- 但某些模板可能读取配置文件

### 新命令 (推荐)

```bash
# 方案1: 使用配置文件的baseURL
cd /mnt/data/hyf/yu_lab/website-new && \
hugo server -D --bind 0.0.0.0 --port 1313

# 方案2: 明确指定baseURL (与配置文件一致)
cd /mnt/data/hyf/yu_lab/website-new && \
hugo server -D --bind 0.0.0.0 --port 1313 \
  --baseURL http://localhost:1313/yuzhang-lab-website/

# 方案3: 生产环境部署
baseURL: 'https://autobrainlab.github.io/yuzhang-lab-website/'
defaultContentLanguageInSubdir: true
```

---

## 验证步骤

### 1. 验证baseURL

```bash
# 重新构建
hugo --quiet

# 检查生成的HTML
grep -r "href=" public/index.html | head -5

# 期望输出: 
# href="/yuzhang-lab-website/en/people/"
# href="/yuzhang-lab-website/zh/people/"
```

### 2. 验证语言路径

```bash
# 英文版首页
curl -s http://localhost:1313/yuzhang-lab-website/en/ | grep -o "Latest News"

# 中文版首页
curl -s http://localhost:1313/yuzhang-lab-website/zh/ | grep -o "最新动态"

# 英文版people页面
curl -I http://localhost:1313/yuzhang-lab-website/en/people/ | grep "200 OK"

# 中文版people页面
curl -I http://localhost:1313/yuzhang-lab-website/zh/people/ | grep "200 OK"
```

### 3. 验证新闻过滤

```bash
# 英文首页应该只显示英文新闻
curl -s http://localhost:1313/yuzhang-lab-website/en/ | \
  grep -c "Lab Opening Announcement"  # 应该 = 1

curl -s http://localhost:1313/yuzhang-lab-website/en/ | \
  grep -c "实验室正式成立"  # 应该 = 0

# 中文首页应该只显示中文新闻
curl -s http://localhost:1313/yuzhang-lab-website/zh/ | \
  grep -c "实验室正式成立"  # 应该 = 1

curl -s http://localhost:1313/yuzhang-lab-website/zh/ | \
  grep -c "Lab Opening Announcement"  # 应该 = 0
```

---

## Hugo多语言最佳实践

### 1. 内容组织

```
content/
├── _index.md           # 英文首页
├── people/
│   └── _index.md       # 英文团队页
├── news/
│   └── 2025-news.md    # 英文新闻
└── zh/                 # 中文目录
    ├── _index.md       # 中文首页
    ├── people/
    │   └── _index.md   # 中文团队页
    └── news/
        └── 2025-news.md # 中文新闻
```

### 2. frontmatter标记

```yaml
# content/news/2025-lab-opening.md
---
title: "Lab Opening"
lang: en           # 明确标记语言
translationKey: lab-opening-2025  # 关联翻译版本
---

# content/zh/news/2025-lab-opening.md
---
title: "实验室成立"
lang: zh
translationKey: lab-opening-2025  # 同样的key
---
```

### 3. 菜单配置

```yaml
# config/_default/menus.en.yaml
main:
  - name: People
    url: /en/people/
    weight: 20

# config/_default/menus.zh.yaml
main:
  - name: 团队成员
    url: /zh/people/
    weight: 20
```

---

## 技术细节

### Hugo路径解析优先级

1. **命令行参数** `--baseURL`
2. **环境变量** `HUGO_BASEURL`
3. **配置文件** `hugo.yaml` 中的 `baseURL`

**建议**: 统一在配置文件中设置，避免混乱

### defaultContentLanguageInSubdir

```yaml
defaultContentLanguageInSubdir: false
  → 英文: /people/
  → 中文: /zh/people/
  
defaultContentLanguageInSubdir: true
  → 英文: /en/people/
  → 中文: /zh/people/
```

**何时使用 true**:
- ✅ 部署到子路径 (如 `/yuzhang-lab-website/`)
- ✅ 需要对称的URL结构
- ✅ SEO优化 (明确语言标识)

**何时使用 false**:
- ✅ 部署到根域名 (如 `https://lab.com/`)
- ✅ 默认语言不想显示前缀

---

## 生产环境配置

### GitHub Pages部署

```yaml
# config/_default/hugo.yaml (生产)
baseURL: 'https://autobrainlab.github.io/yuzhang-lab-website/'
defaultContentLanguageInSubdir: true
canonifyURLs: true

# .github/workflows/deploy.yml
- name: Build
  run: hugo --minify --gc --baseURL https://autobrainlab.github.io/yuzhang-lab-website/
```

### 自定义域名部署

```yaml
# config/_default/hugo.yaml
baseURL: 'https://yuzhanglab.org/'
defaultContentLanguageInSubdir: true

# 英文版: https://yuzhanglab.org/en/
# 中文版: https://yuzhanglab.org/zh/
```

---

## 常见问题

### Q1: 链接还是错误怎么办？

```bash
# 清除缓存
hugo --cleanDestinationDir
rm -rf public/

# 完全重建
hugo --gc --minify
```

### Q2: 菜单链接还有问题？

检查 `config/_default/menus.*.yaml`:

```yaml
# 错误示例
main:
  - url: /people/  # 缺少语言前缀

# 正确示例
main:
  - url: /en/people/  # 明确语言前缀
```

### Q3: 如何调试路径生成？

```bash
# 启用详细日志
hugo server --verbose --log

# 查看生成的链接
grep -r "href=" public/ | grep "people" | head -10
```

---

## 验证清单

- [ ] `config/_default/hugo.yaml` 中 `baseURL` 正确
- [ ] `defaultContentLanguageInSubdir: true`
- [ ] 英文版链接: `/en/people/` 可访问
- [ ] 中文版链接: `/zh/people/` 可访问
- [ ] 英文首页只显示英文新闻
- [ ] 中文首页只显示中文新闻
- [ ] 菜单链接正确
- [ ] 语言切换功能正常

---

**修复时间**: 2025-10-26 18:00  
**修改文件**: `config/_default/hugo.yaml`  
**影响范围**: 所有页面链接、语言切换、新闻过滤  
**测试环境**: http://localhost:1313/yuzhang-lab-website/
