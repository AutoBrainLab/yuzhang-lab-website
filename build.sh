#!/bin/bash
# Hugo生产构建脚本

cd /mnt/data/hyf/yu_lab/website

echo "================================================"
echo "🔨 构建Hugo静态网站（生产模式）"
echo "================================================"
echo ""

# 清理旧的构建
echo "🧹 清理旧的构建文件..."
rm -rf public/
rm -rf resources/_gen/

# 执行构建
echo "⚙️  开始构建..."
hugo --gc --minify --verbose

# 检查构建结果
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 构建成功！"
    echo ""
    echo "📊 生成文件统计:"
    echo "   总大小: $(du -sh public/ | cut -f1)"
    echo "   文件数: $(find public/ -type f | wc -l)"
    echo ""
    echo "📂 输出目录: public/"
    echo ""
    echo "🚀 推送到GitHub后将自动部署到:"
    echo "   https://autobrainlab.github.io/yuzhang-lab-website/"
else
    echo ""
    echo "❌ 构建失败！请检查错误信息"
    exit 1
fi

