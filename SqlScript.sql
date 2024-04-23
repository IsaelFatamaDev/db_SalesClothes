DROP DATABASE IF EXISTS db_SalesClothes;

CREATE DATABASE db_SalesClothes;

USE db_SalesClothes;

CREATE TABLE client (
    id int IDENTITY(1,1),
    type_document char(3),
    number_document char(15),
    names varchar(60),
    last_name varchar(90),
    email varchar(80),
    cell_phone char(9),
    birthdate date,
    active bit,
    CONSTRAINT client_pk PRIMARY KEY  (id)
);

-- Table: clothes
CREATE TABLE clothes (
    id int IDENTITY(1,1),
    description varchar(60),
    brand varchar(60),
    amount int,
    size varchar(10),
    price decimal(8,2),
    active bit,
    sale_detail_id int,
    CONSTRAINT clothes_pk PRIMARY KEY  (id)
);

-- Table: sale
CREATE TABLE sale (
    id int IDENTITY(1,1),
    date_time datetime,
    active bit,
    client_id int,
    seller_id int,
    CONSTRAINT sale_pk PRIMARY KEY  (id)
);

-- Table: sale_detail
CREATE TABLE sale_detail (
    id int IDENTITY(1,1),
    amount int,
    sale_id int,
    CONSTRAINT sale_detail_pk PRIMARY KEY  (id)
);

-- Table: seller
CREATE TABLE seller (
    id int IDENTITY(1,1),
    type_document char(3),
    number_document char(15),
    names varchar(60),
    last_name varchar(90),
    salary decimal(8,2),
    cell_phone char(9),
    email varchar(80),
    active bit,
    CONSTRAINT seller_pk PRIMARY KEY  (id)
);

-- foreign keys
-- Reference: clothes_sale_detail (table: clothes)
ALTER TABLE clothes ADD CONSTRAINT clothes_sale_detail
    FOREIGN KEY (sale_detail_id)
    REFERENCES sale_detail (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;

-- Reference: sale_client (table: sale)
ALTER TABLE sale ADD CONSTRAINT sale_client
    FOREIGN KEY (client_id)
    REFERENCES client (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;

-- Reference: sale_detail_sale (table: sale_detail)
ALTER TABLE sale_detail ADD CONSTRAINT sale_detail_sale
    FOREIGN KEY (sale_id)
    REFERENCES sale (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;

-- Reference: sale_seller (table: sale)
ALTER TABLE sale ADD CONSTRAINT sale_seller
    FOREIGN KEY (seller_id)
    REFERENCES seller (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;


SELECT * FROM INFORMATION_SCHEMA.TABLES;
EXEC sp_columns @table_name = 'client';

SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
GO

ALTER TABLE client
	DROP CONSTRAINT client_pk
GO

DROP TABLE sale_detail;


