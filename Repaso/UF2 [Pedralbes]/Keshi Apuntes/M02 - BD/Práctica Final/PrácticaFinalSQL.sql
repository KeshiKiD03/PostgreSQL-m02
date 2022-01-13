/* Proyecto FINAL BD de Películas UF2 
Autor: Aaron Andal
Fecha: 01/02/2015
*/

!------- Ejercicio 1 Creación de TABLAS PELÍCULAS--------!

	!-- TABLA MEMBER --!
	
DROP TABLE MEMBER CASCADE CONSTRAINTS; !-- Todas las constraints asociadas a esta tabla las borrará --!
DROP TABLE TITLE CASCADE CONSTRAINTS; !-- El orden es importante --!
DROP TABLE TITLE_COPY CASCADE CONSTRAINTS;
DROP TABLE RENTAL CASCADE CONSTRAINTS;
DROP TABLE RESERVATION CASCADE CONSTRAINTS;
DROP SEQUENCE member_id_seq; /* Borramos las secuencias */
DROP SEQUENCE title_id_seq;
DROP VIEW title_avail; /* Borramos las vistas también */

CREATE TABLE MEMBER
(
	MEMBER_ID	NUMBER(10),
	LAST_NAME	VARCHAR2(25) NOT NULL,
	FIRST_NAME	VARCHAR2(25),
	ADDRESS		VARCHAR2(100),
	CITY		VARCHAR2(30),
	PHONE		VARCHAR2(15),
	JOIN_DATE	DATE DEFAULT SYSDATE NOT NULL,
	
	CONSTRAINT mem_mem_id_pk PRIMARY KEY (MEMBER_ID)
);

DESC MEMBER;

	!-- TABLA TITLE --!

CREATE TABLE TITLE
(
	TITLE_ID	NUMBER(10),
	TITLE		VARCHAR2(60) NOT NULL,
	DESCRIPTION	VARCHAR2(400) NOT NULL,
	RATING		VARCHAR2(4),
	CATEGORY		VARCHAR2(20),
	RELEASE_DATE	DATE,
	
	CONSTRAINT tit_titl_id_pk PRIMARY KEY (TITLE_ID),
	CONSTRAINT tit_rat CHECK(RATING IN ('G','PG','R','NC17','NR')),
	CONSTRAINT tit1_rat CHECK(CATEGORY IN ('DRAMA','COMEDY','ACTION','CHILD','SCIFI','DOCUMENTARY'))
		
		/* A nivel de columna sin COMA y sin especificacion y a nivel de tabla con COMA con especificacion */
);

DESC TITLE;


	!-- TABLA TITLE_COPY --!

CREATE TABLE TITLE_COPY
(
	COPY_ID			NUMBER(10),
	TITLE_ID		NUMBER(10),
	STATUS			VARCHAR2(15) NOT NULL,
		
	CONSTRAINT titc_status CHECK(STATUS IN ('AVAILABLE','DESTROYED','RENTED','RESERVED')),
	CONSTRAINT titc_title1_fk FOREIGN KEY (TITLE_ID)
		REFERENCES TITLE (TITLE_ID),
	CONSTRAINT titc_copytitle PRIMARY KEY (COPY_ID, TITLE_ID)
);

DESC TITLE_COPY;


	!-- TABLA RENTAL --!

CREATE TABLE RENTAL
(
	BOOK_DATE		DATE DEFAULT SYSDATE,
	MEMBER_ID		NUMBER(10),
	COPY_ID			NUMBER(10),
	ACT_RET_DATE	DATE,
	EXP_RET_DATE	DATE DEFAULT SYSDATE + 2,
	TITLE_ID		NUMBER(10),
	
	CONSTRAINT mem_bodatememcopytitle_pk PRIMARY KEY (BOOK_DATE, MEMBER_ID, COPY_ID, TITLE_ID),
  	CONSTRAINT mem_member1_fk FOREIGN KEY (MEMBER_ID)
		REFERENCES MEMBER (MEMBER_ID),
	CONSTRAINT mem_title1copy_fk FOREIGN KEY (TITLE_ID, COPY_ID)
		REFERENCES TITLE_COPY (TITLE_ID, COPY_ID)	
);

DESC RENTAL;


	!-- TABLA RESERVATION --!

CREATE TABLE RESERVATION
(
	RES_DATE		DATE,
	MEMBER_ID		NUMBER(10),
	TITLE_ID		NUMBER(10),
		
	CONSTRAINT mem_res_date_mem_tit_pk PRIMARY KEY (RES_DATE, MEMBER_ID, TITLE_ID),
	CONSTRAINT mem_mem2_fk FOREIGN KEY (MEMBER_ID)
		REFERENCES MEMBER (MEMBER_ID),
	CONSTRAINT mem_title3_fk FOREIGN KEY (TITLE_ID)
		REFERENCES TITLE (TITLE_ID)
		
);

DESC RENTAL;


!------- 2 MODELO ER --------!

/* VERIFICAR DIA (ARCHIVO ADJUNTO) del RAR */

!------- 3 VERIFICAR QUE TODO ESTÉ CORRECTO --------!

SELECT *
FROM title;

SELECT *
FROM title_copy;

SELECT *
FROM rental;

SELECT *
FROM reservation;

SELECT *
FROM USER_CONSTRAINTS; /* Vemos las constraints de todas las constraints */

/* COMMIT Se usa para confirmar la transacción de la modificación de la base de datos */

!------- 4 Creacion de Secuencias --------!

CREATE SEQUENCE member_id_seq
	START WITH 101
	NOCACHE;
	
CREATE SEQUENCE title_id_seq
	START WITH 92
	NOCACHE;

select *
from all_sequences /* Con esto verificamos la creación */

!------- 5 Inserts de Registros --------!

/* INSERTS TABLA TITLE */

INSERT INTO TITLE (TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
	VALUES (
	title_id_seq.NEXTVAL,
	'Willie and Christmas Too', 
	'All of Willie’s friends made a Christmas list for Santa, but Willie has yet to add his own wish list', 
	'G', 
	'CHILD',
	'05-OCT-95'
);

INSERT INTO TITLE (TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
	VALUES (
	title_id_seq.NEXTVAL,
	'Alien Again', 
	'Yet another installation of science fiction history. Can the heroine save the planet from the alien life form?', 
	'R', 
	'SCIFI',
	'19-MAY-95'
);

INSERT INTO TITLE (TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
	VALUES (
	title_id_seq.NEXTVAL,
	'The Glob',
	'A meteor crashes near a small American town and unleashed carnivorous goo in this classic.',
	'NR', 
	'SCIFI',
	'12-AUG-95'
);

INSERT INTO TITLE (TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
	VALUES (
	title_id_seq.NEXTVAL,
	'My Day Off', 
	'With a little luck and a lot of ingenuity, a teenager skips school for a day in New York.', 
	'PG', 
	'COMEDY',
	'12-JUL-95'
);

INSERT INTO TITLE (TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
	VALUES (
	title_id_seq.NEXTVAL,
	'Miracles on Ice', 
	'A six-year-old has doubts about Santa Claus but she discovers that miracles really do exits.', 
	'PG', 
	'DRAMA',
	'12-SEP-95'
);

INSERT INTO TITLE (TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
	VALUES (
	title_id_seq.NEXTVAL,
	'Soda Gang', 
	'After discovering a cache of drugs,a young couple find themselves pitted against a vicious gang.', 
	'NR', 
	'ACTION',
	'01-JUN-95'
);

/* INSERTS TABLA MEMBER */

INSERT INTO MEMBER (MEMBER_ID, FIRST_NAME, LAST_NAME, ADDRESS, CITY, PHONE, JOIN_DATE)
	VALUES (
	member_id_seq.NEXTVAL,
	'Carmen', 
	'Velasquez', 
	'283 King Street', 
	'Seattle',
	206-899-6666,
	'08-MAR-90'
);

INSERT INTO MEMBER (MEMBER_ID, FIRST_NAME, LAST_NAME, ADDRESS, CITY, PHONE, JOIN_DATE)
	VALUES (
	member_id_seq.NEXTVAL,
	'LaDoris', 
	'Ngao', 
	'5 Mondrany', 
	'Bratislava',
	886-355-8882,
	'08-MAR-90'
);


INSERT INTO MEMBER (MEMBER_ID, FIRST_NAME, LAST_NAME, ADDRESS, CITY, PHONE, JOIN_DATE)
	VALUES (
	member_id_seq.NEXTVAL,
	'Midori', 
	'Nagayama', 
	'68 Via Centrale', 
	'Sao Paulo',
	254-852-5764,
	'17-JUN-91'
);


INSERT INTO MEMBER (MEMBER_ID, FIRST_NAME, LAST_NAME, ADDRESS, CITY, PHONE, JOIN_DATE)
	VALUES (
	member_id_seq.NEXTVAL,
	'Mark', 
	'Lewis', 
	'6921 King Way', 
	'Lagos',
	63-559-7777,
	'18-JAN-91'
);


INSERT INTO MEMBER (MEMBER_ID, FIRST_NAME, LAST_NAME, ADDRESS, CITY, PHONE, JOIN_DATE)
	VALUES (
	member_id_seq.NEXTVAL,
	'Audry', 
	'Ropeburn', 
	'86 Chu Street', 
	'Hong Kong',
	41-559-87,
	'07-APR-90'
);


INSERT INTO MEMBER (MEMBER_ID, FIRST_NAME, LAST_NAME, ADDRESS, CITY, PHONE, JOIN_DATE)
	VALUES (
	member_id_seq.NEXTVAL,
	'Molly', 
	'Urguhart', 
	'3035 Laurier', 
	'Quebec',
	418-542-9988,
	'18-JAN-91'
);
 
/* INSERTS TABLA TITLE_COPY */

INSERT INTO TITLE_COPY (COPY_ID, TITLE_ID, STATUS)
	VALUES 
( 	
	1,	
	(select title_id
		from title
		where title like 'Willie and Christmas Too'), 
	'AVAILABLE' 
);

INSERT INTO TITLE_COPY (COPY_ID, TITLE_ID, STATUS)
	VALUES 
( 	
	1,	
	(select title_id
		from title
		where title like 'Alien Again'), 
	'AVAILABLE' 
);

INSERT INTO TITLE_COPY (COPY_ID, TITLE_ID, STATUS)
	VALUES 
( 	
	2,	
	(select title_id
		from title
		where title like 'Alien Again'), 
	'RENTED' 
);

INSERT INTO TITLE_COPY (COPY_ID, TITLE_ID, STATUS)
	VALUES 
( 	
	1,	
	(select title_id
		from title
		where title like 'The Glob'), 
	'AVAILABLE' 
);

INSERT INTO TITLE_COPY (COPY_ID, TITLE_ID, STATUS)
	VALUES 
( 	
	1,	
	(select title_id
		from title
		where title like 'My Day Off'), 
	'AVAILABLE' 
);

INSERT INTO TITLE_COPY (COPY_ID, TITLE_ID, STATUS)
	VALUES 
( 	
	2,	
	(select title_id
		from title
		where title like 'My Day Off'), 
	'AVAILABLE' 
);

INSERT INTO TITLE_COPY (COPY_ID, TITLE_ID, STATUS)
	VALUES 
( 	
	3,	
	(select title_id
		from title
		where title like 'My Day Off'), 
	'RENTED' 
);

INSERT INTO TITLE_COPY (COPY_ID, TITLE_ID, STATUS)
	VALUES 
( 	
	1,	
	(select title_id
		from title
		where title like 'Miracles on Ice'), 
	'AVAILABLE' 
);

INSERT INTO TITLE_COPY (COPY_ID, TITLE_ID, STATUS)
	VALUES 
( 	
	1,	
	(select title_id
		from title
		where title like 'Soda Gang'), 
	'AVAILABLE' 
);



/* INSERTS TABLA RENTAL */

INSERT INTO RENTAL (BOOK_DATE, MEMBER_ID, COPY_ID, ACT_RET_DATE, EXP_RET_DATE, TITLE_ID)
	VALUES (	SYSDATE - 3, 	101, 	1, 	SYSDATE - 2, 	SYSDATE - 1, 	92 );

INSERT INTO RENTAL (BOOK_DATE, MEMBER_ID, COPY_ID, ACT_RET_DATE, EXP_RET_DATE, TITLE_ID)
	VALUES (	SYSDATE - 1,	101,	2,	NULL,	SYSDATE,	93 );


INSERT INTO RENTAL (BOOK_DATE, MEMBER_ID, COPY_ID, ACT_RET_DATE, EXP_RET_DATE, TITLE_ID)
	VALUES (	SYSDATE - 2,	102,	3,	NULL,	SYSDATE,	95 );


INSERT INTO RENTAL (BOOK_DATE, MEMBER_ID, COPY_ID, ACT_RET_DATE, EXP_RET_DATE, TITLE_ID)
	VALUES (	SYSDATE - 4,	106,	1,	SYSDATE - 2,	SYSDATE - 2 ,	97 );

!-- 6 Creacion de la vista TITLE_AVAIL --!

/* Una vista es una consulta de una tabla, pero la utilizamos para el fin de restringir ciertas columnas para ciertos usuarios
Una vista es como una tabla nueva pero con las columnas que hemos seleccionado | Son como subtablas
Hay consultas simples y complejas
Vista complejas son el resultado de una operación de las consultas una o más tablas */

/* Con JOIN */

CREATE VIEW TITLE_AVAIL
(title, copy_id, status, exp_ret_date)
AS SELECT t.title, c.copy_id,
c.status,r.exp_ret_date
FROM title_copy c JOIN rental r
ON (c.title_id = r.title_id)
JOIN title t
ON (r.title_id = t.title_id);

/* Con WHERE */

CREATE VIEW TITLE_AVAIL
(title, copy_id, status, exp_ret_date)
AS SELECT t.title, c.copy_id, c.status, r.exp_ret_date
FROM title t, title_copy c, rental r
WHERE t.title_id = c.title_id AND t.title_id = r.title_id;

!-- 7 Inserción de Interstellar Wars en TABLA TITLE --!

/* A Insertar Intellar Wars en TABLA TITLE */

INSERT INTO TITLE (TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
	VALUES (
	title_id_seq.NEXTVAL,
	'Interstellar Wars', 
	'Futuristic interstellar actino movie. Can the rebels save the humans from the evil Empire?', 
	'PG', 
	'SCIFI',
	'07-JUL-77'
);

/* Insertamos 2 copias para la tabla TITLE_COPY*/

INSERT INTO TITLE_COPY (COPY_ID, TITLE_ID, STATUS)
	VALUES ( 1, (select title_id from title
				where title like 'Int%'), 'AVAILABLE' );
	
INSERT INTO TITLE_COPY (COPY_ID, TITLE_ID, STATUS)
	VALUES ( 2, (select title_id from title
				where title like 'Int%'), 'AVAILABLE' );
	

/* B Insertar 2 Reservas en TABLA RESERVATION */

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

INSERT INTO RESERVATION (RES_DATE, MEMBER_ID, TITLE_ID) /* Mark */
	VALUES (
	SYSDATE + 15,
	(select member_id
		from member
		where first_name = 'Mark'), 
	(select title_id
		from title
		where title like 'Soda%')
);

/* C Borrar y Registrar alquilar pelicula de Carmen */

 !-- Actualizamos a RENTED y Borramos la reserva --!

update title_copy
set status='RENTED'
where title_id = (select title_id 
					from title 
					where title like 'Int%') AND copy_id = 1;
					
/* Hacemos una select para verificar que esta cambiado y que se hizo correctamente */ 

select * from title_copy;


delete from reservation /*  Borramos la reserva */
where member_id = (select member_id 
					from member
					where first_name like 'Carm%');
	
!-- 8 Modificar tabla TITLE para añadir columna --!

/* A Insertar columna price para la tabla TITLE */

ALTER TABLE TITLE
ADD PRICE		NUMBER(8,2);

DESC TITLE;

!-- 9 Query modificar VIDEO - PRECIO --!

/* Actualizamos la TABLA TITLE */

update title
set price = &precio
where title_id = &id;

/* Hacemos una select para ver el resultado del update */

select title, price
from title;

!-- 10 Query Historico Clientes --!

SELECT m.FIRST_NAME || '  ' || m.LAST_NAME "Member" , t.TITLE, r.BOOK_DATE, to_number((r.ACT_RET_DATE)-(r.BOOK_DATE)) "Duration"
FROM title t JOIN rental r
ON (t.title_id = r.title_id)
JOIN member m
ON (m.member_id = r.member_id);
