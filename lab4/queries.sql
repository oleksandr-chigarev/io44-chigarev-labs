SELECT 
    COUNT(OrderID) AS TotalOrders, 
    SUM(TotalAmount) AS TotalRevenue 
FROM "Order";

SELECT 
    MIN(Price) AS MinPrice, 
    MAX(Price) AS MaxPrice, 
    ROUND(AVG(Price), 2) AS AvgPrice 
FROM Product;

SELECT 
    CategoryID, 
    COUNT(ProductID) AS ProductCount 
FROM Product 
GROUP BY CategoryID;

SELECT 
    CustomerID, 
    SUM(TotalAmount) AS TotalSpent 
FROM "Order" 
GROUP BY CustomerID 
HAVING SUM(TotalAmount) > 10000;

SELECT 
    p.Name AS ProductName, 
    c.CategoryName, 
    p.Price 
FROM Product p
INNER JOIN Category c ON p.CategoryID = c.CategoryID;

SELECT 
    c.FirstName, 
    c.LastName, 
    o.OrderID, 
    o.TotalAmount 
FROM Customer c
LEFT JOIN "Order" o ON c.CustomerID = o.CustomerID;

SELECT 
    p.Name AS ProductName, 
    oi.Quantity AS ItemsSold 
FROM OrderItem oi
RIGHT JOIN Product p ON oi.ProductID = p.ProductID;

SELECT 
    Name, 
    Price 
FROM Product 
WHERE Price > (SELECT AVG(Price) FROM Product);

SELECT 
    FirstName, 
    LastName, 
    (SELECT COUNT(*) FROM "Order" WHERE CustomerID = Customer.CustomerID) AS OrderCount 
FROM Customer;

SELECT 
    CustomerID, 
    SUM(TotalAmount) AS TotalSpent 
FROM "Order" 
GROUP BY CustomerID 
HAVING SUM(TotalAmount) > (SELECT AVG(TotalAmount) FROM "Order");