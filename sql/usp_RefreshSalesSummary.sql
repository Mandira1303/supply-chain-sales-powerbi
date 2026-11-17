USE [AdventureWorksDW2022]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[usp_RefreshSalesSummary] AS
BEGIN
  IF OBJECT_ID('dbo.SalesSummary') IS NOT NULL DROP TABLE dbo.SalesSummary;
  SELECT d.CalendarYear, d.EnglishMonthName, t.SalesTerritoryRegion,
         SUM(f.SalesAmount) AS TotalSales, SUM(f.TotalProductCost) AS TotalCost
  INTO dbo.SalesSummary
  FROM dbo.FactInternetSales f
  JOIN dbo.DimDate d ON f.OrderDateKey = d.DateKey
  JOIN dbo.DimSalesTerritory t ON f.SalesTerritoryKey = t.SalesTerritoryKey
  GROUP BY d.CalendarYear, d.EnglishMonthName, t.SalesTerritoryRegion;
END;
GO
EXEC dbo.usp_RefreshSalesSummary;
GO
