SELECT last_name,TO_CHAR(hire_date, 'fmDD Month YYYY')AS HIREDATE
FROM employees;

--> Convierte a carácter la fecha MONTH muestra la el mes

----------------------------------------------------

SELECT TO_CHAR(salary, '$99,999.00') SALARY
FROM employees
WHERE last_name = 'Ernst';

--> Imprime el salario de Ernst pasado en carácter como $ , decimal y punto

----------------------------------------------------

SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YYYY') "Date" FROM employees
WHERE hire_date < TO_DATE('01-Jan-90','DD-Mon-RR')
ORDER BY "Date" ASC;

--> Convierte a caracter la fecha introducida con parametros
--> Convierte a fecha la cadena introducida con parametros

----------------------------------------------------

SELECT last_name, job_id, salary,
	CASE job_id WHEN 'IT_PROG' THEN 1.10*salary
				WHEN 'ST_CLERK' THEN 1.15*salary
				WHEN 'SA_REP' THEN 1.20*salary
	ELSE salary END "REVISED_SALARY"
FROM employees;

--> SI en el caso job_id es 'IT_PROG' THEN 1.10*salary | Aumentale el salario
--> Por otro lado muestra solo el salario

----------------------------------------------------

SELECT (LAST_NAME||' earns '||TO_CHAR(SALARY, '$99,999.00')||' monthly but wants '||TO_CHAR(SALARY*3, '$99,999.00'))AS "Dream Salaries"
FROM EMPLOYEES

--> Concatena | Convierte a carácter el salario ...


----------------------------------------------------

SELECT LAST_NAME, HIRE_DATE, TO_CHAR(NEXT_DAY(ADD_MONTHS(HIRE_DATE, 6),'MONDAY'), 'DAY, ddspth "of" Month, YYYY')AS REVIEW
FROM EMPLOYEES;

--> Convierte a carácter el siguiente día ....

-- Muestre el apellido, fecha de contratación y fecha de revisión de salario de cada empleado, 
-- que es el primer lunes después de seis meses de contrato. Etiquete la columna como REVIEW. 
-- Formatee las fechas para que aparezcan en un formato similar a “Lunes treinta y uno de julio de 2000”.

----------------------------------------------------

/* Cree una consulta que muestre los apellidos y comisiones de los empleados. 
Si un empleado no obtiene ninguna comisión, indique "No Commission". 
Etiquete la columna como COMM. */

SELECT LAST_NAME, COALESCE(TO_CHAR(COMMISSION_PCT), 'No Commission')AS COMM
FROM EMPLOYEES

----------------------------------------------------

/* Con la función DECODE, escriba una consulta que muestre el grado 
de todos los empleados según el valor de la columna JOB_ID, */

SELECT JOB_ID,
	DECODE( JOB_ID, 'AD_PRES',  'A',
                  'ST_MAN',   'B',
                  'IT_PROG',  'C',
                  'SA_REP',   'D',
                  'ST_CLERK', 'E',
  '0') GRADE
FROM EMPLOYEES;

----------------------------------------------------


SELECT JOB_ID,
	CASE JOB_ID WHEN 'AD_PRES'  THEN 'A'
              WHEN 'ST_MAN'   THEN 'B'
              WHEN 'IT_PROG'  THEN 'C'
            	WHEN 'SA_REP'   THEN 'D'
            	WHEN 'ST_CLERK' THEN 'E'
            	ELSE '0'
	END GRADE
FROM EMPLOYEES;


--> Lo mismo pero con CASE

-- Decode más eficaz que el case
