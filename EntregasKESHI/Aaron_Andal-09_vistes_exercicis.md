# Exercicis Vistes

## Exercici 1

Defineix una vista anomenada "oficina_est" que contingui únicament les dades de les oficines de la regió est.

1.Veiem els usuaris de l'oficina = 'Est'

```
training=> SELECT * FROM oficines WHERE regio = 'Est';
 oficina |  ciutat  | regio | director | objectiu  |  vendes   
---------+----------+-------+----------+-----------+-----------
      11 | New York | Est   |      106 | 575000.00 | 692637.00
      12 | Chicago  | Est   |      104 | 800000.00 | 735042.00
      13 | Atlanta  | Est   |      105 | 350000.00 | 367911.00
(3 rows)
```

2. Creem la vista oficina_est

CREATE OR REPLACE VIEW oficina_est AS 
	SELECT * FROM oficines WHERE regio = 'Est'
	WITH LOCAL CHECK OPTION;
	
```
training=> CREATE OR REPLACE VIEW oficina_est AS 
        SELECT * FROM oficines WHERE regio = 'Est'
        WITH LOCAL CHECK OPTION;
CREATE VIEW
training=> 

```

3. Veiem la vista creada. 

```
training=> SELECT * FROM oficina_est
training-> ;
 oficina |  ciutat  | regio | director | objectiu  |  vendes   
---------+----------+-------+----------+-----------+-----------
      11 | New York | Est   |      106 | 575000.00 | 692637.00
      12 | Chicago  | Est   |      104 | 800000.00 | 735042.00
      13 | Atlanta  | Est   |      105 | 350000.00 | 367911.00
(3 rows)

```

\d+ 

```
                                 View "public.oficina_est"
  Column  |         Type          | Collation | Nullable | Default | Storage  | Description 
----------+-----------------------+-----------+----------+---------+----------+-------------
 oficina  | smallint              |           |          |         | plain    | 
 ciutat   | character varying(15) |           |          |         | extended | 
 regio    | character varying(10) |           |          |         | extended | 
 director | smallint              |           |          |         | plain    | 
 objectiu | numeric(9,2)          |           |          |         | main     | 
 vendes   | numeric(9,2)          |           |          |         | main     | 
View definition:
 SELECT oficines.oficina,
    oficines.ciutat,
    oficines.regio,
    oficines.director,
    oficines.objectiu,
    oficines.vendes
   FROM oficines
  WHERE oficines.regio::text = 'Est'::text;
Options: check_option=local

```


## Exercici 2

Crear una vista de nom "rep_oest" que mostri les dades dels venedors de la
regió oest.

1. Filtrem per saber els usuaris de l'oficina_rep

```
SELECT * FROM rep_vendes WHERE oficina_rep IN (SELECT oficina FROM oficines WHERE regio = 'Oest');

```
```
 num_empl |      nom      | edat | oficina_rep |       carrec        | data_contracte | cap |   quota   |  vendes   
----------+---------------+------+-------------+---------------------+----------------+-----+-----------+-----------
      102 | Sue Smith     |   48 |          21 | Representant Vendes | 1986-12-10     | 108 | 350000.00 | 474050.00
      108 | Larry Fitch   |   62 |          21 | Dir Vendes          | 1989-10-12     | 106 | 350000.00 | 361865.00
      107 | Nancy Angelli |   49 |          22 | Representant Vendes | 1988-11-14     | 108 | 300000.00 | 186042.00
(3 rows)

```

2. Creem la vista.

CREATE OR REPLACE VIEW rep_oest AS 
	SELECT * FROM rep_vendes WHERE oficina_rep IN (SELECT oficina FROM oficines WHERE regio = 'Oest');
	
```
training=> CREATE OR REPLACE VIEW rep_oest AS 
        SELECT * FROM rep_vendes WHERE oficina_rep IN (SELECT oficina FROM oficines WHERE regio = 'Oest');
CREATE VIEW

```

```
 num_empl |      nom      | edat | oficina_rep |       carrec        | data_contracte | cap |   quota   |  vendes   
----------+---------------+------+-------------+---------------------+----------------+-----+-----------+-----------
      102 | Sue Smith     |   48 |          21 | Representant Vendes | 1986-12-10     | 108 | 350000.00 | 474050.00
      108 | Larry Fitch   |   62 |          21 | Dir Vendes          | 1989-10-12     | 106 | 350000.00 | 361865.00
      107 | Nancy Angelli |   49 |          22 | Representant Vendes | 1988-11-14     | 108 | 300000.00 | 186042.00
(3 rows)

```
	

## Exercici 3

Crea una vista temporal de nom "comandes_sue" que contingui únicament les
comandes fetes per clients assignats la representant de vendes Sue.


1. Comandes de la Sue Smith
```
training=> SELECT * FROM comandes WHERE rep IN (SELECT num_empl FROM rep_vendes WHERE nom = 'Sue Smith');

```

2. Creem la Vista

CREATE OR REPLACE VIEW comandes_sue AS 
	SELECT * FROM comandes WHERE rep IN (SELECT num_empl FROM rep_vendes WHERE nom = 'Sue Smith');
	
```
training=> CREATE OR REPLACE VIEW comandes_sue AS 
        SELECT * FROM comandes WHERE rep IN (SELECT num_empl FROM rep_vendes WHERE nom = 'Sue Smith');
CREATE VIEW

```

```
 num_comanda |    data    | clie | rep | fabricant | producte | quantitat |  import  
-------------+------------+------+-----+-----------+----------+-----------+----------
      112979 | 1989-10-12 | 2114 | 102 | aci       | 4100z    |         6 | 15000.00
      113048 | 1990-02-10 | 2120 | 102 | imm       | 779c     |         2 |  3750.00
      112993 | 1989-01-04 | 2106 | 102 | rei       | 2a45c    |        24 |  1896.00
      113065 | 1990-02-27 | 2106 | 102 | qsa       | xk47     |         6 |  2130.00
(4 rows)

```

## Exercici 4

Crea una vista de nom "clientes_vip" mostri únicament aquells clients que la
suma dels imports de les seves comandes superin 30000.

```
training=*> CREATE VIEW clients_vip
                    AS SELECT cli.*
                         FROM clients cli
                        WHERE cli.num_clie = ANY (SELECT com.clie
                                                    FROM comandes com
                                                GROUP BY com.clie
                                                  HAVING SUM(com.import) > 30000);
CREATE VIEW
training=*> SELECT * FROM clients_vip;
 num_clie |     empresa     | rep_clie | limit_credit
----------+-----------------+----------+--------------
     2103 | Acme Mfg.       |      105 |     50000.00
     2112 | Zetacorp        |      108 |     50000.00
     2117 | J.P. Sinclair   |      106 |     35000.00
     2109 | Chen Associates |      103 |     25000.00
(4 rows)
```


## Exercici 5

Crear una vista de nom "info_rep" amb les següents dades dels venedors:
num_empl, nombre, oficina_rep.

```
training=*> CREATE VIEW info_rep
                    AS SELECT num_empl, nom, oficina_rep
                         FROM rep_vendes;
CREATE VIEW
training=*> SELECT * FROM info_rep;
 num_empl |      nom      | oficina_rep
----------+---------------+-------------
      105 | Bill Adams    |          13
      109 | Mary Jones    |          11
      102 | Sue Smith     |          21
      106 | Sam Clark     |          11
      104 | Bob Smith     |          12
      101 | Dan Roberts   |          12
      110 | Tom Snyder    |
      108 | Larry Fitch   |          21
      103 | Paul Cruz     |          12
      107 | Nancy Angelli |          22
(10 rows)
```

## Exercici 6

Crear una vista de nom "info_oficina" que mostri les oficines amb
l'identificador de l'oficina, la ciutat i la regió.

```
training=*> CREATE VIEW info_oficina
                    AS SELECT oficina, ciutat, regio
                         FROM oficines;
CREATE VIEW
training=*> SELECT * FROM info_oficina;
 oficina |   ciutat    | regio
---------+-------------+-------
      22 | Denver      | Oest
      11 | New York    | Est
      12 | Chicago     | Est
      13 | Atlanta     | Est
      21 | Los Angeles | Oest
(5 rows)
```

## Exercici 7

Crear una vista de nom "info_clie" que contingui el nom de l'empresa dels
clients i l'identificador del venedor que tenen assignat.

```
training=*> CREATE VIEW info_clie
                    AS SELECT empresa, rep_clie
                         FROM clients;
CREATE VIEW
training=*> SELECT * FROM info_clie;
      empresa      | rep_clie
-------------------+----------
 JCP Inc.          |      103
 First Corp.       |      101
 Acme Mfg.         |      105
...
(21 rows)
```

## Exercici 8

Crea una vista de nom "clie_bill" que conté el número de client, el nom de
empresa i el límit de crèdit de tots els clients assignats al representant de
vendes "Bill Adams".

```
training=*> CREATE VIEW clie_bill
                    AS SELECT num_clie, empresa, limit_credit
                         FROM clients
                        WHERE rep_clie IN (SELECT num_empl
                                             FROM rep_vendes
                                            WHERE nom = 'Bill Adams');
CREATE VIEW
training=*> SELECT * FROM clie_bill;
 num_clie |     empresa     | limit_credit
----------+-----------------+--------------
     2103 | Acme Mfg.       |     50000.00
     2122 | Three-Way Lines |     30000.00
(2 rows)
```

## Exercici 9

Crea una vista de nom comanda_per_rep que conté les següents dades de les
comandes de cada venedor: id_representant_vendes, quantitat_pedidos,
import_total, import_minim, import_maxim, import_promig.

```
training=*> CREATE VIEW comanda_per_rep
                    AS SELECT rep AS id_representant_vendes,
                              COUNT(*) AS quantitat_pedidos,
                              SUM(import) AS import_total,
                              MIN(import) AS import_minim,
                              MAX(import) AS import_maxim,
                              AVG(import) AS import_promig
                         FROM comandes
                         GROUP BY rep;
training=*> SELECT * FROM comanda_per_rep;
 id_representant_vendes | quantitat_pedidos | import_total | import_minim | import_maxim |     import_promig
------------------------+-------------------+--------------+--------------+--------------+------------------------
                    101 |                 3 |     26628.00 |       150.00 |     22500.00 |  8876.0000000000000000
                    108 |                 7 |     58633.00 |       652.00 |     45000.00 |  8376.1428571428571429
                    103 |                 2 |      2700.00 |       600.00 |      2100.00 |  1350.0000000000000000
                    105 |                 5 |     39327.00 |       702.00 |     27500.00 |  7865.4000000000000000
                    107 |                 3 |     34432.00 |       652.00 |     31350.00 | 11477.3333333333333333
                    102 |                 4 |     22776.00 |      1896.00 |     15000.00 |  5694.0000000000000000
                    109 |                 2 |      7105.00 |      1480.00 |      5625.00 |  3552.5000000000000000
                    106 |                 2 |     32958.00 |      1458.00 |     31500.00 |     16479.000000000000
                    110 |                 2 |     23132.00 |       632.00 |     22500.00 | 11566.0000000000000000
(9 rows)
```

## Exercici 10

De la vista anterior volem una nova vista per mostrar el nom del representant
de vendes, números de comandes, import total de les comandes i el promig de les
comandes per a cada venedor. S'han d'ordenar per tal que primer es mostrin els
que tenen major import total.

```
training=*> CREATE VIEW top_rep
                    AS SELECT nom, quantitat_pedidos, import_total,
                              import_promig
                         FROM comanda_per_rep
                         JOIN rep_vendes ON id_representant_vendes =
                              num_empl
                         ORDER BY import_maxim
                         DESC;
CREATE VIEW
training=*> SELECT * FROM top_rep;
      nom      | quantitat_pedidos | import_total |     import_promig
---------------+-------------------+--------------+------------------------
 Larry Fitch   |                 7 |     58633.00 |  8376.1428571428571429
 Sam Clark     |                 2 |     32958.00 |     16479.000000000000
 Nancy Angelli |                 3 |     34432.00 | 11477.3333333333333333
 Bill Adams    |                 5 |     39327.00 |  7865.4000000000000000
 Dan Roberts   |                 3 |     26628.00 |  8876.0000000000000000
 Tom Snyder    |                 2 |     23132.00 | 11566.0000000000000000
 Sue Smith     |                 4 |     22776.00 |  5694.0000000000000000
 Mary Jones    |                 2 |      7105.00 |  3552.5000000000000000
 Paul Cruz     |                 2 |      2700.00 |  1350.0000000000000000
(9 rows)
```

## Exercici 11

Crear una vista de nom "info_comanda" amb les dades de les comandes però amb
els noms del client i venedor en lloc dels seus identificadors.

```
training=*> CREATE VIEW info_comanda
                    AS SELECT num_comanda, data, clie.empresa AS nom_client,
                              r.nom AS nom_rep, fabricant, producte,
                              quantitat, import
                         FROM comandes com
                         JOIN clients clie
                           ON com.clie = clie.num_clie
                         JOIN rep_vendes r
                           ON r.num_empl = com.rep;
CREATE VIEW
training=*> SELECT * FROM info_comanda ;
 num_comanda |    data    |    nom_client     |    nom_rep    | fabricant | producte | quantitat |  import
-------------+------------+-------------------+---------------+-----------+----------+-----------+----------
      112961 | 1989-12-17 | J.P. Sinclair     | Sam Clark     | rei       | 2a44l    |         7 | 31500.00
      113012 | 1990-01-11 | JCP Inc.          | Bill Adams    | aci       | 41003    |        35 |  3745.00
      112989 | 1990-01-03 | Jones Mfg.        | Sam Clark     | fea       | 114      |         6 |  1458.00

...
(30 rows)
```

## Exercici 12

Crear una vista anomenada "clie_rep" que mostri l'import total de les comandes
que ha fet cada client a cada representant de vendes. Cal mostrar el nom de
l'empresa i el nom del representant de vendes.

```
training=*> CREATE VIEW clie_rep
                    AS SELECT nom_client, nom_rep, SUM(import)
                        FROM info_comanda
                        GROUP BY nom_client, nom_rep;
CREATE VIEW
training=*> SELECT * FROM clie_rep;
    nom_client     |    nom_rep    |   sum
-------------------+---------------+----------
 Holm & Landis     | Dan Roberts   |   150.00
 Ace International | Tom Snyder    | 23132.00
 JCP Inc.          | Paul Cruz     |  2700.00
 First Corp.       | Dan Roberts   |  3978.00
 JCP Inc.          | Bill Adams    |  3745.00
 Acme Mfg.         | Bill Adams    | 35582.00
 Chen Associates   | Nancy Angelli | 31350.00
 Fred Lewis Corp.  | Sue Smith     |  4026.00
 Midwest Systems   | Larry Fitch   |  3608.00
 Holm & Landis     | Mary Jones    |  7105.00
 Peter Brothers    | Nancy Angelli |  3082.00
 Ian & Schmidt     | Dan Roberts   | 22500.00
 J.P. Sinclair     | Sam Clark     | 31500.00
 Orion Corp        | Sue Smith     | 15000.00
 Jones Mfg.        | Sam Clark     |  1458.00
 Orion Corp        | Larry Fitch   |  7100.00
 Rico Enterprises  | Sue Smith     |  3750.00
 Zetacorp          | Larry Fitch   | 47925.00
(18 rows)
```

## Exercici 13

Crear una vista temporal per substituir la taula "comandes" que mostri les
comandes amb import més gran a 20000 i ordenades per import de forma
descendent.

```
training=*> CREATE LOCAL TEMPORARY VIEW comandes_v2
                                    AS SELECT *
                                         FROM comandes
                                        WHERE import > 20000
                                        ORDER BY import DESC;
CREATE VIEW
training=*# SELECT * FROM comandes_v2;
 num_comanda |    data    | clie | rep | fabricant | producte | quantitat |  import  
-------------+------------+------+-----+-----------+----------+-----------+----------
      113045 | 1990-02-02 | 2112 | 108 | rei       | 2a44r    |        10 | 45000.00
      112961 | 1989-12-17 | 2117 | 106 | rei       | 2a44l    |         7 | 31500.00
      113069 | 1990-03-02 | 2109 | 107 | imm       | 775c     |        22 | 31350.00
      112987 | 1989-12-31 | 2103 | 105 | aci       | 4100y    |        11 | 27500.00
      110036 | 1990-01-30 | 2107 | 110 | aci       | 4100z    |         9 | 22500.00
      113042 | 1990-02-02 | 2113 | 101 | rei       | 2a44r    |         5 | 22500.00
(6 rows)
```

## Exercici 14

Crea una vista anomenada "top_clie" que mostri el nom de l'empresa client i el
total dels imports de les comandes del client. S'han d'ordenar per tal que
primer es mostrin els que tenen major import total.

```
training=*> CREATE VIEW top_clie
                     AS SELECT nom_client, SUM(import)
                          FROM info_comanda
                        GROUP BY nom_client
                        ORDER BY SUM(import)
                        DESC;
CREATE VIEW
training=*> SELECT * FROM top_clie;
    nom_client     |   sum
-------------------+----------
 Zetacorp          | 47925.00
 Acme Mfg.         | 35582.00
 J.P. Sinclair     | 31500.00
 Chen Associates   | 31350.00
 Ace International | 23132.00
 Ian & Schmidt     | 22500.00
 Orion Corp        | 22100.00
 Holm & Landis     |  7255.00
 JCP Inc.          |  6445.00
 Fred Lewis Corp.  |  4026.00
 First Corp.       |  3978.00
 Rico Enterprises  |  3750.00
 Midwest Systems   |  3608.00
 Peter Brothers    |  3082.00
 Jones Mfg.        |  1458.00
(15 rows)
```

## Exercici 15

Crea una vista anomenata "top_prod" que mostri les dades de tots els productes
seguit d'un camp anomenat "quant_total" en que es mostri la quantitat de cada
producte que s'ha demanat en totes les comandes. S'ha d'ordenar per tal que
primer es mostrin els productes que tenen més comandes.

```
training=*> CREATE VIEW top_prod
                    AS SELECT p.*, SUM(quantitat)
                         FROM productes p
                         JOIN comandes c
                           ON (p.id_fabricant, p.id_producte) =
                              (c.fabricant, c.producte)
                        GROUP BY p.id_fabricant, p.id_producte
                        ORDER BY COUNT(*)
                        DESC;
CREATE VIEW
training=*> SELECT * FROM top_prod;
 id_fabricant | id_producte |     descripcio     |  preu   | estoc | sum 
--------------+-------------+--------------------+---------+-------+-----
 aci          | 41004       | Article Tipus 4    |  117.00 |   139 |  68
 qsa          | xk47        | Reductor           |  355.00 |    38 |  28
 rei          | 2a45c       | V Stago Trinquet   |   79.00 |   210 |  32
 aci          | 4100x       | Peu de rei         |   25.00 |    37 |  30
 aci          | 4100z       | Muntador           | 2500.00 |    28 |  15
 bic          | 41003       | Manovella          |  652.00 |     3 |   2
 fea          | 114         | Bancada Motor      |  243.00 |    15 |  16
 imm          | 779c        | Riosta 2-Tm        | 1875.00 |     9 |   5
 rei          | 2a44r       | Frontissa Dta.     | 4500.00 |    12 |  15
 aci          | 41002       | Article Tipus 2    |   76.00 |   167 |  64
 imm          | 775c        | Riosta 1-Tm        | 1425.00 |     5 |  22
 aci          | 4100y       | Extractor          | 2750.00 |    25 |  11
 rei          | 2a44l       | Frontissa Esq.     | 4500.00 |    12 |   7
 aci          | 41003       | Article Tipus 3    |  107.00 |   207 |  35
 fea          | 112         | Coberta            |  148.00 |   115 |  10
 rei          | 2a44g       | Passador Frontissa |  350.00 |    14 |   6
 imm          | 773c        | Riosta 1/2-Tm      |  975.00 |    28 |   3
(17 rows)
```
    

## Exercici 16

Crea una vista anomenada "responsables" que mostri un llistat de tots els
representants de vendes. En un camp anomenat "empl" ha de mostrar el nom de
cada representant de vendes. També ha de mostrar un camp anomenat "superior"
que mostri el nom del cap del representant de vendes, en cas que el
representant de vendes tingui cap. També ha de mostrar un camp anomenat
"oficina_superior" que mostri el nom del director de l'oficina en que treballa
el representant de vendes, en cas que el representant de vendes tingui
assignada una oficina aquesta tingui un director.

```
training=*> CREATE VIEW responsables
                    AS SELECT empl.nom AS empl, jefe.nom AS jefe,
                              dir_emp.nom AS dir_emp
                         FROM rep_vendes empl
                    LEFT JOIN rep_vendes jefe
                           ON empl.cap = jefe.num_empl
                    LEFT JOIN oficines o
                           ON empl.oficina_rep = o.oficina
                    LEFT JOIN rep_vendes dir_emp
                           ON dir_emp.num_empl = o.director;
CREATE VIEW
training=*> SELECT * FROM responsables;
     empl      |    jefe     |   dir_emp
---------------+-------------+-------------
 Bill Adams    | Bob Smith   | Bill Adams
 Mary Jones    | Sam Clark   | Sam Clark
 Sue Smith     | Larry Fitch | Larry Fitch
 Sam Clark     |             | Sam Clark
 Bob Smith     | Sam Clark   | Bob Smith
 Dan Roberts   | Bob Smith   | Bob Smith
 Tom Snyder    | Dan Roberts |
 Larry Fitch   | Sam Clark   | Larry Fitch
 Paul Cruz     | Bob Smith   | Bob Smith
 Nancy Angelli | Larry Fitch | Larry Fitch
(10 rows)
```
