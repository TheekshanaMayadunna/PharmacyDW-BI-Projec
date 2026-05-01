-- ============================================================
-- PharmacyDW — DDL Script 01: DimDate
-- ============================================================
USE PharmacyDW;
GO

CREATE TABLE DimDate (
    DateKey       INT PRIMARY KEY,
    FullDate      DATE,
    Year          INT,
    Quarter       INT,
    QuarterName   NVARCHAR(10),
    Month         INT,
    MonthName     NVARCHAR(20),
    Week          INT,
    Day           INT,
    DayName       NVARCHAR(15),
    DayOfWeek     INT,
    IsWeekend     BIT,
    IsHoliday     BIT
);
GO
