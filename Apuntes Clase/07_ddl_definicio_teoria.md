
# DDL: Data Definition Language / Llenguatge de definició de dades 

## Objectius del tema

- Comprendre la funció de definició de dades
- Comprendre i aplicar els tipus de restriccions.
- Crear taules amb les seves pròpies restriccions (CREATE table)
- Esborrar i modificar les taules (DROP table i ALTER table)
- Tenir la capacitat d'entendre els errors (derivats d'un ús incorrecte del SQL) i de solucionar-los.

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

## Creació d'una base de dades

Per crear una base de dades:

```
CREATE DATABASE base_dades;
```

Si acabo de crear aquesta base de dades, ho faig connectat a una altra,
com em puc connectar a la nova fent servir `psql`?

## Creació d'una taula

Per crear una taula, concretament la seva estructura, farem:

```
CREATE TABLE taula (
	PRIMARY KEY(camp_1),
	camp_1	_TIPUS_DE_DADES_	[restricció a nivell de camp],
	camp_2	_TIPUS_DE_DADES_	[restricció a nivell de camp],
	...		 ...				...
	camp_n	_TIPUS_DE_DADES_	[restricció a nivell de camp],
			[restricció_1 a nivell de taula],
			[restricció_2 a nivell de taula],
			...
);
```

Fem un parell d'exemples.

```
CREATE TABLE clients2 (
	PRIMARY KEY(num_clie),
	num_clie		SMALLINT,
	empresa        	VARCHAR(20)		NOT NULL,
	rep_clie		SMALLINT 		NOT NULL REFERENCES rep_vendes,
	limit_credit	NUMERIC(8,2)
);
``` 

```
CREATE TABLE empleat(
	PRIMARY KEY (empno),
	empno	SMALLINT, 
	ename	VARCHAR(10)
);
```

## L'opció DEFAULT

Es pot especificar un valor per defecte per a un camp, de manera que quan es realitzi l'inserció d'una fila sense valor per a aquest camp, prendrà el que estigui definit per defecte.

```
CREATE TABLE emp (
	...
	hiredate DATE DEFAULT current_date,
	...
);
```

## Constraints (restriccions)

### Definició i tipus de constraints.

Les restriccions (CONSTRAINT) són regles que s'apliquen sobre les taules i que
el SGBD s'encarrega de verificar abans de cada operació DML (INSERT, UPDATE,
DELETE).

Hi ha 5 tipus de restriccions. Les més importants són les de clau primària i
clau aliena.

- PRIMARY KEY: clau primària
- FOREIGN KEY / REFERENCES: clau forana / aliena, per assegurar la integritat referencial. 
- NOT NULL: la columna no pot ser nul.
- UNIQUE: cada valor ha de ser únic a la columna. [Més info](http://stackoverflow.com/questions/9565996/difference-between-primary-key-and-unique-key) i també [aquí](http://tsqltips.blogspot.com/2012/06/difference-between-unique-key-and.html)
- CHECK: comprova que el camp compleixi una condició.


### Sintaxi i nom d'una constraint.

> Constraints should be given a custom name excepting UNIQUE, PRIMARY KEY and FOREIGN KEY where the database vendor will generally supply sufficiently intelligible names automatically.

Necessitem que quan hi hagi un error perquè s'ha incomplert una restricció la identifiquem de seguida. Suposarem que el fabricant del SGBDR ens proporcionarà un nom identificable per UNIQUE, PRIMARY KEY i FOREIGN KEY. Però per la CHECK li donarem un nom de format:

`nom_taula_nom_camp_ck`

Hi ha un altre estil també molt utilitzat que és fer servir aquesta notació per les altres restriccions. Es substitueix _ck_ per _pk_, _fk_, _nn_, _uk_. 



Exemple:

```
CREATE TABLE DEPT (
	PRIMARY KEY(deptno),
	deptno  SMALLINT,
	dname   VARCHAR(14) CONSTRAINT dept_dname_ck CHECK(dname LIKE 'Dept.%'),
	loc     VARCHAR(13)
);
```

## Constraint Primary Key

- Restricció que s'aplica als camps que són clau primària (CP).
- Impedeix que s'insereixin valors repetits o nuls
- Quan la CP és simple, es pot definir a nivell de columna (al costat del tipus de dades) o a nivell de taula (al final de la definició de la taula).
- Quan sigui composta, la definirem a nivell de taula (al final de la definició)

### Exemple de Primary key


Ja hem vist com posarem nosaltres la clau primària: com la primera línia.
 
Però veurem altres maneres de representar-les:
 
- CP simple, definida a nivell de camp:
	```
	CREATE TABLE dept (
		deptno  SMALLINT CONSTRAINT dept_deptno_pk PRIMARY KEY,
		dname   VARCHAR(14),
		loc     VARCHAR(13)
	);
	```

- CP simple, definida a nivell de taula (en comptes de la primera línia, al final)

	```
	CREATE TABLE dept (
		deptno  SMALLINT,
		dname   VARCHAR(14),
		loc     VARCHAR(13),
		        CONSTRAINT dept_deptno_pk PRIMARY KEY(deptno)
	);
	```

- CP composta: obligatori declarar-la a nivell de taula.

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

## Constraint Foreign key (FK)

- La **integritat referencial** exigeix que el valor d'una columna que és clau forània, hagi d'existir com a clau primària de la taula relacionada.
	Exemple: Si a la taula _clients_, un registre, o sigui un fila, té el camp rep_clie amb valor 108, haurà d'existir una fila a rep_vendes amb num_empl 108.
- Serveix per identificar la clau forana (CF) i permetre recuperar informació entre diferentes taules a través de l'operacio de JOIN. 
- Si la CF és simple, es pot definir a nivell de camp o a nivell de taula.  
- Si la CF és composta, només es podrà definir a nivell de taula.

### Exemples de Foreign key


- CF simple, a nivell de camp

	```
	CREATE TABLE emp (
		PRIMARY KEY(empno),
		empno       SMALLINT,
		ename       VARCHAR(10),
		job         VARCHAR(9),
		mgr         SMALLINT,
		hiredate    DATE,
		sal         NUMERIC(7, 2),
		comm        NUMERIC(7, 2),
		deptno      SMALLINT        REFERENCES dept
	);
	```

REFERENCES: denota que és clau forània, força integritat referencial en afegir files.

- CF simple, a nivell de taula

	```
	CREATE TABLE emp (
		PRIMARY KEY(empno),
		empno       SMALLINT,
		ename       VARCHAR(10),
		job         VARCHAR(9),
		mgr         SMALLINT,
		hiredate    DATE,
		sal         NUMERIC(7, 2),
		comm        NUMERIC(7, 2),
		deptno      SMALLINT,
		            CONSTRAINT emp_deptno_fk REFERENCES dept(deptno)
	);
	```
### Tenim problemes quan creem una CF?

Si tenim problemes a l'hora d'afegir una clau forana a una taula, sempre la podrem afegir amb posterioritat a la creació a la taula. Això serà útil quan tenim dues taules que s'apunten mutuament amb les claus alienes o en el cas de relacions reflexives. Ho farem amb l'ordre `ALTER`.

Exemple:

```
CREATE TABLE emp (
	PRIMARY KEY(empno),
	empno       SMALLINT,
	ename       VARCHAR(10),
	job         VARCHAR(9),
	mgr         SMALLINT,
	hiredate    DATE,
	sal         NUMERIC(7, 2),
	comm        NUMERIC(7, 2)
);

ALTER TABLE  emp
ADD CONSTRAINT emp_mgr_fk FOREIGN KEY (mgr) REFERENCES emp(empno);
```

### Política a l'incomplir la integritat referencial


- `ON DELETE`: què fer si trenquem integritat referencial en esborrar una fila de la taula referenciada.
- `ON UPDATE`: què fer si trenquem integritat referencial en modificar una fila de la taula referenciada.

Possibles accions:

- RESTRICT: retorna un error i no es deixa fer l'operació.
- CASCADE: esborra o modifica les files afectades.
- SET DEFAULT: es posa el valor per defecte.
- SET NULL: es posa el valor a NULL.

```
CREATE TABLE clients (
	PRIMARY KEY (num_clie),
	num_clie        SMALLINT,
	empresa         VARCHAR(20)     NOT NULL,
	rep_clie        SMALLINT        NOT NULL 
	                                REFERENCES rep_vendes
	                                ON DELETE RESTRICT,
	limit_credit    NUMERIC(8,2)
);
```

```
INSERT INTO clients
VALUES (200, 'Bit', 108, 10000);
```

Què farà la següent ordre, tenint en compte la constraint descrita abans?

```
DELETE FROM rep_vendes
WHERE num_empl = 108;
```

**Solució:**

Res, mostrarà un missatge d'error.



```
CREATE TABLE clients (
	PRIMARY KEY (num_clie),
	num_clie        SMALLINT,
	empresa         VARCHAR(20)     NOT NULL,
	rep_clie        SMALLINT        NOT NULL
	                                REFERENCES rep_vendes
	                                ON DELETE CASCADE,
	limit_credit    NUMERIC(8,2)
);
```

```
INSERT INTO clients
VALUES (200, 'Bit', 108, 10000);
```

Què farà la següent ordre, tenint en compte la constraint descrita abans?


```
DELETE FROM rep_vendes
WHERE num_empl = 108; 
```

**Solució:**

L'ordre anterior intentarà eliminar el venedor de la taula rep_vendes, aquest venedor pot sortir a la taula clients, de manera que si s'elimina la seva referència en aquesta darrera taula s'aplicaria la política ON CASCADE, o sigui s'eliminaria aquell client que tingui al 108 com a venedor.

El problema però el tenim amb les altres taules ja que si comandes u oficines o la mateixa rep_vendes que s'autoreferencia tenen NO ACTION (que és l'opció que hi ha per defecte quan no es posa res) saltarà l'error i no es modificarà res.

## Herència

L'herència és una eina que ens permet heretar l'estructura d'una taula i afegir-hi
camps nous.

```
CREATE TABLE clients_vip (
	punts INTEGER
)INHERITS (clients);
```

Si mostrem l'estructura de la taula mare:

```
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

```
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

Totes les constraints de tipus CHECK i NOT NULL són heretades, a no ser que
s'indiqui explícitament el contrari. Les altres constraints no s'hereten. Podeu
trobar informació molt interessant
[aquí](https://www.postgresql.org/docs/13/ddl-inherit.html)


## Creació d'una taula a partir d'una consulta
```
CREATE TABLE oficines_est 
    AS (SELECT oficina, ciutat, objectiu, vendes
          FROM oficines
         WHERE regio = 'Oest');
```

## Creació d'una taula temporal

Quan sortim de la sessió la taula desapareixerà:

Forma estàndard: features opcionals de SQL-2016 estàndard.
```
CREATE LOCAL TEMPORARY TABLE table2 ...;
```

PostgreSQL té la seva pròpia comanda:

```
CREATE TEMP TABLE table2 ...;
```

## Eliminació de taules

```
DROP TABLE taula
```

## Modificació de l'estructura d'una taula


+ Afegim un camp:
	```
	ALTER TABLE oficines 
	  ADD telefon varchar(9);
	```

+ Modificar camp:
	```
	ALTER TABLE oficines 
	ALTER telefon varchar(20);
	```

+ Esborrar camp:
	```
	ALTER TABLE oficines 
	 DROP telefon;
	```

+ Afegir constraint:
	```
	ALTER TABLE oficines
	  ADD CHECK(ciutat <> 'Barcelona')
	```
+ o amb nom

	```
	ALTER TABLE oficines
	  ADD CONSTRAINT oficines_ciutat_ck CHECK(ciutat <> 'Badalona')
	```

## EXTRES

### Restriccions i moment en que es comproven. DEFERRABLE

> Quan es fa la comprovació del compliment de les CONSTRAINTS?

La resposta depèn de si la restricció és _DEFERRABLE_ o _NOT DEFERRABLE_ (ajornable o no ajornable)

Aquest concepte fa referència al moment en que és comproven les CONSTRAINTS.

+ Si no estem dintre d'una transacció, per defecte el que passa a PostgreSQL, la constraint es comprova de seguida, no s'ajorna: NOT DEFERRABLE.
+ Si hi ha transacció, es pot definir amb l'ordre SET el comportament d'una constraint:
	+ SET CONSTRAINTS name_constraint IMMEDIATE:
	La constraint es comprova al final de cada declaració.
	+ SET CONSTRAINTS name_constraint DEFERRED
	La constraint no es comprova fins que la transacció acabi amb un COMMIT.

+ NOT NULL i CHECK constraints no admeten aquesta opció ja que són sempre comprovades immediatament.


### RESTRICT i NO ACTION

A les possibles respostes que ja coneixem d'un incompliment de la constraint ( RESTRICT, CASCADE, SET DEFAULT i SET NULL) s'hauria d'afegir NO ACTION que és la que PostgreSQL té per defecte. 

RESTRICT i NO ACTION són iguals excepte si es defineix la constraint com a DEFERRED o com a IMMEDIATE


