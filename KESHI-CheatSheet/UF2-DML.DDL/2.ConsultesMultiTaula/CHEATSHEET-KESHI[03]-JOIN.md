# CHEATSHEET KESHI [03]

# JOIN

* Utilitzem la clàusula JOIN per a consultar dades que es troben en més d’una taula.

* És una reunió o composició de les files d’una taula amb les d’una altra.

```sql
SELECT taula1.columna1, taula2.columna2
FROM taula1 [INNER] JOIN taula2
ON taula1.clau_forana = taula2.clau_primaria;
```

### CROSS JOIN

* Producto cartesiano - Forma explícita o implícita

* Se unen campos de dos tablas o más tablas.

### INNER JOIN O WHERE

`JOIN` sólo se produce cuando las filas cumplen con la clausula `ON`

`FORMA EXPLÍCITA`

```sql
SELECT * FROM propietaris INNER JOIN gats 
ON gats.propietari = propietaris.id;
```

`FORMA EMPLÍCITA`

```sql
SELECT * FROM propietaris, gats WHERE gats.propietari = propietaris.id;
```

#### ALIAS

* Ayudan a simplificar

```sql
SELECT e.empno, e.ename, e.deptno,
d.deptno, d.loc
FROM emp e JOIN dept d
ON e.deptno = d.deptno;
```


### OUTER JOIN

S’utilitza per afegir, al resultat, les files de la taula
que vulguem (left, right o les dues) que
NO acompleixen la condició del JOIN.
● Left join
● Rigth join*
● Full join

```sql
SELECT taula1.columna1, taula2.columna2
FROM taula1 LEFT [OUTER] JOIN taula2
ON taula1.clau_forana = taula2.clau_primaria;
```


```sql
SELECT taula1.columna1, taula2.columna2
FROM taula1 RIGHT [OUTER] JOIN taula2
ON taula1.clau_forana = taula2.clau_primaria;
```

*  Un RIGHT JOIN sempre es pot expressar com un LEFT JOIN,

* És suficient canviar l’ordre de les taules, però quan hi ha més de dues taules podria resultar + còmode no canviar-ho.



#### LEFT JOIN




#### RIGHT JOIN



#### FULL JOIN



----------------------------------------------------------------------------------

**EJEMPLOS**


# Consultes multitaula

## Exercici 1

Llista la ciutat de les oficines, i el nom i càrrec dels directors de cada oficina.

```sql
SELECT ciutat, nom, carrec
  FROM oficines
       JOIN rep_vendes
       ON oficines.director = rep_vendes.num_empl;
```
```sql
   ciutat    |     nom     |       carrec        
-------------+-------------+---------------------
 Denver      | Larry Fitch | Dir Vendes
 New York    | Sam Clark   | VP Vendes
 Chicago     | Bob Smith   | Dir Vendes
 Atlanta     | Bill Adams  | Representant Vendes
 Los Angeles | Larry Fitch | Dir Vendes
```

Però clar, segur que aquesta és tota la informació que ens demanen? Podria ser
que hi hagués un oficina sense director? La resposta és sí:

```sql
\d oficines
                      Table "public.oficines"
  Column  |         Type          | Collation | Nullable |
----------+-----------------------+-----------+----------+...
 oficina  | smallint              |           | not null | 
 ciutat   | character varying(15) |           | not null | 
 regio    | character varying(10) |           | not null | 
 director | smallint              |           |          | <==
 objectiu | numeric(9,2)          |           |          | 
 vendes   | numeric(9,2)          |           |          | 
```

De manera que és interessant veure totes les oficines, i que es vegi si n'hi ha
alguna sense director:

```sql
SELECT ciutat, nom, carrec
  FROM oficines
       LEFT JOIN rep_vendes
       ON  oficines.director = rep_vendes.num_empl ;
```

```sql
   ciutat    |     nom     |       carrec        
-------------+-------------+---------------------
 Denver      | Larry Fitch | Dir Vendes
 New York    | Sam Clark   | VP Vendes
 Chicago     | Bob Smith   | Dir Vendes
 Atlanta     | Bill Adams  | Representant Vendes
 Los Angeles | Larry Fitch | Dir Vendes
(5 rows)
```

## Exercici 2

Llista totes les comandes mostrant el seu número, import, número de client i límit de crèdit.

```sql
SELECT num_comanda, import, empresa, limit_credit
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie;
```

```
 num_comanda |  import  |      empresa      | limit_credit 
-------------+----------+-------------------+--------------
      112961 | 31500.00 | J.P. Sinclair     |     35000.00
      113012 |  3745.00 | JCP Inc.          |     50000.00
      112989 |  1458.00 | Jones Mfg.        |     65000.00
      113051 |  1420.00 | Midwest Systems   |     60000.00
      112968 |  3978.00 | First Corp.       |     65000.00
      110036 | 22500.00 | Ace International |     35000.00
      113045 | 45000.00 | Zetacorp          |     50000.00
      112963 |  3276.00 | Acme Mfg.         |     50000.00
      113013 |   652.00 | Midwest Systems   |     60000.00
      113058 |  1480.00 | Holm & Landis     |     55000.00
      112997 |   652.00 | Peter Brothers    |     40000.00
      112983 |   702.00 | Acme Mfg.         |     50000.00
      113024 |  7100.00 | Orion Corp        |     20000.00
      113062 |  2430.00 | Peter Brothers    |     40000.00
      112979 | 15000.00 | Orion Corp        |     20000.00
      113027 |  4104.00 | Acme Mfg.         |     50000.00
      113007 |  2925.00 | Zetacorp          |     50000.00
      113069 | 31350.00 | Chen Associates   |     25000.00
      113034 |   632.00 | Ace International |     35000.00
      112992 |   760.00 | Midwest Systems   |     60000.00
      112975 |  2100.00 | JCP Inc.          |     50000.00
      113055 |   150.00 | Holm & Landis     |     55000.00
      113048 |  3750.00 | Rico Enterprises  |     50000.00
      112993 |  1896.00 | Fred Lewis Corp.  |     65000.00
      113065 |  2130.00 | Fred Lewis Corp.  |     65000.00
      113003 |  5625.00 | Holm & Landis     |     55000.00
      113049 |   776.00 | Midwest Systems   |     60000.00
      112987 | 27500.00 | Acme Mfg.         |     50000.00
      113057 |   600.00 | JCP Inc.          |     50000.00
      113042 | 22500.00 | Ian & Schmidt     |     20000.00
(30 rows)
```

Aquí no es pot donar el mateix cas d'abans, ja que les comandes tenen totes el
camp _clie_ amb _not null_.

## Exercici 3

Llista el número de totes les comandes amb la descripció del producte demanat.

```sql
SELECT num_comanda, descripcio
  FROM comandes
       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte;
```

```sql
 num_comanda |     descripcio     
-------------+--------------------
      112961 | Frontissa Esq.
      113012 | Article Tipus 3
      112989 | Bancada Motor
      112968 | Article Tipus 4
      110036 | Muntador
      113045 | Frontissa Dta.
      112963 | Article Tipus 4
      113013 | Manovella
      113058 | Coberta
      112997 | Manovella
      112983 | Article Tipus 4
      113024 | Reductor
      113062 | Bancada Motor
      112979 | Muntador
      113027 | Article Tipus 2
      113007 | Riosta 1/2-Tm
      113069 | Riosta 1-Tm
      113034 | V Stago Trinquet
      112992 | Article Tipus 2
      112975 | Passador Frontissa
      113055 | Peu de rei
      113048 | Riosta 2-Tm
      112993 | V Stago Trinquet
      113065 | Reductor
      113003 | Riosta 2-Tm
      113049 | Reductor
      112987 | Extractor
      113057 | Peu de rei
      113042 | Frontissa Dta.
(29 rows)
```

Trobes quelcom estrany?

En efecte només surten 29 en comptes de 30, en trobar una inconsistència a la
base de dades: un dels productes que surten a una comanda no el venem! Això és
perquè hi ha una errada en l'entrada d'informació. Aquesta errada es podria
haver evitat amb una senzilla regla a la taula. Més endavant resoldrem aquest
problema.

Si la taula no contingués aquest error, una consulta INNER JOIN seria la resposta aquí però com que no és el cas, necessitem un LEFT JOIN perquè sorti aquesta comanda amb el producte fantasma.


## Exercici 4

Llista el nom de tots els clients amb el nom del representant de vendes assignat.

```sql
SELECT empresa, nom
  FROM clients
       JOIN rep_vendes
       ON clients.rep_clie = rep_vendes.num_empl;
```
```sql
      empresa      |      nom      
-------------------+---------------
 JCP Inc.          | Paul Cruz
 First Corp.       | Dan Roberts
 Acme Mfg.         | Bill Adams
 Carter & Sons     | Sue Smith
 Ace International | Tom Snyder
 Smithson Corp.    | Dan Roberts
 Jones Mfg.        | Sam Clark
 Zetacorp          | Larry Fitch
 QMA Assoc.        | Paul Cruz
 Orion Corp        | Sue Smith
 Peter Brothers    | Nancy Angelli
 Holm & Landis     | Mary Jones
 J.P. Sinclair     | Sam Clark
 Three-Way Lines   | Bill Adams
 Rico Enterprises  | Sue Smith
 Fred Lewis Corp.  | Sue Smith
 Solomon Inc.      | Mary Jones
 Midwest Systems   | Larry Fitch
 Ian & Schmidt     | Bob Smith
 Chen Associates   | Paul Cruz
 AAA Investments   | Dan Roberts
(21 rows)
```

## Exercici 5

Llista la data de totes les comandes amb el numero i nom del client de la comanda.

```sql
SELECT data, num_clie, empresa
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie; 
```
```
    data    | num_clie |      empresa      
------------+----------+-------------------
 1989-12-17 |     2117 | J.P. Sinclair
 1990-01-11 |     2111 | JCP Inc.
 1990-01-03 |     2101 | Jones Mfg.
 1990-02-10 |     2118 | Midwest Systems
 1989-10-12 |     2102 | First Corp.
 1990-01-30 |     2107 | Ace International
 1990-02-02 |     2112 | Zetacorp
 1989-12-17 |     2103 | Acme Mfg.
 1990-01-14 |     2118 | Midwest Systems
 1990-02-23 |     2108 | Holm & Landis
 1990-01-08 |     2124 | Peter Brothers
 1989-12-27 |     2103 | Acme Mfg.
 1990-01-20 |     2114 | Orion Corp
 1990-02-24 |     2124 | Peter Brothers
 1989-10-12 |     2114 | Orion Corp
 1990-01-22 |     2103 | Acme Mfg.
 1990-01-08 |     2112 | Zetacorp
 1990-03-02 |     2109 | Chen Associates
 1990-01-29 |     2107 | Ace International
 1989-11-04 |     2118 | Midwest Systems
 1989-12-12 |     2111 | JCP Inc.
 1990-02-15 |     2108 | Holm & Landis
 1990-02-10 |     2120 | Rico Enterprises
 1989-01-04 |     2106 | Fred Lewis Corp.
 1990-02-27 |     2106 | Fred Lewis Corp.
 1990-01-25 |     2108 | Holm & Landis
 1990-02-10 |     2118 | Midwest Systems
 1989-12-31 |     2103 | Acme Mfg.
 1990-02-18 |     2111 | JCP Inc.
 1990-02-02 |     2113 | Ian & Schmidt
(30 rows)
```

## Exercici 6

Llista les oficines, noms i títols del seus directors amb un objectiu superior a 600.000.

```sql
SELECT oficina, nom, carrec, objectiu
  FROM oficines
       JOIN rep_vendes
       ON oficines.director = rep_vendes.num_empl
 WHERE oficines.objectiu > 600000;	
```

```
 oficina |     nom     |   carrec   | objectiu  
---------+-------------+------------+-----------
      12 | Bob Smith   | Dir Vendes | 800000.00
      21 | Larry Fitch | Dir Vendes | 725000.00
(2 rows)
```

Mateix cas que a la consulta de l'exercici 1, com el camp _director_ de la
taula _oficines_ pot ser null, podriem estar interessats en mostrar totes les
oficines, fins i tot les que no tenenen director:

```sql
SELECT  oficina, nom, carrec, objectiu
  FROM  oficines
        LEFT JOIN rep_vendes
        ON oficines.director = rep_vendes.num_empl
 WHERE  oficines.objectiu > 600000;
```

Bastaria afegir una oficina sense director per veure la diferència:

```sql
INSERT INTO oficines VALUES(88, 'Vielha', 'Vathd''Aran', NULL, 700000, 666000);
```

## Exercici 7

Llista els venedors de les oficines de la regió est.

```sql
SELECT nom, ciutat
  FROM rep_vendes
       JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina
 WHERE regio = 'Est';
```

```
     nom     |  ciutat  
-------------+----------
 Bill Adams  | Atlanta
 Mary Jones  | New York
 Sam Clark   | New York
 Bob Smith   | Chicago
 Dan Roberts | Chicago
 Paul Cruz   | Chicago
```


Si mirem la taula de venedors _rep_vendes_ veurem que el camp _oficina_rep_ pot
ser NULL, però aquí no té sentit afegir aquests casos, ja que la consulta és
clara, _volem els treballadors que siguin de l'oficina 'Est'_, això obliga a
que el treballador tingui alguna oficina assignada.

## Exercici 8

Llista les comandes superiors a 25000, incloent el nom del venedor que va
servir la comanda i el nom del client que el va sol·licitar.

```sql
SELECT nom, empresa, import
  FROM comandes
       JOIN rep_vendes
       ON comandes.rep = rep_vendes.num_empl

       JOIN clients
       ON comandes.clie = clients.num_clie
 WHERE import > 25000;  
```

```
 num_comanda |      nom      |     empresa     |  import  
-------------+---------------+-----------------+----------
      112961 | Sam Clark     | J.P. Sinclair   | 31500.00
      113045 | Larry Fitch   | Zetacorp        | 45000.00
      113069 | Nancy Angelli | Chen Associates | 31350.00
      112987 | Bill Adams    | Acme Mfg.       | 27500.00
(4 rows)
```

Però com la taula _comandes_ pot tenir com a NULL el camp _rep_ hauríem de fer
un OUTER JOIN mirant a quin costat es troba la taula que pot tenir un NULL.
Afegim una comanda sense venedor a la taula comandes per comprovar la
diferència de resultats.

```sql
INSERT INTO comandes VALUES ( 88888, '2021-11-11', 2111, NULL, 'vi', 'Bages', 2600, 26000);
```

```sql
SELECT num_comanda, nom, empresa, import
  FROM comandes
       LEFT JOIN rep_vendes
       ON comandes.rep = rep_vendes.num_empl

       JOIN clients
       ON comandes.clie = clients.num_clie 
 WHERE import > 25000;
```

```
 num_comanda |      nom      |     empresa     |  import  
-------------+---------------+-----------------+----------
      112961 | Sam Clark     | J.P. Sinclair   | 31500.00
      113045 | Larry Fitch   | Zetacorp        | 45000.00
      113069 | Nancy Angelli | Chen Associates | 31350.00
      112987 | Bill Adams    | Acme Mfg.       | 27500.00
       88888 |               | JCP Inc.        | 26000.00
(5 rows)
```

## Exercici 9

Llista les comandes superiors a 25000, mostrant el client que va servir la comanda i el nom del venedor que té assignat el client.

```sql
SELECT  num_comanda, empresa, rep_clie, nom,import
  FROM  comandes
        JOIN clients
        ON comandes.clie = clients.num_clie

        JOIN rep_vendes
        ON clients.rep_clie = rep_vendes.num_empl  
 WHERE  import > 25000;
```

```
 num_comanda |     empresa     | rep_clie |  import  
-------------+-----------------+----------+----------
      112961 | J.P. Sinclair   |      106 | 31500.00
      113045 | Zetacorp        |      108 | 45000.00
      113069 | Chen Associates |      103 | 31350.00
      112987 | Acme Mfg.       |      105 | 27500.00
(4 rows)
```

## Exercici 10

Llista les comandes superiors a 22000, mostrant el nom del client que el va ordenar, el venedor associat al client, i la ciutat a on treballa aquest venedor.

```sql
SELECT num_comanda, empresa, rep_clie, oficina_rep, ciutat, import
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes
       ON clients.rep_clie = rep_vendes.num_empl

       JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina
 WHERE import > 22000;
```

Aquí podem tenir problemes amb els venedors que no tinguin associada una oficina, de manera que hauríem de fer un LEFT JOIN:

```sql
SELECT num_comanda, empresa, nom, oficina_rep, ciutat, import
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes
       ON clients.rep_clie = rep_vendes.num_empl

       LEFT JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina
 WHERE import > 22000;
```

```
 num_comanda |      empresa      |     nom     | oficina_rep |   ciutat    |  import  
-------------+-------------------+-------------+-------------+-------------+----------
      112961 | J.P. Sinclair     | Sam Clark   |          11 | New York    | 31500.00
      110036 | Ace International | Tom Snyder  |             |             | 22500.00
      113045 | Zetacorp          | Larry Fitch |          21 | Los Angeles | 45000.00
      113069 | Chen Associates   | Paul Cruz   |          12 | Chicago     | 31350.00
      112987 | Acme Mfg.         | Bill Adams  |          13 | Atlanta     | 27500.00
      113042 | Ian & Schmidt     | Bob Smith   |          12 | Chicago     | 22500.00
(6 rows)
```

## Exercici 11

Llista totes les combinacions de venedors i oficines on la quota del venedor és superior a l'objectiu de l'oficina.

És una consulta poc pràctica, sense relació entre venedors i oficines. De manera que farem el producte cartesià. Tots amb tots.

```sql
SELECT nom, ciutat, quota, objectiu
  FROM rep_vendes, oficines
 WHERE quota > objectiu;
```
o

```sql
SELECT nom, ciutat, quota, objectiu 
  FROM rep_vendes
       JOIN oficines
       ON 1 = 1
 WHERE quota > objectiu;
``` 

```sql
     nom     | ciutat |   quota   | objectiu  
-------------+--------+-----------+-----------
 Bill Adams  | Denver | 350000.00 | 300000.00
 Sue Smith   | Denver | 350000.00 | 300000.00
 Larry Fitch | Denver | 350000.00 | 300000.00
(3 rows)
```

## Exercici 12

Informa sobre tots els venedors i les oficines en les que treballen.

```sql
SELECT nom, ciutat
  FROM rep_vendes
       LEFT JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina;
```

```
      nom      |   ciutat    
---------------+-------------
 Bill Adams    | Atlanta
 Mary Jones    | New York
 Sue Smith     | Los Angeles
 Sam Clark     | New York
 Bob Smith     | Chicago
 Dan Roberts   | Chicago
 Tom Snyder    | 
 Larry Fitch   | Los Angeles
 Paul Cruz     | Chicago
 Nancy Angelli | Denver
(10 rows)
```


## Exercici 13

Llista els venedors amb una quota superior a la dels seus caps.

```sql
SELECT venedors.nom, venedors.quota, caps.nom, caps.quota
  FROM rep_vendes AS venedors
       JOIN rep_vendes AS caps
       ON venedors.cap  = caps.num_empl
 WHERE venedors.quota > caps.quota;
```

Aquí volem que hi una comparació de quotes, de manera que no té sentit jugar amb els OUTER, però si la consulta que ens demanessin fos:

"Llista els venedors amb una quota superior a la dels seus caps o d'aquells venedors amb quota però que no tinguin cap: "

```sql
SELECT venedors.nom, venedors.quota, caps.nom, caps.quota
  FROM rep_vendes AS venedors
       LEFT JOIN rep_vendes AS caps
       ON venedors.cap  = caps.num_empl   
 WHERE venedors.quota > caps.quota
    OR venedors.cap IS NULL;
``` 

Aquí és clau fer el LEFT JOIN, sinó no surt Sam Clark

```
     nom     |   quota   |    nom    |   quota   
-------------+-----------+-----------+-----------
 Bill Adams  | 350000.00 | Bob Smith | 200000.00
 Mary Jones  | 300000.00 | Sam Clark | 275000.00
 Dan Roberts | 300000.00 | Bob Smith | 200000.00
 Larry Fitch | 350000.00 | Sam Clark | 275000.00
 Paul Cruz   | 275000.00 | Bob Smith | 200000.00
(5 rows)
```

## Exercici 14

Llistar el nom de l'empresa i totes les comandes fetes pel client 2103.

```sql
SELECT empresa, num_comanda
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie
 WHERE clients.num_clie = 2103;
```

```
  empresa  | num_comanda | producte |  import  
-----------+-------------+----------+----------
 Acme Mfg. |      112963 | 41004    |  3276.00
 Acme Mfg. |      112983 | 41004    |   702.00
 Acme Mfg. |      113027 | 41002    |  4104.00
 Acme Mfg. |      112987 | 4100y    | 27500.00
(4 rows)
```

## Exercici 15

Llista aquelles comandes que el seu import sigui superior a 10000, mostrant el
numero de comanda, els imports i les descripcions del producte.

```sql
SELECT num_comanda, import, descripcio
  FROM comandes
       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte
 WHERE import > 10000;
```

```
 num_comanda |  import  |   descripcio   
-------------+----------+----------------
      112961 | 31500.00 | Frontissa Esq.
      110036 | 22500.00 | Muntador
      113045 | 45000.00 | Frontissa Dta.
      112979 | 15000.00 | Muntador
      113069 | 31350.00 | Riosta 1-Tm
      112987 | 27500.00 | Extractor
      113042 | 22500.00 | Frontissa Dta.
(7 rows)
```

Aquí recordem que per culpa de l'errada d'entrada de dades, tenim una comanda
amb un producte inventat, per tant hauriem de posar LEFT JOIN perquè sortís (si
no surt és perquè no compleix la condició del WHERE)


## Exercici 16

Llista les comandes superiors a 22000, mostrant el nom del client que la va
demanar, el venedor associat al client, i l'oficina on el venedor treballa.
També cal mostrar la descripció del producte.

```sql
SELECT empresa, nom, ciutat, descripcio, import
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes
       ON clients.rep_clie = rep_vendes.num_empl

       JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina

       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte
 WHERE import > 22000;
```

```
     empresa     |     nom     |   ciutat    |   descripcio   |  import  
-----------------+-------------+-------------+----------------+----------
 J.P. Sinclair   | Sam Clark   | New York    | Frontissa Esq. | 31500.00
 Zetacorp        | Larry Fitch | Los Angeles | Frontissa Dta. | 45000.00
 Chen Associates | Paul Cruz   | Chicago     | Riosta 1-Tm    | 31350.00
 Acme Mfg.       | Bill Adams  | Atlanta     | Extractor      | 27500.00
(4 rows)
```

Però en realitat per veure tots els cassos hauríem de fer un parell de OUTERs,
recordem que el segon si s'haguessin fet les coses bé en l'entrada de dades de
la Base de Dades no caldria. 

```sql
SELECT empresa, nom, ciutat, descripcio, import
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes
       ON clients.rep_clie = rep_vendes.num_empl

       LEFT JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina

       LEFT JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte
 WHERE import > 22000;
```

## Exercici 17

Trobar totes les comandes rebudes en els dies en que un nou venedor va ser
contractat. Per cada comanda mostrar un cop el número, import i data de la
comanda.

```sql
SELECT DISTINCT num_comanda, import, data
  FROM comandes
       JOIN rep_vendes
       ON comandes.data = rep_vendes.data_contracte;
```
```
 num_comanda |  import  |    data    
-------------+----------+------------
      112968 |  3978.00 | 1989-10-12
      112979 | 15000.00 | 1989-10-12
(2 rows)
```

## Exercici 18

Mostra el nom, les vendes dels treballadors que tenen assignada una oficina,
amb la ciutat i l'objectiu de l'oficina de cada venedor.


Ens diuen clarament _que tenen assignada una oficina_ per tant no n'hi haurà OUTER JOIN

```sql
SELECT nom, rep_vendes.vendes, ciutat, objectiu
  FROM rep_vendes
       JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina;
```

```
      nom      |  vendes   |   ciutat    | objectiu  
---------------+-----------+-------------+-----------
 Bill Adams    | 367911.00 | Atlanta     | 350000.00
 Mary Jones    | 392725.00 | New York    | 575000.00
 Sue Smith     | 474050.00 | Los Angeles | 725000.00
 Sam Clark     | 299912.00 | New York    | 575000.00
 Bob Smith     | 142594.00 | Chicago     | 800000.00
 Dan Roberts   | 305673.00 | Chicago     | 800000.00
 Larry Fitch   | 361865.00 | Los Angeles | 725000.00
 Paul Cruz     | 286775.00 | Chicago     | 800000.00
 Nancy Angelli | 186042.00 | Denver      | 300000.00
(9 rows)
```

## Exercici 19

Llista el nom de tots els venedors i el del seu cap en cas de tenir-ne. El camp
que conté el nom del treballador s'ha d'identificar com a _empleat_ i el camp
que conté el nom del cap amb _cap_.

```sql
SELECT empleats.nom AS empleat, caps.nom AS cap
  FROM rep_vendes AS empleats
       LEFT JOIN rep_vendes AS caps
       ON empleats.cap = caps.num_empl;
```
```
    empleat    |     cap     
---------------+-------------
 Bill Adams    | Bob Smith
 Mary Jones    | Sam Clark
 Sue Smith     | Larry Fitch
 Sam Clark     | 
 Bob Smith     | Sam Clark
 Dan Roberts   | Bob Smith
 Tom Snyder    | Dan Roberts
 Larry Fitch   | Sam Clark
 Paul Cruz     | Bob Smith
 Nancy Angelli | Larry Fitch
(10 rows)
```

## Exercici 20

Llista totes les combinacions possibles de venedors i ciutats.

```sql
SELECT nom, ciutat
  FROM rep_vendes, oficines;
```

Surten les 50 files 5 x 10 habituals.

o

```sql
SELECT nom, ciutat
  FROM rep_vendes
       CROSS JOIN oficines;
```

o

```sql
SELECT nom, ciutat
  FROM rep_vendes
       JOIN oficines
       ON 1=1;
```
en canvi, si fem aquesta:

```sql
SELECT nom, ciutat
  FROM rep_vendes
       JOIN oficines
       ON true;
```

Però aquesta darrera consulta no és SQL ANSI, podem comprovar-ho
[aquí](https://developer.mimer.com/sql-2016-validator/)

## Exercici 21

Per a cada venedor, mostrar el nom, les vendes i la ciutat de l'oficina en cas
de tenir-ne una d'assignada.

```sql
SELECT nom, rep_vendes.vendes, ciutat
  FROM rep_vendes
       LEFT JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina;
```
```
      nom      |  vendes   |   ciutat    
---------------+-----------+-------------
 Bill Adams    | 367911.00 | Atlanta
 Mary Jones    | 392725.00 | New York
 Sue Smith     | 474050.00 | Los Angeles
 Sam Clark     | 299912.00 | New York
 Bob Smith     | 142594.00 | Chicago
 Dan Roberts   | 305673.00 | Chicago
 Tom Snyder    |  75985.00 | 
 Larry Fitch   | 361865.00 | Los Angeles
 Paul Cruz     | 286775.00 | Chicago
 Nancy Angelli | 186042.00 | Denver
(10 rows)
```

Aquesta consulta es diferencia de la consulta 18 en el _LEFT_.

## Exercici 22

Mostra les comandes de productes que tenen un estoc inferior a 10.  Llistar el
numero de comanda, la data de la comanda, el nom del client que ha fet la
comanda, identificador del fabricant i l'identificador de producte de la
comanda.

```sql
SELECT num_comanda, data, empresa, id_fabricant, id_producte
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie
       
       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte
 WHERE estoc < 10;
```
```
 num_comanda |    data    |     empresa      | id_fabricant | id_producte 
-------------+------------+------------------+--------------+-------------
      113013 | 1990-01-14 | Midwest Systems  | bic          | 41003
      112997 | 1990-01-08 | Peter Brothers   | bic          | 41003
      113069 | 1990-03-02 | Chen Associates  | imm          | 775c 
      113048 | 1990-02-10 | Rico Enterprises | imm          | 779c 
      113003 | 1990-01-25 | Holm & Landis    | imm          | 779c 
(5 rows)
```

## Exercici 23

Llista les 5 comandes amb un import superior. Mostrar l'identificador de la
comanda, import de la comanda, preu del producte, nom del client, nom del
representant de vendes que va efectuar la comanda i ciutat de l'oficina, en cas
de tenir oficina assignada.

```sql
  SELECT num_comanda, import, preu, empresa, rep, ciutat
    FROM comandes
         JOIN clients
         ON comandes.clie = clients.num_clie

         LEFT JOIN productes
         ON comandes.fabricant = productes.id_fabricant
           AND comandes.producte = productes.id_producte

         LEFT JOIN rep_vendes
         ON comandes.rep = rep_vendes.num_empl

         LEFT JOIN oficines
         ON rep_vendes.oficina_rep = oficines.oficina
ORDER BY import DESC;
FETCH FIRST 3 ROWS ONLY;
```
```
 num_comanda |  import  |  preu   |     empresa     | rep |   ciutat    
-------------+----------+---------+-----------------+-----+-------------
      113045 | 45000.00 | 4500.00 | Zetacorp        | 108 | Los Angeles
      112961 | 31500.00 | 4500.00 | J.P. Sinclair   | 106 | New York
      113069 | 31350.00 | 1425.00 | Chen Associates | 107 | Denver
(3 rows)
```

## Exercici 24

Llista les comandes que han estat preses per un representant de vendes que no
és l'actual representant de vendes del client pel que s'ha realitzat la
comanda. Mostra el número de comanda, el nom del client, el nom de l'actual
representant de vendes del client com a "rep_client" i el nom del representant
de vendes que va realitzar la comanda com a "rep_comanda".

```sql
SELECT num_comanda, empresa, rep_vendes.nom AS rep_client, venedor_comanda.nom AS rep_comanda
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes
       ON rep_vendes.num_empl = clients.rep_clie

       JOIN rep_vendes AS venedor_comanda
       ON venedor_comanda.num_empl = comandes.rep 
 WHERE clients.rep_clie != comandes.rep;
```

```sql
 num_comanda |     empresa     | rep_client |  rep_comanda  
-------------+-----------------+------------+---------------
      113012 | JCP Inc.        | Paul Cruz  | Bill Adams
      113024 | Orion Corp      | Sue Smith  | Larry Fitch
      113069 | Chen Associates | Paul Cruz  | Nancy Angelli
      113055 | Holm & Landis   | Mary Jones | Dan Roberts
      113042 | Ian & Schmidt   | Bob Smith  | Dan Roberts
(5 rows)
```

Pregunta, solucionem la consulta amb els [INNER] JOIN o potser necessitem algun
LEFT o algun RIGHT?

En realitat hauríem de fer un cop d'ull a les taules i als possibles valors de
les columnes. I veuríem que la columna _rep_ de la taula _comandes_ pot ser
null. En efecte, si executem:

```sql
\d comandes
```

obtenim:

```sql
                   Table "public.comandes"
   Column    |     Type     | Collation | Nullable | Default 
-------------+--------------+-----------+----------+---------
 num_comanda | integer      |           | not null | 
 data        | date         |           | not null | 
 clie        | smallint     |           | not null | 
 rep         | smallint     |           |          | 
 fabricant   | character(3) |           | not null | 
 producte    | character(5) |           | not null | 
 quantitat   | smallint     |           | not null | 
 import      | numeric(7,2) |           | not null | 

```

La resta de camps que intervenen a la consulta, d'altres
taules també, tenen la condició `not null` i per tant no es pot donar aquest
cas. 

Però, com que la condició de reps diferents no la pot complir una comanda sense
venedor, no fem OUTERs.


## Exercici 25

Llista les comandes amb un import superior a 5000 i també aquelles comandes
realitzades per un client amb un crèdit inferior a 30000. Mostrar
l'identificador de la comanda, el nom del client i el nom del representant de
vendes que va prendre la comanda.

```sql
SELECT num_comanda, empresa, rep_vendes.nom 
  FROM comandes 
       JOIN clients
       ON comandes.clie = clients.num_clie 

       JOIN rep_vendes
       ON rep_vendes.num_empl = clients.rep_clie 

 WHERE comandes.import > 5000
       OR limit_credit < 30000; 
```



```sql
 num_comanda |      empresa      |     nom     
-------------+-------------------+-------------
      112961 | J.P. Sinclair     | Sam Clark
      110036 | Ace International | Tom Snyder
      113045 | Zetacorp          | Larry Fitch
      113024 | Orion Corp        | Sue Smith
      112979 | Orion Corp        | Sue Smith
      113069 | Chen Associates   | Paul Cruz
      113003 | Holm & Landis     | Mary Jones
      112987 | Acme Mfg.         | Bill Adams
      113042 | Ian & Schmidt     | Bob Smith
(9 rows)
```


