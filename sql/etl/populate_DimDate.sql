-- ============================================================
-- PharmacyDW — ETL: Populate DimDate
-- Covers Jan 2022 – Jun 2023 (546 dates)
-- Run as Execute SQL Task in SSIS Package 02
-- ============================================================
USE PharmacyDW;
GO

DECLARE @date DATE = '2022-01-01';
DECLARE @end  DATE = '2023-06-30';

WHILE @date <= @end
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM DimDate WHERE DateKey = CAST(FORMAT(@date,'yyyyMMdd') AS INT)
    )
    BEGIN
        INSERT INTO DimDate (
            DateKey, FullDate, Year, Quarter, QuarterName,
            Month, MonthName, Week, Day, DayName,
            DayOfWeek, IsWeekend, IsHoliday
        )
        VALUES (
            CAST(FORMAT(@date,'yyyyMMdd') AS INT),
            @date,
            YEAR(@date),
            DATEPART(QUARTER, @date),
            'Q' + CAST(DATEPART(QUARTER, @date) AS NVARCHAR),
            MONTH(@date),
            FORMAT(@date,'MMMM'),
            DATEPART(WEEK, @date),
            DAY(@date),
            FORMAT(@date,'dddd'),
            DATEPART(WEEKDAY, @date),
            CASE WHEN DATEPART(WEEKDAY, @date) IN (1,7) THEN 1 ELSE 0 END,
            0  -- IsHoliday: update manually for Sri Lanka public holidays
        );
    END

    SET @date = DATEADD(DAY, 1, @date);
END
GO

-- Verify
SELECT COUNT(*) AS TotalDates FROM DimDate;  -- Expected: 546
