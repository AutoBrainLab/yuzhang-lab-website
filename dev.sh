#!/bin/bash
# Hugo本地开发服务器启动脚本

cd /mnt/data/hyf/yu_lab/website

echo "================================================"
echo "🚀 启动Hugo本地开发服务器"
echo "================================================"
echo ""
echo "📂 工作目录: $(pwd)"
echo "🌐 访问地址: http://localhost:1313"
echo "📝 编辑文件: content/ 目录下的 .md 文件"
echo "⚡ 修改后自动刷新浏览器"
echo ""
echo "💡 提示:"
echo "   - 按 Ctrl+C 停止服务器"
echo "   - 修改保存后 < 1秒 即可看到效果"
echo ""
echo "================================================"
echo ""

# 启动Hugo开发服务器
# -D: 包含草稿内容
# --bind 0.0.0.0: 允许外部访问（如果需要）
# --disableFastRender: 完整重新渲染（更可靠）
hugo server -D

