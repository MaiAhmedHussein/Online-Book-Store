CREATE SCHEMA LIBRARY;

USE LIBRARY;

CREATE TABLE PUBLISHER(
	id INT,
	`name` VARCHAR(30) NOT NULL,
    address VARCHAR(30) NOT NULL,
    phone VARCHAR(12) NOT NULL UNIQUE,
    CONSTRAINT PUBPK 
		PRIMARY KEY(id)
	
);

CREATE TABLE `USER`(
	id INT,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    email VARCHAR(30) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    manager BIT(1) DEFAULT 0,
    CONSTRAINT USERPK 
		PRIMARY KEY(id)
);

CREATE TABLE BOOK(
	ISBN INT,
    title VARCHAR(100) UNIQUE,
    publisherId INT NOT NULL,
    authors VARCHAR(500) NOT NULL,
    publicationYear CHAR(4),
    coverImage VARCHAR(7000),
    price INT NOT NULL,
    CONSTRAINT PRICE_RANGE CHECK (PRICE >= 0),
    category ENUM('Science','Art','Religion','History','Geography') NOT NULL,
	threshold INT NOT NULL,
    stockQuantity INT NOT NULL,
	CONSTRAINT THRESHOLD_RANGE CHECK (threshold >= 0),
    CONSTRAINT BPK
		PRIMARY KEY(ISBN),
	CONSTRAINT PUBFK
		FOREIGN KEY(publisherId) REFERENCES PUBLISHER(id)
			ON UPDATE CASCADE ON DELETE RESTRICT 
);

-- CREATE TABLE BOOK_AUTHORS(
-- 	ISBN INT NOT NULL,
-- 	authorName VARCHAR(30) NOT NULL,
--     CONSTRAINT APK 
-- 		PRIMARY KEY(ISBN, authorName),
-- 	CONSTRAINT AFK
-- 		FOREIGN KEY(ISBN) REFERENCES BOOK(ISBN)
-- 			ON UPDATE RESTRICT ON DELETE CASCADE
-- );

CREATE TABLE STOCK_ORDER(
	id INT NOT NULL,
	ISBN INT NOT NULL,
	quantity INT NULL,
    CONSTRAINT ORDERPK
		PRIMARY KEY(id),
	CONSTRAINT ORDER_BOOK_FK
		FOREIGN KEY(ISBN) REFERENCES BOOK(ISBN)
			ON UPDATE RESTRICT ON DELETE CASCADE
);

CREATE TABLE CUSTOMER_ORDER(
	id INT,
    userId INT NOT NULL,
    CONSTRAINT CARTPK
		PRIMARY KEY(id),
	CONSTRAINT CUSTOMER_ORDER_USER_FK
		FOREIGN KEY(userId) REFERENCES USER(id)
);

CREATE TABLE CUSTOMER_ORDER_ITEM(
	ISBN INT NOT NULL,
    copies INT NOT NULL,
	customerOrderId INT NOT NULL,
    CONSTRAINT ITEMPK
		PRIMARY KEY(ISBN, customerOrderId),
	CONSTRAINT ITEM_BOOK_FK
		FOREIGN KEY(ISBN) REFERENCES BOOK(ISBN)
			ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT CUSTOMER_ORDER_FK
		FOREIGN KEY(customerOrderId) REFERENCES CUSTOMER_ORDER(id)
			ON UPDATE RESTRICT ON DELETE CASCADE
);

ALTER TABLE PUBLISHER ADD INDEX nameIndex(`name`);

ALTER TABLE BOOK ADD INDEX categoryIndex(category);




