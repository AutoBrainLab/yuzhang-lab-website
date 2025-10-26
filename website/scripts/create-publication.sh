#!/bin/bash

# 批量创建论文页面脚本
# 使用方法: ./create-publication.sh "作者年份标题" "完整标题" "期刊名" "年份"

if [ $# -lt 4 ]; then
    echo "使用方法: $0 <文件名> <标题> <期刊> <年份> [类别1,类别2] [DOI] [引用数]"
    echo "示例: $0 zhang2025brain \"Brain Atlas Study\" \"Nature Neuroscience\" 2025 \"Brain Atlas,Neuroimaging\" \"10.1038/xxx\" 50"
    exit 1
fi

FILENAME=$1
TITLE=$2
JOURNAL=$3
YEAR=$4
CATEGORIES=${5:-"Neuroimaging"}
DOI=${6:-""}
CITATIONS=${7:-0}

# 创建英文版
cat > "content/publications/${FILENAME}.md" << EOF
---
title: "${TITLE}"
date: ${YEAR}-01-01
draft: false

# Publication type
publication_types: ["article-journal"]

# Authors
authors:
  - Yu Zhang
  - Author 2
  - Author 3

# Publication details
publication: "*${JOURNAL}*"
publication_short: ""

# Abstract
abstract: |
  Add abstract here.

# Summary
summary: Brief summary of the paper.

# Tags and categories
tags:
  - Brain Imaging
  - Neuroinformatics
categories: [${CATEGORIES}]

# Display settings
featured: false

# Links
url_pdf: ""
url_code: ""
url_dataset: ""
url_poster: ""
url_project: ""
url_slides: ""
url_source: ""
url_video: ""

# DOI and citations
doi: "${DOI}"
citations: ${CITATIONS}

# Featured image
image:
  caption: ""
  focal_point: "Smart"
  preview_only: false

# Projects (optional)
projects: []

# Slides (optional)
slides: ""
---

## Full Text

Add full text or detailed description here.

## Key Findings

- Finding 1
- Finding 2
- Finding 3

## Citation

\`\`\`bibtex
@article{${FILENAME},
  title={${TITLE}},
  author={Zhang, Yu and others},
  journal={${JOURNAL}},
  year={${YEAR}},
  doi={${DOI}}
}
\`\`\`
EOF

# 创建中文版
cat > "content/zh/publications/${FILENAME}.md" << EOF
---
title: "${TITLE}"
date: ${YEAR}-01-01
draft: false

# 出版物类型
publication_types: ["article-journal"]

# 作者
authors:
  - 张瑜
  - 作者2
  - 作者3

# 出版信息
publication: "*${JOURNAL}*"
publication_short: ""

# 摘要
abstract: |
  在此添加中文摘要。

# 概要
summary: 论文简要概述。

# 标签和分类
tags:
  - 脑影像
  - 神经信息学
categories: [${CATEGORIES}]

# 显示设置
featured: false

# 链接
url_pdf: ""
url_code: ""
url_dataset: ""
url_poster: ""
url_project: ""
url_slides: ""
url_source: ""
url_video: ""

# DOI和引用
doi: "${DOI}"
citations: ${CITATIONS}

# 特色图片
image:
  caption: ""
  focal_point: "Smart"
  preview_only: false

# 项目（可选）
projects: []

# 幻灯片（可选）
slides: ""
---

## 全文

在此添加全文或详细描述。

## 主要发现

- 发现1
- 发现2
- 发现3

## 引用

\`\`\`bibtex
@article{${FILENAME},
  title={${TITLE}},
  author={Zhang, Yu and others},
  journal={${JOURNAL}},
  year={${YEAR}},
  doi={${DOI}}
}
\`\`\`
EOF

echo "✅ 已创建论文页面:"
echo "   - content/publications/${FILENAME}.md"
echo "   - content/zh/publications/${FILENAME}.md"
