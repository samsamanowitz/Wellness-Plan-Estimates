# Deployment Checklist - Wellness Plans Admin Interface

Use this checklist to track your deployment progress. Check off items as you complete them.

---

## Pre-Deployment (Documentation Review)

- [ ] Read QUICK_START.md
- [ ] Skim DEPLOYMENT_GUIDE.md
- [ ] Review IMPLEMENTATION_SUMMARY.md
- [ ] Understand the architecture from CLAUDE.md

**Estimated Time:** 30 minutes

---

## Phase 1: GitHub Setup

### Create Repository
- [ ] Sign in to GitHub account
- [ ] Navigate to https://github.com/new
- [ ] Repository name: `wellness-plans-data`
- [ ] Visibility: Public (or Private)
- [ ] Do NOT check "Initialize with README"
- [ ] Click "Create repository"
- [ ] Note repository URL: `https://github.com/___________/wellness-plans-data`

**Estimated Time:** 3 minutes

### Upload Files

**Option A: Quick Setup Script (Recommended)**
- [ ] Open Terminal
- [ ] Navigate to wellness-plans-data directory
- [ ] Run: `./SETUP.sh`
- [ ] Enter your GitHub username when prompted
- [ ] Push code: `git push -u origin main`

**Option B: Manual Upload**
- [ ] Click "uploading an existing file" on empty repo page
- [ ] Drag and drop: plans.json, admin.html, README.md, .gitignore
- [ ] Click "Commit changes"

**OR Option C: Git Command Line**
- [ ] `cd wellness-plans-data`
- [ ] Update GITHUB_OWNER in admin.html
- [ ] `git init`
- [ ] `git add .`
- [ ] `git commit -m "Initial commit"`
- [ ] `git branch -M main`
- [ ] `git remote add origin [URL from above]`
- [ ] `git push -u origin main`

**Estimated Time:** 5 minutes

---

## Phase 2: Enable GitHub Pages

- [ ] Go to repository on GitHub
- [ ] Click "Settings" tab
- [ ] Click "Pages" in left sidebar
- [ ] Under "Source", select:
  - Branch: `main`
  - Folder: `/ (root)`
- [ ] Click "Save"
- [ ] Wait 1-2 minutes for deployment
- [ ] Note GitHub Pages URL: `https://________________.github.io/wellness-plans-data/`

### Verify Deployment
- [ ] Open: `[GitHub Pages URL]/plans.json` in browser
- [ ] Verify JSON data displays correctly
- [ ] Open: `[GitHub Pages URL]/admin.html` in browser
- [ ] Verify admin login page displays

**Estimated Time:** 3 minutes

---

## Phase 3: GitHub Personal Access Token

### Generate Token
- [ ] Click your profile picture → Settings
- [ ] Click "Developer settings" (bottom left)
- [ ] Click "Personal access tokens" → "Tokens (classic)"
- [ ] Click "Generate new token (classic)"
- [ ] Fill in form:
  - Note: `Wellness Plans Admin`
  - Expiration: `90 days`
  - Scopes: ✅ **repo** (check this box)
- [ ] Click "Generate token"
- [ ] **COPY TOKEN IMMEDIATELY** (starts with `ghp_`)
- [ ] Store token securely in password manager
- [ ] Token: `ghp_________________________________`

**Estimated Time:** 3 minutes

---

## Phase 4: Test Admin Interface

### Login Test
- [ ] Open: `[GitHub Pages URL]/admin.html`
- [ ] Paste GitHub token in input field
- [ ] Click "Login"
- [ ] Verify all 4 plans loaded:
  - [ ] Puppy Plan 2026
  - [ ] Canine Adult Plan 2026
  - [ ] Kitten Plan 2026
  - [ ] Feline Adult Plan 2026
- [ ] Verify "Connected" status shows in toolbar
- [ ] Verify "Last updated" timestamp displays

**Estimated Time:** 2 minutes

### Make Test Change
- [ ] Find "Puppy Plan 2026"
- [ ] Note current base cost: $______
- [ ] Change to: $67.01
- [ ] Click "Save"
- [ ] Verify green toast: "Changes saved successfully!"
- [ ] Click "View Audit Log" link
- [ ] Verify new commit appears
- [ ] Verify commit message describes the change
- [ ] Change base cost back to original value
- [ ] Click "Save"
- [ ] Verify second commit appears

**Estimated Time:** 3 minutes

### Verify JSON Updated
- [ ] Wait 30-60 seconds
- [ ] Open: `[GitHub Pages URL]/plans.json`
- [ ] Search for "puppy" → "baseCost"
- [ ] Verify shows correct value
- [ ] Or run in terminal:
  ```
  curl [GitHub Pages URL]/plans.json | grep baseCost
  ```

**Estimated Time:** 2 minutes

---

## Phase 5: Update Generator

### Modify Generator File
- [ ] Open: `Wellness_Estimate_Generator.html` in text editor
- [ ] Find line ~1814 (search for: `PLANS_DATA_URL`)
- [ ] Current line reads:
  ```javascript
  const PLANS_DATA_URL = 'https://YOUR-USERNAME.github.io/wellness-plans-data/plans.json';
  ```
- [ ] Replace `YOUR-USERNAME` with your actual GitHub username
- [ ] Save file

**Estimated Time:** 2 minutes

### Test Locally
- [ ] Open `Wellness_Estimate_Generator.html` in browser
- [ ] Press F12 (or Cmd+Option+I on Mac) to open Console
- [ ] Look for console messages:
  - [ ] "Loading plans data from GitHub Pages..."
  - [ ] "✓ Plans loaded from GitHub Pages successfully"
  - [ ] "Last updated: [timestamp]"
- [ ] If errors appear, verify URL is correct

**Estimated Time:** 2 minutes

### Test Functionality
- [ ] Enter pet name: "Test Pet"
- [ ] Select plan: "Puppy Plan 2026"
- [ ] Verify monthly cost displays correctly
- [ ] Select an optional service
- [ ] Verify calculations are correct
- [ ] Scroll to bottom, verify grand total correct
- [ ] Enter your email address
- [ ] Click "Email Estimate"
- [ ] Check your email
- [ ] Click the estimate link
- [ ] Verify estimate displays correctly in viewer

**Estimated Time:** 5 minutes

---

## Phase 6: Deploy to Hospital Computers

### Prepare
- [ ] Copy `Wellness_Estimate_Generator.html` to USB drive
- [ ] Print this checklist for reference at each computer
- [ ] Note: This is the LAST TIME you'll need to manually distribute!

**Estimated Time:** 2 minutes

### Per Computer Deployment
For each hospital computer:

- [ ] Computer 1:
  - [ ] Backup old file (rename to `*_OLD.html`)
  - [ ] Copy new file from USB
  - [ ] Open in browser
  - [ ] Press F12 → Console
  - [ ] Verify: "✓ Plans loaded from GitHub Pages successfully"
  - [ ] Test creating an estimate
  - [ ] Mark as complete: ✅

- [ ] Computer 2:
  - [ ] Same steps as Computer 1
  - [ ] Mark as complete: ✅

- [ ] Computer 3:
  - [ ] Same steps as Computer 1
  - [ ] Mark as complete: ✅

- [ ] Computer 4:
  - [ ] Same steps as Computer 1
  - [ ] Mark as complete: ✅

- [ ] Computer 5:
  - [ ] Same steps as Computer 1
  - [ ] Mark as complete: ✅

**Estimated Time:** 10 minutes per computer

---

## Phase 7: End-to-End Testing

### Integration Test
- [ ] **Admin**: Open admin interface
- [ ] **Admin**: Update Kitten Plan base cost to $54.50
- [ ] **Admin**: Click Save
- [ ] **Admin**: Verify commit appears in audit log
- [ ] Wait 60 seconds for GitHub Pages to update
- [ ] **Staff**: On hospital computer, refresh generator (F5)
- [ ] **Staff**: Create estimate for Kitten Plan
- [ ] **Staff**: Verify shows $54.50 monthly cost
- [ ] **Staff**: Email estimate to test email
- [ ] **Client**: Open estimate link from email
- [ ] **Client**: Verify shows $54.50 in viewer
- [ ] **Admin**: Change Kitten Plan back to $54.00
- [ ] Verify end-to-end flow works

**Estimated Time:** 10 minutes

### Offline Mode Test
- [ ] Open generator in browser
- [ ] Press F12 → Network tab
- [ ] Check "Offline" box
- [ ] Refresh page (F5)
- [ ] Verify console shows: "✓ Using cached plans data"
- [ ] Create a test estimate
- [ ] Verify works without internet

**Estimated Time:** 3 minutes

### Fallback Mode Test
- [ ] In browser console, type: `localStorage.clear()`
- [ ] Keep offline mode enabled
- [ ] Refresh page (F5)
- [ ] Verify console shows: "⚠️ Using hardcoded fallback data"
- [ ] Create a test estimate
- [ ] Verify works even without cache or internet
- [ ] Uncheck "Offline" and refresh to restore normal mode

**Estimated Time:** 3 minutes

### Backwards Compatibility Test
- [ ] Find an old estimate email (sent before this update)
- [ ] Click the estimate link
- [ ] Verify it still displays correctly
- [ ] Verify pricing matches what it was when sent
- [ ] This confirms data is self-contained in URLs

**Estimated Time:** 2 minutes

---

## Phase 8: Staff Training

### Prepare Training Materials
- [ ] Print quick reference guide from IMPLEMENTATION_SUMMARY.md
- [ ] Bookmark admin interface URL for easy access
- [ ] Prepare example: "Update Puppy Plan to $68"
- [ ] Schedule 15-minute sessions with each staff member

**Estimated Time:** 15 minutes

### Training Session (Per Staff Member)
- [ ] Show how to open admin interface
- [ ] Walk through login with GitHub token
- [ ] Explain what token is and how to store it
- [ ] Demonstrate updating a price
- [ ] Show the audit log
- [ ] Explain 2-minute sync delay
- [ ] Have them practice updating a price
- [ ] Answer questions
- [ ] Give them quick reference card

**Estimated Time:** 15 minutes per person

---

## Phase 9: Documentation

### Update Documentation
- [ ] Fill in actual GitHub username in docs
- [ ] Replace placeholders in DEPLOYMENT_GUIDE.md
- [ ] Update PROJECT_README.md with deployment date
- [ ] Add support contact information
- [ ] Document staff members with admin access

**Estimated Time:** 10 minutes

### Create Quick Reference Materials
- [ ] Print admin interface quick reference
- [ ] Post URL in staff area
- [ ] Add to practice manual
- [ ] Create contact card for technical support

**Estimated Time:** 10 minutes

---

## Phase 10: Post-Deployment Monitoring

### Week 1
- [ ] Day 1: Check console logs on all computers
- [ ] Day 2: Verify staff can update pricing
- [ ] Day 3: Review audit log for any issues
- [ ] Day 4: Check for any error reports
- [ ] Day 5: Gather staff feedback
- [ ] Day 7: Review any issues and address

**Estimated Time:** 15 minutes per day

### Month 1
- [ ] Week 2: Check in with staff
- [ ] Week 3: Review audit log
- [ ] Week 4: Conduct feedback survey
- [ ] End of month: Document lessons learned

**Estimated Time:** 30 minutes per week

---

## Success Criteria

Deployment is successful when all of these are true:

- [ ] ✅ Admin interface loads without errors
- [ ] ✅ Staff can log in with GitHub token
- [ ] ✅ Pricing updates save successfully
- [ ] ✅ Commits appear in Git with clear messages
- [ ] ✅ Changes sync to all computers within 2 minutes
- [ ] ✅ Generator loads data from GitHub Pages
- [ ] ✅ Console shows success message on all computers
- [ ] ✅ Estimates calculate correctly
- [ ] ✅ Email functionality works
- [ ] ✅ Viewer displays estimates correctly
- [ ] ✅ Old estimate links still work
- [ ] ✅ Offline mode works with cache
- [ ] ✅ Fallback mode works without cache
- [ ] ✅ Staff trained and comfortable with admin interface
- [ ] ✅ Quick reference materials distributed
- [ ] ✅ No errors reported in first week

---

## Rollback Plan (If Needed)

If something goes wrong and you need to rollback:

- [ ] Hospital computers: Replace with `Wellness_Estimate_Generator_BACKUP.html`
- [ ] GitHub: Revert commits via Git history
- [ ] Admin interface: Revoke GitHub token if compromised
- [ ] Contact technical support if needed

---

## Maintenance Schedule

Setup these recurring tasks:

### Daily (First Week Only)
- [ ] Monitor console logs
- [ ] Check for error reports
- [ ] Respond to staff questions

### Weekly (First Month)
- [ ] Review audit log
- [ ] Check system status
- [ ] Gather feedback

### Monthly (Ongoing)
- [ ] Review pricing changes in audit log
- [ ] Verify all computers syncing correctly
- [ ] Update documentation if needed

### Quarterly (Ongoing)
- [ ] Rotate GitHub Personal Access Token
- [ ] Review staff access
- [ ] Security audit
- [ ] Update this checklist if needed

### Annually (Ongoing)
- [ ] Full system review
- [ ] Consider improvements
- [ ] Update documentation
- [ ] Review emergency procedures

---

## Notes & Issues

Use this space to track issues encountered during deployment:

**Date:** ___________
**Issue:** _________________________________
**Resolution:** _____________________________

**Date:** ___________
**Issue:** _________________________________
**Resolution:** _____________________________

**Date:** ___________
**Issue:** _________________________________
**Resolution:** _____________________________

---

## Completion

**Deployment Started:** ___________ (Date/Time)
**Deployment Completed:** ___________ (Date/Time)
**Total Time:** ___________ hours
**Deployed By:** ___________
**Verified By:** ___________

**GitHub Repository:** https://github.com/___________/wellness-plans-data
**Admin Interface:** https://___________.github.io/wellness-plans-data/admin.html
**Plans API:** https://___________.github.io/wellness-plans-data/plans.json

**Status:**
- [ ] ⏳ In Progress
- [ ] ✅ Complete and Verified
- [ ] ⚠️ Complete with Issues (document above)

---

**Next Review Date:** ___________

🎉 **Congratulations! You now have automatic pricing synchronization across all hospital computers!**
