# CHEATSHEET KESHI [09]

# CASE - ESTRUCTURA CONTROL

## CASE Expression

## Problema

De vegades necessitem categoritzar per un criteri que no és cap de les nostres columnes. 

Pensem per exemple en la taula rep_vendes, vull comptar quants boomers, millenials o zoomers n'hi ha entre els venedors, però no tinc cap columna amb aquesta informació.

Evidentment una possibilitat és tenir una taula amb dues columnes: una que fes referència a l'edat i l'altra a la generació a la que pertany.

Però existeix una altra solució: l'expressió CASE.

L'expressió CASE que és molt potent i pot ser utilitzada en altres àmbits, aquí l'estudiem dintre de la clàusula SELECT.


## Sintaxi

Veiem com seria la query que em resoldria el problema anterior

```SQL
SELECT num_empl, nom,
       CASE
       WHEN edat < 26 THEN 'Zoomer'
       WHEN edat < 42 THEN 'Millenial'
       WHEN edat < 58 THEN 'Generació X'
       ELSE 'Boomer' END AS generacio
  FROM rep_vendes;
```

Ordre que ens mostra:

```SQL
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

```SQL
CASE 
WHEN <condicio_1> THEN <resultat_1>
WHEN <condicio_2> THEN <resultat_2>
...
[ELSE <resultat_per_la_resta>] END
```

Però n'hi ha una altra manera de fer servir el CASE:

```SQL
CASE <nom_de_columna>
WHEN <expressio_1> THEN <resultat_1>
WHEN <expressio_2> THEN <resultat_2>
...
[ELSE <resultat_per_la_resta>] END
```

Per exemple, imaginem que volem categoritzar les diferents quotes

```SQL
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

```SQL
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

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# 03.03.22 - SQL CASE

## CASE 

Suple la parte de programación que no tiene SQL

* CASE = IF = Condicional

* Estructura de control de un lenguaje de programación.

1. Se pone el campo "quota" --> case = quota when ... then ...
```sql
SELECT num_empl, nom,
       CASE
       WHEN edat < 26 THEN 'Zoomer'
       WHEN edat < 42 THEN 'Millenial'
       WHEN edat < 58 THEN 'Generació X'
       ELSE 'Boomer' END AS generacio
  FROM rep_vendes;
```
* Solo se pone una variable y diferentes valores.

2. O case when (edat < 26) CONDICIO then .... 

3. El case es un **campo calculado**.

4. 

JOIN SUMA / AUMENTA COLUMNAS

UNION AUMENTA FILAS SIN REPETIR / UNION ALL COPIA TODO Y CON REPETIDOS

Con el UNION aumentamos filas --> SELECT nom UNION


**IDENTIFICADO DE FILTRADO** --> *CAMPO DISCRIMINATORIO*

```SQL
CREATE OR REPLACE VIEW grounInf AS

SELECT nom, telef, 'profe' AS TIPUS
FROM profes
WHERE group = '2mj'
```

> UNION - JUNTA LAS FILAS NO SE REPITE SOLO SALE 1 VEZ

> UNION ALL - JUNTA TODAS LAS FILAS AUNQUE SE REPITA

```SQL
SELECT nom, telefon, 'alumne' TIPUS
FROM alumnes
```
'alumne'




**CREATE OR REPLACE FORCE VIEW** - FUERZA UNA VISTA AUNQUE NO EXISTA UNA TABLA.

LAS VISTAS SE PUEDEN PONER ANTES DESPUÉS DEL NOMBRE O DESPUÉS EN EL SELECT

ANTES:

CREATE OR REPLACE VIEW nombre () AS SELECT ....

> NVL --> NULL VALUE --> COALESCE



> IN ES COMO UN BETWEEN

> TRUNC


> TO_CHAR

> TO_DATE


```sql
SELECT nom, carrec, 

    CASE oficina_rep FROM rep_vendes;

    
```