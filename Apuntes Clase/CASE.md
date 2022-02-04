# CASE Expression

## Problema

De vegades necessitem categoritzar per un criteri que no és cap de les nostres columnes. 

Pensem per exemple en la taula rep_vendes, vull comptar quants boomers, millenials o zoomers n'hi ha entre els venedors, però no tinc cap columna amb aquesta informació.

Evidentment una possibilitat és tenir una taula amb dues columnes: una que fes referència a l'edat i l'altra a la generació a la que pertany.

Però existeix una altra solució: l'expressió CASE.

L'expressió CASE que és molt potent i pot ser utilitzada en altres àmbits, aquí l'estudiem dintre de la clàusula SELECT.


## Sintaxi

Veiem com seria la query que em resoldria el problema anterior

```
SELECT num_empl, nom,
       CASE
       WHEN edat < 26 THEN 'Zoomer'
       WHEN edat < 42 THEN 'Millenial'
       WHEN edat < 58 THEN 'Generació X'
       ELSE 'Boomer' END AS generacio
  FROM rep_vendes;
```

Ordre que ens mostra:

```
 num_empl |      nom      |  generacio  
----------+---------------+-------------
      105 | Bill Adams    | Millenial
      109 | Mary Jones    | Millenial
      102 | Sue Smith     | Generació X
      106 | Sam Clark     | Generació X
      104 | Bob Smith     | Millenial
      101 | Dan Roberts   | Generació X
      110 | Tom Snyder    | Millenial
      108 | Larry Fitch   | Boomer
      103 | Paul Cruz     | Millenial
      107 | Nancy Angelli | Generació X
(10 rows)
```

Aquesta és una de les sintaxi de CASE: amb la comparació

```
CASE 
WHEN <condicio_1> THEN <resultat_1>
WHEN <condicio_2> THEN <resultat_2>
...
[ELSE <resultat_per_la_resta>] END
```

Però n'hi ha una altra manera de fer servir el CASE:

```
CASE <nom_de_columna>
WHEN <expressio_1> THEN <resultat_1>
WHEN <expressio_2> THEN <resultat_2>
...
[ELSE <resultat_per_la_resta>] END
```

Per exemple, imaginem que volem categoritzar les diferents quotes

```
SELECT nom, carrec,
       CASE quota
       WHEN 200000 THEN 'quota_baixa'
       WHEN 275000 THEN 'quota_semi_baixa'
       WHEN 300000 THEN 'quota_semi_alta'
       WHEN 350000 THEN 'quota_alta'
       ELSE 'sense quota' END AS tipus_quota
  FROM rep_vendes;
```

Ens mostraria:

```
      nom      |       carrec        |   tipus_quota    
---------------+---------------------+------------------
 Bill Adams    | Representant Vendes | quota_alta
 Mary Jones    | Representant Vendes | quota_semi_alta
 Sue Smith     | Representant Vendes | quota_alta
 Sam Clark     | VP Vendes           | quota_semi_baixa
 Bob Smith     | Dir Vendes          | quota_baixa
 Dan Roberts   | Representant Vendes | quota_semi_alta
 Tom Snyder    | Representant Vendes | sense quota
 Larry Fitch   | Dir Vendes          | quota_alta
 Paul Cruz     | Representant Vendes | quota_semi_baixa
 Nancy Angelli | Representant Vendes | quota_semi_alta
(10 rows)
```


L'expressió CASE es pot fer servir no només a la columna de selecció, sinó a moltes altres parts d'una consulta SELECT: ORDER BY, WHERE ...









