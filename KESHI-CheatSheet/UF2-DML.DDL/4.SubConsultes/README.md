# CHEATSHEET KESHI [05]

# Subconsultas 

* El uso de una subconsulta es para especificar.

* Es decir como ejemplo = "Qué empleados tienen una cuota superior a la cuota de Mary Jones?" 

  * Subconsulta = `¿Cuál es la cuota de Mary Jones?` = Se tiene que igualar con el input del SELECT.

```sql
SELECT camps separats per coma o expressions
FROM taula
WHERE camp operador (SELECT select_list
FROM taula);
```

* La subconsulta **s’executa una vegada** i **abans de la consulta principal**.

```sql
SELECT nom
FROM rep_vendes
WHERE quota >
  (SELECT quota
  FROM rep_vendes
  WHERE nom = 'Mary Jones');
```

```sql
nom
-------------
Bill Adams
Sue Smith
Larry Fitch
```

### Regles de les subconsultes

* Sempre tancada amb parèntesis.

* ➔ Ha d’aparèixer a la dreta de l’operador.

* ➔ No fer servir la clàusula ORDER BY a una subconsulta.

* ➔ Utilitzar operadors monoregistre quan la subconsulta retorni només una fila.

* ➔ Utilitzar operadors multiregistre quan la subconsulta retorni més d’una fila.


![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/tiposubcon.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/subconmono.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/subconmono0.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/subconmono1.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/subconmono2.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/subconmono3.png)

### Subconsulta con HAVING

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/having.png)

### El uso de IN / ANY / ALL

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/any.png)

*SE TIENE QUE USAR LOS OPERADORES DE ARRIBA*

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/in0.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/in1.png)

### IN

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ANY0.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ex1any.png)

### NOT IN

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ex2any.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ex2any0.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ex2any1.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ex2any2.png)

### ALL

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ex3any.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ex3any0.png)

### ANY

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ex4any.png)

#### EXERCICI5: 

* Mostreu els empleats que tenen **més vendes** que la **mitjana** de **vendes** de la seva oficina. 

* Llista el **nom**, **l’oficina**, les seves **vendes** i la **mitjana de la seva oficina**.

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/from.png)

#### EXERCICI4: 

* Mostreu els empleats que treballen a la **mateixa oficina** i que tenen el **mateix càrrec**.

* Pista: fes servir una subconsulta a la **clàusula FROM**

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/final.png)

----------------------------------------------------------------------------------

# RESUM SUBCONSULTES

## Subconsultes monoregistre

Retornen un únic valor (una única fila i columna)

Operadors: =, >, >=, <, <=, <>

> Llista els venedors tals que la seva oficina sigui Chicago

Amb JOIN:
```sql
SELECT nom
FROM rep_vendes
JOIN oficines
ON oficina_rep = oficina
WHERE ciutat = 'Chicago';
```

Amb subconsulta:
```sql
SELECT nom
FROM rep_vendes
WHERE oficina_rep = 
   (SELECT oficina
	  FROM oficines 
	 WHERE ciutat = 'Chicago');
```
						   
> Llista tots els venedors tals que les seves vendes siguin superiors a les
vendes de Sam Clark

```sql
SELECT nom
FROM rep_vendes
WHERE vendes >
       (SELECT vendes
	      FROM rep_vendes
         WHERE nom = 'Sam Clark');
```                        

> Llista els clients que les seves compres hagin superat el seu límit de crèdit.

```sql
SELECT empresa
  FROM clients
 WHERE limit_credit <
       (SELECT SUM(import)
          FROM comandes
         WHERE clie = num_clie);
```

## Subconsultes multiregistre

Retornen més d'un registre

Operadors: IN, op + ANY, op + ALL, EXISTS

### IN

_Alguna fila de la subconsulta coincideix amb el camp avaluat._
    
> Mostra els clients, el representant de vendes dels quals ha fet una comanda
superior a 10000.

```sql
SELECT empresa
  FROM clients
 WHERE rep_clie IN 
       (SELECT rep
          FROM comandes
         WHERE import > 10000);
```    
    
### op ANY

_Alguna fila de la subconsulta compleix la condició._
    
> Mostra els clients que el seu límit de crèdit és superior al 30% de la quota
d'algun representant de vendes.

```sql
SELECT empresa
  FROM clients
 WHERE limit_credit > ANY
       (SELECT 0.3 * quota
	     FROM rep_vendes);
```

### op ALL

_Totes les files de la subconsulta compleixen la condició._
    
> Mostra els clients el límit de crèdit dels quals és superior al 10% de les vendes
de tots els representant de vendes.

```sql
SELECT empresa
  FROM clients
 WHERE limit_credit > ALL
       (SELECT 0.1 * vendes
          FROM rep_vendes);
```

### EXISTS

_La subconsulta retorna algun resultat._
    
> Clients que han fet una comanda l'any 89.

```sql
SELECT empresa
  FROM clients
 WHERE EXISTS 
       (SELECT *
	      FROM comandes
         WHERE num_clie = clie
           AND DATE_PART( 'year', data) = 1989);
```

> Clients que no han fet cap comanda l'any 89.

```sql
SELECT empresa
  FROM clients
 WHERE NOT EXISTS
       (SELECT *
          FROM comandes
         WHERE num_clie = clie
           AND DATE_PART( 'year', data) = 1989);
```

---------------------------------------------------------------------------------

# Subconsultes EJERCICIO

## Exercici 0

Torna a fer l'exercici 4 de les diapositives de teoria de Subconsultes, però
ara fent servir GROUP BY i la funció de group STRING_AGG. Recordem que la
subconsulta era:

_Mostreu els empleats que treballen a la mateixa oficina i que tenen el mateix
càrrec._
  


```sql
SELECT STRING_AGG(nom, ',') AS noms, oficina_rep, carrec
  FROM rep_vendes
 GROUP BY oficina_rep, carrec
HAVING COUNT(num_empl) > 1 ;
```

```
         noms          | oficina_rep |       carrec
-----------------------+-------------+---------------------
 Dan Roberts,Paul Cruz |          12 | Representant Vendes
(1 row)
```



## Exercici 1

Llista els venedors que tinguin una quota igual o inferior a l'objectiu de
l'oficina de vendes d'Atlanta.

```sql
SELECT nom       
  FROM rep_vendes
 WHERE quota <=
       ( SELECT objectiu
           FROM oficines
          WHERE ciutat = 'Atlanta');
```
```
      nom      
---------------
 Bill Adams
 Mary Jones
 Sue Smith
 Sam Clark
 Bob Smith
 Dan Roberts
 Larry Fitch
 Paul Cruz
 Nancy Angelli
(9 rows)
```

## Exercici 2

Tots els clients, identificador i nom de l'empresa, que han estat atesos per
(que han fet comanda amb) Bill Adams.

```sql
SELECT DISTINCT num_clie, empresa 
  FROM clients
       JOIN comandes
       ON num_clie = clie
 WHERE rep =
       ( SELECT num_empl
           FROM rep_vendes
          WHERE nom = 'Bill Adams');
```

```sql
 num_clie |  empresa  
----------+-----------
     2103 | Acme Mfg.
     2111 | JCP Inc.
(2 rows)
```

Altres solucions:

```sql
SELECT DISTINCT num_clie, empresa
  FROM clients
       JOIN comandes
       ON clie = num_clie
       
       JOIN rep_vendes
       ON rep = num_empl
 WHERE nom = 'Bill Adams';
```
```sql
SELECT num_clie, empresa
FROM clients
WHERE num_clie IN
               (SELECT clie
                  FROM comandes
                 WHERE rep =
                       (SELECT num_empl
                          FROM rep_vendes
                         WHERE nom = 'Bill Adams'));
```

## Exercici 3

Venedors amb quotes que siguin iguals o superiors a l'objectiu de llur oficina
de vendes.


```sql
SELECT nom, quota, objectiu
  FROM rep_vendes
       JOIN oficines 
       ON oficina = oficina_rep
 WHERE quota >= objectiu;
```

```sql
      nom      |   quota   | objectiu  
---------------+-----------+-----------
 Bill Adams    | 350000.00 | 350000.00
 Nancy Angelli | 300000.00 | 300000.00
(2 rows)
```

Altres solucions:

```sql
SELECT nom, quota, objectiu
  FROM rep_vendes
       JOIN oficines 
       ON oficina = oficina_rep
 WHERE quota >= objectiu;
```

```sql
SELECT nom
  FROM rep_vendes
 WHERE quota >=
       (SELECT objectiu
          FROM oficines
         WHERE oficina = oficina_rep);
```

## Exercici 4

Mostrar l'identificador de l'oficina i la ciutat de les oficines on l'objectiu
de vendes de l'oficina excedeix la suma de quotes dels venedors d'aquella
oficina.

```sql
SELECT oficina, ciutat
  FROM oficines
 WHERE objectiu >
       (SELECT SUM(quota)
          FROM rep_vendes
         WHERE oficina_rep = oficina);
```

Fixem-nos que a la subcolsulta hi ha una referència externa (oficina)


```sql
 oficina |   ciutat    
---------+-------------
      12 | Chicago
      21 | Los Angeles
(2 rows)
```


## Exercici 5

Llista dels productes del fabricant amb identificador "aci" l'estoc dels quals
superen l'estoc del producte amb identificador de producte "41004" i
identificador de fabricant "aci".

```sql
SELECT id_producte, id_fabricant, descripcio
  FROM productes
 WHERE id_fabricant = 'aci'
   AND estoc >
       (SELECT estoc 
          FROM productes 
         WHERE (id_fabricant, id_producte) = ('aci','41004'));
```

```sql
 id_producte | id_fabricant |   descripcio    
-------------+--------------+-----------------
 41003       | aci          | Article Tipus 3
 41001       | aci          | Article Tipus 1
 41002       | aci          | Article Tipus 2
(3 rows)
```

## Exercici 6

Llistar els venedors que han acceptat una comanda que representa més del 10% de
la seva quota.

```sql
SELECT num_empl, nom
  FROM rep_vendes 
       JOIN comandes
       ON rep = num_empl
 WHERE import > 0.1 * quota;
```

```sql
 num_empl |      nom      
----------+---------------
      106 | Sam Clark
      108 | Larry Fitch
      107 | Nancy Angelli
(3 rows)
```

Altres maneres de fer el mateix

```sql
SELECT num_empl, nom
  FROM rep_vendes 
 WHERE quota * 0.1 < 
       ANY (SELECT import
              FROM comandes
             WHERE rep = num_empl);
```

I la _simètrica_:

```sql
SELECT DISTINCT rep
  FROM comandes
 WHERE import >
       (SELECT quota * 0.1
          FROM rep_vendes
         WHERE rep = num_empl);
```
(Sense els noms, només els identificadors)


## Exercici 7

Llistar el nom i l'edat de totes les persones de l'equip de vendes que no dirigeixen una oficina.

```sql
SELECT nom, edat
  FROM rep_vendes
WHERE num_empl NOT IN (SELECT director
                       FROM oficines);
```
Segur que està bé? No ho miris, pensa-ho, tens la solució a baix de tot.



## Exercici 8

Llistar aquelles oficines, i els seus objectius, els venedors de les quals
tenen unes vendes que superen el 50% de l'objectiu de l'oficina.

```sql
SELECT oficina, ciutat, objectiu
  FROM oficines
 WHERE 0.5 * objectiu < ALL
       (SELECT vendes
	      FROM rep_vendes
         WHERE oficina_rep= oficina);
```

```sql
 oficina |  ciutat  | objectiu  
---------+----------+-----------
      22 | Denver   | 300000.00
      11 | New York | 575000.00
      13 | Atlanta  | 350000.00
(3 rows)
```


## Exercici 9

Llistar aquells clients els representants de vendes dels quals estàn assignats
a oficines de la regió Est.

```sql
SELECT num_clie, empresa
  FROM clients                                   
       JOIN rep_vendes
       ON rep_clie = num_empl
       JOIN oficines 
	   ON oficina_rep = oficina
 WHERE regio = 'Est';
```

```sql
 num_clie |     empresa
----------+-----------------
     2111 | JCP Inc.
     2102 | First Corp.
     2103 | Acme Mfg.
     2115 | Smithson Corp.
     2101 | Jones Mfg.
     2121 | QMA Assoc.
     2108 | Holm & Landis
     2117 | J.P. Sinclair
     2122 | Three-Way Lines
     2119 | Solomon Inc.
     2113 | Ian & Schmidt
     2109 | Chen Associates
     2105 | AAA Investments
(13 rows)
```
```sql
SELECT num_clie, empresa
  FROM clients
 WHERE rep_clie IN
       (SELECT num_empl
          FROM rep_vendes
         WHERE oficina_rep IN
		       (SELECT oficina
			      FROM oficines
				 WHERE regio = 'Est'));
```

## Exercici 10

Llistar els venedors que treballen en oficines que superen el seu objectiu.

```sql
SELECT num_empl, nom 
  FROM rep_vendes
 WHERE oficina_rep IN 
       (SELECT oficina
	      FROM oficines
         WHERE vendes > objectiu);
```

```sql
 num_empl |     nom
----------+-------------
      105 | Bill Adams
      109 | Mary Jones
      102 | Sue Smith
      106 | Sam Clark
      108 | Larry Fitch
(5 rows)
```


## Exercici 11

Llistar els venedors que treballen en oficines que superen el seu objectiu.
Mostrar també les següents dades de l'oficina: ciutat i la diferència entre les
vendes i l'objectiu. Ordenar el resultat per aquest últim valor. Proposa dues
sentències SQL, una amb subconsultes i una sense.

```sql
SELECT num_empl, nom, ciutat, oficines.vendes - objectiu AS dif
  FROM rep_vendes 
       JOIN oficines
	   ON oficina_rep = oficina
 WHERE oficina_rep IN
       (SELECT oficina
	      FROM oficines
         WHERE vendes > objectiu)
 ORDER BY dif;
```
```sql
 num_empl |     nom     |   ciutat    |    dif
----------+-------------+-------------+-----------
      105 | Bill Adams  | Atlanta     |  17911.00
      102 | Sue Smith   | Los Angeles | 110915.00
      108 | Larry Fitch | Los Angeles | 110915.00
      109 | Mary Jones  | New York    | 117637.00
      106 | Sam Clark   | New York    | 117637.00
(5 rows)
```

```sql
SELECT num_empl, nom, ciutat, oficines.vendes - objectiu AS dif
  FROM rep_vendes 
       JOIN oficines
	   ON oficina_rep = oficina
 WHERE oficines.vendes > objectiu
 ORDER BY dif;
```

## Exercici 12

Llista els venedors que no treballen en oficines dirigides per Larry Fitch, o
que no treballen a cap oficina. Sense usar consultes multitaula.

```sql
SELECT num_empl, nom 
  FROM rep_vendes
 WHERE oficina_rep IS NULL
    OR oficina_rep NOT IN 
	   (SELECT oficina 
          FROM oficines 
         WHERE director =
		       (SELECT num_empl 
                  FROM rep_vendes 
                 WHERE nom = 'Larry Fitch'));
```

```sql
 num_empl |     nom
----------+-------------
      105 | Bill Adams
      109 | Mary Jones
      106 | Sam Clark
      104 | Bob Smith
      101 | Dan Roberts
      110 | Tom Snyder
      103 | Paul Cruz
(7 rows)
```

## Exercici 13

Llista els venedors que no treballen en oficines dirigides per Larry Fitch, o
que no treballen a cap oficina. Mostrant també la ciutat de l'oficina on
treballa l'empleat i l'identificador del director de la oficina. Proposa dues
sentències SQL, una amb subconsultes i una sense.

```sql
SELECT num_empl, nom, ciutat 
  FROM rep_vendes 
       JOIN oficines
	   ON oficina_rep = oficina
 WHERE oficina_rep IS NULL
    OR oficina_rep NOT IN
	   (SELECT oficina 
          FROM oficines 
         WHERE director =
		       (SELECT num_empl
			      FROM rep_vendes 
                 WHERE nom = 'Larry Fitch'));
```

```sql
 num_empl |     nom     |  ciutat
----------+-------------+----------
      105 | Bill Adams  | Atlanta
      109 | Mary Jones  | New York
      106 | Sam Clark   | New York
      104 | Bob Smith   | Chicago
      101 | Dan Roberts | Chicago
      103 | Paul Cruz   | Chicago
(6 rows)
```

```sql
SELECT e.num_empl, e.nom, ciutat 
  FROM rep_vendes e 
       JOIN oficines
	   ON oficina_rep = oficina 

       JOIN rep_vendes d
	   ON director = d.num_empl
 WHERE e.oficina_rep IS NULL
    OR d.nom <> 'Larry Fitch';
```

## Exercici 14

Llista tots els clients que han realitzat comandes del productes de la família
ACI Widgets entre gener i juny del 1990. Els productes de la famíla ACI Widgets
són aquells que tenen identificador de fabricant "aci" i que l'identificador
del producte comença per "4100".

```sql
SELECT empresa
  FROM clients
 WHERE num_clie IN
       (SELECT DISTINCT clie
          FROM comandes
         WHERE fabricant = 'aci'
           AND producte LIKE '4100%'
           AND data BETWEEN '1990-01-01' AND '1990-06-30');
```
```sql
      empresa      
-------------------
 Acme Mfg.
 Ace International
 Holm & Landis
 JCP Inc.
(4 rows)
```

```sql
SELECT DISTINCT empresa
  FROM comandes 
       JOIN clients
	   ON num_clie = clie
 WHERE fabricant = 'aci'
   AND producte LIKE '4100%' 
   AND data BETWEEN '1990-01-01' AND '1990-06-30';
```

## Exercici 15

Llista els clients que no tenen cap comanda.

```sql
SELECT empresa
  FROM clients
 WHERE num_clie NOT IN
       (SELECT clie
	      FROM comandes);
```

```sql
     empresa
-----------------
 Carter & Sons
 Smithson Corp.
 QMA Assoc.
 Three-Way Lines
 Solomon Inc.
 AAA Investments
(6 rows)
```


## Exercici 16

Llista els clients que tenen assignat el venedor que porta més temps
contractat.

```sql
SELECT empresa
  FROM clients
 WHERE rep_clie =
       (SELECT num_empl
	      FROM rep_vendes 
         WHERE data_contracte =
		       (SELECT MIN(data_contracte)
			      FROM rep_vendes));
```
```sql
     empresa     
-----------------
 First Corp.
 Smithson Corp.
 AAA Investments
(3 rows)
```


## Exercici 17

Llista els clients assignats a Sue Smith que no han fet cap comanda amb un
import superior a 30000. Proposa una sentència SQL sense usar multitaula i una
altre en que s'usi multitaula i subconsultes.



```sql
SELECT empresa
  FROM clients 
 WHERE rep_clie =
       (SELECT num_empl 
          FROM rep_vendes
         WHERE nom = 'Sue Smith') 
       
   AND NOT EXISTS
	   (SELECT num_comanda 
          FROM comandes
         WHERE clie = num_clie
           AND import > 30000);
```
```sql
     empresa      
------------------
 Carter & Sons
 Orion Corp
 Rico Enterprises
 Fred Lewis Corp.
(4 rows)
```


```sql
SELECT empresa
  FROM clients 
       JOIN rep_vendes
	   ON rep_clie = num_empl 
 WHERE nom = 'Sue Smith' 
   AND NOT EXISTS
	   (SELECT num_comanda 
          FROM comandes
         WHERE clie = num_clie
           AND import > 30000);
```

## Exercici 18

Llista l'identificador i el nom dels directors d'empleats que tenen més de 40
anys i que dirigeixen un venedor que té unes vendes superiors a la seva pròpia
quota.

```sql
SELECT nom 
  FROM rep_vendes 
 WHERE edat > 40
   AND num_empl IN
	   (SELECT cap 
          FROM rep_vendes 
         WHERE vendes > quota);
```
```sql
     nom
-------------
 Sam Clark
 Larry Fitch
(2 rows)
```

## Exercici 19

Llista d'oficines on hi hagi algun venedor tal que la seva quota representi més
del 50% de l'objectiu de l'oficina

```sql
SELECT ciutat 
  FROM oficines
WHERE objectiu * 0.5 < ANY
      (SELECT quota
	     FROM rep_vendes 
        WHERE oficina_rep = oficina);
```
```sql
  ciutat
----------
 Denver
 New York
 Atlanta
(3 rows)
```


## Exercici 20

Llista d'oficines on tots els venedors tinguin la seva quota superior al 55% de
l'objectiu de l'oficina.

```sql
SELECT ciutat 
  FROM oficines
 WHERE objectiu * 0.55 < ALL
       (SELECT quota
	      FROM rep_vendes 
         WHERE oficina_rep = oficina);
```
```sql
 ciutat
---------
 Denver
 Atlanta
(2 rows)
```

## Exercici 21

Transforma el següent JOIN a una comanda amb subconsultes:

```sql
SELECT num_comanda, import, clie, num_clie, limit_credit
  FROM comandes
       JOIN clients
       ON clie = num_clie;
```

```sql
 num_comanda |  import  | clie | num_clie | limit_credit
-------------+----------+------+----------+--------------
      112961 | 31500.00 | 2117 |     2117 |     35000.00
      113012 |  3745.00 | 2111 |     2111 |     50000.00
...
      112987 | 27500.00 | 2103 |     2103 |     50000.00
      113057 |   600.00 | 2111 |     2111 |     50000.00
      113042 | 22500.00 | 2113 |     2113 |     20000.00
(30 rows)
```





```sql
SELECT num_comanda, import, clie, 
       (SELECT num_clie
          FROM clients
         WHERE clie = num_clie), 
       (SELECT limit_credit
          FROM clients
         WHERE clie = num_clie) 
FROM comandes;
```

## Exercici 22

Transforma el següent JOIN a una comanda amb subconsultes:

```sql
SELECT empl.nom, empl.quota, cap.nom, cap.quota
  FROM rep_vendes AS empl
       JOIN rep_vendes AS cap
       ON empl.cap = cap.num_empl
 WHERE empl.quota > cap.quota;
```

```sql
     nom     |   quota   |    nom    |   quota   
-------------+-----------+-----------+-----------
 Bill Adams  | 350000.00 | Bob Smith | 200000.00
 Mary Jones  | 300000.00 | Sam Clark | 275000.00
 Dan Roberts | 300000.00 | Bob Smith | 200000.00
 Larry Fitch | 350000.00 | Sam Clark | 275000.00
 Paul Cruz   | 275000.00 | Bob Smith | 200000.00
(5 rows)
```

```sql
SELECT empl.nom, empl.quota, 
       (SELECT dir.nom 
          FROM rep_vendes dir
         WHERE empl.cap = dir.num_empl), 
       (SELECT dir.quota
          FROM rep_vendes dir
         WHERE empl.cap = dir.num_empl)
  FROM rep_vendes empl
 WHERE empl.quota >
       (SELECT dir.quota
          FROM rep_vendes dir
         WHERE empl.cap = dir.num_empl);
```

## Exercici 23

Transforma la següent consulta amb un ANY a una consulta amb un EXISTS i també
en una altre consulta amb un ALL:

```sql
SELECT oficina
  FROM oficines
 WHERE vendes * 0.8 < ANY 
       (SELECT vendes
          FROM rep_vendes
         WHERE oficina_rep = oficina);
```

```sql
 oficina 
---------
      22
      13
(2 rows)
```


```sql
SELECT oficina
  FROM oficines 
 WHERE EXISTS
       (SELECT *
          FROM rep_vendes
         WHERE oficina_rep = oficina
           AND oficines.vendes * 0.8 < rep_vendes.vendes);
```
   
```sql
SELECT oficina
  FROM oficines
 WHERE NOT vendes * 0.8 >= ALL
       (SELECT vendes
          FROM rep_vendes
         WHERE oficina_rep = oficina);
```
   
## Exercici 24

Transforma la següent consulta amb un ALL a una consulta amb un EXISTS i també
en una altre consulta amb un ANY:

```sql
SELECT num_clie
  FROM clients
 WHERE limit_credit < ALL
       (SELECT import
          FROM comandes
         WHERE num_clie = clie);
```

```sql
 num_clie 
----------
     2123
     2115
     2121
     2122
     2119
     2113
     2109
     2105
(8 rows)
```

```sql
SELECT num_clie
  FROM clients
 WHERE NOT limit_credit >= ANY
       (SELECT import
          FROM comandes
         WHERE num_clie = clie);
```
```sql
SELECT num_clie
  FROM clients
 WHERE NOT EXISTS 
       (SELECT *
          FROM comandes
         WHERE num_clie = clie
           AND import <= limit_credit);
```

## Exercici 25

Transforma la següent consulta amb un EXISTS a una consulta amb un ALL i també
a una altre consulta amb un ANY:

```sql
SELECT num_clie, empresa
  FROM clients
 WHERE EXISTS
       (SELECT *
          FROM rep_vendes
         WHERE rep_clie = num_empl
           AND edat BETWEEN 40 AND 50);
```

```sql
 num_clie |      empresa      
----------+-------------------
     2102 | First Corp.
     2123 | Carter & Sons
     2107 | Ace International
     2115 | Smithson Corp.
     2114 | Orion Corp
     2124 | Peter Brothers
     2120 | Rico Enterprises
     2106 | Fred Lewis Corp.
     2105 | AAA Investments
(9 rows)
```
```sql
SELECT num_clie, empresa
  FROM clients
 WHERE rep_clie = ANY
       (SELECT num_empl
          FROM rep_vendes
         WHERE edat BETWEEN 40 AND 50);
```

```sql
SELECT num_clie, empresa
  FROM clients
 WHERE NOT rep_clie <> ALL
       (SELECT num_empl
          FROM rep_vendes
         WHERE edat BETWEEN 40 AND 50);
```

## Exercici 26

Transforma la següent consulta amb subconsultes a una consulta sense
subconsultes.

```sql
SELECT *
  FROM productes
 WHERE id_fabricant IN 
       (SELECT fabricant
          FROM comandes
         WHERE quantitat > 30)
   AND id_producte IN 
       (SELECT producte
          FROM comandes
         WHERE quantitat > 30);
```

```sql
 id_fabricant | id_producte |   descripcio    |  preu  | estoc 
--------------+-------------+-----------------+--------+-------
 aci          | 41003       | Article Tipus 3 | 107.00 |   207
 aci          | 41004       | Article Tipus 4 | 117.00 |   139
 aci          | 41002       | Article Tipus 2 |  76.00 |   167
(3 rows)
```
```sql
SELECT productes.*
  FROM productes
       JOIN comandes
       ON productes.id_fabricant = comandes.fabricant
           AND productes.id_producte = comandes.producte
 WHERE quantitat > 30;
```

## Exercici 27

Transforma la següent consulta amb subconsultes a una consulta sense
subconsultes.

```sql
SELECT num_empl, nom
  FROM rep_vendes
 WHERE num_empl = ANY 
       (SELECT rep_clie
          FROM clients
         WHERE empresa LIKE '%Inc.');
```
```sql
 num_empl |    nom     
----------+------------
      109 | Mary Jones
      103 | Paul Cruz
(2 rows)
```



```sql
SELECT num_empl, nom
  FROM rep_vendes
       JOIN clients
       ON rep_vendes.num_empl = clients.rep_clie
 WHERE empresa LIKE '%Inc.';
```

## Exercici 28

Transforma la següent consulta amb un IN a una consulta amb un EXISTS i també a
una altre consulta amb un ALL.

```sql
SELECT num_empl, nom
  FROM rep_vendes
 WHERE num_empl IN
       (SELECT cap
          FROM rep_vendes);
```

```sql
 num_empl |     nom     
----------+-------------
      106 | Sam Clark
      104 | Bob Smith
      101 | Dan Roberts
      108 | Larry Fitch
(4 rows)
```

```sql
SELECT num_empl, nom
  FROM rep_vendes empl
 WHERE EXISTS
       (SELECT *
          FROM rep_vendes
         WHERE cap = empl.num_empl);
```


```sql
SELECT num_empl, nom
  FROM rep_vendes
 WHERE NOT num_empl <> ALL 
       (SELECT cap
          FROM rep_vendes);
```

## Exercici 29

Modifica la següent consulta perquè mostri la ciutat de l'oficina, proposa una
consulta simplificada.

```sql
SELECT num_comanda
  FROM comandes
 WHERE rep IN
       (SELECT num_empl
          FROM rep_vendes
         WHERE vendes >
               (SELECT AVG(vendes)
                  FROM rep_vendes)
           AND oficina_rep IN
               (SELECT oficina
                  FROM oficines
                 WHERE LOWER(regio) LIKE 'est') );
```

```sql
 num_comanda 
-------------
      112961
      113012
      112989
      112968
      112963
      113058
      112983
      113027
      113055
      113003
      112987
      113042
(12 rows)
```

Comandes fetes per venedors que les seves vendes siguin superiors a la mitja de
totes les vendes i que treballin a oficines de la regió Est.

```sql
SELECT num_comanda, ciutat
  FROM comandes
       JOIN rep_vendes
       ON rep = num_empl

       JOIN oficines
       ON oficina_rep = oficina
 WHERE rep_vendes.vendes >
       (SELECT AVG(vendes)
          FROM rep_vendes)
   AND LOWER(regio) LIKE 'est';
```
```sql
 num_comanda |  ciutat  
-------------+----------
      112961 | New York
      113012 | Atlanta
      112989 | New York
      112968 | Chicago
      112963 | Atlanta
      113058 | New York
      112983 | Atlanta
      113027 | Atlanta
      113055 | Chicago
      113003 | New York
      112987 | Atlanta
      113042 | Chicago
(12 rows)
```
## Exercici 30

Transforma la següent consulta amb subconsultes a una consulta amb les mínimes
subconsultes possibles.

```sql
SELECT num_clie, empresa,
       (SELECT nom
          FROM rep_vendes
         WHERE rep_clie = num_empl) AS rep_nom
  FROM clients
 WHERE rep_clie = ANY
       (SELECT num_empl
          FROM rep_vendes
         WHERE vendes >
               (SELECT MAX(quota)
                  FROM rep_vendes));
```

```sql
 num_clie |     empresa      |     nom     
----------+------------------+-------------
     2103 | Acme Mfg.        | Bill Adams
     2123 | Carter & Sons    | Sue Smith
     2112 | Zetacorp         | Larry Fitch
     2114 | Orion Corp       | Sue Smith
     2108 | Holm & Landis    | Mary Jones
     2122 | Three-Way Lines  | Bill Adams
     2120 | Rico Enterprises | Sue Smith
     2106 | Fred Lewis Corp. | Sue Smith
     2119 | Solomon Inc.     | Mary Jones
     2118 | Midwest Systems  | Larry Fitch
(10 rows)
```

```sql
SELECT num_clie, empresa, nom
  FROM clients
       JOIN rep_vendes
       ON rep_clie = num_empl
 WHERE vendes >
       (SELECT MAX(quota)
          FROM rep_vendes);
```

## Extres

+ Exercici 7:
```sql
SELECT num_empl, nom, edat
  FROM rep_vendes
 WHERE num_empl NOT IN
       (SELECT director
          FROM oficines
         WHERE director IS NOT NULL);
```

Si no imposo aquesta condició no surt cap empleat, ja que falla una de les
condicions, la de l'oficina sense director, en una expressió composta per AND's
( `num_empl != NULL`)

```sql
 num_empl |      nom      | edat 
----------+---------------+------
      109 | Mary Jones    |   31
      102 | Sue Smith     |   48
      101 | Dan Roberts   |   45
      110 | Tom Snyder    |   41
      103 | Paul Cruz     |   29
      107 | Nancy Angelli |   49
(6 rows)
```