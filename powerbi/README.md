# Power BI Reports

Place your `.pbix` file here:

```
powerbi/
└── PharmacyDW_Reports.pbix
```

## Report Pages

| Page | Type | Description |
|---|---|---|
| Page 1 — Matrix | Matrix visual | Branch × Medicine Category cross-tabulation |
| Page 2 — Slicers | Interactive dashboard | Province, Branch, Category, Year cascading slicers |
| Page 3 — Drill-Down | Bar + Area charts | Time hierarchy: Year → Quarter → Month |
| Page 4 — Summary | Drill-through source | Revenue by Branch (click to drill through) |
| Page 5 — Branch Detail | Drill-through target | KPIs + monthly trend + medicine breakdown |

## Data Model

All 7 tables imported in **Import mode** from `PharmacyDW` SQL Server database.  
Star schema: `FactPharmacySales` at centre, 6 dimension tables on the one-side.

## Published URL

Report published to Power BI Service at: `app.powerbi.com`
