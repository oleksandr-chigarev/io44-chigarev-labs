# Лабораторна робота №3: Маніпулювання даними (OLTP)

**Виконав:** [Твоє Прізвище та Ім'я]  
**Тема:** Операції з даними (INSERT, UPDATE, DELETE, SELECT) у базі даних магазину.

---

## 1. Виконання SQL-запитів (DML)

Нижче наведено всі запити для вибірки, додавання, оновлення та видалення даних, виконані під час роботи:

```sql
-- ==========================================
-- ЗАВДАННЯ 1: ВИБІРКА ДАНИХ (SELECT)
-- ==========================================
-- Показати всіх клієнтів
SELECT * FROM Customer;

-- Знайти товари дорожче 10 000 грн
SELECT Name, Price, StockQuantity FROM Product WHERE Price > 10000;


-- ==========================================
-- ЗАВДАННЯ 2: ДОДАВАННЯ ДАНИХ (INSERT)
-- ==========================================
-- Додаємо нового покупця
INSERT INTO Customer (FirstName, LastName, Email, RegistrationDate)
VALUES ('Андрій', 'Коваленко', 'andrii.k@email.com', CURRENT_TIMESTAMP);

-- Додаємо новий товар
INSERT INTO Product (Name, Description, Price, StockQuantity, CategoryID)
VALUES ('Чохол Silicone Case', 'Захисний чохол для телефону', 950.00, 100, 4);

-- Перевірка доданого товару
SELECT * FROM Product WHERE Name = 'Чохол Silicone Case';


-- ==========================================
-- ЗАВДАННЯ 3: ОНОВЛЕННЯ ДАНИХ (UPDATE)
-- ==========================================
-- Змінюємо ціну товару з ID 1 (наприклад, через курс валют)
UPDATE Product SET Price = Price + 1000 WHERE ProductID = 1;

-- Надаємо знижку 10% для замовлення з ID 1
UPDATE "Order" SET TotalAmount = TotalAmount * 0.9 WHERE OrderID = 1;

-- Перевірка оновлення
SELECT * FROM Product WHERE ProductID = 1;


-- ==========================================
-- ЗАВДАННЯ 4: ВИДАЛЕННЯ ДАНИХ (DELETE)
-- ==========================================
-- Видаляємо товар, якого немає в наявності
DELETE FROM Product WHERE StockQuantity = 0;

-- Видаляємо конкретне замовлення
DELETE FROM "Order" WHERE OrderID = 5;
