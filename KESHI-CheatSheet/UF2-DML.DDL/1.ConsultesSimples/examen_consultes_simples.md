# Examen consultes simples

## Consulta 0

```
SELECT cognom1, cognom2, nom
FROM el_meu_NIF_o_NIE;
```

```
┌───────────────────┬─────────────────────┬──────────────────┐
│     cognom1       │       cognom2       │       nom        │
├───────────────────┼─────────────────────┼──────────────────┤
│                   │                     │                  │
└───────────────────┴─────────────────────┴──────────────────┘
```



__La llegibilitat és molt important__
+ Si no fas la consulta 0 tens un 0.
+ Utilitzeu MAJÚSCULES per TOTES les clàusules SQL: SELECT, FROM, WHERE, OR, AND ... 
+ Trenqueu les consultes en diferents línies tal i com fem a classe:

	```
	SELECT ...
	  FROM ...
	 WHERE ...
	```

## Consulta 1

Llisteu la descripció i l'estoc dels productes amb un preu superior a 100 i que compleixin tots els següents supòsits:
+ L'identificador del fabricant comenci per la lletra _q_ o bé l'estoc sigui inferior o igual a 100.
+ L'estoc sigui superior a 100 o bé la descripció del producte acabi amb les lletres _Tm_.

	```
	SELECT descripcio, estoc
	  FROM productes
	 WHERE preu > 100
	   AND ( id_fabricant LIKE 'q%' OR estoc <= 100)
	   AND ( estoc > 100 OR descripcio LIKE '%Tm');
	```
	```
	  descripcio   | estoc 
	---------------+-------
	 Riosta 2-Tm   |     9
	 Reductor      |   203
	 Riosta 1-Tm   |     5
	 Riosta 1/2-Tm |    28
	(4 rows)
	```

## Consulta 2

Llisteu l'identificador, la data i l'import de les comandes anteriors a l'11 de gener de 1990 i que compleixin algun dels següents supòsits:

+ La quantitat de la comanda sigui superior o igual a 20 i l'identificador del fabricant sigui _aci_.
+ L'import de la comanda sigui superior a 10000 i sigui del client número 2114.
	```
	SELECT num_comanda, data, import
	  FROM comandes
	 WHERE data < '1990-01-11'
	   AND ( quantitat >= 20 AND fabricant = 'aci' OR import > 10000 AND clie = 2114 ); 
	```
	
	```
	 num_comanda |    data    |  import  
	-------------+------------+----------
	      112968 | 1989-10-12 |  3978.00
	      112963 | 1989-12-17 |  3276.00
	      112979 | 1989-10-12 | 15000.00
	(3 rows)
	```

## Consulta 3
Llisteu el nom i límit de crèdit dels clients amb un límit de crèdit superior a 20000, ordenats en primera instància pel límit de crèdit, de major crèdit a menor, i en segona instància pel nom de l'empresa en ordre alfabètic.

```
SELECT empresa, limit_credit
  FROM clients
 WHERE limit_credit > 20000
 ORDER BY limit_credit DESC, empresa;
```
```
      empresa      | limit_credit 
-------------------+--------------
 First Corp.       |     65000.00
 Fred Lewis Corp.  |     65000.00
 Jones Mfg.        |     65000.00
 Midwest Systems   |     60000.00
 Holm & Landis     |     55000.00
 Acme Mfg.         |     50000.00
 JCP Inc.          |     50000.00
 Rico Enterprises  |     50000.00
 Zetacorp          |     50000.00
 AAA Investments   |     45000.00
 QMA Assoc.        |     45000.00
 Carter & Sons     |     40000.00
 Peter Brothers    |     40000.00
 Ace International |     35000.00
 J.P. Sinclair     |     35000.00
 Three-Way Lines   |     30000.00
 Chen Associates   |     25000.00
 Solomon Inc.      |     25000.00
(18 rows)
```

## Consulta 4
Llisteu l'identificador i el nom dels representants de vendes que no tinguin un director assignat o que no tinguin una quota assignada. També s'han de llistar aquells que les seves vendes no hagin superat la seva quota.

```
SELECT num_empl, nom
  FROM rep_vendes
 WHERE cap IS NULL
    OR quota IS NULL
    OR vendes <= quota;
```
```
 num_empl |      nom      
----------+---------------
      106 | Sam Clark
      104 | Bob Smith
      110 | Tom Snyder
      107 | Nancy Angelli
(4 rows)
```

## Consulta 5
Llisteu l'identificador i la ciutat de les oficines l'objectiu de les quals sigui superior a les vendes i de les que tinguin vendes majors o iguals a 300000 i menors o iguals a 700000. **ATENCIÓ**: NO pots fer servir l'operador _<_ ni _<=_.

```
SELECT oficina, ciutat
  FROM oficines
 WHERE objectiu > vendes
    OR vendes >= 300000 AND 700000 >= vendes;
```	
o també:
```
 WHERE objectiu > vendes
    OR vendes BETWEEN 300000 AND 700000;
```

```
 oficina |  ciutat  
---------+----------
      22 | Denver
      11 | New York
      12 | Chicago
      13 | Atlanta
(4 rows)
```

## Consulta 6
Llisteu els productes amb el seu valor d'estoc, és a dir el preu del producte multiplicat per l'estoc del producte. S'ha de mostrar l'identificador del producte, l'identificador del fabricant i el valor d'estoc com a _valor_.

```
SELECT id_fabricant, id_producte, preu * estoc AS valor
  FROM productes;
```

```
 id_fabricant | id_producte |  valor   
--------------+-------------+----------
 rei          | 2a45c       | 16590.00
 aci          | 4100y       | 68750.00
 qsa          | xk47        | 13490.00
 bic          | 41672       |     0.00
 imm          | 779c        | 16875.00
 aci          | 41003       | 22149.00
 aci          | 41004       | 16263.00
 bic          | 41003       |  1956.00
 imm          | 887p        |  6000.00
 qsa          | xk48        | 27202.00
 rei          | 2a44l       | 54000.00
 fea          | 112         | 17020.00
 imm          | 887h        | 12042.00
 bic          | 41089       | 17550.00
 aci          | 41001       | 15235.00
 imm          | 775c        |  7125.00
 aci          | 4100z       | 70000.00
 qsa          | xk48a       |  4329.00
 aci          | 41002       | 12692.00
 rei          | 2a44r       | 54000.00
 imm          | 773c        | 27300.00
 aci          | 4100x       |   925.00
 fea          | 114         |  3645.00
 imm          | 887x        | 15200.00
 rei          | 2a44g       |  4900.00
(25 rows)
```

## Consulta 7
Llisteu els 2 representants de vendes amb les vendes més baixes. Per a cada representant es mostrarà un camp de nom *nom_vendes* amb la següent frase *NOM ha venut VENDES €*. 

Per exemple: *Tom Snyder ha venut 75985.00 €*.

```
SELECT nom || ' ha venut ' || vendes || ' €' AS nom_vendes
  FROM rep_vendes
 ORDER BY vendes
 FETCH FIRST 2 ROWS ONLY;
```

_ASC_ és opcional aquí.

```
           nom_vendes           
--------------------------------
 Tom Snyder ha venut 75985.00 €
 Bob Smith ha venut 142594.00 €
(2 rows)
```

## Consulta 8
Llisteu les regions de les oficines, només mostrant un cop cada regió.

```
SELECT DISTINCT regio
  FROM oficines;
```
```
 regio 
-------
 Est
 Oest
(2 rows)
```

## Consulta 9
Llisteu totes les dades de les oficines amb un objectiu major a 500000 amb director identificat amb el nombre 104 o 108. **ATENCIÓ**: No pots fer servir la clàusula OR.

```
SELECT * 
  FROM oficines
 WHERE objectiu > 500000 AND director IN (104,108);
```
```
 oficina |   ciutat    | regio | director | objectiu  |  vendes   
---------+-------------+-------+----------+-----------+-----------
      12 | Chicago     | Est   |      104 | 800000.00 | 735042.00
      21 | Los Angeles | Oest  |      108 | 725000.00 | 835915.00
(2 rows)
```

## Consulta 10

Llisteu l'identificador i venedor assignat dels clients que tinguin un límit de crèdit inferior a 25000 i dels que hagin fet una comanda superior a 20000.

```
(SELECT num_clie, rep_clie
  FROM clients
 WHERE limit_credit < 25000)
 
 UNION

(SELECT DISTINCT clie, rep
  FROM comandes
 WHERE import > 20000);
```

```
 num_clie | rep_clie 
----------+----------
     2115 |      101
     2113 |      104
     2114 |      102
     2113 |      101
     2107 |      110
     2103 |      105
     2112 |      108
     2117 |      106
     2109 |      107
(9 rows)
```

