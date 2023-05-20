-- Adminer 4.8.1 MySQL 5.7.36-39 dump
---
---Полный дамп БД
---
SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

---Структура таблицы `Categories`

DROP TABLE IF EXISTS `Categories`;
CREATE TABLE `Categories` (
  `id` int(11) NOT NULL COMMENT 'Уникальный идентификатор категории',
  `name` varchar(50) NOT NULL COMMENT 'Наименование категории',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

---Заполенение таблицы `Categories` данными 

INSERT INTO `Categories` (`id`, `name`) VALUES
(1,	'Телевизоры'),
(2,	'Холодильники'),
(3,	'Плиты'),
(4,	'Стиральные машины');

---Структура таблицы `Customers`

DROP TABLE IF EXISTS `Customers`;
CREATE TABLE `Customers` (
  `id` int(11) NOT NULL COMMENT 'Уникальный идентификатор покупателя',
  `name` varchar(100) NOT NULL COMMENT 'Имя покупателя',
  `address` varchar(200) DEFAULT NULL COMMENT 'Адрес покупателя',
  `phone` varchar(20) DEFAULT NULL COMMENT 'Телефон покупателя',
  `email` varchar(100) DEFAULT NULL COMMENT 'Email покупателя',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

---Заполенение таблицы `Customers` данными 

INSERT INTO `Customers` (`id`, `name`, `address`, `phone`, `email`) VALUES
(1,	'John Smith',	'789 Oak St, Anytown, USA',	'+1-555-555-1234',	'john@example.com'),
(2,	'Jane Doe',	'456 Pine St, Anytown, USA',	'+1-555-555-5678',	'jane@example.com');

---Структура таблицы `Employees`

DROP TABLE IF EXISTS `Employees`;
CREATE TABLE `Employees` (
  `id` int(11) NOT NULL COMMENT 'Уникальный идентификатор сотрудника',
  `name` varchar(100) NOT NULL COMMENT 'Имя сотрудника',
  `position` varchar(50) DEFAULT NULL COMMENT 'Должность сотрудника',
  `hire_date` date DEFAULT NULL COMMENT 'Дата приема на работу',
  `salary` decimal(10,2) DEFAULT NULL COMMENT 'Зарплата сотрудника',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

---Заполенение таблицы `Employees` данными 

INSERT INTO `Employees` (`id`, `name`, `position`, `hire_date`, `salary`) VALUES
(1,	'Michael Johnson',	'Sales Associate',	'2020-01-01',	50000.00),
(2,	'Emily Davis',	'Store Manager',	'2018-03-15',	80000.00);

---Структура таблицы `Products`

DROP TABLE IF EXISTS `Products`;
CREATE TABLE `Products` (
  `id` int(11) NOT NULL COMMENT 'Уникальный идентификатор продукта',
  `name` varchar(100) NOT NULL COMMENT 'Наименование продукта',
  `category_id` int(11) DEFAULT NULL COMMENT 'Идентификатор категории',
  `supplier_id` int(11) DEFAULT NULL COMMENT 'Идентификатор поставщика',
  `price` decimal(10,2) DEFAULT NULL COMMENT 'Цена продукта',
  `stock_quantity` int(11) DEFAULT NULL COMMENT 'Количество на складе',
  PRIMARY KEY (`id`),
  KEY `fk_products_category` (`category_id`),
  KEY `fk_products_supplier` (`supplier_id`),
  CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `Categories` (`id`),
  CONSTRAINT `fk_products_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `Suppliers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

---Заполенение таблицы `Products` данными 

INSERT INTO `Products` (`id`, `name`, `category_id`, `supplier_id`, `price`, `stock_quantity`) VALUES
(1,	'Samsung QLED 55\" TV',	1,	1,	1499.99,	10),
(2,	'LG OLED 65\" TV',	1,	2,	1999.99,	5),
(3,	'Samsung French Door Refrigerator',	2,	1,	2499.99,	3),
(4,	'LG Side-by-Side Refrigerator',	2,	2,	1799.99,	8);

---Структура таблицы `Sales`

DROP TABLE IF EXISTS `Sales`;
CREATE TABLE `Sales` (
  `id` int(11) NOT NULL COMMENT 'Уникальный идентификатор продажи',
  `product_id` int(11) DEFAULT NULL COMMENT 'Идентификатор продукта',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Идентификатор покупателя',
  `employee_id` int(11) DEFAULT NULL COMMENT 'Идентификатор сотрудника',
  `sale_date` date DEFAULT NULL COMMENT 'Дата продажи',
  `quantity` int(11) DEFAULT NULL COMMENT 'Количество проданных продуктов',
  `price` decimal(10,2) DEFAULT NULL COMMENT 'Цена продажи',
  PRIMARY KEY (`id`),
  KEY `fk_sales_product` (`product_id`),
  KEY `fk_sales_customer` (`customer_id`),
  KEY `fk_sales_employee` (`employee_id`),
  CONSTRAINT `fk_sales_customer` FOREIGN KEY (`customer_id`) REFERENCES `Customers` (`id`),
  CONSTRAINT `fk_sales_employee` FOREIGN KEY (`employee_id`) REFERENCES `Employees` (`id`),
  CONSTRAINT `fk_sales_product` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

---Заполенение таблицы `Sales` данными 

INSERT INTO `Sales` (`id`, `product_id`, `customer_id`, `employee_id`, `sale_date`, `quantity`, `price`) VALUES
(1,	1,	1,	1,	'2023-05-01',	2,	2999.98),
(2,	3,	2,	1,	'2023-05-02',	1,	2499.99);

---Структура таблицы `Suppliers`

DROP TABLE IF EXISTS `Suppliers`;
CREATE TABLE `Suppliers` (
  `id` int(11) NOT NULL COMMENT 'Уникальный идентификатор поставщика',
  `name` varchar(100) NOT NULL COMMENT 'Наименование поставщика',
  `address` varchar(200) DEFAULT NULL COMMENT 'Адрес поставщика',
  `phone` varchar(20) DEFAULT NULL COMMENT 'Телефон поставщика',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

---Заполенение таблицы `Suppliers` данными 

INSERT INTO `Suppliers` (`id`, `name`, `address`, `phone`) VALUES
(1,	'Samsung Electronics',	'123 Main St, Anytown, USA',	'+1-555-123-4567'),
(2,	'LG Electronics',	'456 Elm St, Anytown, USA',	'+1-555-987-6543');

-- 2023-05-19 15:50:49