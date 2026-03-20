-- ==========================================
-- 1. СТВОРЕННЯ ТАБЛИЦЬ (DDL)
-- ==========================================

-- Таблиця Клієнтів
CREATE TABLE Customer (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблиця Категорій товарів
CREATE TABLE Category (
    CategoryID SERIAL PRIMARY KEY,
    CategoryName VARCHAR(100) UNIQUE NOT NULL
);

-- Таблиця Товарів
CREATE TABLE Product (
    ProductID SERIAL PRIMARY KEY,
    CategoryID INTEGER NOT NULL,
    Name VARCHAR(150) NOT NULL,
    Description TEXT,
    Price NUMERIC(10, 2) NOT NULL CHECK (Price > 0), -- Ціна має бути більшою за нуль
    StockQuantity INTEGER NOT NULL DEFAULT 0 CHECK (StockQuantity >= 0), -- Кількість не може бути від'ємною
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID) ON DELETE RESTRICT
);

-- Таблиця Замовлень
CREATE TABLE "Order" (
    OrderID SERIAL PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) NOT NULL DEFAULT 'Нове' CHECK (Status IN ('Нове', 'В обробці', 'Відправлено', 'Доставлено', 'Скасовано')),
    TotalAmount NUMERIC(12, 2) NOT NULL DEFAULT 0 CHECK (TotalAmount >= 0),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE
);

-- Таблиця Деталей замовлення (зв'язок багато-до-багатьох)
CREATE TABLE OrderItem (
    OrderItemID SERIAL PRIMARY KEY,
    OrderID INTEGER NOT NULL,
    ProductID INTEGER NOT NULL,
    Quantity INTEGER NOT NULL CHECK (Quantity > 0), -- Кількість замовленого не може бути нулем
    UnitPrice NUMERIC(10, 2) NOT NULL CHECK (UnitPrice >= 0),
    FOREIGN KEY (OrderID) REFERENCES "Order"(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE RESTRICT
);


-- ==========================================
-- 2. ВСТАВКА ТЕСТОВИХ ДАНИХ (DML)
-- ==========================================

-- Додаємо клієнтів (5 записів)
INSERT INTO Customer (FirstName, LastName, Email, Phone) VALUES
('Олександр', 'Шевченко', 'alex.shevchenko@email.com', '+380501234567'),
('Марія', 'Коваленко', 'maria.koval@email.com', '+380671234567'),
('Іван', 'Бойко', 'ivan.boyko@email.com', '+380931234567'),
('Анна', 'Мельник', 'anna.melnyk@email.com', '+380991234567'),
('Дмитро', 'Ткаченко', 'dmytro.tkach@email.com', NULL);

-- Додаємо категорії (4 записи)
INSERT INTO Category (CategoryName) VALUES
('Смартфони'),
('Ноутбуки'),
('Навушники'),
('Аксесуари');

-- Додаємо товари (5 записів)
INSERT INTO Product (CategoryID, Name, Description, Price, StockQuantity) VALUES
(1, 'iPhone 15 Pro', 'Остання модель смартфона від Apple', 45999.00, 15),
(1, 'Samsung Galaxy S24', 'Флагманський смартфон на Android', 39999.00, 20),
(2, 'MacBook Air M2', 'Легкий та потужний ноутбук', 52000.00, 10),
(3, 'AirPods Pro 2', 'Бездротові навушники з шумозаглушенням', 10500.00, 30),
(4, 'Чохол для iPhone 15', 'Прозорий силіконовий чохол', 500.00, 100);

-- Додаємо замовлення (4 записи)
INSERT INTO "Order" (CustomerID, Status, TotalAmount) VALUES
(1, 'Доставлено', 46499.00),
(2, 'В обробці', 52000.00),
(3, 'Нове', 10500.00),
(1, 'Відправлено', 10500.00);

-- Додаємо деталі замовлень (5 записів)
-- Замовлення 1 (Олександр) купив iPhone 15 Pro та Чохол
INSERT INTO OrderItem (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 1, 45999.00),
(1, 5, 1, 500.00),
-- Замовлення 2 (Марія) купила MacBook Air
(2, 3, 1, 52000.00),
-- Замовлення 3 (Іван) купив AirPods Pro 2
(3, 4, 1, 10500.00),
-- Замовлення 4 (Олександр) купив ще одні AirPods Pro 2
(4, 4, 1, 10500.00);
