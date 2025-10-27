# 🔍 UX功能未显示问题分析

**问题时间**: 2025-10-26  
**问题描述**: 本地和远程网站未显示新增的UX功能

---

## 问题根源分析

### 1. Hugo Blox Builder主题架构
Hugo Blox Builder使用模块化主题系统，有自己的布局优先级：
```
themes/hugo-blox-builder/modules/blox-tailwind/layouts/
  └── baseof.html (主题的基础布局)
  └── _partials/
      └── components/
          └── headers/navbar.html (主题的导航栏)
```

### 2. 钩子系统未生效
尝试通过 `layouts/_partials/hooks/body-end/` 添加自定义代码，但钩子未被加载：
- 文件路径正确: `layouts/_partials/hooks/body-end/custom-ux.html`
- 钩子调用存在: `baseof.html` 中有 `{{ partial "functions/get_hook" (dict "hook" "body-end" "context" .) }}`
- **但构建后的HTML中未包含钩子内容**

可能原因：
- Hugo版本兼容性问题 (v0.152.2)
- 主题的get_hook函数有特定要求
- 需要特定配置才能启用自定义钩子

### 3. 自定义布局被忽略
创建的自定义布局文件被主题布局覆盖：
- `layouts/_default/baseof.html` - 未被使用
- `layouts/_partials/breadcrumb.html` - 未被调用
- `layouts/_partials/mobile-nav.html` - 未被调用

主题的baseof.html优先级更高。

---

## 实际可用的功能

### ✅ 已生效的配置

#### 1. 双语菜单配置
```toml
# menus.en.toml ✅
# menus.zh.toml ✅
```
**状态**: 文件已创建，Hugo应能识别

#### 2. 语言切换器
```toml
# params.toml
[header.navbar]
show_translations = true  ✅
```
**状态**: 主题自带功能，应该已启用

#### 3. 主题自带的导航
主题提供的导航栏包括：
- 响应式菜单 (hamburger menu)
- 语言选择器
- 主题切换器 (日/夜模式)
- 搜索功能

---

## 验证清单

### 需要验证的功能

#### 中文导航菜单
测试步骤：
1. 访问 `/zh/` (中文主页)
2. 检查菜单是否显示中文
   - 应显示: 主页, 研究方向, 团队成员, 研究成果, 新闻动态, 研究资源, 加入我们
   - 而非: Home, Research, People, Publications, News, Resources, Join Us

#### 语言切换器
测试步骤：
1. 在英文页面查看导航栏右侧
2. 应该看到🌐图标或"English"
3. 点击应该显示可切换的语言(中文)
4. 切换后URL从 `/page/` 变为 `/zh/page/`

#### 响应式菜单
测试步骤：
1. 缩小浏览器窗口到<768px
2. 应该看到☰汉堡菜单图标
3. 点击展开侧边菜单

---

## 解决方案

### 方案A: 依赖主题自带功能 ⭐ 推荐
**优点**: 最可靠，维护成本低
**实施**:
1. 确保 `menus.en.toml` 和 `menus.zh.toml` 配置正确 ✅
2. 在 `params.toml` 中启用语言切换 ✅
3. 使用主题自带的响应式导航 ✅

### 方案B: 覆盖主题布局
**优点**: 完全自定义
**缺点**: 维护成本高，主题更新时可能冲突
**实施**:
1. 复制主题的baseof.html到layouts/
2. 修改布局添加自定义组件
3. 测试所有页面

### 方案C: JavaScript注入
**优点**: 不修改布局文件
**缺点**: 依赖客户端执行
**实施**:
1. 在 `static/js/` 创建custom.js
2. 在params.toml配置加载custom.js
3. 通过JS动态添加返回顶部按钮

---

## 当前采用方案

**选择**: 方案A - 依赖主题自带功能

**理由**:
1. Hugo Blox Builder已提供完整的双语支持
2. 主题的响应式设计已经很好
3. 避免与主题更新冲突
4. 减少维护成本

**关键配置**:
```toml
# params.toml
[header.navbar]
enable = true
show_search = true
show_translations = true  # 语言切换
show_theme_chooser = true  # 日/夜模式
show_logo = true
```

**菜单配置**:
- `config/_default/menus.en.toml` - 英文菜单
- `config/_default/menus.zh.toml` - 中文菜单

---

## 下一步行动

### 立即验证
1. 重新构建网站: `hugo --gc`
2. 启动开发服务器: `hugo server`
3. 测试中文导航: 访问 `/zh/`
4. 测试语言切换: 点击导航栏的语言选择器
5. 测试响应式: 缩小浏览器窗口

### 如果功能仍未显示
1. 检查Hugo构建日志
2. 检查浏览器控制台错误
3. 验证menus文件格式是否正确
4. 检查languages.toml配置
5. 清除Hugo缓存: `hugo --gc --cleanDestinationDir`

---

## 结论

问题原因：
- ❌ 钩子系统未按预期工作
- ❌ 自定义布局被主题覆盖
- ✅ 但主题自带功能应该可用

解决方案：
- 使用主题提供的双语导航功能
- 通过配置文件实现中英文菜单
- 利用主题自带的响应式设计

期望效果：
- ✅ 中文页面显示中文菜单
- ✅ 英文页面显示英文菜单
- ✅ 语言切换器工作
- ✅ 移动端响应式菜单
- ⏸️ 返回顶部按钮(暂缓,不是核心功能)
