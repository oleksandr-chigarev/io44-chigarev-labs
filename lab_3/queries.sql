-- Показати всіх клієнтів
SELECT * FROM Customer;

-- Знайти товари дорожче 10 000 грн (наприклад, iPhone чи MacBook)
SELECT Name, Price, StockQuantity FROM Product WHERE Price > 10000;

-- Додаємо нового покупця
INSERT INTO Customer (FirstName, LastName, Email, RegistrationDate)
VALUES ('Андрій', 'Коваленко', 'andrii.k@email.com', CURRENT_TIMESTAMP);

-- Додаємо новий товар (аксесуар)
INSERT INTO Product (Name, Description, Price, StockQuantity, CategoryID)
VALUES ('Чохол Silicone Case', 'Захисний чохол для телефону', 950.00, 100, 2);

-- Перевіряємо, чи з'явився товар
SELECT * FROM Product WHERE Name = 'Чохол Silicone Case';

-- Змінюємо ціну товару з ID 1 (наприклад, через курс валют)
UPDATE Product SET Price = Price + 1000 WHERE ProductID = 1;

-- Оновлюємо статус замовлення (якщо у тебе є замовлення з ID 1)
UPDATE "Order" SET TotalAmount = TotalAmount * 0.9 WHERE OrderID = 1; -- Знижка 10%
SELECT * FROM Product WHERE ProductID = 1;

-- Видаляємо товар, якого немає в наявності
DELETE FROM Product WHERE StockQuantity = 0;

-- Видаляємо конкретне замовлення
DELETE FROM "Order" WHERE OrderID = 5;