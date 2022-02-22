LLISTA D EXERCICIS DE SQL . PRÀCTICA 9
================================================== 

--21.- Es desitja un llistat d'identificadors de fabricants de productes. 
--Només volem tenir en compte els productes de preu superior a 54. 
--Només volem que apareguin els fabricants amb un nombre total d'unitats superior a 300.


training=> select id_fab,sum(existencias) from productos where 
precio > 54 group by id_fab having sum(existencias) > 300;
 id_fab | sum 
--------+-----
 aci    | 843
(1 row)


--22.Es desitja un llistat dels productes amb les seves descripcions, 
--ordenat per la suma total d'imports facturats (pedidos) de cada producte de l'any 1989.

select id_fab, id_producto, descripcion, sum(importe)
from pedidos
join productos on (fab=id_fab and producto=id_producto)
where fecha_pedido >= '1989-01-01' and fecha_pedido <= '1989-12-31'
group by id_fab, id_producto
order by sum(importe) DESC;

 id_fab | id_producto |    descripcion    |   sum    
--------+-------------+-------------------+----------
 rei    | 2a44l       | Bisagra Izqda.    | 31500.00
 aci    | 4100y       | Extractor         | 27500.00
 aci    | 4100z       | Montador          | 15000.00
 aci    | 41004       | Articulo Tipo 4   |  7956.00
 rei    | 2a44g       | Pasador Bisagra   |  2100.00
 rei    | 2a45c       | V Stago Trinquete |  1896.00
 aci    | 41002       | Articulo Tipo 2   |   760.00
(7 rows)

--23. Per a cada director (de personal, no d'oficina) excepte per al gerent (el venedor que no té director), 
--vull saber el total de vendes dels seus subordinats. Mostreu codi i nom dels directors.

training=> select jefes.num_empl,jefes.nombre,sum(importe) from repventas jefes join repventas venedors 
on venedors.director=jefes.num_empl join pedidos 
on venedors.num_empl=rep group by jefes.num_empl;

 num_empl |   nombre    |   sum    
----------+-------------+----------
      106 | Sam Clark   | 65738.00
      108 | Larry Fitch | 57208.00
      101 | Dan Roberts | 23132.00
      104 | Bob Smith   | 68655.00
(4 rows)


training=> select jefes.num_empl,jefes.nombre,sum(importe) from repventas jefes right join repventas venedors 
on venedors.director=jefes.num_empl join pedidos 
on venedors.num_empl=rep group by jefes.num_empl;
 num_empl |   nombre    |   sum    
----------+-------------+----------
          |             | 32958.00
      106 | Sam Clark   | 65738.00
      108 | Larry Fitch | 57208.00
      101 | Dan Roberts | 23132.00
      104 | Bob Smith   | 68655.00
(5 rows)



--24. Quins són els 5 productes que han estat venuts a més clients diferents? 
--Mostreu el número de clients per cada producte. A igualtat de nombre de clients
--es volen ordenats per ordre decreixent d'existències i, a igualtat d'existències, per descripció. 
--Mostreu tots els camps pels quals s'ordena.



training=> select id_fab,id_producto,descripcion,existencias,count(distinct clie) as 
"Clients diferents" from productos join pedidos on id_fab=fab and id_producto=producto 
group by id_fab,id_producto order by 5 desc, 4 desc, 3 limit 5;


 id_fab | id_producto |    descripcion    | existencias | Clients diferents 
--------+-------------+-------------------+-------------+-------------------
 qsa    | xk47        | Reductor          |          38 |                 3
 rei    | 2a45c       | V Stago Trinquete |         210 |                 2
 aci    | 41002       | Articulo Tipo 2   |         167 |                 2
 aci    | 41004       | Articulo Tipo 4   |         139 |                 2
 aci    | 4100x       | Ajustador         |          37 |                 2
(5 rows)



--25. Es vol llistar el clients (codi i empresa) tals que no hagin comprat cap tipus de frontissa ("bisagra" en castellà, figura a la descripció)
-- i hagin comprat articles de més d'un fabricant diferent.


select num_clie,empresa,count(distinct fab) as "Num fabricants diferents" from clientes join pedidos 
on clie=num_clie join productos on fab=id_fab and producto=id_producto where descripcion NOT ILIKE '%bisagra%' 
group by num_clie having count(distinct fab) >1 order by 3;
 num_clie |      empresa      | Num fabricants diferents 
----------+-------------------+--------------------------
     2106 | Fred Lewis Corp.  |                        2
     2107 | Ace International |                        2
     2114 | Orion Corp        |                        2
     2124 | Peter Brothers    |                        2
     2108 | Holm & Landis     |                        3
     2118 | Midwest Systems   |                        3
(6 rows)



--26. Llisteu les oficines per ordre descendent de nombre total de clients diferents amb comandes (pedidos) 
--realizades pels venedors d'aquella oficina, i, a igualtat de clients, ordenat per ordre ascendent del nom 
--del director de l'oficina. Només s'ha de mostrar el codi i la ciutat de l'oficina.


training=# select ciudad,dir.nombre,count(distinct clie) from oficinas join repventas on oficina=oficina_rep 
join pedidos on num_empl=rep join repventas dir on oficinas.dir=dir.num_empl group by oficina, dir.nombre order by 3 desc, 2;



   ciudad    |   nombre    | count 
-------------+-------------+-------
 Los Angeles | Larry Fitch |     5
 Chicago     | Bob Smith   |     4
 New York    | Sam Clark   |     3
 Atlanta     | Bill Adams  |     2
 Denver      | Larry Fitch |     2
(5 rows)


--27.Llista totes les comandes mostrant el seu número, import, nom de client i límit de crèdit. 

training=# select pedidos.num_pedido, pedidos.importe, clientes.empresa, clientes.limite_credito 
from pedidos join clientes on pedidos.clie = clientes.num_clie ;


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


--28.Llista cada un dels venedors i la ciutat i regió on treballen 

training=# select repventas.nombre, oficinas.ciudad, oficinas.region from repventas join oficinas 
on repventas.oficina_rep = oficinas.oficina where repventas.oficina_rep is not null ;
    nombre     |   ciudad    | region 
---------------+-------------+--------
 Bill Adams    | Atlanta     | Este
 Mary Jones    | New York    | Este
 Sue Smith     | Los Angeles | Oeste
 Sam Clark     | New York    | Este
 Bob Smith     | Chicago     | Este
 Dan Roberts   | Chicago     | Este
 Larry Fitch   | Los Angeles | Oeste
 Paul Cruz     | Chicago     | Este
 Nancy Angelli | Denver      | Oeste
(9 rows)


--29.Llista les oficines, i els noms i títols dels directors. 

training=# select oficinas.oficina, repventas.nombre, repventas.titulo 
from oficinas join repventas on oficinas.dir = repventas.num_empl 
where repventas.titulo = 'Dir Ventas' ;

 oficina |   nombre    |   titulo   
---------+-------------+------------
      22 | Larry Fitch | Dir Ventas
      12 | Bob Smith   | Dir Ventas
      21 | Larry Fitch | Dir Ventas
(3 rows)

--30.Llista les oficines, noms i titols del seus directors amb un objectiu superior a 600.000. 

training=# select oficinas.oficina, oficinas.dir, repventas.nombre, repventas.titulo, oficinas.objetivo 
from oficinas join repventas on oficinas.dir = repventas.num_empl
where oficinas.objetivo > 600000 ;
 
 oficina | dir |   nombre    |   titulo   | objetivo  
---------+-----+-------------+------------+-----------
      12 | 104 | Bob Smith   | Dir Ventas | 800000.00
      21 | 108 | Larry Fitch | Dir Ventas | 725000.00
(2 rows)


--31.Llista els venedors de les oficines de la regió est. 

training=# select repventas.nombre, oficinas.oficina, oficinas.region 
from repventas join oficinas on repventas.oficina_rep = oficinas.oficina 
where oficinas.region = 'Este' ;

   nombre    | oficina | region 
-------------+---------+--------
 Bill Adams  |      13 | Este
 Mary Jones  |      11 | Este
 Sam Clark   |      11 | Este
 Bob Smith   |      12 | Este
 Dan Roberts |      12 | Este
 Paul Cruz   |      12 | Este
(6 rows)


--32.Llista totes les comandes, mostrant els imports i les descripcions del producte. 

training=# select pedidos.num_pedido, pedidos.importe, productos.id_producto, 
productos.descripcion from pedidos join productos 
on pedidos.fab = productos.id_fab and pedidos.producto = productos.id_producto ;


 num_pedido | importe  | id_producto |    descripcion    
------------+----------+-------------+-------------------
     113027 |  4104.00 | 41002       | Articulo Tipo 2
     112992 |   760.00 | 41002       | Articulo Tipo 2
     113012 |  3745.00 | 41003       | Articulo Tipo 3
     112963 |  3276.00 | 41004       | Articulo Tipo 4
     112983 |   702.00 | 41004       | Articulo Tipo 4
     112968 |  3978.00 | 41004       | Articulo Tipo 4
     113055 |   150.00 | 4100x       | Ajustador
     113057 |   600.00 | 4100x       | Ajustador
     112987 | 27500.00 | 4100y       | Extractor
     110036 | 22500.00 | 4100z       | Montador
     112979 | 15000.00 | 4100z       | Montador
     112997 |   652.00 | 41003       | Manivela
     113013 |   652.00 | 41003       | Manivela
     113058 |  1480.00 | 112         | Cubierta
     113062 |  2430.00 | 114         | Bancada Motor
     112989 |  1458.00 | 114         | Bancada Motor
     113007 |  2925.00 | 773c        | Riostra 1/2-Tm
     113069 | 31350.00 | 775c        | Riostra 1-Tm
     113048 |  3750.00 | 779c        | Riostra 2-Tm
     113003 |  5625.00 | 779c        | Riostra 2-Tm
     113065 |  2130.00 | xk47        | Reductor
     113024 |  7100.00 | xk47        | Reductor
     113049 |   776.00 | xk47        | Reductor
     112975 |  2100.00 | 2a44g       | Pasador Bisagra
     112961 | 31500.00 | 2a44l       | Bisagra Izqda.
     113045 | 45000.00 | 2a44r       | Bisagra Dcha.
     113042 | 22500.00 | 2a44r       | Bisagra Dcha.
     112993 |  1896.00 | 2a45c       | V Stago Trinquete
     113034 |   632.00 | 2a45c       | V Stago Trinquete
(29 rows)


--33.Llista les comandes superiors a 25.000, incloent el nom del venedor que va servir la comanda i el nom del client que el va sol·licitar. 


training=#  select pedidos.num_pedido, pedidos.importe, repventas.nombre, clientes.empresa 
from pedidos join repventas on pedidos.rep = repventas.num_empl 
join clientes on pedidos.clie = clientes.num_clie
 where pedidos.importe > 25000;
 
 num_pedido | importe  |    nombre     |     empresa     
------------+----------+---------------+-----------------
     112961 | 31500.00 | Sam Clark     | J.P. Sinclair
     113045 | 45000.00 | Larry Fitch   | Zetacorp
     113069 | 31350.00 | Nancy Angelli | Chen Associates
     112987 | 27500.00 | Bill Adams    | Acme Mfg.
(4 rows)


--34.Llista les comandes superiors a 25000, mostrant el client que va demanar la comanda i el nom del venedor que té assignat el client. 


training=# select pedidos.num_pedido, pedidos.importe, pedidos.clie, 
repventas.nombre from pedidos join clientes on pedidos.clie = clientes.num_clie 
join repventas on clientes.rep_clie = repventas.num_empl where pedidos.importe > 25000;


 num_pedido | importe  | clie |   nombre    
------------+----------+------+-------------
     112961 | 31500.00 | 2117 | Sam Clark
     113045 | 45000.00 | 2112 | Larry Fitch
     113069 | 31350.00 | 2109 | Paul Cruz
     112987 | 27500.00 | 2103 | Bill Adams
(4 rows)


--35.Llista les comandes superiors a 25000, mostrant el nom del client que el va 
ordenar, el venedor associat al client, i l oficina on el venedor treballa. 

training=# select pedidos.num_pedido, pedidos.importe, repventas.nombre, clientes.rep_clie, pedidos.clie, oficinas.oficina
from pedidos join clientes on pedidos.clie = clientes.num_clie 
join repventas on repventas.num_empl = clientes.rep_clie
 join oficinas on repventas.oficina_rep = oficinas.oficina 
 where pedidos.importe > 25000;
 num_pedido | importe  |   nombre    | rep_clie | clie | oficina 
------------+----------+-------------+----------+------+---------
     112961 | 31500.00 | Sam Clark   |      106 | 2117 |      11
     113045 | 45000.00 | Larry Fitch |      108 | 2112 |      21
     113069 | 31350.00 | Paul Cruz   |      103 | 2109 |      12
     112987 | 27500.00 | Bill Adams  |      105 | 2103 |      13
(4 rows)


--35 Llista les comandes superiors a 25000, mostrant el nom del client que el 
va ordenar, el venedor associat al client, i l oficina on el venedor treballa. També cal que mostris la descripció del producte. 

training=# select pedidos.num_pedido, pedidos.importe, repventas.nombre, clientes.rep_clie, pedidos.clie, oficinas.oficina, productos.descripcion
from pedidos join productos on( pedidos.fab = productos.id_fab and pedidos.producto = productos.id_producto)
join clientes on pedidos.clie = clientes.num_clie
join repventas on repventas.num_empl = clientes.rep_clie 
join oficinas on repventas.oficina_rep = oficinas.oficina 
where pedidos.importe > 25000;

 num_pedido | importe  |   nombre    | rep_clie | clie | oficina |  descripcion   
------------+----------+-------------+----------+------+---------+----------------
     112987 | 27500.00 | Bill Adams  |      105 | 2103 |      13 | Extractor
     113069 | 31350.00 | Paul Cruz   |      103 | 2109 |      12 | Riostra 1-Tm
     112961 | 31500.00 | Sam Clark   |      106 | 2117 |      11 | Bisagra Izqda.
     113045 | 45000.00 | Larry Fitch |      108 | 2112 |      21 | Bisagra Dcha.
(4 rows)


--36.Trobar totes les comandes rebudes en els dies en que un nou venedor va ser contractat. 

training=# select distinct num_pedido,contrato from repventas,pedidos where contrato=fecha_pedido;
 num_pedido |  contrato  
------------+------------
     112979 | 1989-10-12
     112968 | 1989-10-12
(2 rows)


--37.Llista totes les combinacions de venedors i oficines on la quota del venedor és superior a l'objectiu de l'oficina. 

training=# select * from oficinas, repventas  where repventas.cuota > oficinas.objetivo ;
 oficina | ciudad | region | dir | objetivo  |  ventas   | num_empl |   nombre    | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ve
ntas   
---------+--------+--------+-----+-----------+-----------+----------+-------------+------+-------------+------------+------------+----------+-----------+----
-------
      22 | Denver | Oeste  | 108 | 300000.00 | 186042.00 |      105 | Bill Adams  |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367
911.00
      22 | Denver | Oeste  | 108 | 300000.00 | 186042.00 |      102 | Sue Smith   |   48 |          21 | Rep Ventas | 1986-12-10 |      108 | 350000.00 | 474
050.00
      22 | Denver | Oeste  | 108 | 300000.00 | 186042.00 |      108 | Larry Fitch |   62 |          21 | Dir Ventas | 1989-10-12 |      106 | 350000.00 | 361
865.00
(3 rows)

--38.Mostra el nom, les vendes i l'oficina de cada venedor. 


training=# select sum(pedidos.importe), oficinas.oficina, repventas.nombre, pedidos.rep 
from repventas join pedidos on repventas.num_empl = pedidos.rep 
join oficinas on repventas.oficina_rep = oficinas.oficina
 group by pedidos.rep, oficinas.oficina, repventas.nombre ;
 
 
   sum    | oficina |    nombre     | rep 
----------+---------+---------------+-----      
 26628.00 |      12 | Dan Roberts   | 101
 58633.00 |      21 | Larry Fitch   | 108
 32958.00 |      11 | Sam Clark     | 106
  2700.00 |      12 | Paul Cruz     | 103
 34432.00 |      22 | Nancy Angelli | 107
 22776.00 |      21 | Sue Smith     | 102
 39327.00 |      13 | Bill Adams    | 105
  7105.00 |      11 | Mary Jones    | 109
(8 rows)


--39.Informa sobre tots els venedors i les oficines en les que treballen. 


training=# select repventas.nombre, oficinas.oficina from repventas join oficinas on repventas.oficina_rep = oficinas.oficina ;
    nombre     | oficina 
---------------+---------
 Bill Adams    |      13
 Mary Jones    |      11
 Sue Smith     |      21
 Sam Clark     |      11
 Bob Smith     |      12
 Dan Roberts   |      12
 Larry Fitch   |      21
 Paul Cruz     |      12
 Nancy Angelli |      22
(9 rows)



--40.Informa sobre tots els venedors (tota la informació de repventas) més la ciutat i regió on treballen. 

training=# select repventas.* , oficinas.ciudad, oficinas.region from repventas join oficinas on repventas.oficina_rep = oficinas.oficina ;

 num_empl |    nombre     | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   |   ciudad    | region 
----------+---------------+------+-------------+------------+------------+----------+-----------+-----------+-------------+--------
      105 | Bill Adams    |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367911.00 | Atlanta     | Este
      109 | Mary Jones    |   31 |          11 | Rep Ventas | 1989-10-12 |      106 | 300000.00 | 392725.00 | New York    | Este
      102 | Sue Smith     |   48 |          21 | Rep Ventas | 1986-12-10 |      108 | 350000.00 | 474050.00 | Los Angeles | Oeste
      106 | Sam Clark     |   52 |          11 | VP Ventas  | 1988-06-14 |          | 275000.00 | 299912.00 | New York    | Este
      104 | Bob Smith     |   33 |          12 | Dir Ventas | 1987-05-19 |      106 | 200000.00 | 142594.00 | Chicago     | Este
      101 | Dan Roberts   |   45 |          12 | Rep Ventas | 1986-10-20 |      104 | 300000.00 | 305673.00 | Chicago     | Este
      108 | Larry Fitch   |   62 |          21 | Dir Ventas | 1989-10-12 |      106 | 350000.00 | 361865.00 | Los Angeles | Oeste
      103 | Paul Cruz     |   29 |          12 | Rep Ventas | 1987-03-01 |      104 | 275000.00 | 286775.00 | Chicago     | Este
      107 | Nancy Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00 | Denver      | Oeste
(9 rows)


--41.Llista el nom dels venedors i el del seu director. 


training=# select dir.nombre, rep.nombre as "nombre director" from repventas rep join repventas dir on rep.num_empl = dir.director ;
    nombre     | nombre director 
---------------+-----------------
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


--42.Llista els venedors amb una quota superior a la dels seus directors. 



training=# select dir.nombre, rep.nombre as "nombre director", rep.cuota as "cuota dir", dir.cuota 
from repventas rep join repventas dir on rep.num_empl = dir.director 
where dir.cuota > rep.cuota;
   nombre    | nombre director | cuota dir |   cuota   
-------------+-----------------+-----------+-----------
 Bill Adams  | Bob Smith       | 200000.00 | 350000.00
 Mary Jones  | Sam Clark       | 275000.00 | 300000.00
 Dan Roberts | Bob Smith       | 200000.00 | 300000.00
 Larry Fitch | Sam Clark       | 275000.00 | 350000.00
 Paul Cruz   | Bob Smith       | 200000.00 | 275000.00
(5 rows)


--43.Llista totes les combinacions possibles de venedors i ciutats. 

training=# select repventas.nombre, oficinas.ciudad from repventas, oficinas;
    nombre     |   ciudad    
---------------+-------------
 Bill Adams    | Denver
 Mary Jones    | Denver
 Sue Smith     | Denver
 Sam Clark     | Denver
 Bob Smith     | Denver
 Dan Roberts   | Denver
 Tom Snyder    | Denver
 Larry Fitch   | Denver
 Paul Cruz     | Denver
 Nancy Angelli | Denver
 Bill Adams    | New York
 Mary Jones    | New York
 Sue Smith     | New York
 Sam Clark     | New York
 Bob Smith     | New York
 Dan Roberts   | New York
 Tom Snyder    | New York
 Larry Fitch   | New York
 Paul Cruz     | New York
 Nancy Angelli | New York
 Bill Adams    | Chicago
 Mary Jones    | Chicago
 Sue Smith     | Chicago
 Sam Clark     | Chicago
 Bob Smith     | Chicago
 Dan Roberts   | Chicago
 Tom Snyder    | Chicago
 Larry Fitch   | Chicago
 Paul Cruz     | Chicago
 Nancy Angelli | Chicago
 Bill Adams    | Atlanta
 Mary Jones    | Atlanta
 Sue Smith     | Atlanta
 Sam Clark     | Atlanta
 Bob Smith     | Atlanta
 Dan Roberts   | Atlanta
 Tom Snyder    | Atlanta
 Larry Fitch   | Atlanta
 Paul Cruz     | Atlanta
 Nancy Angelli | Atlanta
 Bill Adams    | Los Angeles
 Mary Jones    | Los Angeles
 Sue Smith     | Los Angeles
 Sam Clark     | Los Angeles
 Bob Smith     | Los Angeles
 Dan Roberts   | Los Angeles
 Tom Snyder    | Los Angeles
 Larry Fitch   | Los Angeles
 Paul Cruz     | Los Angeles
 Nancy Angelli | Los Angeles
(50 rows)


--44.Llistar el nom de l'empresa i totes les comandes fetes pel client 2.103. 


training=# select pedidos.num_pedido, clientes.empresa, pedidos.clie 
from pedidos join clientes on pedidos.clie = clientes.num_clie where pedidos.clie = '2103';


 num_pedido |  empresa  | clie 
------------+-----------+------
     112963 | Acme Mfg. | 2103
     112983 | Acme Mfg. | 2103
     113027 | Acme Mfg. | 2103
     112987 | Acme Mfg. | 2103
(4 rows)


45.Llista els venedors i les oficines en què treballen. 


training=# select repventas.nombre, oficinas.oficina from repventas join oficinas on repventas.oficina_rep = oficinas.oficina ;
    nombre     | oficina 
---------------+---------
 Bill Adams    |      13
 Mary Jones    |      11
 Sue Smith     |      21
 Sam Clark     |      11
 Bob Smith     |      12
 Dan Roberts   |      12
 Larry Fitch   |      21
 Paul Cruz     |      12
 Nancy Angelli |      22
(9 rows)

-- amb left join veiem que el tom snyder no te oficina

training=> select repventas.nombre, oficinas.oficina from repventas left join oficinas on repventas.oficina_rep = oficinas.oficina ;
    nombre     | oficina 
---------------+---------
 Bill Adams    |      13
 Mary Jones    |      11
 Sue Smith     |      21
 Sam Clark     |      11
 Bob Smith     |      12
 Dan Roberts   |      12
 Tom Snyder    |        
 Larry Fitch   |      21
 Paul Cruz     |      12
 Nancy Angelli |      22
(10 rows)




46.Llista els venedors i les ciutats en què treballen. 

training=# select repventas.nombre, oficinas.ciudad from repventas join oficinas on repventas.oficina_rep = oficinas.oficina ;
    nombre     |   ciudad    
---------------+-------------
 Bill Adams    | Atlanta
 Mary Jones    | New York
 Sue Smith     | Los Angeles
 Sam Clark     | New York
 Bob Smith     | Chicago
 Dan Roberts   | Chicago
 Larry Fitch   | Los Angeles
 Paul Cruz     | Chicago
 Nancy Angelli | Denver
(9 rows)









