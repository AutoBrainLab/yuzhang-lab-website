#!/bin/bash

# 网站导航可达性测试脚本
# Test all navigation links

echo "🧭 开始测试网站导航..."
echo "================================"

BASE_URL="http://localhost:1313/yuzhang-lab-website"

# 测试函数
test_page() {
    local url=$1
    local name=$2
    
    if curl -s -o /dev/null -w "%{http_code}" "$url" | grep -q "200\|301\|302"; then
        echo "✅ $name: $url"
        return 0
    else
        echo "❌ $name: $url (Failed)"
        return 1
    fi
}

echo ""
echo "📍 英文页面测试 (English Pages)"
echo "--------------------------------"
test_page "$BASE_URL/" "主页 (Home)"
test_page "$BASE_URL/research/" "研究 (Research)"
test_page "$BASE_URL/people/" "团队 (People)"
test_page "$BASE_URL/publications/" "出版物 (Publications)"
test_page "$BASE_URL/news/" "新闻 (News)"
test_page "$BASE_URL/resources/" "资源 (Resources)"
test_page "$BASE_URL/join-us/" "招聘 (Join Us)"

echo ""
echo "📍 中文页面测试 (Chinese Pages)"
echo "--------------------------------"
test_page "$BASE_URL/zh/" "主页"
test_page "$BASE_URL/zh/research/" "研究方向"
test_page "$BASE_URL/zh/people/" "团队成员"
test_page "$BASE_URL/zh/publications/" "研究成果"
test_page "$BASE_URL/zh/news/" "新闻动态"
test_page "$BASE_URL/zh/resources/" "研究资源"
test_page "$BASE_URL/zh/join-us/" "加入我们"

echo ""
echo "================================"
echo "✨ 测试完成！"
echo ""
echo "💡 提示："
echo "   - 确保开发服务器正在运行: hugo server -D --bind 0.0.0.0"
echo "   - 访问本地网站: http://localhost:1313/yuzhang-lab-website/"
echo "   - 切换语言测试双语导航"
