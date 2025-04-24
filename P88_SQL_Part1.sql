DROP DATABASE p88;
CREATE DATABASE P88;
USE  P88;

##	Question 2	##

CREATE TABLE dept (
  deptno int NOT NULL,
  dname varchar(25) DEFAULT NULL,
  loc varchar(25) DEFAULT NULL,
  PRIMARY KEY (deptno)
);

INSERT INTO dept VALUES
(10, 'OPERATION', 'BOSTON'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'ACCOUNTING', 'NEW YOURK');

SELECT * FROM dept;

##	Question 1	##

CREATE TABLE Employee (
  empno INT UNIQUE,
  ename VARCHAR(25),
  job VARCHAR(25) DEFAULT 'CLERK',
  mgr VARCHAR(25),
  hiredate DATE,
  sal DECIMAL(6,2) NOT NULL CHECK(sal>0),
  comm DECIMAL(6,2),
  deptno INT,
  
  PRIMARY KEY (empno),
  FOREIGN KEY (deptno) REFERENCES dept(deptno)
);

INSERT INTO Employee VALUES
(7369, 'SMITH', 'CLERK', 7902, '1890-12-17', 800.00, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-09-06', 2450.00, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000.00, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500.00, 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100.00, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950.00, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000.00, NULL, 20),
(7934, 'KILLER', 'CLERK', 7782, '1982-01-23', 1300.00, NULL, 10);

SELECT * FROM Employee;

##	Question 3	##
SELECT  ename, sal FROM Employee WHERE sal>1000;

##	Question 4	##
SELECT * FROM Employee WHERE hiredate<('1981-10-01');

##	Question 5	##
SELECT ename FROM Employee WHERE ename LIKE '_I%';

##	Question 6	##
SELECT ename AS Name, sal AS Salary, sal*.40 AS Allowance, sal*.10 AS PF, sal+(sal*.40)+(sal*.10) AS NetSalary FROM Employee;

# SELECT ename AS Name, sal AS Salary, comm, sal*.40 AS Allowance, sal*.10 AS PF, sal+coalesce(comm,0)+(sal*.40)+(sal*.10) AS NetSalary FROM Employee;

##	Question 7	##
SELECT ename, job FROM Employee WHERE mgr IS NULL;

##	Question 8	##
SELECT empno, ename, sal FROM Employee ORDER BY sal ASC;

##	Question 9	##
SELECT COUNT(DISTINCT job) FROM Employee;

##	Question 10	##
SELECT sum(sal) FROM Employee WHERE job='SALESMAN';

##	Question 11	##
SELECT job, avg(sal) AS AverageSalary FROM Employee GROUP BY job;

##	Question 12	##
SELECT e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno, d.dname
FROM employee e, dept d
WHERE e.deptno = d.deptno;

##	Question 13	##
CREATE TABLE Grades(
grade VARCHAR(1),
lowest_sal INT,
highest_sal INT
);

INSERT INTO Grades VALUES
('A', 0, 999),
('B', 1000, 1999),
('C', 2000, 2999),
('D', 3000, 3999),
('E', 4000, 5000);

SELECT * FROM Grades;

##	Question 14	##
SELECT e.ename, e.sal, g.Grade
FROM Employee e JOIN Grades g
ON e.sal BETWEEN g.lowest_sal AND g.highest_sal
ORDER BY Grade ASC;

##	Question 15	##
# select ename as "Employee Name", empno as "Emp", mgr as "Mgr"  from Employee;    (Ename & Empno to Mgr)

SELECT e.empno AS 'Emp No', e.ename AS "Employee",  e.mgr AS 'Mgr No', m.ename AS 'Mgr Name'
FROM Employee e
JOIN Employee m ON e.mgr = m.empno;

##	Question 16	##		Display Empname and Total sal where Total Sal (sal + Comm)
SELECT ename AS 'Employee', sal, comm, sal+COALESCE(comm,0) AS 'Total Sal' FROM Employee;

##	Question 17	##
SELECT empno, ename, sal FROM Employee 
WHERE MOD(empno,2)=1;

SELECT empno, ename, sal FROM Employee 
WHERE empno IN (SELECT empno FROM Employee WHERE empno %2 <> 0)

##	Question 18	## (Display Empname , Rank of sal in Organisation , Rank of Sal in their department)
Select ename, 
dense_rank() over (order by sal desc) rank_in_org, 
dense_rank() over (partition by deptno order by sal desc) rank_in_dept from employee ;

##	Question 19	##
SELECT ename, sal FROM Employee ORDER BY sal DESC LIMIT 3;

##	Question 20	##		(Display Empname who has highest Salary in Each Department.)
SELECT ename, deptno, MAX(sal) FROM Employee GROUP BY deptno;









