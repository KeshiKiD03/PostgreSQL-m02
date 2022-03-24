# CHEATSHEET KESHI [07]

# DDL - CREATE TABLE / CONSTRAINTS / HERENCIA

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

------------------------------------------------------------------------------------

## CREACIÓ D'UNA BASE DE DADES

⭐️ **SINTAXIS** ⭐️
------------------------------------------------------------------------------------

Per crear una base de dades:

```sql
CREATE DATABASE base_dades; --> Crea una base de DATOS
```

Si acabo de crear aquesta base de dades, ho faig connectat a una altra, com em puc connectar a la nova fent servir `psql`?

## CREACIÓ D'UNA taula

```sql
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

---------------------------------------------------------------------------------
⭐️ **EJEMPLOS** ⭐️
---------------------------------------------------------------------------------

* Crear una tabla `clients2` 

```sql
CREATE TABLE clients2 (
	PRIMARY KEY(num_clie),
	num_clie		smallint,
	empresa		character varying(20)	NOT NULL,
	rep_clie		smallint 			NOT NULL REFERENCES rep_vendes 
	limit_credit	numeric(8,2),
);
```

* Crear una tabla `empleat`

```sql
CREATE TABLE empleat(
	PRIMARY KEY (empno),
	empno	SMALLINT, 
	ename	VARCHAR(10),
);
```

---------------------------------------------------------------------------------

## La opción DEFAULT

* Es pot especificar un valor per defecte per a un camp, de manera que quan es realitzi l'inserció d'una fila sense valor per a aquest camp, prendrà el que estigui definit per defecte.

---------------------------------------------------------------------------------
⭐️ **SINTAXIS** ⭐️
---------------------------------------------------------------------------------
```sql
CREATE TABLE emp (
	...
	hiredate DATE DEFAULT current_date,
	...
);
```
---------------------------------------------------------------------------------

## TIPOS DE DATOS (PARA CREATE TABLE)

---------------------------------------------------------------------------------

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
	

---------------------------------------------------------------------------------

### Monetari: money

+ Per comprovar quin tipus de moneda:

	```
	SHOW lc_mone
	```

---------------------------------------------------------------------------------

##  Caràcters

+ Longitud variable amb límit: 

	* `character` `varying(n)`, `varchar(n)`

+ Longitud fixa (s'omple amb espais en blanc): 

	* `character(n)`, `char(n)`

+ Longitud il·limitada: 

	* `text`

---------------------------------------------------------------------------------

## Data/hora

+ Data i hora sense zona horària: 

	* `timestamp`

+ Data i hora amb zona horària: 

	* `timestamp with time zone`

+ Data: 

	* `date`

+ Hora sense zona horària: 

	* `time`

+ Hora amb zona horària: 

	* `time with time zone`

+ Interval de temps: 

	* `interval`

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

---------------------------------------------------------------------------------
  
## Booleà: boolean

+ Valors per cert: TRUE, 't', 'true', 'y', 'yes', 'on', '1'
+ Valors per fals: FALSE, 'f', 'false', 'n', 'no', 'off', '0'

---------------------------------------------------------------------------------

## Geomètric:

+ Punt: point, '(x,y)'

+ Recta: line, '((x1,y1),(x2,y2))'

+ Segment: lseg, '((x1,y1),(x2,y2))'

+ Rectangle: box, '((x1,y1),(x2,y2))'

+ Polígon: path, polygon, '((x1,y1),...)'

+ Camí: path '[(x1,y1),...]'

+ Cercle: circle, '<(x,y),r>' (centre i radi)

---------------------------------------------------------------------------------

## Adreces de xarxa:

+ Xarxes IPv4 i IPv6: cidr

+ Xarxes i hosts IPv4 i IPv6: inet

+ Adreça MAC: macaddr

---------------------------------------------------------------------------------

## UUID:

+ uuid

---------------------------------------------------------------------------------

## XML:

+ xml: valida que el text introduït estigui ben format, sinó dóna error.

---------------------------------------------------------------------------------

## MINI EJERCICIO - TIPOS DE DATOS

* 7.1- Raona un parell d'exemples en els que creus que s'usaria el tipus  de dades següents.
--
-- boolean
-- character varying
-- character
-- date
-- integer
-- interval
-- money
-- numeric
-- path
-- point
-- polygon
-- real
-- smallint
-- serial
-- text
-- time
-- timestamp
-- uuid
-- xml

* 7.2- Raona quin tipus de dades utilitzaries per emmagatzemar la següent  informació. Escriu la notació SQL per declarar els camps. 

* En cas de necessitar un tipus compost escriu la sentencia SQL necessària per a crear aquest tipus de dades.

-- Adreça MAC i adreça IPv4. **CHARACTER**

-- Dia i hora d'una videoconferència intercontinental. **TIME**

-- Si hi ha o no televisió en una habitació d'hotel. **BOOLEAN**

-- Dos números de telèfon, un de la feina, un de particular. 

-- Lletra i duració d'una cançó.

-- Recorregut d'una carretera.

-- Cobertura d'un radar meteorològic.

-- Data d'un aniversari. **DATE**

-- Despesa d'un viatge de negocis.

-- Matrícula de cotxe. **UUID**

-- Illa de cases en un mapa. **POLYGON**

-- Localització i alçada del pic d'una muntanya.

-- Identificador de xarxa IPv6. 

-- Hora del dia en que s'ha de realitzar una tasca. **TIMESTAMP**

-- Document Nacional d'Identitat. **UUID**

-- Nombre de llits d'un Hospital. **DATE**

-- Document XHTML i URL. **TEXT**


-- Nombre d'escales, de plantes i pisos d'un edifici. **INTEGER** 

-- Abast geogràfic d'un mapa.

-- Segons durant els que un semàfor està en verd, vermell i ambre. 

---------------------------------------------------------------------------------

## CONSTRAINTS (Restricciones)

### Definició i tipus de constraints.

* Les restriccions (CONSTRAINT) són regles que s'apliquen sobre les *taules* i que el SGBD s'encarrega de verificar abans de cada **operació DML** **(INSERT, UPDATE, DELETE)**.

* Hi ha `5 tipus de restriccions`. 

* Les més importants són les de clau primària i clau aliena.

- **PRIMARY KEY**: `clau primària`.

- **FOREIGN KEY / REFERENCES**: `clau forana` / aliena, per assegurar la integritat referencial. 

- **NOT NULL**: la columna no pot ser `null`.

- **UNIQUE**: cada valor ha de ser `únic` a la columna. [Més info](http://stackoverflow.com/questions/9565996/difference-between-primary-key-and-unique-key) 

- **CHECK**: `comprova` que el camp compleixi una condició.

---------------------------------------------------------------------------------

⭐️ **SINTAXIS** ⭐️
---------------------------------------------------------------------------------

> Constraints should be given a custom name excepting **UNIQUE**, **PRIMARY KEY** and **FOREIGN KEY** where the database vendor will generally supply sufficiently intelligible names automatically.

Necessitem que quan hi hagi un **error** perquè s'ha incomplert una restricció la identifiquem de seguida. Suposarem que el fabricant del SGBDR ens proporcionarà un nom identificable per **UNIQUE**, **PRIMARY KEY **i FOREIGN KEY. Però per la **CHECK** li donarem un nom de format:

`nom_taula_nom_camp_ck`

Hi ha un altre estil també molt utilitzat que és fer servir aquesta notació per les altres restriccions. Es substitueix _ck_ per _pk_, _fk_, _nn_, _uk_. 

```sql
CREATE TABLE DEPT (
	PRIMARY KEY(deptno),
	deptno	SMALLINT,
	dname		VARCHAR(14) CONSTRAINT dept_dname_ck CHECK(dname LIKE 'Dept.%'),
	loc		VARCHAR(13),
);
```

---------------------------------------------------------------------------------
## ⭐️ **PRIMARY KEY** ⭐️
---------------------------------------------------------------------------------

- Restricció que s'aplica als camps que són `clau primària (CP)`.

- `Impedeix` que s'insereixin `valors repetits` o nuls

- Quan la CP és `simple`, es pot definir a `nivell de columna` (al `costat` del `tipus de dades`) o a `nivell de taula` (al `final` de la definició de la `taula`).

- Quan sigui `composta`, la definirem a `nivell de taula` (al `final` de la definició)



## EJEMPLOS de Primary Key


Ja hem vist com posarem nosaltres la clau primària: com la primera línia.
 
Però veurem altres maneres de representar-les:
 
- **Clave Primaria SIMPLE**, definida a nivell de camp:
```sql
	CREATE TABLE dept (
		deptno	SMALLINT CONSTRAINT dept_deptno_pk PRIMARY KEY,
		dname		VARCHAR(14),
		loc		VARCHAR(13)
	);
	```

---------------------------------------------------------------------------------

- **Clave Primaria, definida a nivell de taula** (en comptes de la primera línia, al final)

```sql
	CREATE TABLE dept (
		deptno	SMALLINT,
		dname		VARCHAR(14),
		loc		VARCHAR(13),
				CONSTRAINT dept_deptno_pk PRIMARY KEY(deptno)
	);
	```

---------------------------------------------------------------------------------

- **Clave Primaria composta**: obligatori declarar-la a nivell de taula.

```sql
	CREATE TABLE productes (
		PRIMARY KEY(id_fabricant,id_producte),
		id_fabricant    CHARACTER(3),
		id_producte     CHARACTER(5),
		descripcio      CHARACTER VARYING(20)   NOT NULL,
		preu            NUMERIC(7,2)            NOT NULL,
		estoc           INTEGER
	);
	```




---------------------------------------------------------------------------------

## ⭐️ **FOREIGN KEY** ⭐️
---------------------------------------------------------------------------------

- La **integritat referencial** exigeix que el valor d'una columna que és clau forània, hagi d'existir com a clau primària de la taula relacionada.
	
  Exemple: Si a la taula _clients_, un registre, o sigui un fila, té el camp rep_clie amb valor 108, haurà d'existir una fila a rep_vendes amb num_empl 108.

- Serveix per identificar la `clau forana (CF)` i permetre recuperar informació entre diferentes taules a través de l'operacio de `JOIN`. 

- Si la CF és `simple`, es pot definir a `nivell de camp` o a `nivell de taula`.  

- Si la CF és `composta`, només es podrà definir a `nivell de taula`.



## EJEMPLO de Foreign Key

- `CF simple`, a nivell de `camp`

```sql
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

`REFERENCES`: denota que és clau forània, força integritat referencial en afegir files.

- `CF simple`, a nivell de `taula`

```sql
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

---------------------------------------------------------------------------------

## ALTER TABLE

# Tenim problemes quan creem una CF?

Si tenim problemes a l'hora d'afegir una clau forana a una taula, sempre la podrem afegir amb posterioritat a la creació a la taula. Això serà útil quan tenim dues taules que s'apunten mutuament amb les claus alienes o en el cas de relacions reflexives. Ho farem amb l'ordre `ALTER`.

Exemple:

```sql
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

---------------------------------------------------------------------------------
⭐️ **SINTAXIS** ⭐️
---------------------------------------------------------------------------------

```sql
ALTER TABLE  emp
ADD CONSTRAINT emp_mgr_fk FOREIGN KEY (mgr) REFERENCES emp(empno);
```


---------------------------------------------------------------------------------


## Política a l'incomplir la integritat referencial


- `ON DELETE`: què fer si trenquem integritat referencial en esborrar una fila de la taula referenciada.

- `ON UPDATE`: què fer si trenquem integritat referencial en modificar una fila de la taula referenciada.

Possibles accions:

- `RESTRICT`: retorna un error i no es deixa fer l'operació.
- `CASCADE`: esborra o modifica les files afectades.
- `SET DEFAULT`: es posa el valor per defecte.
- `SET NULL`: es posa el valor a NULL.

```sql
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

```sql
INSERT INTO clients
VALUES (200, 'Bit', 108, 10000);
```



Què farà la següent ordre, tenint en compte la constraint descrita abans?

```sql
DELETE FROM rep_vendes
WHERE num_empl = 108;
```

**Solució**:

Res, mostrarà un missatge `d'error`.

```sql
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

```sql
INSERT INTO clients
VALUES (200, 'Bit', 108, 10000);
```

Què farà la següent ordre, tenint en compte la constraint descrita abans?

```
DELETE FROM rep_vendes
WHERE num_empl = 108; 
```

**Solució**:

L'ordre anterior intentarà `eliminar` el `venedor` de la taula `rep_vendes`, aquest venedor `pot sortir` a la taula `clients`, de manera que `si s'elimina` la seva `referència` en aquesta darrera taula s'aplicaria la `política ON CASCADE`, o sigui s'eliminaria aquell client que tingui al `108` com a `venedor`.

El `problema` però el tenim amb les altres taules ja que si comandes u oficines o la mateixa rep_vendes que `s'autoreferencia` tenen `NO ACTION` (que és `l'opció` que hi ha `per defecte` quan no es posa res) `saltarà l'error` i no es modificarà res.


---------------------------------------------------------------------------------

## HERENCIA 

* Hereda los CAMPOS de una TABLA a otra TABLA.

```SQL
CREATE TABLE clients_vip (
	punts INTEGER
)INHERITS (clients);
```

Si mostrem l'estructura de la taula mare:

```SQL
training2=> \d clients
                        Table "public.clients"
    Column    |         Type          | Collation | Nullable | Default 
--------------+-----------------------+-----------+----------+---------
 num_clie     | smallint              |           | not null | 
 empresa      | character varying(20) |           | not null | 
 rep_clie     | smallint              |           | not null | 
 limit_credit | numeric(8,2)          |           |          | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (num_clie)
Referenced by:
    TABLE "comandes" CONSTRAINT "comandes_clie_fkey" FOREIGN KEY (clie) REFERENCES clients(num_clie)
Number of child tables: 1 (Use \d+ to list them.)
```

Veurem ara que la taula filla hereta els seus camps:

```SQL
training2=> \d clients_vip 
                      Table "public.clients_vip"
    Column    |         Type          | Collation | Nullable | Default 
--------------+-----------------------+-----------+----------+---------
 num_clie     | smallint              |           | not null | 
 empresa      | character varying(20) |           | not null | 
 rep_clie     | smallint              |           | not null | 
 limit_credit | numeric(8,2)          |           |          | 
 punts        | integer               |           |          | 
Inherits: clients


```

Totes les constraints de tipus CHECK i NOT NULL són heretades, a no ser que s'indiqui explícitament el contrari. Les altres constraints no s'hereten. Podeu trobar informació molt interessant [AQUI](https://www.postgresql.org/docs/13/ddl-inherit.html)



---------------------------------------------------------------------------------

## Creació d'una taula a partir d'una consulta

---------------------------------------------------------------------------------

```SQL
CREATE TABLE oficines_est 
    AS (SELECT oficina, ciutat, objectiu, vendes
          FROM oficines
         WHERE regio = 'Oest');
```


---------------------------------------------------------------------------------

## Creació d'una taula temporal

---------------------------------------------------------------------------------

Quan sortim de la sessió la taula desapareixerà:

Forma estàndard: features opcionals de SQL-2016 estàndard.

```SQL
CREATE LOCAL TEMPORARY TABLE table2 ...;
```

PostgreSQL té la seva pròpia comanda:

```
CREATE TEMP TABLE table2 ...;
```

---------------------------------------------------------------------------------

## Eliminació de taules

```SQL
DROP TABLE taula
```

---------------------------------------------------------------------------------

* Afegim un camp:

```SQL
ALTER TABLE oficines 
  ADD telefon varchar(9);
```

* Modificar camp:

```SQL
ALTER TABLE oficines 
ALTER telefon varchar(20);

```

* Esborrar camp:

```SQL
ALTER TABLE oficines 
 DROP telefon;

```

* Afegir constraint:

```SQL
ALTER TABLE oficines
  ADD CHECK(ciutat <> 'Barcelona')
```

* o amb nom:

```SQL
ALTER TABLE oficines
  ADD CONSTRAINT oficines_ciutat_ck CHECK(ciutat <> 'Badalona')

```

---------------------------------------------------------------------------------

## EXTRES

### Restriccions i moment en que es comproven. DEFERRABLE

> Quan es fa la comprovació del compliment de les `CONSTRAINTS`?

La resposta depèn de si la restricció és `_DEFERRABLE_` o `_NOT DEFERRABLE_` (ajornable o no ajornable)

Aquest concepte fa referència al moment en que és comproven les CONSTRAINTS.

+ Si no estem `dintre` d'una `transacció`, per defecte el que passa a PostgreSQL, la `constraint` es comprova de `seguida`, no s'ajorna: `NOT DEFERRABLE`.

+ Si hi ha `transacció`, es pot definir amb l'ordre SET el comportament d'una constraint:

	+ `SET CONSTRAINTS` name_constraint `IMMEDIATE`:
	La constraint es comprova al final de cada declaració.

	+ `SET CONSTRAINTS` name_constraint `DEFERRED`
	La constraint no es comprova fins que la transacció acabi amb un COMMIT.

+ `NOT NULL` i `CHECK` constraints no admeten aquesta opció ja que són sempre comprovades immediatament.


### RESTRICT i NO ACTION

A les possibles respostes que ja coneixem d'un incompliment de la constraint ( RESTRICT, CASCADE, SET DEFAULT i SET NULL) s'hauria d'afegir NO ACTION que és la que PostgreSQL té per defecte. 

RESTRICT i NO ACTION són iguals excepte si es defineix la constraint com a DEFERRED o com a IMMEDIATE


---------------------------------------------------------------------------------

# Exercicis DDL (Estructura)

## Exercici 1

+ Crear una base de dades anomenada "biblioteca". Dins aquesta base de dades:
+ crear una taula anomenada llibres amb els camps següents:
```SQL
CREATE DATABASE biblioteca;
```


+ "ref": clau primaria numèrica que identifica els llibres i s'ha d'assignar automàticament.
	
+ "titol": títol del llibre.

+ "editorial": nom de l'editorial.

+ "autor": identificador de l'autor, clau forana, per defecte ha de

+ referenciar a primer valor de la taula autors que simbolitzar l'autor "Anònim".

1. Crear la taula LLIBRES

```SQL
template1=> CREATE TABLE llibres (
        ref             SERIAL NOT NULL
                                CONSTRAINT ref_pk PRIMARY KEY,
        titol           VARCHAR(20),
        editorial       VARCHAR(20),
        author          INT   
) ;
CREATE TABLE
```




+ Crear una altre taula anomenada "autors" amb els següents camps:
	+ "autor": identificador de l'autor.
	+ "nom": Nom i cognoms de l'autor.
	+ "nacionalitat": Nacionalitat de l'autor.
+ Ambdues taules han de mantenir integritat referencial. Cal que si es trenca
+ la integritat per delete d'autor, la clau forana del llibre apunti a "Anònim".
+ Si es trenca la integritat per insert/update s'ha d'impedir l'alta/modificació.
+ Cal inserir l'autor "Anònim" a la taula autors.

2. Crear la taula AUTHOR

```SQL
template1=> CREATE TABLE authors (
        author             INT NOT NULL
                                CONSTRAINT author_pk PRIMARY KEY,
        nom           VARCHAR(20),
        nacionalitat       VARCHAR(20) 
) ;
CREATE TABLE
```

3. Crear la CONSTRAINT FOREIGN KEY de AUTHORS.

```SQL
template1=> ALTER TABLE llibres
ADD CONSTRAINT author_fk FOREIGN KEY (author) REFERENCES authors(author)
template1-> ;
ALTER TABLE
```

4. Revisem la taula LLIBRES.

```SQL
                                    Table "public.llibres"
  Column   |         Type          | Collation | Nullable |               Default                
-----------+-----------------------+-----------+----------+--------------------------------------
 ref       | integer               |           | not null | nextval('llibres_ref_seq'::regclass)
 titol     | character varying(20) |           |          | 
 editorial | character varying(20) |           |          | 
 author    | integer               |           |          | 
Indexes:
    "ref_pk" PRIMARY KEY, btree (ref)
Foreign-key constraints:
    "author_fk" FOREIGN KEY (author) REFERENCES authors(author)

```

5. Inserir un VALOR al camp de AUTHOR.

```SQL
biblioteca=> INSERT INTO authors VALUES (
    1,
    'Anonim',
    'Catala'
);
INSERT 0 1
biblioteca=> 

```

```SQL
biblioteca=> SELECT * FROM authors;
 author |  nom   | nacionalitat 
--------+--------+--------------
      1 | Anonim | Catala
(1 row)

```

# __SOLUCIÓN__

Creem la base de dades (des de qualsevol altre):

```SQL
CREATE DATABASE biblioteca;
```

Ens connectem a la nova:

```
\c biblioteca
```

Creem la taula autors:

```SQL
CREATE TABLE autors (
    PRIMARY KEY(autor),
    autor           INT,
    nom             VARCHAR(50) NOT NULL
                                DEFAULT 'Anònim',
    nacionalitat    VARCHAR(30)
);
```

Creem la taula llibres:

```SQL
CREATE TABLE llibres (
    PRIMARY KEY(ref),
    ref         SERIAL,
    titol       VARCHAR(100)    NOT NULL,
    editorial   VARCHAR(50),
    autor       INT             NOT NULL    
                                DEFAULT 1
                                REFERENCES autors
                                ON DELETE SET DEFAULT
                                ON UPDATE RESTRICT
);
```

Creem l'autor 1, anònim:

```SQL
INSERT INTO autors (autor)
VALUES (1);
```

I un altre:

```SQL
INSERT INTO autors
VALUES(2, 'Tom Sharpe', 'English');
```

Inserim un llibre:

```SQL
INSERT INTO llibres (titol, editorial, autor)
VALUES ('Wilt', 'Magrana', 2);
```

_Petit parèntesi, si torno a inserir el mateix llibre, em deixa?_

```SQL
INSERT INTO llibres (titol, editorial, autor)
VALUES ('Wilt', 'Magrana', 2);
```
```SQL
 ref | titol | editorial | autor 
-----+-------+-----------+-------
   1 | Wilt  | Magrana   |     2
   2 | Wilt  | Magrana   |     2
(2 rows)
```

_Penseu com ho resoldrieu, després compareu la vostra solució amb la que teniu
al final del fitxer._



Tanquem parèntesi.

Comproveu que si en aquesta taula inseriu un llibre amb un autor que no
existeix, la costraint no ens deixa.

I de la mateixa manera, si eliminem l'autor = 2, mirem com es reasigna l'autor
1 o sigui 'Anònim' al llibre Wilt:

```SQL
DELETE FROM autors
 WHERE autor = 2;

DELETE 1
```

En efecte, quan eliminem l'autor 2, el llibre de ref 1, Wilt, no es queda orfe
ja que se l'assigna l'autor 1, l'Anònim.

```SQL
SELECT *
  FROM autors;

 autor |  nom   | nacionalitat 
-------+--------+--------------
     1 | Anònim | 
(1 row)

SELECT *
  FROM llibres;

 ref | titol | editorial | autor 
-----+-------+-----------+-------
   1 | Wilt  | Magrana   |     1 <==
(1 row)
```

## Exercici 2

A la base biblioteca cal crear una taula anomenada "socis"
+ amb els següents camps:
	+ num_soci: clau primària
	+ nom: nom i cognoms del soci.
	+ dni: DNI del soci.


+ També una taula anomenada préstecs amb els següents camps:
	+ ref: clau forana, que fa referència al llibre prestat.
	+ soci: clau forana, que fa referència al soci.
	+ data_prestec: data en que s'ha realitzat el préstec.
+ No cal que préstecs tingui clau principal ja que només és una taula de relació.
+ En eliminar un llibre cal que s'eliminin els seus préstecs automàticament.
+ No s'ha de poder eliminar un soci amb préstecs pendents.


```SQL
CREATE TABLE socis (
        num_soci             INTEGER NOT NULL
                                CONSTRAINT numSoci_pk PRIMARY KEY,
        nom           VARCHAR(20),
        cognom       VARCHAR(20),
        DNI          VARCHAR(9) UNIQUE NOT NULL
) ;
```


```SQL
CREATE TABLE prestecs (
        ref             INTEGER NOT NULL
            CONSTRAINT prestecs_ref_fk REFERENCES llibres (ref) ON DELETE CASCADE,
        soci            INTEGER
            CONSTRAINT prestecs_soci_fk REFERENCES socis (num_soci) ON DELETE RESTRICT,
        data_prestec    DATE
            
CREATE TABLE
) ;
```

```SQL
biblioteca=> \d prestecs
                 Table "public.prestecs"
    Column    |  Type   | Collation | Nullable | Default 
--------------+---------+-----------+----------+---------
 ref          | integer |           | not null | 
 soci         | integer |           |          | 
 data_prestec | date    |           |          | 
Foreign-key constraints:
    "prestecs_ref_fk" FOREIGN KEY (ref) REFERENCES llibres(ref) ON DELETE CASCADE
    "prestecs_soci_fk" FOREIGN KEY (soci) REFERENCES socis(num_soci) ON DELETE RESTRICT

biblioteca=> 
```

# __SOLUCIÓN__

Creem la taula socis:

```SQL
CREATE TABLE socis (
    PRIMARY KEY(num_soci),
    num_soci    INT,
    nom         VARCHAR(50)	NOT NULL,
    dni         VARCHAR(9)	NOT NULL
							UNIQUE
);
```

Creem la taula prestecs:

```SQL
CREATE TABLE prestecs (
    ref             INT     NOT NULL
                            REFERENCES llibres
                            ON DELETE CASCADE,
    soci            INT     NOT NULL
                            REFERENCES socis
                            ON DELETE RESTRICT,
    data_prestec    DATE    NOT NULL
);
```

Fem una prova:

```SQL
INSERT INTO socis
VALUES (7, 'Josep Pi','12345678Z');

INSERT 0 1


INSERT INTO prestecs
VALUES (1, 7, '2022-02-14');

INSERT 0 1
```

Ja tenim un soci i un prèstec.

Intentem eliminar el soci amb prèstecs pendents:

```SQL
DELETE FROM socis
 WHERE num_soci = 7;

ERROR:  update or delete on table "socis" violates foreign key constraint "prestecs_soci_fkey" on table "prestecs"
DETAIL:  Key (num_soci)=(7) is still referenced from table "prestecs".`
```

I en canvi, si eliminem el llibre de referència 1, que actualment està prestat:

```SQL
DELETE FROM llibres
 WHERE ref = 1;

DELETE 1
```

No només s'elimina el llibre sinó també el seu prèstec associat:

```SQL
SELECT *
  FROM prestecs ;

 ref | soci | data_prestec 
-----+------+--------------
(0 rows)
```

## Exercici 3

A la base de dades training crear una taula anomenada "rep_vendes_baixa" que tingui la mateixa estructura que la taula rep_vendes i a més a més un camp anomenat "baixa" que pugui contenir la data en que un representant de vendes s'ha donat de baixa.


```SQL
training=> CREATE TABLE rep_vendes_baixa (
    baixa       TIMESTAMP
)INHERITS (rep_vendes);
CREATE TABLE
training=> 

```

```SQL
\d rep_vendes_baixa


                        Table "public.rep_vendes_baixa"
     Column     |            Type             | Collation | Nullable | Default 
----------------+-----------------------------+-----------+----------+---------
 num_empl       | smallint                    |           | not null | 
 nom            | character varying(30)       |           | not null | 
 edat           | smallint                    |           |          | 
 oficina_rep    | smallint                    |           |          | 
 carrec         | character varying(20)       |           |          | 
 data_contracte | date                        |           | not null | 
 cap            | smallint                    |           |          | 
 quota          | numeric(8,2)                |           |          | 
 vendes         | numeric(8,2)                |           |          | 
 baixa          | timestamp without time zone |           |          | 
Check constraints:
    "ck_rep_vendes_edat" CHECK (edat > 0)
    "ck_rep_vendes_nom" CHECK (nom::text = initcap(nom::text))
    "ck_rep_vendes_quota" CHECK (quota > 0::numeric)
    "ck_rep_vendes_vendes" CHECK (vendes > 0::numeric)
Inherits: rep_vendes



```

# __SOLUCIÓN__

```SQL
CREATE TABLE rep_vendes_baixa (
    baixa DATE
) INHERITS (rep_vendes);
```



## Exercici 4

A la base de dades training crear una taula anomenada "productes_sense_comandes" omplerta amb aquells productes que no han tingut mai cap comanda. A continuació esborrar de la taula "productes" aquells productes que estan en aquesta nova taula.

## Obtenim els productes que mai s'han fet comanda.

```SQL
training=> SELECT comandes.producte, productes.id_fabricant, productes.id_producte FROM comandes RIGHT JOIN productes ON (comandes.producte = productes.id_producte) AND (comandes.fabricant = productes.id_fabricant) WHERE comandes.num_comanda IS NULL;
 producte | id_fabricant | id_producte 
----------+--------------+-------------
          | aci          | 41001
          | qsa          | xk48 
          | bic          | 41089
          | qsa          | xk48a
          | imm          | 887x 
          | imm          | 887h 
          | imm          | 887p 
          | bic          | 41672
(8 rows)
```

## Fem la creació amb el AS

```SQL
training=> CREATE TABLE productes_sense_comandes AS (
    (SELECT comandes.producte, productes.id_fabricant, productes.id_producte FROM comandes RIGHT JOIN productes ON (comandes.producte = productes.id_producte) AND (comandes.fabricant = productes.id_fabricant) WHERE comandes.num_comanda IS NULL)
);
SELECT 8
training=> 

```


## Visualitzem la taula productes_sense_comandes amb un SELECT
```SQL
training=> SELECT * FROM productes_sense_comandes;
 producte | id_fabricant | id_producte 
----------+--------------+-------------
          | aci          | 41001
          | qsa          | xk48 
          | bic          | 41089
          | qsa          | xk48a
          | imm          | 887x 
          | imm          | 887h 
          | imm          | 887p 
          | bic          | 41672
(8 rows)

training=> 

```


DEFINITIVO

```SQL
DELETE FROM productes
WHERE id_producte IN (SELECT id_producte FROM productes_sense_comandes);
```

# __SOLUCIÓN__

Creem la taula _productes_sense_comandes_:


```SQL
CREATE TABLE productes_sense_comandes AS (
    SELECT * 
      FROM productes 
     WHERE (id_producte, id_fabricant) NOT IN
           (SELECT producte, fabricant 
              FROM comandes)
);
```

Esborrem els elements de la taula productes que ja estan a la nova taula:

```SQL
DELETE FROM productes
 WHERE (id_fabricant, id_producte) IN
       (SELECT id_fabricant, id_producte
          FROM productes_sense_comandes);
```


## Exercici 5

A la base de dades training crear una taula temporal que substitueixi la taula "clients" però només ha de contenir aquells clients que no han fet comandes i tenen assignat un representant de vendes amb unes vendes inferiors al 110% de la seva quota.

```SQL
CREATE LOCAL TEMPORARY TABLE clients2 AS (
	SELECT num_clie FROM clients 
	WHERE num_clie NOT IN (
		SELECT clie
		FROM comandes
		) AND rep_clie = ANY (
				SELECT num_empl 
				FROM rep_vendes 
				WHERE vendes < (quota*1.1)
			)	
);
SELECT 4
```


```SQL
training=> SELECT * FROM clients2;
 num_clie 
----------
     2115
     2121
     2122
     2105
(4 rows)

```

# __SOLUCIÓN__

```SQL
CREATE LOCAL TEMPORARY TABLE clients AS (
    SELECT * 
      FROM clients
     WHERE num_clie NOT IN
           (SELECT clie 
              FROM comandes)
       AND rep_clie IN
           (SELECT num_empl 
              FROM rep_vendes 
             WHERE vendes < 1.1 * quota)
);
```

Si ara fem:

```SQL
SELECT *
  FROM clients;
``` 

Només hi haurà els clients que ens demanen.  Si sortim de la sessió, no ho feu
encara, desapareixerà aquesta taula clients i tornarem a tenir l'antiga.

Mirant la sortida de l'ordre psql `\d` a veure si sou capaços de veure alguna
diferència d'aquesta taula respecte a les altres i utilitzant això fer alguna
consulta SELECT per veure la taula clients original sense necessitat
d'esperar-nos a sortir de la sessió perquè desaparegui la temporal.
  
Si no us surt la solució està a sota.



## Exercici 6

Escriu les sentències necessàries per a crear l'estructura de l'esquema proporcionat de la base de dades training. Justifica les accions a realitzar en modificar/actualitzar les claus primàries.

```SQL
CREATE TABLE IF NOT EXISTS PRODUCTES (
    PRIMARY KEY(id_fabricant,id_producte),
    id_fabricant        VARCHAR(5),
    id_producte         VARCHAR(5),
    descripcio          VARCHAR(20)     NOT NULL,
    preu                NUMERIC(8,2)    NOT NULL,
    estoc               INT             NOT NULL DEFAULT 0
);
```
```SQL
CREATE TABLE IF NOT EXISTS OFICINES (
    PRIMARY KEY(oficina),
    oficina             SMALLINT,
    ciutat              VARCHAR(15)     NOT NULL,
    regio               VARCHAR(10)     NOT NULL,
    director            SMALLINT,
    objectiu            NUMERIC(9,2),
    vendes              NUMERIC(9,2)    NOT NULL DEFAULT 0
);
```
```SQL
CREATE TABLE IF NOT EXISTS REP_VENDES (
    PRIMARY KEY(num_empl),
    num_empl            SMALLINT,
    nom                 VARCHAR(30)     NOT NULL,
    edat                SMALLINT,
    oficina_rep         SMALLINT,
    carrec              VARCHAR(20),
    data_contracte      DATE            NOT NULL,
    cap                 SMALLINT,
    quota               NUMERIC(8,2) NOT NULL DEFAULT 250000,
    vendes              NUMERIC(8,2) NOT NULL DEFAULT 0
);
```
```SQL
CREATE TABLE IF NOT EXISTS CLIENTS (
    PRIMARY KEY(num_clie),
    num_clie            SMALLINT,
    empresa             VARCHAR(20)     NOT NULL,
    rep_clie            SMALLINT        NOT NULL,
    limit_credit        NUMERIC(8,2)
);
```
```SQL
CREATE TABLE IF NOT EXISTS COMANDES (
    PRIMARY KEY(num_comanda)
    num_comanda         INT,
    data                DATE            NOT NULL,
    clie                SMALLINT        NOT NULL,
    rep                 SMALLINT,
    fabricant           VARCHAR(3)      NOT NULL,
    producte            VARCHAR(5)      NOT NULL,
    quantitat           SMALLINT        NOT NULL,
    import              NUMERIC(7,2)    NOT NULL DEFAULT 0
);
```

# __SOLUCIÓN__

```SQL
CREATE TABLE clients (
	PRIMARY KEY(num_clie),
	num_clie        SMALLINT,
	empresa         VARCHAR(20)		NOT NULL,
	rep_clie        SMALLINT		NOT NULL DEFAULT 106, -- entenem que Sam Clark és el cap de l'empresa
	limit_credit    NUMERIC(8,2)
);
```
```SQL
CREATE TABLE oficines (
	PRIMARY KEY(oficina),
	oficina     SMALLINT,
	ciutat      VARCHAR(15)		NOT NULL,
	regio       VARCHAR(10)		NOT NULL,
	director    SMALLINT,
	objectiu    NUMERIC(9,2),
	vendes      NUMERIC(9,2)	NOT NULL
);
```
```SQL
CREATE TABLE comandes (
	PRIMARY KEY(num_comanda),
	num_comanda     INTEGER,
	data            DATE            NOT NULL,
	clie            SMALLINT        NOT NULL,
	rep             SMALLINT,
	fabricant       CHARACTER(3)    NOT NULL,
	producte        CHARACTER(5)    NOT NULL,
	quantitat       SMALLINT        NOT NULL,
	import          NUMERIC(7,2)    NOT NULL
);
```
```SQL
CREATE TABLE productes (
	PRIMARY KEY(id_fabricant, id_producte),
	id_fabricant	CHARACTER(3),
	id_producte		CHARACTER(5),
	descripcion		CHARACTER varying(20)   NOT NULL,
	preu			NUMERIC(7,2)            NOT NULL,
	estoc			INTEGER                 NOT NULL
);
```
```SQL
CREATE TABLE rep_vendes (
	PRIMARY KEY(num_empl),
	num_empl        SMALLINT,
	nom             VARCHAR(15)     NOT NULL,
	edat            SMALLINT,
	oficina_rep     SMALLINT,
	carrec          VARCHAR(10),
	data_contracte  DATE            NOT NULL,
	cap             SMALLINT        DEFAULT 106,
	quota           NUMERIC(8,2),
	vendes          NUMERIC(8,2)    NOT NULL
);
```

Com que ens demanen "justifica les accions a realitzar en modificar/actualitzar
les claus primàries", no només haurem de crear les constraints de clau forana
sinó també justificar-les.


```SQL
ALTER TABLE clients
  ADD CONSTRAINT representant_del_client 
      FOREIGN KEY (rep_clie) REFERENCES rep_vendes(num_empl)
      ON DELETE SET DEFAULT -- Si un representant desapareix, el client tindrà assignat el representant per defecte que és el cap de l'empresa (que en teoria mai desapareixerà :D)
      ON UPDATE CASCADE; -- Si un representant canvia de codi, canviarem també el codi en el client
```
```SQL
ALTER TABLE oficines
  ADD CONSTRAINT director_de_l_oficina 
      FOREIGN KEY (director) REFERENCES rep_vendes(num_empl)
      ON DELETE SET NULL -- Si un representant desapareix, l'oficina quedarà temporalment sense director
      ON UPDATE CASCADE; -- Si un representant canvia de codi, canviarem també el codi a l'oficina
```

```SQL
ALTER TABLE comandes
  ADD CONSTRAINT client_que_ha_fet_comanda 
      FOREIGN KEY (clie) REFERENCES clients(num_clie)
      ON DELETE CASCADE -- Si s'esborra un client, esborrem totes les seves comandes
      ON UPDATE CASCADE, -- Si un client canvia de codi, canviarem també el codi en la comanda
  ADD CONSTRAINT representant_que_ha_ates_comanda 
      FOREIGN KEY (rep) REFERENCES rep_vendes(num_empl)
      ON DELETE SET NULL -- Si s'esborra un representant, posarem les comandes que va fer a NULL, per tal de no perdre la comanda
      ON UPDATE CASCADE, -- Si un representant canvia de codi, canviarem també el codi en la comanda
  ADD CONSTRAINT producte_del_pedido 
      FOREIGN KEY (fabricant, producte) REFERENCES productes(id_fabricant, id_producte)
      ON DELETE CASCADE -- Si s'esborra el producte, esborrem les comandes amb aquest producte
      ON UPDATE CASCADE; -- Si un producte canvia de codi, canviarem també el codi en la comanda

-- Atenció, aquesta sentència donarà error perquè hi ha una comanda que trenca la integritat referencial.

```
```SQL
ALTER TABLE rep_vendes
  ADD CONSTRAINT oficina_on_treballa_representant 
      FOREIGN KEY (oficina_rep) REFERENCES oficines(oficina)
      ON DELETE SET NULL -- Si s'esborra l'oficina, el representant es queda temporalment sense oficina assignada
      ON UPDATE CASCADE, -- Si l'oficina canvia de codi, canviarem també el codi al representant
  ADD CONSTRAINT cap_del_representant
      FOREIGN KEY (cap) REFERENCES rep_vendes(num_empl)
      ON DELETE SET DEFAULT -- Si s'esborra el cap s'assignaicina, el representant es queda temporalment sense oficina assignada
      ON UPDATE CASCADE; -- Si l'oficina canvia de codi, canviarem també el codi al representant
```

## Exercici 7

Escriu una sentència que permeti modificar la base de dades training proporcionada. Cal que afegeixi un camp anomenat "nif" a la taula "clients" que permeti emmagatzemar el NIF de cada client. També s'ha de procurar que el NIF de cada client sigui únic.

```SQL
ALTER TABLE clients 
  ADD nif VARCHAR(9) UNIQUE;
```

# __SOLUCIÓN__

```SQL
ALTER TABLE clients
  ADD nif CHAR(9) UNIQUE CHECK (nif LIKE '_________'); -- hi ha 9 underscores
```
O si no guardem la lletra:

```SQL
ALTER TABLE clients
  ADD nif INT UNIQUE CHECK (nif >= 10000000 AND nif <= 99999999 );
```

## Exercici 8

Escriu una sentència que permeti modificar la base de dades training proporcionada. Cal que afegeixi un camp anomenat "tel" a la taula "clients" que permeti emmagatzemar el número de telèfon de cada client. També s'ha de procurar que aquest contingui 9 xifres.

```SQL
ALTER TABLE clients 
  ADD tel INT;
```
```SQL
ALTER TABLE clients
    ADD CONSTRAINT clients_tel_ck CHECK(length(tel::text) = 9);
```

# __SOLUCIÓN__

```SQL
ALTER TABLE clients
  ADD tel NUMERIC(9,0) CHECK (tel >= 100000000 AND tel <= 999999999 );
```

## Exercici 9

Escriu les sentències necessàries per modificar la base de dades training proporcionada. Cal que s'impedeixi que els noms dels representants de vendes i els noms dels clients estiguin buits, és a dir que ni siguin nuls ni continguin la cadena buida.

```SQL
ALTER TABLE rep_vendes 
  ADD constraint rep_nom_ck CHECK (nom <> '' OR nom IS NOT NULL);
```
```SQL
ALTER TABLE clients 
  ADD constraint cli_empresa_ck CHECK (empresa <> '' OR empresa IS NOT NULL);
```

# __SOLUCIÓN__

```SQL
ALTER TABLE rep_vendes
ALTER nom SET NOT NULL,  -- o també 'ALTER COLUMN nom'
  ADD CHECK(nom <> '');
```

```SQL
ALTER TABLE clients
ALTER empresa SET NOT NULL,
  ADD CHECK(empresa <> '');
```

## Exercici 10

Escriu una sentència que permeti modificar la base de dades training proporcionada. Cal que procuri que l'edat dels representants de vendes no sigui inferior a 18 anys ni superior a 65.

```SQL
ALTER TABLE rep_vendes 
  ADD constraint rep_edad_ck CHECK (edat>=18 OR edat<=65);
```

# __SOLUCIÓN__

```SQL
ALTER TABLE rep_vendes
  ADD CHECK(edat BETWEEN 18 AND 65);
```

## Exercici 11

Escriu una sentència que permeti modificar la base de dades training proporcionada. Cal que esborri el camp "carrec" de la taula "rep_vendes" esborrant també les possibles restriccions i referències que tingui.

```SQL
ALTER TABLE rep_vendes 
  DROP carrec CASCADE;
```

# __SOLUCIÓN__

```SQL
ALTER TABLE rep_vendes 
 DROP carrec CASCADE;
```


## Exercici 12

Escriu les sentències necessàries per modificar la base de dades training proporcionada per tal que aquesta tingui integritat referencial. Justifica les accions a realitzar per modificar les dades.

```SQL
CREATE TABLE IF NOT EXISTS PRODUCTES (
    PRIMARY KEY(id_fabricant,id_producte),
    id_fabricant        VARCHAR(5),
    id_producte         VARCHAR(5),
    descripcio          VARCHAR(20)     NOT NULL,
    preu                NUMERIC(8,2)    NOT NULL,
    estoc               INT             NOT NULL DEFAULT 0
);
```

```SQL
CREATE TABLE IF NOT EXISTS OFICINES (
    PRIMARY KEY(oficina),
    oficina             SMALLINT,
    ciutat              VARCHAR(15)     NOT NULL,
    regio               VARCHAR(10)     NOT NULL,
    director            SMALLINT,
    objectiu            NUMERIC(9,2),
    vendes              NUMERIC(9,2)    NOT NULL DEFAULT 0
);
```

```SQL
CREATE TABLE IF NOT EXISTS REP_VENDES (
    PRIMARY KEY(num_empl),
    num_empl            SMALLINT,
    nom                 VARCHAR(30)     NOT NULL,
    edat                SMALLINT,
    oficina_rep         SMALLINT,
    carrec              VARCHAR(20),
    data_contracte      DATE            NOT NULL,
    cap                 SMALLINT,
    quota               NUMERIC(8,2) NOT NULL DEFAULT 250000,
    vendes              NUMERIC(8,2) NOT NULL DEFAULT 0,
                        CONSTRAINT CK_REP_VENDES_NOM CHECK(NOM = INITCAP(NOM)),
	                    CONSTRAINT CK_REP_VENDES_EDAT CHECK(EDAT>0),
	                    CONSTRAINT CK_REP_VENDES_QUOTA CHECK(QUOTA>0),
	                    CONSTRAINT FK_REP_VENDES_OFICINA_REP FOREIGN KEY(oficina_rep) REFERENCES OFICINES(oficina)	
);
```

```SQL
CREATE TABLE IF NOT EXISTS CLIENTS (
    PRIMARY KEY(num_clie),
    num_clie            SMALLINT,
    empresa             VARCHAR(20)     NOT NULL,
    rep_clie            SMALLINT        NOT NULL,
    limit_credit        NUMERIC(8,2),
                        CONSTRAINT FK_CLIENTS_REP_CLIE FOREIGN KEY(REP_CLIE) REFERENCES REP_VENDES(NUM_EMPL)
);
```

```SQL
CREATE TABLE IF NOT EXISTS COMANDES (
    PRIMARY KEY(num_comanda)
    num_comanda         INT,
    data                DATE            NOT NULL,
    clie                SMALLINT        NOT NULL,
    rep                 SMALLINT,
    fabricant           VARCHAR(3)      NOT NULL,
    producte            VARCHAR(5)      NOT NULL,
    quantitat           SMALLINT        NOT NULL,
    import              NUMERIC(7,2)    NOT NULL DEFAULT 0,
	                    CONSTRAINT FK_COMANDES_REP FOREIGN KEY(REP) REFERENCES REP_VENDES(NUM_EMPL),
	                    CONSTRAINT FK_COMANDES_CLIE FOREIGN KEY(CLIE) REFERENCES CLIENTS(NUM_CLIE)
);
```

# __SOLUCIÓN____

```SQL
SELECT resposta
  FROM exercici6;
```

## Extres

Solució al _problema-parèntesi_ plantejat a **l'exercici 1**:

```SQL
	ALTER TABLE llibres
	  ADD CONSTRAINT autors_titol_editorial_autor_uq UNIQUE (titol, editorial, autor);
```

En efecte:

```SQL
	INSERT INTO llibres (titol, editorial, autor)
	VALUES ('Wilt', 'Magrana', 2);
	ERROR:  duplicate key value violates unique constraint "autors_titol_editorial_autor_uq"
	DETAIL:  Key (titol, editorial, autor)=(Wilt, Magrana, 2) already exists.
```


+ Solució al problema plantejat a **l'exercici 5**:

```SQL
	\d
					   List of relations
	  Schema   |           Name           | Type  | Owner  
	-----------+--------------------------+-------+--------
	 pg_temp_3 | clients                  | table | pingui
	 public    | comandes                 | table | pingui
	 public    | oficines                 | table | pingui
	...
```

L'esquema de la nova taula clients és diferent, no és el càssic public.

Un esquema proveeix informació de les taules, vistes, columnes i procedures 	(funcions) de la base de dades Si Ara no explicarem els esquemes. Una idea resumida la podeu trobar [aquí (https://en.wikipedia.org/wiki/Information_schema)


Cada taula té per associat un esquema. Si hi ha la mateixa taula a dos esquemes hi haurà una que serà la que hi hhagi per defecte. En aquest cas per a totes és public menys per a 'clients'. Però puc cridar a la taula clients posant el esquema davant:

```SQL
	SELECT *
	  FROM public.clients;
```



---------------------------------------------------------------------------------



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


