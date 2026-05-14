# Лабораторна робота №6: Міграції баз даних та еволюція схеми

**Студент:** Чігарев Олександр  
**Тема:** Керування змінами у структурі БД за допомогою SQL-міграцій та ORM Prisma.

## 1. Мета роботи
Навчитися вносити зміни в існуючу структуру бази даних (Schema Evolution) без втрати даних, використовуючи механізми міграцій. Ознайомитися з принципами роботи ORM Prisma для опису моделей даних.

## 2. Опис внесених змін
У ході лабораторної роботи було реалізовано дві основні зміни в архітектурі бази даних інтернет-магазину:

1.  **Додавання поля знижки:** У таблицю `Product` додано стовпець `Discount` для підтримки акційних пропозицій.
2.  **Створення системи відгуків:** Розроблено нову таблицю `ProductReview`, яка пов'язана з товарами (`Product`) та клієнтами (`Customer`) для збереження рейтингів та коментарів.

## 3. SQL-код міграції
Для реалізації змін у середовищі PostgreSQL через pgAdmin 4 було виконано наступний скрипт:

```sql
-- 1. Модифікація таблиці товарів
ALTER TABLE Product 
ADD COLUMN Discount NUMERIC(5, 2) DEFAULT 0;

-- 2. Створення таблиці відгуків
CREATE TABLE ProductReview (
    ReviewID SERIAL PRIMARY KEY,
    ProductID INTEGER REFERENCES Product(ProductID),
    CustomerID INTEGER REFERENCES Customer(CustomerID),
    Rating INTEGER CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Оновлення даних (приклад застосування бізнес-логіки)
UPDATE Product SET Discount = 10.00 WHERE Name LIKE '%iPhone%';
```

## 4. Опис моделі Prisma (schema.prisma)
```prisma
model Product {
  id         Int             @id @default(autoincrement())
  name       String
  price      Decimal
  discount   Decimal         @default(0)
  categoryId Int
  reviews    ProductReview[]
}

model ProductReview {
  id         Int      @id @default(autoincrement())
  productId  Int
  customerId Int
  rating     Int
  comment    String?
  createdAt  DateTime @default(now())
  product    Product  @relation(fields: [productId], references: [id])
}
```
## 5. Верифікація результатів
Успішність виконання міграції підтверджується скріншотами, розміщеними у папці src/:

1.png: Підтвердження успішного виконання SQL-запитів у pgAdmin.

2.png: Відображення структури таблиці Product з новою колонкою Discount.

3.png: Перевірка наявності нової таблиці ProductReview у схемі бази даних.

## Висновок
Під час виконання роботи було освоєно процес еволюції схеми бази даних. Використання міграцій дозволило розширити функціонал існуючої системи (додати знижки та систему відгуків), зберігаючи цілісність зв'язків між таблицями.
