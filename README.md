# Yuzhang Neuro+AI Lab - Digital Assets Repository

Official repository for the Yuzhang Neuro+AI Laboratory's digital presence and documentation.

## 📁 Repository Structure

```
yu_lab/
├── .github/workflows/     # CI/CD automation
├── docs/                  # Project documentation
├── website-new/           # Active Hugo website (Hugo Blox theme)
│   ├── content/          # English content
│   ├── content/zh/       # Chinese (中文) content
│   ├── config/           # Site configuration
│   ├── layouts/          # Custom templates
│   ├── static/           # Static assets
│   └── themes/           # Hugo themes
├── website/               # Legacy website (deprecated)
└── scripts/               # Utility scripts
```

## 🌐 Website

**Live URL**: https://autobrainlab.github.io/yuzhang-lab-website/

**Technology Stack**:
- Hugo Extended v0.152.2 (Static Site Generator)
- Hugo Blox Builder Theme
- GitHub Pages (Hosting)
- GitHub Actions (CI/CD)

## 🚀 Quick Start

### Prerequisites
- Hugo Extended v0.152.2+
- Node.js (for theme dependencies)
- Git

### Local Development
```bash
cd website-new
hugo server -D --bind 0.0.0.0 --port 1313
# Visit http://localhost:1313/yuzhang-lab-website/
```

### Build for Production
```bash
cd website-new
hugo --gc --minify
```

## 📝 Content Management

### Adding News
```bash
# English
cd website-new
hugo new news/YYYY-news-title.md

# Chinese
hugo new zh/news/YYYY-news-title.md
```

### Adding Publications
Edit files in:
- `website-new/content/publications/` (English)
- `website-new/content/zh/publications/` (Chinese)

### Adding Team Members
Edit files in:
- `website-new/content/people/` (English)
- `website-new/content/zh/people/` (Chinese)

## 🌍 Multilingual Support

The website is fully bilingual:
- **English**: `/en/` (default language)
- **中文**: `/zh/` (Chinese)

## 📚 Documentation

- [Project Analysis & Development Plan](PROJECT_ANALYSIS_AND_DEVELOPMENT_PLAN.md)
- [Repository Migration Plan](REPOSITORY_MIGRATION_PLAN.md)
- [Website Building Guide](docs/WEBSITE_GUIDE.md)

## 🔄 Deployment

The website is automatically deployed to GitHub Pages when changes are pushed to the `main` branch via GitHub Actions workflow (`.github/workflows/deploy-hugo.yml`).

## 🔧 Recent Improvements (Oct 26, 2025)

- ✅ Fixed HTML rendering issues in Research page
- ✅ Resolved markdown indentation problems (Goldmark compatibility)
- ✅ Configured multilingual content filtering
- ✅ Set up GitHub Pages deployment
- ✅ Updated baseURL for production environment

## 📧 Contact

**Principal Investigator**: Prof. Yu Zhang  
**Email**: yuzhang2@sjtu.edu.cn  
**Institution**: School of Psychology, Shanghai Jiao Tong University  
**Lab Website**: https://autobrainlab.github.io/yuzhang-lab-website/

## 📄 License

Copyright © 2025 Yuzhang Neuro+AI Lab. All rights reserved.

---

*Last updated: October 26, 2025*
