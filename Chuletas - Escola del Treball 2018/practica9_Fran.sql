-- 21.- Es desitja un llistat d'identificadors de fabricants de productes. Només volem tenir en compte els productes de preu 
-- superior a 54. Només volem que apareguin els fabricants amb un nombre total d'unitats superior a 300.
training=# SELECT id_fab, sum(existencias) AS "totalunitats" FROM productos WHERE precio > 54 GROUP BY id_fab HAVING sum(existencias) > 300; 
 id_fab | totalunitats 
--------+--------------
 aci    |          843
(1 row)

-- 22.Es desitja un llistat dels productes amb les seves descripcions, ordenat per la suma total d'imports facturats (pedidos) de 
-- cada producte de l'any 1989.
training=# SELECT pr.id_fab, pr.id_producto, pr.descripcion, SUM(pe.importe) FROM productos pr JOIN pedidos pe ON pr.id_producto = pe.producto AND pr.id_fab = pe.fab WHERE pe.fecha_pedido >= '1989-01-01' AND pe.fecha_pedido <= '1989-12-31' GROUP BY pr.id_fab, pr.id_producto ORDER BY 4;
 id_fab | id_producto |    descripcion    |   sum    
--------+-------------+-------------------+----------
 aci    | 41002       | Articulo Tipo 2   |   760.00
 rei    | 2a45c       | V Stago Trinquete |  1896.00
 rei    | 2a44g       | Pasador Bisagra   |  2100.00
 aci    | 41004       | Articulo Tipo 4   |  7956.00
 aci    | 4100z       | Montador          | 15000.00
 aci    | 4100y       | Extractor         | 27500.00
 rei    | 2a44l       | Bisagra Izqda.    | 31500.00
(7 rows)

identificar els productes amb id_fab, id_producto (group by)

-- 23. Per a cada director (de personal, no d'oficina) excepte per al gerent (el venedor que no té director), vull saber el total  
-- de vendes dels seus subordinats. Mostreu codi i nom dels directors.
training=# SELECT jefe.num_empl, jefe.nombre, sum(importe) FROM repventas jefe JOIN repventas venedors ON jefe.num_empl = venedors.director JOIN pedidos ON venedors.num_empl = rep GROUP BY jefe.num_empl;
 num_empl |   nombre    |   sum    
----------+-------------+----------
      106 | Sam Clark   | 65738.00
      101 | Dan Roberts | 23132.00
      104 | Bob Smith   | 68655.00
      108 | Larry Fitch | 57208.00
(4 rows)

-- Exeptee el treballador que no te cap
training=# SELECT jefe.num_empl, jefe.nombre, sum(importe) FROM repventas jefe LEFT JOIN repventas venedors ON jefe.num_empl = venedors.director RIGHT JOIN pedidos ON venedors.num_empl = rep GROUP BY jefe.num_empl;
 num_empl |   nombre    |   sum    
----------+-------------+----------
          |             | 32958.00
      106 | Sam Clark   | 65738.00
      101 | Dan Roberts | 23132.00
      104 | Bob Smith   | 68655.00
      108 | Larry Fitch | 57208.00
(5 rows)



-- 24. Quins són els 5 productes que han estat venuts a més clients diferents? Mostreu el número de clients per cada producte. 
-- A igualtat de nombre de clients es volen ordenats per ordre decreixent d'existències i, a igualtat d'existències, per 
-- descripció. Mostreu tots els camps pels quals s'ordena.



-- 25. Es vol llistar el clients (codi i empresa) tals que no hagin comprat cap tipus de frontissa ("bisagra" en castellà, figura 
-- a la descripció) i hagin comprat articles de més d'un fabricant diferent.

-- 26. Llisteu les oficines per ordre descendent de nombre total de clients diferents amb comandes (pedidos) realizades pels venedors 
-- d'aquella oficina, i, a igualtat de clients, ordenat per ordre ascendent del nom del director de l'oficina. Només s'ha de mostrar el codi i la ciutat de l'oficina.



-- 27.Llista totes les comandes mostrant el seu número, import, nom de client i límit de crèdit. 
training=# SELECT p.num_pedido, p.importe, p.clie, c.num_clie, c.limite_credito FROM pedidos p LEFT JOIN clientes c ON c.num_clie = p.clie;
 num_pedido | importe  | clie | num_clie | limite_credito 
------------+----------+------+----------+----------------
     112961 | 31500.00 | 2117 |     2117 |       35000.00
     113012 |  3745.00 | 2111 |     2111 |       50000.00
     112989 |  1458.00 | 2101 |     2101 |       65000.00
     113051 |  1420.00 | 2118 |     2118 |       60000.00
     112968 |  3978.00 | 2102 |     2102 |       65000.00
     110036 | 22500.00 | 2107 |     2107 |       35000.00
     113045 | 45000.00 | 2112 |     2112 |       50000.00
     112963 |  3276.00 | 2103 |     2103 |       50000.00
     113013 |   652.00 | 2118 |     2118 |       60000.00
     113058 |  1480.00 | 2108 |     2108 |       55000.00
     112997 |   652.00 | 2124 |     2124 |       40000.00
     112983 |   702.00 | 2103 |     2103 |       50000.00
     113024 |  7100.00 | 2114 |     2114 |       20000.00
     113062 |  2430.00 | 2124 |     2124 |       40000.00
     112979 | 15000.00 | 2114 |     2114 |       20000.00
     113027 |  4104.00 | 2103 |     2103 |       50000.00
     113007 |  2925.00 | 2112 |     2112 |       50000.00
     113069 | 31350.00 | 2109 |     2109 |       25000.00
     113034 |   632.00 | 2107 |     2107 |       35000.00
     112992 |   760.00 | 2118 |     2118 |       60000.00
     112975 |  2100.00 | 2111 |     2111 |       50000.00
     113055 |   150.00 | 2108 |     2108 |       55000.00
     113048 |  3750.00 | 2120 |     2120 |       50000.00
     112993 |  1896.00 | 2106 |     2106 |       65000.00
     113065 |  2130.00 | 2106 |     2106 |       65000.00
     113003 |  5625.00 | 2108 |     2108 |       55000.00
     113049 |   776.00 | 2118 |     2118 |       60000.00
     112987 | 27500.00 | 2103 |     2103 |       50000.00
     113057 |   600.00 | 2111 |     2111 |       50000.00
     113042 | 22500.00 | 2113 |     2113 |       20000.00
(30 rows)

-- 28.Llista cada un dels venedors i la ciutat i regió on treballen 
training=# SELECT r.num_empl, r.oficina_rep, o.oficina, o.ciudad, o.region FROM repventas r LEFT JOIN oficinas o ON o.oficina = r.oficina_rep;
 num_empl | oficina_rep | oficina |   ciudad    | region 
----------+-------------+---------+-------------+--------
      105 |          13 |      13 | Atlanta     | Este
      109 |          11 |      11 | New York    | Este
      102 |          21 |      21 | Los Angeles | Oeste
      106 |          11 |      11 | New York    | Este
      104 |          12 |      12 | Chicago     | Este
      101 |          12 |      12 | Chicago     | Este
      110 |             |         |             | 
      108 |          21 |      21 | Los Angeles | Oeste
      103 |          12 |      12 | Chicago     | Este
      107 |          22 |      22 | Denver      | Oeste
(10 rows)

-- 29.Llista les oficines, i els noms i títols dels directors. 
training=# SELECT DISTINCT o.oficina, o.ciudad, o.dir, o.objetivo, r.director FROM repventas r, oficinas o;
 oficina |   ciudad    | dir | objetivo  | director 
---------+-------------+-----+-----------+----------
      11 | New York    | 106 | 575000.00 |      101
      11 | New York    | 106 | 575000.00 |      104
      11 | New York    | 106 | 575000.00 |      106
      11 | New York    | 106 | 575000.00 |      108
      11 | New York    | 106 | 575000.00 |         
      12 | Chicago     | 104 | 800000.00 |      101
      12 | Chicago     | 104 | 800000.00 |      104
      12 | Chicago     | 104 | 800000.00 |      106
      12 | Chicago     | 104 | 800000.00 |      108
      12 | Chicago     | 104 | 800000.00 |         
      13 | Atlanta     | 105 | 350000.00 |      101
      13 | Atlanta     | 105 | 350000.00 |      104
      13 | Atlanta     | 105 | 350000.00 |      106
      13 | Atlanta     | 105 | 350000.00 |      108
      13 | Atlanta     | 105 | 350000.00 |         
      21 | Los Angeles | 108 | 725000.00 |      101
      21 | Los Angeles | 108 | 725000.00 |      104
      21 | Los Angeles | 108 | 725000.00 |      106
      21 | Los Angeles | 108 | 725000.00 |      108
      21 | Los Angeles | 108 | 725000.00 |         
      22 | Denver      | 108 | 300000.00 |      101
      22 | Denver      | 108 | 300000.00 |      104
      22 | Denver      | 108 | 300000.00 |      106
      22 | Denver      | 108 | 300000.00 |      108
      22 | Denver      | 108 | 300000.00 |         
(25 rows)

-- 30.Llista les oficines, noms i titols del seus directors amb un objectiu superior a 600.000. 
training=# SELECT DISTINCT o.oficina, o.ciudad, o.dir, o.objetivo, r.director FROM repventas r RIGHT JOIN oficinas o ON o.objetivo > 600.000;
 oficina |   ciudad    | dir | objetivo  | director 
---------+-------------+-----+-----------+----------
      11 | New York    | 106 | 575000.00 |      101
      11 | New York    | 106 | 575000.00 |      104
      11 | New York    | 106 | 575000.00 |      106
      11 | New York    | 106 | 575000.00 |      108
      11 | New York    | 106 | 575000.00 |         
      12 | Chicago     | 104 | 800000.00 |      101
      12 | Chicago     | 104 | 800000.00 |      104
      12 | Chicago     | 104 | 800000.00 |      106
      12 | Chicago     | 104 | 800000.00 |      108
      12 | Chicago     | 104 | 800000.00 |         
      13 | Atlanta     | 105 | 350000.00 |      101
      13 | Atlanta     | 105 | 350000.00 |      104
      13 | Atlanta     | 105 | 350000.00 |      106
      13 | Atlanta     | 105 | 350000.00 |      108
      13 | Atlanta     | 105 | 350000.00 |         
      21 | Los Angeles | 108 | 725000.00 |      101
      21 | Los Angeles | 108 | 725000.00 |      104
      21 | Los Angeles | 108 | 725000.00 |      106
      21 | Los Angeles | 108 | 725000.00 |      108
      21 | Los Angeles | 108 | 725000.00 |         
      22 | Denver      | 108 | 300000.00 |      101
      22 | Denver      | 108 | 300000.00 |      104
      22 | Denver      | 108 | 300000.00 |      106
      22 | Denver      | 108 | 300000.00 |      108
      22 | Denver      | 108 | 300000.00 |         
(25 rows)


