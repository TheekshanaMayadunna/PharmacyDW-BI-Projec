-- ============================================================
-- PharmacyDW — DDL Script 03: DimMedicine
-- ============================================================
USE PharmacyDW;
GO

CREATE TABLE DimMedicine (
    MedicineKey       INT IDENTITY(1,1) PRIMARY KEY,
    MedicineID        INT,
    MedicineName      NVARCHAR(150),
    GenericName       NVARCHAR(100),
    MedicineCategory  NVARCHAR(50),
    DosageForm        NVARCHAR(50),
    StrengthMg        DECIMAL(8,2),
    PackSize          INT,
    TherapeuticGroup  NVARCHAR(100)
);
GO
-- Product Hierarchy: MedicineCategory -> MedicineName
