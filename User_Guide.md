# User Guide: Supply Chain & Sales Dashboard

**What it is:** An interactive sales report with two pages. It shows how much we sold, how much profit we made, and where.

## Opening the report
Sign in at **app.powerbi.com** -> **My workspace** -> **Supply_Chain_Sales_Dashboard**.

## Page 1: Executive Summary
| Item | What it tells you |
|---|---|
| **Total Sales** | Total revenue for the current filter |
| **Profit** | Sales minus product cost |
| **Margin %** | Profit as a share of sales |
| **Line chart** | Sales by month (shows the seasonal pattern) |
| **Category chart** | Sales by product category (Bikes, Accessories, Clothing) |
| **Territory chart** | Sales by sales region |

## How to use it
1. **Filter by year:** use the **CalendarYear** dropdown. Every chart updates.
2. **Cross-filter:** click any bar (for example, "Bikes"). The other charts highlight to match. Click it again to clear.
3. **Drill through to products:** right-click a bar -> **Drill through** -> **Product Details**. Use the back arrow at the top of the page to return.
4. **Read the table:** on Product Details, each product shows Sales, Profit, and Margin %. Click a column heading to sort.

## Security
You only see the regions assigned to your role (North America, Europe, or Pacific). If a region is missing, ask the report owner to update your role.

## Data refresh
Data comes from the AdventureWorks warehouse. A SQL job updates the summary table daily at 02:00. The report owner refreshes and republishes the report. The "Data updated" date at the top shows the last refresh.

## Troubleshooting
| Problem | Fix |
|---|---|
| A chart looks empty | Clear the slicer (set CalendarYear to "All") |
| Numbers look different | Check which filters are active (Filters pane on the right) |
| Can't open the report | Confirm you're signed in with the correct account |
