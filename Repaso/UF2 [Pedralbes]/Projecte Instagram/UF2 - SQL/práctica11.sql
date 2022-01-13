--1

/* 

El personal del departamento de recursos humanos desea ocultar algunos de los datos de la tabla EMPLOYEES. 
Cree una vista denominada EMPLOYEES_VU basada en los números y los apellidos de los empleados y 
en los números de departamento de la tabla EMPLOYEES. 
La cabecera del nombre de empleado debe ser EMPLOYEE.

*/

CREATE VIEW employee_vu
AS SELECT employee_id,last_name,department_id
FROM employees;

--2

/* Confirme que la vista funciona. Visualice el contenido de la vista EMPLOYEES_VU. */

DESCRIBE employee_vu
SELECT *
FROM employee_vu;


--3

/* Con la vista EMPLOYEES_VU, escriba una consulta para el departamento de recursos humanos 
para visualizar todos los nombres de empleados y números de departamento. */

select last_name Employee,department_id 
from employees;

--4

/* El departamento 50 necesita acceso a los datos de los empleados. 
Cree una vista con el nombre DEPT50 que contenga los números y apellidos de los empleados 
y los números de departamento de todos los empleados del departamento 50. 
Se le ha pedido que etiquete las columnas de la vista como EMPNO, EMPLOYEE y DEPTNO. 
Por motivos de seguridad, no permita la reasignación de un empleado a otro departamento a través de la vista. */

create view dept_50
as select employee_id,last_name,department_id
from employees
where department_id = '50';


-- 5 

/* Visualice la estructura y el contenido de la vista DEPT50. */


desc dept_50
select *
from dept_50

--6

/* Pruebe la vista. Intente reasignar Matos al departamento 80. */

UPDATE dept_50
SET department_id = 80
WHERE last_name = 'Matos';

-- 7

/* Necesita una secuencia que se pueda utilizar con la columna PRIMARY KEY de la tabla DEPT. 
La secuencia debe empezar en 200 y tener un valor máximo de 1.000. 
Aplique incrementos de 10 a la secuencia. 
Asigne a la secuencia el nombre DEPT_ID_SEQ. */

CREATE SEQUENCE dept_id_seg2
INCREMENT BY 10
START WITH 200
MAXVALUE 1000;

-- 8

/* Para probar la secuencia, escriba un script para insertar dos filas en la tabla DEPT.
Asigne al script el nombre lab_11_08.sql. 
Asegúrese de utilizar la secuencia que ha creado para la columna ID. 
Agregue dos departamentos: Education y Administration. 
Confirme las adiciones. 
Ejecute los comandos del script. */

CREATE SEQUENCE dept_sequencia
INCREMENT BY 10
START WITH 280
MAXVALUE 1000;

INSERT INTO departments VALUES (dept_sequencia.NEXTVAL, 'Education', 200, 2500);

INSERT INTO departments VALUES (dept_sequencia.NEXTVAL, 'Administration', 200, 1700);

SELECT *
FROM DEPARTMENTS;

SELECT dept_id_seq.CURRVAL
FROM DUAL;

-- 9 

/* Cree un índice no único en la columna NAME de la tabla DEPT. */

CREATE INDEX dept_name_idx
ON DEPT(last_name);


-- 10 

/* Cree un sinónimo para la tabla EMPLOYEES. Llámelo EMP. */

CREATE SYNONYM emp
FOR employees;


