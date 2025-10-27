#!/bin/bash

# GitHub Pages Verification Script
# Usage: ./verify-github-pages.sh

BASE_URL="https://autobrainlab.github.io/yuzhang-lab-website"

echo "======================================"
echo "GitHub Pages Deployment Verification"
echo "======================================"
echo ""

# Function to check URL
check_url() {
    local url=$1
    local expected=$2
    local desc=$3
    
    echo -n "Checking $desc... "
    status=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    
    if [ "$status" = "$expected" ]; then
        echo "✅ $status"
        return 0
    else
        echo "❌ $status (expected $expected)"
        return 1
    fi
}

# Check main pages
echo "1. Main Pages"
echo "-------------"
check_url "$BASE_URL/" "200" "Root (redirect)"
check_url "$BASE_URL/en/" "200" "English homepage"
check_url "$BASE_URL/zh/" "200" "Chinese homepage"
echo ""

# Check resources
echo "2. CSS Resources"
echo "----------------"
check_url "$BASE_URL/css/vendor-bundle.min.26c458e6907dc03073573976b7f4044e.css" "200" "Vendor CSS"
check_url "$BASE_URL/css/wowchemy.b1f2dc6443cb5306ae373ca47eeed880.css" "200" "Wowchemy CSS"
echo ""

echo "3. JavaScript Resources"
echo "-----------------------"
check_url "$BASE_URL/js/vendor-bundle.min.d613345003d21781ec611233eea95b85.js" "200" "Vendor JS"
check_url "$BASE_URL/js/wowchemy-init.min.9e4214442a7711d35691acd58f6f6361.js" "200" "Init JS"
echo ""

echo "4. Media Resources"
echo "------------------"
check_url "$BASE_URL/media/logo_hu_6c8a4be24d586532.png" "200" "Logo image"
check_url "$BASE_URL/media/icon_hu_2311fe1a408f47c1.png" "200" "Icon image"
echo ""

echo "5. Content Pages"
echo "----------------"
check_url "$BASE_URL/en/research/" "200" "Research page (EN)"
check_url "$BASE_URL/en/people/" "200" "People page (EN)"
check_url "$BASE_URL/en/publications/" "200" "Publications page (EN)"
check_url "$BASE_URL/zh/research/" "200" "Research page (ZH)"
echo ""

# Check for common issues
echo "6. Issue Detection"
echo "------------------"

echo -n "Checking for localhost links... "
if curl -s "$BASE_URL/en/" | grep -q "localhost:1313"; then
    echo "⚠️  Found localhost links"
else
    echo "✅ No localhost links"
fi

echo -n "Checking CSS loading... "
if curl -s "$BASE_URL/en/" | grep -q "vendor-bundle.min"; then
    echo "✅ CSS referenced in HTML"
else
    echo "❌ CSS not found in HTML"
fi

echo ""
echo "======================================"
echo "Verification Complete"
echo "======================================"
echo ""
echo "Visit the site: $BASE_URL"
