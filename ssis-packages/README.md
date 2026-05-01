# SSIS Packages

Place your `.dtsx` package files here:

| File | Purpose |
|---|---|
| `01_Load_Staging.dtsx` | Extracts from all 4 sources into staging |
| `02_Load_Dimensions.dtsx` | Loads all 6 dimension tables (incl. SCD Type 2) |
| `03_Load_FactSales.dtsx` | Loads FactPharmacySales with surrogate key lookups |
| `04_Update_AccumulatingFact.dtsx` | Updates completion time and process hours |

Export packages from Visual Studio:  
Right-click `.dtsx` file → **Copy to Folder**, then paste here.
