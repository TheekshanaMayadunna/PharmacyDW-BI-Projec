# ⚙️ Environment Setup Guide

## Prerequisites

| Tool | Version | Purpose |
|---|---|---|
| SQL Server | 2019 or later | Database engine |
| SSMS | 19+ | SQL management |
| Visual Studio | 2019/2022 | SSIS & SSAS development |
| SSIS extension | VS extension | ETL package development |
| SSAS extension | VS extension | Cube development |
| Power BI Desktop | Latest | Report development |
| Excel | 2016+ with Analysis Services add-in | OLAP operations |

---

## Step 1 — Create Databases

Open SSMS and run:

```sql
CREATE DATABASE PharmacyDW;
CREATE DATABASE PharmacyDW_Staging;
CREATE DATABASE PharmacySource;   -- Source system simulation
GO
```

---

## Step 2 — Create Staging Tables

```
Run: data/staging/create_staging_tables.sql  (on PharmacyDW_Staging)
```

---

## Step 3 — Create Data Warehouse Tables

Run in order on `PharmacyDW`:

```
sql/ddl/01_create_DimDate.sql
sql/ddl/02_create_DimBranch.sql
sql/ddl/03_create_DimMedicine.sql
sql/ddl/04_create_DimSupplier.sql
sql/ddl/05_create_DimCustomer.sql
sql/ddl/06_create_DimPayment.sql
sql/ddl/07_create_FactPharmacySales.sql
```

---

## Step 4 — Place Source Files

Copy source files to your SSIS-accessible path and update connection managers:

```
data/source-files/Source1_Transactions.csv
data/source-files/Medicine_Supplier_Reference.xlsx
data/source-files/Source4_Payment_Methods.txt
```

Also populate `PharmacySource.dbo.BranchMaster` from your branch data.

---

## Step 5 — Run SSIS Packages

Open the SSIS project in Visual Studio and run packages **in order**:

```
1. 01_Load_Staging.dtsx          — loads all staging tables
2. 02_Load_Dimensions.dtsx       — loads all 6 dimension tables
3. 03_Load_FactSales.dtsx        — loads 50,000 fact rows
4. 04_Update_AccumulatingFact.dtsx — updates completion times
```

---

## Step 6 — Validate Data

Run `sql/queries/validation_queries.sql` in SSMS.  
Expected fact row count: **50,000**

---

## Step 7 — Deploy SSAS Cube

1. Open `ssas/PharmacySales_Cube_it23584068/` in Visual Studio
2. Right-click project → **Deploy**
3. Right-click cube → **Process** → Full Processing
4. Browse in cube browser to verify

---

## Step 8 — Open Power BI Report

1. Open `powerbi/PharmacyDW_Reports.pbix` in Power BI Desktop
2. Update data source connection to your SQL Server instance
3. Refresh data model
4. Publish to Power BI Service if needed

---

## Step 9 — Excel OLAP Connection

1. Open Excel → Data → Get Data → From Analysis Services
2. Server: `THEEKSHANA\SQLEXPRESS01`
3. Database: `PharmacyDW_SSAS_IT23584068`
4. Cube: `PharmacySales_Cube`
5. Insert PivotTable to begin OLAP operations

---

## SSAS Configuration Reference

| Element | Value |
|---|---|
| Visual Studio project | `PharmacySales_Cube_it23584068` |
| SSAS cube name | `PharmacySales_Cube` |
| Data source name | `Pharmacy DW` |
| Data source view | `PharmacyDW_DSV` |
| SSAS server | `THEEKSHANA\SQLEXPRESS01` |
| SSAS database | `PharmacyDW_SSAS_IT23584068` |
