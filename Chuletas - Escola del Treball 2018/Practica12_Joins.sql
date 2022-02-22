-- 1. Per cada comanda que tenim, visualitzar la ciutat de l'oficina del representant de ventes  que l'ha fet,
-- el nom del representant que l'ha fet, l''import i el nom de l'empresa que ha comprat el producte. Mostrar-ho
-- ordenat pels 2 primers camps demanats.
training=# SELECT o.ciudad, o.oficina, r.nombre, p.importe, c.empresa FROM oficinas o RIGHT JOIN repventas r ON oficina = oficina_rep JOIN pedidos p ON num_empl = rep JOIN clientes c ON clie = num_clie ORDER BY o.ciudad, r.nombre;
   ciudad    | oficina |    nombre     | importe  |      empresa      
-------------+---------+---------------+----------+-------------------
 Atlanta     |      13 | Bill Adams    |   702.00 | Acme Mfg.
 Atlanta     |      13 | Bill Adams    |  3276.00 | Acme Mfg.
 Atlanta     |      13 | Bill Adams    | 27500.00 | Acme Mfg.
 Atlanta     |      13 | Bill Adams    |  4104.00 | Acme Mfg.
 Atlanta     |      13 | Bill Adams    |  3745.00 | JCP Inc.
 Chicago     |      12 | Dan Roberts   | 22500.00 | Ian & Schmidt
 Chicago     |      12 | Dan Roberts   |  3978.00 | First Corp.
 Chicago     |      12 | Dan Roberts   |   150.00 | Holm & Landis
 Chicago     |      12 | Paul Cruz     |  2100.00 | JCP Inc.
 Chicago     |      12 | Paul Cruz     |   600.00 | JCP Inc.
 Denver      |      22 | Nancy Angelli |  2430.00 | Peter Brothers
 Denver      |      22 | Nancy Angelli | 31350.00 | Chen Associates
 Denver      |      22 | Nancy Angelli |   652.00 | Peter Brothers
 Los Angeles |      21 | Larry Fitch   | 45000.00 | Zetacorp
 Los Angeles |      21 | Larry Fitch   |  7100.00 | Orion Corp
 Los Angeles |      21 | Larry Fitch   |  1420.00 | Midwest Systems
 Los Angeles |      21 | Larry Fitch   |  2925.00 | Zetacorp
 Los Angeles |      21 | Larry Fitch   |   760.00 | Midwest Systems
 Los Angeles |      21 | Larry Fitch   |   776.00 | Midwest Systems
 Los Angeles |      21 | Larry Fitch   |   652.00 | Midwest Systems
 Los Angeles |      21 | Sue Smith     | 15000.00 | Orion Corp
 Los Angeles |      21 | Sue Smith     |  3750.00 | Rico Enterprises
 Los Angeles |      21 | Sue Smith     |  1896.00 | Fred Lewis Corp.
 Los Angeles |      21 | Sue Smith     |  2130.00 | Fred Lewis Corp.
 New York    |      11 | Mary Jones    |  1480.00 | Holm & Landis
 New York    |      11 | Mary Jones    |  5625.00 | Holm & Landis
 New York    |      11 | Sam Clark     |  1458.00 | Jones Mfg.
 New York    |      11 | Sam Clark     | 31500.00 | J.P. Sinclair
             |         | Tom Snyder    |   632.00 | Ace International
             |         | Tom Snyder    | 22500.00 | Ace International
(30 rows)

-- 2. Mostrar la quantitat de comandes que cada representant ha fet per client i l'import total de comandes que cada venedor ha venut a cada client.
-- Mostrar la ciutat de l'oficina del representant de ventes, el nom del representant, 
-- el nom del client, la quantitat de comandes representant-client i
-- el total de l''import de les seves comandes per client.
-- Ordenar resulats per ciutat, representant i client.
training=# SELECT p.cant, sum(p.importe), o.ciudad, p.rep, c.empresa, p.clie FROM pedidos p JOIN repventas r ON p.rep = r.num_empl JOIN clientes c ON p.clie = c.num_clie JOIN oficinas o ON oficina = oficina_rep GROUP BY cant, ciudad, rep, empresa, clie ORDER BY ciudad, rep, clie;
 cant |   sum    |   ciudad    | rep |     empresa      | clie 
------+----------+-------------+-----+------------------+------
   11 | 27500.00 | Atlanta     | 105 | Acme Mfg.        | 2103
   28 |  3276.00 | Atlanta     | 105 | Acme Mfg.        | 2103
   54 |  4104.00 | Atlanta     | 105 | Acme Mfg.        | 2103
    6 |   702.00 | Atlanta     | 105 | Acme Mfg.        | 2103
   35 |  3745.00 | Atlanta     | 105 | JCP Inc.         | 2111
   34 |  3978.00 | Chicago     | 101 | First Corp.      | 2102
    6 |   150.00 | Chicago     | 101 | Holm & Landis    | 2108
    5 | 22500.00 | Chicago     | 101 | Ian & Schmidt    | 2113
   24 |   600.00 | Chicago     | 103 | JCP Inc.         | 2111
    6 |  2100.00 | Chicago     | 103 | JCP Inc.         | 2111
   22 | 31350.00 | Denver      | 107 | Chen Associates  | 2109
    1 |   652.00 | Denver      | 107 | Peter Brothers   | 2124
   10 |  2430.00 | Denver      | 107 | Peter Brothers   | 2124
    6 |  2130.00 | Los Angeles | 102 | Fred Lewis Corp. | 2106
   24 |  1896.00 | Los Angeles | 102 | Fred Lewis Corp. | 2106
    6 | 15000.00 | Los Angeles | 102 | Orion Corp       | 2114
    2 |  3750.00 | Los Angeles | 102 | Rico Enterprises | 2120
   10 | 45000.00 | Los Angeles | 108 | Zetacorp         | 2112
    3 |  2925.00 | Los Angeles | 108 | Zetacorp         | 2112
   20 |  7100.00 | Los Angeles | 108 | Orion Corp       | 2114
    4 |  1420.00 | Los Angeles | 108 | Midwest Systems  | 2118
    1 |   652.00 | Los Angeles | 108 | Midwest Systems  | 2118
   10 |   760.00 | Los Angeles | 108 | Midwest Systems  | 2118
    2 |   776.00 | Los Angeles | 108 | Midwest Systems  | 2118
    6 |  1458.00 | New York    | 106 | Jones Mfg.       | 2101
    7 | 31500.00 | New York    | 106 | J.P. Sinclair    | 2117
   10 |  1480.00 | New York    | 109 | Holm & Landis    | 2108
    3 |  5625.00 | New York    | 109 | Holm & Landis    | 2108
(28 rows)

-- 3. Mostrar la quantitat de representants de ventes que hi ha a la regió Este i  la quantitat de 
-- representants de ventes que hi ha a la regió Oeste.
training=# SELECT o.region, count(r.num_empl) FROM repventas r RIGHT JOIN oficinas o ON dir = num_empl GROUP BY region;
 region | count 
--------+-------
 Este   |     3
 Oeste  |     2
(2 rows)

-- 4. Mostrar la quantitat de representatns de ventes que hi ha a les diferents ciutats-oficines.
-- Mostrar la regió, la ciutat i el número de representants.
training=# SELECT o.ciudad, o.oficina, count(r.num_empl) FROM repventas r RIGHT JOIN oficinas o ON oficina = oficina_rep GROUP BY region, oficina;
   ciudad    | oficina | count 
-------------+---------+-------
 Denver      |      22 |     1
 Chicago     |      12 |     3
 New York    |      11 |     2
 Los Angeles |      21 |     2
 Atlanta     |      13 |     1
(5 rows)

-- 5. Mostrar la quantitat de representants de ventes que hi ha les diferents ciutats-oficines
-- i la quantitat de clients que tenen associats als representants d''aquestes ciutats-oficines.
-- Mostrar la regió, la ciutat, el número de representants i el número de clients.
training=# SELECT o.ciudad, o.oficina, count(r.num_empl), count(c.rep_clie) FROM repventas r RIGHT JOIN oficinas o ON oficina = oficina_rep JOIN clientes c ON rep_clie = num_empl GROUP BY region, oficina;
   ciudad    | oficina | count | count 
-------------+---------+-------+-------
 Denver      |      22 |     1 |     1
 Chicago     |      12 |     7 |     7
 New York    |      11 |     4 |     4
 Los Angeles |      21 |     6 |     6
 Atlanta     |      13 |     2 |     2
(5 rows)

-- 6. Mostrar els noms de les empreses que han comprat productes de les fàbriques imm i rei amb un preu
-- de catàleg (no de compra) inferior a 80 o superior a 1000. Mostrar l'empresa' el fabricant, el codi
-- de producte i el preu
training=# SELECT empresa, fab, producto, precio FROM productos LEFT JOIN pedidos ON fab = id_fab AND producto = id_producto JOIN clientes ON clie = num_clie WHERE fab LIKE 'rei' OR fab LIKE 'imm' AND precio < 80 AND precio > 1000 ;
      empresa      | fab | producto | precio  
-------------------+-----+----------+---------
 Fred Lewis Corp.  | rei | 2a45c    |   79.00
 Ace International | rei | 2a45c    |   79.00
 J.P. Sinclair     | rei | 2a44l    | 4500.00
 Ian & Schmidt     | rei | 2a44r    | 4500.00
 Zetacorp          | rei | 2a44r    | 4500.00
 JCP Inc.          | rei | 2a44g    |  350.00
(6 rows)

-- 7. Mostrar les empreses amb un nom que no comenci ni per I ni per J que entre totes les seves compres ens han comprat per un total
-- superior a 20000
training=# SELECT empresa, importe FROM clientes LEFT JOIN pedidos ON clie = num_clie WHERE NOT (empresa LIKE 'I%' OR empresa LIKE 'J%') AND (importe > 20000);
      empresa      | importe  
-------------------+----------
 Ace International | 22500.00
 Zetacorp          | 45000.00
 Chen Associates   | 31350.00
 Acme Mfg.         | 27500.00
(4 rows)

-- 8. Mostrar les comandes que els clients han fet a representants de ventes que no són el que tenen assignat.
-- Mostrar l'import de la comanda, el nom del client, el nom del representant de ventes que ha fet 
-- la comanda i el nom del representant de ventes que el client té assignat.'



-- 9. Mostrar les dades del producte (5 camps) del qual se n'han venut més unitats.'
training=# SELECT id_fab, id_producto, descripcion, precio FROM pedidos LEFT JOIN productos ON id_fab = fab AND id_producto = producto ORDER BY cant DESC LIMIT 5;
 id_fab | id_producto |   descripcion   | precio 
--------+-------------+-----------------+--------
 aci    | 41002       | Articulo Tipo 2 |  76.00
 aci    | 41003       | Articulo Tipo 3 | 107.00
 aci    | 41004       | Articulo Tipo 4 | 117.00
 aci    | 41004       | Articulo Tipo 4 | 117.00
 aci    | 4100x       | Ajustador       |  25.00
(5 rows)

-- 10. Per cada representant de ventes mostrar el seu nom, el nom del seu cap i el nom del cap
-- de l''oficina on treballa.
training=# SELECT treb.nombre as "treballador", dir.nombre as "director", dir.oficina_rep FROM repventas treb JOIN repventas dir ON treb.director = dir.num_empl JOIN oficinas ON oficina = dir.oficina_rep AND dir = dir.num_empl;
  treballador  |  director   | oficina_rep 
---------------+-------------+-------------
 Bill Adams    | Bob Smith   |          12
 Mary Jones    | Sam Clark   |          11
 Sue Smith     | Larry Fitch |          21
 Bob Smith     | Sam Clark   |          11
 Dan Roberts   | Bob Smith   |          12
 Larry Fitch   | Sam Clark   |          11
 Paul Cruz     | Bob Smith   |          12
 Nancy Angelli | Larry Fitch |          21
(8 rows)

-- 3 
training=# SELECT treb.num_empl, treb.nombre, treb.director, boss.num_empl, boss.nombre, sum(importe) FROM repventas treb LEFT JOIN oficinas ON treb.oficina_rep = oficina LEFT JOIN repventas boss ON dir = boss.num_empl LEFT JOIN pedidos ON treb.director = rep GROUP BY 1, 4;
 num_empl |    nombre     | director | num_empl |   nombre    |   sum    
----------+---------------+----------+----------+-------------+----------
      105 | Bill Adams    |      104 |      105 | Bill Adams  |         
      108 | Larry Fitch   |      106 |      108 | Larry Fitch | 32958.00
      110 | Tom Snyder    |      101 |          |             | 26628.00
      109 | Mary Jones    |      106 |      106 | Sam Clark   | 32958.00
      102 | Sue Smith     |      108 |      108 | Larry Fitch | 58633.00
      101 | Dan Roberts   |      104 |      104 | Bob Smith   |         
      104 | Bob Smith     |      106 |      104 | Bob Smith   | 32958.00
      107 | Nancy Angelli |      108 |      108 | Larry Fitch | 58633.00
      106 | Sam Clark     |          |      106 | Sam Clark   |         
      103 | Paul Cruz     |      104 |      104 | Bob Smith   |         
(10 rows)








