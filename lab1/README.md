# Лабораторна робота №1: Збір вимог та розробка схеми ER

## 1. Короткий виклад вимог
**Предметна область:** Інтернет-магазин (E-commerce).
**Мета системи:** Створення бази даних для інтернет-магазину, яка дозволяє клієнтам переглядати товари, додавати їх у кошик та оформлювати замовлення, а адміністраторам — управляти асортиментом та відстежувати продажі.

**Бізнес-правила та операції:**
* Клієнти повинні реєструватися (створювати обліковий запис), щоб зробити замовлення.
* Товари згруповані за категоріями.
* Одне замовлення може містити кілька різних товарів у різній кількості.
* Система повинна зберігати історію замовлень та поточний статус кожного з них (наприклад: "Нове", "Відправлено", "Доставлено").

---

## 2. Сутності та їхні атрибути

* **Customer (Клієнт)**
  * `CustomerID` (Primary Key)
  * `FirstName` (Ім'я)
  * `LastName` (Прізвище)
  * `Email` (Унікальний)
  * `Phone` (Телефон)
  * `RegistrationDate` (Дата реєстрації)

* **Category (Категорія)**
  * `CategoryID` (Primary Key)
  * `CategoryName` (Назва категорії, унікальна)

* **Product (Товар)**
  * `ProductID` (Primary Key)
  * `CategoryID` (Foreign Key)
  * `Name` (Назва товару)
  * `Description` (Опис)
  * `Price` (Ціна, > 0)
  * `StockQuantity` (Кількість на складі, >= 0)

* **Order (Замовлення)**
  * `OrderID` (Primary Key)
  * `CustomerID` (Foreign Key)
  * `OrderDate` (Дата та час замовлення)
  * `Status` (Статус замовлення)
  * `TotalAmount` (Загальна сума)

* **OrderItem (Деталі замовлення)** — *асоціативна сутність для зв'язку "багато-до-багатьох".*
  * `OrderItemID` (Primary Key)
  * `OrderID` (Foreign Key)
  * `ProductID` (Foreign Key)
  * `Quantity` (Кількість замовленого товару, > 0)
  * `UnitPrice` (Ціна за одиницю на момент покупки)

---

## 3. Опис зв'язків
* **Customer ↔ Order (1 до багатьох):** Один клієнт може зробити багато замовлень, але кожне замовлення належить лише одному клієнту.
* **Category ↔ Product (1 до багатьох):** В одній категорії може бути багато товарів, але кожен товар належить лише до однієї категорії.
* **Order ↔ Product (багато до багатьох):** Одне замовлення може містити багато товарів, а один товар може фігурувати у багатьох замовленнях. Реалізується через проміжну сутність **OrderItem**.
  * *Order ↔ OrderItem (1 до багатьох)*
  * *Product ↔ OrderItem (1 до багатьох)*

---

## 4. Припущення та обмеження
1. Гість не може оформити замовлення без створення профілю.
2. Ціна товару та кількість на складі не можуть бути від'ємними.
3. Атрибут `UnitPrice` в `OrderItem` фіксує ціну товару *на момент покупки*, щоб майбутні зміни цін не вплинули на історію старих замовлень.

---

## 5. ER-діаграма (Концептуальна схема)

```mermaid
erDiagram
    CUSTOMER ||--o{ ORDER : "робить"
    CATEGORY ||--o{ PRODUCT : "містить"
    ORDER ||--|{ ORDER_ITEM : "включає"
    PRODUCT ||--o{ ORDER_ITEM : "є частиною"

    CUSTOMER {
        int CustomerID PK
        string FirstName
        string LastName
        string Email
        string Phone
        datetime RegistrationDate
    }
    CATEGORY {
        int CategoryID PK
        string CategoryName
    }
    PRODUCT {
        int ProductID PK
        int CategoryID FK
        string Name
        string Description
        decimal Price
        int StockQuantity
    }
    ORDER {
        int OrderID PK
        int CustomerID FK
        datetime OrderDate
        string Status
        decimal TotalAmount
    }
    ORDER_ITEM {
        int OrderItemID PK
        int OrderID FK
        int ProductID FK
        int Quantity
        decimal UnitPrice
    }
