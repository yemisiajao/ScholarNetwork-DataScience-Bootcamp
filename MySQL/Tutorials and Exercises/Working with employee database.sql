USE employees;
/**SELECT statement and its components**/ 

#SELECT -FROM

SELECT 
    first_name, last_name
FROM
    employees;

/**WEHERE allows use to set conditions that refer to subsets of individual rows, AND, OR**/

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis';

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND gender = 'M';

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis'
        OR first_name = 'Elvis';
#In a query where both AND and OR is used, the AND operator is executed first

SELECT 
    *
FROM
    employees
WHERE
    last_name = 'Denis'
        AND (gender = 'M' OR gender = 'F');
/**IN ooperator is prefer when many conditions are to be applied in a query.
It allows SQL to retun the written values wrtten in parentheses, if they exists in a table**/

SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Cathie' , 'Mark', 'Nathan');

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('Cathie' , 'Mark', 'Nathan');

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('mar%');

/** Wildcard characters(%, _, *):
% substitutes for a sequence of characters
_ helps match a single character
* will deliver a list of all colums in a table;
 it can also be used to count all rows of a table**/
 
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%mar');

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%mar%');

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('mar_');

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('mar_');
  
/**BETWEEN -AND helps to designate the interval to which a given values belongs
NOT BETWEEN -AND will refer to and interval composed of two parts:
- an interval below the first value indicate
-a second interval above the second value**/  
 
 SELECT 
    *
FROM
    employees
WHERE
    hire_date BETWEEN '1990-01-01' AND '2000-01-01';
 
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('??????');
    
/**IS NOT NULL is used to extract values that are not null**/    

SELECT 
    *
FROM
    employees
WHERE
    first_name IS NOT NULL;
    
/**other comparison operators**/

SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';
    
 SELECT *
FROM
    employees
WHERE
    hire_date <= '1985-02-01';

#SELECT DISTINCT sellects all distinct, different vallues
SELECT DISTINCT
    gender
FROM
    employees;
    
/**ORDER BY used to sort results in a particular order or direction
used with ASC and DESC; it orders in ASC by default**/

SELECT 
    *
FROM
    employees
    ORDER BY first_name; 
 
SELECT 
    *
FROM
    employees
ORDER BY emp_no , first_name DESC;

/**GROUP BY is used to group results according to a specific fields or fields
it must be placed immediately after the where condition, if any, 
and just before the ORDER BY clause **/

SELECT 
    first_name
FROM
    employees
GROUP BY first_name;

SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC;

/**Alias (AS) is used to rename a selection from your query**/
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
ORDER BY first_name;
 
/**HAVING refines the output from records that do not satisfy a certain condition
after HAVING, you can have a condition with a aggregate function unlike WHERE
It's frequently implemented with GROUP BY
you cant have both aggregated and non aggregated condition in the having clause**/
 
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name) > 250
ORDER BY first_name;


 SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC;

 /**LIMIT**/   
SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

/**INSERT statement**/
insert into employees 
( 
	emp_no, 
	birth_date, 
	first_name, 
	last_name, gender, 
	hire_date
) values 
( 
	999901, 
	'1986-04-21', 
	'John', 
	'Smith', 
	'M', 
	'2011-01-01'
);

SELECT 
    *
FROM
    departments
LIMIT 10;

CREATE TABLE departments_dup (
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

insert into departments_dup
 (
 dept_no,
 dept_name
 )
select 
* 
from departments;

insert into departments_dup
( 
 dept_no
) values 
('d010'), ('d011');

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;
 
COMMIT;

/**COMMIT STATEMENT - saves the transaction in the database;
- changes cannot be undone**/
/**ROLLBACK STATEMENT allows you to take a step back
-the last change(s) made will not count
-reverts to the last non-committed state**/
/**the UPDATE STATEMENT is used to update the values of existing records in a table**/

UPDATE employees 
SET 
    first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F'
WHERE
    emp_no = 999901;

UPDATE departments_dup 
SET 
    dept_no = 'd011',
    dept_name = 'Quality Control';

ROLLBACK;
    
SELECT 
    *
FROM
   dept_manager;
   
CREATE TABLE dept_manager_dup (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) DEFAULT NULL,
    from_date DATE DEFAULT NULL,
    to_date DATE DEFAULT NULL
);    
    
/**DELETE statement
becareful with the delete statement. use the WHERE clause and always attach 
a condition if you dont want to loose your information**/    
SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999903;

DELETE FROM employees 
WHERE
    emp_no = 999903;
    
ROLLBACK;   

 /**AGGREGRATE FUNCTIONS are applied on multiple rows of a single column of a table
 and return an output of a single value
 COUNT() counts the number of non null records in a field
 it's frequently used in combination with the reserved word "DISTINCT"
 COUNT(DISTINCT) will deliver the number of different values found througout the table
 COUNT(*) will return the number of all rows of the table including NULL values
 SUM() sums all the non null values in a column
 MIN() returns the min values from the entire list 
 MAX() returns the max values from the entire list  
 AVG() calculates the average of all non null values belonging to a certain column of a table
 ROUND(#, decimal_places) is a numeric, or math, function you can use 
 -usually applied to the single vakues that agregate functions return
 NOTE: aggregate functions ignore null values unless told not to**/ 
 
 SELECT 
    COUNT(salary)
FROM
    salaries;
 
SELECT 
    COUNT(DISTINCT first_name)
FROM
    employees; 
    
 SELECT 
    COUNT(*)
FROM
    salaries; 
    
SELECT 
    SUM(salary)
FROM
    salaries;
    
SELECT 
    max(salary)
FROM
    salaries;

SELECT 
   AVG(salary)
FROM
    salaries;
    
SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries;
    
/**IFNULL() returns the first of the two indicated values if the data value found 
in the table is not nul, and returns the second values if there is a null value
- prints the returned value in the column of the output
- cannot contain more than two parameters
IFNULL(expression_1, expression_2)**/    

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

SELECT 
    dept_no,
    IFNULL(dept_name,
            'Department name not provided')
FROM
    departments_dup;
    
/**COALESCE() will always return a single value of the ones we have within parentheses,
and this value will be the first non-null value of this list, 
reading the values from left to right.
- allows you to insert N arguments in the parentheses
- COALESCE(expression_1, expression_2, expression_N)
IFNULL()and COALESCE() do not make any changes to the data set. they merely create 
an output where certain data values appear in place of NULL values**/

/**JOINS: allows us to construct a relationship between objects
- it shows result set, containing fields derived from two or more tables**/
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no;
   
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

/**INNER JOIN extracts only records in which the values in the related columns match
- null values, or values appearing in just one of the two tables and not appearing
in the other, are not displayed**/
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY dept_no;

#remove duplicates
delete from dept_manager_dup where emp_no = '110228';
delete from departments_dup where dept_no = 'd009';

# add back initial records
insert into dept_manager_dup
values ('110228', 'd003', '1992-03-21', '9999-01-01');

insert into departments_dup
values ('d009', 'Customer Service');

/*LEFT JOIN returns all matching values of the two tables and 
- all values from the left table that match no values from the right table*/
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
WHERE
    dept_name IS NULL
ORDER BY m.dept_no;
/* RIGHT JOIN
LEFT and RIGHT joins are percfect example of one-to-many relationships*/

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        RIGHT JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY dept_no;

# JOIN and WHERE used together
SELECT 
    e.emp_no, e.first_name, e.last_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.salary > 145000;
    
/*CROSS JOIN will take the values from a certain table and connect them with all the
values from the tables we want to join it with
- it is the Cartesian product of the values of two or more sets*/
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    dm.*, d.*
FROM
    dept_manager dm,
    departments d
ORDER BY dm.emp_no , d.dept_no;


SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;

/*using aggregate functions on join*/

SELECT 
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

/*join more than two tables in SQL
when creating a query that joins multiple tables, you must back it with strong 
intuition and a crystal-clear idea of how you would like the tables to be connected*/
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
	employees e ON m.emp_no = e.emp_no;
    

SELECT 
    d.dept_name, AVG(salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
HAVING average_salary > 60000
ORDER BY average_salary DESC;

-- create employees_dup
drop table if exists employees_dup;
CREATE TABLE employees_dup (
    emp_no INT(11),
    birth_date DATE,
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    gender ENUM('M', 'F'),
    hire_date DATE
);

-- duplicate the structure of the 'employees' table
insert into employees_dup 
select e.* from employees e limit 20;


select * from employees_dup;

insert into employees_dup
values ('10001', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');

/*UNION ALL is used to combine a few SELECT statements in a single output
- you can think of it as a tool that allows you to unify tables
- retrives the duplicate values as well
UNION displays only distinct values in the output
UNION and UNION ALL: we have to select the same number of columns from each table
- these columns should have the same name, same order 
and should contain related datatypes*/

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION ALL SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
    dept_manager m;
    
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
    dept_manager m;

/*subqueries(inner select) embedded in a query
they are part of another query, called an outer query(outer select)
- subqueries shoould be always placed in parentheses*/

SELECT 
    *
FROM
    dept_manager;

/* subqueries with IN nested inside WHERE
- searches among the values*/
/*select the first and the last name from the 'employees' table for the same
employee numbers that can be found in the 'department manager' table*/
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm);
            
/*subqueries with EXISTS-NOT EXISTS Nested Inside WHERE
- checks whether certain row values are found within a subquery
- it returns a boolean value: TRUE or FALSE*
-tests row values for existence*/

SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no);

/*using ORDER BY in nested queries
- it can be within the sub query, but it recommended to apply it in the outer query*/
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no)
ORDER BY emp_no;

/*subqueries nested in SELECT and FROM*/
/*assign employee number 110022 as a manager to all employees from 10001 to 10020 
(this must be subset A), and employee number 110039 as a manager to all employees 
from 10021 to 10040 (this must be subset B).*/
SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;
    
    
/*Use the structure of subset A to create subset C, 
where you must assign employee number 110039 as a manager to employee 110022*/
SELECT 
    C.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS C;
/*Following the same logic, create subset D. Here you must do the opposite 
- assign employee 110022 as a manager to employee 110039.*/    
SELECT 
    D.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS D;

/*Fill emp_manager with data about employees, the number of the department 
they are working in, and their managers.*/


CREATE TABLE emp_manager (
    emp_no INT NOT NULL,
    dept_no CHAR(4) NOT NULL,
    manager_no BIGINT(20) NOT NULL
);

INSERT INTO emp_manager
SELECT 
	U.*
FROM
    (SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
    UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B 
    UNION SELECT 
    C.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS C
    UNION SELECT 
    D.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS D) AS U;
    
    SELECT 
    *
FROM
    emp_manager;

/*Self JOIN is applied when a table must join itself
- if you'd like to combine certain rows of a table with other rows of the same table*/
-- task: from the emp_manager table, extract the record data only of those employees
-- who are managers as well

SELECT 
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
    
SELECT 
    e1.emp_no, e1.dept_no, e2.manager_no
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
    
/*the query below would return the desired result, 
and not the number of time the employees are managers*/
SELECT DISTINCT
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
    
-- another method
SELECT 
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no
WHERE
    e2.emp_no IN (SELECT 
            manager_no
        FROM
            emp_manager);

SELECT 
    manager_no
FROM
    emp_manager;


/*SQL Views: a virtual table whose contents are obtained from an existing table
or tables, called base tables. a view object is a view into the base table
- the view itself does not contain any real data
- the view simply show the data contained in the base table
- it acts as a shortcut for writing the same SELECT staement everytime a new request has been made*/

SELECT 
    *
FROM
    dept_emp;

SELECT 
    emp_no, from_date, to_date, COUNT(emp_no) AS num
FROM
    dept_emp
GROUP BY emp_no
HAVING num > 1;

/*visualize only the period encompassing the last contract of each employee*/
/**while creating a view, using REPLACE after the view would 
replace any existing views of the same name*/
CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;
    
SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;
    
-- retrieving views
SELECT * FROM employees.v_dept_emp_latest_date;

/*stored routines: is an sql statement or a set of sql statements, that can be stored
on the databse server. types:
- stored procedures - functions(user-defines functions & built-in functions)
in procedures, instead of using semicolons as delimiters we use DELIMITER $$
this is to ensure that when invoking our procedures, 
the rest of the queries would not be ignored because of the ;
- parentheses must always come after procedure name because they are inherent to the procedure
- the contain parameters that represents certain values that the procedure will use to complete the calculation 
it is supposed to execute
- procedure can be created wihtout parameters too, but the parentheses must always be attached*/

--  devise a procedure that will return the first 1,000 rows from the 'employees' table
DROP PROCEDURE IF EXISTS select_employees;
-- when dropping a nonparameterized procedure, we should not write the parentheses at the end
DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
      SELECT * FROM employees
	  LIMIT 1000;
END$$

DELIMITER ;

-- invoking procedures
call employees.select_employees();
call select_employees();
-- we can also create stored procedures through the workbench schema

/*parametric procedures
- stored procedures can take an input value and then use it in the query
or queries, written in the body of the procedure
- this value is represented by the IN parameter*/
DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
SELECT
    e.first_name, e.last_name, s.salary, s.from_date, s.to_date
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
END $$

end$
DELIMITER ; 

-- procedures with one input parameter can be used with aggregate functions too
DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN
SELECT
    e.first_name, e.last_name, AVG(s.salary)
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
END $$

DELIMITER ; 

call emp_avg_salary(11300);

/*procedures with one output parameter
it will represent the variable containing the output value of the operation executed by
the query of the stored procedure
- evey time you create a procedure containing both an IN and OUT parameter, you must use
the SELECT-INTO structure in the query of this objects body*/
DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INTEGER, OUT p_avg_salary DECIMAL(10,2))
BEGIN
SELECT
    AVG(s.salary)
INTO p_avg_salary FROM
    employees e 
        JOIN
	salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
END $$

DELIMITER ; 

/*SQL VARIABLES
- input values is the argument, while the obtained putput value is sored in a variable*/
SET @v_avg_salary = 0;
CALL employees.emp_avg_salary_out(11300, @v_avg_salary);
SELECT @v_avg_salary;

/*user-defined functions*/
DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary(p_emp_no INTEGER) RETURNS DECIMAL(10,2)
BEGIN

DECLARE v_avg_salary DECIMAL(10,2);

SELECT
    AVG(s.salary)
INTO v_avg_salary FROM
    employees e 
        JOIN
	salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
    
RETURN v_avg_salary;
END $$

DELIMITER ; 

-- we can't call a function, we can select it
SELECT f_emp_avg_salary(11300);

/*stored procedure:
- does not return a value
- CALL procedure;
- can have multiple OUT parameters
- can be used if we perform INSERT, UPDATE, DELETE only
- including a procedure in a SELECT statement is impossible
user-defined function:
- returns a value
- SELECT function;
- can only return a single value only
- should not be used if we perform INSERT, UPDATE, DELETE only
- you can easily include a function as one of the columns inside a SELECT statement*/

SET @v_emp_no = 11300;
SELECT 
    emp_no,
    first_name,
    last_name,
    f_emp_avg_salary(@v_emp_no) AS avg_salary
FROM
    employees
WHERE
    emp_no = @v_emp_no;
    
/*scope/visibility: a region of a computer program where a phenomenon, such as a variable
is considered valid
types of sql variables: local, session, global
- local variable is visible only in the BEGIN-END block in which it was created
-DECLARE is a keyword that can be used when creating local variables only*/
is considered valid
types of mysql variables: local, session, global
-local vairable is visible only in the BEGIN-END block in which it was created*/
DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary(p_emp_no INTEGER) RETURNS DECIMAL(10,2)
BEGIN

DECLARE v_avg_salary DECIMAL(10,2);

BEGIN
    DECLARE v_avg_salary_2 DECIMAL(10,2);
END;

SELECT
    AVG(s.salary)
INTO v_avg_salary FROM
    employees e 
        JOIN
	salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
    
RETURN v_avg_salary;
END $$

DELIMITER ; 

/*session variable is a variable that exists only for the session in which you are operating
- it is defined on our server, and it lives there
- it is visible to the connections being used only*/
SET @s_var1 =3;

SELECT @s_var1;

/*global variables: apply to all connections related to a specific server*/
SET GLOBAL max_connections = 1000;

SET @@global.max_connections = 1;

COMMIT;



















