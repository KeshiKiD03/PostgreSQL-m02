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

+ Solució al _problema-parèntesi_ plantejat a **l'exercici 1**:

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

	Un esquema proveeix informació de les taules, vistes, columnes i procedures
	(funcions) de la base de dades Si Ara no explicarem els esquemes. Una idea
	resumida la podeu trobar
	[aquí](https://en.wikipedia.org/wiki/Information_schema)


	Cada taula té per associat un esquema. Si hi ha la mateixa taula a dos esquemes
	hi haurà una que serà la que hi hhagi per defecte. En aquest cas per a totes és
	public menys per a 'clients'. Però puc cridar a la taula clients posant el
	esquema davant:

	```SQL
	SELECT *
	  FROM public.clients;
	```


