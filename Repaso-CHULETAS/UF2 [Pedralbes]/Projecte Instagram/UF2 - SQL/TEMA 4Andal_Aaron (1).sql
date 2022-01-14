/* Tema 4 oracle Academy*/

--1

SELECT (LAST_NAME||' earns '||TO_CHAR(SALARY, '$99,999.00')||' monthly but wants '||TO_CHAR(SALARY*3, '$99,999.00'))AS "Dream Salaries"
FROM EMPLOYEES


--2

SELECT LAST_NAME, HIRE_DATE, TO_CHAR(NEXT_DAY(ADD_MONTHS(HIRE_DATE, 6),'MONDAY'), 'DAY, ddspth "of" Month, YYYY')AS REVIEW
FROM EMPLOYEES


--3

SELECT LAST_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'DAY')AS DAY
FROM EMPLOYEES
ORDER BY DAY



--4

SELECT LAST_NAME, COALESCE(TO_CHAR(COMMISSION_PCT), 'No Commission')AS COMM
FROM EMPLOYEES


--5

SELECT JOB_ID,
	DECODE( JOB_ID, 'AD_PRES',  'A',
                  'ST_MAN',   'B',
                  'IT_PROG',  'C',
                  'SA_REP',   'D',
                  'ST_CLERK', 'E',
  '0') GRADE
FROM EMPLOYEES;


--6

SELECT JOB_ID,
	CASE JOB_ID WHEN 'AD_PRES'  THEN 'A'
              WHEN 'ST_MAN'   THEN 'B'
              WHEN 'IT_PROG'  THEN 'C'
            	WHEN 'SA_REP'   THEN 'D'
            	WHEN 'ST_CLERK' THEN 'E'
            	ELSE '0'
	END GRADE
FROM EMPLOYEES;

