-- 6 --



-- 7 -- 

SELECT last_name, salary
FROM employees
where salary > ANY
				(SELECT salary
				FROM employees
				where department_id = 60);

-- 8 --

SELECT job_id, last_name, salary
FROM employees
WHERE salary > 
				(SELECT AVG(salary)
				FROM employees)

AND last_name like '%u%';
