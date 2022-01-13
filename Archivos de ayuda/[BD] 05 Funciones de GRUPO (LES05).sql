SELECT COUNT(DISTINCT department_id)
FROM employees;

--> Cuentame cuantos son del departamento_id y que no se repita

----------------------------------------------------

SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary)>10000 ;

--> El máximo salario que sobrepase los 10000

----------------------------------------------------

SELECT job_id, SUM(salary) PAYROLL
FROM employees
WHERE job_id 
NOT LIKE '%REP%'
GROUP BY job_id
HAVING SUM(salary) > 13000
ORDER BY SUM(salary);

--> La suma de los salarios donde no sea %REP%, agrupar por job_id
--> Y filtramos por funcion de grupo salary
