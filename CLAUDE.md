# Wellness Plan Estimator - Project Documentation

## Project Overview

Veterinary wellness plan estimate generator for creating monthly payment plans. Staff can:
- Create estimates for multiple pets across 4 plan types (Puppy, Canine Adult, Kitten, Feline Adult)
- Customize with optional services (spay/neuter, dental, microchip, etc.)
- Email estimates to clients with secure, self-contained viewer links

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

**Wellness_Estimate_Generator.html** (8600+ lines)
- **Purpose**: Staff-facing estimate generator
- **Location**: Hospital computers (manually distributed)
- **Key sections**:
  - Lines 1-1800: HTML structure, CSS styling, EmailJS integration
  - Lines 1809-1902: `plansData` object (pricing/services) - **MIGRATION TARGET**
  - Lines 1905-2200: Multi-pet state management
  - Lines 1923-1925: `getEnrollmentFee()` function - **NEEDS UPDATE**
  - Lines 2200+: Pet card rendering, calculation logic, email generation

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

## Data Structures

### plansData Object (line 1809)
```javascript
const plansData = {
    puppy: {
        name: "Puppy Plan 2026",
        displayName: "Puppy Plan 2026",
        species: "canine",  // or "feline"
        baseCost: 67.00,    // Monthly base price
        included: [
            { name: "Service Name", qty: "Unlimited" | "1" | "2" | "As Recommended" }
        ],
        optional: [
            {
                id: "puppy_spay",          // Unique identifier
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

### Enrollment Fees
- **First pet**: $50.00 (hardcoded at line 1923)
- **Additional pets**: $40.00 (hardcoded at line 1923)

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

## Current Pain Points (Reason for This Project)

**Problem**: Pricing is hardcoded in HTML
- Must edit code to change prices (risky)
- Must manually copy updated file to 5-6 hospital computers
- Must delete old version on each computer
- No audit trail for price changes
- Staff can't update prices themselves

**Solution**: Admin interface + GitHub-based data storage
- Staff updates pricing via web interface (no code editing)
- Changes automatically sync to all computers
- Full audit trail via Git commits
- Zero-cost hosting (GitHub Pages)

## New Architecture (This Implementation)

### Data Flow
```
Admin Interface (admin.html)
    ↓ GitHub API commit
GitHub Repository (wellness-plans-data)
    ↓ GitHub Pages serves
plans.json (https://your-org.github.io/wellness-plans-data/plans.json)
    ↓ fetch() on page load
Wellness_Estimate_Generator.html (all hospital computers)
    ↓ LZ-compressed URL
estimate-viewer.html (clients)
```

### New Repository: wellness-plans-data
```
wellness-plans-data/
├── plans.json          # Single source of truth for all pricing
├── admin.html          # Admin interface (GitHub PAT authenticated)
├── README.md           # Setup instructions
└── .gitignore
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

## Deployment Process

### One-Time Setup
1. Create GitHub repository `wellness-plans-data`
2. Enable GitHub Pages (Settings → Pages → Source: main branch, / root)
3. Create GitHub Personal Access Token (Settings → Developer settings → PAT → Generate with `repo` scope)
4. Upload files: plans.json, admin.html, README.md
5. Verify JSON accessible at: `https://YOUR-ORG.github.io/wellness-plans-data/plans.json`

### Generator Update (One-Time)
1. Update Wellness_Estimate_Generator.html with new fetch logic
2. Replace hardcoded `plansData` with dynamic loading
3. Manually copy to all hospital computers (last time!)
4. Test on one computer first, then roll out

### Ongoing Price Updates
1. Admin opens: `https://YOUR-ORG.github.io/wellness-plans-data/admin.html`
2. Enters GitHub PAT (stored in localStorage)
3. Edits pricing inline
4. Clicks Save → Creates Git commit
5. GitHub Pages updates (~30-60 seconds)
6. Hospital computers get new data on next page refresh

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

**Monthly Costs**: $0 (GitHub Pages free forever)

**Quarterly Tasks**:
- Rotate GitHub Personal Access Token (security best practice)
- Review Git commit history (audit trail)

**Annual Tasks**:
- Review admin access (GitHub collaborators)
- Update this documentation if architecture changes

## Contact & Support

- **GitHub Repository**: [Link to wellness-plans-data repo]
- **Technical Questions**: [Your contact info]
- **Staff Training Materials**: [Link to training docs]

## Version History

- **2026.1** (Feb 2026): Initial admin interface implementation
- **2025.4** (2025): Updated to 2026 pricing, removed Advanced plans
- **2025.3** (2025): Added Pre-Op Blood Panel badge
- **2025.2** (2025): Fixed mobile layout for included services

---

**Last Updated**: 2026-02-13
**Maintained By**: Samanowitz Technologies LLC
