/*
1)

Escriba una consulta para que el departamento de recursos humanos genere las direcciones de todos los departamentos.
Utilice las tablas LOCATIONS y COUNTRIES. Muestre el ID de ubicación, dirección, ciudad, estado o provincia y país en la salida. 
Utilice NATURAL JOIN para producir los resultados. 
*/

SELECT l.location_id, l.street_address, l.city, c.state_province, c.country_name
FROM locations l JOIN countries c
ON (l.locations = c.locations_id)

-- Con NATURAL JOINS --

SELECT LOCATION_ID, STREET_ADDRESS, CITY, STATE_PROVINCE, COUNTRY_NAME
FROM LOCATIONS
NATURAL JOIN COUNTRIES;

-- 2 --

SELECT LAST_NAME, DEPARTMENT_ID, DEPARTMENT_NAME
FROM EMPLOYEES
NATURAL JOIN DEPARTMENTS;

SELECT e.LAST_NAME, e.DEPARTMENT_ID, d.DEPARTMENT_NAME
FROM EMPLOYEES e JOIN DEPARTMENTS d
ON (e.department_id = d.department_id);

SELECT e.LAST_NAME, e.DEPARTMENT_ID, d.DEPARTMENT_NAME
FROM EMPLOYEES e, DEPARTMENTS d
where (e.department_id = d.department_id);

-- 3

SELECT e.LAST_NAME, e.JOB_ID, l.CITY, d.DEPARTMENT_NAME
FROM employees e JOIN departments d
ON d.department_id = e.department_id 
JOIN locations l
ON d.location_id = l.location_id
WHERE CITY = 'Toronto';

SELECT e.LAST_NAME, e.JOB_ID, l.CITY, d.DEPARTMENT_NAME
FROM employees e, departments d, locations l
WHERE l.CITY = 'Toronto' AND (d.department_id = e.department_id) AND (d.location_id = l.location_id);

-- 4

SELECT worker.last_name Employee, worker.employee_id EMP#, manager.last_name Manager, manager.employee_id Mgr#
FROM employees worker JOIN employees manager
ON (worker.manager_id = manager.employee_id);

-- 5

SELECT worker.last_name Employee, worker.employee_id EMP#, manager.last_name Manager, manager.employee_id Mgr#
FROM employees worker LEFT JOIN employees manager
ON (worker.manager_id = manager.employee_id);

-- 6

SELECT e.last_name, coleguees.last_name "COLEGUEES"
FROM employees e LEFT OUTER JOIN employees coleguees
ON (e.department_id = coleguees.department_id)

-- 7

CREATE TABLE Job_Grade(
	GRADE_LEVEL		VARCHAR2(3),
	LOWEST_SAL		NUMBER(7),
	HIGHEST_SAL		NUMBER(7)
);


SELECT e.last_name, e.job_id, d.department_name, e.salary, J.grade_level
FROM employees e JOIN department d
ON (e.department_id = d.department_id)
JOIN job_grades j
ON e.salary
  BETWEEN j.lowest_sal AND j.higher_sal;
  
-- 8 

SELECT e.last_name, e.hire_date
FROM employees e JOIN employees davies
ON (davies.last_name = 'Davies') AND (davies.hire_date > e.hire_date);

-- 9

SELECT WORKER.LAST_NAME WORKER, WORKER.HIRE_DATE Hire_Date_1 ,

MANAGER.LAST_NAME MANAGER, MANAGER.HIRE_DATE Hire_Date_2

FROM employees WORKER JOIN employees MANAGER

ON (MANAGER.EMPLOYEE_ID=WORKER.MANAGER_ID) AND

(WORKER.HIRE_DATE<MANAGER.HIRE_DATE);




















SELECT e.last_name, d.deptartment_id, d.dept_name
FROM employees e JOIN departments d
ON (d.deptarment_id = e.department_id); 

SELECT e.last_name, d.deptartment_id, d.dept_name
FROM employees e, departments d
WHERE (d.deptarment_id = e.department_id); 


