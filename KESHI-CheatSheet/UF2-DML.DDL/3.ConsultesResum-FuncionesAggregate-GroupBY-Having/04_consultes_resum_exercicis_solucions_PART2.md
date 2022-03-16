# Consultes resum

## Exercici 20

Quina és l'import promig de les comandes de cada venedor?

```
  SELECT rep, ROUND(AVG(import),2) AS promig_comandes
    FROM comandes
GROUP BY rep
ORDER BY rep;
```
```
 rep | promig_comandes 
-----+-----------------
 101 |         8876.00
 102 |         5694.00
 103 |         1350.00
 105 |         7865.40
 106 |        16479.00
 107 |        11477.33
 108 |         8376.14
 109 |         3552.50
 110 |        11566.00
     |        18000.00 <- comanda afegida extra (la del vi¹)
(10 rows)
```

Però si volguéssim els noms necessitaríem un JOIN:

```
  SELECT nom, ROUND(AVG(import),2) AS promig_comandes
    FROM comandes
         JOIN rep_vendes
         ON comandes.rep = rep_vendes.num_empl
GROUP BY nom
ORDER BY promig_comandes;
```

```
      nom      | promig_comandes 
---------------+-----------------
 Larry Fitch   |         8376.14
 Sue Smith     |         5694.00
 Tom Snyder    |        11566.00
 Nancy Angelli |        11477.33
 Mary Jones    |         3552.50
 Bill Adams    |         7865.40
 Dan Roberts   |         8876.00
 Sam Clark     |        16479.00
 Paul Cruz     |         1350.00
(9 rows)
```

El problema és que podria haver-hi comandes amb venedors NULL, el grup dels venedors NULL i no sortirien aqui.

La solució passa per fer un LEFT JOIN: 

```
  SELECT nom, ROUND(AVG(import),2) AS promig_comandes
    FROM comandes
         LEFT JOIN rep_vendes
         ON comandes.rep = rep_vendes.num_empl
GROUP BY nom
ORDER BY promig_comandes;
```

## Exercici 21

Quin és el rang (màxim i mínim) de quotes dels venedors per cada oficina?

```
  SELECT oficina_rep, MAX(quota) AS max_quota, MIN(quota) AS MIN_quota
    FROM rep_vendes
   WHERE oficina_rep IS NOT NULL
GROUP BY oficina_rep
ORDER BY oficina_rep;
```
```
 oficina_rep | max_quota | min_quota 
-------------+-----------+-----------
          11 | 300000.00 | 275000.00
          12 | 300000.00 | 200000.00
          13 | 350000.00 | 350000.00
          21 | 350000.00 | 350000.00
          22 | 300000.00 | 300000.00
(5 rows)
```

## Exercici 22

Quants venedors estan asignats a cada oficina?

```
  SELECT oficina_rep, count(num_empl)
    FROM rep_vendes
GROUP BY oficina_rep
ORDER BY oficina_rep;
```
```
 oficina_rep | count 
-------------+-------
             |     1
          22 |     1
          11 |     2
          21 |     2
          13 |     1
          12 |     3
(6 rows)
```

Fixem-nos que també ens compten aquells camps nuls. En principi això pot ser
interessant, ja que també ens informa de quants vendors no tenen oficina
assignada.

Però si se'ns digués explícitament que només volem l'informació de les oficines
assignades, llavors la consulta seria:

```
  SELECT oficina_rep, count(num_empl)
    FROM rep_vendes
   WHERE oficina_rep IS NOT NULL        
GROUP BY oficina_rep;
```

## Exercici 23

Per cada venedor calcular quants clients diferents ha atès ( atès = atendre una comanda)?

```
  SELECT rep, COUNT(DISTINCT clie)
    FROM comandes
GROUP BY rep
ORDER BY rep;
```
```
 rep | count 
-----+-------
 101 |     3
 102 |     3
 103 |     1
 105 |     2
 106 |     2
 107 |     2
 108 |     3
 109 |     1
 110 |     1
     |     1
(10 rows)
```

## Exercici 24

Calcula el total dels imports de les comandes fetes per cada client a cada vendedor.

```
SELECT clie, rep, SUM(import) AS total_import
  FROM comandes
 GROUP BY clie, rep;
```

```
 clie | rep | total_import 
------+-----+--------------
 2113 | 101 |     22500.00
 2107 | 110 |     23132.00
 2103 | 105 |     35582.00
 2120 | 102 |      3750.00
 2106 | 102 |      4026.00
 2112 | 108 |     47925.00
 2117 | 106 |     31500.00
 2118 | 108 |      3608.00
 2108 | 101 |       150.00
 2111 | 105 |      3745.00
 2114 | 108 |      7100.00
 2102 | 101 |      3978.00
 2111 | 103 |      2700.00
 2109 | 107 |     31350.00
 2114 | 102 |     15000.00
 2101 | 106 |      1458.00
 2124 | 107 |      3082.00
 2108 | 109 |      7105.00
(18 rows)
```

Tot i que a la taula comandes ara mateix no hi ha cap comanda amb el camp rep
NULL ho podria haver en un futur ja que no tenim cap restricció que ho
impedeixi. Si no volem que surtin aquestes comandes amb el camp rep NULL, com
sempre:

```
SELECT clie, rep, SUM(import) AS total_import
  FROM comandes
 WHERE rep IS NOT NULL
 GROUP BY clie, rep;
```

## Exercici 25

El mateix que a la qüestió anterior, però ordenat per client i dintre de client per venedor.

```
SELECT clie, rep, SUM(import) AS total_import
  FROM comandes
 GROUP BY clie, rep
 ORDER BY clie, rep;
``` 
```
 clie | rep | total_import 
------+-----+--------------
 2101 | 106 |      1458.00
 2102 | 101 |      3978.00
 2103 | 105 |     35582.00
 2106 | 102 |      4026.00
 2107 | 110 |     23132.00
 2108 | 101 |       150.00
 2108 | 109 |      7105.00
 2109 | 107 |     31350.00
 2111 | 103 |      2700.00
 2111 | 105 |      3745.00
 2112 | 108 |     47925.00
 2113 | 101 |     22500.00
 2114 | 102 |     15000.00
 2114 | 108 |      7100.00
 2117 | 106 |     31500.00
 2118 | 108 |      3608.00
 2120 | 102 |      3750.00
 2124 | 107 |      3082.00
(18 rows)
```

## Exercici 26

Calcula les comandes totals per a cada venedor.


Si el que ens estan preguntant és el número total de comandes que ha fet cada
venedor:

```
  SELECT rep, COUNT(*)
    FROM comandes
   WHERE rep IS NOT NULL
GROUP BY rep;
```
```
 rep | count 
-----+-------
 101 |     3
 108 |     7
 103 |     2
 105 |     5
 107 |     3
 102 |     4
 109 |     2
 106 |     2
 110 |     2
(9 rows)
```

Si ens demanen pel total de l'import de les comandes de cada venedor:


```
  SELECT rep, SUM(import)
    FROM comandes
   WHERE rep IS NOT NULL
GROUP BY rep;
```

```
 rep |   sum    
-----+----------
 101 | 26628.00
 108 | 58633.00
 103 |  2700.00
 105 | 39327.00
 107 | 34432.00
 102 | 22776.00
 109 |  7105.00
 106 | 32958.00
 110 | 23132.00
(9 rows)
```

Si volem que surti el NULL eliminem la clàusula WHERE.


## Exercici 27

Quin és l'import promig de les comandes per cada venedor, les comandes dels
quals sumen més de 30000?

```
  SELECT rep, round(AVG(import),2) AS "import promig"
    FROM comandes 
GROUP BY rep
  HAVING SUM(import) > 30000;
```
```
 rep | import promig 
-----+---------------
 108 |       8376.14
 105 |       7865.40
 107 |      11477.33
 106 |      16479.00
(4 rows)
```

## Exercici 28

Per cada oficina amb dos o més empleats, calcular la quota total i les vendes
totals per a tots els venedors que treballen a la oficina (volem mostrar la
ciutat de l'oficina a la consulta)

```
  SELECT ciutat, oficina_rep, SUM(quota) AS "suma quotes", SUM(rep_vendes.vendes) AS "suma de vendes"
    FROM rep_vendes
         JOIN oficines
         ON rep_vendes.oficina_rep = oficines.oficina
GROUP BY oficina_rep, ciutat
  HAVING COUNT(*) >= 2;
```

```
   ciutat    | oficina_rep | suma quotes | suma de vendes 
-------------+-------------+-------------+----------------
 Los Angeles |          21 |   700000.00 |      835915.00
 Chicago     |          12 |   775000.00 |      735042.00
 New York    |          11 |   575000.00 |      692637.00
(3 rows)
```

Si tenim la garantia de que el camp ciutat serà sempre únic, podríem fer `GROUP
BY ciutat` sempre que no necessitem mostrar a la selecció de columnes el número
d'oficina.


## Exercici 29

Mostra el preu, l'estoc i la quantitat total de les comandes de cada producte
per als quals la quantitat total demanada està per sobre del 75% de l'estoc.

ALERTA amb el tema de que totes les columnes que surten al SELECT han de sortir al GROUP BY. No és cert, si són columnes que tenen el mateix valor al fer el GROUP BY no cal.

```
SELECT id_fabricant, id_producte, preu, estoc, SUM(quantitat) AS suma_quantitat
  FROM comandes
       JOIN productes
       ON fabricant = id_fabricant
         AND producte = id_producte
 GROUP BY id_fabricant, id_producte
HAVING SUM(quantitat) > 75 * estoc / 100;
```

```
 id_fabricant | id_producte |  preu   | estoc | suma_quantitat 
--------------+-------------+---------+-------+----------------
 aci          | 4100x       |   25.00 |    37 |             30
 fea          | 114         |  243.00 |    15 |             16
 imm          | 775c        | 1425.00 |     5 |             22
 rei          | 2a44r       | 4500.00 |    12 |             15
(4 rows)
```

Aquesta possibilitat, no posar columnes que depenen funcionalment de la que
surt al group by, és una feature.

Què vol dir dependència funcional o funcionalment dependent?

Direm que _edat_ és **funcionalment dependent** de _num_empl_ perquè en el
moment que ens diguin quin és el valor de _num_empl_ automàticament sabem quin
és el valor de _edat_ 


Les preguntes serien

+ És _preu_ funcionalment dependent de *id_fabricant* i *id_producte* ?
+ I estoc?
+ I desripció?
+ I quantitat?



Executem aquesta instrucció:

```
SELECT *                       
  FROM comandes
       JOIN productes
       ON fabricant = id_fabricant
         AND producte = id_producte
 ORDER BY id_fabricant, id_producte; 
```

Mirem com son els camps en funció del _producte_ (recordem que un producte
queda determinat per 2 camps)

Veiem per tant que les files que tenen la mateixa "clau primària" per al producte tenen els mateixos valors en els camps que són dependents funcionalment (preu, descripció, estoc). 



## Exercici 30

Es desitja un llistat d'identificadors de fabricants de productes. Només volem tenir en compte els productes de preu superior a 54. Només volem que apareguin els fabricants amb un nombre total d'unitats superior a 300.

Anem a pams (Slow motion):
```
SELECT id_fabricant, estoc			SELECT id_fabricant, SUM(estoc) AS suma_estoc
  FROM productes 				  FROM productes
 ORDER BY id_fabricant;				 GROUP BY id_fabricant
					 	 ORDER BY id_fabricant;
```

Ens mostren respectivament:				

```
 id_fabricant | estoc				 id_fabricant | suma_estoc	
--------------+-------				--------------+------------
 aci          |    37					      | 
 aci          |   207					      |		
 aci          |   139					      |
 aci          |    25					      |
 aci          |   277					      |
 aci          |    28		 suma			      |
 aci          |   167		=====>		 aci          |        880
 
 bic          |     0					      |
 bic          |    78		 suma			      |
 bic          |     3		=====>		 bic          |         81       

 fea          |    15		 suma			      |         
 fea          |   115		=====>		 fea          |        130        

 imm          |    28            
 imm          |    24           
 imm          |   223           
 imm          |    32           
 imm          |     9  		 suma               
 imm          |     5   	=====>		 imm          |        321

 qsa          |    37
 qsa          |    38    	 suma
 qsa          |   203   	=====>		 qsa          |        278 

 rei          |    14
 rei          |    12
 rei          |    12    	 suma 
 rei          |   210   	=====>		 rei          |        248
(25 rows)
```

Si ara ens diuen que només volem els productes de preu superior a 54, les 2 consultes serien:


```
SELECT id_fabricant, estoc			SELECT id_fabricant, SUM(estoc) AS suma_estoc
  FROM productes				  FROM productes
 ORDER BY id_fabricant;				 WHERE preu > 54
						 GROUP BY id_fabricant
						 ORDER BY id_fabricant;
```

```
 id_fabricant | estoc |  preu                              id_fabricant | suma_estoc
--------------+-------+---------                          --------------+------------
 aci          | 🚫 37 |   25.00 <-                                      |
 aci          |   207 |  107.00                                         |
 aci          |   139 |  117.00                                         |
 aci          |    25 | 2750.00                                         |
 aci          |   277 |   55.00                                         |
 aci          |    28 | 2500.00            suma                         |
 aci          |   167 |   76.00           =====>           aci          |        843
                                
 bic          |     0 |  180.00                                         |
 bic          |    78 |  225.00            suma                         |
 bic          |     3 |  652.00           =====>           bic          |         81
                                
 fea          |    15 |  243.00            suma                         |
 fea          |   115 |  148.00           =====>           fea          |        130
                                
 imm          |    28 |  975.00                                         | 
 imm          |    24 |  250.00                                         | 
 imm          |🚫 223 |   54.00 <-                                      | 
 imm          |    32 |  475.00                                         | 
 imm          |     9 | 1875.00            suma                         | 
 imm          |     5 | 1425.00           =====>           imm          |         98
                                
 qsa          |    37 |  117.00                                         | 
 qsa          |    38 |  355.00            suma                         | 
 qsa          |   203 |  134.00           =====>           qsa          |        278
                                
 rei          |    14 |  350.00                                         | 	
 rei          |    12 | 4500.00                                         | 
 rei          |    12 | 4500.00            suma                         | 
 rei          |   210 |   79.00           =====>           rei          |        248
(25 rows)
```


Ens quedem amb la taula resultant: 


```
 id_fabricant | suma_estoc 
--------------+------------
 aci          |        843
 bic          |         81
 fea          |        130
 imm          |         98
 qsa          |        278
 rei          |        248
```


Si només volem aquelles que tinguin una suma d'estoc superior a 300 

```
SELECT id_fabricant, SUM(estoc) AS suma_estoc
  FROM productes
 WHERE preu > 54
 GROUP BY id_fabricant
HAVING SUM(estoc) > 300;
```

```
 id_fabricant | suma_estoc 
--------------+------------
 aci          |        843
(1 row)
```




## Exercici 31

Es desitja un llistat dels productes amb les seves descripcions, ordenat per la
suma total d'imports facturats (comandes) de cada producte de l'any 1989.

```
SELECT id_fabricant, id_producte, descripcio, SUM(import)
  FROM productes
       JOIN comandes
       ON id_fabricant = fabricant
         AND id_producte = producte
 WHERE date_part('year', data) = 1989
 GROUP BY id_fabricant, id_producte
 ORDER BY SUM(import);
```
```
 id_fabricant | id_producte |     descripcio     |   sum    
--------------+-------------+--------------------+----------
 aci          | 41002       | Article Tipus 2    |   760.00
 rei          | 2a45c       | V Stago Trinquet   |  1896.00
 rei          | 2a44g       | Passador Frontissa |  2100.00
 aci          | 41004       | Article Tipus 4    |  7956.00
 aci          | 4100z       | Muntador           | 15000.00
 aci          | 4100y       | Extractor          | 27500.00
 rei          | 2a44l       | Frontissa Esq.     | 31500.00
(7 rows)
```


## Exercici 32

Per a cada director (de personal, no d'oficina) excepte per al gerent (el venedor que no té director), vull saber el total de vendes dels seus subordinats. Mostreu codi i nom dels directors.


Podem primer mostrar tots els camps sense agrupar, amb el JOIN:

```
SELECT *                                         
  FROM rep_vendes AS venedors
       JOIN rep_vendes AS caps
       ON venedors.cap = caps.num_empl
 ORDER BY caps.num_empl;
```

Executeu la consulta anterior i fixem-nos en els camps en funció del director
del venedor.




Resolem la consulta sense fer l'excepció (la del gerent):

```
SELECT caps.num_empl, caps.nom, SUM(venedors.vendes)
  FROM rep_vendes AS venedors
       JOIN rep_vendes AS caps
       ON venedors.cap = caps.num_empl
 GROUP BY caps.num_empl
 ORDER BY caps.num_empl;
```


Finalment imposem que el cap dels venedors tingui al seu torn cap:

```
SELECT caps.num_empl, caps.nom, SUM(venedors.vendes)
  FROM rep_vendes AS venedors
       JOIN rep_vendes AS caps
       ON venedors.cap = caps.num_empl
 WHERE caps.cap IS NOT NULL
 GROUP BY caps.num_empl
 ORDER BY caps.num_empl;
```


## Exercici 33

Quins són els 5 productes que han estat venuts a més clients diferents? Mostreu
el número de clients per cada producte. A igualtat de nombre de clients es
volen ordenats per ordre decreixent d'estoc i, a igualtat d'estoc, per
descripció. Mostreu tots els camps pels quals s'ordena.

```
SELECT fab, producto, descripcion, existencias, COUNT(DISTINCT clie)
FROM pedidos
JOIN productos ON producto = id_producto AND fab = id_fab
GROUP BY id_fab, id_producto, fab, producto
ORDER BY COUNT(DISTINCT clie) DESC, existencias DESC, descripcion
LIMIT 5;
```

```
SELECT id_fabricant, id_producte, estoc, descripcio,  COUNT(DISTINCT clie) AS clients_p_producte
  FROM productes
       JOIN comandes
       ON productes.id_fabricant = fabricant
         AND id_producte = producte
 GROUP BY id_fabricant, id_producte
ORDER BY clients_p_producte DESC, estoc DESC, descripcio
FETCH FIRST 5 ROWS ONLY;
```

```
 id_fabricant | id_producte | estoc |    descripcio    | clients_p_producte 
--------------+-------------+-------+------------------+--------------------
 qsa          | xk47        |    38 | Reductor         |                  3
 rei          | 2a45c       |   210 | V Stago Trinquet |                  2
 aci          | 41002       |   167 | Article Tipus 2  |                  2
 aci          | 41004       |   139 | Article Tipus 4  |                  2
 aci          | 4100x       |    37 | Peu de rei       |                  2
(5 rows)
```

## Exercici 34

Es vol llistar el clients (codi i empresa) tals que no hagin comprat cap tipus
de Frontissa (figura a la descripció) i hagin comprat articles de més d'un
fabricant diferent


Una solució que utilitza una feature no estàndard (descobreix quina és)

```
SELECT num_clie, empresa 
  FROM comandes
       JOIN productes
       ON id_fabricant = fabricant
         AND id_producte = producte
       JOIN clients
       ON clie = num_clie
 WHERE descripcio NOT LIKE 'Frontissa%'
 GROUP BY num_clie
HAVING COUNT( DISTINCT (fabricant, producte)) > 1
ORDER BY num_clie;
```
o

```
SELECT num_clie, empresa
  FROM comandes
       JOIN productes
       ON id_fabricant = fabricant
         AND id_producte = producte
       JOIN clients
       ON clie = num_clie
 WHERE descripcio NOT LIKE 'Frontissa%'
 GROUP BY num_clie
HAVING COUNT( DISTINCT fabricant|| producte)) > 1
ORDER BY num_clie;
```



## Exercici 35

Llisteu les oficines per ordre descendent de nombre total de clients diferents
amb comandes realitzades pels venedors d'aquella oficina, i, a igualtat de
clients, ordenat per ordre ascendent del nom del director de l'oficina. Només
s'ha de mostrar el codi i la ciutat de l'oficina.



Llistem les oficines amb els seus venedors, comandes de les quals s'han
encarregat aquests venedors i clients que han fet aquestes comandes


```
SELECT oficina, ciutat, num_empl, nom, num_comanda, num_clie, empresa
  FROM oficines
       JOIN rep_vendes
       ON oficina = oficina_rep

       JOIN comandes
       ON num_empl = rep

       JOIN clients
       ON clie = num_clie
 ORDER BY ciutat;
```

```
 oficina |   ciutat    | num_empl |      nom      | num_comanda | num_clie |     empresa      
---------+-------------+----------+---------------+-------------+----------+------------------
      13 | Atlanta     |      105 | Bill Adams    |      112983 |     2103 | Acme Mfg.
      13 | Atlanta     |      105 | Bill Adams    |      112963 |     2103 | Acme Mfg.
      13 | Atlanta     |      105 | Bill Adams    |      112987 |     2103 | Acme Mfg.
      13 | Atlanta     |      105 | Bill Adams    |      113027 |     2103 | Acme Mfg.
      13 | Atlanta     |      105 | Bill Adams    |      113012 |     2111 | JCP Inc.
      12 | Chicago     |      101 | Dan Roberts   |      113042 |     2113 | Ian & Schmidt
      12 | Chicago     |      101 | Dan Roberts   |      112968 |     2102 | First Corp.
      12 | Chicago     |      103 | Paul Cruz     |      112975 |     2111 | JCP Inc.
      12 | Chicago     |      101 | Dan Roberts   |      113055 |     2108 | Holm & Landis
      12 | Chicago     |      103 | Paul Cruz     |      113057 |     2111 | JCP Inc.
      22 | Denver      |      107 | Nancy Angelli |      113069 |     2109 | Chen Associates
      22 | Denver      |      107 | Nancy Angelli |      113062 |     2124 | Peter Brothers
      22 | Denver      |      107 | Nancy Angelli |      112997 |     2124 | Peter Brothers
      21 | Los Angeles |      108 | Larry Fitch   |      113051 |     2118 | Midwest Systems
      21 | Los Angeles |      108 | Larry Fitch   |      113007 |     2112 | Zetacorp
      21 | Los Angeles |      108 | Larry Fitch   |      112992 |     2118 | Midwest Systems
      21 | Los Angeles |      108 | Larry Fitch   |      113045 |     2112 | Zetacorp
      21 | Los Angeles |      108 | Larry Fitch   |      113024 |     2114 | Orion Corp
      21 | Los Angeles |      102 | Sue Smith     |      112979 |     2114 | Orion Corp
      21 | Los Angeles |      102 | Sue Smith     |      112993 |     2106 | Fred Lewis Corp.
      21 | Los Angeles |      102 | Sue Smith     |      113065 |     2106 | Fred Lewis Corp.
      21 | Los Angeles |      108 | Larry Fitch   |      113049 |     2118 | Midwest Systems
      21 | Los Angeles |      108 | Larry Fitch   |      113013 |     2118 | Midwest Systems
      21 | Los Angeles |      102 | Sue Smith     |      113048 |     2120 | Rico Enterprises
      11 | New York    |      106 | Sam Clark     |      112961 |     2117 | J.P. Sinclair
      11 | New York    |      109 | Mary Jones    |      113003 |     2108 | Holm & Landis
      11 | New York    |      109 | Mary Jones    |      113058 |     2108 | Holm & Landis
      11 | New York    |      106 | Sam Clark     |      112989 |     2101 | Jones Mfg.
(28 rows)
```

Per a cada oficina comptem el nombre de clients diferents que els han fet comandes 

```
SELECT oficina, ciutat, COUNT(DISTINCT num_clie)
  FROM oficines
       JOIN rep_vendes
       ON oficina = oficina_rep

       JOIN comandes
       ON num_empl = rep

       JOIN clients
       ON clie = num_clie
 GROUP BY oficina;
```

```
 oficina |   ciutat    | count 
---------+-------------+-------
      11 | New York    |     3
      12 | Chicago     |     4
      13 | Atlanta     |     2
      21 | Los Angeles |     5
      22 | Denver      |     2
(5 rows)
```


Ordenem descendentment per aquest últim camp

```
SELECT oficina, ciutat, COUNT(DISTINCT num_clie)
  FROM oficines
       JOIN rep_vendes
       ON oficina = oficina_rep

       JOIN comandes
       ON num_empl = rep

       JOIN clients
       ON clie = num_clie
 GROUP BY oficina
 ORDER BY COUNT(DISTINCT num_clie) DESC;
```

```
 oficina |   ciutat    | count 
---------+-------------+-------
      21 | Los Angeles |     5
      12 | Chicago     |     4
      11 | New York    |     3
      13 | Atlanta     |     2
      22 | Denver      |     2
(5 rows)
```


Afegim el nom dels directors de les oficines, fent un JOIN extra de la taula repventas

```
SELECT oficina, ciutat, COUNT(DISTINCT num_clie), caps.nom
  FROM oficines
       JOIN rep_vendes
       ON oficina = oficina_rep

       JOIN comandes
       ON num_empl = rep

       JOIN clients
       ON clie = num_clie

       JOIN rep_vendes AS caps
       ON rep_vendes.cap = caps.num_empl

 GROUP BY oficina, caps.nom
 ORDER BY COUNT(DISTINCT num_clie) DESC;
```

```
 oficina |   ciutat    | count |     nom     
---------+-------------+-------+-------------
      12 | Chicago     |     4 | Bob Smith
      21 | Los Angeles |     3 | Larry Fitch
      21 | Los Angeles |     3 | Sam Clark
      13 | Atlanta     |     2 | Bob Smith
      22 | Denver      |     2 | Larry Fitch
      11 | New York    |     1 | Sam Clark
(6 rows)
```

Afegim a l'ordenació aquest últim camp (caps.nom)


```
SELECT oficina, ciutat, COUNT(DISTINCT num_clie), caps.nom
  FROM oficines
       JOIN rep_vendes
       ON oficina = oficina_rep

       JOIN comandes
       ON num_empl = rep

       JOIN clients
       ON clie = num_clie

       JOIN rep_vendes AS caps
       ON rep_vendes.cap = caps.num_empl

 GROUP BY oficina, caps.nom
 ORDER BY COUNT(DISTINCT num_clie) DESC, caps.nom;
```

```
 oficina |   ciutat    | count |     nom     
---------+-------------+-------+-------------
      12 | Chicago     |     4 | Bob Smith
      21 | Los Angeles |     3 | Larry Fitch
      21 | Los Angeles |     3 | Sam Clark
      13 | Atlanta     |     2 | Bob Smith
      22 | Denver      |     2 | Larry Fitch
      11 | New York    |     1 | Sam Clark
(6 rows)
```

Ja ho tindríem però per fer exactament el que diu l'enunciat, eliminem les
dades que no ens demanen:


```
SELECT oficina, ciutat
  FROM oficines
       JOIN rep_vendes
       ON oficina = oficina_rep

       JOIN comandes
       ON num_empl = rep

       JOIN clients
       ON clie = num_clie

       JOIN rep_vendes AS caps
       ON rep_vendes.cap = caps.num_empl

 GROUP BY oficina, caps.nom
 ORDER BY COUNT(DISTINCT num_clie) DESC, caps.nom;
```


```
 oficina |   ciutat    
---------+-------------
      12 | Chicago
      21 | Los Angeles
      21 | Los Angeles
      13 | Atlanta
      22 | Denver
      11 | New York
(6 rows)
```




## Nota¹:

Recordeu que havíem afegit a la taula comandes una comanda de vi amb un venedor
NULL per fer proves:

```
INSERT INTO comandes VALUES ( 88888, '2021-11-11', 2111, NULL, 'vi', 'Bages', 2600, 26000);
```



## LINK molt interessant:

[Do all columns in a SELECT list have to appear in a GROUP BY clause](https://stackoverflow.com/questions/5986127/do-all-columns-in-a-select-list-have-to-appear-in-a-group-by-clause#) 
