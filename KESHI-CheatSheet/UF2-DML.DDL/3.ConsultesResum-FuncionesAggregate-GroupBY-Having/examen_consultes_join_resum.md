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
