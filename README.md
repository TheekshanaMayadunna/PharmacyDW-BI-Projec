# 🏥 PharmacyDW — Data Warehouse & Business Intelligence Project


## 📌 Project Overview

A complete end-to-end DW & BI solution built on a **Sri Lanka Multi-Branch Pharmacy Sales** dataset containing **50,000 transactions** across **7 branches** and **6 provinces** over an **18-month period** (January 2022 – June 2023).

The solution follows a **Kimball-style six-layer pipeline architecture**:

```
Layer 1 — Data Sources
Layer 2 — Staging Area  (PharmacyDW_Staging)
Layer 3 — ETL / SSIS Packages
Layer 4 — Data Warehouse  (PharmacyDW — Star Schema)
Layer 5 — OLAP / SSAS Cube
Layer 6 — Reporting & Analytics
```

---

## 📂 Repository Structure

```
PharmacyDW_BI_Project/
│
├── README.md                        ← You are here
│
├── docs/
│   ├── assignment1/                 ← Assignment 1 report (PDF)
│   └── assignment2/                 ← Assignment 2 report (PDF)
│
├── sql/
│   ├── ddl/                         ← CREATE TABLE scripts for all DW tables
│   │   ├── 01_create_DimDate.sql
│   │   ├── 02_create_DimBranch.sql
│   │   ├── 03_create_DimMedicine.sql
│   │   ├── 04_create_DimSupplier.sql
│   │   ├── 05_create_DimCustomer.sql
│   │   ├── 06_create_DimPayment.sql
│   │   └── 07_create_FactPharmacySales.sql
│   ├── etl/
│   │   └── populate_DimDate.sql     ← Date dimension generation script
│   └── queries/
│       └── validation_queries.sql   ← Row count and join validation queries
│
├── ssis-packages/                   ← SSIS .dtsx package files
│   ├── 01_Load_Staging.dtsx
│   ├── 02_Load_Dimensions.dtsx
│   ├── 03_Load_FactSales.dtsx
│   └── 04_Update_AccumulatingFact.dtsx
│
├── ssas/                            ← SSAS project files
│   └── PharmacySales_Cube_it23584068/
│
├── powerbi/                         ← Power BI report file
│   └── PharmacyDW_Reports.pbix
│
├── data/
│   ├── source-files/                ← Raw source data files
│   │   ├── Source1_Transactions.csv
│   │   ├── Medicine_Supplier_Reference.xlsx
│   │   └── Source4_Payment_Methods.txt
│   └── staging/                     ← Staging DDL scripts
│       └── create_staging_tables.sql
│
└── scripts/
    └── setup.md                     ← Step-by-step environment setup guide
```

---

## 🗄️ Data Warehouse Design

### Star Schema — Tables

| Table | Type | Primary Key | Description |
|---|---|---|---|
| `DimDate` | Dimension | DateKey (INT) | Calendar dimension Jan 2022 – Jun 2023 |
| `DimBranch` | Dimension | BranchKey | 7 branches — Province → District → Branch hierarchy |
| `DimMedicine` | Dimension | MedicineKey | 148 medicines — Category → Name hierarchy |
| `DimSupplier` | **SCD Type 2** | SupplierKey | 8 suppliers with historical tracking |
| `DimCustomer` | Dimension | CustomerKey | 64 demographic segments (Gender + AgeGroup + City) |
| `DimPayment` | Dimension | PaymentKey | Card / Cash / Insurance |
| `FactPharmacySales` | Accumulating Fact | SalesKey | 50,000 transactions with 6 FK references |

### Fact Table Measures

| Measure | Type | Aggregation |
|---|---|---|
| Quantity | INT | SUM, AVG |
| UnitPrice_LKR | DECIMAL(12,2) | AVG, MIN, MAX |
| DiscountRate | DECIMAL(5,4) | AVG |
| DiscountAmount_LKR | DECIMAL(12,2) | SUM |
| LineTotal_LKR | DECIMAL(12,2) | SUM, AVG |
| txn_process_time_hours | DECIMAL(10,2) | AVG |

---

## ⚙️ ETL Packages (SSIS)

| Package | Purpose | Order |
|---|---|---|
| `01_Load_Staging.dtsx` | Loads all 4 source types into 5 staging tables | 1st |
| `02_Load_Dimensions.dtsx` | Populates all 6 dimension tables (incl. SCD Type 2) | 2nd |
| `03_Load_FactSales.dtsx` | Loads fact table with surrogate key lookups | 3rd |
| `04_Update_AccumulatingFact.dtsx` | Updates completion time + process hours | 4th |

---

## 📊 SSAS Cube — Hierarchies

| Hierarchy | Dimension | Levels |
|---|---|---|
| Calendar | DimDate | Year → Quarter → Month → Day |
| Geography | DimBranch | Province → District → BranchName |
| Product | DimMedicine | MedicineCategory → MedicineName |
| Customer Segment | DimCustomer | AgeGroup → Gender |

**Cube Name:** `PharmacySales_Cube`  
**SSAS Database:** `PharmacyDW_SSAS_IT23584068`

---

## 📈 Power BI Reports

| Report | Description |
|---|---|
| Report 1 — Matrix Visual | Cross-tabulation of Branch × Medicine Category with revenue |
| Report 2 — Slicers & Cascading Filters | Interactive dashboard with Province, Branch, Category, Year slicers |
| Report 3 — Drill-Down | Time hierarchy drill-down: Year → Quarter → Month |
| Report 4 — Drill-Through | Branch summary → Branch detail page |

---

## 🔧 Tech Stack

- **Database:** Microsoft SQL Server (SSMS)
- **ETL:** SQL Server Integration Services (SSIS) in Visual Studio
- **OLAP Cube:** SQL Server Analysis Services (SSAS) — Multidimensional
- **Reporting:** Power BI Desktop + Power BI Service
- **Excel:** OLAP Pivot Tables (Roll-up, Drill-down, Slice, Dice, Pivot)

---

## 🚀 Getting Started

See [`scripts/setup.md`](scripts/setup.md) for full environment setup instructions.

**Quick steps:**
1. Restore or create `PharmacyDW` and `PharmacyDW_Staging` databases in SSMS
2. Run all scripts in `sql/ddl/` in order
3. Place source files in `data/source-files/`
4. Execute SSIS packages in order (01 → 02 → 03 → 04)
5. Deploy SSAS project from `ssas/` folder
6. Open Power BI report from `powerbi/` folder

---

