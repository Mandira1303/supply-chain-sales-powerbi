# User Guide: Enterprise BI Suite

**What it is:** one report for sales, finance, HR and supply chain. You only see data for your own region.

**Open it:** sign in at **app.powerbi.com** → **My workspace** → **Supply_Chain_Sales_Dashboard**. Use the page list on the left to move between pages.

## Pages

| Page | Use it to answer |
|---|---|
| **Executive Summary** | How much did we sell, how much profit, and where? |
| **Product Details** | Which products in a category sell best and at what margin? (Opened by drill-through, see below.) |
| **Sales Trends** | Are sales growing? Year to date, vs last year (YoY %) and the 3-month rolling average |
| **Finance** | Is revenue on budget? Actual vs budget by year, variance by division, expenses by account |
| **HR** | How many people do we employ, in which departments, and how long have they stayed? |
| **Supply Chain** | How much stock do we hold, and which products are about to run out? |

## How to use it

1. **Filter by year:** use the **CalendarYear** slicer on a page. All charts on that page update.
2. **Cross-filter:** click a bar or slice (for example, "Bikes"). The other charts highlight to match. Click it again to clear.
3. **Drill through to products:** on Executive Summary, right-click a category bar → **Drill through** → **Product Details**. Use the back arrow to return.
4. **Sort a table:** click a column heading. On Supply Chain, the product table is sorted by **Days of Inventory**, lowest first: these products are closest to running out.
5. **See exact numbers:** hover over any bar or point.

## Reading the numbers

- **Margin %** = profit ÷ sales.
- **YoY Growth %** compares a period with the same period last year. The last month (January 2014) is incomplete, so it looks like a drop.
- **Revenue Variance %** compares actual revenue with budget, only for periods and divisions that have a budget. Negative means below budget.
- **Days of Inventory** = stock on hand ÷ average units shipped per day.
- **Tenure** is measured to January 2014, when the data ends.

## Security

You see only your region (**Europe**, **North America** or **Pacific**). Supply chain data is company-wide, so everyone sees all of it. If a region is missing or wrong, ask the report owner to check your role.

## Data refresh

A SQL job updates the warehouse summary daily, and the report refreshes daily at **13:30 IST**. The **Data updated** date at the top of the report in Power BI Service shows the last refresh.

## Troubleshooting

| Problem | Fix |
|---|---|
| A chart is empty | Clear the year slicer, or check the Filters pane on the right |
| Budget shows "--" | Your region has no budget data in the source |
| Numbers differ from a colleague's | They may have a different region role, or different filters applied |
| Can't open the report | Check you are signed in with the correct account |
