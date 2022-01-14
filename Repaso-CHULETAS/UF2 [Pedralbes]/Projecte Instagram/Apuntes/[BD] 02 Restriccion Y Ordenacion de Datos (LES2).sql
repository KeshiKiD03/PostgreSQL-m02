
SELECT last_name, salary
FROM employees
WHERE salary <= 3000 ;

--> Sea menor o igual que 3000

----------------------------------------------------

SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 2500 AND 3500 ;

--> Entre 2500 y 3500 --> Incluidos los limites

----------------------------------------------------

SELECT employee_id, last_name, salary, manager_id
FROM employees
WHERE manager_id IN (100, 101, 201) ;

--> En 100, 101 o 201

----------------------------------------------------

SELECT first_name
FROM employees
WHERE first_name LIKE 'S%' ;

--> Donde empiece por S%
--% = Cadena de caracteres | _ 1 carácter

----------------------------------------------------

SELECT last_name, manager_id
FROM employees
WHERE manager_id IS NULL ; --> Valor nulo

----------------------------------------------------

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >= 10000
AND job_id LIKE '%MAN%' ; --> Ambas condiciones verdaderas

----------------------------------------------------

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >= 10000
OR job_id LIKE '%MAN%' ;

--> 1 de las 2 verdaderas | Operador NOT In no hace falta

----------------------------------------------------

SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY hire_date ;

--> Ordenar por DESC , ASC, numero de columna

----------------------------------------------------

SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE employee_id = &employee_num ;

--> Variable de sustitución para ID | Nombre opcional | && = Hola 

----------------------------------------------------

SELECT DISTINCT LAST_NAME
FROM EMPLOYEES
WHERE (LAST_NAME like '%a%') AND (LAST_NAME like '%e%') OR (LAST_NAME like '%a%') OR (LAST_NAME like '%e%');

--> Mostrar apellidos donde haya una a, o una e

----------------------------------------------------


SELECT LAST_NAME
FROM EMPLOYEES
WHERE (LOWER(LAST_NAME) LIKE '%a%') AND (LOWER(LAST_NAME) LIKE '%e%');

--> 2da opcion

----------------------------------------------------

--	Muestre el apellido, cargo y salario de todos los empleados que sean vendedores 
-- u oficinistas 
--en el departamento de stock y cuyos salarios no sean iguales que 2.500, 3.500 ó 7.000 dólares.

SELECT LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID  = ‘50‘ AND SALARY not in (2500,3500,7000);
