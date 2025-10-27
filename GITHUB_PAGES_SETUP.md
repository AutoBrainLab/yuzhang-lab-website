# GitHub Pages Setup Instructions

## ✅ Code Pushed Successfully

The website code has been pushed to: `https://github.com/AutoBrainLab/yuzhang-lab-website`

## 📋 GitHub Repository Settings Required

To enable GitHub Pages deployment, follow these steps:

### 1. Enable GitHub Pages

1. Go to your repository: https://github.com/AutoBrainLab/yuzhang-lab-website
2. Click on **Settings** tab
3. In the left sidebar, click **Pages**
4. Under **Source**, select:
   - Source: **GitHub Actions** (not "Deploy from a branch")
5. Click **Save**

### 2. Verify Workflow Permissions

1. In repository **Settings**
2. Click **Actions** → **General** in the left sidebar
3. Scroll to **Workflow permissions**
4. Select **Read and write permissions**
5. Check ✅ **Allow GitHub Actions to create and approve pull requests**
6. Click **Save**

### 3. Trigger Deployment

The deployment will start automatically because we just pushed to `main` branch.

You can also manually trigger it:
1. Go to **Actions** tab
2. Click on **Deploy Hugo site to GitHub Pages** workflow
3. Click **Run workflow** → **Run workflow**

### 4. Monitor Deployment

1. Go to **Actions** tab
2. You should see a running workflow: "Deploy Hugo site to GitHub Pages"
3. Click on it to see progress
4. Wait for both "build" and "deploy" jobs to complete (✅ green checkmarks)

### 5. Access Your Website

Once deployment is complete (usually 2-5 minutes):

**Live URL**: https://autobrainlab.github.io/yuzhang-lab-website/

## 🔍 Troubleshooting

### If deployment fails:

1. **Check workflow logs**:
   - Go to Actions tab
   - Click on the failed workflow
   - Read error messages in build/deploy steps

2. **Common issues**:
   - **Hugo version mismatch**: Workflow uses Hugo v0.152.2
   - **Module errors**: Check `website-new/go.mod`
   - **Build errors**: Check HTML/markdown syntax

3. **Re-run failed workflow**:
   - Click on failed workflow
   - Click "Re-run all jobs"

## 📝 Configuration Files

Key files for GitHub Pages deployment:

1. **`.github/workflows/deploy-hugo.yml`**
   - GitHub Actions workflow
   - Builds Hugo site and deploys to GitHub Pages

2. **`website-new/config/_default/hugo.yaml`**
   - Production baseURL: `https://autobrainlab.github.io/yuzhang-lab-website/`

3. **`website-new/config/_default/config.development.yaml`**
   - Development baseURL: `http://localhost:1313/yuzhang-lab-website/`
   - Used when running `hugo server` locally

## 🔄 Future Updates

After making changes to the website:

```bash
# 1. Make your changes in website-new/

# 2. Test locally
cd website-new
hugo server -D

# 3. Commit and push
cd ..
git add .
git commit -m "Update website content"
git push origin main

# 4. GitHub Actions will automatically deploy
# Wait 2-5 minutes, then visit:
# https://autobrainlab.github.io/yuzhang-lab-website/
```

## ✅ Checklist

- [x] Code pushed to GitHub
- [ ] GitHub Pages enabled (Source: GitHub Actions)
- [ ] Workflow permissions set (Read and write)
- [ ] First deployment triggered
- [ ] Deployment successful (check Actions tab)
- [ ] Website accessible at live URL

## 📧 Support

If you encounter issues:
1. Check GitHub Actions logs
2. Review Hugo build output
3. Verify all configuration files
4. Check this documentation

---

*Created: October 26, 2025*
