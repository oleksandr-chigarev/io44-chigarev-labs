-- Додаємо поле знижки
ALTER TABLE Product ADD COLUMN Discount NUMERIC(5, 2) DEFAULT 0;

-- Створюємо таблицю відгуків
CREATE TABLE ProductReview (
    ReviewID SERIAL PRIMARY KEY,
    ProductID INTEGER REFERENCES Product(ProductID),
    CustomerID INTEGER REFERENCES Customer(CustomerID),
    Rating INTEGER CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
