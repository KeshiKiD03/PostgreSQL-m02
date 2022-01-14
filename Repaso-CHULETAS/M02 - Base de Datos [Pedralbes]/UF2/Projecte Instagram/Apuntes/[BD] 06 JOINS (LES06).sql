NATURAL JOIN --> Ver donde hay nombre tabla.
JOIN = Unir 2 tablas que están comunes en 2 columnas. PK + FK.
ALIAS = SELECT E.EMPLOYEE_ID, E.LAST_NAME,
		D.DEPARTMENT_ID
	FROM EMPLOYEES E JOIN DEPARTMENTS D

------------------------------------------------------------------------------------


A)
 
SELECT FIRST_NAME, DEPARTMENT_ID, DEPARTMENT_ID, DEPARTMENT_NAME
FROM EMPLOYEES
NATURAL JOIN DEPARTMENTS;

------------------------------------------------------------------------------------

B)

SELECT e.first_name, e.department_id, d.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);

------------------------------------------------------------------------------------

B) JOIN con WHERE

SELECT e.first_name, e.department_id, d.department_id, d.department_name
FROM employees e, departments d
where (e.department_id = d.department_id);

------------------------------------------------------------------------------------

Con ciudad

SELECT e.first_name, e.department_id, d.department_id, d.department_name, l.city, l.location_id
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);


------------------------------------------------------------------------------------

CON WHERE

SELECT e.first_name, e.department_id, d.department_id, d.department_name, l.city, l.location_id
FROM employees e, departments d, locations l
where (e.department_id = d.department_id) AND (d.location_id = l.location_id)

------------------------------------------------------------------------------------

SIEMPRE ES CON UN ÚNICO "FROM"

------------------------------------------------------------------------------------

AUTO JOIN

Bautizar con diferentes nombres la misma tabla

SELECT worker.last_name emp, manager.last_name mgr
FROM employees worker JOIN employees manager
ON (worker.manager.id = manager.employee_id);

SELECT worker.last_name Employee, worker.employee_id EMP#, manager.last_name Manager, manager.manager_id Mgr#
FROM employees worker JOIN employees manager
ON (worker.manager_id = manager.employee_id);

-------------------------------

OUTER JOINS

FROM employees e RIGHT OUTER JOIN departments d

Right OUTER --> Derecha
Left OUTER  --> Izquierda

RIGHT OUTER

2 ----- 10
3 ----- 20
null ----- 30

LEFT OUTER

1 ---- NULL
2 ---- 10
3 ---- 27
4 ---- null

CROSS JOIN


------------------------------------------------------------------------------------

SELECT e.last_name, d.department_id, d.department_name
FROM employees e JOIN departments d
ON (d.department_id = e.department_id);

------------------------------------------------------------------------------------

SELECT last_name, d.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id; --> Muestrame las columnas de la izquierda

------------------------------------------------------------------------------------

// SÓLO ES PARA ORACLE
SELECT last_name, d.department_id, department_name
FROM employees e, departments d
WHERE e.department_id (+)= d.department_id(+);

------------------------------------------------------------------------------------


WHERE e.department_id = d.department_id(+); --> Para (+) añadir nulos. Se puede poner al final o al principio


Ejercicio 9 - Act6 Empleado con Hire Date

SELECT w.last_name as "Worker name", w.hire_date, m.last_name as "Manager name", m.hire_date
FROM employees w, employees m
WHERE (w.hire_date < m.hire_date) ABD (w.manager_id = employee_id);

DECODE ES COMO UN IF 
SI JOB_ID es igual a IT_PROG, ponme 1.10*salary y sino ponme....

SELECT last_name, job_id, salary,
	DECODE(job_id, 'IT_PROG', 1.10*salary,       // Si Job_ID es igual a IT_PROG ponme 1.10*salary
			'ST_CLERK', 1.15*salary,
			'SA_REP', 1.20*salary,
		salary)
	REVISED SALARY
FROM employees;

)
