#!/bin/bash
# 双语页面创建脚本
# 用法: ./create-bilingual-page.sh <page-name> "<English Title>" "<中文标题>"
# 示例: ./create-bilingual-page.sh courses "Courses" "课程"

if [ "$#" -ne 3 ]; then
    echo "用法: $0 <page-name> \"<English Title>\" \"<中文标题>\""
    echo "示例: $0 courses \"Courses\" \"课程\""
    exit 1
fi

PAGE_NAME=$1
EN_TITLE=$2
ZH_TITLE=$3

BASE_DIR="/mnt/data/hyf/yu_lab/website"

echo "================================================"
echo "📝 创建双语页面: $PAGE_NAME"
echo "================================================"
echo ""

# 创建英文页面
echo "1️⃣ 创建英文版本..."
mkdir -p "$BASE_DIR/content/$PAGE_NAME"
cat > "$BASE_DIR/content/$PAGE_NAME/_index.md" << EOF
---
title: "$EN_TITLE"
description: ""
---

# $EN_TITLE

Your English content here...

---

*Last updated: $(date +%Y-%m-%d)*
EOF
echo "   ✅ $BASE_DIR/content/$PAGE_NAME/_index.md"

# 创建中文页面
echo ""
echo "2️⃣ 创建中文版本..."
mkdir -p "$BASE_DIR/content/zh/$PAGE_NAME"
cat > "$BASE_DIR/content/zh/$PAGE_NAME/_index.md" << EOF
---
title: "$ZH_TITLE"
description: ""
---

# $ZH_TITLE

您的中文内容...

---

*最后更新：$(date +%Y年%m月%d日)*
EOF
echo "   ✅ $BASE_DIR/content/zh/$PAGE_NAME/_index.md"

echo ""
echo "================================================"
echo "✅ 双语页面创建成功！"
echo "================================================"
echo ""
echo "📂 文件位置:"
echo "   英文: content/$PAGE_NAME/_index.md"
echo "   中文: content/zh/$PAGE_NAME/_index.md"
echo ""
echo "🌐 访问地址 (本地开发):"
echo "   英文: http://localhost:1313/yuzhang-lab-website/$PAGE_NAME/"
echo "   中文: http://localhost:1313/yuzhang-lab-website/zh/$PAGE_NAME/"
echo ""
echo "💡 下一步:"
echo "   1. 编辑英文内容: vim $BASE_DIR/content/$PAGE_NAME/_index.md"
echo "   2. 编辑中文内容: vim $BASE_DIR/content/zh/$PAGE_NAME/_index.md"
echo "   3. 浏览器查看效果（开发服务器自动刷新）"
echo ""
