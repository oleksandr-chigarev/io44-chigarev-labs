\# Лабораторна робота №3: Маніпулювання даними (OLTP)



\*\*Мета:\*\* Відпрацювати основні операції маніпулювання даними (DML): пошук, додавання, зміну та видалення записів у базі даних інтернет-магазину.



\---



\## Завдання 1: Вибірка даних (SELECT)



```sql

\-- Отримання списку всіх клієнтів

SELECT \* FROM Customer;



\-- Пошук товарів дорожче 10 000 грн

SELECT Name, Price FROM Product WHERE Price > 10000;


\-- Додавання нового клієнта

INSERT INTO Customer (FirstName, LastName, Email, RegistrationDate)

VALUES ('Андрій', 'Коваленко', 'andrii.k@email.com', CURRENT\_TIMESTAMP);



\-- Додавання нового товару

INSERT INTO Product (Name, Description, Price, StockQuantity, CategoryID)

VALUES ('Чохол Leather Case', 'Шкіряний чохол для iPhone', 1200.00, 50, 2);



\-- Перевірка доданого товару

SELECT \* FROM Product;



\-- Збільшення ціни товару з ID 1 на 500 грн

UPDATE Product

SET Price = Price + 500

WHERE ProductID = 1;



\-- Зміна Email клієнта

UPDATE Customer

SET Email = 'updated.email@gmail.com'

WHERE CustomerID = 1;



\-- Перевірка оновлення

SELECT \* FROM Customer;



\-- Видалення замовлення №5

DELETE FROM "Order"

WHERE OrderID = 5;



\-- Видалення товарів, кількість яких на складі дорівнює 0

DELETE FROM Product

WHERE StockQuantity = 0;

