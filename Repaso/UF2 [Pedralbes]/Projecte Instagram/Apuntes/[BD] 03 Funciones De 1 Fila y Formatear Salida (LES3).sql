SELECT last_name, (SYSDATE-hire_date)/7 AS WEEKS
FROM employees
WHERE department_id = 90; -->  Semanas del empleado


----------------------------------------------------

SELECT LAST_NAME, ROUND (MONTHS_BETWEEN (SYSDATE, HIRE_DATE)) “MONTHS_WORKED”
FROM EMPLOYEES
ORDER BY “MONTHS_WORKED” ASC; --> Duración de contrato en MESES

----------------------------------------------------

SELECT LAST_NAME, LPAD(SALARY,15,'$') “SALARY”
FROM EMPLOYEES; --> Formatear para que tenga 15 caracteres de longitud y lo que queda $

----------------------------------------------------

SELECT LAST_NAME, SALARY,RPAD(' ', ROUND(SALARY/1000)+1, '*') "EMPLOYEES_AND_THEIR_SALARIES"
FROM EMPLOYEES
ORDER BY "EMPLOYEES_AND_THEIR_SALARIES" DESC;

--> Cantidad de salario en * | Cada * significa 1000 dolares

----------------------------------------------------

SELECT LAST_NAME, TRUNC((SYSDATE-HIRE_DATE)/7) "Tenure", DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID in (select department_id
						from employees
						where department_id = 90)
ORDER BY "Tenure" DESC;

-- Cree una consulta para mostrar el apellido y el número de semanas 
-- durante las que han trabajado todos los empleados del departamento 90. 
-- Etiquete la columna de número de semanas como TENURE. 
-- Trunque el valor del número de semana en 0 decimales. 
-- Muestre los registros en orden descendente de antigüedad del empleado. 
