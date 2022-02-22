-- 1. Llistar els productes amb existències no superiors a 200 i no inferiors a 20 de la fàbrica aci o de la fabrica imm, i els nom dels clients que han comprat aquests productes. 
-- Si algun producte no l'ha comprat ningú ha de sortir sense nom de client.
training=# SELECT pe.clie, pr.id_producto, pr.id_fab 
FROM productos pr 
LEFT JOIN pedidos pe 
ON id_fab = fab 
AND id_producto = producto 
WHERE existencias < 200 AND existencias > 20 AND (id_fab LIKE 'aci' OR id_fab LIKE 'imm');
 clie | id_producto | id_fab 
------+-------------+--------
 2102 | 41004       | aci
 2107 | 4100z       | aci
 2103 | 41004       | aci
 2103 | 41004       | aci
 2114 | 4100z       | aci
 2103 | 41002       | aci
 2112 | 773c        | imm
 2118 | 41002       | aci
 2108 | 4100x       | aci
 2103 | 4100y       | aci
 2111 | 4100x       | aci
      | 887p        | imm
      | 887x        | imm
(13 rows)

-- 2. Llistar la ciutat de cada oficina, el número total de treballadors, el nom del cap de l'oficina i el nom de cadascun dels treballadors (incloent al cap com a treballador).
training=# SELECT 'Total treballadors' , ciudad , null , count(repventas.*) FROM repventas JOIN oficinas ON oficina_rep = oficina GROUP BY ciudad 
UNION 
SELECT 'Cap oficina', ciudad , nombre , null FROM oficinas JOIN repventas ON dir = num_empl 
UNION 
SELECT 'Nom treballadors' , ciudad , nombre , null FROM oficinas JOIN repventas ON oficina = oficina_rep ORDER BY 2,1;

-- 3. Llistar els noms i preus dels productes de la fàbrica imm i de la fàbrica rei que contenen 'gr' o 'tr' en el seu nom i que valen entre 900 i 5000€, i els noms dels venedors queç
-- han venut aquests productes. Si algun producte no l'ha comprat ningú ha de sortir sense nom venedor.
training=# SELECT 'Producte' , descripcion , precio , null 
FROM productos 
LEFT JOIN pedidos ON id_fab = fab and id_producto = producto 
WHERE (fab = 'imm' or fab = 'rei') and 
(descripcion like '%gr%' or descripcion like '%tr%') and (precio > 900 and precio < 5000) 
UNION 
SELECT 'Venedor' , descripcion , null , nombre FROM repventas JOIN pedidos ON num_empl = rep JOIN productos ON fab = id_fab AND producto = id_producto WHERE (fab = 'imm' OR fab = 'rei') and (descripcion LIKE '%gr%' OR descripcion LIKE '%tr%') AND (precio > 900 AND precio < 5000) ORDER BY 2,1; 
 ?column? |  descripcion   | precio  |   ?column?    
----------+----------------+---------+---------------
 Producte | Bisagra Dcha.  | 4500.00 | 
 Venedor  | Bisagra Dcha.  |         | Larry Fitch
 Venedor  | Bisagra Dcha.  |         | Dan Roberts
 Producte | Bisagra Izqda. | 4500.00 | 
 Venedor  | Bisagra Izqda. |         | Sam Clark
 Producte | Riostra 1/2-Tm |  975.00 | 
 Venedor  | Riostra 1/2-Tm |         | Larry Fitch
 Producte | Riostra 1-Tm   | 1425.00 | 
 Venedor  | Riostra 1-Tm   |         | Nancy Angelli
 Producte | Riostra 2-Tm   | 1875.00 | 
 Venedor  | Riostra 2-Tm   |         | Sue Smith
 Venedor  | Riostra 2-Tm   |         | Mary Jones
(12 rows)

-- 4. Llistar els noms dels productes, el número total de ventes que s'ha fet d'aquell producte, la quantitat total d'unitats que s'han venut d'aquell producte, i el nom de cada client 
-- que l'ha comprat.
training=# SELECT 'Numero pedidos' , descripcion , count(pedidos.*) , null 
FROM pedidos 
RIGHT JOIN productos 
ON fab = id_fab and producto = id_producto 
JOIN clientes ON clie = num_clie 
GROUP BY 
id_fab , id_producto 
UNION 
SELECT 'Quantitat unitats' , descripcion , sum(cant) , empresa 
FROM pedidos 
RIGHT JOIN productos 
ON fab = id_fab and producto = id_producto 
JOIN clientes 
ON clie = num_clie 
GROUP BY id_fab , id_producto , num_clie 
ORDER BY 2,1 DESC;
     ?column?      |    descripcion    | count |     ?column?      
-------------------+-------------------+-------+-------------------
 Quantitat unitats | Ajustador         |    24 | JCP Inc.
 Quantitat unitats | Ajustador         |     6 | Holm & Landis
 Numero pedidos    | Ajustador         |     2 | 
 Quantitat unitats | Articulo Tipo 2   |    54 | Acme Mfg.
 Quantitat unitats | Articulo Tipo 2   |    10 | Midwest Systems
 Numero pedidos    | Articulo Tipo 2   |     2 | 
 Quantitat unitats | Articulo Tipo 3   |    35 | JCP Inc.
 Numero pedidos    | Articulo Tipo 3   |     1 | 
 Quantitat unitats | Articulo Tipo 4   |    34 | Acme Mfg.
 Quantitat unitats | Articulo Tipo 4   |    34 | First Corp.
 Numero pedidos    | Articulo Tipo 4   |     3 | 
 Quantitat unitats | Bancada Motor     |    10 | Peter Brothers
 Quantitat unitats | Bancada Motor     |     6 | Jones Mfg.
 Numero pedidos    | Bancada Motor     |     2 | 
 Quantitat unitats | Bisagra Dcha.     |    10 | Zetacorp
 Quantitat unitats | Bisagra Dcha.     |     5 | Ian & Schmidt
 Numero pedidos    | Bisagra Dcha.     |     2 | 
 Quantitat unitats | Bisagra Izqda.    |     7 | J.P. Sinclair
 Numero pedidos    | Bisagra Izqda.    |     1 | 
 Quantitat unitats | Cubierta          |    10 | Holm & Landis
 Numero pedidos    | Cubierta          |     1 | 
 Quantitat unitats | Extractor         |    11 | Acme Mfg.
 Numero pedidos    | Extractor         |     1 | 
 Quantitat unitats | Manivela          |     1 | Peter Brothers
 Quantitat unitats | Manivela          |     1 | Midwest Systems
 Numero pedidos    | Manivela          |     2 | 
 Quantitat unitats | Montador          |     6 | Orion Corp
 Quantitat unitats | Montador          |     9 | Ace International
 Numero pedidos    | Montador          |     2 | 
 Quantitat unitats | Pasador Bisagra   |     6 | JCP Inc.
 Numero pedidos    | Pasador Bisagra   |     1 | 
 Quantitat unitats | Reductor          |    20 | Orion Corp
 Quantitat unitats | Reductor          |     2 | Midwest Systems
 Quantitat unitats | Reductor          |     6 | Fred Lewis Corp.
 Numero pedidos    | Reductor          |     3 | 
 Quantitat unitats | Riostra 1/2-Tm    |     3 | Zetacorp
 Numero pedidos    | Riostra 1/2-Tm    |     1 | 
 Quantitat unitats | Riostra 1-Tm      |    22 | Chen Associates
 Numero pedidos    | Riostra 1-Tm      |     1 | 
 Quantitat unitats | Riostra 2-Tm      |     2 | Rico Enterprises
 Quantitat unitats | Riostra 2-Tm      |     3 | Holm & Landis
 Numero pedidos    | Riostra 2-Tm      |     2 | 
 Quantitat unitats | V Stago Trinquete |    24 | Fred Lewis Corp.
 Quantitat unitats | V Stago Trinquete |     8 | Ace International
 Numero pedidos    | V Stago Trinquete |     2 | 
(45 rows)

-- 5. Llistar els poductes que costen més de 1000 o no són ni de la fàbrica imm ni de la fàbrica rei, ni de la fàbrica ací, i el total que n'ha comprat cada client. Si algun producte 
-- no l'ha comprat ningú ha de sortir sense nom de client.
training=# SELECT descripcion , id_fab , id_producto , clie , sum(cant) 
FROM productos 
LEFT JOIN pedidos 
ON id_fab = fab and id_producto = producto 
WHERE precio > 1000 and id_fab <> 'imm' and id_fab <> 'rei' 
GROUP BY 2,3,4;
 descripcion | id_fab | id_producto | clie | sum 
-------------+--------+-------------+------+-----
 Montador    | aci    | 4100z       | 2114 |   6
 Montador    | aci    | 4100z       | 2107 |   9
 Extractor   | aci    | 4100y       | 2103 |  11
(3 rows)

-- 6. Llistar els codis de fabricants, el número total de productes d'aquell fabricant i el nom de cadascun dels productes.
training=# SELECT 'Total' , id_fab , null , count(*) 
FROM productos GROUP BY id_fab 
UNION 
SELECT 'Productes' , id_fab , id_producto , null 
FROM productos ORDER BY 2,1;
 ?column?  | id_fab | ?column? | count 
-----------+--------+----------+-------
 Productes | aci    | 41002    |      
 Productes | aci    | 4100y    |      
 Productes | aci    | 4100x    |      
 Productes | aci    | 41001    |      
 Productes | aci    | 41003    |      
 Productes | aci    | 4100z    |      
 Productes | aci    | 41004    |      
 Total     | aci    |          |     7
 Productes | bic    | 41672    |      
 Productes | bic    | 41089    |      
 Productes | bic    | 41003    |      
 Total     | bic    |          |     3
 Productes | fea    | 112      |      
 Productes | fea    | 114      |      
 Total     | fea    |          |     2
 Productes | imm    | 887h     |      
 Productes | imm    | 779c     |      
 Productes | imm    | 775c     |      
 Productes | imm    | 887x     |      
 Productes | imm    | 773c     |      
 Productes | imm    | 887p     |      
 Total     | imm    |          |     6
 Productes | qsa    | xk47     |      
 Productes | qsa    | xk48     |      
 Productes | qsa    | xk48a    |      
 Total     | qsa    |          |     3
 Productes | rei    | 2a44r    |      
 Productes | rei    | 2a44l    |      
 Productes | rei    | 2a44g    |      
 Productes | rei    | 2a45c    |      
 Total     | rei    |          |     4
(31 rows)

-- 7. Llistar els venedors i els seus imports totals de ventes, que tinguin més de 30 anys i treballin a l'oficina 12 i els que tinguin més de 20 anys i treballin a l'oficina 21. 
-- Llistar els clients a qui ha venut cadascun d'aquests venedors
training=# SELECT 'Suma ventas' , rep , sum(importe) , null 
FROM pedidos 
JOIN repventas 
ON rep = num_empl 
WHERE (edad > 30 and oficina_rep = 12) or (edad > 20 and oficina_rep = 21) 
GROUP BY rep 
UNION SELECT 'Clients venuts' , rep , null , clie 
FROM pedidos 
JOIN repventas 
ON rep = num_empl 
WHERE (edad > 30 and oficina_rep = 12) or (edad > 20 and oficina_rep = 21) 
ORDER BY 2,1;
    ?column?    | rep |   sum    | ?column? 
----------------+-----+----------+----------
 Clients venuts | 101 |          |     2113
 Clients venuts | 101 |          |     2102
 Clients venuts | 101 |          |     2108
 Suma ventas    | 101 | 26628.00 |         
 Clients venuts | 102 |          |     2106
 Clients venuts | 102 |          |     2120
 Clients venuts | 102 |          |     2114
 Suma ventas    | 102 | 22776.00 |         
 Clients venuts | 108 |          |     2112
 Clients venuts | 108 |          |     2114
 Clients venuts | 108 |          |     2118
 Suma ventas    | 108 | 58633.00 |         
(12 rows)


