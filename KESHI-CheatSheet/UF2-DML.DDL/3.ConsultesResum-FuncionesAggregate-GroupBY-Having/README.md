# CHEATSHEET KESHI [04]

# Funciones de grupo - Aggregate 

* TIPOS FUNCIONES

```sql
SELECT AVG(sal), MAX(sal), MIN(sal), SUM(sal) FROM emp WHERE Lower(job) = 'salesman';
```

* RETORNA EL NÚMERO DE FILAS DE UNA TABLA

```sql
SELECT COUNT(*) FROM emp;
```

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ways-to-count.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/example-baby-feedings.png)

* Las funciones de grupo ignoran los valores nulos.

```sql

```

**COALESCE** = Transforma los valores nulos - Falsea los datos.

```sql
SELECT AVG(coalesce(comm,0)) FROM emp;
```

**Creación de Grupos de Datos** **GROUP BY**

```sql
SELECT camp/s, funció_grup
FROM taula/es
[WHERE condició/ons]
[GROUP BY camp/s_d’agrupació]
[ORDER BY camp/s];
```

`Totes les columnes esmentades al SELECT que no són funcions de gruphan d’estar a la clàusula GROUP BY*`

```sql
SELECT deptno, AVG(sal)
FROM emp
GROUP BY deptno;
```

* Group By con múltiples columnas

```sql
SELECT deptno, job, sum(sal)
FROM emp
GROUP BY deptno, job;
```

`¿CORRECTO?`

```sql
SELECT deptno, COUNT(ename)
FROM emp;
```

`NO`

```sql
SELECT deptno, COUNT(ename)
FROM emp;

ERROR: column "emp.deptno" must appear in the
GROUP BY clause or be used in an aggregate function
LINE 1: SELECT deptno, COUNT(ename)
```

`Qualsevol columna o expressió en una consulta SELECT que no sigui una funció d’agrupació s’ha de escriure a la clàusula GROUP BY*`

```sql
SELECT deptno, COUNT(ename)
FROM emp
GROUP BY deptno;
```

**HAVING** = SE USA COMO WHERE EN LOS **GROUP BY**.

```sql
SELECT camp/s, funció_grup
FROM taul
[WHERE condició/ons]
[GROUP BY camps d’agrupació]
[HAVING condició de grup]
[ORDER BY camps];
```

* *S’agrupen les files segons el camp d’agrupació
* *S’aplica la funció d’agrupament
* *Es filtren les files resultants segons HAVING

```sql
SELECT deptno, avg(sal)
FROM emp
GROUP BY deptno
HAVING avg(sal) > 2900;
```


* Muestra Job, Suma el Salario, donde Job no empiece por SALES y la suma de salario sea mayor que 5000.

```sql
SELECT job, SUM(sal) AS "Suma de salaris"
FROM emp
WHERE job NOT LIKE 'SALES%'
GROUP BY job
HAVING SUM(sal) > 5000
ORDER BY SUM(sal);
```


----------------------------------------------------------------------------------

# Ejemplos y ejercicios PART1

# Consultes resum

## Exercici 0
En una mateixa consulta, calcula la suma de les quotes, quants venedors n'hi
ha, i finalment mostra la quota promig calculada a partir de les funcions
anteriors i també amb una funció especial per al promig. Compara aquests dos
últims resultats. Si volguéssim que la darrera funció actui com la penúltima
com ho faries?


```sql
SELECT SUM(quota), COUNT(*), SUM(quota) / COUNT(*) AS mitjana, AVG(quota)
  FROM rep_vendes;
``` 
```sql
    sum     | count |       mitjana       |         avg         
------------+-------+---------------------+---------------------
 2700000.00 |    10 | 270000.000000000000 | 300000.000000000000
(1 row)
```

**CAST** = Convert a value to an int datatype:

```sql
SELECT SUM(quota), COUNT(*), CAST( SUM(quota) / COUNT(*) as NUMERIC(8,2) )  AS mitjana, 
       CAST( AVG(quota) as NUMERIC(8,2) )
 FROM rep_vendes;
```

Depenent del que vulguem ens convindrà més una o altra. Però responent a la pregunta plantejada:

```sql
SELECT CAST( SUM(quota) / COUNT(*) as NUMERIC(8,2) )  AS mitjana, CAST( AVG(COALESCE(quota,0)) as NUMERIC(8,2) )
 FROM rep_vendes; 
```

```sql
  mitjana  |    avg    
-----------+-----------
 270000.00 | 270000.20
(1 row)
```

Nota: no posem COALESCE a la funció d'agrupament SUM ja que no influiria en el
resultat, ja és el que fa SUM.


## Exercici 1
Quina és la quota promig mostrada com a "prom_quota" i la venda promig
mostrades com a "prom_vendes" dels venedors?

```sql
SELECT AVG(quota) AS prom_vendes, AVG(vendes) AS prom_vendes
FROM rep_vendes;
```

## Exercici 2
Quin és el promig del rendiment dels venedors (promig del percentatge de les vendes
respecte la quota)?

```sql
SELECT CAST( 100 * AVG( vendes / quota ) AS NUMERIC(5,2) )
  FROM rep_vendes;
```
```
 numeric 
---------
  102.60
(1 row)
```

### Nota 1 
Si deixem el 100 fora del `CAST` perdem alguns decimals i el resultat és menys exacte.

### Nota 2

Fixem-nos que hi ha un quocient que es descarta perquè no hi ha quota:

En efecte el quocient de Tom Snyder, l'únic venedor que no té quota no entra:

```sql
SELECT CAST( 100 * AVG( vendes / quota ) AS NUMERIC(5,2) )
  FROM rep_vendes
 WHERE quota IS NOT NULL;
```
dona el mateix resultat
```sql
 numeric
---------
  102.60
(1 row)
```

Ens podria interessar fer el següent:

Volem calcular la mitjana dels quocients vendes / quota i quan ens trobem un
venedor sense quota li assignarem un valor, quin valor li podríem assignar?


Una possibilitat podria ser _La mitjana de les quotes_

De manera que tindríem que la consulta la podríem calcular de la següent manera:


```sql
SELECT CAST(100 * AVG( vendes / COALESCE( quota, AVG(quota) )) AS NUMERIC(5,2))
  FROM rep_vendes; 
```

Però tenim un problema, PostgreSQL no admet funcions d'agrupació niuades.

`ERROR:  aggregate function calls cannot be nested`

De manera que s'hauria de resoldre amb una subconsulta. Com encara no sabem
fer-les, no podrem escriure una cosa com aquesta:

```sql
SELECT CAST(100 * AVG( vendes / COALESCE( quota, 
       ( SELECT AVG(quota) from rep_vendes AS taula ) )) AS NUMERIC(5,2))
  FROM rep_vendes; 
```
```
 numeric 
---------
   94.87
(1 row)
```

Tot i que no entenguem encara com s'ha resolt aquesta darrera consulta. Ens
sembla raonable aquesta baixada del 102.60 % al 94.87% ?


## Exercici 3

Quines són les quotes totals com a *t_quota* i vendes totals com a *t_vendes*
de tots els venedors?

```sql
SELECT SUM(quota) AS t_quota, SUM(vendes) AS t_vendes
  FROM rep_vendes;
```
```sql
  t_quota   |  t_vendes  
------------+------------
 2700000.00 | 2893532.00
(1 row)
```

## Exercici 4
Calcula el preu mig dels productes del fabricant amb identificador "aci".

```sql
SELECT CAST(AVG(preu) AS NUMERIC(6,2) ) AS preu_mig_aci
  FROM productes
 WHERE id_fabricant = 'aci';
```
```sql
 preu_mig_aci 
--------------
       804.29
(1 row)
```

## Exercici 5
Quines són les quotes assignades mínima i màxima?

```sql
SELECT MIN(quota), MAX(quota)
  FROM rep_vendes;
```
```sql
    min    |    max    
-----------+-----------
 200000.00 | 350000.00
(1 row)
```


## Exercici 6
Quina és la data de comanda més antiga?

```sql
SELECT MIN(data)
  FROM comandes;
```

``` sql
    min     
------------
 1989-01-04
(1 row)
```

## Exercici 7
Quin és el major percentatge de rendiment de vendes respecte les quotes de tots els venedors?
(o sigui el major percentatge de les vendes respecte a la quota)


```sql
SELECT ROUND(MAX(100 * vendes / quota),2)
  FROM rep_vendes;
```
o
```sql
SELECT  CAST(100 * MAX( vendes / quota ) AS NUMERIC(5,2))
  FROM rep_vendes;
```

```sql
 numeric 
---------
  135.44
(1 row)
```

### Nota 1:

Si fem el mateix que a l'exercici 2 veiem que amb el màxim no canvia res.
```sql
SELECT  CAST( 100 * MAX( vendes / COALESCE( quota,
       ( SELECT AVG(quota) from rep_vendes AS taula ) )) AS NUMERIC(5,2))
  FROM rep_vendes;
```
```sql
 numeric 
---------
  135.44
(1 row)
```

Però què passa si calculem el mínim?

El mínim:

```sql
SELECT  CAST(100 * MIN( vendes / quota ) AS NUMERIC(5,2))
  FROM rep_vendes;
```
ens dona:

```sql
 numeric 
---------
   62.01
(1 row)
```



Ara al afegir el quocient de Tom Snyder (recordem que li posem com a quota la
mitjana de la resta de venedors)

```sql
SELECT  CAST( 100 * MIN( vendes / COALESCE( quota,
       ( SELECT AVG(quota) from rep_vendes AS taula ) )) AS NUMERIC(5,2))
  FROM rep_vendes;
```

Ens dona:

```sql
 numeric 
---------
   25.33
(1 row)
```

que es el quocient que obtenim de dividir les vendes de Tom Snyder per la quota
_mitjana de la resta de treballadors_.


## Exercici 8
Quants clients hi ha?

```sql
SELECT COUNT(*)  AS nombre_clients
FROM clients;
```
```sql
 nombre_clients 
----------------
             21
(1 row)

```


## Exercici 9
Quants venedors superen la seva quota?

```sql
SELECT COUNT(*) AS venedors_superen_quota
  FROM rep_vendes 
 WHERE vendes > quota;
```
```sql
 venedors_superen_quota 
------------------------
                      7
(1 row)
```

## Exercici 10
Quantes comandes amb un import superior a 25000 hi ha en els registres?

```sql
SELECT COUNT(*) AS "import comandes > 25000"
  FROM comandes 
 WHERE import > 25000;
```
```sql
 import comandes > 25000 
--------------------------
                        5
(1 row)
```


## Exercici 11

Trobar l'import mitjà de les comandes, l'import total de les
comandes, la mitjana del percentatge de l'import mitjà de les comandes respecte
del límit de crèdit del client i la mitjana del percentatge de l'import mitjà
de comandes respecte a la quota del venedor.

```sql
SELECT ROUND(AVG(import),2) AS import_mitja, ROUND(SUM(import),2) AS import_total,
       ROUND(AVG(100 * import / limit_credit),2) AS "mitjana import/credit",
       ROUND(AVG(100 * import / quota),2) AS "mitjana import/quota"
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes
       ON comandes.rep = rep_vendes.num_empl;
```
```sql
 import_mitja | import_total | mitjana import/credit | mitjana import/quota 
--------------+--------------+-----------------------+----------------------
      8256.37 |    247691.00 |                 24.45 |                 2.51
(1 row)

```

## Exercici 12
Compta les files que hi ha a repventas, les files del camp vendes i les del camp quota.

```sql
SELECT COUNT(*), COUNT(vendes), COUNT(quota)
  FROM rep_vendes;
```
```sql
 count | count | count 
-------+-------+-------
    10 |    10 |     9
(1 row)
```

## Exercici 13

Demostra que la suma de restar vendes menys quota és diferent que sumar vendes i restar-li la suma de quotes.

```sql
SELECT SUM(vendes - quota) AS "SUM(vendes-quota)",
       SUM(vendes) - SUM(quota) AS "SUM(vendes) - SUM(quota)" 
  FROM rep_vendes;
```
```sql
 SUM(vendes-quota) | SUM(vendes) - SUM(quota) 
-------------------+--------------------------
         117547.00 |                193532.00
(1 row)
```
La diferència ve donada pel valor NULL a la quota que fa que la resta de Tom Snyder (75985.00 - NULL) no es faci, en canvi quan es suma primer tots els valors de vendes aquest 75985 sí que es suma.

Si volguéssim obtenir el mateix valor ho podríem solucionar amb un _coalesce_:

```sql
SELECT SUM(vendes - COALESCE(quota,0)) AS "SUM(vendes-quota)",
       SUM(vendes) - SUM(quota) AS "SUM(vendes) - SUM(quota)"
  FROM rep_vendes;
```
```sql
 SUM(vendes-quota) | SUM(vendes) - SUM(quota) 
-------------------+--------------------------
         193532.00 |                193532.00
(1 row)
```

## Exercici 14
Quants tipus de càrrecs hi ha de venedors?

```sql
SELECT COUNT(DISTINCT carrec)
FROM repventas;
```
```sql
 count 
-------
     3
(1 row)
```


## Exercici 15

Quantes oficines de vendes tenen venedors que superen les seves quotes?

```sql
SELECT COUNT(DISTINCT oficina_rep) AS "oficines amb grans venedors"
  FROM rep_vendes
 WHERE vendes > quota;
```

```sql
 oficines amb grans venedors 
-----------------------------
                           4
(1 row)
```

## Exercici 16
De la taula clients quants clients diferents i venedors diferents hi ha.

```sql
SELECT COUNT(num_clie) AS "total clients", COUNT(DISTINCT rep_clie) AS "total venedors"  
  FROM clients;
```
```sql
 total clients | total venedors 
---------------+----------------
            21 |             10
(1 row)
```



## Exercici 17
De la taula comandes seleccionar quantes comandes diferents i clients diferents hi ha

```sql
SELECT COUNT(num_comanda)  AS "total comandes", COUNT(DISTINCT clie) AS "total clients"
  FROM comandes;
```
```sql
 total comandes | total clients 
----------------+---------------
             31 |            15
(1 row)
```

## Exercici 18
Calcular la mitjana dels imports de les comandes.

Ja fet(11)

```sql
SELECT AVG(import) 
  FROM comandes;
```

## Exercici 19
Calcula la mitjana de l'import d'una comanda realitzada pel client amb nom d'empresa "Acme Mfg."

```sql
SELECT ROUND(AVG(import),2) AS "import mitjà Acme" 
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie
 WHERE empresa = 'Acme Mfg.';
```

```sql
 import mitjà Acme 
-------------------
           8895.50
(1 row)
```


----------------------------------------------------------------------------------

# EJERCICIOS - PART 2



# Consultes resum

## Exercici 20

Quina és l'import promig de les comandes de cada venedor?

```sql
  SELECT rep, ROUND(AVG(import),2) AS promig_comandes
    FROM comandes
GROUP BY rep
ORDER BY rep;
```
```sql
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

```sql
  SELECT nom, ROUND(AVG(import),2) AS promig_comandes
    FROM comandes
         JOIN rep_vendes
         ON comandes.rep = rep_vendes.num_empl
GROUP BY nom
ORDER BY promig_comandes;
```

```sql
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

```sql
  SELECT nom, ROUND(AVG(import),2) AS promig_comandes
    FROM comandes
         LEFT JOIN rep_vendes
         ON comandes.rep = rep_vendes.num_empl
GROUP BY nom
ORDER BY promig_comandes;
```

## Exercici 21

Quin és el rang (màxim i mínim) de quotes dels venedors per cada oficina?

```sql
  SELECT oficina_rep, MAX(quota) AS max_quota, MIN(quota) AS MIN_quota
    FROM rep_vendes
   WHERE oficina_rep IS NOT NULL
GROUP BY oficina_rep
ORDER BY oficina_rep;
```
```sql
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

```sql
  SELECT oficina_rep, count(num_empl)
    FROM rep_vendes
GROUP BY oficina_rep
ORDER BY oficina_rep;
```
```sql
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

```sql
  SELECT oficina_rep, count(num_empl)
    FROM rep_vendes
   WHERE oficina_rep IS NOT NULL        
GROUP BY oficina_rep;
```

## Exercici 23

Per cada venedor calcular quants clients diferents ha atès ( atès = atendre una comanda)?

```sql
  SELECT rep, COUNT(DISTINCT clie)
    FROM comandes
GROUP BY rep
ORDER BY rep;
```
```sql
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

```sql
SELECT clie, rep, SUM(import) AS total_import
  FROM comandes
 GROUP BY clie, rep;
```

```sql
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

```sql
SELECT clie, rep, SUM(import) AS total_import
  FROM comandes
 WHERE rep IS NOT NULL
 GROUP BY clie, rep;
```

## Exercici 25

El mateix que a la qüestió anterior, però ordenat per client i dintre de client per venedor.

```sql
SELECT clie, rep, SUM(import) AS total_import
  FROM comandes
 GROUP BY clie, rep
 ORDER BY clie, rep;
``` 
```sql
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

```sql
  SELECT rep, COUNT(*)
    FROM comandes
   WHERE rep IS NOT NULL
GROUP BY rep;
```
```sql
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


```sql
  SELECT rep, SUM(import)
    FROM comandes
   WHERE rep IS NOT NULL
GROUP BY rep;
```

```sql
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

```sql
  SELECT rep, round(AVG(import),2) AS "import promig"
    FROM comandes 
GROUP BY rep
  HAVING SUM(import) > 30000;
```
```sql
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

```sql
  SELECT ciutat, oficina_rep, SUM(quota) AS "suma quotes", SUM(rep_vendes.vendes) AS "suma de vendes"
    FROM rep_vendes
         JOIN oficines
         ON rep_vendes.oficina_rep = oficines.oficina
GROUP BY oficina_rep, ciutat
  HAVING COUNT(*) >= 2;
```

```sql
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

```sql
SELECT id_fabricant, id_producte, preu, estoc, SUM(quantitat) AS suma_quantitat
  FROM comandes
       JOIN productes
       ON fabricant = id_fabricant
         AND producte = id_producte
 GROUP BY id_fabricant, id_producte
HAVING SUM(quantitat) > 75 * estoc / 100;
```

```sql
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

```sql
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
```sql
SELECT id_fabricant, estoc			SELECT id_fabricant, SUM(estoc) AS suma_estoc
  FROM productes 				  FROM productes
 ORDER BY id_fabricant;				 GROUP BY id_fabricant
					 	 ORDER BY id_fabricant;
```

Ens mostren respectivament:				

```sql
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


```sql
SELECT id_fabricant, estoc			SELECT id_fabricant, SUM(estoc) AS suma_estoc
  FROM productes				  FROM productes
 ORDER BY id_fabricant;				 WHERE preu > 54
						 GROUP BY id_fabricant
						 ORDER BY id_fabricant;
```

```sql
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


```sql
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

```sql
SELECT id_fabricant, SUM(estoc) AS suma_estoc
  FROM productes
 WHERE preu > 54
 GROUP BY id_fabricant
HAVING SUM(estoc) > 300;
```

```sql
 id_fabricant | suma_estoc 
--------------+------------
 aci          |        843
(1 row)
```




## Exercici 31

Es desitja un llistat dels productes amb les seves descripcions, ordenat per la
suma total d'imports facturats (comandes) de cada producte de l'any 1989.

```sql
SELECT id_fabricant, id_producte, descripcio, SUM(import)
  FROM productes
       JOIN comandes
       ON id_fabricant = fabricant
         AND id_producte = producte
 WHERE date_part('year', data) = 1989
 GROUP BY id_fabricant, id_producte
 ORDER BY SUM(import);
```
```sql
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

```sql
SELECT *                                         
  FROM rep_vendes AS venedors
       JOIN rep_vendes AS caps
       ON venedors.cap = caps.num_empl
 ORDER BY caps.num_empl;
```

Executeu la consulta anterior i fixem-nos en els camps en funció del director
del venedor.




Resolem la consulta sense fer l'excepció (la del gerent):

```sql
SELECT caps.num_empl, caps.nom, SUM(venedors.vendes)
  FROM rep_vendes AS venedors
       JOIN rep_vendes AS caps
       ON venedors.cap = caps.num_empl
 GROUP BY caps.num_empl
 ORDER BY caps.num_empl;
```


Finalment imposem que el cap dels venedors tingui al seu torn cap:

```sql
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

```sql
SELECT fab, producto, descripcion, existencias, COUNT(DISTINCT clie)
FROM pedidos
JOIN productos ON producto = id_producto AND fab = id_fab
GROUP BY id_fab, id_producto, fab, producto
ORDER BY COUNT(DISTINCT clie) DESC, existencias DESC, descripcion
LIMIT 5;
```

```sql
SELECT id_fabricant, id_producte, estoc, descripcio,  COUNT(DISTINCT clie) AS clients_p_producte
  FROM productes
       JOIN comandes
       ON productes.id_fabricant = fabricant
         AND id_producte = producte
 GROUP BY id_fabricant, id_producte
ORDER BY clients_p_producte DESC, estoc DESC, descripcio
FETCH FIRST 5 ROWS ONLY;
```

```sql
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

```sql
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

```sql
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


```sql
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

```sql
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

```sql
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

```sql
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

```sql
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

```sql
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

```sql
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

```sql
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


```sql
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

```sql
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


```sql
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


```sql
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

```sql
INSERT INTO comandes VALUES ( 88888, '2021-11-11', 2111, NULL, 'vi', 'Bages', 2600, 26000);
```



## LINK molt interessant:

[Do all columns in a SELECT list have to appear in a GROUP BY clause](https://stackoverflow.com/questions/5986127/do-all-columns-in-a-select-list-have-to-appear-in-a-group-by-clause#) 





---------------------------------------------------------------------------------

# Examen consultes multitaula i resum


## Exercici 1

Es vol llistar aquelles comandes que tinguin associat un representant de
vendes i també tinguin associat un producte on el preu pagat (import) sigui
inferior a 5000. Mostreu l'identificador i l'import de la comanda, el nom del
representant de vendes, la descripció del producte i el nom del client que ha
fet la comanda.



**Solució:**

La solució passa per no posar cap OUTER JOIN ja que diu clarament "que tinguin associat" :

```sql
SELECT num_comanda, import, nom, descripcio, empresa
  FROM comandes
       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte

       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes
       ON comandes.rep = rep_vendes.num_empl
 WHERE import < 5000;
```


```sql
 num_comanda | import  |      nom      |     descripcio     |      empresa      
-------------+---------+---------------+--------------------+-------------------
      113012 | 3745.00 | Bill Adams    | Article Tipus 3    | JCP Inc.
      112989 | 1458.00 | Sam Clark     | Bancada Motor      | Jones Mfg.
      112968 | 3978.00 | Dan Roberts   | Article Tipus 4    | First Corp.
      112963 | 3276.00 | Bill Adams    | Article Tipus 4    | Acme Mfg.
      113013 |  652.00 | Larry Fitch   | Manovella          | Midwest Systems
      113058 | 1480.00 | Mary Jones    | Coberta            | Holm & Landis
      112997 |  652.00 | Nancy Angelli | Manovella          | Peter Brothers
      112983 |  702.00 | Bill Adams    | Article Tipus 4    | Acme Mfg.
      113062 | 2430.00 | Nancy Angelli | Bancada Motor      | Peter Brothers
      113027 | 4104.00 | Bill Adams    | Article Tipus 2    | Acme Mfg.
      113007 | 2925.00 | Larry Fitch   | Riosta 1/2-Tm      | Zetacorp
      113034 |  632.00 | Tom Snyder    | V Stago Trinquet   | Ace International
      112992 |  760.00 | Larry Fitch   | Article Tipus 2    | Midwest Systems
      112975 | 2100.00 | Paul Cruz     | Passador Frontissa | JCP Inc.
      113055 |  150.00 | Dan Roberts   | Peu de rei         | Holm & Landis
      113048 | 3750.00 | Sue Smith     | Riosta 2-Tm        | Rico Enterprises
      112993 | 1896.00 | Sue Smith     | V Stago Trinquet   | Fred Lewis Corp.
      113065 | 2130.00 | Sue Smith     | Reductor           | Fred Lewis Corp.
      113049 |  776.00 | Larry Fitch   | Reductor           | Midwest Systems
      113057 |  600.00 | Paul Cruz     | Peu de rei         | JCP Inc.
(20 rows)
```

Si l'enunciat fos diferent i ens demanés comandes sense rep associat hauríem d'afegir un LEFT

```sql
SELECT num_comanda, import, nom, descripcio, empresa
  FROM comandes
       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte

       JOIN clients
       ON comandes.clie = clients.num_clie

       LEFT JOIN rep_vendes
       ON comandes.rep = rep_vendes.num_empl
 WHERE import < 5000;
```

## Exercici 2:

Llisteu tots els empleats que han estat contractats abans que els seus
directors. Mostrar el nom de l'empleat com a "empleat", la data del contracte del
l'empleat com a "contracte_empleat", el nom del seu cap com a "cap" i la data de
contracte del director com a "contracte_cap".

**Solució:**

```sql
SELECT venedors.nom AS empleat, venedors.data_contracte AS contracte_empleat,
       caps.nom AS cap, caps.data_contracte AS contracte_cap
  FROM rep_vendes AS venedors 
       JOIN rep_vendes AS caps
       ON venedors.cap = caps.num_empl
 WHERE venedors.data_contracte < caps.data_contracte;
```

```sql
    empleat    | contracte_empleat |     cap     | contracte_cap 
---------------+-------------------+-------------+---------------
 Sue Smith     | 1986-12-10        | Larry Fitch | 1989-10-12
 Bob Smith     | 1987-05-19        | Sam Clark   | 1988-06-14
 Dan Roberts   | 1986-10-20        | Bob Smith   | 1987-05-19
 Paul Cruz     | 1987-03-01        | Bob Smith   | 1987-05-19
 Nancy Angelli | 1988-11-14        | Larry Fitch | 1989-10-12
(5 rows)
```

   

## Exercici 3 


Llisteu les comandes dels clients els quals la segona lletra del nom de l'empresa sigui la lletra "c", sense tenir en compte majúscules i minúscules. Mostreu la data de la comanda i el nom de l'empresa.

**Solució:**

```sql
SELECT empresa, data
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie
 WHERE LOWER(empresa) LIKE '_c%';
```
```sql
      empresa      |    data    
-------------------+------------
 JCP Inc.          | 1990-01-11
 Ace International | 1990-01-30
 Acme Mfg.         | 1989-12-17
 Acme Mfg.         | 1989-12-27
 Acme Mfg.         | 1990-01-22
 Ace International | 1990-01-29
 JCP Inc.          | 1989-12-12
 Acme Mfg.         | 1989-12-31
 JCP Inc.          | 1990-02-18
 JCP Inc.          | 2021-11-11
(10 rows)
```

ILIKE és de PostgreSQL i no és estandard per tant no el fem servir si hi ha una
opció estàndard que accepta PostgreSQL.



## Exercici 4

Llisteu les comandes amb els clients que les han demanades. Si algun client no ha demanat cap comanda també ha d'aparèixer. S'ha de mostrar el codi de la comanda, el codi del client i el nom del client.

**Solució:**

```sql
SELECT num_comanda, num_clie, empresa
  FROM comandes
       RIGHT JOIN clients
       ON comandes.clie = clients.num_clie;
```

```
 num_comanda | num_clie |      empresa      
-------------+----------+-------------------
      112961 |     2117 | J.P. Sinclair
      113012 |     2111 | JCP Inc.
      112989 |     2101 | Jones Mfg.
      113051 |     2118 | Midwest Systems
      112968 |     2102 | First Corp.
      110036 |     2107 | Ace International
      113045 |     2112 | Zetacorp
      112963 |     2103 | Acme Mfg.
      113013 |     2118 | Midwest Systems
      113058 |     2108 | Holm & Landis
      112997 |     2124 | Peter Brothers
      112983 |     2103 | Acme Mfg.
      113024 |     2114 | Orion Corp
      113062 |     2124 | Peter Brothers
      112979 |     2114 | Orion Corp
      113027 |     2103 | Acme Mfg.
      113007 |     2112 | Zetacorp
      113069 |     2109 | Chen Associates
      113034 |     2107 | Ace International
      112992 |     2118 | Midwest Systems
      112975 |     2111 | JCP Inc.
      113055 |     2108 | Holm & Landis
      113048 |     2120 | Rico Enterprises
      112993 |     2106 | Fred Lewis Corp.
      113065 |     2106 | Fred Lewis Corp.
      113003 |     2108 | Holm & Landis
      113049 |     2118 | Midwest Systems
      112987 |     2103 | Acme Mfg.
      113057 |     2111 | JCP Inc.
      113042 |     2113 | Ian & Schmidt
        NULL |     2121 | QMA Assoc.
        NULL |     2115 | Smithson Corp.
        NULL |     2119 | Solomon Inc.
        NULL |     2122 | Three-Way Lines
        NULL |     2105 | AAA Investments
        NULL |     2123 | Carter & Sons
(36 rows)
```

## Exercici 5

Llisteu les comandes que continguin un producte amb la lletra _x_ al seu codi de
producte. S'ha de mostrar el codi de la comanda, el codi del fabricant i del
producte, el nom del venedor que ha servit la comanda com a empleat_comanda i
el nom del venedor associat al client que ha fet la comanda com a
empleat_client. Ordena-ho pel camp que tingui més sentit escollir.


**Solució:**

```sql
SELECT num_comanda, fabricant, producte, ven_comandes.nom AS empleat_comanda, ven_clients.nom AS empleat_client
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes AS ven_comandes
       ON comandes.rep = ven_comandes.num_empl

       JOIN rep_vendes AS ven_clients
       ON clients.rep_clie = ven_clients.num_empl
WHERE producte LIKE '%x%'
ORDER BY 2,3;
```

```sql
 num_comanda | fabricant | producte | empleat_comanda | empleat_client 
-------------+-----------+----------+-----------------+----------------
      113055 | aci       | 4100x    | Dan Roberts     | Mary Jones
      113057 | aci       | 4100x    | Paul Cruz       | Paul Cruz
      113024 | qsa       | xk47     | Larry Fitch     | Sue Smith
      113065 | qsa       | xk47     | Sue Smith       | Sue Smith
      113049 | qsa       | xk47     | Larry Fitch     | Larry Fitch
(5 rows)
```

## Exercici 6

Mostreu un camp anomenat "edat_m". El camp ha de contenir la mitjana de l'edat
dels treballadors amb només dos decimals.

**Solució:**

```sql
SELECT ROUND(AVG(edat),2) AS edat_m
  FROM rep_vendes;
```

```sql
 edat_m 
--------
  42.70
(1 row)
```



## Exercici 7
 
Mostreu l'identificador dels clients i un camp anomenat "comandes". El camp
"comandes" ha de mostrar quantes comandes ha fet cada client. S'ha d'ordenar
per identificador del client, de més petit a més gran.


**Solució:**
```sql
SELECT num_clie, COUNT(clie) AS comandes
  FROM comandes
       RIGHT JOIN clients
       ON comandes.clie = clients.num_clie
 GROUP BY num_clie
 ORDER BY num_clie;
```

```sql
 num_clie | comandes 
----------+----------
     2101 |        1
     2102 |        1
     2103 |        4
     2105 |        0
     2106 |        2
     2107 |        2
     2108 |        3
     2109 |        1
     2111 |        4
     2112 |        2
     2113 |        1
     2114 |        2
     2115 |        0
     2117 |        1
     2118 |        4
     2119 |        0
     2120 |        1
     2121 |        0
     2122 |        0
     2123 |        0
     2124 |        2
(21 rows)
```

## Exercici 8

Llisteu aquells clients pels quals la suma dels imports de les seves comandes
sigui menor al limit de crèdit. Mostreu l'identificador i el nom de l'empresa
dels clients.


**Solució:**

```sql
SELECT num_clie, empresa, limit_credit, SUM(import) AS total_imports
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie
 GROUP BY num_clie
HAVING limit_credit > SUM(import);
```

No cal posar _empresa_ ja que depèn funcionalment de *num_clie*, la columna
utilitzada com a criteri d'agrupació.


```sql
 num_clie |      empresa      | limit_credit | total_imports 
----------+-------------------+--------------+---------------
     2108 | Holm & Landis     |     55000.00 |       7255.00
     2124 | Peter Brothers    |     40000.00 |       3082.00
     2101 | Jones Mfg.        |     65000.00 |       1458.00
     2106 | Fred Lewis Corp.  |     65000.00 |       4026.00
     2118 | Midwest Systems   |     60000.00 |       3608.00
     2112 | Zetacorp          |     50000.00 |      47925.00
     2107 | Ace International |     35000.00 |      23132.00
     2102 | First Corp.       |     65000.00 |       3978.00
     2117 | J.P. Sinclair     |     35000.00 |      31500.00
     2103 | Acme Mfg.         |     50000.00 |      35582.00
     2120 | Rico Enterprises  |     50000.00 |       3750.00
     2111 | JCP Inc.          |     50000.00 |      15445.00
(12 rows)
```

El límit de crèdit podria ser NULL, però com a l'enunciat diu "que sigui menor ..."


## Exercici 9

Mostreu l'identificador del venedor i un camp anomenat "preu_top". El camp
"preu_top" ha de contenir el preu del producte més car que ha venut.

**Solució:**

```sql
SELECT rep, MAX(preu) AS preu_top
  FROM comandes
       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte
 GROUP BY rep
 ORDER BY rep;
```
```sql
 rep | preu_top 
-----+----------
 101 |  4500.00
 102 |  2500.00
 103 |   350.00
 105 |  2750.00
 106 |  4500.00
 107 |  1425.00
 108 |  4500.00
 109 |  1875.00
 110 |  2500.00
(9 rows)
```


Si l'enunciat de l'examen ens hagués demanat que també sortissin els venedors
que no han fet cap comanda i que per a aquests casos el seu preu top fos 0, la
consulta es podria resoldre de la següent manera.
 

```sql
SELECT num_empl, COALESCE(MAX(preu),0) AS preu_top
  FROM comandes
       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte
 
       RIGHT JOIN rep_vendes
       ON comandes.rep = rep_vendes.num_empl    
 GROUP BY num_empl
 ORDER BY num_empl;
```

```sql
 num_empl | preu_top 
----------+----------
      101 |  4500.00
      102 |  2500.00
      103 |   350.00
      104 |        0
      105 |  2750.00
      106 |  4500.00
      107 |  1425.00
      108 |  4500.00
      109 |  1875.00
      110 |  2500.00
(10 rows)
```



## Exercici 10

Mostreu l'identificador i la ciutat de les oficines i dos camps més, un
anomenat "crèdit1" i l'altre "crèdit2". Per a cada oficina, el camp "crèdit1"
ha de mostrar el límit de crèdit més petit dels clients que tenen assignat un
representant en aquesta oficina. El camp "crèdit2" ha de ser el mateix però pel
límit de crèdit més gran.

**Solució:**

```sql
SELECT oficina, ciutat, MIN(limit_credit) AS credit1, MAX(limit_credit) AS credit2
  FROM clients
       JOIN rep_vendes
       ON clients.rep_clie = rep_vendes.num_empl

       JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina
 GROUP BY oficina        
 ORDER BY oficina, ciutat;
```

No cal posar _ciutat_ ja que depèn funcionalment de *oficina*, la columna
utilitzada com a criteri d'agrupació.
```
 oficina |   ciutat    | credit1  | credit2  
---------+-------------+----------+----------
      11 | New York    | 25000.00 | 65000.00
      12 | Chicago     | 20000.00 | 65000.00
      13 | Atlanta     | 30000.00 | 50000.00
      21 | Los Angeles | 20000.00 | 65000.00
      22 | Denver      | 40000.00 | 40000.00
(5 rows)
```

