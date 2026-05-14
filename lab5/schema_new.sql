-- Створення структури
CREATE TABLE Category (
    CategoryID SERIAL PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);

CREATE TABLE Customer (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20)
);

CREATE TABLE Product (
    ProductID SERIAL PRIMARY KEY,
    CategoryID INTEGER REFERENCES Category(CategoryID),
    Name VARCHAR(150) NOT NULL,
    Price NUMERIC(10, 2) NOT NULL,
    StockQuantity INTEGER DEFAULT 0
);

CREATE TABLE "Order" (
    OrderID SERIAL PRIMARY KEY,
    CustomerID INTEGER REFERENCES Customer(CustomerID),
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(50),
    TotalAmount NUMERIC(12, 2)
);

CREATE TABLE OrderItem (
    OrderItemID SERIAL PRIMARY KEY,
    OrderID INTEGER REFERENCES "Order"(OrderID),
    ProductID INTEGER REFERENCES Product(ProductID),
    Quantity INTEGER NOT NULL,
    UnitPrice NUMERIC(10, 2) NOT NULL
);
