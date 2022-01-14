# Consultes resum

## Exercici 0
En una mateixa consulta, calcula la suma de les quotes, quants venedors n'hi
ha, i finalment mostra la quota promig calculada a partir de les funcions
anteriors i també amb una funció especial per al promig. Compara aquests dos
últims resultats. Si volguéssim que la darrera funció actui com la penúltima
com ho faries?


```
SELECT SUM(quota), COUNT(*), SUM(quota) / COUNT(*) AS mitjana, AVG(quota)
  FROM rep_vendes;
``` 
```
    sum     | count |       mitjana       |         avg         
------------+-------+---------------------+---------------------
 2700000.00 |    10 | 270000.000000000000 | 300000.000000000000
(1 row)
```

```
SELECT SUM(quota), COUNT(*), CAST( SUM(quota) / COUNT(*) as NUMERIC(8,2) )  AS mitjana, 
       CAST( AVG(quota) as NUMERIC(8,2) )
 FROM rep_vendes;
```

Depenent del que vulguem ens convindrà més una o altra. Però responent a la pregunta plantejada:

```
SELECT CAST( SUM(quota) / COUNT(*) as NUMERIC(8,2) )  AS mitjana, CAST( AVG(COALESCE(quota,0)) as NUMERIC(8,2) )
 FROM rep_vendes; 
```

```
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

```
SELECT AVG(quota) AS prom_vendes, AVG(vendes) AS prom_vendes
FROM rep_vendes;
```

## Exercici 2
Quin és el promig del rendiment dels venedors (promig del percentatge de les vendes
respecte la quota)?

```
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

```
SELECT CAST( 100 * AVG( vendes / quota ) AS NUMERIC(5,2) )
  FROM rep_vendes
 WHERE quota IS NOT NULL;
```
dona el mateix resultat
```
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


```
SELECT CAST(100 * AVG( vendes / COALESCE( quota, AVG(quota) )) AS NUMERIC(5,2))
  FROM rep_vendes; 
```

Però tenim un problema, PostgreSQL no admet funcions d'agrupació niuades.

`ERROR:  aggregate function calls cannot be nested`

De manera que s'hauria de resoldre amb una subconsulta. Com encara no sabem
fer-les, no podrem escriure una cosa com aquesta:

```
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

```
SELECT SUM(quota) AS t_quota, SUM(vendes) AS t_vendes
  FROM rep_vendes;
```
```
  t_quota   |  t_vendes  
------------+------------
 2700000.00 | 2893532.00
(1 row)
```

## Exercici 4
Calcula el preu mig dels productes del fabricant amb identificador "aci".

```
SELECT CAST(AVG(preu) AS NUMERIC(6,2) ) AS preu_mig_aci
  FROM productes
 WHERE id_fabricant = 'aci';
```
```
 preu_mig_aci 
--------------
       804.29
(1 row)
```

## Exercici 5
Quines són les quotes assignades mínima i màxima?

```
SELECT MIN(quota), MAX(quota)
  FROM rep_vendes;
```
```
    min    |    max    
-----------+-----------
 200000.00 | 350000.00
(1 row)
```


## Exercici 6
Quina és la data de comanda més antiga?

```
SELECT MIN(data)
  FROM comandes;
```

``` 
    min     
------------
 1989-01-04
(1 row)
```

## Exercici 7
Quin és el major percentatge de rendiment de vendes respecte les quotes de tots els venedors?
(o sigui el major percentatge de les vendes respecte a la quota)


```
SELECT ROUND(MAX(100 * vendes / quota),2)
  FROM rep_vendes;
```
o
```
SELECT  CAST(100 * MAX( vendes / quota ) AS NUMERIC(5,2))
  FROM rep_vendes;
```

```
 numeric 
---------
  135.44
(1 row)
```

### Nota 1:

Si fem el mateix que a l'exercici 2 veiem que amb el màxim no canvia res.
```
SELECT  CAST( 100 * MAX( vendes / COALESCE( quota,
       ( SELECT AVG(quota) from rep_vendes AS taula ) )) AS NUMERIC(5,2))
  FROM rep_vendes;
```
```
 numeric 
---------
  135.44
(1 row)
```

Però què passa si calculem el mínim?

El mínim:

```
SELECT  CAST(100 * MIN( vendes / quota ) AS NUMERIC(5,2))
  FROM rep_vendes;
```
ens dona:

```
 numeric 
---------
   62.01
(1 row)
```



Ara al afegir el quocient de Tom Snyder (recordem que li posem com a quota la
mitjana de la resta de venedors)

```
SELECT  CAST( 100 * MIN( vendes / COALESCE( quota,
       ( SELECT AVG(quota) from rep_vendes AS taula ) )) AS NUMERIC(5,2))
  FROM rep_vendes;
```

Ens dona:

```
 numeric 
---------
   25.33
(1 row)
```

que es el quocient que obtenim de dividir les vendes de Tom Snyder per la quota
_mitjana de la resta de treballadors_.


## Exercici 8
Quants clients hi ha?

```
SELECT COUNT(*)  AS nombre_clients
FROM clients;
```
```
 nombre_clients 
----------------
             21
(1 row)

```


## Exercici 9
Quants venedors superen la seva quota?

```
SELECT COUNT(*) AS venedors_superen_quota
  FROM rep_vendes 
 WHERE vendes > quota;
```
```
 venedors_superen_quota 
------------------------
                      7
(1 row)
```

## Exercici 10
Quantes comandes amb un import superior a 25000 hi ha en els registres?

```
SELECT COUNT(*) AS "import comandes > 25000"
  FROM comandes 
 WHERE import > 25000;
```
```
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

```
SELECT ROUND(AVG(import),2) AS import_mitja, ROUND(SUM(import),2) AS import_total,
       ROUND(AVG(100 * import / limit_credit),2) AS "mitjana import/credit",
       ROUND(AVG(100 * import / quota),2) AS "mitjana import/quota"
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes
       ON comandes.rep = rep_vendes.num_empl;
```
```
 import_mitja | import_total | mitjana import/credit | mitjana import/quota 
--------------+--------------+-----------------------+----------------------
      8256.37 |    247691.00 |                 24.45 |                 2.51
(1 row)

```

## Exercici 12
Compta les files que hi ha a repventas, les files del camp vendes i les del camp quota.

```
SELECT COUNT(*), COUNT(vendes), COUNT(quota)
  FROM rep_vendes;
```
```
 count | count | count 
-------+-------+-------
    10 |    10 |     9
(1 row)
```

## Exercici 13

Demostra que la suma de restar vendes menys quota és diferent que sumar vendes i restar-li la suma de quotes.

```
SELECT SUM(vendes - quota) AS "SUM(vendes-quota)",
       SUM(vendes) - SUM(quota) AS "SUM(vendes) - SUM(quota)" 
  FROM rep_vendes;
```
```
 SUM(vendes-quota) | SUM(vendes) - SUM(quota) 
-------------------+--------------------------
         117547.00 |                193532.00
(1 row)
```
La diferència ve donada pel valor NULL a la quota que fa que la resta de Tom Snyder (75985.00 - NULL) no es faci, en canvi quan es suma primer tots els valors de vendes aquest 75985 sí que es suma.

Si volguéssim obtenir el mateix valor ho podríem solucionar amb un _coalesce_:

```
SELECT SUM(vendes - COALESCE(quota,0)) AS "SUM(vendes-quota)",
       SUM(vendes) - SUM(quota) AS "SUM(vendes) - SUM(quota)"
  FROM rep_vendes;
```
```
 SUM(vendes-quota) | SUM(vendes) - SUM(quota) 
-------------------+--------------------------
         193532.00 |                193532.00
(1 row)
```

## Exercici 14
Quants tipus de càrrecs hi ha de venedors?

```
SELECT COUNT(DISTINCT carrec)
FROM repventas;
```
```
 count 
-------
     3
(1 row)
```


## Exercici 15

Quantes oficines de vendes tenen venedors que superen les seves quotes?

```
SELECT COUNT(DISTINCT oficina_rep) AS "oficines amb grans venedors"
  FROM rep_vendes
 WHERE vendes > quota;
```

```
 oficines amb grans venedors 
-----------------------------
                           4
(1 row)
```

## Exercici 16
De la taula clients quants clients diferents i venedors diferents hi ha.

```
SELECT COUNT(num_clie) AS "total clients", COUNT(DISTINCT rep_clie) AS "total venedors"  
  FROM clients;
```
```
 total clients | total venedors 
---------------+----------------
            21 |             10
(1 row)
```



## Exercici 17
De la taula comandes seleccionar quantes comandes diferents i clients diferents hi ha

```
SELECT COUNT(num_comanda)  AS "total comandes", COUNT(DISTINCT clie) AS "total clients"
  FROM comandes;
```
```
 total comandes | total clients 
----------------+---------------
             31 |            15
(1 row)
```

## Exercici 18
Calcular la mitjana dels imports de les comandes.

Ja fet(11)

```
SELECT AVG(import) 
  FROM comandes;
```

## Exercici 19
Calcula la mitjana de l'import d'una comanda realitzada pel client amb nom d'empresa "Acme Mfg."

```
SELECT ROUND(AVG(import),2) AS "import mitjà Acme" 
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie
 WHERE empresa = 'Acme Mfg.';
```

```
 import mitjà Acme 
-------------------
           8895.50
(1 row)
```

