# Data Dictionary

Source database: **AdventureWorksDW2022** (SQL Server). Model names are the table names in Power BI; source names are the warehouse tables they come from.

## Fact tables

### Sales (source: `dbo.FactInternetSales`)
Grain: one row per order line. Covers Dec 2010 – Jan 2014.

| Column | Description |
|---|---|
| OrderDateKey | Order date (yyyymmdd) → `Date` (active relationship) |
| DueDateKey, ShipDateKey | Other dates → `Date` (inactive relationships) |
| ProductKey | → `Product` |
| CustomerKey | → `Customer` |
| SalesTerritoryKey | → `Territory` |
| OrderQuantity | Units ordered |
| SalesAmount | Revenue for the line (used by Total Sales) |
| TotalProductCost | Cost of goods for the line (used by Total Cost) |
| DiscountAmount, ExtendedAmount, Freight, ProductStandardCost | Other line amounts |

### SalesSummary (source: `dbo.SalesSummary`, built by the SQL Agent job)
Grain: one row per year × month × sales region.

| Column | Description |
|---|---|
| CalendarYear | Year of the order date |
| EnglishMonthName | Month name |
| SalesTerritoryRegion | Region → `Territory` (one-to-many) |
| TotalSales | Sum of SalesAmount |
| TotalCost | Sum of TotalProductCost |

### Finance (source: `dbo.FactFinance`)
Grain: one row per date × organization × scenario × account.

| Column | Description |
|---|---|
| DateKey | Period date → `Date` |
| OrganizationKey | → `Organization` |
| ScenarioKey | → `Scenario` (Actual, Budget, Forecast) |
| AccountKey | → `Account` |
| Amount | Value for that account. Mixes revenue, expenses, assets etc., so measures always filter by account type |

### Inventory (source: `dbo.FactProductInventory`)
Grain: one row per product per day (daily stock snapshot).

| Column | Description |
|---|---|
| ProductKey | → `Product` |
| DateKey | Snapshot date → `Date` |
| UnitCost | Cost per unit |
| UnitsIn | Units received that day |
| UnitsOut | Units shipped that day |
| UnitsBalance | Stock at end of day (a snapshot: never summed across days) |

## Dimension tables

### Date (source: `dbo.DimDate`)
Marked as the date table. Key columns: DateKey (yyyymmdd), FullDateAlternateKey (date), CalendarYear, CalendarQuarter, EnglishMonthName, FiscalYear, FiscalQuarter.

### Product (source: `dbo.DimProduct` + merged `DimProductSubcategory`, `DimProductCategory`)
ProductKey, EnglishProductName, ModelName, Color, Size, ProductLine, ListPrice, StandardCost, EnglishProductSubcategoryName, ProductCategoryKey, EnglishProductCategoryName (Bikes, Components, Clothing, Accessories; blank for products with no subcategory).

### Customer (source: `dbo.DimCustomer` + merged `DimGeography`)
CustomerKey, FirstName, BirthDate, EnglishEducation, EnglishOccupation, CommuteDistance, DateFirstPurchase, City, EnglishCountryRegionName.

### Territory (source: `dbo.DimSalesTerritory`)
SalesTerritoryKey, SalesTerritoryRegion (e.g. Northwest, France, Australia), SalesTerritoryCountry, **SalesTerritoryGroup** (North America, Europe, Pacific; used by RLS). Filters Sales, SalesSummary and Employee.

### Employee (source: `dbo.DimEmployee`, 11 of 36 columns kept)
EmployeeKey, FirstName, LastName, Title, DepartmentName, HireDate, Gender, VacationHours, SickLeaveHours, Status ("Current" for current records), SalesTerritoryKey → `Territory` (non-sales staff have territory "NA").

### Account (source: `dbo.DimAccount`)
AccountKey, AccountDescription, AccountType (Revenue, Expenditures, Assets, Liabilities, etc.).

### Organization (source: `dbo.DimOrganization`)
OrganizationKey, OrganizationName, **Region** (calculated column: North America, Europe, Pacific or Corporate; used by RLS).

### Scenario (source: `dbo.DimScenario`)
ScenarioKey, ScenarioName (Actual, Budget, Forecast).

## Relationships

All one-to-many, single direction, active unless noted.

| From (one) | To (many) |
|---|---|
| Date[DateKey] | Sales[OrderDateKey] (active); Sales[DueDateKey], Sales[ShipDateKey] (inactive) |
| Date[DateKey] | Finance[DateKey] |
| Date[DateKey] | Inventory[DateKey] |
| Product[ProductKey] | Sales[ProductKey] |
| Product[ProductKey] | Inventory[ProductKey] |
| Customer[CustomerKey] | Sales[CustomerKey] |
| Territory[SalesTerritoryKey] | Sales[SalesTerritoryKey] |
| Territory[SalesTerritoryRegion] | SalesSummary[SalesTerritoryRegion] |
| Territory[SalesTerritoryKey] | Employee[SalesTerritoryKey] |
| Account[AccountKey] | Finance[AccountKey] |
| Organization[OrganizationKey] | Finance[OrganizationKey] |
| Scenario[ScenarioKey] | Finance[ScenarioKey] |

## Measures

| Table | Measure | Meaning |
|---|---|---|
| Sales | Total Sales, Total Cost, Profit, Margin % | Revenue, cost, profit and profit ÷ revenue |
| Sales | Sales YTD, Sales Prior Year, YoY Growth % | Year to date, same period last year, growth vs last year |
| Sales | Sales Rolling 3M, Sales Rolling 3M Avg | Last 3 months' sales, and that ÷ 3 |
| Finance | Actual / Budget Revenue, Actual / Budget Expenses | Amount filtered by scenario and account type |
| Finance | Actual Revenue (Budgeted), Revenue Variance, Revenue Variance % | Actual vs budget, only where a budget exists |
| Employee | Headcount, Avg Tenure (Years), Avg Vacation Hours, Avg Sick Leave Hours | Current staff count and averages |
| Inventory | Stock on Hand, Stock Value | Units and value on the latest day in the filter |
| Inventory | Units Out, Avg Daily Units Out, Days of Inventory | Units shipped, per day, and days of stock left |

DAX for every measure is in the [README](../README.md#4-dax-measures).
