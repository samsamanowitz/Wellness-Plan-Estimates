# Wellness Plans Admin Interface - Deployment Guide

## 📋 Overview

This guide walks you through deploying the wellness plans admin interface from start to finish.

**What You're Building:**
- Admin web interface for updating pricing (no code editing required)
- Automatic synchronization to all hospital computers
- Full audit trail via Git commits
- Zero-cost hosting via GitHub Pages

**Time Required:** 30-45 minutes

---

## 🚀 Step 1: Create GitHub Repository

### 1.1 Create New Repository

1. Go to [GitHub](https://github.com) and log in
2. Click the **+** icon in top-right → **New repository**
3. Fill in repository details:
   - **Repository name**: `wellness-plans-data`
   - **Description**: `Wellness plan pricing data for veterinary estimate generator`
   - **Visibility**: Public (or Private if you prefer)
   - **Initialize with README**: ❌ Leave unchecked (we have our own)
4. Click **Create repository**

### 1.2 Upload Files

You have two options:

**Option A: Via GitHub Web Interface (Easiest)**

1. Click **uploading an existing file** link on the empty repository page
2. Drag and drop these files from `wellness-plans-data/` folder:
   - `plans.json`
   - `admin.html`
   - `README.md`
   - `.gitignore`
3. Scroll down and click **Commit changes**

**Option B: Via Git Command Line**

```bash
cd /Users/samuelsamanowitz/Documents/Samanowitz\ Technologies\ LLC/Wellness\ Plan\ Estimates/wellness-plans-data

git init
git add .
git commit -m "Initial commit: wellness plans data and admin interface"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/wellness-plans-data.git
git push -u origin main
```

Replace `YOUR-USERNAME` with your actual GitHub username.

---

## 🌐 Step 2: Enable GitHub Pages

### 2.1 Configure GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** tab
3. Scroll down to **Pages** section in left sidebar
4. Under **Source**:
   - Branch: Select `main`
   - Folder: Select `/ (root)`
5. Click **Save**
6. Wait 1-2 minutes for deployment

### 2.2 Verify Deployment

1. GitHub will show: "Your site is published at `https://YOUR-USERNAME.github.io/wellness-plans-data/`"
2. Test the JSON file is accessible:
   ```bash
   curl https://YOUR-USERNAME.github.io/wellness-plans-data/plans.json
   ```
   You should see the JSON data.

3. Test the admin interface:
   ```
   https://YOUR-USERNAME.github.io/wellness-plans-data/admin.html
   ```
   You should see the login page (won't work yet, that's next step).

---

## 🔑 Step 3: Create GitHub Personal Access Token

### 3.1 Generate Token

1. Go to GitHub → Click your profile picture → **Settings**
2. Scroll down to **Developer settings** (bottom of left sidebar)
3. Click **Personal access tokens** → **Tokens (classic)**
4. Click **Generate new token** → **Generate new token (classic)**
5. Configure the token:
   - **Note**: `Wellness Plans Admin`
   - **Expiration**: `90 days` (recommended)
   - **Select scopes**: ✅ Check **repo** (full control of private repositories)
6. Scroll down and click **Generate token**
7. **CRITICAL**: Copy the token immediately!
   - It starts with `ghp_`
   - You'll never see it again after leaving this page
   - Store it in a password manager

### 3.2 Security Notes

- ⚠️ **Never share this token** - it has full access to your repositories
- ⚠️ **Don't commit it to Git** - only enter it in the admin interface
- ✅ **Rotate every 90 days** - GitHub will warn you when it's expiring
- ✅ **Revoke if compromised** - Go back to Personal access tokens → Delete

---

## ⚙️ Step 4: Configure Admin Interface

### 4.1 Update admin.html with Your GitHub Info

1. Open `wellness-plans-data/admin.html` in a text editor
2. Find lines 266-267:
   ```javascript
   const GITHUB_OWNER = 'YOUR-GITHUB-USERNAME';  // Replace with your GitHub username or org
   const GITHUB_REPO = 'wellness-plans-data';    // Repository name
   ```
3. Replace `YOUR-GITHUB-USERNAME` with your actual GitHub username
4. Save the file

### 4.2 Commit the Change

**Via GitHub Web Interface:**
1. Go to your repository on GitHub
2. Click `admin.html`
3. Click the pencil icon (Edit)
4. Update the `GITHUB_OWNER` line
5. Scroll down, add commit message: `Configure GitHub owner`
6. Click **Commit changes**

**Via Git Command Line:**
```bash
cd wellness-plans-data
git add admin.html
git commit -m "Configure GitHub owner for admin interface"
git push
```

### 4.3 Wait for GitHub Pages to Update

- Changes take 30-60 seconds to deploy
- Refresh the admin.html page after waiting

---

## 🧪 Step 5: Test Admin Interface

### 5.1 Login Test

1. Open: `https://YOUR-USERNAME.github.io/wellness-plans-data/admin.html`
2. Paste your GitHub Personal Access Token (starts with `ghp_`)
3. Click **Login**
4. You should see:
   - All 4 plans loaded (Puppy, Canine Adult, Kitten, Feline Adult)
   - Global settings section
   - Status indicator showing "Connected"
   - Last updated timestamp

### 5.2 Make a Test Change

1. Find **Puppy Plan 2026**
2. Change **Monthly Base Cost** from `67.00` to `67.01`
3. Click **Save**
4. You should see:
   - Success message: "Changes saved successfully!"
   - Green toast notification

### 5.3 Verify Commit

1. Click **View Audit Log** link in top-right
2. You should see a new commit with message:
   ```
   Update Puppy Plan 2026 base cost from $67.00 to $67.01
   ```
3. Click the commit to see the diff (what changed)

### 5.4 Verify JSON Updated

1. Wait 30-60 seconds for GitHub Pages to update
2. Check the JSON file:
   ```bash
   curl https://YOUR-USERNAME.github.io/wellness-plans-data/plans.json | grep "baseCost"
   ```
3. Puppy plan should show `67.01`

### 5.5 Revert Test Change

1. Go back to admin interface
2. Change Puppy Plan base cost back to `67.00`
3. Click **Save**
4. This creates another commit (part of the audit trail!)

---

## 🏥 Step 6: Update Generator on Hospital Computers

### 6.1 Update the URL in Generator

1. Open `Wellness_Estimate_Generator.html` in a text editor
2. Find line ~1814 (search for `PLANS_DATA_URL`):
   ```javascript
   const PLANS_DATA_URL = 'https://YOUR-USERNAME.github.io/wellness-plans-data/plans.json';
   ```
3. Replace `YOUR-USERNAME` with your actual GitHub username
4. Save the file

### 6.2 Test Locally First

1. Open `Wellness_Estimate_Generator.html` in a browser
2. Open browser console (F12 → Console tab)
3. Look for these messages:
   ```
   Loading plans data from GitHub Pages...
   ✓ Plans loaded from GitHub Pages successfully
   Last updated: [timestamp]
   ```
4. If you see errors, double-check the URL

### 6.3 Test Estimate Creation

1. Enter a pet name (e.g., "Fluffy")
2. Select **Puppy Plan 2026**
3. Verify the monthly cost shows correctly
4. Select an optional service
5. Create an estimate and email it
6. Open the emailed link and verify it displays correctly

### 6.4 Deploy to Hospital Computers

**One-time manual distribution (last time!):**

1. Copy `Wellness_Estimate_Generator.html` to USB drive
2. Visit each hospital computer
3. Replace the old file with the new one
4. Test on first computer, verify console shows "Plans loaded from GitHub Pages"
5. If successful, roll out to remaining computers

---

## ✅ Step 7: Verify End-to-End

### 7.1 Full Integration Test

1. **Admin** updates Kitten Plan base cost to `54.50`
2. **Admin** clicks Save in admin interface
3. Wait 60 seconds for GitHub Pages to update
4. **Staff** on hospital computer refreshes generator page
5. **Staff** creates estimate for Kitten Plan
6. **Verify** estimate shows new $54.50 price
7. **Staff** emails estimate to test email
8. **Verify** emailed link shows $54.50 in viewer

### 7.2 Test Offline Mode

1. Open generator in browser
2. Open DevTools (F12) → Network tab
3. Check "Offline" checkbox
4. Refresh page
5. Console should show: "✓ Using cached plans data from: [timestamp]"
6. Verify generator still works

### 7.3 Test Fallback Mode

1. In browser console, type: `localStorage.clear()`
2. Keep offline mode enabled
3. Refresh page
4. Console should show: "⚠️ Using hardcoded fallback data"
5. Verify generator still works

---

## 📚 Step 8: Staff Training

### 8.1 Create Admin User Guide

**Quick Reference for Staff:**

1. **To Update Pricing:**
   - Open: `https://YOUR-USERNAME.github.io/wellness-plans-data/admin.html`
   - Enter your GitHub token (first time only)
   - Find the plan/service to update
   - Change the price
   - Click Save
   - Changes appear on all computers within 2 minutes

2. **To View Change History:**
   - Click "View Audit Log" link
   - See who changed what and when
   - Click any commit to see the diff

3. **If You Forgot Your Token:**
   - Generate a new one (Step 3)
   - Enter it in the admin interface
   - Old token automatically stops working

### 8.2 Train Key Staff

Schedule 15-minute sessions with staff who will update pricing:
- Show how to log in
- Walk through updating a price
- Show the audit log
- Explain 2-minute delay for changes to sync
- Give them a copy of the Quick Reference guide

---

## 🎉 Success Criteria

You're done when:

- ✅ Admin interface loads and authenticates
- ✅ Changes save successfully (see green toast)
- ✅ Commits appear in repository with clear messages
- ✅ plans.json updates within 60 seconds
- ✅ Generator loads data from GitHub Pages (check console)
- ✅ Generator works offline with cache
- ✅ Generator falls back to hardcoded data when needed
- ✅ Old estimate links still work (backwards compatibility)
- ✅ New estimates use latest pricing
- ✅ Staff can update pricing without your help

---

## 🔧 Troubleshooting

### "Failed to fetch plans data: 404"

**Problem**: Generator can't find plans.json

**Solution**:
1. Verify GitHub Pages is enabled in repository settings
2. Check the URL in browser: `https://YOUR-USERNAME.github.io/wellness-plans-data/plans.json`
3. Verify `PLANS_DATA_URL` in generator matches the GitHub Pages URL exactly
4. Wait 2-3 minutes after enabling GitHub Pages

### "Invalid token or repository not found"

**Problem**: Can't log in to admin interface

**Solution**:
1. Verify token is valid (check GitHub → Settings → Developer settings → Personal access tokens)
2. Verify token has `repo` scope
3. Verify `GITHUB_OWNER` in admin.html matches your GitHub username exactly
4. Verify repository name is exactly `wellness-plans-data`
5. Try generating a new token

### "Changes not appearing on hospital computers"

**Problem**: Generator still shows old prices after admin update

**Solution**:
1. Check GitHub Pages update delay (30-60 seconds after commit)
2. Staff needs to refresh the generator page (F5 or Cmd+R)
3. Clear browser cache: Ctrl+Shift+Delete (Windows) or Cmd+Shift+Delete (Mac)
4. Clear localStorage: Open console, type `localStorage.clear()`, refresh
5. Verify plans.json shows new price: view raw file on GitHub Pages

### "Using hardcoded fallback data" in console

**Problem**: Generator is offline or can't reach GitHub

**Solution**:
1. Check internet connection
2. Verify GitHub Pages URL is accessible in browser
3. Check for corporate firewall blocking GitHub Pages
4. If online, clear localStorage and refresh to rebuild cache

### Estimates emailed before update now show wrong prices

**This is normal!** Old estimates are frozen at the time they were created. They won't update because:
- Data is embedded in the URL (self-contained)
- This is by design for backwards compatibility
- Old estimates remain valid forever

---

## 📞 Support Contacts

**Technical Issues**:
- Email: [your-email@example.com]
- Phone: [your-phone]

**GitHub Pages Status**:
- [GitHub Status](https://www.githubstatus.com/)

**Documentation**:
- Project README: `wellness-plans-data/README.md`
- Code Documentation: `CLAUDE.md`

---

## 🔄 Regular Maintenance

### Every 90 Days

**Rotate GitHub Personal Access Token:**
1. Generate new token (Step 3)
2. Enter in admin interface
3. Revoke old token in GitHub settings

### Monthly

**Review Audit Log:**
1. Open: `https://github.com/YOUR-USERNAME/wellness-plans-data/commits/main/plans.json`
2. Review all pricing changes
3. Verify changes were authorized
4. Document any unusual patterns

### As Needed

**Update Plans Data:**
- Use admin interface (preferred)
- For structural changes (new plans, new fields), contact developer

---

## 🎓 Next Steps

Now that the system is deployed:

1. **Create backup admin access**: Generate token for backup staff member
2. **Document in practice manual**: Add Quick Reference guide to staff manual
3. **Schedule training**: Train all staff who will update pricing
4. **Monitor first month**: Watch for issues, gather feedback
5. **Celebrate**: You now have automatic pricing synchronization! 🎉

---

**Deployment Date**: _________________

**Deployed By**: _________________

**GitHub Repository**: `https://github.com/YOUR-USERNAME/wellness-plans-data`

**Admin Interface**: `https://YOUR-USERNAME.github.io/wellness-plans-data/admin.html`

**GitHub Pages Status**: ✅ Active / ⏳ Pending / ❌ Not Enabled
