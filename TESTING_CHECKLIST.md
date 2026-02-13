# Service Management Implementation - Testing Checklist

## ✅ Implementation Complete

**Date**: February 13, 2026
**Version**: 2026.2
**Commit**: f9c35fd

---

## What Changed

### 1. Schema Migration (plans.json)
- ✅ All optional services now use Covetrus codes (WPSPAYK9, K222, RADS3, etc.)
- ✅ All included services now have IDs (WPOF, B025, T805, etc.)
- ✅ Backwards compatible with existing estimates
- ✅ Version bumped to 2026.2

### 2. Admin Interface (admin.html)
- ✅ Add optional services button
- ✅ Add included services button
- ✅ Edit included services (name, qty)
- ✅ Edit optional services (name, cost, qty, note)
- ✅ Delete services with confirmation
- ✅ Service code validation
- ✅ Enhanced UI with service codes displayed

---

## Testing Checklist

### Pre-Testing Setup
- [ ] Clear browser cache
- [ ] Open admin portal: `wellness-plans-data/admin.html`
- [ ] Log in with password
- [ ] Verify plans load successfully

---

## Phase 1: Schema Validation

### Test 1.1: Verify Schema Migration
- [ ] Open browser console (F12)
- [ ] Navigate to Network tab
- [ ] Reload page and verify `plans.json` loads
- [ ] Check console for "✓ Plans loaded from GitHub Pages successfully"
- [ ] Verify no JavaScript errors

**Expected**: All plans load with Covetrus codes visible

### Test 1.2: Backwards Compatibility
- [ ] Open an existing estimate URL (created before migration)
- [ ] Verify estimate displays correctly
- [ ] Check that all services and prices match

**Expected**: Old estimates work perfectly

---

## Phase 2: Add Services

### Test 2.1: Add Optional Service
1. [ ] Click "+ Add Optional" on Puppy Plan
2. [ ] Enter:
   - Service Code: `TEST1`
   - Service Name: `Test Optional Service`
   - Monthly Cost: `10.00`
   - Quantity: `1`
   - Includes Note: `Test note`
3. [ ] Click "Add Service"
4. [ ] Verify:
   - [ ] Success toast appears
   - [ ] Service appears in list with code "TEST1"
   - [ ] GitHub commit created
   - [ ] Check GitHub commit message includes service details

**Expected**: Service added successfully with all details

### Test 2.2: Add Included Service
1. [ ] Click "+ Add Included" on Canine Adult Plan
2. [ ] Enter:
   - Service Code: `TEST2`
   - Service Name: `Test Included Service`
   - Quantity: `2`
3. [ ] Verify cost and note fields are hidden
4. [ ] Click "Add Service"
5. [ ] Verify:
   - [ ] Success toast appears
   - [ ] Service appears in included section
   - [ ] GitHub commit created

**Expected**: Included service added without cost/note fields

### Test 2.3: Duplicate Code Prevention
1. [ ] Try adding service with code `WPSPAYK9` (existing)
2. [ ] Verify error: "Service code WPSPAYK9 already exists in this plan"
3. [ ] Modal should remain open with focus on code field

**Expected**: Duplicate codes rejected

### Test 2.4: Invalid Code Format
1. [ ] Try code with special characters: `TEST@123`
2. [ ] Verify error about valid characters
3. [ ] Try lowercase code: `test123`
4. [ ] Verify it's auto-converted to: `TEST123`

**Expected**: Format validation works

---

## Phase 3: Edit Services

### Test 3.1: Edit Optional Service
1. [ ] Click "Edit" on existing optional service (e.g., Spay Surgery)
2. [ ] Verify:
   - [ ] Service code field is read-only
   - [ ] All fields populated correctly
   - [ ] Cost and note fields visible
3. [ ] Change cost from $54.00 to $55.00
4. [ ] Click "Save Changes"
5. [ ] Verify:
   - [ ] Success toast
   - [ ] New cost displayed
   - [ ] GitHub commit shows old → new price

**Expected**: Cost updated, code unchanged

### Test 3.2: Edit Included Service
1. [ ] Click "Edit" on included service
2. [ ] Verify:
   - [ ] Cost and note fields hidden
   - [ ] Service code read-only
3. [ ] Change quantity or name
4. [ ] Save and verify changes

**Expected**: Included service updated without cost

---

## Phase 4: Delete Services

### Test 4.1: Delete Optional Service
1. [ ] Click "Delete" on TEST1 service (from Test 2.1)
2. [ ] Verify confirmation modal shows:
   - Service name
   - Service code
   - Plan name
   - Warning about GitHub commit
3. [ ] Click "Delete Service"
4. [ ] Verify:
   - [ ] Service removed from list
   - [ ] GitHub commit created
   - [ ] Success toast

**Expected**: Service deleted permanently

### Test 4.2: Delete Included Service
1. [ ] Click "Delete" on TEST2 service (from Test 2.2)
2. [ ] Confirm deletion
3. [ ] Verify removed

**Expected**: Included service deleted

### Test 4.3: Cancel Deletion
1. [ ] Click "Delete" on any service
2. [ ] Click "Cancel" in confirmation modal
3. [ ] Verify:
   - [ ] Modal closes
   - [ ] Service still exists
   - [ ] No GitHub commit

**Expected**: Deletion cancelled safely

---

## Phase 5: Generator Integration

### Test 5.1: Generator Loads New Data
1. [ ] Open `Wellness_Estimate_Generator.html` in browser
2. [ ] Open browser console (F12)
3. [ ] Verify console shows: "✓ Plans loaded from GitHub Pages successfully"
4. [ ] Create pet card for Puppy Plan
5. [ ] Check optional services dropdown
6. [ ] Verify:
   - [ ] TEST1 service appears (if not deleted)
   - [ ] All new services visible
   - [ ] Deleted services NOT visible

**Expected**: Generator automatically picks up changes

### Test 5.2: Create Estimate with New Service
1. [ ] Select a newly added service
2. [ ] Complete estimate
3. [ ] Email estimate
4. [ ] Open estimate viewer URL
5. [ ] Verify:
   - [ ] Service displays correctly
   - [ ] Price calculates correctly
   - [ ] Email renders properly

**Expected**: New services work end-to-end

---

## Phase 6: Edge Cases

### Test 6.1: Empty Fields
- [ ] Try saving with empty service code → Error
- [ ] Try saving with empty name → Error
- [ ] Try saving with empty quantity → Error

**Expected**: Required fields enforced

### Test 6.2: Invalid Cost
- [ ] Enter negative cost: `-10`
- [ ] Verify error: "Please enter a valid cost (minimum $0.00)"

**Expected**: Cost validation works

### Test 6.3: Long Service Name
- [ ] Enter 250-character service name
- [ ] Verify error about 200-character limit

**Expected**: Length validation works

### Test 6.4: Special Service Codes
- [ ] Test hyphenated code: `99-0011516` (existing)
- [ ] Verify it works correctly
- [ ] Test numeric code: `K222` (existing)
- [ ] Verify it works

**Expected**: Various code formats accepted

### Test 6.5: Cancel Operations
- [ ] Open add modal, fill fields, click Cancel
- [ ] Verify no changes saved
- [ ] Open edit modal, change data, click Cancel
- [ ] Verify original data unchanged

**Expected**: Cancel works safely

---

## Phase 7: Multi-Plan Testing

### Test 7.1: Cross-Plan Service Codes
1. [ ] Add service to Puppy Plan with code `TESTK9`
2. [ ] Add service to Kitten Plan with code `TESTFEL`
3. [ ] Verify codes work (no conflict)
4. [ ] Add service to Puppy Plan with code `TESTK9` again
5. [ ] Verify duplicate error (plan-specific)

**Expected**: Codes are plan-specific, not global

---

## Phase 8: Offline Mode

### Test 8.1: Cache Fallback
1. [ ] Open generator once (loads from GitHub)
2. [ ] Disable network in DevTools
3. [ ] Reload generator
4. [ ] Check console: "✓ Using cached plans data from: [date]"
5. [ ] Verify all services still work

**Expected**: Cache fallback works

### Test 8.2: Hardcoded Fallback
1. [ ] Clear localStorage
2. [ ] Disable network
3. [ ] Reload generator
4. [ ] Check console: "⚠️ Using hardcoded fallback data"
5. [ ] Verify basic services available

**Expected**: Hardcoded fallback works (safety net)

---

## Phase 9: Audit Trail

### Test 9.1: Commit Messages
1. [ ] Go to GitHub: https://github.com/samsamanowitz/Wellness-Plan-Estimates/commits/main/wellness-plans-data/plans.json
2. [ ] Verify commit messages are descriptive:
   - [ ] "Add optional service to Puppy Plan 2026: [name] ([code]) - $X.XX/mo"
   - [ ] "Delete optional service from [plan]: [name] ([code])"
   - [ ] "Update [plan] - [name] ([code]) from $X.XX to $Y.YY"

**Expected**: Clear audit trail

---

## Phase 10: Stress Testing

### Test 10.1: Multiple Services
1. [ ] Add 5 new optional services to one plan
2. [ ] Verify all appear correctly
3. [ ] Edit multiple services
4. [ ] Delete all test services
5. [ ] Verify clean state

**Expected**: Handles multiple operations

### Test 10.2: Rapid Changes
1. [ ] Add service → immediately edit → immediately delete
2. [ ] Verify each operation completes
3. [ ] Check GitHub commits are sequential

**Expected**: No race conditions

---

## Known Limitations

1. **Service code changes**: When editing, service code is read-only (by design - prevents breaking estimates)
2. **Plan-wide changes**: No bulk operations (must edit services one at a time)
3. **Undo**: No built-in undo (must use Git revert for rollbacks)

---

## Rollback Plan

If critical issues found:

```bash
cd "wellness-plans-data"
git log --oneline | head -10  # Find commit before f9c35fd
git revert f9c35fd
git push
```

Then refresh admin portal and generator.

---

## Success Criteria

- ✅ Staff can add services without developer help
- ✅ Staff can delete services without developer help
- ✅ Service codes match Covetrus system
- ✅ Backwards compatibility maintained
- ✅ Generator auto-updates
- ✅ Clear audit trail
- ✅ Safe validation prevents errors

---

## Contact

**Issues**: https://github.com/samsamanowitz/Wellness-Plan-Estimates/issues
**Documentation**: `CLAUDE.md`
**Version**: 2026.2
