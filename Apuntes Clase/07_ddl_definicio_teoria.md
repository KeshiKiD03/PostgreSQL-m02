
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
	camp_1	_tipus_de_dades_	[restricció a nivell de camp],
	camp_2	_tipus_de_dades_	[restricció a nivell de camp],
	...		 ...				...
	camp_n	_tipus_de_dades_	[restricció a nivell de camp],
			[restricció_1 a nivell de taula],
			[restricció_2 a nivell de taula]
			...
);
```

Fem un parell d'exemples.

```
CREATE TABLE clients2 (
	PRIMARY KEY(num_clie),
	num_clie		smallint,
	empresa		character varying(20)	NOT NULL,
	rep_clie		smallint 			NOT NULL REFERENCES rep_vendes 
	limit_credit	numeric(8,2),
);
``` 

```
CREATE TABLE empleat(
	PRIMARY KEY (empno),
	empno	SMALLINT, 
	ename	VARCHAR(10),
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
- UNIQUE: cada valor ha de ser únic a la columna. [Més info](http://stackoverflow.com/questions/9565996/difference-between-primary-key-and-unique-key) 
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
	deptno	SMALLINT,
	dname		VARCHAR(14) CONSTRAINT dept_dname_ck CHECK(dname LIKE 'Dept.%'),
	loc		VARCHAR(13),
);
```

## Primary key

- Restricció que s'aplica als camps que són clau primària (CP).
- Impedeix que s'insereixin valors repetits o nuls
- Quan la CP és simple, es pot definir a nivell de columna (al costat del tipus de dades) o a nivell de taula (al final de la definició de la taula).
- Quan sigui composta, la definirem a nivell de taula (al final de la definició)

## Exemple de Primary key


Ja hem vist com posarem nosaltres la clau primària: com la primera línia.
 
Però veurem altres maneres de representar-les:
 
- CP simple, definida a nivell de camp:
	```
	CREATE TABLE dept (
		deptno	SMALLINT CONSTRAINT dept_deptno_pk PRIMARY KEY,
		dname		VARCHAR(14),
		loc		VARCHAR(13)
	);
	```

- CP simple, definida a nivell de taula (en comptes de la primera línia, al final)

	```
	CREATE TABLE dept (
		deptno	SMALLINT,
		dname		VARCHAR(14),
		loc		VARCHAR(13),
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

## Exemples de Foreign key


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
