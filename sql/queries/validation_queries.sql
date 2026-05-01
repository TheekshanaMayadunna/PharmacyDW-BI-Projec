-- ============================================================
-- PharmacyDW — Validation Queries
-- Run after all 4 SSIS packages complete
-- ============================================================
USE PharmacyDW;
GO

-- ── 1. Row Count Checks ─────────────────────────────────────
SELECT 'DimDate'            AS TableName, COUNT(*) AS Rows FROM DimDate
UNION ALL
SELECT 'DimBranch',           COUNT(*) FROM DimBranch
UNION ALL
SELECT 'DimMedicine',          COUNT(*) FROM DimMedicine
UNION ALL
SELECT 'DimSupplier',          COUNT(*) FROM DimSupplier
UNION ALL
SELECT 'DimCustomer',          COUNT(*) FROM DimCustomer
UNION ALL
SELECT 'DimPayment',           COUNT(*) FROM DimPayment
UNION ALL
SELECT 'FactPharmacySales',    COUNT(*) FROM FactPharmacySales;
-- Expected: 546 | 7 | 148 | 8+ | 64 | 3 | 50000

-- ── 2. Sample Fact Join ──────────────────────────────────────
SELECT TOP 5
    f.TransactionID,
    d.FullDate,
    b.BranchName,
    b.Province,
    m.MedicineName,
    m.MedicineCategory,
    s.SupplierName,
    p.PaymentMethod,
    f.Quantity,
    f.LineTotal_LKR,
    f.accm_txn_create_time
FROM FactPharmacySales f
JOIN DimDate     d ON f.DateKey     = d.DateKey
JOIN DimBranch   b ON f.BranchKey   = b.BranchKey
JOIN DimMedicine m ON f.MedicineKey = m.MedicineKey
JOIN DimSupplier s ON f.SupplierKey = s.SupplierKey
JOIN DimPayment  p ON f.PaymentKey  = p.PaymentKey;

-- ── 3. Total Revenue by Province ────────────────────────────
SELECT
    b.Province,
    SUM(f.LineTotal_LKR)  AS TotalRevenue_LKR,
    SUM(f.Quantity)        AS TotalQuantity,
    COUNT(*)               AS Transactions
FROM FactPharmacySales f
JOIN DimBranch b ON f.BranchKey = b.BranchKey
GROUP BY b.Province
ORDER BY TotalRevenue_LKR DESC;

-- ── 4. Revenue by Medicine Category ─────────────────────────
SELECT
    m.MedicineCategory,
    SUM(f.LineTotal_LKR) AS TotalRevenue_LKR,
    COUNT(*)              AS Transactions
FROM FactPharmacySales f
JOIN DimMedicine m ON f.MedicineKey = m.MedicineKey
GROUP BY m.MedicineCategory
ORDER BY TotalRevenue_LKR DESC;

-- ── 5. Accumulating Fact Validation (after Package 04) ──────
SELECT
    COUNT(*)                         AS UpdatedRows,
    AVG(txn_process_time_hours)      AS AvgProcessHours,
    MIN(txn_process_time_hours)      AS MinHours,
    MAX(txn_process_time_hours)      AS MaxHours
FROM FactPharmacySales
WHERE accm_txn_complete_time IS NOT NULL;
-- Expected UpdatedRows: 50000

-- ── 6. SCD Type 2 — Supplier History Check ──────────────────
SELECT SupplierName, EffectiveDate, ExpiryDate, IsCurrent, City, ContactEmail
FROM DimSupplier
ORDER BY SupplierName, EffectiveDate;
