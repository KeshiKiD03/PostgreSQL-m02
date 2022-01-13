-- 4.1- Llista la ciutat de les oficines, i el nom i títol dels directors de cada oficina.
select ciudad,nombre,titulo
from oficinas,repventas
where dir=num_empl;

select ciudad,nombre,titulo
from oficinas join repventas on oficinas.dir=repventas.num_empl;

   ciudad    |   nombre    |   titulo   
-------------+-------------+------------
 Denver      | Larry Fitch | Dir Ventas
 New York    | Sam Clark   | VP Ventas
 Chicago     | Bob Smith   | Dir Ventas
 Atlanta     | Bill Adams  | Rep Ventas
 Los Angeles | Larry Fitch | Dir Ventas
(5 rows)

-- 4.2- Llista totes les comandes mostrant el seu número, import, número de client i límit de crèdit.
select num_pedido,importe,empresa,limite_credito
from pedidos,clientes
where clie=num_clie;

select num_pedido,importe,empresa,limite_credito
from pedidos join clientes on clie=num_clie;

 num_pedido | importe  |      empresa      | limite_credito 
------------+----------+-------------------+----------------
     112961 | 31500.00 | J.P. Sinclair     |       35000.00
     113012 |  3745.00 | JCP Inc.          |       50000.00
     112989 |  1458.00 | Jones Mfg.        |       65000.00
     113051 |  1420.00 | Midwest Systems   |       60000.00
     112968 |  3978.00 | First Corp.       |       65000.00
     110036 | 22500.00 | Ace International |       35000.00
     113045 | 45000.00 | Zetacorp          |       50000.00
     112963 |  3276.00 | Acme Mfg.         |       50000.00
     113013 |   652.00 | Midwest Systems   |       60000.00
     113058 |  1480.00 | Holm & Landis     |       55000.00
     112997 |   652.00 | Peter Brothers    |       40000.00
     112983 |   702.00 | Acme Mfg.         |       50000.00
     113024 |  7100.00 | Orion Corp        |       20000.00
     113062 |  2430.00 | Peter Brothers    |       40000.00
     112979 | 15000.00 | Orion Corp        |       20000.00
     113027 |  4104.00 | Acme Mfg.         |       50000.00
     113007 |  2925.00 | Zetacorp          |       50000.00
     113069 | 31350.00 | Chen Associates   |       25000.00
     113034 |   632.00 | Ace International |       35000.00
     112992 |   760.00 | Midwest Systems   |       60000.00
     112975 |  2100.00 | JCP Inc.          |       50000.00
     113055 |   150.00 | Holm & Landis     |       55000.00
     113048 |  3750.00 | Rico Enterprises  |       50000.00
     112993 |  1896.00 | Fred Lewis Corp.  |       65000.00
     113065 |  2130.00 | Fred Lewis Corp.  |       65000.00
     113003 |  5625.00 | Holm & Landis     |       55000.00
     113049 |   776.00 | Midwest Systems   |       60000.00
     112987 | 27500.00 | Acme Mfg.         |       50000.00
     113057 |   600.00 | JCP Inc.          |       50000.00
     113042 | 22500.00 | Ian & Schmidt     |       20000.00
(30 rows)

-- 4.3- Llista el número de totes les comandes amb la descripció del producte demanat.
select num_pedido,producto,descripcion
from pedidos,productos
where id_fab=fab and producto=id_producto;

select num_pedido,producto,descripcion
from pedidos join productos on fab=id_fab and producto=id_producto;

-- Con left join:
select num_pedido,producto,descripcion
from pedidos left join productos on fab=id_fab and producto=id_producto;
-- (30 rows)

 num_pedido | producto |    descripcion    
------------+----------+-------------------
     112961 | 2a44l    | Bisagra Izqda.
     113012 | 41003    | Manivela
     113012 | 41003    | Articulo Tipo 3
     112989 | 114      | Bancada Motor
     112968 | 41004    | Articulo Tipo 4
     110036 | 4100z    | Montador
     113045 | 2a44r    | Bisagra Dcha.
     112963 | 41004    | Articulo Tipo 4
     113013 | 41003    | Manivela
     113013 | 41003    | Articulo Tipo 3
     113058 | 112      | Cubierta
     112997 | 41003    | Manivela
     112997 | 41003    | Articulo Tipo 3
     112983 | 41004    | Articulo Tipo 4
     113024 | xk47     | Reductor
     113062 | 114      | Bancada Motor
     112979 | 4100z    | Montador
     113027 | 41002    | Articulo Tipo 2
     113007 | 773c     | Riostra 1/2-Tm
     113069 | 775c     | Riostra 1-Tm
     113034 | 2a45c    | V Stago Trinquete
     112992 | 41002    | Articulo Tipo 2
     112975 | 2a44g    | Pasador Bisagra
     113055 | 4100x    | Ajustador
     113048 | 779c     | Riostra 2-Tm
     112993 | 2a45c    | V Stago Trinquete
     113065 | xk47     | Reductor
     113003 | 779c     | Riostra 2-Tm
     113049 | xk47     | Reductor
     112987 | 4100y    | Extractor
     113057 | 4100x    | Ajustador
     113042 | 2a44r    | Bisagra Dcha.
(32 rows)

-- 4.4- Llista el nom de tots els clients amb el nom del representant de vendes assignat.
select empresa,nombre
from clientes,repventas
where rep_clie=num_empl;

select empresa,nombre
from clientes join repventas on rep_clie=num_empl;

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
select fecha_pedido,num_pedido,clie,empresa
from pedidos,clientes
where clie=num_clie;

select fecha_pedido,num_pedido,clie,empresa
from pedidos join clientes on clie=num_clie;

 fecha_pedido | num_pedido | clie |      empresa      
--------------+------------+------+-------------------
 1989-12-17   |     112961 | 2117 | J.P. Sinclair
 1990-01-11   |     113012 | 2111 | JCP Inc.
 1990-01-03   |     112989 | 2101 | Jones Mfg.
 1990-02-10   |     113051 | 2118 | Midwest Systems
 1989-10-12   |     112968 | 2102 | First Corp.
 1990-01-30   |     110036 | 2107 | Ace International
 1990-02-02   |     113045 | 2112 | Zetacorp
 1989-12-17   |     112963 | 2103 | Acme Mfg.
 1990-01-14   |     113013 | 2118 | Midwest Systems
 1990-02-23   |     113058 | 2108 | Holm & Landis
 1990-01-08   |     112997 | 2124 | Peter Brothers
 1989-12-27   |     112983 | 2103 | Acme Mfg.
 1990-01-20   |     113024 | 2114 | Orion Corp
 1990-02-24   |     113062 | 2124 | Peter Brothers
 1989-10-12   |     112979 | 2114 | Orion Corp
 1990-01-22   |     113027 | 2103 | Acme Mfg.
 1990-01-08   |     113007 | 2112 | Zetacorp
 1990-03-02   |     113069 | 2109 | Chen Associates
 1990-01-29   |     113034 | 2107 | Ace International
 1989-11-04   |     112992 | 2118 | Midwest Systems
 1989-12-12   |     112975 | 2111 | JCP Inc.
 1990-02-15   |     113055 | 2108 | Holm & Landis
 1990-02-10   |     113048 | 2120 | Rico Enterprises
 1989-01-04   |     112993 | 2106 | Fred Lewis Corp.
 1990-02-27   |     113065 | 2106 | Fred Lewis Corp.
 1990-01-25   |     113003 | 2108 | Holm & Landis
 1990-02-10   |     113049 | 2118 | Midwest Systems
 1989-12-31   |     112987 | 2103 | Acme Mfg.
 1990-02-18   |     113057 | 2111 | JCP Inc.
 1990-02-02   |     113042 | 2113 | Ian & Schmidt
(30 rows)

-- 4.6- Llista les oficines, noms i títols del seus directors amb un objectiu superior a 600.000.
select oficina,nombre,titulo,objetivo
from repventas,oficinas
where oficina=oficina_rep
and objetivo > 600000;

select oficina,nombre,titulo,objetivo
from oficinas join repventas on oficinas.oficina=repventas.oficina_rep
where objetivo > 600000;

 oficina |   nombre    |   titulo   | objetivo  
---------+-------------+------------+-----------
      21 | Sue Smith   | Rep Ventas | 725000.00
      12 | Bob Smith   | Dir Ventas | 800000.00
      12 | Dan Roberts | Rep Ventas | 800000.00
      21 | Larry Fitch | Dir Ventas | 725000.00
      12 | Paul Cruz   | Rep Ventas | 800000.00
(5 rows)

-- 4.7- Llista els venedors de les oficines de la regió est.
select nombre,ciudad,region
from repventas,oficinas
where oficina_rep=oficina 
and region='Este';

select nombre,ciudad,region
from repventas join oficinas on oficina_rep=oficina
where region='Este';

   nombre    |  ciudad  | region 
-------------+----------+--------
 Bill Adams  | Atlanta  | Este
 Mary Jones  | New York | Este
 Sam Clark   | New York | Este
 Bob Smith   | Chicago  | Este
 Dan Roberts | Chicago  | Este
 Paul Cruz   | Chicago  | Este
(6 rows)

-- 4.8- Llista les comandes superiors a 25000, incloent el nom del venedor que va servir la comanda i el nom del client que el va sol·licitar.
select num_pedido,importe,empresa,nombre
from pedidos,clientes,repventas
where clie=num_clie and rep=num_empl
and importe > 25000;

select num_pedido,importe,empresa,nombre
from pedidos join clientes on clie=num_clie 
             join repventas on rep=num_empl
where importe > 25000;

 num_pedido | importe  |     empresa     |    nombre     
------------+----------+-----------------+---------------
     112961 | 31500.00 | J.P. Sinclair   | Sam Clark
     113045 | 45000.00 | Zetacorp        | Larry Fitch
     113069 | 31350.00 | Chen Associates | Nancy Angelli
     112987 | 27500.00 | Acme Mfg.       | Bill Adams
(4 rows)

-- 4.9- Llista les comandes superiors a 25000, mostrant el client que va servir la comanda i el nom del venedor que té assignat el
-- client.
select num_pedido,importe,empresa,nombre
from pedidos,clientes,repventas
where clie=num_clie and rep_clie=num_empl
and importe > 25000;

select num_pedido,importe,empresa,nombre
from pedidos
      join clientes on clie=num_clie
      join repventas on rep_clie=num_empl
where importe > 25000;

 num_pedido | importe  |     empresa     |   nombre    
------------+----------+-----------------+-------------
     112961 | 31500.00 | J.P. Sinclair   | Sam Clark
     113045 | 45000.00 | Zetacorp        | Larry Fitch
     113069 | 31350.00 | Chen Associates | Paul Cruz
     112987 | 27500.00 | Acme Mfg.       | Bill Adams
(4 rows)

-- 4.10- Llista les comandes superiors a 25000, mostrant el nom del client que el va ordenar, el venedor associat al client, i
-- l'oficina on el venedor treballa.
select num_pedido,importe,empresa,nombre,ciudad
from pedidos,clientes,repventas,oficinas
where clie=num_clie and rep_clie=num_empl and oficina_rep=oficina
and importe > 25000;

select num_pedido,importe,empresa,nombre,ciudad
from pedidos
      join clientes on clie=num_clie
      join repventas on rep_clie=num_empl
      join oficinas on oficina_rep=oficina
where importe > 25000;

 num_pedido | importe  |     empresa     |   nombre    |   ciudad    
------------+----------+-----------------+-------------+-------------
     112961 | 31500.00 | J.P. Sinclair   | Sam Clark   | New York
     113045 | 45000.00 | Zetacorp        | Larry Fitch | Los Angeles
     113069 | 31350.00 | Chen Associates | Paul Cruz   | Chicago
     112987 | 27500.00 | Acme Mfg.       | Bill Adams  | Atlanta
(4 rows)

-- 4.11- Llista totes les combinacions de venedors i oficines on la quota del venedor és superior a l'objectiu de l'oficina.
select nombre,oficina
from oficinas,repventas
where oficina=oficina_rep
and cuota > objetivo;

 nombre | oficina 
--------+---------
(0 rows)

-- Correcto, no hay cuota que supere el objetivo

-- 4.12- Informa sobre tots els venedors i les oficines en les que treballen.
select num_empl,nombre,oficinas.*
from oficinas,repventas
where oficina=oficina_rep;

select * 
from repventas
      join oficinas on num_empl=dir;
-- (5 rows)
select * 
from repventas
      join oficinas on oficina_rep=oficina;
--(9 rows)

 num_empl |    nombre     | oficina |   ciudad    | region | dir | objetivo  |  ventas   
----------+---------------+---------+-------------+--------+-----+-----------+-----------
      105 | Bill Adams    |      13 | Atlanta     | Este   | 105 | 350000.00 | 367911.00
      109 | Mary Jones    |      11 | New York    | Este   | 106 | 575000.00 | 692637.00
      102 | Sue Smith     |      21 | Los Angeles | Oeste  | 108 | 725000.00 | 835915.00
      106 | Sam Clark     |      11 | New York    | Este   | 106 | 575000.00 | 692637.00
      104 | Bob Smith     |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      101 | Dan Roberts   |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      108 | Larry Fitch   |      21 | Los Angeles | Oeste  | 108 | 725000.00 | 835915.00
      103 | Paul Cruz     |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      107 | Nancy Angelli |      22 | Denver      | Oeste  | 108 | 300000.00 | 186042.00
(9 rows)

-- 4.13- Llista els venedors amb una quota superior a la dels seus directors.
select repventas1.num_empl,repventas1.nombre,repventas1.cuota,repventas1.director,
      repventas2.num_empl,repventas2.nombre,repventas2.cuota
from repventas repventas1,repventas repventas2
where repventas1.director=repventas2.num_empl
and repventas1.cuota > repventas2.cuota;

select r1.nombre as nombre_rep,r1.cuota as cuota_rep,r2.nombre as nombre_dir,r2.cuota as cuota_dir
from repventas r1
      join repventas r2 on r1.director=r2.num_empl
where r1.cuota > r2.cuota;

 num_empl |   nombre    |   cuota   | director | num_empl |  nombre   |   cuota   
----------+-------------+-----------+----------+----------+-----------+-----------
      105 | Bill Adams  | 350000.00 |      104 |      104 | Bob Smith | 200000.00
      109 | Mary Jones  | 300000.00 |      106 |      106 | Sam Clark | 275000.00
      101 | Dan Roberts | 300000.00 |      104 |      104 | Bob Smith | 200000.00
      108 | Larry Fitch | 350000.00 |      106 |      106 | Sam Clark | 275000.00
      103 | Paul Cruz   | 275000.00 |      104 |      104 | Bob Smith | 200000.00
(5 rows)

-- 4.14- Llistar el nom de l'empresa i totes les comandes fetes pel client 2103.
select empresa,num_pedido
from clientes,pedidos
where num_clie=clie
and clie = 2103;

select empresa,num_pedido
from clientes
      join pedidos on num_clie=clie
where clie = 2103;

  empresa  | num_pedido 
-----------+------------
 Acme Mfg. |     112963
 Acme Mfg. |     112983
 Acme Mfg. |     113027
 Acme Mfg. |     112987
(4 rows)

-- 4.15- Llista aquelles comandes que el seu import sigui superior a 10000, mostrant el numero de comanda, els imports i les
-- descripcions del producte.
select num_pedido,importe,descripcion
from pedidos,productos
where producto=id_producto and fab=id_fab
and importe > 10000;

select num_pedido,importe,descripcion
from pedidos
      join productos on producto=id_producto and fab=id_fab
where importe > 10000;

-- ponemos el id_producto y id_fab porque los producto se identificant con los dos campos.

 num_pedido | importe  |  descripcion   
------------+----------+----------------
     112961 | 31500.00 | Bisagra Izqda.
     110036 | 22500.00 | Montador
     113045 | 45000.00 | Bisagra Dcha.
     112979 | 15000.00 | Montador
     113069 | 31350.00 | Riostra 1-Tm
     112987 | 27500.00 | Extractor
     113042 | 22500.00 | Bisagra Dcha.
(7 rows)

-- 4.16- Llista les comandes superiors a 25000, mostrant el nom del client que la va demanar, el venedor associat al client, i
-- l'oficina on el venedor treballa. També cal mostar la descripció del producte.
select num_pedido,importe,empresa,nombre,ciudad,descripcion
from pedidos,clientes,repventas,oficinas,productos
where clie=num_clie and rep_clie=num_empl and oficina_rep=oficina and fab=id_fab and producto=id_producto
and importe > 25000;

select num_pedido,importe,empresa,nombre,ciudad,descripcion
from pedidos
      join productos on pedidos.fab=productos.
      join clientes on clie=num_clie
      join repventas on clientes.rep_clie=repventas.num_empl
      join oficinas on oficina=oficina_rep
where importe > 25000;

 num_pedido | importe  |     empresa     |   nombre    |   ciudad    |  descripcion   
------------+----------+-----------------+-------------+-------------+----------------
     112961 | 31500.00 | J.P. Sinclair   | Sam Clark   | New York    | Bisagra Izqda.
     113045 | 45000.00 | Zetacorp        | Larry Fitch | Los Angeles | Bisagra Dcha.
     113069 | 31350.00 | Chen Associates | Paul Cruz   | Chicago     | Riostra 1-Tm
     112987 | 27500.00 | Acme Mfg.       | Bill Adams  | Atlanta     | Extractor
(4 rows)

-- 4.17- Trobar totes les comandes rebudes en els dies en que un nou venedor va ser contractat. Per cada comanda mostrar un cop
-- el número, import i data de la comanda.
select distinct num_pedido,importe,fecha_pedido
from pedidos,repventas
where fecha_pedido=contrato;

select distinct num_pedido,importe,fecha_pedido
from pedidos
      join repventas on fecha_pedido=contrato;

 num_pedido | importe  | fecha_pedido 
------------+----------+--------------
     112968 |  3978.00 | 1989-10-12
     112979 | 15000.00 | 1989-10-12
(2 rows)

-- 4.18- Mostra el nom, les vendes dels treballadors que tenen assignada una oficina, amb la ciutat i l'objectiu de l'oficina de
-- cada venedor.

-- 1. num_empl=dir /// 2. oficina=oficina_rep
-- 1. director d'oficina
-- 2. oficina d'un representant de ventas
select nombre,repventas.ventas,ciudad,objetivo
from repventas,oficinas
where oficina_rep=oficina;

select nombre,repventas.ventas,ciudad,objetivo
from repventas
      join oficinas on oficina_rep=oficina;

-- 4.19- Llista el nom de tots els venedors i el del seu director en cas de tenir-ne. El camp que conté el nom del treballador s'ha
-- d'identificar amb "empleado" i el camp que conté el nom del director amb "director".
select repventas1.num_empl,repventas1.nombre as "empleado",repventas1.director,repventas2.num_empl,repventas2.nombre as "director"
from repventas repventas1,repventas repventas2
where repventas1.director=repventas2.num_empl;

select rep.num_empl,rep.nombre as nombre_rep,rep.director,dir.num_empl,dir.nombre as nombre_dir
from repventas rep 
      join repventas dir on rep.director=dir.num_empl;

 num_empl |   empleado    | director | num_empl |  director   
----------+---------------+----------+----------+-------------
      105 | Bill Adams    |      104 |      104 | Bob Smith
      109 | Mary Jones    |      106 |      106 | Sam Clark
      102 | Sue Smith     |      108 |      108 | Larry Fitch
      104 | Bob Smith     |      106 |      106 | Sam Clark
      101 | Dan Roberts   |      104 |      104 | Bob Smith
      110 | Tom Snyder    |      101 |      101 | Dan Roberts
      108 | Larry Fitch   |      106 |      106 | Sam Clark
      103 | Paul Cruz     |      104 |      104 | Bob Smith
      107 | Nancy Angelli |      108 |      108 | Larry Fitch
(9 rows)

-- 4.20- Llista totes les combinacions possibles de venedors i ciutats.
select *
from repventas,oficinas;

select *
from repventas
      inner join oficinas;

 num_empl |    nombre     | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   | oficina |   ciudad    | region | dir | objetivo  |  ventas   
----------+---------------+------+-------------+------------+------------+----------+-----------+-----------+---------+-------------+--------+-----+-----------+-----------
      105 | Bill Adams    |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367911.00 |      22 | Denver      | Oeste  | 108 | 300000.00 | 186042.00
      109 | Mary Jones    |   31 |          11 | Rep Ventas | 1989-10-12 |      106 | 300000.00 | 392725.00 |      22 | Denver      | Oeste  | 108 | 300000.00 | 186042.00
      102 | Sue Smith     |   48 |          21 | Rep Ventas | 1986-12-10 |      108 | 350000.00 | 474050.00 |      22 | Denver      | Oeste  | 108 | 300000.00 | 186042.00
      106 | Sam Clark     |   52 |          11 | VP Ventas  | 1988-06-14 |          | 275000.00 | 299912.00 |      22 | Denver      | Oeste  | 108 | 300000.00 | 186042.00
      104 | Bob Smith     |   33 |          12 | Dir Ventas | 1987-05-19 |      106 | 200000.00 | 142594.00 |      22 | Denver      | Oeste  | 108 | 300000.00 | 186042.00
      101 | Dan Roberts   |   45 |          12 | Rep Ventas | 1986-10-20 |      104 | 300000.00 | 305673.00 |      22 | Denver      | Oeste  | 108 | 300000.00 | 186042.00
      110 | Tom Snyder    |   41 |             | Rep Ventas | 1990-01-13 |      101 |           |  75985.00 |      22 | Denver      | Oeste  | 108 | 300000.00 | 186042.00
      108 | Larry Fitch   |   62 |          21 | Dir Ventas | 1989-10-12 |      106 | 350000.00 | 361865.00 |      22 | Denver      | Oeste  | 108 | 300000.00 | 186042.00
      103 | Paul Cruz     |   29 |          12 | Rep Ventas | 1987-03-01 |      104 | 275000.00 | 286775.00 |      22 | Denver      | Oeste  | 108 | 300000.00 | 186042.00
      107 | Nancy Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00 |      22 | Denver      | Oeste  | 108 | 300000.00 | 186042.00
      105 | Bill Adams    |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367911.00 |      11 | New York    | Este   | 106 | 575000.00 | 692637.00
      109 | Mary Jones    |   31 |          11 | Rep Ventas | 1989-10-12 |      106 | 300000.00 | 392725.00 |      11 | New York    | Este   | 106 | 575000.00 | 692637.00
      102 | Sue Smith     |   48 |          21 | Rep Ventas | 1986-12-10 |      108 | 350000.00 | 474050.00 |      11 | New York    | Este   | 106 | 575000.00 | 692637.00
      106 | Sam Clark     |   52 |          11 | VP Ventas  | 1988-06-14 |          | 275000.00 | 299912.00 |      11 | New York    | Este   | 106 | 575000.00 | 692637.00
      104 | Bob Smith     |   33 |          12 | Dir Ventas | 1987-05-19 |      106 | 200000.00 | 142594.00 |      11 | New York    | Este   | 106 | 575000.00 | 692637.00
      101 | Dan Roberts   |   45 |          12 | Rep Ventas | 1986-10-20 |      104 | 300000.00 | 305673.00 |      11 | New York    | Este   | 106 | 575000.00 | 692637.00
      110 | Tom Snyder    |   41 |             | Rep Ventas | 1990-01-13 |      101 |           |  75985.00 |      11 | New York    | Este   | 106 | 575000.00 | 692637.00
      108 | Larry Fitch   |   62 |          21 | Dir Ventas | 1989-10-12 |      106 | 350000.00 | 361865.00 |      11 | New York    | Este   | 106 | 575000.00 | 692637.00
      103 | Paul Cruz     |   29 |          12 | Rep Ventas | 1987-03-01 |      104 | 275000.00 | 286775.00 |      11 | New York    | Este   | 106 | 575000.00 | 692637.00
      107 | Nancy Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00 |      11 | New York    | Este   | 106 | 575000.00 | 692637.00
      105 | Bill Adams    |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367911.00 |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      109 | Mary Jones    |   31 |          11 | Rep Ventas | 1989-10-12 |      106 | 300000.00 | 392725.00 |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      102 | Sue Smith     |   48 |          21 | Rep Ventas | 1986-12-10 |      108 | 350000.00 | 474050.00 |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      106 | Sam Clark     |   52 |          11 | VP Ventas  | 1988-06-14 |          | 275000.00 | 299912.00 |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      104 | Bob Smith     |   33 |          12 | Dir Ventas | 1987-05-19 |      106 | 200000.00 | 142594.00 |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      101 | Dan Roberts   |   45 |          12 | Rep Ventas | 1986-10-20 |      104 | 300000.00 | 305673.00 |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      110 | Tom Snyder    |   41 |             | Rep Ventas | 1990-01-13 |      101 |           |  75985.00 |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      108 | Larry Fitch   |   62 |          21 | Dir Ventas | 1989-10-12 |      106 | 350000.00 | 361865.00 |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      103 | Paul Cruz     |   29 |          12 | Rep Ventas | 1987-03-01 |      104 | 275000.00 | 286775.00 |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      107 | Nancy Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00 |      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      105 | Bill Adams    |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367911.00 |      13 | Atlanta     | Este   | 105 | 350000.00 | 367911.00
      109 | Mary Jones    |   31 |          11 | Rep Ventas | 1989-10-12 |      106 | 300000.00 | 392725.00 |      13 | Atlanta     | Este   | 105 | 350000.00 | 367911.00
      102 | Sue Smith     |   48 |          21 | Rep Ventas | 1986-12-10 |      108 | 350000.00 | 474050.00 |      13 | Atlanta     | Este   | 105 | 350000.00 | 367911.00
      106 | Sam Clark     |   52 |          11 | VP Ventas  | 1988-06-14 |          | 275000.00 | 299912.00 |      13 | Atlanta     | Este   | 105 | 350000.00 | 367911.00
      104 | Bob Smith     |   33 |          12 | Dir Ventas | 1987-05-19 |      106 | 200000.00 | 142594.00 |      13 | Atlanta     | Este   | 105 | 350000.00 | 367911.00
      101 | Dan Roberts   |   45 |          12 | Rep Ventas | 1986-10-20 |      104 | 300000.00 | 305673.00 |      13 | Atlanta     | Este   | 105 | 350000.00 | 367911.00
      110 | Tom Snyder    |   41 |             | Rep Ventas | 1990-01-13 |      101 |           |  75985.00 |      13 | Atlanta     | Este   | 105 | 350000.00 | 367911.00
      108 | Larry Fitch   |   62 |          21 | Dir Ventas | 1989-10-12 |      106 | 350000.00 | 361865.00 |      13 | Atlanta     | Este   | 105 | 350000.00 | 367911.00
      103 | Paul Cruz     |   29 |          12 | Rep Ventas | 1987-03-01 |      104 | 275000.00 | 286775.00 |      13 | Atlanta     | Este   | 105 | 350000.00 | 367911.00
      107 | Nancy Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00 |      13 | Atlanta     | Este   | 105 | 350000.00 | 367911.00
      105 | Bill Adams    |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367911.00 |      21 | Los Angeles | Oeste  | 108 | 725000.00 | 835915.00
      109 | Mary Jones    |   31 |          11 | Rep Ventas | 1989-10-12 |      106 | 300000.00 | 392725.00 |      21 | Los Angeles | Oeste  | 108 | 725000.00 | 835915.00
      102 | Sue Smith     |   48 |          21 | Rep Ventas | 1986-12-10 |      108 | 350000.00 | 474050.00 |      21 | Los Angeles | Oeste  | 108 | 725000.00 | 835915.00
      106 | Sam Clark     |   52 |          11 | VP Ventas  | 1988-06-14 |          | 275000.00 | 299912.00 |      21 | Los Angeles | Oeste  | 108 | 725000.00 | 835915.00
      104 | Bob Smith     |   33 |          12 | Dir Ventas | 1987-05-19 |      106 | 200000.00 | 142594.00 |      21 | Los Angeles | Oeste  | 108 | 725000.00 | 835915.00
      101 | Dan Roberts   |   45 |          12 | Rep Ventas | 1986-10-20 |      104 | 300000.00 | 305673.00 |      21 | Los Angeles | Oeste  | 108 | 725000.00 | 835915.00
      110 | Tom Snyder    |   41 |             | Rep Ventas | 1990-01-13 |      101 |           |  75985.00 |      21 | Los Angeles | Oeste  | 108 | 725000.00 | 835915.00
      108 | Larry Fitch   |   62 |          21 | Dir Ventas | 1989-10-12 |      106 | 350000.00 | 361865.00 |      21 | Los Angeles | Oeste  | 108 | 725000.00 | 835915.00
      103 | Paul Cruz     |   29 |          12 | Rep Ventas | 1987-03-01 |      104 | 275000.00 | 286775.00 |      21 | Los Angeles | Oeste  | 108 | 725000.00 | 835915.00
      107 | Nancy Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00 |      21 | Los Angeles | Oeste  | 108 | 725000.00 | 835915.00
(50 rows)

-- 4.21- Per a cada venedor, mostrar el nom, les vendes i la ciutat de l'oficina en cas de tenir-ne una d'assignada.
select nombre,ciudad
from repventas,oficinas
where repventas.oficina_rep=oficinas.oficina;

select nombre,oficina_rep,oficinas.ventas,ciudad
from repventas
      join oficinas on oficina_rep=oficina;

    nombre     | oficina_rep |  ventas   |   ciudad    
---------------+-------------+-----------+-------------
 Bill Adams    |          13 | 367911.00 | Atlanta
 Mary Jones    |          11 | 692637.00 | New York
 Sue Smith     |          21 | 835915.00 | Los Angeles
 Sam Clark     |          11 | 692637.00 | New York
 Bob Smith     |          12 | 735042.00 | Chicago
 Dan Roberts   |          12 | 735042.00 | Chicago
 Larry Fitch   |          21 | 835915.00 | Los Angeles
 Paul Cruz     |          12 | 735042.00 | Chicago
 Nancy Angelli |          22 | 186042.00 | Denver
(9 rows)

-- 4.22- Mostra les comandes de productes que tenen unes existències inferiors a 10. Llistar el 
-- numero de comanda, la data de la comanda, el nom del client que ha fet la comanda, identificador
-- del fabricant i l'identificador de producte de la comanda.
select num_pedido,fecha_pedido,empresa,fab,producto
from pedidos,clientes,productos
where fab=id_fab and producto=id_producto and clie=num_clie
and existencias < 10;

select num_pedido,fecha_pedido,empresa,fab,producto
from pedidos
      join clientes on clie=num_clie
      join productos on fab=id_fab and producto=id_producto
where existencias < 10;

 num_pedido | fecha_pedido |     empresa      | fab | producto 
------------+--------------+------------------+-----+----------
     113013 | 1990-01-14   | Midwest Systems  | bic | 41003
     112997 | 1990-01-08   | Peter Brothers   | bic | 41003
     113069 | 1990-03-02   | Chen Associates  | imm | 775c 
     113048 | 1990-02-10   | Rico Enterprises | imm | 779c 
     113003 | 1990-01-25   | Holm & Landis    | imm | 779c 
(5 rows)

select num_pedido,fecha_pedido,empresa,fab,producto
from pedidos
      left join clientes on clie=num_clie
      left join productos on fab=id_fab and producto=id_producto
where existencias < 10;

 num_pedido | fecha_pedido |     empresa      | fab | producto 
------------+--------------+------------------+-----+----------
     113013 | 1990-01-14   | Midwest Systems  | bic | 41003
     112997 | 1990-01-08   | Peter Brothers   | bic | 41003
     113069 | 1990-03-02   | Chen Associates  | imm | 775c 
     113048 | 1990-02-10   | Rico Enterprises | imm | 779c 
     113003 | 1990-01-25   | Holm & Landis    | imm | 779c 
(5 rows)

select num_pedido,fecha_pedido,empresa,fab,producto
from pedidos
      right join clientes on clie=num_clie
      right join productos on fab=id_fab and producto=id_producto
where existencias < 10;

 num_pedido | fecha_pedido |     empresa      | fab | producto 
------------+--------------+------------------+-----+----------
     113013 | 1990-01-14   | Midwest Systems  | bic | 41003
     112997 | 1990-01-08   | Peter Brothers   | bic | 41003
     113069 | 1990-03-02   | Chen Associates  | imm | 775c 
     113048 | 1990-02-10   | Rico Enterprises | imm | 779c 
     113003 | 1990-01-25   | Holm & Landis    | imm | 779c 
            |              |                  |     | 
(6 rows)

select num_pedido,fecha_pedido,empresa,fab,producto
from pedidos
      full join clientes on clie=num_clie
      full join productos on fab=id_fab and producto=id_producto
where existencias < 10;

 num_pedido | fecha_pedido |     empresa      | fab | producto 
------------+--------------+------------------+-----+----------
     113013 | 1990-01-14   | Midwest Systems  | bic | 41003
     112997 | 1990-01-08   | Peter Brothers   | bic | 41003
     113069 | 1990-03-02   | Chen Associates  | imm | 775c 
     113048 | 1990-02-10   | Rico Enterprises | imm | 779c 
     113003 | 1990-01-25   | Holm & Landis    | imm | 779c 
            |              |                  |     | 
(6 rows)

-- 4.23- Llista les 5 comandes amb un import superior. Mostrar l'identificador de la comanda, import
-- de la comanda, preu del producte, nom del client, nom del representant de vendes que va efectuar
-- la comanda i ciutat de l'oficina, en cas de tenir oficina assignada.
select num_pedido,importe,precio,empresa,nombre,ciudad
from pedidos,productos,clientes,repventas,oficinas
where producto=id_producto and fab=id_fab
and clie=num_clie and rep=num_empl and oficina_rep=oficina
and oficina_rep is not null
order by importe desc
limit 5;

select num_pedido,importe,precio,empresa,nombre,ciudad
from pedidos
      join productos on producto=id_producto and fab=id_fab
      join clientes on clie=num_clie
      join repventas on rep=num_empl
      join oficinas on oficina_rep=oficina
where oficina_rep is not null
order by importe desc
limit 5;

 num_pedido | importe  | precio  |     empresa     |    nombre     |   ciudad    
------------+----------+---------+-----------------+---------------+-------------
     113045 | 45000.00 | 4500.00 | Zetacorp        | Larry Fitch   | Los Angeles
     112961 | 31500.00 | 4500.00 | J.P. Sinclair   | Sam Clark     | New York
     113069 | 31350.00 | 1425.00 | Chen Associates | Nancy Angelli | Denver
     112987 | 27500.00 | 2750.00 | Acme Mfg.       | Bill Adams    | Atlanta
     113042 | 22500.00 | 4500.00 | Ian & Schmidt   | Dan Roberts   | Chicago
(5 rows)

select num_pedido,importe,precio,empresa,nombre,ciudad
from pedidos
      left join productos on producto=id_producto and fab=id_fab
      left join clientes on clie=num_clie
      left join repventas on rep=num_empl
      left join oficinas on oficina_rep=oficina
where oficina_rep is not null
order by importe desc
limit 5;

 num_pedido | importe  | precio  |     empresa     |    nombre     |   ciudad    
------------+----------+---------+-----------------+---------------+-------------
     113045 | 45000.00 | 4500.00 | Zetacorp        | Larry Fitch   | Los Angeles
     112961 | 31500.00 | 4500.00 | J.P. Sinclair   | Sam Clark     | New York
     113069 | 31350.00 | 1425.00 | Chen Associates | Nancy Angelli | Denver
     112987 | 27500.00 | 2750.00 | Acme Mfg.       | Bill Adams    | Atlanta
     113042 | 22500.00 | 4500.00 | Ian & Schmidt   | Dan Roberts   | Chicago
(5 rows)

select num_pedido,importe,precio,empresa,nombre,ciudad
from pedidos
      right join productos on producto=id_producto and fab=id_fab
      right join clientes on clie=num_clie
      right join repventas on rep=num_empl
      right join oficinas on oficina_rep=oficina
where oficina_rep is not null
order by importe desc
limit 5;

 num_pedido | importe  | precio  |     empresa     |    nombre     |   ciudad    
------------+----------+---------+-----------------+---------------+-------------
            |          |         |                 | Bob Smith     | Chicago
     113045 | 45000.00 | 4500.00 | Zetacorp        | Larry Fitch   | Los Angeles
     112961 | 31500.00 | 4500.00 | J.P. Sinclair   | Sam Clark     | New York
     113069 | 31350.00 | 1425.00 | Chen Associates | Nancy Angelli | Denver
     112987 | 27500.00 | 2750.00 | Acme Mfg.       | Bill Adams    | Atlanta
(5 rows)

select num_pedido,importe,precio,empresa,nombre,ciudad
from pedidos
      full join productos on producto=id_producto and fab=id_fab
      full join clientes on clie=num_clie
      full join repventas on rep=num_empl
      full join oficinas on oficina_rep=oficina
where oficina_rep is not null
order by importe desc
limit 5;

 num_pedido | importe  | precio  |     empresa     |    nombre     |   ciudad    
------------+----------+---------+-----------------+---------------+-------------
            |          |         |                 | Bob Smith     | Chicago
     113045 | 45000.00 | 4500.00 | Zetacorp        | Larry Fitch   | Los Angeles
     112961 | 31500.00 | 4500.00 | J.P. Sinclair   | Sam Clark     | New York
     113069 | 31350.00 | 1425.00 | Chen Associates | Nancy Angelli | Denver
     112987 | 27500.00 | 2750.00 | Acme Mfg.       | Bill Adams    | Atlanta
(5 rows)

-- 4.24- Llista les comandes que han estat preses per un representant de vendes que no és l'actual
-- representant de vendes del client pel que s'ha realitzat la comanda.
-- Mostrar el número de comanda, el nom del client, el nom de l'actual representant de vendes del
-- client com a "rep_cliente" i el nom del representant de vendes que va realitzar la comanda com
-- a "rep_pedido".
select num_pedido,empresa,rep_cliente.nombre,rep_pedido.nombre
from pedidos,clientes,repventas as rep_cliente,repventas as rep_pedido
where clie=num_clie and rep=rep_pedido.num_empl and rep_clie=rep_cliente.num_empl;

select num_pedido,empresa,rep_cliente.nombre,rep_pedido.nombre
from pedidos
      join clientes on clie=num_clie
      join repventas rep_pedido on rep=rep_pedido.num_empl
      join repventas rep_cliente on rep_clie=rep_cliente.num_empl;

 num_pedido |      empresa      |    nombre     |    nombre     
------------+-------------------+---------------+---------------
     112961 | J.P. Sinclair     | Sam Clark     | Sam Clark
     113012 | JCP Inc.          | Paul Cruz     | Bill Adams
     112989 | Jones Mfg.        | Sam Clark     | Sam Clark
     113051 | Midwest Systems   | Larry Fitch   | Larry Fitch
     112968 | First Corp.       | Dan Roberts   | Dan Roberts
     110036 | Ace International | Tom Snyder    | Tom Snyder
     113045 | Zetacorp          | Larry Fitch   | Larry Fitch
     112963 | Acme Mfg.         | Bill Adams    | Bill Adams
     113013 | Midwest Systems   | Larry Fitch   | Larry Fitch
     113058 | Holm & Landis     | Mary Jones    | Mary Jones
     112997 | Peter Brothers    | Nancy Angelli | Nancy Angelli
     112983 | Acme Mfg.         | Bill Adams    | Bill Adams
     113024 | Orion Corp        | Sue Smith     | Larry Fitch
     113062 | Peter Brothers    | Nancy Angelli | Nancy Angelli
     112979 | Orion Corp        | Sue Smith     | Sue Smith
     113027 | Acme Mfg.         | Bill Adams    | Bill Adams
     113007 | Zetacorp          | Larry Fitch   | Larry Fitch
     113069 | Chen Associates   | Paul Cruz     | Nancy Angelli
     113034 | Ace International | Tom Snyder    | Tom Snyder
     112992 | Midwest Systems   | Larry Fitch   | Larry Fitch
     112975 | JCP Inc.          | Paul Cruz     | Paul Cruz
     113055 | Holm & Landis     | Mary Jones    | Dan Roberts
     113048 | Rico Enterprises  | Sue Smith     | Sue Smith
     112993 | Fred Lewis Corp.  | Sue Smith     | Sue Smith
     113065 | Fred Lewis Corp.  | Sue Smith     | Sue Smith
     113003 | Holm & Landis     | Mary Jones    | Mary Jones
     113049 | Midwest Systems   | Larry Fitch   | Larry Fitch
     112987 | Acme Mfg.         | Bill Adams    | Bill Adams
     113057 | JCP Inc.          | Paul Cruz     | Paul Cruz
     113042 | Ian & Schmidt     | Bob Smith     | Dan Roberts
(30 rows)

select num_pedido,empresa,rep_cliente.nombre,rep_pedido.nombre
from pedidos,clientes,repventas as rep_cliente,repventas as rep_pedido
where clie=num_clie and rep=rep_pedido.num_empl and rep_clie=rep_cliente.num_empl
and rep_cliente.nombre != rep_pedido.nombre;

select num_pedido,empresa,rep_cliente.nombre,rep_pedido.nombre
from pedidos
      join clientes on clie=num_clie
      join repventas rep_pedido on rep=rep_pedido.num_empl
      join repventas rep_cliente on rep_clie=rep_cliente.num_empl
where rep_cliente.nombre != rep_pedido.nombre;

 num_pedido |     empresa     |   nombre   |    nombre     
------------+-----------------+------------+---------------
     113012 | JCP Inc.        | Paul Cruz  | Bill Adams
     113024 | Orion Corp      | Sue Smith  | Larry Fitch
     113069 | Chen Associates | Paul Cruz  | Nancy Angelli
     113055 | Holm & Landis   | Mary Jones | Dan Roberts
     113042 | Ian & Schmidt   | Bob Smith  | Dan Roberts
(5 rows)


-- 4.25- Llista les comandes amb un import superior a 5000 i també aquelles comandes realitzades
-- per un client amb un crèdit inferior a 30000. Mostrar l'identificador de la comanda, el nom del
-- client i el nom del representant de vendes que va prendre la comanda.
select num_pedido,empresa,nombre
from pedidos,clientes,repventas
where clie=num_clie and rep=num_empl
and (importe > 5000 and limite_credito < 30000);

select num_pedido,empresa,nombre
from pedidos
      join clientes on clie=num_clie
      join repventas on rep=num_empl
where importe > 5000 and limite_credito < 30000;

 num_pedido |     empresa     |    nombre     
------------+-----------------+---------------
     113024 | Orion Corp      | Larry Fitch
     112979 | Orion Corp      | Sue Smith
     113069 | Chen Associates | Nancy Angelli
     113042 | Ian & Schmidt   | Dan Roberts
(4 rows)
