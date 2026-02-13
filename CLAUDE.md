# Wellness Plan Estimator - Project Documentation

## ⚡ Current Status (February 2026)

**✅ Full Service Management: OPERATIONAL**
- Staff can add/delete/edit services via admin portal (no code required)
- Service IDs migrated to Covetrus codes for system consistency
- All pricing and service changes sync automatically via GitHub
- **ONE FINAL manual distribution pending** for latest HTML structure changes (itemized pricing breakdown)
- **After that: All future PRICING and SERVICE updates sync automatically** ✨

**🔒 Security Enhancement: COMPLETED**
- ✅ GitHub Actions workflow implemented for secure commits
- ✅ Hardcoded tokens removed from all files
- ✅ Fine-grained PAT with minimal permissions (workflow trigger only)
- ✅ Token stored in localStorage (never in code)
- ✅ Professional enterprise-grade architecture
- ✅ Enhanced audit trail (workflow logs + Git commits)

**📋 Recent Changes:**
- February 13, 2026 (Late PM): ✅ **Security remediation** - Migrated to GitHub Actions workflow
- February 13, 2026 (PM): ✅ Added full service management (add/delete/edit services)
- February 13, 2026 (AM): Added itemized pricing breakdown (Base Plan + Add-Ons = Monthly Payment)
- Action required: Distribute updated Wellness_Estimate_Generator.html to all hospital computers ONE LAST TIME

---

## Project Overview

Veterinary wellness plan estimate generator for creating monthly payment plans. Staff can:
- Create estimates for multiple pets across 4 plan types (Puppy, Canine Adult, Kitten, Feline Adult)
- Customize with optional services (spay/neuter, dental, microchip, etc.)
- Email estimates to clients with secure, self-contained viewer links
- **Update pricing via admin portal** (no manual file distribution needed)

## Current Architecture

**Technology Stack**:
- **Client-side HTML app** - Single-file generator with embedded CSS/JS
- **No frameworks** - Vanilla JavaScript for maximum portability
- **EmailJS integration** - Sends estimates via email without backend server
- **LZ-String compression** - Embeds all estimate data in URL parameters for viewer
- **GitHub Pages** - Hosts estimate-viewer.html for client access

**Key Design Decisions**:
1. **Self-contained estimates**: Viewer receives ALL data via compressed URL parameters (backwards compatible forever)
2. **No database**: Data embedded in URLs means estimates never expire or break
3. **Offline-capable**: Generator works without internet after initial load
4. **Multi-pet support**: Up to 5 pets per estimate with individual plan selection
5. **Hospital deployment**: HTML file manually copied to 5-6 hospital computers

## File Structure

### Main Project Files

**Wellness_Estimate_Generator.html** (2600+ lines)
- **Purpose**: Staff-facing estimate generator
- **Location**: Hospital computers (manually distributed)
- **Key sections**:
  - Lines 1-1800: HTML structure, CSS styling, EmailJS integration
  - Line 1826: `PLANS_DATA_URL` - GitHub Pages endpoint ✅
  - Lines 1828-1904: `loadPlansData()` function - Fetches from GitHub ✅
  - Lines 1874-1980: Hardcoded fallback data (safety net)
  - Lines 1987-1994: DOMContentLoaded - Calls `loadPlansData()` ✅
  - Lines 1996-1998: `getEnrollmentFee()` function - Uses dynamic `enrollmentFees` ✅
  - Lines 2000-2018: `calculatePetBreakdown()` helper - NEW (itemized pricing)
  - Lines 2020-2035: `calculatePetTotal()` - Main calculation logic
  - Lines 2067+: Pet card rendering, calculation logic, email generation

**estimate-viewer.html**
- **Purpose**: Client-facing estimate display (read-only)
- **Hosted on**: GitHub Pages at `https://your-org.github.io/wellness-estimates/estimate-viewer.html`
- **Data source**: LZ-compressed URL parameters (fully self-contained)
- **Key features**:
  - Lines 730-741: LZ-String decompression of URL params
  - Responsive design for mobile viewing
  - No external dependencies on pricing data

**Wellness_Estimate_Generator_BACKUP.html**
- Safety backup of previous version
- Keep for rollback if needed

**email-button-preview.html**
- Testing file for email templates
- Not used in production

## ✅ Admin Portal Capabilities (FULLY IMPLEMENTED)

### What Staff Can Do (No Developer Needed)

**Pricing Management:**
- ✅ Update base plan costs (monthly pricing)
- ✅ Update enrollment fees (first pet, additional pets)
- ✅ Edit optional service costs
- ✅ All pricing changes sync automatically to all hospital computers

**Service Management:** ✨ NEW
- ✅ Add new optional services (with Covetrus code, name, cost, qty, note)
- ✅ Add new included services (with Covetrus code, name, qty)
- ✅ Edit existing services (name, cost, quantity, notes)
- ✅ Delete services (with confirmation)
- ✅ Validation prevents duplicate codes and invalid data
- ✅ Service codes match Covetrus practice management system

**How to Access:**
1. Open: `wellness-plans-data/admin.html`
2. Log in with password
3. *(First-time only)* Admin configures workflow token (see `ADMIN_SETUP.md`)
4. Make changes via web interface
5. Click Save → GitHub Actions workflow processes changes
6. Changes sync to all hospital computers within 60 seconds

**Audit Trail:**
- All changes tracked in GitHub commit history AND workflow logs
- Git commits: https://github.com/samsamanowitz/Wellness-Plan-Estimates/commits/main/wellness-plans-data/plans.json
- Workflow runs: https://github.com/samsamanowitz/Wellness-Plan-Estimates/actions

---

## Data Structures

### ✅ plansData Object (Dynamically Loaded from GitHub)
**Source**: `https://samsamanowitz.github.io/Wellness-Plan-Estimates/wellness-plans-data/plans.json`

```javascript
// Loaded dynamically at runtime (line 1828-1850)
let plansData = {}; // Populated from GitHub Pages
let enrollmentFees = { first: 50.00, additional: 40.00 }; // Populated from GitHub Pages

// Structure:
plansData = {
    puppy: {
        name: "Puppy Plan 2026",
        displayName: "Puppy Plan 2026",
        species: "canine",  // or "feline"
        baseCost: 67.00,    // Monthly base price
        included: [
            {
                id: "WPOF",              // ✨ NEW: Covetrus service code
                name: "Unlimited Office Visits...",
                qty: "Unlimited" | "1" | "2" | "As Recommended"
            }
        ],
        optional: [
            {
                id: "WPSPAYK9",            // ✨ UPDATED: Now uses Covetrus codes
                name: "Spay Surgery",       // Display name
                cost: 54.00,                // Monthly cost
                qty: 1,                     // Quantity
                includesNote: "Includes..." // Optional note
            }
        ]
    },
    canineAdult: { /* same structure */ },
    kitten: { /* same structure */ },
    felineAdult: { /* same structure */ }
};
```

**Key Changes in Version 2026.2:**
- ✅ All services now have unique IDs (included services previously lacked IDs)
- ✅ Service IDs are Covetrus codes (WPSPAYK9, K222, RADS3, etc.) for system consistency
- ✅ Backwards compatible: Old estimates with old service IDs still work

### ✅ Enrollment Fees (Dynamically Loaded)
- **First pet**: Loaded from `plans.json` → `settings.enrollmentFeeFirst` (currently $50.00)
- **Additional pets**: Loaded from `plans.json` → `settings.enrollmentFeeAdditional` (currently $40.00)
- **Fallback**: Hardcoded values used if GitHub/cache unavailable

### Pet State Object
```javascript
{
    id: 1,                          // Unique pet ID
    name: 'Fluffy',                 // Pet name
    planKey: 'puppy',               // Key to plansData object
    selectedOptionals: {            // Selected optional services
        'puppy_spay': {
            name: "Spay Surgery",
            cost: 54.00,
            qty: 1
        }
    },
    isExpanded: true                // UI state
}
```

## ✅ Implemented Solution (COMPLETED)

**Previous Problem**: Pricing was hardcoded in HTML
- Required editing code to change prices (risky)
- Required manual copying updated file to 5-6 hospital computers
- No audit trail for price changes
- Staff couldn't update prices themselves

**Current Solution**: ✅ **FULLY IMPLEMENTED**
- ✅ Admin interface deployed at: `wellness-plans-data/admin.html`
- ✅ Pricing data stored in GitHub repository: `wellness-plans-data/plans.json`
- ✅ Generator fetches data from: `https://samsamanowitz.github.io/Wellness-Plan-Estimates/wellness-plans-data/plans.json`
- ✅ Staff can update pricing via web interface (no code editing required)
- ✅ Changes automatically sync to all hospital computers
- ✅ Full audit trail via Git commits
- ✅ Zero-cost hosting (GitHub Pages)

**Important**: HTML structure changes (like adding new features) still require manual distribution, but **pricing updates now sync automatically**.

## ✅ Current Architecture (IMPLEMENTED)

### Data Flow (Live System - Secure Architecture)
```
Admin Interface (admin.html) - Browser
    ↓ Triggers repository_dispatch event (workflow trigger token - localStorage only)
GitHub Actions Workflow (.github/workflows/update-pricing.yml)
    ↓ Validates payload & commits using built-in GITHUB_TOKEN (encrypted secret)
GitHub Repository (Wellness-Plan-Estimates/wellness-plans-data)
    ↓ GitHub Pages auto-deploys (30-60 seconds)
plans.json (https://samsamanowitz.github.io/Wellness-Plan-Estimates/wellness-plans-data/plans.json)
    ↓ fetch() on page load (with localStorage cache fallback)
Wellness_Estimate_Generator.html (all hospital computers)
    ↓ LZ-compressed URL
estimate-viewer.html (https://university-animal-clinic.github.io/uacvet.github.io/estimate-viewer.html)
```

**Security Benefits:**
- ✅ Token stored in localStorage (never in code)
- ✅ Fine-grained PAT with minimal permissions (workflow trigger only)
- ✅ Workflow validates data before commit
- ✅ Professional enterprise-grade architecture
- ✅ Zero infrastructure costs

### Repository Structure (ACTIVE)
```
Wellness-Plan-Estimates/
├── .github/
│   └── workflows/
│       └── update-pricing.yml    # GitHub Actions workflow (secure commits)
├── wellness-plans-data/
│   ├── plans.json                # Single source of truth for all pricing
│   ├── admin.html                # Admin interface (workflow-authenticated)
│   └── README.md                 # Setup instructions
├── .gitignore                    # Prevent token commits
├── ADMIN_SETUP.md                # Administrator setup guide
└── CLAUDE.md                     # This file
```

### plans.json Schema
```json
{
  "plans": {
    "puppy": { /* same as plansData.puppy */ },
    "canineAdult": { /* ... */ },
    "kitten": { /* ... */ },
    "felineAdult": { /* ... */ }
  },
  "settings": {
    "enrollmentFeeFirst": 50.00,
    "enrollmentFeeAdditional": 40.00
  },
  "metadata": {
    "lastUpdated": "2026-02-13T10:30:00Z",
    "version": "2026.1"
  }
}
```

### Generator Changes (Wellness_Estimate_Generator.html)

**Replace line 1809** (`const plansData = { ... }`):
```javascript
let plansData = {}; // Populated from GitHub Pages
let enrollmentFees = { first: 50.00, additional: 40.00 }; // Defaults

async function loadPlansData() {
    try {
        const response = await fetch('https://YOUR-ORG.github.io/wellness-plans-data/plans.json');
        const data = await response.json();

        plansData = data.plans;
        enrollmentFees.first = data.settings.enrollmentFeeFirst;
        enrollmentFees.additional = data.settings.enrollmentFeeAdditional;

        // Cache for offline fallback
        localStorage.setItem('plansDataCache', JSON.stringify(data));
        localStorage.setItem('plansCacheTime', Date.now());

        console.log('Plans loaded from GitHub Pages');
    } catch (error) {
        console.warn('Failed to load from GitHub Pages, using cache:', error);

        const cached = localStorage.getItem('plansDataCache');
        if (cached) {
            const data = JSON.parse(cached);
            plansData = data.plans;
            enrollmentFees.first = data.settings.enrollmentFeeFirst;
            enrollmentFees.additional = data.settings.enrollmentFeeAdditional;
        } else {
            // Ultimate fallback: keep hardcoded data inline here
            plansData = { /* original plansData object */ };
        }
    }
}
```

**Update line 1918** (DOMContentLoaded):
```javascript
document.addEventListener('DOMContentLoaded', async function() {
    await loadPlansData();  // Load data first
    renderAllPetCards();
    updateGrandTotal();
});
```

**Update line 1923** (`getEnrollmentFee`):
```javascript
function getEnrollmentFee(index) {
    return index === 0 ? enrollmentFees.first : enrollmentFees.additional;
}
```

## ✅ Deployment Status

### ✅ One-Time Setup (COMPLETED)
1. ✅ GitHub repository created: `Wellness-Plan-Estimates/wellness-plans-data`
2. ✅ GitHub Pages enabled and serving at: `https://samsamanowitz.github.io/Wellness-Plan-Estimates/wellness-plans-data/plans.json`
3. ✅ GitHub Personal Access Token configured
4. ✅ Files deployed: plans.json, admin.html, README.md, SETUP.sh
5. ✅ JSON verified accessible (HTTP 200 OK)

### ✅ Generator Update (COMPLETED)
1. ✅ Wellness_Estimate_Generator.html updated with GitHub fetch logic
2. ✅ `loadPlansData()` function implemented (line 1828)
3. ✅ localStorage cache fallback added for offline capability
4. ✅ Hardcoded fallback data retained as ultimate safety net
5. ⏳ **PENDING: Manual distribution to hospital computers with latest changes**

### 🔄 Ongoing Price Updates (ACTIVE)
**How Staff Updates Pricing:**
1. Open admin interface: `wellness-plans-data/admin.html`
2. Enter GitHub PAT (stored in localStorage)
3. Edit pricing inline in web interface
4. Click Save → Creates Git commit automatically
5. GitHub Pages updates within 30-60 seconds
6. **All hospital computers get new data on next page refresh** ✅
7. **No manual file distribution needed** ✅

## Important Constraints

### Backwards Compatibility
- **Critical**: Existing emailed estimate links MUST continue working forever
- **Why**: Estimate data is self-contained in LZ-compressed URL parameters
- **Result**: estimate-viewer.html requires NO changes
- **Guarantee**: Old estimates will work even if we change pricing structure

### Browser Compatibility
- Must work on hospital computers (potentially older browsers)
- No ES6+ features without fallbacks
- Keep JavaScript simple and widely compatible

### Offline Capability
- Generator should work if GitHub Pages is temporarily down
- Three-level fallback: API → localStorage cache → hardcoded data
- Staff should never be blocked from creating estimates

### Security
- Admin interface requires GitHub PAT authentication
- Plans.json can be public (pricing is not secret)
- No passwords or sensitive data in repository

## Testing Checklist

### Before Deployment
- [ ] plans.json validates (use JSONLint)
- [ ] GitHub Pages serves plans.json (curl test)
- [ ] Admin interface loads plans from GitHub
- [ ] Admin interface can commit changes
- [ ] Generator loads from GitHub Pages (online mode)
- [ ] Generator uses cache (offline mode)
- [ ] Generator uses fallback (no cache, offline)
- [ ] Calculations match current hardcoded values

### After Deployment
- [ ] Old estimate links still work
- [ ] New estimates have correct pricing
- [ ] Email delivery works
- [ ] Multi-pet estimates calculate correctly
- [ ] All 4 plan types work
- [ ] Optional services calculate correctly

### Stress Testing
- [ ] Create 5-pet estimate with all optional services
- [ ] Update pricing, verify all computers sync
- [ ] Test with network disabled (cache mode)
- [ ] Test with cache cleared + network disabled (fallback mode)

## Cost & Maintenance

**Monthly Costs**: $0 (GitHub Pages + GitHub Actions free forever)

**Annual Tasks**:
- **Rotate workflow trigger token** (fine-grained PAT expires annually)
- Review admin access (GitHub collaborators)
- Review workflow logs for anomalies
- Update this documentation if architecture changes

**Quarterly Tasks**:
- Review Git commit history (audit trail)
- Check GitHub Actions workflow runs for errors

## Contact & Support

- **GitHub Repository**: https://github.com/samsamanowitz/Wellness-Plan-Estimates
- **Data Repository**: `wellness-plans-data/` folder
- **Admin Interface**: `wellness-plans-data/admin.html`
- **Plans Data**: https://samsamanowitz.github.io/Wellness-Plan-Estimates/wellness-plans-data/plans.json
- **Estimate Viewer**: https://university-animal-clinic.github.io/uacvet.github.io/estimate-viewer.html

## Version History

- **2026.2-SECURE** (Feb 13, 2026 Late PM): ✅ **Security Enhancement - GitHub Actions Workflow**
  - **Critical**: Removed hardcoded tokens from all files (security remediation)
  - Migrated to GitHub Actions workflow architecture for secure commits
  - Fine-grained PAT with minimal permissions (workflow trigger only)
  - Token stored in localStorage (never in code)
  - Professional enterprise-grade architecture
  - Enhanced audit trail (workflow logs + Git commits)
  - Zero infrastructure costs (GitHub Actions free tier)
  - Created `.github/workflows/update-pricing.yml`
  - Created `.gitignore` to prevent future token commits
  - Created `ADMIN_SETUP.md` for administrator guidance
  - Updated `wellness-plans-data/README.md` with security documentation
- **2026.2** (Feb 13, 2026 PM): ✅ **Added full service management to admin portal**
  - Staff can add/delete/edit services without developer help
  - Service IDs migrated to Covetrus codes (WPSPAYK9, K222, RADS3, etc.)
  - Added service code validation and duplicate prevention
  - Enhanced admin UI with service management buttons
  - All services now have unique IDs (included services previously lacked IDs)
- **2026.2** (Feb 13, 2026 AM): ✅ Added itemized pricing breakdown (Base Plan + Add-Ons = Monthly Payment)
- **2026.1** (Feb 2026): ✅ Completed GitHub integration - pricing now updates automatically via admin portal
- **2025.4** (2025): Updated to 2026 pricing, removed Advanced plans
- **2025.3** (2025): Added Pre-Op Blood Panel badge
- **2025.2** (2025): Fixed mobile layout for included services

---

**Last Updated**: 2026-02-13 (PM)
**Maintained By**: Samanowitz Technologies LLC
**Current Version**: 2026.2
