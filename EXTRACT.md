EXTRACT(year FROM comandes.data)








EXTRACT(year FROM comandes.data)

EXTRACT(year FROM comandes.data)














# Aaron Andal isx36579183

# Borrar CK_REP_VENDES_VENDES

training=> ALTER TABLE rep_vendes DROP CONSTRAINT ck_rep_vendes_vendes 
training-> ;
ALTER TABLE
training=> 


# Modificació

## Exercici 1:

Inseriu un nou venedor amb nom "Enric Jimenez" amb identificador 1012, oficina 18, títol "Dir Vendes", contracte d'1 de febrer del 2012, cap 101 i vendes 0.

INSERT INTO rep_vendes (num_empl, 
			nom, 
			oficina_rep, 
			carrec, 
			data_contracte, 
			cap, 
			vendes
			) 
			
			VALUES (
				1012, 
				'Enric Jimenez',
				13,
				'Dir Vendes',
				'2012-02-01',
				101,
				0
				);


training=> SELECT * FROM rep_vendes WHERE num_empl = 1012;
 num_empl |      nom      | edat | oficina_rep |   carrec   | data_contracte | cap | quota | vendes 
----------+---------------+------+-------------+------------+----------------+-----+-------+--------
     1012 | Enric Jimenez |      |          13 | Dir Vendes | 2012-02-01     | 101 |       |   0.00
(1 row)


## Exercici 2:

Inseriu un nou client "C1" i una nova comanda pel venedor anterior.

training=> INSERT INTO clients (num_clie, empresa, rep_clie, limit_credit) VALUES (1245,'C1',103,50000);

INSERT 0 1

training=> SELECT * FROM clients WHERE empresa = 'C1';
 num_clie | empresa | rep_clie | limit_credit 
----------+---------+----------+--------------
     1245 | C1      |      1012 |     50000.00
(1 row)


training=> INSERT INTO comandes VALUES (
    112741,
    '1987-12-15',
    1245,
    (SELECT num_empl FROM rep_vendes WHERE nom = 'Enric Jimenez'),
    'aci',
    '4100z',
    1,
    2500
   
   );
   
   
INSERT 0 1

training=> SELECT * FROM comandes WHERE num_comanda = 112741;
 num_comanda |    data    | clie | rep  | fabricant | producte | quantitat | import  
-------------+------------+------+------+-----------+----------+-----------+---------
      112741 | 1987-12-15 | 1245 | 1012 | aci       | 4100z    |         1 | 2500.00
(1 row)

			






## Exercici 3:

Inseriu un nou venedor amb nom "Pere Mendoza" amb identificador 1013, contracte del 15 de agost del 2011 i vendes 0. La resta de camps a null.

INSERT INTO rep_vendes (num_empl, nom, edat, oficina_rep, carrec, data_contracte, cap, quota, vendes) VALUES (1013, 'Pere Mendoza', NULL, NULL, NULL, '2011-08-15', NULL, NULL, 0);

INSERT 0 1

training=> SELECT * FROM rep_vendes WHERE num_empl = 1013;
 num_empl |     nom      | edat | oficina_rep | carrec | data_contracte | cap | quota | vendes 
----------+--------------+------+-------------+--------+----------------+-----+-------+--------
     1013 | Pere Mendoza |      |             |        | 2011-08-15     |     |       |   0.00
(1 row)


## Exercici 4:

Inseriu un nou client "C2" omplint els mínims camps.

training=> INSERT INTO clients (num_clie, empresa, rep_clie, limit_credit) VALUES (1234, 'C2', (SELECT num_empl FROM rep_vendes WHERE nom = 'Pere Mendoza'), 0);

INSERT 0 1

training=> SELECT * FROM clients WHERE num_clie = 1234;
 num_clie | empresa | rep_clie | limit_credit 
----------+---------+----------+--------------
     1234 | C2      |     1013 |         0.00
(1 row)

## Exercici 5:

Inseriu una nova comanda del client "C2" al venedor "Pere Mendoza" sense especificar la llista de camps pero si la de valors.

training=> INSERT INTO comandes VALUES (113333, '1990-01-22', (SELECT num_clie FROM clients WHERE empresa = 'C2'), (SELECT num_empl FROM rep_vendes WHERE nom = 'Pere Mendoza'), 'rei', '2a45c', 2, 158);

INSERT 0 1

training=> SELECT * FROM comandes WHERE clie = (SELECT num_clie FROM clients WHERE empresa = 'C2');
 num_comanda |    data    | clie | rep  | fabricant | producte | quantitat | import 
-------------+------------+------+------+-----------+----------+-----------+--------
      113333 | 1990-01-22 | 1234 | 1013 | rei       | 2a45c    |         2 | 158.00
(1 row)


## Exercici 6:

Esborreu de la còpia de la base de dades el venedor afegit anteriorment anomenat "Enric Jimenez".





training=> DELETE FROM rep_vendes WHERE nom = 'Enric Jimenez';
ERROR:  update or delete on table "rep_vendes" violates foreign key constraint "fk_clients_rep_clie" on table "clients"
DETAIL:  Key (num_empl)=(1012) is still referenced from table "clients".
training=> 

* S'ha d'esborrar primer la comanda, després el client i després el venedor. Si no hi ha error d'integritat ja que no es pot deixar NULL. Segons \d.

1. training=> DELETE FROM comandes WHERE clie = 1245;
DELETE 1
training=> 

2. training=> DELETE FROM clients WHERE empresa = 'C1';
DELETE 1
training=> 

3. training=> DELETE FROM rep_vendes WHERE nom = 'Enric Jimenez';
DELETE 1

   
## Exercici 7:

Elimineu totes les comandes del client "C1" afegit anteriorment.

training=> DELETE FROM comandes WHERE clie = (SELECT num_clie FROM clients WHERE empresa = 'C1');
DELETE 1


training=> SELECT * FROM comandes WHERE clie = (SELECT num_clie FROM clients WHERE empresa = 'C1');
 num_comanda | data | clie | rep | fabricant | producte | quantitat | import 
-------------+------+------+-----+-----------+----------+-----------+--------
(0 rows)



## Exercici 8:

Esborreu totes les comandes d'abans del 15-11-1989.

DELETE FROM comandes WHERE data < '1989-11-15';



training=> DELETE FROM comandes WHERE data < '1989-11-15';
DELETE 4
training=> 


training=> SELECT data FROM comandes WHERE data < '1989-11-15';
 data 
------
(0 rows)

training=> 


# ABANS

 num_comanda |    data    | clie | rep  | fabricant | producte | quantitat |  import  
-------------+------------+------+------+-----------+----------+-----------+----------
      112961 | 1989-12-17 | 2117 |  106 | rei       | 2a44l    |         7 | 31500.00
      113012 | 1990-01-11 | 2111 |  105 | aci       | 41003    |        35 |  3745.00
      112989 | 1990-01-03 | 2101 |  106 | fea       | 114      |         6 |  1458.00
      113051 | 1990-02-10 | 2118 |  108 | qsa       | k47      |         4 |  1420.00
      112968 | 1989-10-12 | 2102 |  101 | aci       | 41004    |        34 |  3978.00
      110036 | 1990-01-30 | 2107 |  110 | aci       | 4100z    |         9 | 22500.00
      113045 | 1990-02-02 | 2112 |  108 | rei       | 2a44r    |        10 | 45000.00
      112963 | 1989-12-17 | 2103 |  105 | aci       | 41004    |        28 |  3276.00
      113013 | 1990-01-14 | 2118 |  108 | bic       | 41003    |         1 |   652.00
      113058 | 1990-02-23 | 2108 |  109 | fea       | 112      |        10 |  1480.00
      112997 | 1990-01-08 | 2124 |  107 | bic       | 41003    |         1 |   652.00
      112983 | 1989-12-27 | 2103 |  105 | aci       | 41004    |         6 |   702.00
      113024 | 1990-01-20 | 2114 |  108 | qsa       | xk47     |        20 |  7100.00
      113062 | 1990-02-24 | 2124 |  107 | fea       | 114      |        10 |  2430.00
      112979 | 1989-10-12 | 2114 |  102 | aci       | 4100z    |         6 | 15000.00
      113027 | 1990-01-22 | 2103 |  105 | aci       | 41002    |        54 |  4104.00
      113007 | 1990-01-08 | 2112 |  108 | imm       | 773c     |         3 |  2925.00
      113069 | 1990-03-02 | 2109 |  107 | imm       | 775c     |        22 | 31350.00
      113034 | 1990-01-29 | 2107 |  110 | rei       | 2a45c    |         8 |   632.00
      112992 | 1989-11-04 | 2118 |  108 | aci       | 41002    |        10 |   760.00
      112975 | 1989-12-12 | 2111 |  103 | rei       | 2a44g    |         6 |  2100.00
      113055 | 1990-02-15 | 2108 |  101 | aci       | 4100x    |         6 |   150.00
      113048 | 1990-02-10 | 2120 |  102 | imm       | 779c     |         2 |  3750.00
      112993 | 1989-01-04 | 2106 |  102 | rei       | 2a45c    |        24 |  1896.00
      113065 | 1990-02-27 | 2106 |  102 | qsa       | xk47     |         6 |  2130.00
      113003 | 1990-01-25 | 2108 |  109 | imm       | 779c     |         3 |  5625.00
      113049 | 1990-02-10 | 2118 |  108 | qsa       | xk47     |         2 |   776.00
      112987 | 1989-12-31 | 2103 |  105 | aci       | 4100y    |        11 | 27500.00
      113057 | 1990-02-18 | 2111 |  103 | aci       | 4100x    |        24 |   600.00
      113042 | 1990-02-02 | 2113 |  101 | rei       | 2a44r    |         5 | 22500.00
      113333 | 1990-01-22 | 1234 | 1013 | rei       | 2a45c    |         2 |   158.00
(31 rows)


# DESPRÉS

training=> SELECT * FROM comandes;
 num_comanda |    data    | clie | rep  | fabricant | producte | quantitat |  import  
-------------+------------+------+------+-----------+----------+-----------+----------
      112961 | 1989-12-17 | 2117 |  106 | rei       | 2a44l    |         7 | 31500.00
      113012 | 1990-01-11 | 2111 |  105 | aci       | 41003    |        35 |  3745.00
      112989 | 1990-01-03 | 2101 |  106 | fea       | 114      |         6 |  1458.00
      113051 | 1990-02-10 | 2118 |  108 | qsa       | k47      |         4 |  1420.00
      110036 | 1990-01-30 | 2107 |  110 | aci       | 4100z    |         9 | 22500.00
      113045 | 1990-02-02 | 2112 |  108 | rei       | 2a44r    |        10 | 45000.00
      112963 | 1989-12-17 | 2103 |  105 | aci       | 41004    |        28 |  3276.00
      113013 | 1990-01-14 | 2118 |  108 | bic       | 41003    |         1 |   652.00
      113058 | 1990-02-23 | 2108 |  109 | fea       | 112      |        10 |  1480.00
      112997 | 1990-01-08 | 2124 |  107 | bic       | 41003    |         1 |   652.00
      112983 | 1989-12-27 | 2103 |  105 | aci       | 41004    |         6 |   702.00
      113024 | 1990-01-20 | 2114 |  108 | qsa       | xk47     |        20 |  7100.00
      113062 | 1990-02-24 | 2124 |  107 | fea       | 114      |        10 |  2430.00
      113027 | 1990-01-22 | 2103 |  105 | aci       | 41002    |        54 |  4104.00
      113007 | 1990-01-08 | 2112 |  108 | imm       | 773c     |         3 |  2925.00
      113069 | 1990-03-02 | 2109 |  107 | imm       | 775c     |        22 | 31350.00
      113034 | 1990-01-29 | 2107 |  110 | rei       | 2a45c    |         8 |   632.00
      112975 | 1989-12-12 | 2111 |  103 | rei       | 2a44g    |         6 |  2100.00
      113055 | 1990-02-15 | 2108 |  101 | aci       | 4100x    |         6 |   150.00
      113048 | 1990-02-10 | 2120 |  102 | imm       | 779c     |         2 |  3750.00
      113065 | 1990-02-27 | 2106 |  102 | qsa       | xk47     |         6 |  2130.00
      113003 | 1990-01-25 | 2108 |  109 | imm       | 779c     |         3 |  5625.00
      113049 | 1990-02-10 | 2118 |  108 | qsa       | xk47     |         2 |   776.00
      112987 | 1989-12-31 | 2103 |  105 | aci       | 4100y    |        11 | 27500.00
      113057 | 1990-02-18 | 2111 |  103 | aci       | 4100x    |        24 |   600.00
      113042 | 1990-02-02 | 2113 |  101 | rei       | 2a44r    |         5 | 22500.00
      113333 | 1990-01-22 | 1234 | 1013 | rei       | 2a45c    |         2 |   158.00
(27 rows)

training=> 



## Exercici 9:

Esborreu tots els clients dels venedors: Adams, Jones i Roberts.

training=> SELECT * FROM clients WHERE rep_clie IN (SELECT num_empl FROM rep_vendes WHERE nom LIKE '%Adams' OR nom LIKE '%Jones' OR nom LIKE '%Roberts');
 num_clie |     empresa     | rep_clie | limit_credit 
----------+-----------------+----------+--------------
     2102 | First Corp.     |      101 |     65000.00
     2103 | Acme Mfg.       |      105 |     50000.00
     2115 | Smithson Corp.  |      101 |     20000.00
     2108 | Holm & Landis   |      109 |     55000.00
     2122 | Three-Way Lines |      105 |     30000.00
     2119 | Solomon Inc.    |      109 |     25000.00
     2105 | AAA Investments |      101 |     45000.00
(7 rows)

training=> DELETE FROM clients WHERE rep_clie IN (SELECT num_empl FROM rep_vendes WHERE nom LIKE '%Adams' OR nom LIKE '%Jones' OR nom LIKE '%Roberts');
ERROR:  update or delete on table "clients" violates foreign key constraint "fk_comandes_clie" on table "comandes"
DETAIL:  Key (num_clie)=(2103) is still referenced from table "comandes".

# Dona error --> Solució

1. Esborrar les comandes del 3 venedors.

training=> DELETE FROM comandes WHERE rep IN (SELECT num_empl FROM rep_vendes WHERE nom LIKE '%Adams' OR nom LIKE '%Jones' OR nom LIKE '%Roberts');
DELETE 9

training=> SELECT * FROM comandes WHERE rep IN (SELECT num_empl FROM rep_vendes WHERE nom LIKE '%Adams' OR nom LIKE '%Jones' OR nom LIKE '%Roberts');
 num_comanda | data | clie | rep | fabricant | producte | quantitat | import 
-------------+------+------+-----+-----------+----------+-----------+--------
(0 rows)

2. Ara si

training=> DELETE FROM clients WHERE rep_clie IN (SELECT num_empl FROM rep_vendes WHERE nom LIKE '%Adams' OR nom LIKE '%Jones' OR nom LIKE '%Roberts');
DELETE 7
training=> 



training=> SELECT * FROM clients WHERE rep_clie IN (SELECT num_empl FROM rep_vendes WHERE nom LIKE '%Adams' OR nom LIKE '%Jones' OR nom LIKE '%Roberts');
 num_clie | empresa | rep_clie | limit_credit 
----------+---------+----------+--------------
(0 rows)



## Exercici 10:

Esborreu tots els venedors contractats abans del juliol del 1988 que encara no se'ls ha assignat una quota.


training=> SELECT * FROM rep_vendes WHERE data_contracte < '1988-07-01'
;


 num_empl |     nom     | edat | oficina_rep |       carrec        | data_contracte | cap |   quota   |  vendes   
----------+-------------+------+-------------+---------------------+----------------+-----+-----------+-----------
      105 | Bill Adams  |   37 |          13 | Representant Vendes | 1988-02-12     | 104 | 350000.00 | 367911.00
      102 | Sue Smith   |   48 |          21 | Representant Vendes | 1986-12-10     | 108 | 350000.00 | 474050.00
      106 | Sam Clark   |   52 |          11 | VP Vendes           | 1988-06-14     |     | 275000.00 | 299912.00
      104 | Bob Smith   |   33 |          12 | Dir Vendes          | 1987-05-19     | 106 | 200000.00 | 142594.00
      101 | Dan Roberts |   45 |          12 | Representant Vendes | 1986-10-20     | 104 | 300000.00 | 305673.00
      103 | Paul Cruz   |   29 |          12 | Representant Vendes | 1987-03-01     | 104 | 275000.00 | 286775.00
(6 rows)


training=> SELECT * FROM rep_vendes WHERE data_contracte < '1988-07-01' AND quota IS NULL;
;
 num_empl | nom | edat | oficina_rep | carrec | data_contracte | cap | quota | vendes 
----------+-----+------+-------------+--------+----------------+-----+-------+--------
(0 rows)


* No esborra cap

training=> DELETE FROM rep_vendes WHERE data_contracte < '1988-07-01' AND quota IS NULL;
DELETE 0

training=> 







## Exercici 11:

Esborreu totes les comandes.

training=> DELETE FROM comandes;
DELETE 18
training=> SELECT * FROM comandes;
 num_comanda | data | clie | rep | fabricant | producte | quantitat | import 
-------------+------+------+-----+-----------+----------+-----------+--------
(0 rows)

training=> 

* Sense CLAUSULA where esborra tot.


## Exercici 12:

Esborreu totes les comandes acceptades per la Sue Smith (cal tornar a disposar de la taula comandes)

* EXIT

* DROP DATABASE training;

* CREATE DATABASE training;

* \c training

* training=> \i '/home/keshi/Documents/m02/trainingv4.sql'
ALTER TABLE
ALTER TABLE
DROP TABLE
DROP TABLE
DROP TABLE
DROP TABLE
DROP TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
COPY 25
COPY 5
COPY 10
COPY 21
COPY 30
ALTER TABLE
ALTER TABLE
training=> 

* \d

training=> ALTER TABLE rep_vendes DROP CONSTRAINT ck_rep_vendes_vendes 
training-> ;
ALTER TABLE
training=> 

training=> \d rep_vendes
                        Table "public.rep_vendes"
     Column     |         Type          | Collation | Nullable | Default 
----------------+-----------------------+-----------+----------+---------
 num_empl       | smallint              |           | not null | 
 nom            | character varying(30) |           | not null | 
 edat           | smallint              |           |          | 
 oficina_rep    | smallint              |           |          | 
 carrec         | character varying(20) |           |          | 
 data_contracte | date                  |           | not null | 
 cap            | smallint              |           |          | 
 quota          | numeric(8,2)          |           |          | 
 vendes         | numeric(8,2)          |           |          | 
Indexes:
    "pk_rep_vendes_num_empl" PRIMARY KEY, btree (num_empl)
Check constraints:
    "ck_rep_vendes_edat" CHECK (edat > 0)
    "ck_rep_vendes_nom" CHECK (nom::text = initcap(nom::text))
    "ck_rep_vendes_quota" CHECK (quota > 0::numeric)
Foreign-key constraints:
    "fk_rep_vendes_cap" FOREIGN KEY (cap) REFERENCES rep_vendes(num_empl)
    "fk_rep_vendes_oficina_rep" FOREIGN KEY (oficina_rep) REFERENCES oficines(oficina)
Referenced by:
    TABLE "clients" CONSTRAINT "fk_clients_rep_clie" FOREIGN KEY (rep_clie) REFERENCES rep_vendes(num_empl)
    TABLE "comandes" CONSTRAINT "fk_comandes_rep" FOREIGN KEY (rep) REFERENCES rep_vendes(num_empl)
    TABLE "oficines" CONSTRAINT "fk_oficina_director" FOREIGN KEY (director) REFERENCES rep_vendes(num_empl)
    TABLE "rep_vendes" CONSTRAINT "fk_rep_vendes_cap" FOREIGN KEY (cap) REFERENCES rep_vendes(num_empl)

training=> 


1. Agafar num_empl en rep_vendes a Sue Smith
---
training=> SELECT num_empl FROM rep_vendes WHERE nom = 'Sue Smith';
 num_empl 
----------
      102
(1 row)
---

2. Filtrar les comandes de la Sue Smith.
---
SELECT * FROM comandes WHERE rep = (SELECT num_empl FROM rep_vendes WHERE nom = 'Sue Smith');
 num_comanda |    data    | clie | rep | fabricant | producte | quantitat |  import  
-------------+------------+------+-----+-----------+----------+-----------+----------
      112979 | 1989-10-12 | 2114 | 102 | aci       | 4100z    |         6 | 15000.00
      113048 | 1990-02-10 | 2120 | 102 | imm       | 779c     |         2 |  3750.00
      112993 | 1989-01-04 | 2106 | 102 | rei       | 2a45c    |        24 |  1896.00
      113065 | 1990-02-27 | 2106 | 102 | qsa       | xk47     |         6 |  2130.00
(4 rows)

---

3. Esborrem les comandes de la Sue Smith
---
training=> DELETE FROM comandes WHERE rep = (SELECT num_empl FROM rep_vendes WHERE nom = 'Sue Smith');
DELETE 4
training=>
---

4. Verifiquem.
---
training=> SELECT * FROM comandes WHERE rep = (SELECT num_empl FROM rep_vendes WHERE nom = 'Sue Smith');
 num_comanda | data | clie | rep | fabricant | producte | quantitat | import 
-------------+------+------+-----+-----------+----------+-----------+--------
(0 rows)


---

## Exercici 13:

Suprimeix els clients atesos per venedors les vendes dels quals són inferiors al 80% de la seva quota.


## Exercici 14:

Suprimiu els venedors els quals el seu total de comandes actual (imports) és menor que el 2% de la seva quota.

## Exercici 15:

Suprimiu els clients que no han realitzat comandes des del 10-11-1989.

## Exercici 16:

Eleva el límit de crèdit de l'empresa Acme Manufacturing a 60000 i la reassignes a Mary Jones.

## Exercici 17:

Transferiu tots els venedors de l'oficina de Chicago (12) a la de Nova York (11), i rebaixa les seves quotes un 10%.

## Exercici 18:

Reassigna tots els clients atesos pels empleats 105, 106, 107, a l'empleat 102.

## Exercici 19:

Assigna una quota de 100000 a tots aquells venedors que actualment no tenen quota.

## Exercici 20:

Eleva totes les quotes un 5%.

## Exercici 21:

Eleva en 5000 el límit de crèdit de qualsevol client que ha fet una comanda d'import superior a 25000.

## Exercici 22:

Reassigna tots els clients atesos pels venedors les vendes dels quals són menors al 80% de les seves quotes. Reassignar al venedor 105.

## Exercici 23:

Feu que tots els venedors que atenen a més de tres clients estiguin sota de les ordres de Sam Clark (106).

## Exercici 24:

Augmenteu un 50% el límit de credit d'aquells clients que totes les seves comandes tenen un import major a 30000.

## Exercici 25:

Disminuiu un 2% el preu d'aquells productes que tenen un estoc superior a 200 i no han tingut comandes.

## Exercici 26:

Establiu un nou objectiu per aquelles oficines en que l'objectiu actual sigui inferior a les vendes. Aquest nou objectiu serà el doble de la suma de les vendes dels treballadors assignats a l'oficina.

## Exercici 27:

Modifiqueu la quota dels caps d'oficina que tinguin una quota superior a la quota d'algun empleat de la seva oficina. Aquests caps han de tenir la mateixa quota que l'empleat de la seva oficina que tingui una quota menor.

## Exercici 28:

Cal que els 5 clients amb un total de compres (quantitat) més alt siguin transferits a l'empleat Tom Snyder i que se'ls augmenti el límit de crèdit en un 50%.

## Exercici 29:

Es volen donar de baixa els productes dels que no tenen estoc i alhora no se n'ha venut cap des de l'any 89.

## Exercici 30:

Afegiu una oficina de la ciutat de "San Francisco", regió oest, el cap ha de ser "Larry Fitch", les vendes 0, l'objectiu ha de ser la mitja de l'objectiu de les oficines de l'oest i l'identificador de l'oficina ha de ser el següent valor després del valor més alt.


## BACKUP i RESTORE de la Base de DADES training:

Una manera de fer un backup ràpid des del bash és:

```
pg_dump -Fc training > training.dump
```
Podem eliminar també la base de dades:

```
dropdb training
```
Podem restaurar una base de dades amb:
```
pg_restore -C -d postgres training.dump
```

Una altra manera de fer el mateix:

Backup en fitxer pla
```
pg_dump -f training.dump   training
```

Eliminem la base de dades:

```
dropdb training
```

Creem la base de dades:
```
createdb training
```
Reconstruim l'estructura i dades:
```
psql training < training.dump
```
 




