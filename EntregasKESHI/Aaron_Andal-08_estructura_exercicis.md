# Exercicis DDL (Estructura)

## Exercici 1

+ Crear una base de dades anomenada "biblioteca". Dins aquesta base de dades:
+ crear una taula anomenada llibres amb els camps següents:
```
CREATE DATABASE biblioteca;
```


	+ "ref": clau primaria numèrica que identifica els llibres i s'ha d'assignar automàticament.
	
	+ "titol": títol del llibre.
	+ "editorial": nom de l'editorial.
	+ "autor": identificador de l'autor, clau forana, per defecte ha de
+ referenciar a primer valor de la taula autors que simbolitzar l'autor "Anònim".

1. Crear la taula LLIBRES

```
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

```
template1=> CREATE TABLE authors (
        author             INT NOT NULL
                                CONSTRAINT author_pk PRIMARY KEY,
        nom           VARCHAR(20),
        nacionalitat       VARCHAR(20) 
) ;
CREATE TABLE
```

3. Crear la CONSTRAINT FOREIGN KEY de AUTHORS.

```
template1=> ALTER TABLE llibres
ADD CONSTRAINT author_fk FOREIGN KEY (author) REFERENCES authors(author)
template1-> ;
ALTER TABLE
```

4. Revisem la taula LLIBRES.

```
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

```
biblioteca=> INSERT INTO authors VALUES (
    1,
    'Anonim',
    'Catala'
);
INSERT 0 1
biblioteca=> 

```

```
biblioteca=> SELECT * FROM authors;
 author |  nom   | nacionalitat 
--------+--------+--------------
      1 | Anonim | Catala
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


```
CREATE TABLE socis (
        num_soci             INTEGER NOT NULL
                                CONSTRAINT numSoci_pk PRIMARY KEY,
        nom           VARCHAR(20),
        cognom       VARCHAR(20),
        DNI          VARCHAR(9) UNIQUE NOT NULL
) ;
```


```
CREATE TABLE prestecs (
        ref             INTEGER NOT NULL
            CONSTRAINT prestecs_ref_fk REFERENCES llibres (ref) ON DELETE CASCADE,
        soci            INTEGER
            CONSTRAINT prestecs_soci_fk REFERENCES socis (num_soci) ON DELETE RESTRICT,
        data_prestec    DATE
            
CREATE TABLE
) ;
```

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




## Exercici 3

A la base de dades training crear una taula anomenada "rep_vendes_baixa" que tingui la mateixa estructura que la taula rep_vendes i a més a més un camp anomenat "baixa" que pugui contenir la data en que un representant de vendes s'ha donat de baixa.


```
training=> CREATE TABLE rep_vendes_baixa (
    baixa       TIMESTAMP
)INHERITS (rep_vendes);
CREATE TABLE
training=> 

```

```
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



## Exercici 4

A la base de dades training crear una taula anomenada "productes_sense_comandes" omplerta amb aquells productes que no han tingut mai cap comanda. A continuació esborrar de la taula "productes" aquells productes que estan en aquesta nova taula.

## Obtenim els productes que mai s'han fet comanda.

```
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

```
training=> CREATE TABLE productes_sense_comandes AS (
    (SELECT comandes.producte, productes.id_fabricant, productes.id_producte FROM comandes RIGHT JOIN productes ON (comandes.producte = productes.id_producte) AND (comandes.fabricant = productes.id_fabricant) WHERE comandes.num_comanda IS NULL)
);
SELECT 8
training=> 

```


## Visualitzem la taula productes_sense_comandes amb un SELECT
```
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

```
DELETE FROM productes
WHERE id_producte IN (SELECT id_producte FROM productes_sense_comandes);
```




## Exercici 5

A la base de dades training crear una taula temporal que substitueixi la taula "clients" però només ha de contenir aquells clients que no han fet comandes i tenen assignat un representant de vendes amb unes vendes inferiors al 110% de la seva quota.

```
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


```
training=> SELECT * FROM clients2;
 num_clie 
----------
     2115
     2121
     2122
     2105
(4 rows)

```


## Exercici 6

Escriu les sentències necessàries per a crear l'estructura de l'esquema proporcionat de la base de dades training. Justifica les accions a realitzar en modificar/actualitzar les claus primàries.

```
CREATE TABLE IF NOT EXISTS PRODUCTES (
    PRIMARY KEY(id_fabricant,id_producte),
    id_fabricant        VARCHAR(5),
    id_producte         VARCHAR(5),
    descripcio          VARCHAR(20)     NOT NULL,
    preu                NUMERIC(8,2)    NOT NULL,
    estoc               INT             NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS OFICINES (
    PRIMARY KEY(oficina),
    oficina             SMALLINT,
    ciutat              VARCHAR(15)     NOT NULL,
    regio               VARCHAR(10)     NOT NULL,
    director            SMALLINT,
    objectiu            NUMERIC(9,2),
    vendes              NUMERIC(9,2)    NOT NULL DEFAULT 0
);


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

CREATE TABLE IF NOT EXISTS CLIENTS (
    PRIMARY KEY(num_clie),
    num_clie            SMALLINT,
    empresa             VARCHAR(20)     NOT NULL,
    rep_clie            SMALLINT        NOT NULL,
    limit_credit        NUMERIC(8,2)
);

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

## Exercici 7

Escriu una sentència que permeti modificar la base de dades training proporcionada. Cal que afegeixi un camp anomenat "nif" a la taula "clients" que permeti emmagatzemar el NIF de cada client. També s'ha de procurar que el NIF de cada client sigui únic.

```
ALTER TABLE clients 
  ADD nif VARCHAR(9) UNIQUE;
```

## Exercici 8

Escriu una sentència que permeti modificar la base de dades training proporcionada. Cal que afegeixi un camp anomenat "tel" a la taula "clients" que permeti emmagatzemar el número de telèfon de cada client. També s'ha de procurar que aquest contingui 9 xifres.

```
ALTER TABLE clients 
  ADD tel INT;
  
ALTER TABLE clients
    ADD CONSTRAINT clients_tel_ck CHECK(length(tel::text) = 9);
```

## Exercici 9

Escriu les sentències necessàries per modificar la base de dades training proporcionada. Cal que s'impedeixi que els noms dels representants de vendes i els noms dels clients estiguin buits, és a dir que ni siguin nuls ni continguin la cadena buida.

```
ALTER TABLE rep_vendes 
  ADD constraint rep_nom_ck CHECK (nom <> '' OR nom IS NOT NULL);
  
ALTER TABLE clients 
  ADD constraint cli_empresa_ck CHECK (empresa <> '' OR empresa IS NOT NULL);
```

## Exercici 10

Escriu una sentència que permeti modificar la base de dades training proporcionada. Cal que procuri que l'edat dels representants de vendes no sigui inferior a 18 anys ni superior a 65.

```
ALTER TABLE rep_vendes 
  ADD constraint rep_edad_ck CHECK (edat>=18 OR edat<=65);
```

## Exercici 11

Escriu una sentència que permeti modificar la base de dades training proporcionada. Cal que esborri el camp "carrec" de la taula "rep_vendes" esborrant també les possibles restriccions i referències que tingui.

```
ALTER TABLE rep_vendes 
  DROP carrec CASCADE;
```


## Exercici 12

Escriu les sentències necessàries per modificar la base de dades training proporcionada per tal que aquesta tingui integritat referencial. Justifica les accions a realitzar per modificar les dades.

```
CREATE TABLE IF NOT EXISTS PRODUCTES (
    PRIMARY KEY(id_fabricant,id_producte),
    id_fabricant        VARCHAR(5),
    id_producte         VARCHAR(5),
    descripcio          VARCHAR(20)     NOT NULL,
    preu                NUMERIC(8,2)    NOT NULL,
    estoc               INT             NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS OFICINES (
    PRIMARY KEY(oficina),
    oficina             SMALLINT,
    ciutat              VARCHAR(15)     NOT NULL,
    regio               VARCHAR(10)     NOT NULL,
    director            SMALLINT,
    objectiu            NUMERIC(9,2),
    vendes              NUMERIC(9,2)    NOT NULL DEFAULT 0
);


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

CREATE TABLE IF NOT EXISTS CLIENTS (
    PRIMARY KEY(num_clie),
    num_clie            SMALLINT,
    empresa             VARCHAR(20)     NOT NULL,
    rep_clie            SMALLINT        NOT NULL,
    limit_credit        NUMERIC(8,2),
                        CONSTRAINT FK_CLIENTS_REP_CLIE FOREIGN KEY(REP_CLIE) REFERENCES REP_VENDES(NUM_EMPL)
);

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