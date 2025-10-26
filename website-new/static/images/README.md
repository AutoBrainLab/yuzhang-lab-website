# 图片资源说明

## 目录结构

```
images/
├── logo/               # 实验室Logo
│   ├── logo.png        # 横版Logo (建议300x80px)
│   └── logo-square.png # 方形Logo (建议512x512px)
├── team/               # 团队成员照片
│   ├── yuzhang.jpg     # PI头像 (400x400px)
│   └── ...             # 其他成员头像
├── research/           # 研究方向配图
│   ├── brain-atlas.jpg    # 脑图谱研究
│   ├── big-data.jpg       # 大数据分析
│   └── brain-ai.jpg       # 脑科学与AI
└── publications/       # 论文相关图片
    └── featured/       # 精选论文配图
```

## 图片规格要求

### Logo
- **横版Logo**: 300x80px, PNG格式, 透明背景
- **方形Logo**: 512x512px, PNG格式, 用于社交媒体

### 头像
- **尺寸**: 400x400px (1:1比例)
- **格式**: JPG或PNG
- **背景**: 纯色或专业背景
- **文件大小**: <200KB

### 研究配图
- **尺寸**: 1200x800px (3:2比例)
- **格式**: JPG
- **质量**: 高清，文件<500KB
- **内容**: 相关科研图示或高质量库存图

### Favicon
- **位置**: `/static/favicon/`
- **文件**: favicon.ico (16x16, 32x32, 48x48多尺寸)
- **可选**: apple-touch-icon.png (180x180px)

## 图片来源建议

### 免费高质量图库
- **Unsplash**: https://unsplash.com/ (科学、大脑、技术类)
- **Pexels**: https://pexels.com/
- **Pixabay**: https://pixabay.com/

### Logo设计工具
- **Canva**: https://www.canva.com/ (在线设计)
- **Figma**: https://www.figma.com/ (专业设计)
- **LogoMakr**: https://logomakr.com/ (Logo生成器)

### Favicon生成工具
- **Real Favicon Generator**: https://realfavicongenerator.net/
- **Favicon.io**: https://favicon.io/

## 使用方法

### 在Markdown中引用图片

```markdown
# 主页中使用
![Yu Zhang](../images/team/yuzhang.jpg)

# 研究页面中使用
![Brain Atlas Research](../images/research/brain-atlas.jpg)
```

### 在Hugo配置中使用

```toml
# config/_default/params.toml
[logo]
  text = "Yu Zhang Lab"
  filename = "logo/logo.png"
  width = 300
  height = 80
```

## 优化建议

1. **压缩图片**: 使用TinyPNG或ImageOptim压缩
2. **响应式**: 为移动端准备不同尺寸
3. **CDN**: 考虑使用图床或CDN加速
4. **Alt文本**: 所有图片添加描述性alt文本
5. **命名规范**: 使用小写字母和连字符，避免空格和特殊字符
