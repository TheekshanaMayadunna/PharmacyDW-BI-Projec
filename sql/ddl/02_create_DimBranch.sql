-- ============================================================
-- PharmacyDW — DDL Script 02: DimBranch
-- ============================================================
USE PharmacyDW;
GO

CREATE TABLE DimBranch (
    BranchKey    INT IDENTITY(1,1) PRIMARY KEY,
    BranchID     INT,
    BranchName   NVARCHAR(100),
    District     NVARCHAR(50),
    Province     NVARCHAR(50),
    Region       NVARCHAR(50),
    OpenDate     DATE
);
GO
-- Geography Hierarchy: Province -> District -> BranchName
