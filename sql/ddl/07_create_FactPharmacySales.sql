-- ============================================================
-- PharmacyDW — DDL Script 07: FactPharmacySales
-- Accumulating Snapshot Fact Table
-- ============================================================
USE PharmacyDW;
GO

CREATE TABLE FactPharmacySales (
    SalesKey              INT IDENTITY(1,1) PRIMARY KEY,

    -- Foreign Keys to Dimensions
    DateKey               INT REFERENCES DimDate(DateKey),
    BranchKey             INT REFERENCES DimBranch(BranchKey),
    MedicineKey           INT REFERENCES DimMedicine(MedicineKey),
    SupplierKey           INT REFERENCES DimSupplier(SupplierKey),
    CustomerKey           INT REFERENCES DimCustomer(CustomerKey),
    PaymentKey            INT REFERENCES DimPayment(PaymentKey),

    -- Degenerate Dimension
    TransactionID         INT,

    -- Additive Measures
    Quantity              INT,
    UnitPrice_LKR         DECIMAL(12,2),
    DiscountRate          DECIMAL(5,4),

    -- Derived Measure (calculated in SSIS: UnitPrice * Qty * DiscountRate)
    DiscountAmount_LKR    DECIMAL(12,2),

    -- Additive Revenue Measure
    LineTotal_LKR         DECIMAL(12,2),

    -- Additional Attributes
    PrescriptionRequired  BIT,

    -- Accumulating Snapshot Columns
    accm_txn_create_time    DATETIME,       -- Set at initial load via GETDATE()
    accm_txn_complete_time  DATETIME NULL,  -- Updated by Package 04
    txn_process_time_hours  DECIMAL(10,2) NULL  -- DATEDIFF(complete - create)
);
GO

-- Indexes for query performance
CREATE INDEX IX_Fact_DateKey     ON FactPharmacySales(DateKey);
CREATE INDEX IX_Fact_BranchKey   ON FactPharmacySales(BranchKey);
CREATE INDEX IX_Fact_MedicineKey ON FactPharmacySales(MedicineKey);
GO
