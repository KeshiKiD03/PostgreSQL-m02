-- 4.1- Llista la ciutat de les oficines, i el nom i títol dels directors de cada oficina.
SELECT ciudad , nombre , titulo 
FROM oficinas , repventas 
WHERE dir = num_empl;

   ciudad    |   nombre    |   titulo   
-------------+-------------+------------
 Denver      | Larry Fitch | Dir Ventas
 New York    | Sam Clark   | VP Ventas
 Chicago     | Bob Smith   | Dir Ventas
 Atlanta     | Bill Adams  | Rep Ventas
 Los Angeles | Larry Fitch | Dir Ventas
(5 rows)



-- 4.2- Llista totes les comandes mostrant el seu número, import, número de client i límit de crèdit.
SELECT num_pedido , importe , clie , limite_credito 
FROM pedidos , clientes 
WHERE num_clie = clie;

 num_pedido | importe  | clie | limite_credito 
------------+----------+------+----------------
     112961 | 31500.00 | 2117 |       35000.00
     113012 |  3745.00 | 2111 |       50000.00
     112989 |  1458.00 | 2101 |       65000.00
     113051 |  1420.00 | 2118 |       60000.00
     112968 |  3978.00 | 2102 |       65000.00
     110036 | 22500.00 | 2107 |       35000.00
     113045 | 45000.00 | 2112 |       50000.00
     112963 |  3276.00 | 2103 |       50000.00
     113013 |   652.00 | 2118 |       60000.00
     113058 |  1480.00 | 2108 |       55000.00
     112997 |   652.00 | 2124 |       40000.00
     112983 |   702.00 | 2103 |       50000.00
     113024 |  7100.00 | 2114 |       20000.00
     113062 |  2430.00 | 2124 |       40000.00
     112979 | 15000.00 | 2114 |       20000.00
     113027 |  4104.00 | 2103 |       50000.00
     113007 |  2925.00 | 2112 |       50000.00
     113069 | 31350.00 | 2109 |       25000.00
     113034 |   632.00 | 2107 |       35000.00
     112992 |   760.00 | 2118 |       60000.00
     112975 |  2100.00 | 2111 |       50000.00
     113055 |   150.00 | 2108 |       55000.00
     113048 |  3750.00 | 2120 |       50000.00
     112993 |  1896.00 | 2106 |       65000.00
     113065 |  2130.00 | 2106 |       65000.00
     113003 |  5625.00 | 2108 |       55000.00
     113049 |   776.00 | 2118 |       60000.00
     112987 | 27500.00 | 2103 |       50000.00
     113057 |   600.00 | 2111 |       50000.00
     113042 | 22500.00 | 2113 |       20000.00
(30 rows)



-- 4.3- Llista el número de totes les comandes amb la descripció del producte demanat.
SELECT num_pedido , descripcion 
FROM pedidos , productos 
WHERE fab = id_fab and producto = id_producto;

 num_pedido |    descripcion    
------------+-------------------
     113027 | Articulo Tipo 2
     112992 | Articulo Tipo 2
     113012 | Articulo Tipo 3
     112963 | Articulo Tipo 4
     112983 | Articulo Tipo 4
     112968 | Articulo Tipo 4
     113055 | Ajustador
     113057 | Ajustador
     112987 | Extractor
     110036 | Montador
     112979 | Montador
     112997 | Manivela
     113013 | Manivela
     113058 | Cubierta
     113062 | Bancada Motor
     112989 | Bancada Motor
     113007 | Riostra 1/2-Tm
     113069 | Riostra 1-Tm
     113048 | Riostra 2-Tm
     113003 | Riostra 2-Tm
     113065 | Reductor
     113024 | Reductor
     113049 | Reductor
     112975 | Pasador Bisagra
     112961 | Bisagra Izqda.
     113045 | Bisagra Dcha.
     113042 | Bisagra Dcha.
     112993 | V Stago Trinquete
     113034 | V Stago Trinquete
(29 rows)



-- 4.4- Llista el nom de tots els clients amb el nom del representant de vendes assignat.
SELECT empresa , nombre 
FROM clientes , repventas 
WHERE rep_clie = num_empl;

      empresa      |    nombre     
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



-- 4.5- Llista la data de totes les comandes amb el numero i nom del client de la comanda.
SELECT fecha_pedido , clie , empresa 
FROM pedidos , clientes 
WHERE num_clie = clie;

 fecha_pedido | clie |      empresa      
--------------+------+-------------------
 1989-12-17   | 2117 | J.P. Sinclair
 1990-01-11   | 2111 | JCP Inc.
 1990-01-03   | 2101 | Jones Mfg.
 1990-02-10   | 2118 | Midwest Systems
 1989-10-12   | 2102 | First Corp.
 1990-01-30   | 2107 | Ace International
 1990-02-02   | 2112 | Zetacorp
 1989-12-17   | 2103 | Acme Mfg.
 1990-01-14   | 2118 | Midwest Systems
 1990-02-23   | 2108 | Holm & Landis
 1990-01-08   | 2124 | Peter Brothers
 1989-12-27   | 2103 | Acme Mfg.
 1990-01-20   | 2114 | Orion Corp
 1990-02-24   | 2124 | Peter Brothers
 1989-10-12   | 2114 | Orion Corp
 1990-01-22   | 2103 | Acme Mfg.
 1990-01-08   | 2112 | Zetacorp
 1990-03-02   | 2109 | Chen Associates
 1990-01-29   | 2107 | Ace International
 1989-11-04   | 2118 | Midwest Systems
 1989-12-12   | 2111 | JCP Inc.
 1990-02-15   | 2108 | Holm & Landis
 1990-02-10   | 2120 | Rico Enterprises
 1989-01-04   | 2106 | Fred Lewis Corp.
 1990-02-27   | 2106 | Fred Lewis Corp.
 1990-01-25   | 2108 | Holm & Landis
 1990-02-10   | 2118 | Midwest Systems
 1989-12-31   | 2103 | Acme Mfg.
 1990-02-18   | 2111 | JCP Inc.
 1990-02-02   | 2113 | Ian & Schmidt
(30 rows)



-- 4.6- Llista les oficines, noms i títols del seus directors amb un objectiu superior a 600.000.
SELECT oficina , ciudad , nombre , titulo 
FROM oficinas , repventas 
WHERE (dir = num_empl) and objetivo > 600000;

 oficina |   ciudad    |   nombre    |   titulo   
---------+-------------+-------------+------------
      12 | Chicago     | Bob Smith   | Dir Ventas
      21 | Los Angeles | Larry Fitch | Dir Ventas
(2 rows)



-- 4.7- Llista els venedors de les oficines de la regió est.
SELECT num_empl , nombre , oficina, ciudad 
FROM repventas , oficinas 
WHERE (dir = num_empl) and region = 'Este';

 num_empl |   nombre   | oficina |  ciudad  
----------+------------+---------+----------
      105 | Bill Adams |      13 | Atlanta
      106 | Sam Clark  |      11 | New York
      104 | Bob Smith  |      12 | Chicago
(3 rows)



-- 4.8- Llista les comandes superiors a 25000, incloent el nom del venedor que va servir la comanda 
--		i el nom del client que el va sol·licitar.
SELECT pedidos.* , nombre , empresa 
FROM pedidos , repventas , clientes 
WHERE (clie = num_clie) and (rep = num_empl) and importe > 25000;

 num_pedido | fecha_pedido | clie | rep | fab | producto | cant | importe  |    nombre     |     empresa     
------------+--------------+------+-----+-----+----------+------+----------+---------------+-----------------
     112961 | 1989-12-17   | 2117 | 106 | rei | 2a44l    |    7 | 31500.00 | Sam Clark     | J.P. Sinclair
     113045 | 1990-02-02   | 2112 | 108 | rei | 2a44r    |   10 | 45000.00 | Larry Fitch   | Zetacorp
     113069 | 1990-03-02   | 2109 | 107 | imm | 775c     |   22 | 31350.00 | Nancy Angelli | Chen Associates
     112987 | 1989-12-31   | 2103 | 105 | aci | 4100y    |   11 | 27500.00 | Bill Adams    | Acme Mfg.
(4 rows)



-- 4.9- Llista les comandes superiors a 25000, mostrant el client que va servir la comanda i el 
--		nom del venedor que té assignat el client.
SELECT pedidos.* , empresa , nombre  
FROM pedidos , repventas , clientes 
WHERE (clie = num_clie) and (rep_clie = num_empl) and importe > 25000;

 num_pedido | fecha_pedido | clie | rep | fab | producto | cant | importe  |     empresa     |   nombre    
------------+--------------+------+-----+-----+----------+------+----------+-----------------+-------------
     112961 | 1989-12-17   | 2117 | 106 | rei | 2a44l    |    7 | 31500.00 | J.P. Sinclair   | Sam Clark
     113045 | 1990-02-02   | 2112 | 108 | rei | 2a44r    |   10 | 45000.00 | Zetacorp        | Larry Fitch
     113069 | 1990-03-02   | 2109 | 107 | imm | 775c     |   22 | 31350.00 | Chen Associates | Paul Cruz
     112987 | 1989-12-31   | 2103 | 105 | aci | 4100y    |   11 | 27500.00 | Acme Mfg.       | Bill Adams
(4 rows)



-- 4.10- Llista les comandes superiors a 25000, mostrant el nom del client que el va ordenar, 
--		 el venedor associat al client, i l'oficina on el venedor treballa.
SELECT pedidos.* , empresa , nombre , oficina_rep  
FROM pedidos , repventas , clientes 
WHERE (clie = num_clie) and (rep_clie = num_empl) and importe > 25000;

 num_pedido | fecha_pedido | clie | rep | fab | producto | cant | importe  |     empresa     |   nombre    | oficina_rep 
------------+--------------+------+-----+-----+----------+------+----------+-----------------+-------------+-------------
     112961 | 1989-12-17   | 2117 | 106 | rei | 2a44l    |    7 | 31500.00 | J.P. Sinclair   | Sam Clark   |          11
     113045 | 1990-02-02   | 2112 | 108 | rei | 2a44r    |   10 | 45000.00 | Zetacorp        | Larry Fitch |          21
     113069 | 1990-03-02   | 2109 | 107 | imm | 775c     |   22 | 31350.00 | Chen Associates | Paul Cruz   |          12
     112987 | 1989-12-31   | 2103 | 105 | aci | 4100y    |   11 | 27500.00 | Acme Mfg.       | Bill Adams  |          13
(4 rows)



-- 4.11- Llista totes les combinacions de venedors i oficines on les ventes del venedor és superior a les ventes de l'oficina.
SELECT num_empl , oficina , repventas.ventas , oficinas.ventas 
FROM repventas , oficinas 
WHERE (repventas.ventas = oficinas.ventas) and repventas.ventas > oficinas.ventas;

 num_empl | oficina | cuota | objetivo 
----------+---------+-------+----------
(0 rows)



-- 4.12- Informa sobre tots els venedors i les oficines en les que treballen.
SELECT repventas.* , oficinas.* 
FROM repventas , oficinas 
WHERE oficina = oficina_rep;

 num_empl |    nombre     | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   | oficina |   ciudad    | region | dir | objetivo  |  ventas   
----------+---------------+------+-------------+------------+------------+----------+-----------+-----------+---------+-------------+--------+-----+-----------+-----------
      105 | Bill Adams    |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367911.00 |      13 | Atlanta     | Este   | 105 | 350000.00 | 367911.00
      109 | Mary Jones    |   31 |          11 | Rep Ventas | 1989-10-12 |      106 | 300000.00 | 392725.00 |      11 | New York    | Este   | 106 | 575000.00 | 692637.00
      102 | Sue Smith     |   48 |          21 | Rep Ventas | 1986-12-10 |      108 | 350000.00 | 474050.00 |      21 | Los Angeles | Oeste  | 108 | 725000.00 | 835915.00
      106 | Sam Clark     |   52 |          11 | VP Ventas  | 1988-06-14 |          | 275000.00 | 299912.00 |      11 | New York    | Este   | 106 | 575000.00 | 692637.00
      104 | Bob Smith     |   33 |          12 | Dir Ventas | 1987-05-19 |      106 | 200000.00 | 142594.00 |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      101 | Dan Roberts   |   45 |          12 | Rep Ventas | 1986-10-20 |      104 | 300000.00 | 305673.00 |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      108 | Larry Fitch   |   62 |          21 | Dir Ventas | 1989-10-12 |      106 | 350000.00 | 361865.00 |      21 | Los Angeles | Oeste  | 108 | 725000.00 | 835915.00
      103 | Paul Cruz     |   29 |          12 | Rep Ventas | 1987-03-01 |      104 | 275000.00 | 286775.00 |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      107 | Nancy Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00 |      22 | Denver      | Oeste  | 108 | 300000.00 | 186042.00
(9 rows)



-- 4.13- Llista els venedors amb una quota superior a la dels seus directors.
SELECT * 
FROM repventas treb , repventas boss 
WHERE treb.director=boss.num_empl and treb.cuota > boss.cuota; 

 num_empl |   nombre    | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   | num_empl |  nombre | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   
----------+-------------+------+-------------+------------+------------+----------+-----------+-----------+----------+-----------+------+-------------+------------+------------+----------+-----------+-----------
      105 | Bill Adams  |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367911.00 |      104 | Bob Smith |   33 |          12 | Dir Ventas | 1987-05-19 |      106 | 200000.00 | 142594.00
      109 | Mary Jones  |   31 |          11 | Rep Ventas | 1989-10-12 |      106 | 300000.00 | 392725.00 |      106 | Sam Clark |   52 |          11 | VP Ventas  | 1988-06-14 |          | 275000.00 | 299912.00
      101 | Dan Roberts |   45 |          12 | Rep Ventas | 1986-10-20 |      104 | 300000.00 | 305673.00 |      104 | Bob Smith |   33 |          12 | Dir Ventas | 1987-05-19 |      106 | 200000.00 | 142594.00
      108 | Larry Fitch |   62 |          21 | Dir Ventas | 1989-10-12 |      106 | 350000.00 | 361865.00 |      106 | Sam Clark |   52 |          11 | VP Ventas  | 1988-06-14 |          | 275000.00 | 299912.00
      103 | Paul Cruz   |   29 |          12 | Rep Ventas | 1987-03-01 |      104 | 275000.00 | 286775.00 |      104 | Bob Smith |   33 |          12 | Dir Ventas | 1987-05-19 |      106 | 200000.00 | 142594.00
(5 rows)




-- 4.14- Llistar el nom de l'empresa i totes les comandes fetes pel client 2103.
SELECT empresa , pedidos.* 
FROM clientes , pedidos 
WHERE num_clie=clie and clie=2103;

  empresa  | num_pedido | fecha_pedido | clie | rep | fab | producto | cant | importe  
-----------+------------+--------------+------+-----+-----+----------+------+----------
 Acme Mfg. |     112963 | 1989-12-17   | 2103 | 105 | aci | 41004    |   28 |  3276.00
 Acme Mfg. |     112983 | 1989-12-27   | 2103 | 105 | aci | 41004    |    6 |   702.00
 Acme Mfg. |     113027 | 1990-01-22   | 2103 | 105 | aci | 41002    |   54 |  4104.00
 Acme Mfg. |     112987 | 1989-12-31   | 2103 | 105 | aci | 4100y    |   11 | 27500.00
(4 rows)



-- 4.15- Llista aquelles comandes que el seu import sigui superior a 10000, mostrant el numero de comanda, 
-- els imports i les descripcions del producte.
SELECT num_pedido , importe , descripcion 
FROM pedidos , productos 
WHERE id_fab = fab and id_producto=producto and importe > 10000;

 num_pedido | importe  |  descripcion   
------------+----------+----------------
     112987 | 27500.00 | Extractor
     110036 | 22500.00 | Montador
     112979 | 15000.00 | Montador
     113069 | 31350.00 | Riostra 1-Tm
     112961 | 31500.00 | Bisagra Izqda.
     113045 | 45000.00 | Bisagra Dcha.
     113042 | 22500.00 | Bisagra Dcha.
(7 rows)



-- 4.16- Llista les comandes superiors a 25000, mostrant el nom del client que la va demanar, el venedor associat al client, 
-- i l'oficina on el venedor treballa. També cal mostar la descripció del producte.
SELECT empresa , rep , oficina_rep , descripcion , oficinas.ciudad 
FROM clientes , pedidos , productos , repventas , oficinas 
WHERE importe > 25000 and num_clie=clie and rep_clie=num_empl and id_fab=fab and id_producto=producto and oficina_rep = oficina;

     empresa     | rep | oficina_rep |  descripcion   |   ciudad    
-----------------+-----+-------------+----------------+-------------
 Acme Mfg.       | 105 |          13 | Extractor      | Atlanta
 Chen Associates | 107 |          12 | Riostra 1-Tm   | Chicago
 J.P. Sinclair   | 106 |          11 | Bisagra Izqda. | New York
 Zetacorp        | 108 |          21 | Bisagra Dcha.  | Los Angeles
(4 rows)




-- 4.17- Trobar totes les comandes rebudes en els dies en que un nou venedor va ser contractat. 
-- Per cada comanda mostrar un cop el número, import i data de la comanda.
SELECT DISTINCT num_pedido , importe , fecha_pedido , contrato 
FROM pedidos , repventas 
WHERE contrato=fecha_pedido; 

 num_pedido | importe  | fecha_pedido |  contrato  
------------+----------+--------------+------------
     112968 |  3978.00 | 1989-10-12   | 1989-10-12
     112979 | 15000.00 | 1989-10-12   | 1989-10-12
(2 rows)




-- 4.18- Mostra el nom, les vendes dels treballadors que tenen assignada una oficina, 
-- amb la ciutat i l'objectiu de l'oficina de cada venedor.
SELECT nombre , repventas.ventas , ciudad , objetivo 
FROM repventas , oficinas 
WHERE oficina_rep=oficina and oficina_rep IS NOT NULL;

    nombre     |  ventas   |   ciudad    | objetivo  
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



-- 4.19- Llista el nom de tots els venedors i el del seu director en cas de tenir-ne. 
-- El camp que conté el nom del treballador s'ha d'identificar amb "empleado" i el camp que conté 
-- el nom del director amb "director".
SELECT treb.nombre as "empleado", boss.nombre as "director" 
FROM repventas treb , repventas boss 
WHERE treb.director = boss.num_empl;

   empleado    |  director   
---------------+-------------
 Bill Adams    | Bob Smith
 Mary Jones    | Sam Clark
 Sue Smith     | Larry Fitch
 Bob Smith     | Sam Clark
 Dan Roberts   | Bob Smith
 Tom Snyder    | Dan Roberts
 Larry Fitch   | Sam Clark
 Paul Cruz     | Bob Smith
 Nancy Angelli | Larry Fitch
(9 rows)



-- 4.20- Llista totes les combinacions possibles de venedors i ciutats.
SELECT repventas.num_empl , repventas.oficina_rep , oficinas.oficina , oficinas.ciudad 
FROM repventas , oficinas;

 num_empl | oficina_rep | oficina |   ciudad    
----------+-------------+---------+-------------
      105 |          13 |      22 | Denver
      109 |          11 |      22 | Denver
      102 |          21 |      22 | Denver
      106 |          11 |      22 | Denver
      104 |          12 |      22 | Denver
      101 |          12 |      22 | Denver
      110 |             |      22 | Denver
      108 |          21 |      22 | Denver
      103 |          12 |      22 | Denver
      107 |          22 |      22 | Denver
      105 |          13 |      11 | New York
      109 |          11 |      11 | New York
      102 |          21 |      11 | New York
      106 |          11 |      11 | New York
      104 |          12 |      11 | New York
      101 |          12 |      11 | New York
      110 |             |      11 | New York
      108 |          21 |      11 | New York
      103 |          12 |      11 | New York
      107 |          22 |      11 | New York
      105 |          13 |      12 | Chicago
      109 |          11 |      12 | Chicago
      102 |          21 |      12 | Chicago
      106 |          11 |      12 | Chicago
      104 |          12 |      12 | Chicago
      101 |          12 |      12 | Chicago
      110 |             |      12 | Chicago
      108 |          21 |      12 | Chicago
      103 |          12 |      12 | Chicago
      107 |          22 |      12 | Chicago
      105 |          13 |      13 | Atlanta
      109 |          11 |      13 | Atlanta
      102 |          21 |      13 | Atlanta
      106 |          11 |      13 | Atlanta
      104 |          12 |      13 | Atlanta
      101 |          12 |      13 | Atlanta
      110 |             |      13 | Atlanta
      108 |          21 |      13 | Atlanta
      103 |          12 |      13 | Atlanta
      107 |          22 |      13 | Atlanta
      105 |          13 |      21 | Los Angeles
      109 |          11 |      21 | Los Angeles
      102 |          21 |      21 | Los Angeles
      106 |          11 |      21 | Los Angeles
      104 |          12 |      21 | Los Angeles
      101 |          12 |      21 | Los Angeles
      110 |             |      21 | Los Angeles
      108 |          21 |      21 | Los Angeles
      103 |          12 |      21 | Los Angeles
      107 |          22 |      21 | Los Angeles
(50 rows)




-- 4.21- Per a cada venedor, mostrar el nom, les vendes i la ciutat de l'oficina en cas de tenir-ne una d'assignada.
SELECT repventas.nombre , repventas.ventas , oficinas.ciudad 
FROM oficinas , repventas 
WHERE oficinas.oficina=repventas.oficina_rep;

    nombre     |  ventas   |   ciudad    
---------------+-----------+-------------
 Bill Adams    | 367911.00 | Atlanta
 Mary Jones    | 392725.00 | New York
 Sue Smith     | 474050.00 | Los Angeles
 Sam Clark     | 299912.00 | New York
 Bob Smith     | 142594.00 | Chicago
 Dan Roberts   | 305673.00 | Chicago
 Larry Fitch   | 361865.00 | Los Angeles
 Paul Cruz     | 286775.00 | Chicago
 Nancy Angelli | 186042.00 | Denver
(9 rows)



-- 4.22- Mostra les comandes de productes que tenen unes existències inferiors a 10. 
-- Llistar el numero de comanda, la data de la comanda, el nom del client que ha fet la comanda, 
-- identificador del fabricant i l'identificador de producte de la comanda.
SELECT pedidos.num_pedido , pedidos.fecha_pedido , clientes.empresa , productos.id_fab , productos.id_producto 
FROM pedidos , clientes , productos 
WHERE pedidos.clie = clientes.num_clie and pedidos.fab = productos.id_fab and pedidos.producto = productos.id_producto and productos.existencias < 10;

 num_pedido | fecha_pedido |     empresa      | id_fab | id_producto 
------------+--------------+------------------+--------+-------------
     113013 | 1990-01-14   | Midwest Systems  | bic    | 41003
     112997 | 1990-01-08   | Peter Brothers   | bic    | 41003
     113069 | 1990-03-02   | Chen Associates  | imm    | 775c 
     113048 | 1990-02-10   | Rico Enterprises | imm    | 779c 
     113003 | 1990-01-25   | Holm & Landis    | imm    | 779c 
(5 rows)

	

-- 4.23- Llista les 5 comandes amb un import superior. Mostrar l'identificador de la comanda, import de la comanda, 
-- preu del producte, nom del client, nom del representant de vendes que va efectuar la comanda i ciutat de l'oficina, 
-- en cas de tenir oficina assignada.
SELECT pedidos.num_pedido , pedidos.importe , productos.precio , clientes.empresa , pedidos.rep , oficinas.ciudad 
FROM pedidos 
JOIN productos ON pedidos.fab = productos.id_fab and pedidos.producto = productos.id_producto 
JOIN clientes ON pedidos.clie = clientes.num_clie 
JOIN repventas ON pedidos.rep = repventas.num_empl 
JOIN oficinas ON repventas.oficina_rep = oficinas.oficina 
ORDER BY importe DESC LIMIT 5;

 num_pedido | importe  | precio  |     empresa     | rep |   ciudad    
------------+----------+---------+-----------------+-----+-------------
     113045 | 45000.00 | 4500.00 | Zetacorp        | 108 | Los Angeles
     112961 | 31500.00 | 4500.00 | J.P. Sinclair   | 106 | New York
     113069 | 31350.00 | 1425.00 | Chen Associates | 107 | Denver
     112987 | 27500.00 | 2750.00 | Acme Mfg.       | 105 | Atlanta
     113042 | 22500.00 | 4500.00 | Ian & Schmidt   | 101 | Chicago
(5 rows)



-- 4.24- Llista les comandes que han estat preses per un representant de vendes que no és l'actual 
-- representant de vendes del client pel que s'ha realitzat la comanda. Mostrar el número de comanda, 
-- el nom del client, el nom de l'actual representant de vendes del client com a "rep_cliente" 
-- i el nom del representant de vendes que va realitzar la comanda com a "rep_pedido".
SELECT pedidos.num_pedido , clientes.empresa , clientes.rep_clie as "rep_cliente" , pedidos.rep as "rep_pedido"
FROM PEDIDOS 
JOIN clientes ON pedidos.clie = clientes.num_clie 
WHERE clientes.rep_clie <> pedidos.rep;

 num_pedido |     empresa     | rep_cliente | rep_pedido 
------------+-----------------+-------------+------------
     113024 | Orion Corp      |         102 |        108
     113069 | Chen Associates |         103 |        107
     113055 | Holm & Landis   |         109 |        101
     113042 | Ian & Schmidt   |         104 |        101
(4 rows)



-- 4.25- Llista les comandes amb un import superior a 5000 i també aquelles comandes realitzades per 
-- un client amb un crèdit inferior a 30000. 
-- Mostrar l'identificador de la comanda, el nom del client i el nom del representant de vendes que va prendre la comanda.
SELECT pedidos.num_pedido , clientes.empresa , repventas.nombre 
FROM pedidos 
JOIN clientes ON pedidos.clie = clientes.num_clie 
JOIN repventas ON pedidos.rep = repventas.num_empl 
WHERE importe > 5000 or clientes.limite_credito < 30000;

 num_pedido |      empresa      |    nombre     
------------+-------------------+---------------
     112961 | J.P. Sinclair     | Sam Clark
     110036 | Ace International | Tom Snyder
     113045 | Zetacorp          | Larry Fitch
     113024 | Orion Corp        | Larry Fitch
     112979 | Orion Corp        | Sue Smith
     113069 | Chen Associates   | Nancy Angelli
     113003 | Holm & Landis     | Mary Jones
     112987 | Acme Mfg.         | Bill Adams
     113042 | Ian & Schmidt     | Dan Roberts
(9 rows)

	
	
