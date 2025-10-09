Use AdventureWorksDW2022;
go
--SABER QUE CAMPOS TIENE LA BASE DATOS --
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DimCustomer';

-- CONOCER TODAS LAS TABLAS QUE TIENEN--
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

-- CONOCER LOS DATOS DE UNA SOLA TABLA--
SELECT *
FROM DimCustomer;

--CONOCER LOS DATOS DE DIFERENTES TABLAS PERO SOLO 10 DATOS--
SELECT TOP 10 *
FROM DimCustomer;

SELECT TOP 10 *
FROM DimProduct;

SELECT TOP 10 *
FROM FactInternetSales;

--CONBINAR TABLAS--
SELECT 
    c.FirstName,
    c.LastName,
    f.SalesOrderNumber,
    f.OrderDate,
    f.SalesAmount
FROM FactInternetSales f
INNER JOIN DimCustomer c
    ON f.CustomerKey = c.CustomerKey;

-- VER VENTAS MAYORES A 1000--
SELECT 
    f.SalesOrderNumber,
    f.OrderDate,
    f.SalesAmount
FROM FactInternetSales f
WHERE f.SalesAmount > 1000;

SELECT 
    c.FirstName,
    c.LastName,
    f.SalesOrderNumber,
    f.SalesAmount
FROM FactInternetSales f
INNER JOIN DimCustomer c
    ON f.CustomerKey = c.CustomerKey
WHERE c.LastName = 'Mitchell';

--ORDENAR DATOS DE MANERA DESCENDIENTE--
SELECT 
    f.SalesOrderNumber,
    f.OrderDate,
    f.SalesAmount
FROM FactInternetSales f
WHERE f.SalesAmount > 1000
ORDER BY f.SalesAmount DESC;

--VER CLIENTES QUE NO TIENEN EMAIL--
SELECT 
    CustomerKey,
    FirstName,
    LastName,
    EmailAddress
FROM DimCustomer
WHERE EmailAddress IS NULL;

SELECT 
    CustomerKey,
    FirstName,
    LastName,
    EmailAddress
FROM DimCustomer
WHERE EmailAddress IS NOT NULL;

-- probar el like--
SELECT FirstName, LastName
FROM DimCustomer
WHERE FirstName LIKE 'A%';

SELECT FirstName, LastName
FROM DimCustomer
WHERE LastName LIKE '%son';

SELECT FirstName, LastName
FROM DimCustomer
WHERE FirstName LIKE '%li%';

--donde viven cada cliente--
SELECT 
    c.FirstName,
    c.LastName,
    g.EnglishCountryRegionName AS Country
FROM DimCustomer c
INNER JOIN DimGeography g
    ON c.GeographyKey = g.GeographyKey
WHERE g.EnglishCountryRegionName IN ('Spain', 'France');

-- mostrar ventas --
SELECT 
    SalesOrderNumber,
    SalesAmount
FROM FactInternetSales
WHERE SalesAmount BETWEEN 500 AND 1000;

--total de ventas--
SELECT 
    SUM(SalesAmount) AS TotalVentas
FROM FactInternetSales;

--total pedidos--
SELECT 
    COUNT(SalesOrderNumber) AS CantidadPedidos
FROM FactInternetSales;

--promedio de ventas al año--
SELECT 
    YEAR(f.OrderDate) AS Año,
    AVG(f.SalesAmount) AS PromedioVentas
FROM FactInternetSales f
GROUP BY YEAR(f.OrderDate);

--clientes con mas de 5000 ventas--
SELECT 
    c.FirstName,
    c.LastName,
    SUM(f.SalesAmount) AS TotalVentas
FROM FactInternetSales f
INNER JOIN DimCustomer c
    ON f.CustomerKey = c.CustomerKey
GROUP BY c.FirstName, c.LastName
HAVING SUM(f.SalesAmount) > 5000;

--clasificar ventas --
SELECT 
    f.SalesOrderNumber,
    f.SalesAmount,
    CASE
        WHEN f.SalesAmount < 500 THEN 'Baja'
        WHEN f.SalesAmount BETWEEN 500 AND 2000 THEN 'Media'
        ELSE 'Alta'
    END AS CategoriaVenta
FROM FactInternetSales f;

--subconsultas escalar--
--comparar las ventas mayores del promedio--
SELECT 
    SalesOrderNumber,
    SalesAmount
FROM FactInternetSales
WHERE SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM FactInternetSales
);

--subconsulta de tablas--
--total de ventas por cliente--
SELECT 
    Cliente.FirstName,
    Cliente.LastName,
    Totales.TotalVentas
FROM (
    SELECT 
        CustomerKey,
        SUM(SalesAmount) AS TotalVentas
    FROM FactInternetSales
    GROUP BY CustomerKey
) AS Totales
INNER JOIN DimCustomer AS Cliente
    ON Totales.CustomerKey = Cliente.CustomerKey;

	--subconsulta correlacionada--
-- ventas mayores al promedio del mismo cliente--
SELECT 
    f1.SalesOrderNumber,
    f1.CustomerKey,
    f1.SalesAmount
FROM FactInternetSales f1
WHERE f1.SalesAmount > (
    SELECT AVG(f2.SalesAmount)
    FROM FactInternetSales f2
    WHERE f2.CustomerKey = f1.CustomerKey
);

--ventas totales de cada cliente por pais --
SELECT 
    Sub.Country,
    Sub.FirstName,
    Sub.LastName,
    Sub.TotalSales
FROM (
    SELECT 
        c.CustomerKey,
        c.FirstName,
        c.LastName,
        g.EnglishCountryRegionName AS Country,
        SUM(f.SalesAmount) AS TotalSales
    FROM FactInternetSales f
    INNER JOIN DimCustomer c
        ON f.CustomerKey = c.CustomerKey
    INNER JOIN DimGeography g
        ON c.GeographyKey = g.GeographyKey
    GROUP BY 
        c.CustomerKey, c.FirstName, c.LastName, g.EnglishCountryRegionName
) AS Sub
WHERE Sub.TotalSales > 5000
ORDER BY Sub.TotalSales DESC;

--         --
SELECT 
    c.FirstName,
    c.LastName,
    g.EnglishCountryRegionName AS Country
FROM DimCustomer c
LEFT JOIN DimGeography g
    ON c.GeographyKey = g.GeographyKey;

SELECT 
    c.FirstName,
    c.LastName,
    g.EnglishCountryRegionName AS Country
FROM DimCustomer c
RIGHT JOIN DimGeography g
    ON c.GeographyKey = g.GeographyKey;

SELECT 
    c.FirstName,
    g.EnglishCountryRegionName AS Country
FROM DimCustomer c
CROSS JOIN DimGeography g;

BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO FactInternetSales
        (ProductKey, CustomerKey, PromotionKey, CurrencyKey, SalesTerritoryKey,
         SalesOrderNumber, SalesOrderLineNumber, RevisionNumber,
         OrderDateKey, DueDateKey, ShipDateKey,
         OrderQuantity, UnitPrice, ExtendedAmount,
         UnitPriceDiscountPct, DiscountAmount,
         ProductStandardCost, TotalProductCost,
         SalesAmount, TaxAmt, Freight)
    VALUES
        (602, 11000, 1, 35, 1,
         'SO999995', 1, 1,
         20050101, 20050105, 20050103,
         2, 250.00, 500.00,
         0.00, 0.00,
         150.00, 300.00,
         500.00, 40.00, 10.00);

    COMMIT TRANSACTION;
    PRINT ' Transacción completada exitosamente.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT ' Error detectado. Cambios revertidos.';
    PRINT 'Detalles del error:';
    PRINT ERROR_MESSAGE();
END CATCH;

--verificacion del registro--
SELECT SalesOrderNumber, OrderDateKey, SalesAmount, CustomerKey
FROM FactInternetSales
WHERE SalesOrderNumber = 'SO999993';


SELECT TOP 5 ProductKey FROM DimProduct;
SELECT TOP 5 CustomerKey FROM DimCustomer;
SELECT TOP 5 PromotionKey FROM DimPromotion;
SELECT TOP 5 CurrencyKey FROM DimCurrency;
SELECT TOP 5 DateKey, FullDateAlternateKey
FROM DimDate;
