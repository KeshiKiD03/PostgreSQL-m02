------------------------
-- BASE DE DATOS 2022 --
------------------------

<!---
# Plantilla H1
## Plantilla H2
### Plantilla H3
-->
<!--- <img src="https://phoneky.co.uk/thumbs/screensavers/down/original/linux_3rj131p8.gif" />
-->

⭐️ **PLANTILLA** ⭐️

| 🔥PLANTILLA TABLA❗🔥 | 
| ------------- |
| *Plantilla* |


--------------------------------------------------------------------------------

13.12.01 - Instalación SQL

https://gitlab.com/isx-m02-m10-bd/uf2-sql-ddl-i-dml-public/-/raw/main/introduccio/0_install_config_postgreSQL.md

https://gitlab.com/jandugar/m02-bd/-/blob/master/UF2_SQL/apunts/0_install_config_postgreSQL_DEBIAN.md --> INSTALACIÓN DEBIAN

https://gitlab.com/jandugar/m02-bd

\du --> Ver tu usuario

https://www.freecodecamp.org/news/learn-sql-in-10-minutes/

https://learnsql.com/blog/sql-basics-cheat-sheet/sql-basics-cheat-sheet-a4.pdf

--------------------------------------------------

Programación del CURSO UF3						Horas

UF3 Assegurament de la informació 					49
AEA04 Llenguatge DML: Modificacions 					8
AEA05 Llenguatge TCL: Control de transaccions i concurrència. 	4
AEA06 Llenguatge DDL: creació de l’estructura de la base de dades 	12
AEA07 Salvaguarda i recuperació de Dades 				13
AEA08 Transferència de Dades 						12

---------------------------------------------------

### POSTGRESQL

* Es un gestor de bases de datos relacional y orientado a objetos. Su licencia y desarrollo es de código abierto, siendo mantenida por una comunidad de desarrolladores, colaboradores y organizaciones comerciales de forma libre y desinteresadamente. Esta comunidad es denominada PDGD (PostgreSQL Global Development Group, por sus siglas en inglés).

# INSTALACIÓN

* apt-get update

* # apt-get install  postgresql postgresql-contrib

* dpkg -l | grep postgres

* pg_ctlcluster 13 main start

* getent passwd postgres

* # passwd postgres

* # systemctl status postgresql

---

2. Creación de mi usuario al servidor de PostgreSQL

* su -l postgres

* psql template1

* # CREATE USER keshi CREATEDB;

* \du

---

3. Creación de la Base de Datos Training

* whoami

* $ psql template1

* => CREATE DATABASE training;

* \l --> Para listar todas las bases disponibles.

* \c training --> Para conectarse a la base de datos Training.

* \i /ruta/script.sql --> Cargará el script, donde creará la estructura de la base de datos a nivel de tablas **DDL** y cargará los datos **DML**.

* \d --> Visualizamos las tablas de nuestra base de datos

* \d OFICINA --> Visualizamos la estructura de una de las tablas importadas.

* \q --> Finaliza la sesión con el servidor o CTRL + D


------

5. Conexión a la BD training con nuestro usuario

* $ psql training

* => SELECT * FROM OFICINA;

* \q --> Salir del PSQL

------

6. Eliminación de la base de datos Training del RDBMS Postgres

* su -l postgres

* $ psql template1 --> Se conecta al servidor de postgres con el client psql, a la base de datos de template1.

* DROP DATABASE "template1" --> Elimina base de datos.

* \l --> Muestra todas las bases disponibles

* \q --> sale de la base datos

* exit

--------

7. Desinstalar el servidor PostgreSQL

* su -l

* systemctl stop postgresql

* # apt-get purge postgresql postgresql-contrib 
* # apt-get autoremove 

* # rm -rf /var/lib/postgresql/13/main  

* exit

-------

9. Ajuda e instalación de doc local

* => \h

* => \?

* su -l

* # apt-get install postgresql-doc

* # exit

$ firefox /usr/share/doc/postgresql-doc-13/html/index.html &


---------









### DDL --> Data Definition Language --> Estructura

## CREATE [DATABASE] [TABLE]


   * Comprendre la funció de definició de dades
   
   * Comprendre i aplicar els tipus de restriccions.
   
   * Crear taules amb les seves pròpies restriccions (CREATE table)
   
   * Esborrar i modificar les taules (DROP table i ALTER table)
   
   * Tenir la capacitat d'entendre els errors (derivats d'un ús incorrecte del SQL) i de solucionar-los.


## Llenguatge de definició de dades (DDL)

- Llenguatge d'un SGBD que permet _definir_ (crear/modificar/esborrar) les estructures necessàries per gestionar una base de dades.

- Les estructures (objectes) principals que manipularem seran:

	+ Taules
	+ Vistes
	+ Índexs
	+ Usuaris

- Les sentències SQL que usarem són:

	+ CREATE (crea)
	+ DROP (esborra)
	+ ALTER (modifica)

## Taula

- És la unitat bàsica d'emmagatzematge amb una determinada estructura (camps) i un contingut (files).
- Regles per posar nom a una taula:
	+ Han de començar per una lletra.
	+ Poden tenir una longitud de 1-30 caràcters de llarg.
	+ Han de contenir només A-Z, a-z, 0-9, \_
	+ No han de duplicar el nom d'un altre objecte a dintre del mateix `esquema`
	+ No ha de ser una paraula reservada del servidor de bases de dades.

> _Important_: postgres a les taules els hi diu _relations_



⭐️ **SINTAXIS** ⭐️
-------------------

```
CREATE DATABASE base_dades; --> Crea una base de DATOS
```

```
CREATE TABLE taula (
	PRIMARY KEY(camp_1),
	camp_1	_tipus_de_dades_	[restricció a nivell de camp],
	camp_2	_tipus_de_dades_	[restricció a nivell de camp],
	...		 ...				...
	camp_n	_tipus_de_dades_	[restricció a nivell de camp],
			[restricció_1 a nivell de taula],
			[restricció_2 a nivell de taula]
			...
);
```





-------------------


⭐️ **EJEMPLOS** ⭐️
-------------------

* Crear una tabla clients2 

```
CREATE TABLE clients2 (
	PRIMARY KEY(num_clie),
	num_clie		smallint,
	empresa		character varying(20)	NOT NULL,
	rep_clie		smallint 			NOT NULL REFERENCES rep_vendes 
	limit_credit	numeric(8,2),
);
```

* Crear una tabla empleat

```
CREATE TABLE empleat(
	PRIMARY KEY (empno),
	empno	SMALLINT, 
	ename	VARCHAR(10),
);
```

-------------------

## DEFAULT

* Es pot especificar un valor per defecte per a un camp, de manera que quan es realitzi l'inserció d'una fila sense valor per a aquest camp, prendrà el que estigui definit per defecte.

⭐️ **SINTAXIS** ⭐️
-------------------
```
CREATE TABLE emp (
	...
	hiredate DATE DEFAULT current_date,
	...
);
```
-------------------

## TIPOS DE DATOS (PARA CREATE TABLE)

### NUMÉRICO

* Enteros:

	* SMALLINT
	
	* INTEGER
	
	* BIGINT

* Reales con precisión exacta:

	* NUMERIC

* Reales con precisión inexacta:

	* REAL
	
	* DOUBLE PRECISION

* Campo autoincremental:

	* SMALLSERIAL
	
	* SERIAL
	
	* BIGSERIAL
	



### Monetari: money

+ Per comprovar quin tipus de moneda:

	```
	SHOW lc_mone
	```

##  Caràcters

+ Longitud variable amb límit: 

	* character varying(n), varchar(n)

+ Longitud fixa (s'omple amb espais en blanc): 

	* character(n), char(n)

+ Longitud il·limitada: 

	* text

## Data/hora

+ Data i hora sense zona horària: 

	* timestamp

+ Data i hora amb zona horària: 

	* timestamp with time zone

+ Data: 

	* date

+ Hora sense zona horària: 

	* time

+ Hora amb zona horària: 

	* time with time zone

+ Interval de temps: 

	* interval

+ DateStyle: 

	*té dos components 
	
	* el primer ens denota com es mostraran les dates: ISO, SQL, Postgres, German
	
	* el segon ens denota l'ordre de dia, mes, any de la data d'entrada si és que hi ha confusió: DMY, MDY, YMD

	- Mostrar el valor de DateStyle
		```
		SHOW DateStyle;
		```
	- Establir el valor de DateStyle
		```
		SET DateStyle TO ISO, DMY;
		```
		```
		SET DateStyle TO German, DMY;
		```
## Booleà: boolean

+ Valors per cert: TRUE, 't', 'true', 'y', 'yes', 'on', '1'
+ Valors per fals: FALSE, 'f', 'false', 'n', 'no', 'off', '0'

## Geomètric:

+ Punt: point, '(x,y)'

+ Recta: line, '((x1,y1),(x2,y2))'

+ Segment: lseg, '((x1,y1),(x2,y2))'

+ Rectangle: box, '((x1,y1),(x2,y2))'

+ Polígon: path, polygon, '((x1,y1),...)'

+ Camí: path '[(x1,y1),...]'

+ Cercle: circle, '<(x,y),r>' (centre i radi)

## Adreces de xarxa:

+ Xarxes IPv4 i IPv6: cidr

+ Xarxes i hosts IPv4 i IPv6: inet

+ Adreça MAC: macaddr

## UUID:

+ uuid

## XML:

+ xml: valida que el text introduït estigui ben format, sinó dóna error.




-------------------

## HERENCIA 



* Hereda los CAMPOS de una TABLA a otra TABLA.

*



-------------------

## CONSTRAINTS (Restricciones)

### Definició i tipus de constraints.

* Les restriccions (CONSTRAINT) són regles que s'apliquen sobre les *taules* i que el SGBD s'encarrega de verificar abans de cada **operació DML** **(INSERT, UPDATE, DELETE)**.

* Hi ha 5 tipus de restriccions. 

* Les més importants són les de clau primària i clau aliena.

- **PRIMARY KEY**: clau primària
- **FOREIGN KEY / REFERENCES**: clau forana / aliena, per assegurar la integritat referencial. 
- **NOT NULL**: la columna no pot ser nul.
- **UNIQUE**: cada valor ha de ser únic a la columna. [Més info](http://stackoverflow.com/questions/9565996/difference-between-primary-key-and-unique-key) 
- **CHECK**: comprova que el camp compleixi una condició.

-------------------

⭐️ **SINTAXIS** ⭐️
-------------------

> Constraints should be given a custom name excepting **UNIQUE**, **PRIMARY KEY** and **FOREIGN KEY** where the database vendor will generally supply sufficiently intelligible names automatically.

Necessitem que quan hi hagi un **error** perquè s'ha incomplert una restricció la identifiquem de seguida. Suposarem que el fabricant del SGBDR ens proporcionarà un nom identificable per **UNIQUE**, **PRIMARY KEY **i FOREIGN KEY. Però per la **CHECK** li donarem un nom de format:

`nom_taula_nom_camp_ck`

Hi ha un altre estil també molt utilitzat que és fer servir aquesta notació per les altres restriccions. Es substitueix _ck_ per _pk_, _fk_, _nn_, _uk_. 

```
CREATE TABLE DEPT (
	PRIMARY KEY(deptno),
	deptno	SMALLINT,
	dname		VARCHAR(14) CONSTRAINT dept_dname_ck CHECK(dname LIKE 'Dept.%'),
	loc		VARCHAR(13),
);
```

-------------------

## ⭐️ **PRIMARY KEY** ⭐️
-------------------

- Restricció que s'aplica als camps que són clau primària (CP).
- Impedeix que s'insereixin valors repetits o nuls
- Quan la CP és simple, es pot definir a nivell de columna (al costat del tipus de dades) o a nivell de taula (al final de la definició de la taula).
- Quan sigui composta, la definirem a nivell de taula (al final de la definició)



## EJEMPLOS


Ja hem vist com posarem nosaltres la clau primària: com la primera línia.
 
Però veurem altres maneres de representar-les:
 
- **Clave Primaria SIMPLE**, definida a nivell de camp:
	```
	CREATE TABLE dept (
		deptno	SMALLINT CONSTRAINT dept_deptno_pk PRIMARY KEY,
		dname		VARCHAR(14),
		loc		VARCHAR(13)
	);
	```

- **Clave Primaria, definida a nivell de taula** (en comptes de la primera línia, al final)

	```
	CREATE TABLE dept (
		deptno	SMALLINT,
		dname		VARCHAR(14),
		loc		VARCHAR(13),
				CONSTRAINT dept_deptno_pk PRIMARY KEY(deptno)
	);
	```

- **Clave Primaria composta**: obligatori declarar-la a nivell de taula.

	```
	CREATE TABLE productes (
		PRIMARY KEY(id_fabricant,id_producte),
		id_fabricant    CHARACTER(3),
		id_producte     CHARACTER(5),
		descripcio      CHARACTER VARYING(20)   NOT NULL,
		preu            NUMERIC(7,2)            NOT NULL,
		estoc           INTEGER
	);
	```




-------------------

## ⭐️ **FOREIGN KEY** ⭐️
-------------------

- La **integritat referencial** exigeix que el valor d'una columna que és clau forània, hagi d'existir com a clau primària de la taula relacionada.
	Exemple: Si a la taula _clients_, un registre, o sigui un fila, té el camp rep_clie amb valor 108, haurà d'existir una fila a rep_vendes amb num_empl 108.
- Serveix per identificar la clau forana (CF) i permetre recuperar informació entre diferentes taules a través de l'operacio de JOIN. 
- Si la CF és simple, es pot definir a nivell de camp o a nivell de taula.  
- Si la CF és composta, només es podrà definir a nivell de taula.



## EJEMPLO

- CF simple, a nivell de camp

```
	CREATE TABLE emp (
		PRIMARY KEY(empno),
		empno		SMALLINT,
		ename		VARCHAR(10),
		job		VARCHAR(9),
		mgr		SMALLINT,
		hiredate	DATE,
		sal		NUMERIC(7, 2),
		comm		NUMERIC(7, 2),
		deptno	SMALLINT		REFERENCES dept
	);
```

REFERENCES: denota que és clau forània, força integritat referencial en afegir files.

- CF simple, a nivell de taula

```
	CREATE TABLE emp (
		PRIMARY KEY(empno),
		empno 	SMALLINT,
		ename 	VARCHAR(10),
		job 		VARCHAR(9),
		mgr 		SMALLINT,
		hiredate	DATE,
		sal 		NUMERIC(7, 2),
		comm 		NUMERIC(7, 2),
		deptno	SMALLINT,
 				CONSTRAINT emp_deptno_fk REFERENCES dept(deptno)
	);
```


## ALTER

# Tenim problemes quan creem una CF?

Si tenim problemes a l'hora d'afegir una clau forana a una taula, sempre la podrem afegir amb posterioritat a la creació a la taula. Això serà útil quan tenim dues taules que s'apunten mutuament amb les claus alienes o en el cas de relacions reflexives. Ho farem amb l'ordre `ALTER`.

Exemple:

```
CREATE TABLE emp (

		PRIMARY KEY(empno),
		empno		SMALLINT,
		ename		VARCHAR(10),
		job		VARCHAR(9),
		mgr		SMALLINT,
		hiredate	DATE,
		sal		NUMERIC(7, 2),
		comm		NUMERIC(7, 2),
);

ALTER TABLE  emp
ADD CONSTRAINT emp_mgr_fk FOREIGN KEY (mgr) REFERENCES emp(empno);
```

⭐️ **SINTAXIS** ⭐️
-------------------

```
ALTER TABLE  emp
ADD CONSTRAINT emp_mgr_fk FOREIGN KEY (mgr) REFERENCES emp(empno);
```


-------------------


## Política a l'incomplir la integritat referencial


- `ON DELETE`: què fer si trenquem integritat referencial en esborrar una fila de la taula referenciada.
- `ON UPDATE`: què fer si trenquem integritat referencial en modificar una fila de la taula referenciada.

Possibles accions:

- RESTRICT: retorna un error i no es deixa fer l'operació.
- CASCADE: esborra o modifica les files afectades.
- SET DEFAULT: es posa el valor per defecte.
- SET NULL: es posa el valor a NULL.

```
CREATE TABLE clients (
	PRIMARY KEY (num_clie)
	num_clie 		SMALLINT,
	empresa 		CHARACTER VARYING(20)	NOT NULL,
	rep_clie 		SMALLINT 			NOT NULL 
								REFERENCES rep_vendes
					  			ON DELETE RESTRICT,
	limit_credit	NUMERIC(8,2),
);
```

```
INSERT INTO clients
VALUES (200, 'Bit', 108, 10000);
```

```
DELETE FROM rep_vendes
WHERE num_empl = 108;
```

```
CREATE TABLE clients (
	PRIMARY KEY (num_clie)
	num_clie 		SMALLINT,
	empresa 		CHARACTER VARYING(20)	NOT NULL,
	rep_clie 		SMALLINT 			NOT NULL 
								REFERENCES rep_vendes
					  			ON DELETE CASCADE,
	limit_credit	NUMERIC(8,2),
);
```

```
INSERT INTO clients
VALUES (200, 'Bit', 108, 10000);
```

```
DELETE FROM rep_vendes
WHERE num_empl = 108; 
```


⭐️ **EJEMPLOS** ⭐️
-------------------

-------------------


-------------------

## ⭐️ **CHECK** ⭐️
-------------------




## DROP

⭐️ **SINTAXIS** ⭐️
-------------------

-------------------



⭐️ **EJEMPLOS** ⭐️
-------------------

-------------------






### DQL --> Data Query Language --> SELECTS

## SELECT

⭐️ **SINTAXIS** ⭐️
-------------------

-------------------



⭐️ **EJEMPLOS** ⭐️
-------------------

------------------------------------------------------------






------------------------------------------------------------

-------------------



# JOINS




### DML

## INSERT


* Permite insertar filas a una tabla

* Los valores deben estar en la misma orden

* Los valores del tipo 'string' o 'date' se aplican con comillas simples --> ' '

⭐️ **SINTAXIS** ⭐️
-------------------

INSERT INTO tabla [(campo1 [, camp2 ...])]
VALUES (lista de valores separados por coma);
-------------------





⭐️ **EJEMPLOS** ⭐️
-------------------

* Método explícito: Solo especificando oficines. Hace falta especificar la palabra clave NULL

--
INSERT INTO oficines
VALUES (66, 'Barcelona', 'Sud', NULL, 111, 0);
--



* Método implícito: Omitiendo el campo de la lista

--
INSERT INTO oficines (oficina, ciutat, regio, director, vendes)
VALUES (66, 'Barcelona', 'Sud', 111, 0);
--

--------------------------------------

* Función CURRENT_DATE registra la fecha y hora actual.

--
INSERT INTO rep_vendes
VALUES (666, 'M. Rajoy', 68, 22, 'Representant Vendes', CURRENT_DATE, 104, 300000, 88888 );
--


* Función TO_DATE(text, format) convierte una **cadena** en una fecha en **segundos**, según el formato que se le pase.

--
INSERT INTO rep_vendes
VALUES ( 666, 'M. Rajoy', 68, 22, 'Representant Vendes',
	TO_DATE('1988-10-14', 'YYYY-MM-DD'), 104,
	300000, 88888 );
--

--------------------------------------

**AÑADIR VARIAS FILAS A UNA TABLA** --> **SUBCONSULTA**

* Se pueden añadir con la sentencia INSERT, mediante una subconsulta.

--
INSERT INTO directors(id, nom, carrec)
SELECT num_empl, nom, carrec
FROM rep_vendes
WHERE carrec = 'Dir Vendes';
--

* Ha de coincidir el número de columnas de la clausula INSERT con la de la subconsulta.

* No se usa la clausula **VALUES**.


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------

--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


## UPDATE

* Modifica filas existentes.

* Puede afectar a más de una fila al mismo tiempo.

* Se usa la clausula WHERE, para especificar.


⭐️ **SINTAXIS** ⭐️
-------------------
UPDATE taula
SET camp1 = valor1 [, camp2 = valor2]
[WHERE condicio/ns];
-------------------



⭐️ **EJEMPLOS** ⭐️
-------------------

--
UPDATE rep_vendes
SET oficina_rep = 21
WHERE num_empl = 666;
--

**IMPORTANTE**

* Si no se usa la clausula WHERE se modificarán todas las filas.

--
UPDATE rep_vendes
SET oficina_rep = 21;
--
**UPDATE 11** 

--------------------------------------

**Uso de subconsultas con UPDATE**

Se ha de modificar la categoria y la oficina del emplado 666, con los valores actuales que son 110.

--
UPDATE rep_vendes
	SET (carrec, oficina_rep) =
	(SELECT carrec, oficina_rep
		FROM rep_vendes
		WHERE num_empl = 110)
WHERE num_empl = 666;
--

--------------------------------------

**Cuidado con los errores de INTEGRIDAD**

--
UPDATE rep_vendes
	SET quota = 100000, oficina_rep = 91
	WHERE num_empl = 666;



ERROR: insert or update on table "rep_vendes"
violates foreign key constraint
"fk_rep_vendes_oficina_rep"
DETAIL: Key (oficina_rep)=(91)
is not present in table "oficines".
--

* Esto es porque no existe ninguna oficina 91 en la tabla OFICINES.

--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


-------------------



## DELETE

* Elimina filas existentes.

* Puede afectar a más de una fila al mismo tiempo.

* Se usa la clausula WHERE, para especificar.


⭐️ **SINTAXIS** ⭐️
-------------------
DELETE FROM taula
[WHERE condición/es];
-------------------



⭐️ **EJEMPLOS** ⭐️
-------------------

--
DELETE FROM comandes
WHERE num_comanda = 8888;
--

**IMPORTANTE**

* Si no se usa la clausula WHERE se modificarán todas las filas.

--
DELETE FROM comandes;
--
**DELETE 30** 

--------------------------------------

**Uso de subconsultas con DELETE**

Se ha de modificar la categoria y la oficina del emplado 666, con los valores actuales que son 110.

--
DELETE FROM rep_vendes
	WHERE oficina_rep = ANY
		(SELECT oficina
		FROM oficines
		WHERE regio ='Est');
--

* «Elimina els venedors que siguin d’una oficina de la regió Est.»

* En una subconsulta puede retornar más de una fila. Hemos de especificar el operador multiregistro **ANY**.


--------------------------------------

**Cuidado con los errores de INTEGRIDAD**

--
DELETE FROM rep_vendes
	WHERE oficina_rep = ANY
		(SELECT oficina
		FROM oficines
		WHERE regio ='Est');


ERROR: update or delete on table "rep_vendes"
violates foreign key constraint "fk_clients_rep_clie"
on table "clients"
DETAIL: Key (num_empl)=(105) is still referenced
from table "clients"
--

* Al intentar eliminar un vendedor de la tabla rep_vendes --> ERROR DE INTEGRIDAD REFERENCIAL.

* Básicamente incumple la constraint de FK a la tabla Clients. Para ello se debe eliminar primero el registro en CLIENTES y luego en REP_VENDES.
 
--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------


--------------------------------------






### DCL

# GRANT

⭐️ **SINTAXIS** ⭐️
-------------------

-------------------



⭐️ **EJEMPLOS** ⭐️
-------------------

-------------------

# REVOKE

⭐️ **SINTAXIS** ⭐️
-------------------

-------------------



⭐️ **EJEMPLOS** ⭐️
-------------------

-------------------

### DTL

# BEGIN

⭐️ **SINTAXIS** ⭐️
-------------------

-------------------



⭐️ **EJEMPLOS** ⭐️
-------------------

-------------------

# COMMIT

⭐️ **SINTAXIS** ⭐️
-------------------

-------------------



⭐️ **EJEMPLOS** ⭐️
-------------------

-------------------

# ROLLBACK

⭐️ **SINTAXIS** ⭐️
-------------------

-------------------



⭐️ **EJEMPLOS** ⭐️
-------------------

-------------------



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 



















-------------------------------------------------------------------------------- 
