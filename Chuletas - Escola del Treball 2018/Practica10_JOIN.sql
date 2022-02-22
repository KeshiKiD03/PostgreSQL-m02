-- 1. Llistar quants clients té assignats cada treballador-venedor-representant. 
-- Mostrar el codi del representant, el nom del representant i la quantitat de clients, ordenant de major quantitat de clients a menor.
 
SELECT count(c.num_clie), r.num_empl, r.nombre
FROM repventas r
JOIN clientes c
ON r.num_empl = c.rep_clie
GROUP BY r.num_empl
ORDER BY 1 DESC;
 count | num_empl |    nombre     
-------+----------+---------------
     4 |      102 | Sue Smith
     3 |      103 | Paul Cruz
     3 |      101 | Dan Roberts
     2 |      106 | Sam Clark
     2 |      109 | Mary Jones
     2 |      108 | Larry Fitch
     2 |      105 | Bill Adams
     1 |      110 | Tom Snyder
     1 |      107 | Nancy Angelli
     1 |      104 | Bob Smith
(10 rows)


-- 2. Llistar el nom de cada producte diferent, el seu preu i quantes unitats se n'han venut. No cal mostrar productes sense nom.

SELECT DISTINCT pr.descripcion, pr.precio, sum(pe.cant)
FROM productos pr
JOIN pedidos pe
ON pr.id_producto = pe.producto AND pr.id_fab = pe.fab
GROUP BY pr.id_producto, pr.id_fab;
    descripcion    | precio  | sum 
-------------------+---------+-----
 Cubierta          |  148.00 |  10
 Bancada Motor     |  243.00 |  16
 Pasador Bisagra   |  350.00 |   6
 Bisagra Izqda.    | 4500.00 |   7
 Bisagra Dcha.     | 4500.00 |  15
 V Stago Trinquete |   79.00 |  32
 Articulo Tipo 2   |   76.00 |  64
 Articulo Tipo 3   |  107.00 |  35
 Manivela          |  652.00 |   2
 Articulo Tipo 4   |  117.00 |  68
 Ajustador         |   25.00 |  30
 Extractor         | 2750.00 |  11
 Montador          | 2500.00 |  15
 Riostra 1/2-Tm    |  975.00 |   3
 Riostra 1-Tm      | 1425.00 |  22
 Riostra 2-Tm      | 1875.00 |   5
 Reductor          |  355.00 |  28
(17 rows)


-- 3. Llistar el nom de cada producte diferent, el seu preu i quantes unitats 
-- se n'han venut segons el representant que l'ha venut (volem saber quantes unitats n'ha venut cada representant). 
-- Mostrar el nom del venedor. No cal mostrar productes sense nom.

SELECT DISTINCT pr.descripcion, pr.precio, sum(pe.cant), re.num_empl, re.nombre
FROM productos pr
JOIN pedidos pe
ON pr.id_producto = pe.producto AND pr.id_fab = pe.fab
JOIN repventas re
ON re.num_empl = pe.rep
GROUP BY pr.id_producto, pr.id_fab, re.num_empl;
    descripcion    | precio  | sum | num_empl |    nombre     
-------------------+---------+-----+----------+---------------
 Riostra 1/2-Tm    |  975.00 |   3 |      108 | Larry Fitch
 Ajustador         |   25.00 |   6 |      101 | Dan Roberts
 Articulo Tipo 4   |  117.00 |  34 |      101 | Dan Roberts
 Riostra 2-Tm      | 1875.00 |   3 |      109 | Mary Jones
 Articulo Tipo 3   |  107.00 |  35 |      105 | Bill Adams
 Articulo Tipo 4   |  117.00 |  34 |      105 | Bill Adams
 Pasador Bisagra   |  350.00 |   6 |      103 | Paul Cruz
 Reductor          |  355.00 |  22 |      108 | Larry Fitch
 Riostra 2-Tm      | 1875.00 |   2 |      102 | Sue Smith
 Articulo Tipo 2   |   76.00 |  54 |      105 | Bill Adams
 Cubierta          |  148.00 |  10 |      109 | Mary Jones
 Bisagra Dcha.     | 4500.00 |  10 |      108 | Larry Fitch
 Montador          | 2500.00 |   9 |      110 | Tom Snyder
 Bancada Motor     |  243.00 |   6 |      106 | Sam Clark
 Manivela          |  652.00 |   1 |      108 | Larry Fitch
 Reductor          |  355.00 |   6 |      102 | Sue Smith
 Ajustador         |   25.00 |  24 |      103 | Paul Cruz
 V Stago Trinquete |   79.00 |  24 |      102 | Sue Smith
 Montador          | 2500.00 |   6 |      102 | Sue Smith
 Extractor         | 2750.00 |  11 |      105 | Bill Adams
 Bancada Motor     |  243.00 |  10 |      107 | Nancy Angelli
 Bisagra Izqda.    | 4500.00 |   7 |      106 | Sam Clark
 V Stago Trinquete |   79.00 |   8 |      110 | Tom Snyder
 Riostra 1-Tm      | 1425.00 |  22 |      107 | Nancy Angelli
 Manivela          |  652.00 |   1 |      107 | Nancy Angelli
 Bisagra Dcha.     | 4500.00 |   5 |      101 | Dan Roberts
 Articulo Tipo 2   |   76.00 |  10 |      108 | Larry Fitch
(27 rows)



-- 4. Llistar el nom de cada producte diferent, el seu preu i quantes unitats se n'han venut segons 
-- el el client que l'ha comprat (volem saber quantes unitats n'ha comprat cada client). 
-- Mostrar el nom del client. No cal mostrar productes sense nom.

SELECT DISTINCT pr.descripcion, pr.precio, sum(pe.cant), cl.num_clie, cl.empresa
FROM productos pr
JOIN pedidos pe
ON pr.id_producto = pe.producto AND pr.id_fab = pe.fab
JOIN clientes cl
ON cl.num_clie = pe.clie
GROUP BY pr.id_producto, pr.id_fab, cl.num_clie;
    descripcion    | precio  | sum | num_clie |      empresa      
-------------------+---------+-----+----------+-------------------
 Riostra 2-Tm      | 1875.00 |   2 |     2120 | Rico Enterprises
 Bancada Motor     |  243.00 |   6 |     2101 | Jones Mfg.
 Montador          | 2500.00 |   9 |     2107 | Ace International
 Articulo Tipo 2   |   76.00 |  54 |     2103 | Acme Mfg.
 Articulo Tipo 3   |  107.00 |  35 |     2111 | JCP Inc.
 Manivela          |  652.00 |   1 |     2124 | Peter Brothers
 Riostra 1/2-Tm    |  975.00 |   3 |     2112 | Zetacorp
 Articulo Tipo 4   |  117.00 |  34 |     2103 | Acme Mfg.
 Montador          | 2500.00 |   6 |     2114 | Orion Corp
 Articulo Tipo 2   |   76.00 |  10 |     2118 | Midwest Systems
 Pasador Bisagra   |  350.00 |   6 |     2111 | JCP Inc.
 Riostra 2-Tm      | 1875.00 |   3 |     2108 | Holm & Landis
 Ajustador         |   25.00 |  24 |     2111 | JCP Inc.
 Extractor         | 2750.00 |  11 |     2103 | Acme Mfg.
 V Stago Trinquete |   79.00 |  24 |     2106 | Fred Lewis Corp.
 Manivela          |  652.00 |   1 |     2118 | Midwest Systems
 Bisagra Izqda.    | 4500.00 |   7 |     2117 | J.P. Sinclair
 Bancada Motor     |  243.00 |  10 |     2124 | Peter Brothers
 V Stago Trinquete |   79.00 |   8 |     2107 | Ace International
 Reductor          |  355.00 |   6 |     2106 | Fred Lewis Corp.
 Cubierta          |  148.00 |  10 |     2108 | Holm & Landis
 Articulo Tipo 4   |  117.00 |  34 |     2102 | First Corp.
 Reductor          |  355.00 |   2 |     2118 | Midwest Systems
 Bisagra Dcha.     | 4500.00 |   5 |     2113 | Ian & Schmidt
 Reductor          |  355.00 |  20 |     2114 | Orion Corp
 Ajustador         |   25.00 |   6 |     2108 | Holm & Landis
 Riostra 1-Tm      | 1425.00 |  22 |     2109 | Chen Associates
 Bisagra Dcha.     | 4500.00 |  10 |     2112 | Zetacorp
(28 rows)


--5. Mostrar quants treballadors tenim a cada regió.

SELECT COUNT(re.num_empl), o.region
FROM repventas re
JOIN oficinas o
ON re.oficina_rep = o.oficina
GROUP BY o.region;
 count | region 
-------+--------
     6 | Este
     3 | Oeste
(2 rows)



--6. Mostrar el noms dels 3  clients que ens han comprat més tenint en compte l'import.

SELECT cl.empresa, pe.importe
FROM clientes cl
JOIN pedidos pe
ON cl.num_clie = pe.clie
ORDER BY pe.importe DESC LIMIT 3;
     empresa     | importe  
-----------------+----------
 Zetacorp        | 45000.00
 J.P. Sinclair   | 31500.00
 Chen Associates | 31350.00
(3 rows)




--7. Mostrar els 3 noms de productes que s'han venut més tenint en compte la quantitat.

SELECT pr.descripcion, pe.cant
FROM productos pr
JOIN pedidos pe
ON pr.id_producto = pe.producto AND pr.id_fab = pe.fab
ORDER BY pe.cant DESC LIMIT 3;
   descripcion   | cant 
-----------------+------
 Articulo Tipo 2 |   54
 Articulo Tipo 3 |   35
 Articulo Tipo 4 |   34
(3 rows)


-- 8. Mostrat els 3 noms de venedors que han venut menys tenint en compte l'import.

SELECT re.nombre, pe.importe
FROM repventas re
JOIN pedidos pe
ON re.num_empl = pe.rep
ORDER BY pe.importe ASC LIMIT 3;
   nombre    | importe 
-------------+---------
 Dan Roberts |  150.00
 Paul Cruz   |  600.00
 Tom Snyder  |  632.00
(3 rows)





-- 9. Mostrar totes les dades possibles relacionades amb les 
-- comandes que han fet els clients que tenen un nom que no comença ni amb 'A' ni amb 'S' de productes 
-- dels fabricants acabats amb ' sa ' o en ' mm'  i que ha fet algun venendor de Denver.

SELECT *
FROM clientes cl
JOIN pedidos pe
ON cl.num_clie = pe.clie
WHERE NOT (cl.empresa LIKE 'A%' OR cl.empresa LIKE 'S%');
 num_clie |     empresa      | rep_clie | limite_credito | num_pedido | fecha_pedido | clie | rep | fab | producto | cant | importe  
----------+------------------+----------+----------------+------------+--------------+------+-----+-----+----------+------+----------
     2117 | J.P. Sinclair    |      106 |       35000.00 |     112961 | 1989-12-17   | 2117 | 106 | rei | 2a44l    |    7 | 31500.00
     2111 | JCP Inc.         |      103 |       50000.00 |     113012 | 1990-01-11   | 2111 | 105 | aci | 41003    |   35 |  3745.00
     2101 | Jones Mfg.       |      106 |       65000.00 |     112989 | 1990-01-03   | 2101 | 106 | fea | 114      |    6 |  1458.00
     2118 | Midwest Systems  |      108 |       60000.00 |     113051 | 1990-02-10   | 2118 | 108 | qsa | k47      |    4 |  1420.00
     2102 | First Corp.      |      101 |       65000.00 |     112968 | 1989-10-12   | 2102 | 101 | aci | 41004    |   34 |  3978.00
     2112 | Zetacorp         |      108 |       50000.00 |     113045 | 1990-02-02   | 2112 | 108 | rei | 2a44r    |   10 | 45000.00
     2118 | Midwest Systems  |      108 |       60000.00 |     113013 | 1990-01-14   | 2118 | 108 | bic | 41003    |    1 |   652.00
     2108 | Holm & Landis    |      109 |       55000.00 |     113058 | 1990-02-23   | 2108 | 109 | fea | 112      |   10 |  1480.00
     2124 | Peter Brothers   |      107 |       40000.00 |     112997 | 1990-01-08   | 2124 | 107 | bic | 41003    |    1 |   652.00
     2114 | Orion Corp       |      102 |       20000.00 |     113024 | 1990-01-20   | 2114 | 108 | qsa | xk47     |   20 |  7100.00
     2124 | Peter Brothers   |      107 |       40000.00 |     113062 | 1990-02-24   | 2124 | 107 | fea | 114      |   10 |  2430.00
     2114 | Orion Corp       |      102 |       20000.00 |     112979 | 1989-10-12   | 2114 | 102 | aci | 4100z    |    6 | 15000.00
     2112 | Zetacorp         |      108 |       50000.00 |     113007 | 1990-01-08   | 2112 | 108 | imm | 773c     |    3 |  2925.00
     2109 | Chen Associates  |      103 |       25000.00 |     113069 | 1990-03-02   | 2109 | 107 | imm | 775c     |   22 | 31350.00
     2118 | Midwest Systems  |      108 |       60000.00 |     112992 | 1989-11-04   | 2118 | 108 | aci | 41002    |   10 |   760.00
     2111 | JCP Inc.         |      103 |       50000.00 |     112975 | 1989-12-12   | 2111 | 103 | rei | 2a44g    |    6 |  2100.00
     2108 | Holm & Landis    |      109 |       55000.00 |     113055 | 1990-02-15   | 2108 | 101 | aci | 4100x    |    6 |   150.00
     2120 | Rico Enterprises |      102 |       50000.00 |     113048 | 1990-02-10   | 2120 | 102 | imm | 779c     |    2 |  3750.00
     2106 | Fred Lewis Corp. |      102 |       65000.00 |     112993 | 1989-01-04   | 2106 | 102 | rei | 2a45c    |   24 |  1896.00
     2106 | Fred Lewis Corp. |      102 |       65000.00 |     113065 | 1990-02-27   | 2106 | 102 | qsa | xk47     |    6 |  2130.00
     2108 | Holm & Landis    |      109 |       55000.00 |     113003 | 1990-01-25   | 2108 | 109 | imm | 779c     |    3 |  5625.00
     2118 | Midwest Systems  |      108 |       60000.00 |     113049 | 1990-02-10   | 2118 | 108 | qsa | xk47     |    2 |   776.00
     2111 | JCP Inc.         |      103 |       50000.00 |     113057 | 1990-02-18   | 2111 | 103 | aci | 4100x    |   24 |   600.00
     2113 | Ian & Schmidt    |      104 |       20000.00 |     113042 | 1990-02-02   | 2113 | 101 | rei | 2a44r    |    5 | 22500.00
(24 rows)


-- 1a fase

-------------------------

SELECT *
FROM clientes cl
JOIN pedidos pe
ON cl.num_clie = pe.clie
WHERE NOT (cl.empresa LIKE 'A%' OR cl.empresa LIKE 'S%') AND (pe.fab LIKE '_sa' OR pe.fab LIKE '_mm');
 num_clie |     empresa      | rep_clie | limite_credito | num_pedido | fecha_pedido | clie | rep | fab | producto | cant | importe  
----------+------------------+----------+----------------+------------+--------------+------+-----+-----+----------+------+----------
     2112 | Zetacorp         |      108 |       50000.00 |     113007 | 1990-01-08   | 2112 | 108 | imm | 773c     |    3 |  2925.00
     2114 | Orion Corp       |      102 |       20000.00 |     113024 | 1990-01-20   | 2114 | 108 | qsa | xk47     |   20 |  7100.00
     2108 | Holm & Landis    |      109 |       55000.00 |     113003 | 1990-01-25   | 2108 | 109 | imm | 779c     |    3 |  5625.00
     2120 | Rico Enterprises |      102 |       50000.00 |     113048 | 1990-02-10   | 2120 | 102 | imm | 779c     |    2 |  3750.00
     2106 | Fred Lewis Corp. |      102 |       65000.00 |     113065 | 1990-02-27   | 2106 | 102 | qsa | xk47     |    6 |  2130.00
     2118 | Midwest Systems  |      108 |       60000.00 |     113049 | 1990-02-10   | 2118 | 108 | qsa | xk47     |    2 |   776.00
     2118 | Midwest Systems  |      108 |       60000.00 |     113051 | 1990-02-10   | 2118 | 108 | qsa | k47      |    4 |  1420.00
     2109 | Chen Associates  |      103 |       25000.00 |     113069 | 1990-03-02   | 2109 | 107 | imm | 775c     |   22 | 31350.00
(8 rows)


-- 2da fase

----------------
SELECT *
FROM clientes cl
JOIN pedidos pe
ON cl.num_clie = pe.clie
JOIN repventas re
ON re.num_empl = pe.rep
JOIN oficinas o
ON o.oficina = re.oficina_rep
WHERE NOT (cl.empresa LIKE 'A%' OR cl.empresa LIKE 'S%') AND (pe.fab LIKE '_sa' OR pe.fab LIKE '_mm') AND o.ciudad = 'Denver';
 num_clie |     empresa     | rep_clie | limite_credito | num_pedido | fecha_pedido | clie | rep | fab | producto | cant | importe  | num_empl |    n
ombre     | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   | oficina | ciudad | region | dir | objetivo  |  ventas  
 
----------+-----------------+----------+----------------+------------+--------------+------+-----+-----+----------+------+----------+----------+-----
----------+------+-------------+------------+------------+----------+-----------+-----------+---------+--------+--------+-----+-----------+----------
-
     2109 | Chen Associates |      103 |       25000.00 |     113069 | 1990-03-02   | 2109 | 107 | imm | 775c     |   22 | 31350.00 |      107 | Nanc
y Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00 |      22 | Denver | Oeste  | 108 | 300000.00 | 186042.00
(1 row)

-- FINAL





--10. Mostrar, per cada comanda, les següents dades ordenades per client:
-- Nom de producte
-- Codi i nom del venedor que va vendre la comanda
-- Ciutat de l'oficina del venedor que va vendre la comanda
-- Codi i nom del cap del venedor que va vendre la comanda
-- Codi i nom del client que va comprar la comanda
-- Codi i nom del venedor assignat al client
-- Ciutat de l'oficina del venedor assignat al client
-- Codi i nom del cap del venedor assignat al client
-- Import de la comanda

SELECT pe.num_pedido, pr.descripcion, re.num_empl, re.nombre, o.ciudad, dir.num_empl, dir.nombre, cl.num_clie, cl.empresa, clven.num_empl, clven.nombre, clvenofi.ciudad, clvendir.num_empl, clvendir.nombre, pe.importe
FROM pedidos pe
LEFT JOIN productos pr 
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN repventas re -- Codi i nom del venedor que va vendre la comanda
ON re.num_empl = pe.rep
LEFT JOIN oficinas o -- Ciutat de l'oficina del venedor que va vendre la comanda
ON o.oficina = re.oficina_rep
LEFT JOIN repventas dir -- Codi i nom del cap del venedor que va vendre la comanda
ON dir.num_empl = re.director
LEFT JOIN clientes cl -- Codi i nom del client que va comprar la comanda
ON cl.num_clie = pe.clie
JOIN repventas clven -- Codi i nom del venedor assignat al client
ON clven.num_empl = cl.rep_clie
LEFT JOIN oficinas clvenofi -- Ciutat de l'oficina del venedor assignat al client
ON clvenofi.oficina = clven.oficina_rep
LEFT JOIN repventas clvendir -- Codi i nom del cap del venedor assignat al client
ON clvendir.num_empl = clven.director
ORDER BY cl.num_clie;


training=# SELECT pe.num_pedido, pr.descripcion
training-# FROM pedidos pe
training-# LEFT JOIN productos pr 
training-# ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab;


num_pedido |    descripcion    
------------+-------------------
     113058 | Cubierta
     112989 | Bancada Motor
     113062 | Bancada Motor
     112975 | Pasador Bisagra
     112961 | Bisagra Izqda.
     113042 | Bisagra Dcha.
     113045 | Bisagra Dcha.
     112993 | V Stago Trinquete
     113034 | V Stago Trinquete
     113027 | Articulo Tipo 2
     112992 | Articulo Tipo 2
     113012 | Articulo Tipo 3
     112997 | Manivela
     113013 | Manivela
     112968 | Articulo Tipo 4
     112963 | Articulo Tipo 4
     112983 | Articulo Tipo 4
     113055 | Ajustador
     113057 | Ajustador
     112987 | Extractor
     110036 | Montador
     112979 | Montador
     113007 | Riostra 1/2-Tm
     113069 | Riostra 1-Tm
     113003 | Riostra 2-Tm
     113048 | Riostra 2-Tm
     113051 | 
     113065 | Reductor
     113049 | Reductor
     113024 | Reductor
(30 rows)



-- FUNCIONA ESTO 1

SELECT pe.num_pedido, pr.descripcion, re.num_empl, re.nombre, o.ciudad -- nombre del producto, Codigo y nombre del vndedor y oficina del vendedor
FROM pedidos pe
LEFT JOIN productos pr
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN repventas re
ON pe.rep = re.num_empl 
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina;

 num_pedido |    descripcion    | num_empl |    nombre     |   ciudad    
------------+-------------------+----------+---------------+-------------
     113058 | Cubierta          |      109 | Mary Jones    | New York
     112989 | Bancada Motor     |      106 | Sam Clark     | New York
     113062 | Bancada Motor     |      107 | Nancy Angelli | Denver
     112975 | Pasador Bisagra   |      103 | Paul Cruz     | Chicago
     112961 | Bisagra Izqda.    |      106 | Sam Clark     | New York
     113042 | Bisagra Dcha.     |      101 | Dan Roberts   | Chicago
     113045 | Bisagra Dcha.     |      108 | Larry Fitch   | Los Angeles
     112993 | V Stago Trinquete |      102 | Sue Smith     | Los Angeles
     113034 | V Stago Trinquete |      110 | Tom Snyder    | 
     113027 | Articulo Tipo 2   |      105 | Bill Adams    | Atlanta
     112992 | Articulo Tipo 2   |      108 | Larry Fitch   | Los Angeles
     113012 | Articulo Tipo 3   |      105 | Bill Adams    | Atlanta
     112997 | Manivela          |      107 | Nancy Angelli | Denver
     113013 | Manivela          |      108 | Larry Fitch   | Los Angeles
     112968 | Articulo Tipo 4   |      101 | Dan Roberts   | Chicago
     112963 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta
     112983 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta
     113055 | Ajustador         |      101 | Dan Roberts   | Chicago
     113057 | Ajustador         |      103 | Paul Cruz     | Chicago
     112987 | Extractor         |      105 | Bill Adams    | Atlanta
     110036 | Montador          |      110 | Tom Snyder    | 
     112979 | Montador          |      102 | Sue Smith     | Los Angeles
     113007 | Riostra 1/2-Tm    |      108 | Larry Fitch   | Los Angeles
     113069 | Riostra 1-Tm      |      107 | Nancy Angelli | Denver
     113003 | Riostra 2-Tm      |      109 | Mary Jones    | New York
     113048 | Riostra 2-Tm      |      102 | Sue Smith     | Los Angeles
     113051 |                   |      108 | Larry Fitch   | Los Angeles
     113065 | Reductor          |      102 | Sue Smith     | Los Angeles
     113049 | Reductor          |      108 | Larry Fitch   | Los Angeles
     113024 | Reductor          |      108 | Larry Fitch   | Los Angeles
(30 rows)



-- FUNCIONA ESTO 2

SELECT pe.num_pedido, pr.descripcion, re.num_empl, re.nombre, o.ciudad, dir.num_empl, dir.nombre -- director del vendedor
FROM pedidos pe
LEFT JOIN productos pr
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN repventas re
ON re.num_empl = pe.rep
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina
LEFT JOIN repventas dir
ON re.oficina_rep = dir.num_empl ; -- SE PUEDE PONER AL REVES ON dir.num_empl = re.director;

 num_pedido |    descripcion    | num_empl |    nombre     |   ciudad    | num_empl |   nombre    
------------+-------------------+----------+---------------+-------------+----------+-------------
     113058 | Cubierta          |      109 | Mary Jones    | New York    |      106 | Sam Clark
     112989 | Bancada Motor     |      106 | Sam Clark     | New York    |          | 
     113062 | Bancada Motor     |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch
     112975 | Pasador Bisagra   |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith
     112961 | Bisagra Izqda.    |      106 | Sam Clark     | New York    |          | 
     113042 | Bisagra Dcha.     |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith
     113045 | Bisagra Dcha.     |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     112993 | V Stago Trinquete |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     113034 | V Stago Trinquete |      110 | Tom Snyder    |             |      101 | Dan Roberts
     113027 | Articulo Tipo 2   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     112992 | Articulo Tipo 2   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113012 | Articulo Tipo 3   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     112997 | Manivela          |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch
     113013 | Manivela          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     112968 | Articulo Tipo 4   |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith
     112963 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     112983 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     113055 | Ajustador         |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith
     113057 | Ajustador         |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith
     112987 | Extractor         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     110036 | Montador          |      110 | Tom Snyder    |             |      101 | Dan Roberts
     112979 | Montador          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     113007 | Riostra 1/2-Tm    |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113069 | Riostra 1-Tm      |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch
     113003 | Riostra 2-Tm      |      109 | Mary Jones    | New York    |      106 | Sam Clark
     113048 | Riostra 2-Tm      |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     113051 |                   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113065 | Reductor          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     113049 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113024 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
(30 rows)





-- FUNCIONA ESTO 3

SELECT pe.num_pedido, pr.descripcion, re.num_empl, re.nombre, o.ciudad, dir.num_empl, dir.nombre, cl.num_clie, cl.empresa -- Cliente que compró la comanda
FROM pedidos pe
LEFT JOIN productos pr
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN repventas re
ON pe.rep = re.num_empl 
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina
LEFT JOIN repventas dir
ON re.director = dir.num_empl 
LEFT JOIN clientes cl
ON pe.clie = cl.num_clie;

 num_pedido |    descripcion    | num_empl |    nombre     |   ciudad    | num_empl |   nombre    | num_clie |      empresa      
------------+-------------------+----------+---------------+-------------+----------+-------------+----------+-------------------
     113058 | Cubierta          |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis
     112989 | Bancada Motor     |      106 | Sam Clark     | New York    |          |             |     2101 | Jones Mfg.
     113062 | Bancada Motor     |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers
     112975 | Pasador Bisagra   |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.
     112961 | Bisagra Izqda.    |      106 | Sam Clark     | New York    |          |             |     2117 | J.P. Sinclair
     113042 | Bisagra Dcha.     |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2113 | Ian & Schmidt
     113045 | Bisagra Dcha.     |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp
     112993 | V Stago Trinquete |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.
     113034 | V Stago Trinquete |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International
     113027 | Articulo Tipo 2   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.
     112992 | Articulo Tipo 2   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems
     113012 | Articulo Tipo 3   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2111 | JCP Inc.
     112997 | Manivela          |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers
     113013 | Manivela          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems
     112968 | Articulo Tipo 4   |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2102 | First Corp.
     112963 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.
     112983 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.
     113055 | Ajustador         |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2108 | Holm & Landis
     113057 | Ajustador         |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.
     112987 | Extractor         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.
     110036 | Montador          |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International
     112979 | Montador          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2114 | Orion Corp
     113007 | Riostra 1/2-Tm    |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp
     113069 | Riostra 1-Tm      |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2109 | Chen Associates
     113003 | Riostra 2-Tm      |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis
     113048 | Riostra 2-Tm      |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2120 | Rico Enterprises
     113051 |                   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems
     113065 | Reductor          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.
     113049 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems
     113024 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2114 | Orion Corp
(30 rows)
 
 
 
 -- FUNCIONA ESTO 4

SELECT pe.num_pedido, pr.descripcion, re.num_empl, re.nombre, o.ciudad, dir.num_empl, dir.nombre, cl.num_clie, cl.empresa, clven.num_empl, clven.nombre -- Codi i nom del venedor assignat al client 
FROM pedidos pe
LEFT JOIN productos pr 
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN repventas re
ON pe.rep = re.num_empl
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina 
LEFT JOIN repventas dir
ON re.director = dir.num_empl
LEFT JOIN clientes cl
ON pe.clie = cl.num_clie
JOIN repventas clven
ON cl.rep_clie = clven.num_empl
ORDER BY cl.num_clie;


 num_pedido |    descripcion    | num_empl |    nombre     |   ciudad    | num_empl |   nombre    | num_clie |      empresa      | num_empl |    nombre     
------------+-------------------+----------+---------------+-------------+----------+-------------+----------+-------------------+----------+---------------
     113058 | Cubierta          |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis     |      109 | Mary Jones
     112989 | Bancada Motor     |      106 | Sam Clark     | New York    |          |             |     2101 | Jones Mfg.        |      106 | Sam Clark
     113062 | Bancada Motor     |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers    |      107 | Nancy Angelli
     112975 | Pasador Bisagra   |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz
     112961 | Bisagra Izqda.    |      106 | Sam Clark     | New York    |          |             |     2117 | J.P. Sinclair     |      106 | Sam Clark
     113042 | Bisagra Dcha.     |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2113 | Ian & Schmidt     |      104 | Bob Smith
     113045 | Bisagra Dcha.     |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp          |      108 | Larry Fitch
     112993 | V Stago Trinquete |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.  |      102 | Sue Smith
     113034 | V Stago Trinquete |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International |      110 | Tom Snyder
     113027 | Articulo Tipo 2   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams
     112992 | Articulo Tipo 2   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch
     113012 | Articulo Tipo 3   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz
     112997 | Manivela          |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers    |      107 | Nancy Angelli
     113013 | Manivela          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch
     112968 | Articulo Tipo 4   |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2102 | First Corp.       |      101 | Dan Roberts
     112963 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams
     112983 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams
     113055 | Ajustador         |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2108 | Holm & Landis     |      109 | Mary Jones
     113057 | Ajustador         |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz
     112987 | Extractor         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams
     110036 | Montador          |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International |      110 | Tom Snyder
     112979 | Montador          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2114 | Orion Corp        |      102 | Sue Smith
     113007 | Riostra 1/2-Tm    |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp          |      108 | Larry Fitch
     113069 | Riostra 1-Tm      |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2109 | Chen Associates   |      103 | Paul Cruz
     113003 | Riostra 2-Tm      |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis     |      109 | Mary Jones
     113048 | Riostra 2-Tm      |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2120 | Rico Enterprises  |      102 | Sue Smith
     113051 |                   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch
     113065 | Reductor          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.  |      102 | Sue Smith
     113049 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch
     113024 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2114 | Orion Corp        |      102 | Sue Smith
(30 rows)


 -- FUNCIONA ESTO 5

SELECT pe.num_pedido, pr.descripcion, re.num_empl, re.nombre, o.ciudad, dir.num_empl, dir.nombre, cl.num_clie, cl.empresa, clven.num_empl, clven.nombre, clvenofi.ciudad -- Ciutat de l'oficina del venedor assignat al client 
FROM pedidos pe
LEFT JOIN productos pr 
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN repventas re
ON pe.rep = re.num_empl
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina 
LEFT JOIN repventas dir
ON re.director = dir.num_empl
LEFT JOIN clientes cl
ON pe.clie = cl.num_clie 
JOIN repventas clven
ON cl.rep_clie = clven.num_empl 
LEFT JOIN oficinas clvenofi
ON clven.oficina_rep = clvenofi.oficina
ORDER BY cl.num_clie;

 num_pedido |    descripcion    | num_empl |    nombre     |   ciudad    | num_empl |   nombre    | num_clie |      empresa      | num_empl |    nombre     |   ciudad    
------------+-------------------+----------+---------------+-------------+----------+-------------+----------+-------------------+----------+---------------+-------------
     112989 | Bancada Motor     |      106 | Sam Clark     | New York    |          |             |     2101 | Jones Mfg.        |      106 | Sam Clark     | New York
     112968 | Articulo Tipo 4   |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2102 | First Corp.       |      101 | Dan Roberts   | Chicago
     113027 | Articulo Tipo 2   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta
     112987 | Extractor         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta
     112983 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta
     112963 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta
     113065 | Reductor          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.  |      102 | Sue Smith     | Los Angeles
     112993 | V Stago Trinquete |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.  |      102 | Sue Smith     | Los Angeles
     110036 | Montador          |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International |      110 | Tom Snyder    | 
     113034 | V Stago Trinquete |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International |      110 | Tom Snyder    | 
     113058 | Cubierta          |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York
     113055 | Ajustador         |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York
     113003 | Riostra 2-Tm      |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York
     113069 | Riostra 1-Tm      |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2109 | Chen Associates   |      103 | Paul Cruz     | Chicago
     113012 | Articulo Tipo 3   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago
     113057 | Ajustador         |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago
     112975 | Pasador Bisagra   |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago
     113045 | Bisagra Dcha.     |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp          |      108 | Larry Fitch   | Los Angeles
     113007 | Riostra 1/2-Tm    |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp          |      108 | Larry Fitch   | Los Angeles
     113042 | Bisagra Dcha.     |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2113 | Ian & Schmidt     |      104 | Bob Smith     | Chicago
     113024 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2114 | Orion Corp        |      102 | Sue Smith     | Los Angeles
     112979 | Montador          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2114 | Orion Corp        |      102 | Sue Smith     | Los Angeles
     112961 | Bisagra Izqda.    |      106 | Sam Clark     | New York    |          |             |     2117 | J.P. Sinclair     |      106 | Sam Clark     | New York
     113013 | Manivela          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles
     112992 | Articulo Tipo 2   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles
     113049 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles
     113051 |                   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles
     113048 | Riostra 2-Tm      |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2120 | Rico Enterprises  |      102 | Sue Smith     | Los Angeles
     113062 | Bancada Motor     |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers    |      107 | Nancy Angelli | Denver
     112997 | Manivela          |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers    |      107 | Nancy Angelli | Denver
(30 rows)



 -- FUNCIONA ESTO 6

SELECT pe.num_pedido, pr.descripcion, re.num_empl, re.nombre, o.ciudad, dir.num_empl, dir.nombre, cl.num_clie, cl.empresa, clven.num_empl, clven.nombre, clvenofi.ciudad, clvendir.num_empl, clvendir.nombre -- Codi i nom del cap del venedor assignat al client 
FROM pedidos pe
LEFT JOIN productos pr 
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN repventas re
ON pe.rep = re.num_empl
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina
LEFT JOIN repventas dir
ON re.director = dir.num_empl
LEFT JOIN clientes cl
ON pe.clie = cl.num_clie 
JOIN repventas clven
ON cl.rep_clie = clven.num_empl
LEFT JOIN oficinas clvenofi
ON clven.oficina_rep = clvenofi.oficina
LEFT JOIN repventas clvendir
ON clven.director = clvendir.num_empl
ORDER BY cl.num_clie;



 num_pedido |    descripcion    | num_empl |    nombre     |   ciudad    | num_empl |   nombre    | num_clie |      empresa      | num_empl |    nombre     |   ciudad    | num_empl |   nombre    
------------+-------------------+----------+---------------+-------------+----------+-------------+----------+-------------------+----------+---------------+-------------+----------+-------------
     112989 | Bancada Motor     |      106 | Sam Clark     | New York    |          |             |     2101 | Jones Mfg.        |      106 | Sam Clark     | New York    |          | 
     112968 | Articulo Tipo 4   |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2102 | First Corp.       |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith
     113027 | Articulo Tipo 2   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     112987 | Extractor         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     112983 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     112963 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     113065 | Reductor          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.  |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     112993 | V Stago Trinquete |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.  |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     110036 | Montador          |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International |      110 | Tom Snyder    |             |      101 | Dan Roberts
     113034 | V Stago Trinquete |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International |      110 | Tom Snyder    |             |      101 | Dan Roberts
     113058 | Cubierta          |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York    |      106 | Sam Clark
     113055 | Ajustador         |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York    |      106 | Sam Clark
     113003 | Riostra 2-Tm      |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York    |      106 | Sam Clark
     113069 | Riostra 1-Tm      |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2109 | Chen Associates   |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith
     113012 | Articulo Tipo 3   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith
     113057 | Ajustador         |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith
     112975 | Pasador Bisagra   |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith
     113045 | Bisagra Dcha.     |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113007 | Riostra 1/2-Tm    |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113042 | Bisagra Dcha.     |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2113 | Ian & Schmidt     |      104 | Bob Smith     | Chicago     |      106 | Sam Clark
     113024 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2114 | Orion Corp        |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     112979 | Montador          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2114 | Orion Corp        |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     112961 | Bisagra Izqda.    |      106 | Sam Clark     | New York    |          |             |     2117 | J.P. Sinclair     |      106 | Sam Clark     | New York    |          | 
     113013 | Manivela          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     112992 | Articulo Tipo 2   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113049 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113051 |                   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113048 | Riostra 2-Tm      |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2120 | Rico Enterprises  |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     113062 | Bancada Motor     |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers    |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch
     112997 | Manivela          |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers    |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch
(30 rows)





 -- FUNCIONA ESTO 7 FINAAAL

SELECT pe.num_pedido, pr.descripcion, re.num_empl, re.nombre, o.ciudad, dir.num_empl, dir.nombre, cl.num_clie, cl.empresa, clven.num_empl, clven.nombre, clvenofi.ciudad, clvendir.num_empl, clvendir.nombre, pe.importe -- Codi i nom del cap del venedor assignat al client 
FROM pedidos pe
LEFT JOIN productos pr 
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN repventas re
ON pe.rep = re.num_empl
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina 
LEFT JOIN repventas dir
ON re.director = dir.num_empl
LEFT JOIN clientes cl
ON pe.clie = cl.num_clie 
JOIN repventas clven
ON cl.rep_clie = clven.num_empl
LEFT JOIN oficinas clvenofi
ON clven.oficina_rep = clvenofi.oficina
LEFT JOIN repventas clvendir
ON clven.director = clvendir.num_empl
ORDER BY cl.num_clie;


 num_pedido |    descripcion    | num_empl |    nombre     |   ciudad    | num_empl |   nombre    | num_clie |      empresa      | num_empl |    nombre     |   ciudad    | num_empl |   nombre    | importe  
------------+-------------------+----------+---------------+-------------+----------+-------------+----------+-------------------+----------+---------------+-------------+----------+-------------+----------
     112989 | Bancada Motor     |      106 | Sam Clark     | New York    |          |             |     2101 | Jones Mfg.        |      106 | Sam Clark     | New York    |          |             |  1458.00
     112968 | Articulo Tipo 4   |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2102 | First Corp.       |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |  3978.00
     113027 | Articulo Tipo 2   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |  4104.00
     112987 | Extractor         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   | 27500.00
     112983 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |   702.00
     112963 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |  3276.00
     113065 | Reductor          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.  |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |  2130.00
     112993 | V Stago Trinquete |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.  |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |  1896.00
     110036 | Montador          |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International |      110 | Tom Snyder    |             |      101 | Dan Roberts | 22500.00
     113034 | V Stago Trinquete |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International |      110 | Tom Snyder    |             |      101 | Dan Roberts |   632.00
     113058 | Cubierta          |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York    |      106 | Sam Clark   |  1480.00
     113055 | Ajustador         |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York    |      106 | Sam Clark   |   150.00
     113003 | Riostra 2-Tm      |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York    |      106 | Sam Clark   |  5625.00
     113069 | Riostra 1-Tm      |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2109 | Chen Associates   |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   | 31350.00
     113012 | Articulo Tipo 3   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |  3745.00
     113057 | Ajustador         |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |   600.00
     112975 | Pasador Bisagra   |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |  2100.00
     113045 | Bisagra Dcha.     |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   | 45000.00
     113007 | Riostra 1/2-Tm    |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |  2925.00
     113042 | Bisagra Dcha.     |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2113 | Ian & Schmidt     |      104 | Bob Smith     | Chicago     |      106 | Sam Clark   | 22500.00
     113024 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2114 | Orion Corp        |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |  7100.00
     112979 | Montador          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2114 | Orion Corp        |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch | 15000.00
     112961 | Bisagra Izqda.    |      106 | Sam Clark     | New York    |          |             |     2117 | J.P. Sinclair     |      106 | Sam Clark     | New York    |          |             | 31500.00
     113013 | Manivela          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |   652.00
     112992 | Articulo Tipo 2   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |   760.00
     113049 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |   776.00
     113051 |                   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |  1420.00
     113048 | Riostra 2-Tm      |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2120 | Rico Enterprises  |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |  3750.00
     113062 | Bancada Motor     |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers    |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |  2430.00
     112997 | Manivela          |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers    |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |   652.00
(30 rows)
