-- ============================================================
-- PharmacyDW — DDL Script 05: DimCustomer
-- ============================================================
USE PharmacyDW;
GO

-- No CustomerID in source — segmented by Gender + AgeGroup + City
-- AgeGroup derived in SSIS: 0-18 | 19-35 | 36-55 | 56+
CREATE TABLE DimCustomer (
    CustomerKey  INT IDENTITY(1,1) PRIMARY KEY,
    Gender       NVARCHAR(10),
    AgeGroup     NVARCHAR(20),
    City         NVARCHAR(50)
);
GO
-- Customer Segment Hierarchy: AgeGroup -> Gender
-- Total unique segments: 64
