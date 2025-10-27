#!/bin/bash
# GitHub Pages部署验证脚本

SITE_URL="https://autobrainlab.github.io/yuzhang-lab-website"

echo "==========================================="
echo "GitHub Pages 部署验证"
echo "==========================================="
echo ""

echo "⏳ 等待部署完成（30秒）..."
sleep 30

echo ""
echo "1️⃣ 检查根路径重定向..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" -L "$SITE_URL/")
if [ "$STATUS" = "200" ]; then
    echo "   ✅ 根路径可访问 (HTTP $STATUS)"
else
    echo "   ❌ 根路径返回 HTTP $STATUS"
fi

echo ""
echo "2️⃣ 检查英文页面..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$SITE_URL/en/")
if [ "$STATUS" = "200" ]; then
    echo "   ✅ 英文页面可访问 (HTTP $STATUS)"
else
    echo "   ❌ 英文页面返回 HTTP $STATUS"
fi

echo ""
echo "3️⃣ 检查中文页面..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$SITE_URL/zh/")
if [ "$STATUS" = "200" ]; then
    echo "   ✅ 中文页面可访问 (HTTP $STATUS)"
else
    echo "   ❌ 中文页面返回 HTTP $STATUS"
fi

echo ""
echo "4️⃣ 检查CSS文件..."
CSS_COUNT=$(curl -s "$SITE_URL/en/" | grep -o 'href="/yuzhang-lab-website/css/' | wc -l)
if [ "$CSS_COUNT" -gt 0 ]; then
    echo "   ✅ 找到 $CSS_COUNT 个CSS引用"
    # 检查第一个CSS文件
    CSS_URL=$(curl -s "$SITE_URL/en/" | grep -o 'href="/yuzhang-lab-website/css/[^"]*"' | head -1 | sed 's/href="//;s/"//')
    if [ -n "$CSS_URL" ]; then
        FULL_CSS_URL="$SITE_URL${CSS_URL#/yuzhang-lab-website}"
        STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$FULL_CSS_URL")
        if [ "$STATUS" = "200" ]; then
            echo "   ✅ CSS文件可访问 (HTTP $STATUS)"
        else
            echo "   ❌ CSS文件返回 HTTP $STATUS"
            echo "   URL: $FULL_CSS_URL"
        fi
    fi
else
    echo "   ❌ 未找到CSS引用"
fi

echo ""
echo "5️⃣ 检查Logo图片..."
LOGO_URL=$(curl -s "$SITE_URL/en/" | grep -o 'src="/yuzhang-lab-website/media/logo[^"]*"' | head -1 | sed 's/src="//;s/"//')
if [ -n "$LOGO_URL" ]; then
    FULL_LOGO_URL="$SITE_URL${LOGO_URL#/yuzhang-lab-website}"
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$FULL_LOGO_URL")
    if [ "$STATUS" = "200" ]; then
        echo "   ✅ Logo图片可访问 (HTTP $STATUS)"
    else
        echo "   ❌ Logo图片返回 HTTP $STATUS"
        echo "   URL: $FULL_LOGO_URL"
    fi
else
    echo "   ⚠️  未找到Logo引用"
fi

echo ""
echo "6️⃣ 检查语言切换器..."
LOCALHOST_COUNT=$(curl -s "$SITE_URL/en/" | grep -c "localhost:1313" || true)
if [ "$LOCALHOST_COUNT" = "0" ]; then
    echo "   ✅ 无localhost链接"
else
    echo "   ❌ 发现 $LOCALHOST_COUNT 个localhost链接"
fi

echo ""
echo "==========================================="
echo "验证完成！"
echo "==========================================="
echo ""
echo "📊 在浏览器中访问："
echo "   - $SITE_URL"
echo "   - $SITE_URL/en/"
echo "   - $SITE_URL/zh/"
echo ""
echo "🔍 如有问题，检查："
echo "   - GitHub Actions: https://github.com/AutoBrainLab/yuzhang-lab-website/actions"
echo "   - 浏览器开发者工具 Console 和 Network 标签"
