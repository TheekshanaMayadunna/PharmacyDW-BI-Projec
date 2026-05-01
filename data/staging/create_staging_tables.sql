-- ============================================================
-- PharmacyDW_Staging — Create All Staging Tables
-- ============================================================
USE PharmacyDW_Staging;
GO

-- Source 1: Transactions CSV
CREATE TABLE stg_Transactions (
    Transaction_ID    INT,
    Transaction_Date  NVARCHAR(20),
    Branch_ID         INT,
    Branch_Name       NVARCHAR(100),
    District          NVARCHAR(50),
    Province          NVARCHAR(50),
    Payment_Method    NVARCHAR(20),
    Customer_Gender   NVARCHAR(10),
    Customer_Age      INT,
    Customer_City     NVARCHAR(50),
    Medicine_ID       INT,
    Medicine_Name     NVARCHAR(150),
    Generic_Name      NVARCHAR(100),
    Medicine_Category NVARCHAR(50),
    Dosage_Form       NVARCHAR(50),
    Strength_mg       DECIMAL(8,2),
    Pack_Size         INT,
    Supplier_Name     NVARCHAR(100),
    Prescription_Required NVARCHAR(5),
    Batch_No          NVARCHAR(50),
    Expiry_Date       NVARCHAR(20),
    Quantity          INT,
    Unit_Price_LKR    DECIMAL(12,2),
    Discount_Rate     DECIMAL(5,4),
    Line_Total_LKR    DECIMAL(12,2),
    Year              INT,
    Month             INT
);
GO

-- Source 2: Branch SQL Server table
CREATE TABLE stg_Branches (
    Branch_ID    INT,
    Branch_Name  NVARCHAR(100),
    District     NVARCHAR(50),
    Province     NVARCHAR(50),
    Region       NVARCHAR(50),
    Open_Date    DATE
);
GO

-- Source 3 Sheet 1: Medicine reference Excel
CREATE TABLE stg_Medicines (
    Medicine_ID        INT,
    Medicine_Name      NVARCHAR(150),
    Generic_Name       NVARCHAR(100),
    Medicine_Category  NVARCHAR(50),
    Dosage_Form        NVARCHAR(50),
    Strength_mg        DECIMAL(8,2),
    Pack_Size          INT,
    Therapeutic_Group  NVARCHAR(100)
);
GO

-- Source 3 Sheet 2: Supplier reference Excel
CREATE TABLE stg_Suppliers (
    Supplier_Name     NVARCHAR(100),
    Contact_Email     NVARCHAR(100),
    City              NVARCHAR(50),
    Established_Year  INT,
    Is_Active         BIT
);
GO

-- Source 4: Payment methods pipe-delimited text
CREATE TABLE stg_PaymentMethods (
    Payment_Method    NVARCHAR(20),
    Description       NVARCHAR(200),
    Is_Digital        BIT,
    Cashback_Eligible BIT,
    Processing_Days   INT
);
GO

-- Error log table
CREATE TABLE stg_ETL_Errors (
    ErrorID       INT IDENTITY(1,1) NOT NULL,
    ErrorTime     DATETIME          NOT NULL,
    ErrorSource   NVARCHAR(255)     NOT NULL,
    ErrorMessage  NVARCHAR(MAX)     NOT NULL,
    SourceKey     NVARCHAR(255)     NULL,
    CONSTRAINT PK_stg_ETL_Errors PRIMARY KEY CLUSTERED (ErrorID ASC)
);
GO
