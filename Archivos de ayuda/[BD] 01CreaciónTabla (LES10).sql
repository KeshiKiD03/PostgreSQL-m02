	--------------------------------------
    --    |	CREACION DE TABLA	  | 	--
	--------------------------------------

DROP TABLE "name" CASCADE CONSTRAINTS

----------------------------------------------------

CREATE TABLE 
	dept(deptno 	NUMBER(2),
		dname 		VARCHAR2(14),
		loc 		VARCHAR2(13),
		create_date DATE DEFAULT SYSDATE);

----------------------------------------------------

CREATE TABLE employees
	( employee_id NUMBER(6)
		CONSTRAINT emp_employee_id PRIMARY KEY
	, first_name VARCHAR2(20)
	, last_name VARCHAR2(25)
			CONSTRAINT emp_last_name_nn NOT NULL
	, email VARCHAR2(25)
		CONSTRAINT emp_email_nn NOT NULL --> Constraint NOT NULL a nivel de col
		CONSTRAINT emp_email_uk UNIQUE --> Constraint UNIQUE a nivel de col
	, phone_number VARCHAR2(20)
	, hire_date DATE
		CONSTRAINT emp_hire_date_nn NOT NULL
	, job_id VARCHAR2(10)
		CONSTRAINT emp_job_nn NOT NULL --> Not null a nivel de col
	, salary NUMBER(8,2)
		CONSTRAINT emp_salary_ck CHECK (salary>0) --> Constraint CHECK
	, commission_pct NUMBER(2,2)
	, manager_id NUMBER(6)
		CONSTRAINT emp_manager_fk REFERENCES
	employees (employee_id)
	, department_id NUMBER(4)
		CONSTRAINT emp_dept_fk REFERENCES
	departments (department_id)); --> Constraint FK
	
	-- No se puede suprimir una fila que contenga una clave primaria
	-- Que se utilice como clave ajena a otra tabla
----------------------------------------------------

CREATE TABLE dept80
	AS 
	SELECT employee_id, last_name,
			salary*12 ANNSAL,
			hire_date
		FROM employees
		WHERE department_id = 80;
		
--> Crear una tabla con el departamento 80

----------------------------------------------------

ALTER TABLE table_name
ADD "column_name"	"datatype" --> Añadir columna a una tabla existente

ALTER TABLE table_name
DROP COLUMN	"column_name" --> Borrar columna


ALTER TABLE table_name
MODIFY COLUMN	"column_name" --> MOdificar columna

ALTER TABLE table_name READ ONLY/READ WRITE;

ALTER TABLE table_name
RENAME COLUMN "column_name" TOP name; --> Cambiar nombre de la columna

ALTER TABLE table_name
RENAME TO "new_table_name"; --> Cambiar nombre de la table

----------------------------------------------------

DROP TABLE "table_name" --> Borrar tabla a una papelera

----------------------------------------------------

TRUNCATE TABLE "table_name" --> Borra definitivamente una tabla
