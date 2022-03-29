RepasoExamen-Vistas.md

# Vistas

* Crea una vista anomenata "top_prod" que mostri les dades de tots els productes seguit d'un camp anomenat "quant_total" en que es mostri la quantitat de cada producte que s'ha demanat en totes les comandes. S'ha d'ordenar per tal que primer es mostrin els productes que tenen més comandes.

```sql
training=*> CREATE VIEW top_prod
                    AS SELECT p.*, SUM(quantitat)
                         FROM productes p
                         JOIN comandes c
                           ON (p.id_fabricant, p.id_producte) =
                              (c.fabricant, c.producte)
                        GROUP BY p.id_fabricant, p.id_producte
                        ORDER BY COUNT(*)
                        DESC;
CREATE VIEW
training=*> SELECT * FROM top_prod;
 id_fabricant | id_producte |     descripcio     |  preu   | estoc | sum 
--------------+-------------+--------------------+---------+-------+-----
 aci          | 41004       | Article Tipus 4    |  117.00 |   139 |  68
 qsa          | xk47        | Reductor           |  355.00 |    38 |  28
 rei          | 2a45c       | V Stago Trinquet   |   79.00 |   210 |  32
 aci          | 4100x       | Peu de rei         |   25.00 |    37 |  30
 aci          | 4100z       | Muntador           | 2500.00 |    28 |  15
 bic          | 41003       | Manovella          |  652.00 |     3 |   2
 fea          | 114         | Bancada Motor      |  243.00 |    15 |  16
 imm          | 779c        | Riosta 2-Tm        | 1875.00 |     9 |   5
 rei          | 2a44r       | Frontissa Dta.     | 4500.00 |    12 |  15
 aci          | 41002       | Article Tipus 2    |   76.00 |   167 |  64
 imm          | 775c        | Riosta 1-Tm        | 1425.00 |     5 |  22
 aci          | 4100y       | Extractor          | 2750.00 |    25 |  11
 rei          | 2a44l       | Frontissa Esq.     | 4500.00 |    12 |   7
 aci          | 41003       | Article Tipus 3    |  107.00 |   207 |  35
 fea          | 112         | Coberta            |  148.00 |   115 |  10
 rei          | 2a44g       | Passador Frontissa |  350.00 |    14 |   6
 imm          | 773c        | Riosta 1/2-Tm      |  975.00 |    28 |   3
(17 rows)
```

* SOLUCIÓ

```sql
CREATE VIEW top_prod
    AS SELECT productes.*, SUM(quantitat)
         FROM productes
              JOIN comandes
              ON (id_fabricant, id_producte) = (fabricant, producte)
        GROUP BY id_fabricant, id_producte
        ORDER BY COUNT(*) DESC;
```

* Crea una vista anomenada "responsables" que mostri un llistat de tots els representants de vendes. 

* En un camp anomenat "empl" ha de mostrar el nom de cada representant de vendes. També ha de mostrar un camp anomenat "superior" que mostri el nom del cap del representant de vendes, en cas que el representant de vendes tingui cap. 

* També ha de mostrar un camp anomenat "oficina_superior" que mostri el nom del director de l'oficina en que treballa el representant de vendes, en cas que el representant de vendes tingui assignada una oficina aquesta tingui un director.

```sql
training=*> CREATE VIEW responsables
                    AS SELECT empl.nom AS empl, jefe.nom AS jefe,
                              dir_emp.nom AS dir_emp
                         FROM rep_vendes empl
                    LEFT JOIN rep_vendes jefe
                           ON empl.cap = jefe.num_empl
                    LEFT JOIN oficines o
                           ON empl.oficina_rep = o.oficina
                    LEFT JOIN rep_vendes dir_emp
                           ON dir_emp.num_empl = o.director;
CREATE VIEW
training=*> SELECT * FROM responsables;
     empl      |    jefe     |   dir_emp
---------------+-------------+-------------
 Bill Adams    | Bob Smith   | Bill Adams
 Mary Jones    | Sam Clark   | Sam Clark
 Sue Smith     | Larry Fitch | Larry Fitch
 Sam Clark     |             | Sam Clark
 Bob Smith     | Sam Clark   | Bob Smith
 Dan Roberts   | Bob Smith   | Bob Smith
 Tom Snyder    | Dan Roberts |
 Larry Fitch   | Sam Clark   | Larry Fitch
 Paul Cruz     | Bob Smith   | Bob Smith
 Nancy Angelli | Larry Fitch | Larry Fitch
(10 rows)
```

* SOLUCIÓ

```sql
CREATE VIEW responsables
    AS SELECT empleats.nom AS empl, caps.nom AS superior, directors.nom AS ofi_dire 
         FROM rep_vendes empleats 
              LEFT JOIN rep_vendes caps
              ON empleats.cap = caps.num_empl 
              
              LEFT JOIN oficines
              ON empleats.oficina_rep = oficina 

              LEFT JOIN rep_vendes directors
              ON director = directors.num_empl;
```