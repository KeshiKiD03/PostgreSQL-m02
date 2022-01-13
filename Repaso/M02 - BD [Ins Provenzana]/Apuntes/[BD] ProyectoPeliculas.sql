
-- PRIMER PASO BORRAR TODO --

DROP TABLE MEMBER CASCADE CONSTRAINTS; !-- Todas las constraints asociadas a esta tabla las borrará --!
DROP TABLE TITLE CASCADE CONSTRAINTS; !-- El orden es importante --!
DROP TABLE TITLE_COPY CASCADE CONSTRAINTS;
DROP TABLE RENTAL CASCADE CONSTRAINTS;
DROP TABLE RESERVATION CASCADE CONSTRAINTS;
DROP SEQUENCE member_id_seq; /* Borramos las secuencias */
DROP SEQUENCE title_id_seq;
DROP VIEW title_avail; /* Borramos las vistas también */


----------------------------------------------------------------------------------------

	--------------------------------------
    --    |	PELICULAS Proyecto  | 	--
	--------------------------------------

CREATE TABLE dept
	(deptno	 	NUMBER(2),
	dname 		VARCHAR2(14),
	loc 		VARCHAR2(13),
	create_date DATE DEFAULT SYSDATE);

-------------------------------------------------

CREATE TABLE MEMBER
(
	MEMBER_ID	NUMBER(10), --> NO SE PONE NOT NULL NI UNIQUE --> PK Incluye los 2
	LAST_NAME	VARCHAR2(25) NOT NULL,
	FIRST_NAME	VARCHAR2(25),
	ADDRESS		VARCHAR2(100),
	CITY		VARCHAR2(30),
	PHONE		VARCHAR2(15),
	JOIN_DATE	DATE DEFAULT SYSDATE NOT NULL, --> DEFAULT FECHA DEL SISTEMA
	
	CONSTRAINT mem_mem_id_pk PRIMARY KEY (MEMBER_ID) --> Crea una constraint a nivel de col
);

----------------------------------------------------

DESC tabla --> Confirma la tabla

----------------------------------------------------

CONSTRAINT tit_rat CHECK(RATING IN ('G','PG','R','NC17','NR')), --> Constraints con check para que verifique los datos que sean ciertos.
CONSTRAINT tit1_rat CHECK(CATEGORY IN ('DRAMA','COMEDY','ACTION','CHILD','SCIFI','DOCUMENTARY'))
	

----------------------------------------------------

CONSTRAINT mem_bodatememcopytitle_pk PRIMARY KEY (BOOK_DATE, MEMBER_ID, COPY_ID, TITLE_ID), --> 2 o más PK se hacen a nivel de TABLA.

----------------------------------------------------

SELECT *
FROM USER_CONSTRAINTS; --> Ver las constraints del sistema

----------------------------------------------------

CREATE SEQUENCE member_id_seq
	START WITH 101
	NOCACHE; --> Crear una secuencia que empiece por 101 y que no cache

----------------------------------------------------

INSERT INTO TITLE (TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
	VALUES (
	title_id_seq.NEXTVAL,
	'Willie and Christmas Too', 
	'All of Willie’s friends made a Christmas list for Santa, but Willie has yet to add his own wish list', 
	'G', 
	'CHILD',
	'05-OCT-95'
); --> Insertar datos [SIEMPRE EN ORDEN], comillas simples texto y fechas.
--> Se usa una secuencia para añadir un valor numérico a la primary KEY

----------------------------------------------------

INSERT INTO TITLE_COPY (COPY_ID, TITLE_ID, STATUS)
	VALUES 
( 	
	1,	
	(select title_id
		from title
		where title like 'Willie and Christmas Too'), 
	'AVAILABLE' 
); --> Insertar registros con SUB-Consultas

-- NOTA: La SELECT de la subconsulta siempre siempre tiene que coincidir con la columna del INSERT.
-- Ya después podremos introducir lo que queramos con el where

----------------------------------------------------


INSERT INTO RENTAL (BOOK_DATE, MEMBER_ID, COPY_ID, ACT_RET_DATE, EXP_RET_DATE, TITLE_ID)
	VALUES (	SYSDATE - 3, 	101, 	1, 	SYSDATE - 2, 	SYSDATE - 1, 	92 );

--> Insertar valores de la fecha de sistema -3 o +1 días depende

----------------------------------------------------

CREATE VIEW TITLE_AVAIL
(title, copy_id, status, exp_ret_date)
AS SELECT t.title, c.copy_id,
c.status,r.exp_ret_date
FROM title_copy c JOIN rental r
ON (c.title_id = r.title_id)
JOIN title t
ON (r.title_id = t.title_id); 

--> Creación de una vista con 2 JOINS de 3 tablas.
--> Siempre IGUALAR los campos iguales
	--- En este caso el ID de los 3

----------------------------------------------------

CREATE VIEW TITLE_AVAIL
(title, copy_id, status, exp_ret_date)
AS SELECT t.title, c.copy_id, c.status, r.exp_ret_date
FROM title t, title_copy c, rental r
WHERE t.title_id = c.title_id AND t.title_id = r.title_id;

--> El mismo pero con WHERE

----------------------------------------------------

INSERT INTO RESERVATION (RES_DATE, MEMBER_ID, TITLE_ID) /* Carmen */
	VALUES (
	SYSDATE + 10,
	(select member_id
		from member
		where first_name = 'Carmen'), 
	(select title_id
		from title
		where title like 'Int%')
);

--> Insertar registros con SUBCONSULTAS
--> Si se usa LIKE --> Obligatóriamente con Comodines y comillas
--> Si se usa = no hace falta pero si comillas

----------------------------------------------------

update title_copy
set status='RENTED'
where title_id = (select title_id 
					from title 
					where title like 'Int%') AND copy_id = 1;
					
--> UPDATE con SUBCONSULTAS
--> Actualizar a RENTED y donde el TITLE_ID que empiece con Int% y que tenga copy_id= 1
----------------------------------------------------

ALTER TABLE TITLE
ADD PRICE		NUMBER(8,2); --> Añadir una nueva columna

----------------------------------------------------

update title
set price = &precio
where title_id = &id;

--> Hacer un update a una columna vacía y asigarle el precio que introduzca el usuario
--> Y su respectivo ID para FILTRAR

----------------------------------------------------

SELECT m.FIRST_NAME || '  ' || m.LAST_NAME "Member" , t.TITLE, r.BOOK_DATE, to_number((r.ACT_RET_DATE)-(r.BOOK_DATE)) "Duration"
FROM title t JOIN rental r
ON (t.title_id = r.title_id)
JOIN member m
ON (m.member_id = r.member_id);

--> Consulta con JOIN


----------------------------------------------------
