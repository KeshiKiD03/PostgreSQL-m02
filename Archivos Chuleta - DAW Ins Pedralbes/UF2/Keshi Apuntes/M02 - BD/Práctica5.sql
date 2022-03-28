/* Práctica 5 */

-- 1 --

-- verdadero --

-- 2 --

-- falso --

-- 3 -- 

-- verdadero --

-- 4 --

/* Encontrar el valor más alto, el valor más bajo, la suma y la media del salario de todos
los empleados. Etiquete las columnas como Maximum, Minimum, Sum y Average,
respectivamente. Redondee los resultados al número entero más cercano. Guarde la
sentencia SQL como lab_05_04.sql. Ejecute la consulta. */

SELECT ROUND(MAX(SALARY))"Maximum", ROUND(MIN(SALARY))"Minimum", ROUND(SUM(SALARY))"Sum", ROUND(AVG(SALARY))"'Average"
FROM EMPLOYEES;

-- 5 --

SELECT JOB_ID, ROUND(MAX(SALARY))"Maximum", ROUND(MIN(SALARY))"Minimum", ROUND(SUM(SALARY))"Sum", ROUND(AVG(SALARY))"'Average"
FROM EMPLOYEES
GROUP BY JOB_ID;

-- 6 --

/* Escriba una consulta para mostrar el número de personas con el mismo cargo. */

SELECT JOB_ID, COUNT(JOB_ID)
FROM EMPLOYEES
GROUP BY JOB_ID;

-- 6B --

SELECT JOB_ID, COUNT(JOB_ID)
FROM EMPLOYEES
WHERE JOB_ID = '&VARIABLE'
GROUP BY JOB_ID;

-- 7 --

/* Determine el número de gestores sin enumerarlos en una lista. Etiquete la columna */

SELECT COUNT(DISTINCT MANAGER_ID) "Number of Managers"
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL;

-- 8 --

/* Busque la diferencia entre los salarios más altos y más bajos. Etiquete la columna como DIFFERENCE. */

SELECT (MAX(SALARY)-MIN(SALARY))"DIFFERENCE" FROM EMPLOYEES;

-- 9 --

/* Cree un informe para mostrar el número de gestor y el salario del empleado 
con menor sueldo de ese gestor. 
Excluya a cualquier trabajador del que desconozca su gestor. 
Excluya cualquier grupo en el que el salario mínimo sea 6.000 dólares o menos. 
Ordene la salida en orden descendente de salarios. */

SELECT MANAGER_ID, MIN(SALARY)
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING MIN(SALARY)>6000
ORDER BY MIN(SALARY) DESC;

-- 10 --

/* Cree una consulta para mostrar el número total de empleados y, de ese total, 
el número de empleados contratados en 1995, 1996, 1997 y 1998. 
Cree las cabeceras de columna adecuadas. */

SELECT
SUM(DECODE('1995',TO_CHAR(HIRE_DATE,'YYYY'),1,0))"1995",
SUM(DECODE('1996',TO_CHAR(HIRE_DATE,'YYYY'),1,0))"1996",
SUM(DECODE('1997',TO_CHAR(HIRE_DATE,'YYYY'),1,0))"1997",
SUM(DECODE('1998',TO_CHAR(HIRE_DATE,'YYYY'),1,0))"1998"
FROM EMPLOYEES;

SELECT
SUM(DECODE(TO_CHAR(hire_date,'YYYY'),'1995',1,0)) "1995",
SUM(DECODE(TO_CHAR(hire_date,'YYYY'),'1996',1,0)) "1996",
SUM(DECODE(TO_CHAR(hire_date,'YYYY'),'1997',1,0)) "1997",
SUM(DECODE(TO_CHAR(hire_date,'YYYY'),'1998',1,0)) "1998"
FROM EMPLOYEES;


-- 11 --

/* 11) Cree una consulta de matriz para mostrar el cargo, 
el salario de ese cargo según el número de departamento y 
el salario total del cargo para los departamentos 20, 50, 80 y 90, 
proporcionando a cada columna una cabecera adecuada. */

SELECT
SUM('1995',
