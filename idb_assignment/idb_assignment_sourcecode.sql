-------------------------------------------------------------------------------

-- CREATE DATABASE idb_assignment;						-- To Create Database
USE idb_assignment;									-- To Use Database

-------------------------------------------------------------------------------

-- DROP TABLE members;

-- 1
CREATE TABLE members (
	member_id INT PRIMARY KEY AUTO_INCREMENT, 
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR (50)
);

-- 2
CREATE TABLE member_contact ( 
	contact_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT NOT NULL,
    email VARCHAR(50) NOT NULL, 
    phone INT NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- 3
CREATE TABLE member_address (
	address_id INT PRIMARY KEY AUTO_INCREMENT,
	member_id INT NOT NULL, 
    address VARCHAR(50) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- 4
CREATE TABLE publishers (
	publisher_id INT PRIMARY KEY AUTO_INCREMENT, 
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR (50)
);

-- 5
CREATE TABLE book (
	book_id INT PRIMARY KEY AUTO_INCREMENT,
	serial_number VARCHAR(50) NOT NULL,
    title VARCHAR(50) NOT NULL,
	price DECIMAL(6,2) NOT NULL,									-- max = 9999.99
    quantity INT NOT NULL,
    publisher_id INT NOT NULL, 
    published_date DATE NOT NULL,
    FOREIGN KEY (publisher_id) REFERENCES publishers (publisher_id)
);

-- 6
CREATE TABLE member_order (
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    order_date DATE NOT NULL, 
    order_quantity INT NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- 7
CREATE TABLE delivery(
	delivery_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    delivery_date DATE NOT NULL, 
    address_id INT NOT NULL,
    contact_id INT NOT NULL,
    delivery_status VARCHAR(50) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES member_order(order_id),
    FOREIGN KEY (address_id) REFERENCES member_address (address_id),
    FOREIGN KEY (contact_id) REFERENCES member_contact(contact_id)
);

-- 8
CREATE TABLE book_review (
	review_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    book_rating DECIMAL(2,1) NOT NULL, 							-- max = 5.0
    book_comment VARCHAR(200), 
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- 9
CREATE TABLE managers (
	manager_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR (50)
);

-- 10
CREATE TABLE manager_order (
	order_id INT PRIMARY KEY AUTO_INCREMENT, 
    manager_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL, 
    publisher_id  INT NOT NULL,
    FOREIGN KEY (manager_id) REFERENCES managers(manager_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (publisher_id) REFERENCES publishers (publisher_id)
);

-------------------------------------------------------------------------------

--- INSERT DATA	

-- 1
INSERT INTO members (first_name, last_name) 
VALUES 	('Mike', 'Adam'), 
		('Steven', 'Lee'), 
        ('Stephanie', 'Eliz'), 
        ('Sean', 'Louis'), 
        ('Sebastian', 'Stan');
SELECT * FROM members;

-- 2
INSERT INTO member_contact (member_id, email, phone) 
VALUES 	(1, 'mike_a@mail.com', '195077315'), 
		(2, 'steven_l@mail.com', '197556256'), 
        (3, 'stephanie_99@mail.com', '197793021'),
        (4, 'sean_louis12@mail.com', '198053772'), 
        (5, 'sebastianstan_22@mail.com', '190853741');
SELECT * FROM member_contact;

-- 3
INSERT INTO member_address (member_id, address) 
VALUES	(1 , 'Kuantan Raya Q/11 Street'), 
		(2, 'Selakaso L/42 Street'),
		(3 , 'Sri Petaling (Endah Ria)'),
		(4 , 'Sri Petaling (Endah Villa)'),
		(5 , 'Parkhill residence C/08');
SELECT * FROM member_address;

-- 4
INSERT INTO publishers (first_name, last_name) 
VALUES	('Andy', 'Paul'), 
		('Jack', 'Owen'), 
        ('Michael', 'Myers'),
        ('Marc', 'Spector'), 
        ('Robert', 'Junior');
SELECT * FROM publishers;

-- 5
INSERT INTO book (serial_number, title, price, quantity, publisher_id, published_date) 
VALUES	('BOOK01', 'The tale of Percy Jackson', 90.00, 50, 1, '2005-07-28'), 
		('BOOK02', 'The Second Life', 		85.00, 100, 2, '2010-07-30'),
        ('BOOK03', 'Maze Runner' , 			60.00, 70, 3, '2015-08-28'),
        ('BOOK04', 'Megalodon' , 			120.00, 60, 4, '2009-04-21'), 
        ('BOOK05', 'Christmas Terror' , 	85.50, 75, 3, '2020-05-12');
SELECT * FROM managers;

-- 6
INSERT INTO member_order (member_id, book_id, order_date, order_quantity) 
VALUES	(1, 1, '2023-07-28', 1), 
		(2, 2, '2023-07-28', 2), 
        (3, 2, '2023-07-29', 1), 
        (4, 2, '2023-07-29', 1), 
        (5, 4, '2023-07-29', 2);
SELECT * FROM member_order;

-- 7
INSERT INTO delivery (order_id, delivery_date, address_id, contact_id, delivery_status) 
VALUES	(1 , '2023-08-01' ,1 , 1, 'Not Delivered'), 
		(2, '2023-08-01' ,2 , 2, 'On Going') ,
        (3, '2023-08-01' ,3 , 3, 'On Going') , 
        (4,  '2023-08-02' ,4 , 4, 'On Going') ,
        (5, '2023-08-02' ,5 , 5, 'Not Delivered');	
SELECT * FROM delivery;

-- 8 
INSERT INTO book_review (member_id, book_id, book_rating, book_comment)
VALUES	(1, 1, 2.0, 'The book is too boring'), 
		(2, 3, 5.0, 'The book is very interesting'), 
        (3, 1, 4.0, 'The book is good'), 
        (4, 2, 4.0, 'The story in the book is good'), 
        (5, 3, 3.0, 'The book is okay. Need more interesting stuffs');
SELECT * FROM book_review;

-- 9
INSERT INTO managers (first_name, last_name)
VALUES	('Ronaldo', 'Christiano'), 
		('Xin' , 'Rex'), 
        ('Neymar' , 'Junior') , 
        ('Alan', 'Walker') ,
        ('Daniel' , 'Caesar');
SELECT * FROM managers;

-- 10
INSERT INTO manager_order (manager_id, book_id, quantity, publisher_id) 
VALUES
(1 , 1, 5, 1),
(3 , 2, 4, 2), 
(3, 3, 10, 3), 
(5, 4, 10, 3),
(4 , 5, 10, 4);
SELECT * FROM manager_order;

-- --------------------------------------------------------------------------

--  List the book(s) which has the highest rating. Show book id, book name, and the rating.
SELECT book.book_id, book.title, AVG(review.book_rating) AS rating 
FROM book, book_review AS review 
WHERE book.book_id = review.book_id
GROUP BY book.book_id
ORDER BY rating DESC
LIMIT 1;
-- SELECT * FROM book;
-- SELECT * FROM book_review;

-- Find the total number of feedback per member. Show member id, member name, and total number of feedback per member.
SELECT members.member_id, members.first_name, COUNT(review.review_id) AS total_feedback
FROM members, book_review as review
WHERE members.member_id = review.member_id
GROUP BY members.member_id
ORDER BY total_feedback;

SELECT * FROM book_review;

-- Find the total number of book published by each publisher. Show publisher id, publisher name, and number of book published.
SELECT publishers.publisher_id, publishers.first_name , COUNT(book.publisher_id) AS total_book
FROM publishers, book
WHERE book.publisher_id = publishers.publisher_id
GROUP BY publishers.first_name, publishers.publisher_id
ORDER BY total_book;

SELECT * FROM publishers;
SELECT * FROM book;

-- Find the total number of books ordered by store manager from each publisher.
SELECT SUM(mo.quantity) AS quantity, p.first_name
FROM manager_order mo, publishers p
WHERE p.publisher_id = mo.publisher_id
GROUP BY p.first_name;

SELECT * FROM manager_order;
SELECT * FROM publishers;

-- From the book table, list the books where quantity is more than the average quantity of all books. 
SELECT title, quantity
FROM book
WHERE quantity > (
	SELECT AVG (quantity)
    FROM book);

SELECT * FROM book;

-- Find the bestselling book(s).
SELECT b.title, SUM(mo.order_quantity) AS book_sold
FROM book AS b, member_order AS mo
WHERE b.book_id = mo.book_id
GROUP BY b.title
ORDER BY book_sold DESC
LIMIT 1;

SELECT * FROM book;
SELECT * FROM member_order;

-- Show the member(s) who spent most on buying books
SELECT members.first_name, SUM(mo.order_quantity * book.price) AS total_spent
FROM members, member_order AS mo, book
WHERE members.member_id = mo.member_id AND mo.book_id = book.book_id
GROUP BY members.first_name
ORDER BY total_spent DESC
LIMIT 1;

SELECT * FROM members;
SELECT * FROM member_order;
SELECT * FROM book;

-- A list of purchased books that have not been delivered to members. The list should show: 
/* 	- members identification number, 
    - address, 
    - contact number, 
    - book serial number, 
    - book title, 
    - quantity, 
    - date and 
    - status of delivery. */
Select mo.member_id, ma.address, mc.phone, b.serial_number, b.title, mo.order_quantity, d.delivery_date, d.delivery_status
From member_order mo, member_address ma, member_contact mc, book b, delivery d
where d.delivery_status = 'Not Delivered' and 
	ma.member_id = mo.member_id and 
    mc.contact_id = d.contact_id and 
    b.book_id = mo.book_id and
    mo.order_id = d.order_id;
    
SELECT * FROM delivery;
SELECT * FROM member_order;
SELECT * FROM book;
SELECT * FROM member_contact;
SELECT * FROM member_address;

-- Show the members who made more than 2 orders.
SELECT mo.member_id, m.first_name, m.last_name, count(mo.member_id) AS total_order
FROM members AS m, member_order AS mo
WHERE m.member_id = mo.member_id
GROUP BY mo.member_id, m.first_name, m.last_name
HAVING count(mo.member_id) >= 2;

SELECT * FROM member_order;

-- COUNT HOW MANY ORDER WHERE THE TOTAL PRICE IS MORE THAN 100

SELECT mo.order_id, (mo.order_quantity * book.price) AS total_spent
FROM member_order AS mo, book 
WHERE mo.book_id = book.book_id;

SELECT COUNT(*)
FROM member_order mo, book b
WHERE mo.book_id = b.book_id AND (b.price * mo.order_quantity) > 100;

SELECT * FROM member_order;

