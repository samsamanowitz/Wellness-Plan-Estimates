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
     - **Contents**: Read-only ✅
     - **Metadata**: Read-only ✅ (auto-selected)
4. Generate and copy token (starts with `github_pat_`)

### 2. Configure Admin Portal

1. Open `wellness-plans-data/admin.html`
2. Log in with password
3. Click "Configure Workflow Token" button
4. Paste token from step 1
5. Done!

Token stored in browser localStorage. Staff never see it.

## Annual Maintenance

**Token expires after 1 year**:
1. Create new token (follow step 1 above)
2. Click "Configure Workflow Token" again
3. Paste new token
4. Revoke old token at: https://github.com/settings/tokens

## Troubleshooting

**"Token expired" error**:
- Create new token and reconfigure

**"Token rejected" error**:
- Check token has correct permissions (Actions: read/write)
- Ensure token is for correct repository

**Changes not appearing**:
- Check workflow logs: https://github.com/samsamanowitz/Wellness-Plan-Estimates/actions
- Verify token has Actions: write permission
- Ensure repository has GitHub Actions enabled

## Support

- **Repository**: https://github.com/samsamanowitz/Wellness-Plan-Estimates
- **Workflow logs**: https://github.com/samsamanowitz/Wellness-Plan-Estimates/actions
- **Data file**: https://samsamanowitz.github.io/Wellness-Plan-Estimates/wellness-plans-data/plans.json
