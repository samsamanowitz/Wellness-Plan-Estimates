# Wellness Plans Data Repository

This repository contains the centralized pricing and service data for the veterinary wellness plan estimate generator. All hospital computers automatically fetch the latest pricing from this repository via GitHub Pages.

## 🎯 Purpose

- **Single source of truth** for all wellness plan pricing
- **Automatic synchronization** to all hospital computers
- **Admin interface** for non-technical staff to update pricing
- **Built-in audit trail** via Git commit history

## 📁 Repository Structure

```
wellness-plans-data/
├── plans.json          # All pricing and service data
├── admin.html          # Admin interface for editing pricing
├── README.md           # This file
└── .gitignore          # Git ignore file
```

## 🚀 Initial Setup

### 1. Enable GitHub Pages

1. Go to repository **Settings** → **Pages**
2. Set **Source** to: `main` branch, `/ (root)` folder
3. Click **Save**
4. Wait 1-2 minutes for deployment
5. Verify your site is published at: `https://YOUR-USERNAME.github.io/wellness-plans-data/`

### 2. Create GitHub Personal Access Token

1. Go to GitHub → **Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)**
2. Click **Generate new token (classic)**
3. Set token name: `Wellness Plans Admin`
4. Set expiration: `90 days` (recommended for security)
5. Select scope: **✅ repo** (full control of private repositories)
6. Click **Generate token**
7. **IMPORTANT**: Copy the token immediately (it's only shown once!)
8. Store securely (password manager recommended)

### 3. Configure Admin Interface

1. Open `admin.html` in a text editor
2. Find these lines near the top of the `<script>` section:
   ```javascript
   const GITHUB_OWNER = 'YOUR-GITHUB-USERNAME';  // Replace with your GitHub username or org
   const GITHUB_REPO = 'wellness-plans-data';    // Repository name
   ```
3. Replace `YOUR-GITHUB-USERNAME` with your actual GitHub username or organization name
4. Save the file
5. Commit and push the change:
   ```bash
   git add admin.html
   git commit -m "Configure GitHub owner for admin interface"
   git push
   ```

### 4. Test the Setup

1. Verify plans.json is accessible:
   ```bash
   curl https://YOUR-USERNAME.github.io/wellness-plans-data/plans.json
   ```
   You should see the JSON data.

2. Open admin interface:
   ```
   https://YOUR-USERNAME.github.io/wellness-plans-data/admin.html
   ```

3. Paste your GitHub Personal Access Token when prompted

4. Verify you can see all plans and settings loaded

5. Make a test change (e.g., update a price by $0.01)

6. Click Save and verify:
   - Success message appears
   - New commit appears in repository
   - plans.json updates within 30-60 seconds

## 👨‍💼 Using the Admin Interface

### Accessing the Admin Interface

Open in your browser:
```
https://YOUR-USERNAME.github.io/wellness-plans-data/admin.html
```

### First-Time Login

1. Enter your GitHub Personal Access Token
2. Click **Login**
3. Token is saved in browser's localStorage for convenience
4. You'll see all plans and settings loaded

### Updating Prices

#### Global Enrollment Fees
1. Navigate to **Global Settings** section
2. Change the value in the input field
3. Click **Save** next to the field
4. Changes commit immediately to GitHub

#### Plan Base Costs
1. Find the plan you want to update (e.g., "Puppy Plan 2026")
2. Change the **Monthly Base Cost** value
3. Click **Save**
4. Changes commit immediately to GitHub

#### Optional Services
1. Find the service under the plan's **Optional Services** section
2. Click **Edit** button
3. Update any fields:
   - Service Name
   - Monthly Cost
   - Quantity
   - Includes Note (optional)
4. Click **Save** in the modal
5. Changes commit immediately to GitHub

### Audit Trail

Click **View Audit Log** in the top-right corner to see:
- All pricing changes
- Who made each change (GitHub user)
- When changes were made
- What was changed (commit message)

### Security

- **Token Expiration**: Rotate your token every 90 days
- **Logout**: Click **Logout** to remove token from browser
- **Revoke Token**: Go to GitHub Settings → Personal access tokens → Revoke if compromised

## 🏥 Hospital Computer Setup

### One-Time Update Required

After setting up this repository, update the generator on all hospital computers:

1. Open `Wellness_Estimate_Generator.html` in a text editor
2. Find line 1809: `const plansData = {`
3. Replace with the new dynamic loading code (see implementation guide)
4. Update line 1918 to load data on page load
5. Update line 1923 to use dynamic enrollment fees
6. Save the file
7. Distribute to all hospital computers (last time!)

### How It Works

Once updated, the generator will:
1. Load plans.json from GitHub Pages on page load
2. Cache data in localStorage for offline use
3. Fall back to hardcoded data if offline and no cache
4. Automatically get new pricing when staff refresh the page

### Verification

Open browser console (F12) and look for:
```
Plans loaded from GitHub Pages
```

If you see this, the generator is successfully fetching from GitHub!

## 📊 Data Structure

### plans.json Schema

```json
{
  "plans": {
    "puppy": {
      "name": "Puppy Plan 2026",
      "displayName": "Puppy Plan 2026",
      "species": "canine",
      "baseCost": 67.00,
      "included": [
        { "name": "Service Name", "qty": "Unlimited" }
      ],
      "optional": [
        {
          "id": "puppy_spay",
          "name": "Spay Surgery",
          "cost": 54.00,
          "qty": 1,
          "includesNote": "Includes Pre-Op Blood Panel"
        }
      ]
    }
  },
  "settings": {
    "enrollmentFeeFirst": 50.00,
    "enrollmentFeeAdditional": 40.00
  },
  "metadata": {
    "lastUpdated": "2026-02-13T10:00:00Z",
    "version": "2026.1"
  }
}
```

## 🔧 Troubleshooting

### Admin interface won't load plans
- **Check**: Is GitHub Pages enabled in repository settings?
- **Check**: Is plans.json accessible at the GitHub Pages URL?
- **Check**: Is your token valid and has `repo` scope?
- **Fix**: Regenerate token if expired or invalid

### Changes not appearing on hospital computers
- **Check**: Has GitHub Pages updated? (30-60 second delay after commit)
- **Check**: Has staff refreshed the generator page?
- **Check**: Open browser console - any errors?
- **Fix**: Clear browser cache and refresh

### "Failed to save" error in admin interface
- **Check**: Is your token still valid? (check expiration)
- **Check**: Do you have write access to the repository?
- **Check**: Is plans.json a valid JSON file?
- **Fix**: Check browser console for detailed error message

### Old pricing still showing
- **Check**: Clear localStorage: Open browser console, type `localStorage.clear()`, refresh
- **Check**: Verify plans.json has updated on GitHub Pages
- **Check**: Check last commit time in repository

## 🔒 Security Best Practices

1. **Token Management**:
   - Never share your Personal Access Token
   - Rotate tokens every 90 days
   - Use separate tokens for different purposes
   - Revoke tokens immediately if compromised

2. **Repository Access**:
   - Limit admin access to authorized staff only
   - Use GitHub's collaboration features to track who has access
   - Consider making repository private if needed

3. **Backup**:
   - Git history serves as automatic backup
   - Can revert to any previous version via Git
   - Download backups periodically: `git clone` to local machine

## 📞 Support

For technical support or questions:
- **Email**: [your-email@example.com]
- **Phone**: [your-phone-number]
- **GitHub Issues**: [Link to issues page]

## 📝 Change Log

### Version 2026.1 (February 2026)
- Initial admin interface implementation
- Migrated from hardcoded pricing to GitHub-based system
- Added automatic synchronization to all hospital computers

---

**Last Updated**: February 13, 2026
**Maintained By**: Samanowitz Technologies LLC
