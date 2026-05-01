-- ============================================================
-- PharmacyDW — DDL Script 04: DimSupplier (SCD Type 2)
-- ============================================================
USE PharmacyDW;
GO

CREATE TABLE DimSupplier (
    SupplierKey      INT IDENTITY(1,1) PRIMARY KEY,
    SupplierName     NVARCHAR(100),   -- Natural Key
    ContactEmail     NVARCHAR(100),   -- SCD Type 2 — tracked historically
    City             NVARCHAR(50),    -- SCD Type 2 — tracked historically
    EstablishedYear  INT,             -- SCD Type 1 — overwrite
    IsActive         BIT,             -- SCD Type 1 — overwrite
    EffectiveDate    DATE,
    ExpiryDate       DATE,
    IsCurrent        BIT DEFAULT 1
);
GO
-- SCD Type 2: When ContactEmail or City changes:
--   Old row → IsCurrent=0, ExpiryDate=today
--   New row → IsCurrent=1, EffectiveDate=today, ExpiryDate=9999-12-31
