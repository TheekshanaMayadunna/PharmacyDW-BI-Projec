-- ============================================================
-- PharmacyDW — DDL Script 06: DimPayment
-- ============================================================
USE PharmacyDW;
GO

CREATE TABLE DimPayment (
    PaymentKey        INT IDENTITY(1,1) PRIMARY KEY,
    PaymentMethod     NVARCHAR(20),   -- Natural Key: Card | Cash | Insurance
    Description       NVARCHAR(200),
    IsDigital         BIT,
    CashbackEligible  BIT
);
GO
-- Source: Source4_Payment_Methods.txt (pipe-delimited)
