# Consultes simples

Escriu la consulta SELECT que mostra el que es demana a cada exercici i la seva
sortida.

## Exercici 1:

Els identificadors de les oficines amb la seva ciutat, els objectius i les
vendes reals.

```
SELECT oficina, ciutat, objectiu, vendes
FROM oficines;
```

```
 oficina |   ciutat    | objectiu  |  vendes   
---------+-------------+-----------+-----------
      22 | Denver      | 300000.00 | 186042.00
      11 | New York    | 575000.00 | 692637.00
      12 | Chicago     | 800000.00 | 735042.00
      13 | Atlanta     | 350000.00 | 367911.00
      21 | Los Angeles | 725000.00 | 835915.00
(5 rows)
```

## Exercici 2:

Els identificadors de les oficines de la regió est amb la seva ciutat, els
objectius i les vendes reals.

```
SELECT oficina, ciutat, objectiu, vendes
FROM oficines
WHERE regio = 'Est';
```

```
 oficina |  ciudad  | objetivo  |  vendes   
---------+----------+-----------+-----------
      11 | New York | 575000.00 | 692637.00
      12 | Chicago  | 800000.00 | 735042.00
      13 | Atlanta  | 350000.00 | 367911.00
(3 rows)
```

## Exercici 3:

Les ciutats en ordre alfabètic de les oficines de la regió est amb els
objectius i les vendes reals.

```
SELECT ciutat, objectiu, vendes
FROM oficines
WHERE regio = 'Est'
ORDER BY ciutat;
```

```
  ciutat  | objectiu  |  vendes   
----------+-----------+-----------
 Atlanta  | 350000.00 | 367911.00
 Chicago  | 800000.00 | 735042.00
 New York | 575000.00 | 692637.00
(3 rows)
```

## Exercici 4:

Les ciutats, els objectius i les vendes d'aquelles oficines que les seves
vendes superin el seu objectiu.

```
SELECT ciutat, objectiu, vendes
FROM oficines 
WHERE vendes > objectiu;
```

```
   ciutat    | objectiu  |  vendes   
-------------+-----------+-----------
 New York    | 575000.00 | 692637.00
 Atlanta     | 350000.00 | 367911.00
 Los Angeles | 725000.00 | 835915.00
(3 rows)
```

## Exercici 5:

Nom, quota i vendes de l'empleat representant de vendes número 107.

```
SELECT nom, quota, vendes
FROM rep_vendes
WHERE num_empl=107;
```

```
      nom      |   quota   |  vendes   
---------------+-----------+-----------
 Nancy Angelli | 300000.00 | 186042.00
(1 row)
```

## Exercici 6:

Nom i data de contracte dels representants de vendes amb vendes superiors a
300000.

```
SELECT nom, data_contracte
FROM rep_vendes
WHERE vendes > 300000;
```

```
   nom    |  data_contracte  
-------------+------------
 Bill Adams  | 1988-02-12
 Mary Jones  | 1989-10-12
 Sue Smith   | 1986-12-10
 Dan Roberts | 1986-10-20
 Larry Fitch | 1989-10-12
(5 rows)
```

## Exercici 7:

Nom dels representants de vendes dirigits per l'empleat numero 104 Bob Smith.

```
SELECT nom
FROM rep_vendes
WHERE cap = 104;
```

```
     nom     
-------------
 Bill Adams
 Dan Roberts
 Paul Cruz
(3 rows)
```

## Exercici 8:

Nom dels venedors i data de contracte d'aquells que han estat contractats abans
del 1988.

```
SELECT nom, data_contracte
FROM rep_vendes
WHERE data_contracte < '1988-01-01';
```

```
   nom    |  data_contracte  
-------------+------------
 Sue Smith   | 1986-12-10
 Bob Smith   | 1987-05-19
 Dan Roberts | 1986-10-20
 Paul Cruz   | 1987-03-01
(4 rows)
```

Quan estudiem funcions veurem altres solucions: 

funció de SQL estàndard: `extract`

```
SELECT nom, data_contracte
FROM rep_vendes
WHERE extract(year from data_contracte) < 1988;
```

funció de PostgreSQL: `date_part`

```
SELECT nom, data_contracte 
FROM rep_vendes 
WHERE date_part('year', data_contracte) < 1988;
```

## Exercici 9:

Identificador de les oficines i ciutat d'aquelles oficines que el seu objectiu
és diferent a 800000.

```
SELECT oficina, ciutat
FROM oficines
WHERE objectiu <> 800000;
```

```
 oficina |   ciudad    
---------+-------------
      22 | Denver
      11 | New York
      13 | Atlanta
      21 | Los Angeles
(4 rows)
```

## Exercici 10:

Nom de l'empresa i limit de crèdit del client número 2107.

```
SELECT empresa, limit_credit
FROM clients
WHERE num_clie = 2107;
```

```
      empresa      | limit_credit 
-------------------+--------------
 Ace International |     35000.00
(1 row)
```

## Exercici 11:

id_fabricant com a "Identificador del fabricant", id_producte com a "Identificador del producte" i descripcio com a "Descripció" dels productes.

```
SELECT id_fabricant AS "Identificador del fabricant",
id_producte AS "Identificador del producte",
descripcio AS "Descripció"
FROM productes;
```

```
 Identificador del fabricant | Identificador del producte |     Descripció     
-----------------------------+----------------------------+--------------------
 rei                         | 2a45c                      | V Stago Trinquet
 aci                         | 4100y                      | Extractor
 qsa                         | xk47                       | Reductor
 bic                         | 41672                      | Plate
 imm                         | 779c                       | Riosta 2-Tm
 aci                         | 41003                      | Article Tipus 3
 aci                         | 41004                      | Article Tipus 4
 bic                         | 41003                      | Manovella
 imm                         | 887p                       | Pern Riosta
 qsa                         | xk48                       | Reductor
 rei                         | 2a44l                      | Frontissa Esq.
 fea                         | 112                        | Coberta
 imm                         | 887h                       | Suport Riosta
 bic                         | 41089                      | Retn
 aci                         | 41001                      | Article Tipus 1
 imm                         | 775c                       | Riosta 1-Tm
 aci                         | 4100z                      | Muntador
 qsa                         | xk48a                      | Reductor
 aci                         | 41002                      | Article Tipus 2
 rei                         | 2a44r                      | Frontissa Dta.
 imm                         | 773c                       | Riosta 1/2-Tm
 aci                         | 4100x                      | Peu de rei
 fea                         | 114                        | Bancada Motor
 imm                         | 887x                       | Retenidor Riosta
 rei                         | 2a44g                      | Passador Frontissa
```

## Exercici 12:

Identificador del fabricant, identificador del producte i descripció del producte d'aquells productes que el seu identificador de fabricant acabi amb la lletra i.

```
SELECT id_fabricant, id_producte, descripcio
FROM productes
WHERE id_fabricant LIKE '%i';
```

```
 id_fabricant | id_producte |     descripcio     
--------------+-------------+--------------------
 rei          | 2a45c       | V Stago Trinquet
 aci          | 4100y       | Extractor
 aci          | 41003       | Article Tipus 3
 aci          | 41004       | Article Tipus 4
 rei          | 2a44l       | Frontissa Esq.
 aci          | 41001       | Article Tipus 1
 aci          | 4100z       | Muntador
 aci          | 41002       | Article Tipus 2
 rei          | 2a44r       | Frontissa Dta.
 aci          | 4100x       | Peu de rei
 rei          | 2a44g       | Passador Frontissa
(11 rows)
```

## Exercici 13:

Nom i identificador dels venedors que estan per sota la quota i tenen vendes
inferiors a 300000.

```
SELECT nom, num_empl
FROM rep_vendes
WHERE vendes < quota AND vendes < 300000;
```

```
      nom      | num_empl 
---------------+----------
 Bob Smith     |      104
 Nancy Angelli |      107
(2 rows)
```

## Exercici 14:

Identificador i nom dels venedors que treballen a les oficines 11 o 13.

```
SELECT num_empl, nom
FROM rep_vendes
WHERE oficina_rep IN(11,13);
```

```
 num_empl |   nom   
----------+------------
      105 | Bill Adams
      109 | Mary Jones
      106 | Sam Clark
(3 rows)
```

Una altra possible solució:

```
SELECT num_empl, nom
FROM rep_vendes
WHERE oficina_rep = 11 OR oficina_rep = 13;
```


## Exercici 15:

Identificador, descripció i preu dels productes ordenats del més car al més
barat.

```
SELECT id_producte, descripcio, preu
FROM productes
ORDER BY preu DESC;
```

```
 id_producte |     descripcio     |  preu   
-------------+--------------------+---------
 2a44r       | Frontissa Dta.     | 4500.00
 2a44l       | Frontissa Esq.     | 4500.00
 4100y       | Extractor          | 2750.00
 4100z       | Muntador           | 2500.00
 779c        | Riosta 2-Tm        | 1875.00
 775c        | Riosta 1-Tm        | 1425.00
 773c        | Riosta 1/2-Tm      |  975.00
 41003       | Manovella          |  652.00
 887x        | Retenidor Riosta   |  475.00
 xk47        | Reductor           |  355.00
 2a44g       | Passador Frontissa |  350.00
 887p        | Pern Riosta        |  250.00
 114         | Bancada Motor      |  243.00
 41089       | Retn               |  225.00
 41672       | Plate              |  180.00
 112         | Coberta            |  148.00
 xk48        | Reductor           |  134.00
 xk48a       | Reductor           |  117.00
 41004       | Article Tipus 4    |  117.00
 41003       | Article Tipus 3    |  107.00
 2a45c       | V Stago Trinquet   |   79.00
 41002       | Article Tipus 2    |   76.00
 41001       | Article Tipus 1    |   55.00
 887h        | Suport Riosta      |   54.00
 4100x       | Peu de rei         |   25.00
(25 rows)
```

## Exercici 16:

Identificador i descripció de producte amb el valor_inventari (estoc * preu).

```
SELECT id_producte, descripcio,
estoc * preu as "valor_inventari"
FROM productes;
```

```
 id_producte |     descripcio     | valor_inventari 
-------------+--------------------+-----------------
 2a45c       | V Stago Trinquet   |        16590.00
 4100y       | Extractor          |        68750.00
 xk47        | Reductor           |        13490.00
 41672       | Plate              |            0.00
 779c        | Riosta 2-Tm        |        16875.00
 41003       | Article Tipus 3    |        22149.00
 41004       | Article Tipus 4    |        16263.00
 41003       | Manovella          |         1956.00
 887p        | Pern Riosta        |         6000.00
 xk48        | Reductor           |        27202.00
 2a44l       | Frontissa Esq.     |        54000.00
 112         | Coberta            |        17020.00
 887h        | Suport Riosta      |        12042.00
 41089       | Retn               |        17550.00
 41001       | Article Tipus 1    |        15235.00
 775c        | Riosta 1-Tm        |         7125.00
 4100z       | Muntador           |        70000.00
 xk48a       | Reductor           |         4329.00
 41002       | Article Tipus 2    |        12692.00
 2a44r       | Frontissa Dta.     |        54000.00
 773c        | Riosta 1/2-Tm      |        27300.00
 4100x       | Peu de rei         |          925.00
 114         | Bancada Motor      |         3645.00
 887x        | Retenidor Riosta   |        15200.00
 2a44g       | Passador Frontissa |         4900.00
(25 rows)
```

## Exercici 17:

Vendes de cada oficina en una sola columna i format "<ciutat> té unes vendes de <vendes>", exemple "Denver te unes vendes de 186042.00".

```
SELECT ciutat || ' té unes vendes de ' || vendes AS "Vendes de cada oficina"
FROM  oficines;
```

```
         Vendes de cada oficina          
-----------------------------------------
 Denver té unes vendes de 186042.00
 New York té unes vendes de 692637.00
 Chicago té unes vendes de 735042.00
 Atlanta té unes vendes de 367911.00
 Los Angeles té unes vendes de 835915.00
(5 rows)
```

## Exercici 18:

Codis d'empleats que són directors d'oficines.

```
SELECT DISTINCT director FROM oficines;
```

```
 director 
----------
      108
      104
      105
      106
(4 rows)
```

## Exercici 19:

Identificador i ciutat de les oficines que tinguin ventes per sota el 80% del seu objectiu.

```
SELECT oficina, ciutat
FROM oficines
WHERE  80 * objectiu / 100 > vendes;
```

```
 oficina | ciutat
---------+--------
      22 | Denver
(1 row)
```

Vigileu, qué passa amb: 

```
SELECT oficina, ciutat
FROM oficines
WHERE  80 / 100 * objectiu > vendes;
```

Altres solucions passen per representar algun literal com 80 o 100 amb decimals
perquè s'interpretin com a reals en comptes d'enters (80.0 o 100.0)

## Exercici 20:

Identificador, ciutat i director de les oficines que no siguin dirigides per l'empleat 108.

```
SELECT oficina, ciutat, director
FROM oficines WHERE director <> 108;
```

```
 oficina |  ciutat  | director 
---------+----------+----------
      11 | New York |      106
      12 | Chicago  |      104
      13 | Atlanta  |      105
(3 rows)
```


## Exercici 21:

Identificadors i noms dels venedors amb vendes entre el 80% i el 120% de llur quota.

```
SELECT num_empl,nom
FROM rep_vendes
WHERE vendes > 80 * quota / 100 AND vendes < 120 * quota / 100;
```

El mateix d'una altra manera:

```
SELECT num_empl,nom
FROM rep_vendes
WHERE (vendes/quota) BETWEEN  0.8 AND 1.20;
      -- (vendes/quota) > 0.8
      --AND (vendes/quota) < 1.20;
```

```
 num_empl |   nom    
----------+-------------
      105 | Bill Adams
      106 | Sam Clark
      101 | Dan Roberts
      108 | Larry Fitch
      103 | Paul Cruz
(5 rows)
```

O si volem mostrar una 3a columna amb el percentatge entre 80 i 120:

```
SELECT num_empl, nom, 100 * vendes / quota as percentatge
FROM rep_vendes
WHERE vendes > 80 * quota / 100 AND vendes < 120 * quota / 100;
```

```
 num_empl |     nom     |     percentatge      
----------+-------------+----------------------
      105 | Bill Adams  | 105.1174285714285714
      106 | Sam Clark   | 109.0589090909090909
      101 | Dan Roberts | 101.8910000000000000
      108 | Larry Fitch | 103.3900000000000000
      103 | Paul Cruz   | 104.2818181818181818
(5 rows)
```

I si volem només dos decimals podem fer servir la funció SQL ANSI CAST:

```
SELECT num_empl, nom, cast(100 * vendes / quota as numeric(5,2) ) as percentatge
FROM rep_vendes
WHERE vendes > 80 * quota / 100 AND vendes < 120 * quota / 100;
```

```
 num_empl |     nom     | percentatge 
----------+-------------+-------------
      105 | Bill Adams  |      105.12
      106 | Sam Clark   |      109.06
      101 | Dan Roberts |      101.89
      108 | Larry Fitch |      103.39
      103 | Paul Cruz   |      104.28
(5 rows)
``` 

## Exercici 22:

Identificador, vendes i ciutat de cada oficina ordenades alfabèticament per regió i, dintre de cada regió ordenades per ciutat.

```
SELECT oficina, vendes, ciutat
FROM oficines
ORDER BY regio, ciutat;
```
```
 oficina |  vendes   |   ciutat
---------+-----------+-------------
      13 | 367911.00 | Atlanta
      12 | 735042.00 | Chicago
      11 | 692637.00 | New York
      22 | 186042.00 | Denver
      21 | 835915.00 | Los Angeles
```

## Exercici 23:

Llista d'oficines classificades alfabèticament per regió i, per cada regió, en
ordre descendent de rendiment de vendes (vendes-objectiu).

```
SELECT oficina,ciutat
FROM oficines
ORDER BY regio ASC, (vendes-objectiu) DESC;
```
```
 oficina |   ciudad
---------+-------------
      11 | New York
      13 | Atlanta
      12 | Chicago
      21 | Los Angeles
      22 | Denver
(5 rows)
```

Millor mostrar les regions i les vendes-objectiu per comprovar que és correcte:

```
SELECT oficina,ciutat,regio, vendes - objectiu as diferencia
FROM oficines
ORDER BY regio ASC, (vendes-objectiu) DESC;
```
```
 oficina |   ciutat    | regio | diferencia 
---------+-------------+-------+------------
      11 | New York    | Est   |  117637.00
      13 | Atlanta     | Est   |   17911.00
      12 | Chicago     | Est   |  -64958.00
      21 | Los Angeles | Oest  |  110915.00
      22 | Denver      | Oest  | -113958.00
(5 rows)
```

## Exercici 24:

Codi i nom dels tres venedors que tinguin unes vendes superiors.

Solució fent servir SQL ANSI:

```
SELECT num_empl,nom
FROM rep_vendes
ORDER BY vendes DESC
FETCH FIRST 3 ROWS ONLY;
```

[Solució de PostgreSQL (i MySQL, MAriaDB, SQLite)...](https://en.wikipedia.org/wiki/Select_(SQL)#FETCH_FIRST_clause):

```
SELECT num_empl,nom
FROM rep_vendes
ORDER BY vendes DESC
LIMIT 3;
```
```
  num_empl |   nom   
----------+------------
      102 | Sue Smith
      109 | Mary Jones
      105 | Bill Adams
(3 rows)
```
## Exercici 25:

Nom i data de contracte dels empleats que les seves vendes siguin superiors a 500000.

```
SELECT nom, data_contracte
FROM rep_vendes
WHERE vendes > 500000;
```
```
 nom | data_contracte 
--------+----------
(0 rows)
```

## Exercici 26:

Nom i quota actual dels venedors amb el calcul d'una "nova possible quota" que
serà la quota de cada venedor augmentada un 3 per cent de les seves pròpies
vendes.

```
SELECT nom, quota, quota + cast(3 * vendes / 100 as numeric(8,2)) AS "nova possible quota"
FROM rep_vendes;
```

```
      nom      |   quota   | nova possible quota 
---------------+-----------+---------------------
 Bill Adams    | 350000.00 |           361037.33
 Mary Jones    | 300000.00 |           311781.75
 Sue Smith     | 350000.00 |           364221.50
 Sam Clark     | 275000.00 |           283997.36
 Bob Smith     | 200000.00 |           204277.82
 Dan Roberts   | 300000.00 |           309170.19
 Tom Snyder    |           |                    
 Larry Fitch   | 350000.00 |           360855.95
 Paul Cruz     | 275000.00 |           283603.25
 Nancy Angelli | 300000.00 |           305581.26
(10 rows)
```

## Exercici 27:

Numero i import de les comandes que el seu import oscil·li entre 20000 i 29999.

```
SELECT num_comanda, import
FROM comandes
WHERE import BETWEEN 20000 AND 29999;
```
```
 num_pedido | importe  
------------+----------
     110036 | 22500.00
     112987 | 27500.00
     113042 | 22500.00
(3 rows)
```

## Exercici 28:

Nom, vendes i quota dels venedors, les vendes dels quals no estiguin entre el 80% i el 120% de la seva quota.

```
SELECT nom, vendes, quota
FROM rep_vendes
WHERE vendes > 120 * quota / 100 OR vendes < 80 * quota / 100;
```
o també

```
SELECT nom, vendes, quota
FROM rep_vendes
WHERE vendes NOT BETWEEN (80 * quota / 100) AND (120* quota / 100);
```

```
      nom      |  vendes   |   quota   
---------------+-----------+-----------
 Mary Jones    | 392725.00 | 300000.00
 Sue Smith     | 474050.00 | 350000.00
 Bob Smith     | 142594.00 | 200000.00
 Nancy Angelli | 186042.00 | 300000.00
(4 rows)
```

## Exercici 29:

Nom i límit de crèdit de les empreses, el nom de les quals comencin per Smith.

```
SELECT empresa, limit_credit
FROM clients
WHERE empresa LIKE 'Smith%';
```

```
    empresa     | limit_credit 
----------------+--------------
 Smithson Corp. |     20000.00
(1 row)
```

## Exercici 30:

Identificador i nom dels venedors que no tenen assignada oficina.

```
SELECT num_empl,nom
FROM rep_vendes
WHERE oficina_rep IS NULL;
```
```
 num_empl |    nom     
----------+------------
      110 | Tom Snyder
(1 row)
```


## Exercici 31:

Identificador i nom dels venedors, amb l'identificador de l'oficina, d'aquells venedors que tenen una oficina assignada.

```
SELECT num_empl,nom,oficina_rep
FROM rep_vendes
WHERE oficina_rep IS NOT NULL;
```

```
 num_empl |     nom       | oficina_rep 
----------+---------------+-------------
      105 | Bill Adams    |          13
      109 | Mary Jones    |          11
      102 | Sue Smith     |          21
      106 | Sam Clark     |          11
      104 | Bob Smith     |          12
      101 | Dan Roberts   |          12
      108 | Larry Fitch   |          21
      103 | Paul Cruz     |          12
      107 | Nancy Angelli |          22
(9 rows)
```

## Exercici 32:

Identificador i descripció dels productes del fabricant identificat per _imm_
dels quals hi hagi estoc superior o igual a 200, també del fabricant _bic_
amb estoc superior o igual a 50.

```
SELECT id_fabricant, id_producte, descripcio  FROM productes
WHERE id_fabricant = 'imm' AND existencias >= 200
OR id_fabricant = 'bic' AND existencias >= 50;
```

```
 id_fabricant | id_producte |  descripcio   
--------------+-------------+---------------
 imm          | 887h        | Suport Riosta
 bic          | 41089       | Retn
(2 rows)
```

## Exercici 33:

Identificador i nom dels venedors que treballen a les oficines 11, 12 o 22 i
compleixen algun dels següents supòsits:

+ han estat contractats a partir de juny del 1988 i no tenen cap
+ estan per sobre la quota però tenen vendes de 600000 o menors.

```
SELECT num_empl, nom, oficina_rep, data_contracte, cap, quota, vendes
FROM rep_vendes
WHERE oficina_rep IN(22,11,12)
AND ( data_contracte >= '1988-6-1' AND cap IS NULL 
OR
vendes > quota AND vendes <= 600000);
```

```
 num_empl |     nom     | oficina_rep | data_contracte | cap |   quota   |  vendes   
----------+-------------+-------------+----------------+-----+-----------+-----------
      109 | Mary Jones  |          11 | 1989-10-12     | 106 | 300000.00 | 392725.00
      106 | Sam Clark   |          11 | 1988-06-14     |     | 275000.00 | 299912.00
      101 | Dan Roberts |          12 | 1986-10-20     | 104 | 300000.00 | 305673.00
      103 | Paul Cruz   |          12 | 1987-03-01     | 104 | 275000.00 | 286775.00
(4 rows)
```

## Exercici 34:

Identificador i descripció dels productes amb un preu superior a 1000 i que
siguin del fabricant amb identificador _rei_ o estoc superior a 20.

```
SELECT id_producte, descripcio
FROM productes
WHERE preu > 1000 AND ( id_fabricant = 'rei' OR estoc > 20 );
```

```
 id_producte |   descripcio   
-------------+----------------
 4100y       | Extractor
 2a44l       | Frontissa Esq.
 4100z       | Muntador
 2a44r       | Frontissa Dta.
(4 rows)
```

## Exercici 35:

Identificador del fabricant, identificador del producte i descripció d'aquells
productes amb identificador de fabricant format per una lletra qualsevol, una
lletra 'i' i una altre lletra qualsevol.

```
SELECT id_fabricant, id_producte, descripcio
FROM productes WHERE id_fabricant LIKE '_i_';
```

```
 id_fabricant | id_producte | descripcio 
--------------+-------------+------------
 bic          | 41672       | Plate
 bic          | 41003       | Manovella
 bic          | 41089       | Retn

```

## Exercici 36:

Identificador i descripció dels productes la descripció dels quals comença per
_art_ sense tenir en compte les majúscules i minúscules.

```
SELECT id_producte, descripcio
FROM productes
WHERE descripcio ILIKE 'art%';
```

ILIKE és un operador que es fa servir a PostgreSQL

```
 id_producte |   descripcio   
-------------+-----------------
 41003       | Articulo Tipo 3 
 41004       | Articulo Tipo 4 
 41001       | Articulo Tipo 1 
 41002       | Articulo Tipo 2 
(4 rows)
```

## Exercici 37:

Identificador i nom dels clients que la segona lletra del nom sigui una "a"
minúscula o majuscula.

```
SELECT num_clie, empresa
FROM clients
WHERE empresa ILIKE '_a%';
```

```
 num_clie |     empresa     
----------+-----------------
     2123 | Carter & Sons
     2113 | Ian & Schmidt
     2105 | AAA Investments
(3 rows)
```

## Exercici 38:

Identificador i ciutat de les oficines que compleixen algun dels següents supòsits:
+ És de la regió est amb unes vendes inferiors a 700000.
+ És de la regió oest amb unes vendes inferiors a 600000.

```
SELECT oficina,ciutat
FROM oficines
WHERE regio = 'Est' AND vendes < 700000
OR regio = 'Oest' AND vendes < 600000;
```

```
 oficina |  ciutat  
---------+----------
      22 | Denver
      11 | New York
      13 | Atlanta
(3 rows)
```

## Exercici 39:

Identificador del fabricant i producte, descripció d'aquells productes que compleixen tots els següents supòsits:
+ L'identificador del fabricant és "imm" o el preu és menor a 500.
+ L'estoc és inferior a 5 o el producte te l'identificador _41003_.  

```
SELECT id_fabricant, id_producte, descripcio
FROM productes
WHERE (id_fabricant = 'imm' OR preu < 500)
AND (estoc < 5 OR id_producte = '41003');
```

```
 id_fabricant | id_producte |   descripcio    
--------------+-------------+-----------------
 bic          | 41672       | Plate
 aci          | 41003       | Article Tipus 3
(2 rows)
```

## Exercici 40:

Identificador de les comandes del fabricant, l'identificador del qual és _rei_
amb una quantitat superior o igual a 10 o amb un import superior o igual a
10000.

```
SELECT num_comanda
FROM comandes
WHERE fabricant = 'rei' AND (quantitat >= 10 OR import >= 10000);
```

```
 num_comanda 
-------------
      112961
      113045
      112993
      113042
(4 rows)

```
## Exercici 41:

Data de les comandes amb una quantitat superior a 20 i un import superior a
1000 dels clients 2102, 2106 i 2109.

```
SELECT data
FROM comandes
WHERE quantitat > 20 AND import > 1000 AND clie IN(2102,2106,2109);
```
```
    data    
------------
 1989-10-12
 1990-03-02
 1989-01-04
(3 rows)
```
## Exercici 42:

Identificador dels clients el nom dels quals no conté ' Corp.' o ' Inc.' amb
crèdit major a 30000.

```
SELECT num_clie
FROM clients
WHERE empresa NOT LIKE '% Corp.' AND empresa NOT LIKE '% Inc.' AND limit_credit > 50000;
```
```
 num_clie 
----------
     2101
     2108
     2118
(3 rows)
```

## Exercici 43:

Identificador dels representants de vendes majors de 40 anys amb vendes
inferiors a 400000.

```
SELECT num_empl
FROM rep_vendes
WHERE edat > 40 AND vendes < 400000;
```

```
num_empl
----------
      106
      101
      110
      108
      107
(5 rows)
```

## Exercici 44:

Identificador dels representants de vendes menors de 35 anys amb vendes
superiors a 350000.

```
SELECT num_empl
FROM rep_vendes
WHERE edat < 35 AND vendes > 350000;
```

```
num_empl
----------
      109
(1 row)
```
