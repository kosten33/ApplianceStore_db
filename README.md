# Проектирование базы данных для магазина бытовой техники

## Описание

База данных "Магазин бытовой техники" предназначена для автоматизации деятельности магазина, специализирующегося на продаже бытовой техники. Она помогает эффективно управлять информацией о клиентах, поставщиках, продуктах, продажах, категориях и сотрудниках, предоставляя ценную информацию и функциональность для успешного ведения бизнеса.

## БД состоит из таблиц:

## Таблица "Products":

Cодержит информацию о продуктах, доступных в магазине бытовой техники.

|    Поле    | Тип данных |                        Описание                        |
|:----------:|:---------:|:-----------------------------------------------------:|
|     id     |    INT    |           Уникальный идентификатор продукта            |
|    name    | VARCHAR |                 Наименование продукта                 |
| category_id |    INT    |                 Идентификатор категории                |
| supplier_id |    INT    |                Идентификатор поставщика                |
|    price   | DECIMAL |                       Цена продукта                    |
|stock_quantity|   INT    |                 Количество на складе                   |

## Таблица "Categories":

Содержит информацию о категориях продуктов. 

|  Поле  | Тип данных |           Описание          |
|:------:|:---------:|:--------------------------:|
|   id   |    INT    |   Уникальный идентификатор  |
|  name  | VARCHAR |      Наименование категории     |

## Таблица "Suppliers":

Cодержит информацию о поставщиках магазина бытовой техники.

|   Поле   | Тип данных |            Описание           |
|:--------:|:---------:|:----------------------------:|
|    id    |    INT    |    Уникальный идентификатор   |
|   name   | VARCHAR |       Наименование поставщика       |
| address  | VARCHAR |         Адрес поставщика         |
|   phone  | VARCHAR |          Телефон поставщика         |

## Таблица "Sales":

Cодержит информацию о продажах продуктов в магазине. 

|    Поле    | Тип данных |                      Описание                     |
|:----------:|:---------:|:------------------------------------------------:|
|     id     |    INT    |          Уникальный идентификатор продажи          |
| product_id |    INT    |                 Идентификатор продукта            |
| customer_id|    INT    |                 Идентификатор покупателя          |
| employee_id|    INT    |                 Идентификатор сотрудника           |
| sale_date  |    DATE   |                    Дата продажи                   |
|  quantity  |    INT    |                 Количество проданных продуктов     |
|   price    | DECIMAL   |                    Цена продажи                 |

## Таблица "Customers":

Cодержит информацию о клиентах магазина бытовой техники.

|   Поле   | Тип данных |               Описание              |
|:--------:|:---------:|:----------------------------------:|
|    id    |    INT    |       Уникальный идентификатор      |
|   name   | VARCHAR(100) |          Имя покупателя            |
| address  | VARCHAR(200) |          Адрес покупателя           |
|   phone  | VARCHAR(20)  |          Телефон покупателя         |
|   email  | VARCHAR(100) |           Email покупателя          |

## Таблица "Employees":

Содержит информацию о сотрудниках магазина бытовой техники.

|    Поле    | Тип данных |                Описание               |
|:----------:|:---------:|:------------------------------------:|
|     id     |   INT   |         Уникальный идентификатор      |
|    name    | VARCHAR |            Имя сотрудника            |
|  position  | VARCHAR |         Должность сотрудника          |
| hire_date  |    DATE |          Дата приема на работу        |
|   salary   | DECIMAL |             Зарплата сотрудника       |


## Взаимосвязи:

![image]()

* Каждый продукт относится к одной категории, но одна категория может содержать множество продуктов.

* Каждый продукт имеет одного поставщика, но один поставщик может поставлять множество продуктов.

* Каждая продажа относится к одному продукту, но один продукт может быть продан несколько раз.

* Каждая продажа совершается одним покупателем, но один покупатель может совершить несколько покупок.

* Каждая продажа связана с одним сотрудником, но один сотрудник может совершить несколько продаж.

## Представления

1. Это представление объединяет таблицы "Products", "Categories" и "Sales" и предоставляет информацию о продажах продуктов.

```sql
CREATE VIEW ProductSalesView AS
SELECT p.id AS product_id, p.name AS product_name, c.name AS category_name, s.sale_date, s.quantity, s.price
FROM Products p
JOIN Categories c ON p.category_id = c.id
JOIN Sales s ON p.id = s.product_id;
```

2. Это представление объединяет таблицы "Customers", "Sales" и "Products" и предоставляет информацию о продажах, связанных с конкретными клиентами.

```sql
CREATE VIEW CustomerSalesView AS
SELECT c.id AS customer_id, c.name AS customer_name, p.name AS product_name, s.sale_date, s.quantity, s.price
FROM Customers c
JOIN Sales s ON c.id = s.customer_id
JOIN Products p ON s.product_id = p.id;
```

3. Это представление объединяет таблицы "Employees", "Sales" и "Products" и предоставляет информацию о продажах, связанных с определенными сотрудниками. 

```sql
CREATE VIEW EmployeeSalesView AS
SELECT e.id AS employee_id, e.name AS employee_name, p.name AS product_name, s.sale_date, s.quantity, s.price
FROM Employees e
JOIN Sales s ON e.id = s.employee_id
JOIN Products p ON s.product_id = p.id;
```

## Создание таблиц:

```sql
---Создание таблицы "Products"
CREATE TABLE Products (
    id INT PRIMARY KEY COMMENT 'Уникальный идентификатор продукта',
    name VARCHAR(100) NOT NULL COMMENT 'Наименование продукта',
    category_id INT COMMENT 'Идентификатор категории',
    supplier_id INT COMMENT 'Идентификатор поставщика',
    price DECIMAL(10, 2) COMMENT 'Цена продукта',
    stock_quantity INT COMMENT 'Количество на складе'
);

---Создание таблицы "Categories"
CREATE TABLE Categories (
    id INT PRIMARY KEY COMMENT 'Уникальный идентификатор категории',
    name VARCHAR(50) NOT NULL COMMENT 'Наименование категории'
);

---Создание таблицы "Suppliers"
CREATE TABLE Suppliers (
    id INT PRIMARY KEY COMMENT 'Уникальный идентификатор поставщика',
    name VARCHAR(100) NOT NULL COMMENT 'Наименование поставщика',
    address VARCHAR(200) COMMENT 'Адрес поставщика',
    phone VARCHAR(20) COMMENT 'Телефон поставщика'
);

---Создание таблицы "Sales"
CREATE TABLE Sales (
    id INT PRIMARY KEY COMMENT 'Уникальный идентификатор продажи',
    product_id INT COMMENT 'Идентификатор продукта',
    customer_id INT COMMENT 'Идентификатор покупателя',
    employee_id INT COMMENT 'Идентификатор сотрудника',
    sale_date DATE COMMENT 'Дата продажи',
    quantity INT COMMENT 'Количество проданных продуктов',
    price DECIMAL(10, 2) COMMENT 'Цена продажи'
);

---Создание таблицы "Customers"
CREATE TABLE Customers (
    id INT PRIMARY KEY COMMENT 'Уникальный идентификатор покупателя',
    name VARCHAR(100) NOT NULL COMMENT 'Имя покупателя',
    address VARCHAR(200) COMMENT 'Адрес покупателя',
    phone VARCHAR(20) COMMENT 'Телефон покупателя',
    email VARCHAR(100) COMMENT 'Email покупателя'
);

---Создание таблицы "Employees"
CREATE TABLE Employees (
    id INT PRIMARY KEY COMMENT 'Уникальный идентификатор сотрудника',
    name VARCHAR(100) NOT NULL COMMENT 'Имя сотрудника',
    position VARCHAR(50) COMMENT 'Должность сотрудника',
    hire_date DATE COMMENT 'Дата приема на работу',
    salary DECIMAL(10, 2) COMMENT 'Зарплата сотрудника'
);
```


## Создание взаимосвязей:

```sql
---Добавление внешнего ключа category_id в таблицу Products
ALTER TABLE Products
ADD CONSTRAINT fk_products_category
FOREIGN KEY (category_id) REFERENCES Categories(id);

---Добавление внешнего ключа supplier_id в таблицу Products
ALTER TABLE Products
ADD CONSTRAINT fk_products_supplier
FOREIGN KEY (supplier_id) REFERENCES Suppliers(id);

---Добавление внешнего ключа product_id в таблицу Sales
ALTER TABLE Sales
ADD CONSTRAINT fk_sales_product
FOREIGN KEY (product_id) REFERENCES Products(id);

---Добавление внешнего ключа customer_id в таблицу Sales
ALTER TABLE Sales
ADD CONSTRAINT fk_sales_customer
FOREIGN KEY (customer_id) REFERENCES Customers(id);

---Добавление внешнего ключа employee_id в таблицу Sales
ALTER TABLE Sales
ADD CONSTRAINT fk_sales_employee
FOREIGN KEY (employee_id) REFERENCES Employees(id);
```


# Примеры SQL запросов для типовых операций:

```sql
---Создание записи в таблице Customers
INSERT INTO Customers (id, name, address, phone, email) VALUES
    (1, 'John Smith', '789 Oak St, Anytown, USA', '+1-555-555-1234', 'johny142@example.com');

---Создает новую запись в таблице Customers с указанными данными о клиенте.

---Изменение записи в таблице Customers
UPDATE Customers SET email = 'john@example.com' WHERE id = 1;

---Изменяет существующую запись в таблице Customers, обновляя значение email для указанного клиента.

---Удаление записи из таблицы Customers
DELETE FROM Customers WHERE id = 1;

---Удаляет указанную запись из таблицы Customers на основе заданного идентификатора клиента.

---Создание записи в таблице Suppliers
INSERT INTO Suppliers (id, name, address, phone) VALUES
    (1, 'Samsung Electronics', '123 Main St, Anytown, USA', '+1-555-123-4567');

---Создает новую запись в таблице Suppliers с указанными данными о поставщике.

---Изменение записи в таблице Suppliers

UPDATE Suppliers SET phone = '+1-555-666-4567' WHERE id = 1;

---Изменяет существующую запись в таблице Suppliers, обновляя значение телефона для указанного поставщика.

---Удаление записи из таблицы Suppliers
DELETE FROM Suppliers WHERE id = 1;

---Удаляет указанную запись из таблицы Suppliers на основе заданного идентификатора поставщика.

---Создание записи в таблице Products
INSERT INTO Products (id, name, category_id, supplier_id, price, stock_quantity) VALUES
    (1, 'Samsung QLED 55" TV', 1, 1, 1499.99, 10);

---Создает новую запись в таблице Products с указанными данными о продукте.

---Изменение записи в таблице Products
UPDATE Products SET stock_quantity = '8' WHERE id = 1;

---Изменяет существующую запись в таблице Products, обновляя значение количества на складе для указанного продукта.

---Удаление записи из таблицы Products
DELETE FROM Products WHERE id = 1;

---Удаляет указанную запись из таблицы Products на основе заданного идентификатора продукта.

---Создание записи в таблице Sales
INSERT INTO Sales (id, product_id, customer_id, employee_id, sale_date, quantity, price) VALUES
    (1, 1, 1, 1, '2023-05-01', 2, 2999.98);

---Создает новую запись в таблице Sales с указанными данными о продаже.

---Изменение записи в таблице Sales
UPDATE Sales SET quantity = '4' WHERE id = 1;

---Изменяет существующую запись в таблице Sales, обновляя значение количества продаж для указанной записи.

---Удаление записи из таблицы Sales
DELETE FROM Sales WHERE id = 1;

---Удаляет указанную запись из таблицы Sales на основе заданного идентификатора продажи.
```
