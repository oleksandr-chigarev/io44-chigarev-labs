# Лабораторна робота №3: Маніпулювання даними (OLTP)

**Виконав:** Чігарев Олексаднр  
**Тема:** Операції з даними в базі даних Інтернет-магазину.

---

## Завдання 1: Вибірка даних (SELECT)
Отримання списку всіх клієнтів та пошук найдорожчих товарів.

```sql
-- Показати всіх клієнтів
SELECT * FROM Customer;

-- Знайти товари дорожче 10 000 грн
SELECT Name, Price, StockQuantity FROM Product WHERE Price > 10000;

## Завдання 2: Додавання нових записів (INSERT)
## Реєстрація нового клієнта та додавання нового товару в каталог.
-- Додаємо нового покупця
INSERT INTO Customer (FirstName, LastName, Email, RegistrationDate)
VALUES ('Андрій', 'Коваленко', 'andrii.k@email.com', CURRENT_TIMESTAMP);

-- Додаємо новий товар (аксесуар)
INSERT INTO Product (Name, Description, Price, StockQuantity, CategoryID)
VALUES ('Чохол Silicone Case', 'Захисний чохол для телефону', 950.00, 100, 2);

-- Перевіряємо, чи з'явився товар
SELECT * FROM Product WHERE Name = 'Чохол Silicone Case';

## Завдання 3: Оновлення даних (UPDATE)
## Коригування ціни товару та оновлення суми замовлення.

-- Змінюємо ціну товару з ID 1 (наприклад, через курс валют)
UPDATE Product SET Price = Price + 1000 WHERE ProductID = 1;

-- Оновлюємо статус замовлення (знижка 10% для замовлення з ID 1)
UPDATE "Order" SET TotalAmount = TotalAmount * 0.9 WHERE OrderID = 1;

## Завдання 4: Видалення даних (DELETE)
## Очищення бази від товарів, яких немає в наявності, та видалення конкретного замовлення.

-- Видаляємо товар, якого немає в наявності
DELETE FROM Product WHERE StockQuantity = 0;

-- Видаляємо конкретне замовлення
DELETE FROM "Order" WHERE OrderID = 5;
