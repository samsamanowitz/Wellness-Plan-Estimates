# Wellness Plans Admin Portal - Administrator Setup

**For**: Repository Administrator (One-Time)
**Last Updated**: February 13, 2026

## Overview

This guide is for the admin who sets up the GitHub Actions integration.

**Staff don't need this** - they just log in with password and use the interface.

## One-Time Setup (Administrator Only)

### 1. Create Fine-Grained Personal Access Token

1. Go to: https://github.com/settings/tokens?type=beta
2. Click "Generate new token"
3. Configure:
   - **Name**: `Wellness Plans Workflow Trigger`
   - **Expiration**: 1 year
   - **Repository**: Only `Wellness-Plan-Estimates`
   - **Permissions**:
     - **Actions**: Read and write ✅
     - **Contents**: Read and write ✅ (REQUIRED - enables repository_dispatch API)
     - **Metadata**: Read-only ✅ (auto-selected)
4. Generate and copy token (starts with `github_pat_`)

### 2. Configure Admin Portal

**IMPORTANT**: Must access via HTTPS (GitHub Pages), not local file:

1. Open: https://samsamanowitz.github.io/Wellness-Plan-Estimates/wellness-plans-data/admin.html
2. Log in with password
3. Click "Configure Workflow Token" button
4. Paste token from step 1
5. Verify "✅ Configured" status appears
6. Done!

Token stored in browser localStorage (HTTPS only). Staff never see it.

## Annual Maintenance

**Token expires after 1 year**:
1. Create new token (follow step 1 above)
2. Click "Configure Workflow Token" again
3. Paste new token
4. Revoke old token at: https://github.com/settings/tokens

## Troubleshooting

**Token not saving / "Configure Workflow Token" doesn't persist**:
- ❌ Do NOT use local file (file:///...) - localStorage won't work!
- ✅ MUST access via GitHub Pages: https://samsamanowitz.github.io/Wellness-Plan-Estimates/wellness-plans-data/admin.html
- Open browser DevTools (F12) → Console tab
- Type: `localStorage.getItem('workflowToken')`
- Should show your token after configuration

**Workflow doesn't trigger when clicking Save**:
- ❌ Most common cause: Token missing "Contents: write" permission!
- ✅ Go to https://github.com/settings/tokens and edit token
- ✅ Change "Contents" from "Read-only" to "Read and write"
- ✅ Reconfigure token in admin portal
- Check browser console for API errors (F12 → Console)

**"Token expired" error**:
- Create new token and reconfigure (expires after 1 year)

**"Token rejected" / 403/404 error**:
- Verify token has **Contents: read/write** (NOT read-only!)
- Check token has **Actions: read/write**
- Ensure token is for correct repository: `Wellness-Plan-Estimates`

**Changes not appearing**:
- Check workflow logs: https://github.com/samsamanowitz/Wellness-Plan-Estimates/actions
- Verify GitHub Actions is enabled in repository settings
- Wait 30-60 seconds for GitHub Pages deployment

## Support

- **Repository**: https://github.com/samsamanowitz/Wellness-Plan-Estimates
- **Workflow logs**: https://github.com/samsamanowitz/Wellness-Plan-Estimates/actions
- **Data file**: https://samsamanowitz.github.io/Wellness-Plan-Estimates/wellness-plans-data/plans.json
