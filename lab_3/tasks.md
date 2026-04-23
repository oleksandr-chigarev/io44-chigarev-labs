# Лабораторна робота №3: Маніпулювання даними (OLTP)

**Виконав:** Чігарев Олександр  
**Тема:** Операції з даними (INSERT, UPDATE, DELETE, SELECT) у базі даних магазину.

---

## 1. Повний перелік SQL-запитів (DML)

Усі операції по роботі з даними (вибірка, додавання нового клієнта та товару, оновлення ціни та видалення залишків) об'єднані в один скрипт:

```sql
-- [ЗАВДАННЯ 1]: ВИБІРКА ДАНИХ (SELECT)
-- Отримання списку клієнтів та фільтрація товарів за ціною
SELECT * FROM Customer;
SELECT Name, Price, StockQuantity FROM Product WHERE Price > 10000;

-- [ЗАВДАННЯ 2]: ДОДАВАННЯ ДАНИХ (INSERT)
-- Реєстрація нового покупця
INSERT INTO Customer (FirstName, LastName, Email, RegistrationDate)
VALUES ('Андрій', 'Коваленко', 'andrii.k@email.com', CURRENT_TIMESTAMP);

-- Додавання нового аксесуара
INSERT INTO Product (Name, Description, Price, StockQuantity, CategoryID)
VALUES ('Чохол Silicone Case', 'Захисний чохол для телефону', 950.00, 100, 4);

-- Перевірка результату вставки
SELECT * FROM Product WHERE Name = 'Чохол Silicone Case';

-- [ЗАВДАННЯ 3]: ОНОВЛЕННЯ ДАНИХ (UPDATE)
-- Коригування ціни товару (ID: 1) та застосування знижки 10% на замовлення
UPDATE Product SET Price = Price + 1000 WHERE ProductID = 1;
UPDATE "Order" SET TotalAmount = TotalAmount * 0.9 WHERE OrderID = 1;

-- Перевірка оновлених значень
SELECT * FROM Product WHERE ProductID = 1;

-- [ЗАВДАННЯ 4]: ВИДАЛЕННЯ ДАНИХ (DELETE)
-- Очищення бази від товарів з нульовим залишком та видалення замовлення
DELETE FROM Product WHERE StockQuantity = 0;
DELETE FROM "Order" WHERE OrderID = 5;
