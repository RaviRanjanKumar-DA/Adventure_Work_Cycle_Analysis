##	Question 1	##

CREATE TABLE Salespeople (
snum INT PRIMARY KEY,
sname VARCHAR(20),
city VARCHAR(20),
comm DECIMAL(4,2)
);
INSERT INTO Salespeople VALUES
(1001,'Peel', 'London', .12),
(1002, 'Serres', 'San Jose', .13),
(1003, 'Axelrd', 'New York', .10),
(1004, 'Motika', 'London', .11),
(1007, 'Rafkin', 'Barcelona', .15)
;
SELECT * FROM Salespeople;


##	Question 2	##

CREATE TABLE Cust (
cnum INT PRIMARY KEY,
cname VARCHAR(20),
city VARCHAR(20),
rating INT(3),
snum INT,
FOREIGN KEY (snum) REFERENCES salespeople(snum)
);

INSERT INTO Cust VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanne', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 300, 1002),
(2004, 'Grass', 'Berlin', 100, 1002),
(2006, 'Clemens', 'London', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004),
(2008, 'James', 'London', 200, 1007)
;
SELECT * FROM Cust;

##	Question 3	##

CREATE TABLE Orders (
onum INT PRIMARY KEY,
amt DECIMAL(6,2),
odate DATE,
cnum INT,
snum INT,

FOREIGN KEY (cnum) REFERENCES Cust(cnum),
FOREIGN KEY (snum) REFERENCES Salespeople(snum)
);

INSERT INTO Orders VALUES
(3001, 18.69, '1994-10-03', 2008, 1007),
(3002, 1900.10, '1994-10-03', 2007, 1004),
(3003, 767.19, '1994-10-03', 2001, 1001),
(3005, 5160.45, '1994-10-03', 2003, 1002),
(3006, 1098.16, '1994-10-04', 2008, 1007),
(3007, 75.75, '1994-10-05', 2004, 1002),
(3008, 4723, '1994-10-05', 2006, 1001),
(3009, 1713.23, '1994-10-04', 2002, 1003),
(3010, 1309.95, '1994-10-06', 2004, 1002),
(3011, 9891.88, '1994-10-06', 2006, 1001)
;

SELECT * FROM Orders;

##	Question 4	##
SELECT s.sname AS "Salesman", c.cname, c.city 
FROM salespeople s, Cust c 
WHERE s.city = c.city;

##	Question 5	##
SELECT c.cname, s.sname FROM Cust c, Salespeople s
WHERE s.snum = c.snum;

##	Question 6	##
SELECT onum, cname, orders.cnum, orders.snum
FROM salespeople, cust, orders
WHERE cust.city <> salespeople.city
AND orders.cnum = cust.cnum
AND orders.snum = salespeople.snum;

##	Question 7	##
SELECT Orders.onum, cust.cnum, cust.cname FROM orders, cust
WHERE orders.cnum = cust.cnum;

##	Question 8	##
SELECT * FROM cust order by rating;

##	Question 9	##
# Write a query to find out all pairs of customers served by a single salesperson
SELECT * FROM cust 
WHERE snum IN (SELECT snum FROM cust GROUP BY snum HAVING COUNT(cnum) = 1);

##	Question 10	##
# Write a query that produces all pairs of salespeople who are living in same city
SELECT m.sname, n.sname, m.city 
	FROM salespeople m, salespeople n
	WHERE m.city = n.city AND m.sname < n.sname;

##	Question 11	##
# Write a Query to find all orders credited to the same salesperson who services Customer 2008
SELECT * FROM orders 
WHERE cnum = 2008;

##	Question 12	##
# Write a Query to find out all orders that are greater than the average for Oct 4th
SELECT  AVG(amt) FROM orders
     WHERE odate ='1994-10-04';
     
SELECT * FROM orders
WHERE amt >
    (SELECT  AVG(amt) FROM orders 
     WHERE odate ='1994-10-04');

##	Question 13	##
# Write a Query to find all orders attributed to salespeople in London.
SELECT snum FROM salespeople
		WHERE city ='London';
        
SELECT * FROM orders
	WHERE snum IN
		(SELECT snum FROM salespeople
		WHERE city ='London');

##	Question 14	##
# Write a query to find all the customers whose cnum is 1000 above the snum of Serres.
SELECT snum FROM salespeople
WHERE sname = 'Serres';

SELECT * FROM cust
WHERE cnum > (1000 + 
	(SELECT snum FROM salespeople
	WHERE sname = 'Serres'));

##	Question 15	##
# Write a query to count customers with ratings above San Jose’s average rating.
SELECT AVG(rating) FROM cust
WHERE city = 'San Jose';

SELECT COUNT(cnum) FROM cust
WHERE rating > (SELECT AVG(rating) FROM cust
				WHERE city = 'San Jose');


##	Question 16	##
# Write a query to show each salesperson with multiple customers.
  
SELECT * FROM cust 
WHERE snum IN (SELECT snum FROM cust GROUP BY snum HAVING COUNT(cnum) > 1);

