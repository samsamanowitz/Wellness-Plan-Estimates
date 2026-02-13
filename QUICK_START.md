# Quick Start Guide - Wellness Plans Admin Interface

## 🚀 Get Up and Running in 15 Minutes

This guide gets you from zero to a working admin interface as quickly as possible. For detailed explanations, see DEPLOYMENT_GUIDE.md.

---

## Prerequisites

- [ ] GitHub account ([Sign up free](https://github.com/join))
- [ ] Git installed on your computer ([Download](https://git-scm.com/downloads))
- [ ] Text editor (VS Code, Sublime, or any editor)

---

## Step 1: Create GitHub Repository (3 minutes)

### Option A: Quick Setup (Recommended)

1. **Run the setup script:**
   ```bash
   cd "/Users/samuelsamanowitz/Documents/Samanowitz Technologies LLC/Wellness Plan Estimates/wellness-plans-data"
   ./SETUP.sh
   ```

2. **Follow the prompts** - enter your GitHub username when asked

3. **Create repository on GitHub:**
   - Go to: https://github.com/new
   - Repository name: `wellness-plans-data`
   - Leave everything else default
   - Click **Create repository**

4. **Push your code:**
   ```bash
   git push -u origin main
   ```

### Option B: Manual Setup

1. Go to https://github.com/new
2. Repository name: `wellness-plans-data`
3. Public or Private: Your choice
4. **Don't** check "Initialize with README"
5. Click **Create repository**
6. Run these commands:
   ```bash
   cd "/Users/samuelsamanowitz/Documents/Samanowitz Technologies LLC/Wellness Plan Estimates/wellness-plans-data"

   # Update admin.html with your username
   # Replace YOUR-GITHUB-USERNAME with your actual username in admin.html

   git init
   git add .
   git commit -m "Initial commit: wellness plans data and admin interface"
   git branch -M main
   git remote add origin https://github.com/YOUR-USERNAME/wellness-plans-data.git
   git push -u origin main
   ```

---

## Step 2: Enable GitHub Pages (2 minutes)

1. Go to your repository: `https://github.com/YOUR-USERNAME/wellness-plans-data`
2. Click **Settings** tab
3. Scroll to **Pages** in left sidebar
4. Under **Source**:
   - Branch: `main`
   - Folder: `/ (root)`
5. Click **Save**
6. Wait 1-2 minutes

**Verify:** Open `https://YOUR-USERNAME.github.io/wellness-plans-data/plans.json` - you should see JSON data

---

## Step 3: Create GitHub Token (3 minutes)

1. Click your profile picture → **Settings**
2. **Developer settings** (bottom left)
3. **Personal access tokens** → **Tokens (classic)**
4. **Generate new token (classic)**
5. Fill in:
   - Note: `Wellness Plans Admin`
   - Expiration: `90 days`
   - Scopes: ✅ **repo** (check the box)
6. Click **Generate token**
7. **COPY THE TOKEN** (starts with `ghp_`) - you'll never see it again!

---

## Step 4: Test Admin Interface (3 minutes)

1. Open: `https://YOUR-USERNAME.github.io/wellness-plans-data/admin.html`
2. Paste your token (from Step 3)
3. Click **Login**
4. You should see all 4 wellness plans loaded

**Make a test change:**
1. Find Puppy Plan base cost
2. Change from `67.00` to `67.01`
3. Click **Save**
4. You should see green "Changes saved successfully!" toast
5. Click **View Audit Log** - verify commit appears
6. Change it back to `67.00` and save again

---

## Step 5: Update Generator (4 minutes)

1. Open `Wellness_Estimate_Generator.html` in text editor
2. Find line ~1814 (search for `PLANS_DATA_URL`)
3. Replace `YOUR-USERNAME` with your actual GitHub username:
   ```javascript
   const PLANS_DATA_URL = 'https://YOUR-USERNAME.github.io/wellness-plans-data/plans.json';
   ```
4. Save the file
5. Open in browser
6. Press F12 → Console tab
7. Look for: `✓ Plans loaded from GitHub Pages successfully`

**Test it works:**
1. Create an estimate for any pet
2. Verify calculations are correct
3. Email an estimate to yourself
4. Verify the emailed link works

---

## ✅ Success Checklist

You're done when all these are true:

- [ ] Repository created on GitHub
- [ ] Files pushed to repository
- [ ] GitHub Pages enabled and serving files
- [ ] plans.json accessible at GitHub Pages URL
- [ ] GitHub Personal Access Token created
- [ ] Admin interface loads and authenticates
- [ ] Test change saved successfully
- [ ] Commit appears in audit log
- [ ] Generator updated with your GitHub username
- [ ] Generator console shows "Plans loaded from GitHub Pages"
- [ ] Test estimate created and emailed successfully

---

## 🎉 You're Live!

Your admin interface is now live at:
```
https://YOUR-USERNAME.github.io/wellness-plans-data/admin.html
```

### What You Can Do Now

1. **Update Pricing** - Changes sync to all computers within 2 minutes
2. **View History** - Click "View Audit Log" to see all changes
3. **Train Staff** - Show them the admin interface (15 minutes)
4. **Deploy Generator** - Copy updated generator to hospital computers

---

## 📱 Bookmark These URLs

**Admin Interface:**
```
https://YOUR-USERNAME.github.io/wellness-plans-data/admin.html
```

**Plans Data (API):**
```
https://YOUR-USERNAME.github.io/wellness-plans-data/plans.json
```

**Repository:**
```
https://github.com/YOUR-USERNAME/wellness-plans-data
```

**Audit Log:**
```
https://github.com/YOUR-USERNAME/wellness-plans-data/commits/main/plans.json
```

---

## 🆘 Quick Troubleshooting

### "404 Not Found" when opening admin.html
- **Wait 2-3 minutes** - GitHub Pages takes time to deploy
- Check Settings → Pages shows "Your site is published"
- Verify files were pushed: `git push origin main`

### "Invalid token" error
- Verify token has `repo` scope
- Check token hasn't expired
- Generate a new token if needed

### Generator not loading data
- Check console (F12) for error messages
- Verify `PLANS_DATA_URL` matches your GitHub username exactly
- Test the URL in browser - should show JSON

### Changes not syncing
- Wait 2 minutes for GitHub Pages to update
- Staff must refresh the generator page (F5)
- Clear browser cache if needed

---

## 📚 Next Steps

1. **Read DEPLOYMENT_GUIDE.md** for complete instructions
2. **Review IMPLEMENTATION_SUMMARY.md** for technical details
3. **Check CLAUDE.md** for project architecture
4. **Train staff** on using admin interface
5. **Deploy to all hospital computers**

---

## 📞 Need Help?

- **Full Guide:** DEPLOYMENT_GUIDE.md
- **Troubleshooting:** DEPLOYMENT_GUIDE.md → Troubleshooting section
- **GitHub Pages Docs:** https://docs.github.com/pages
- **GitHub Token Docs:** https://docs.github.com/authentication

---

**Setup Time:** ~15 minutes
**Difficulty:** Easy
**Cost:** $0/month forever

**Questions?** Review the detailed guides in this directory.
