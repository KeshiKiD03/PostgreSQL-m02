-- LLISTA D'EXERCICIS DE SQL . PRÀCTICA 11
-- ==================================================
-- 21.- Es desitja un llistat d'identificadors de fabricants de productes. Només volem tenir en compte els
-- productes de preu superior a 54. Només volem que apareguin els fabricants amb un nombre total d'unitats
-- superior a 300.
select id_fab,id_producto,precio,sum(cant) as unidades
from productos
    join pedidos on id_fab=fab and id_producto=producto
where precio > 54
group by id_fab,id_producto
having sum(cant) > 30;

 id_fab | id_producto | precio | unidades 
--------+-------------+--------+----------
 aci    | 41002       |  76.00 |       64
 aci    | 41003       | 107.00 |       35
 aci    | 41004       | 117.00 |       68
 rei    | 2a45c       |  79.00 |       32
(4 rows)

-- 22.Es desitja un llistat dels productes amb les seves descripcions, ordenat per la suma total d'imports
-- facturats (pedidos) de cada producte de l'any 1989.
select id_producto,descripcion,sum(importe) as total_importes
from productos
    join pedidos on id_fab=fab and id_producto=producto
where fecha_pedido >= '1989-01-01' and fecha_pedido <= '1989-12-31'
group by id_producto,descripcion
order by 3;

 id_producto |    descripcion    | total_importes 
-------------+-------------------+----------------
 41002       | Articulo Tipo 2   |         760.00
 2a45c       | V Stago Trinquete |        1896.00
 2a44g       | Pasador Bisagra   |        2100.00
 41004       | Articulo Tipo 4   |        7956.00
 4100z       | Montador          |       15000.00
 4100y       | Extractor         |       27500.00
 2a44l       | Bisagra Izqda.    |       31500.00
(7 rows)

-- 23. Per a cada director (de personal, no d'oficina) excepte per al gerent (el venedor que no té director),
-- vull saber el total de vendes dels seus subordinats. Mostreu codi i nom dels directors.
select rep.director,dir.nombre,sum(rep.ventas) as total_ventas
from repventas rep
    join repventas dir on rep.director=dir.num_empl
where rep.director is not null
group by rep.director,dir.nombre;

 director |   nombre    | total_ventas 
----------+-------------+--------------
      104 | Bob Smith   |    960359.00
      108 | Larry Fitch |    660092.00
      101 | Dan Roberts |     75985.00
      106 | Sam Clark   |    897184.00
(4 rows)

-- 24. Quins són els 5 productes que han estat venuts a més clients diferents? Mostreu el número de clients
-- per cada producte. A igualtat de nombre de clients es volen ordenats per ordre decreixent d'existències i, a
-- igualtat d'existències, per descripció. Mostreu tots els camps pels quals s'ordena.
select count(clie) as clientes,producto,descripcion,existencias
from pedidos
    join productos on fab=id_fab and producto=id_producto
group by producto,descripcion,existencias
order by clientes desc,descripcion desc
limit 5;

 clientes | producto |    descripcion    | existencias 
----------+----------+-------------------+-------------
        3 | xk47     | Reductor          |          38
        3 | 41004    | Articulo Tipo 4   |         139
        2 | 2a45c    | V Stago Trinquete |         210
        2 | 779c     | Riostra 2-Tm      |           9
        2 | 4100z    | Montador          |          28
(5 rows)

-- 25. Es vol llistar el clients (codi i empresa) tals que no hagin comprat cap tipus de frontissa ("bisagra" en
-- castellà, figura a la descripció) i hagin comprat articles de més d'un fabricant diferent.
select clie,empresa
from pedidos
    join clientes on clie=num_clie
    join productos on fab=id_fab and producto=id_producto
where descripcion not like '%Bisagra%'
group by clie,empresa
having count(fab) > 1;

 clie |      empresa      
------+-------------------
 2103 | Acme Mfg.
 2106 | Fred Lewis Corp.
 2107 | Ace International
 2108 | Holm & Landis
 2111 | JCP Inc.
 2114 | Orion Corp
 2118 | Midwest Systems
 2124 | Peter Brothers
(8 rows)

-- 26. Llisteu les oficines per ordre descendent de nombre total de clients diferents amb comandes (pedidos)
-- realizades pels venedors d'aquella oficina, i, a igualtat de clients, ordenat per ordre ascendent del nom del
-- director de l'oficina. Només s'ha de mostrar el codi i la ciutat de l'oficina.
select oficina,ciudad,count(pedidos.clie) as clientes,dir,nombre
from oficinas
    join repventas on dir=num_empl 
    join pedidos on num_empl=rep
group by oficina,nombre
order by clientes desc,nombre asc;

 oficina |   ciudad    | clientes | dir |   nombre    
---------+-------------+----------+-----+-------------
      21 | Los Angeles |        7 | 108 | Larry Fitch
      22 | Denver      |        7 | 108 | Larry Fitch
      13 | Atlanta     |        5 | 105 | Bill Adams
      11 | New York    |        2 | 106 | Sam Clark
(4 rows)

-- 27.Llista totes les comandes mostrant el seu número, import, nom de client i límit de crèdit.
select num_pedido,importe,empresa,limite_credito
from pedidos
    join clientes on clie=num_clie;

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

-- 28.Llista cada un dels venedors i la ciutat i regió on treballen
select num_empl,ciudad,region
from repventas
    left join oficinas on oficina_rep=oficina;

 num_empl |   ciudad    | region 
----------+-------------+--------
      105 | Atlanta     | Este
      109 | New York    | Este
      102 | Los Angeles | Oeste
      106 | New York    | Este
      104 | Chicago     | Este
      101 | Chicago     | Este
      110 |             | 
      108 | Los Angeles | Oeste
      103 | Chicago     | Este
      107 | Denver      | Oeste
(10 rows)

-- 29.Llista les oficines, i els noms i títols dels directors.
select oficina,nombre,titulo
from oficinas
    join repventas on dir=num_empl;

 oficina |   nombre    |   titulo   
---------+-------------+------------
      22 | Larry Fitch | Dir Ventas
      11 | Sam Clark   | VP Ventas
      12 | Bob Smith   | Dir Ventas
      13 | Bill Adams  | Rep Ventas
      21 | Larry Fitch | Dir Ventas
(5 rows)

-- 30.Llista les oficines, noms i titols del seus directors amb un objectiu superior a 600.000.
select oficina,nombre,titulo,objetivo
from oficinas
    join repventas on dir=num_empl
where objetivo > 600000;

 oficina |   nombre    |   titulo   | objetivo  
---------+-------------+------------+-----------
      12 | Bob Smith   | Dir Ventas | 800000.00
      21 | Larry Fitch | Dir Ventas | 725000.00
(2 rows)

-- 31.Llista els venedors de les oficines de la regió est.
select num_empl
from repventas
    join oficinas on oficina_rep=oficina
where region='Este';

 num_empl 
----------
      105
      109
      106
      104
      101
      103
(6 rows)

-- 32.Llista totes les comandes, mostrant els imports i les descripcions del producte.
select num_pedido,importe,descripcion
from pedidos
    left join productos on fab=id_fab and producto=id_producto;

 num_pedido | importe  |    descripcion    
------------+----------+-------------------
     112961 | 31500.00 | Bisagra Izqda.
     113012 |  3745.00 | Articulo Tipo 3
     112989 |  1458.00 | Bancada Motor
     113051 |  1420.00 | 
     112968 |  3978.00 | Articulo Tipo 4
     110036 | 22500.00 | Montador
     113045 | 45000.00 | Bisagra Dcha.
     112963 |  3276.00 | Articulo Tipo 4
     113013 |   652.00 | Manivela
     113058 |  1480.00 | Cubierta
     112997 |   652.00 | Manivela
     112983 |   702.00 | Articulo Tipo 4
     113024 |  7100.00 | Reductor
     113062 |  2430.00 | Bancada Motor
     112979 | 15000.00 | Montador
     113027 |  4104.00 | Articulo Tipo 2
     113007 |  2925.00 | Riostra 1/2-Tm
     113069 | 31350.00 | Riostra 1-Tm
     113034 |   632.00 | V Stago Trinquete
     112992 |   760.00 | Articulo Tipo 2
     112975 |  2100.00 | Pasador Bisagra
     113055 |   150.00 | Ajustador
     113048 |  3750.00 | Riostra 2-Tm
     112993 |  1896.00 | V Stago Trinquete
     113065 |  2130.00 | Reductor
     113003 |  5625.00 | Riostra 2-Tm
     113049 |   776.00 | Reductor
     112987 | 27500.00 | Extractor
     113057 |   600.00 | Ajustador
     113042 | 22500.00 | Bisagra Dcha.
(30 rows)

-- 33.Llista les comandes superiors a 25.000, incloent el nom del venedor que va servir la comanda i el nom
-- del client que el va sol·licitar.
select num_pedido as pedido,nombre as vendedor,empresa as cliente
from pedidos
    join repventas on rep=num_empl
    join clientes on clie=num_clie
where importe > 25000;

 pedido |   vendedor    |     cliente     
--------+---------------+-----------------
 112961 | Sam Clark     | J.P. Sinclair
 113045 | Larry Fitch   | Zetacorp
 113069 | Nancy Angelli | Chen Associates
 112987 | Bill Adams    | Acme Mfg.
(4 rows)

-- 34.Llista les comandes superiors a 25000, mostrant el client que va demanar la comanda i el nom del
-- venedor que té assignat el client.
select num_pedido as pedido,empresa as cliente,nombre as rep_clie
from pedidos
    join clientes on clie=num_clie
    join repventas on rep_clie=num_empl
where importe > 25000;

 pedido |     cliente     |  rep_clie   
--------+-----------------+-------------
 112961 | J.P. Sinclair   | Sam Clark
 113045 | Zetacorp        | Larry Fitch
 113069 | Chen Associates | Paul Cruz
 112987 | Acme Mfg.       | Bill Adams
(4 rows)

-- 35.Llista les comandes superiors a 25000, mostrant el nom del client que el va
-- ordenar, el venedor associat al client, i l'oficina on el venedor treballa.
select num_pedido as pedido,empresa as cliente,clie.nombre as rep_clie,rep.oficina_rep
from pedidos
    join clientes on clie=num_clie
    join repventas clie on rep_clie=clie.num_empl
    join repventas rep on rep=rep.num_empl
where importe > 25000;

 pedido |     cliente     |  rep_clie   | oficina_rep 
--------+-----------------+-------------+-------------
 112961 | J.P. Sinclair   | Sam Clark   |          11
 113045 | Zetacorp        | Larry Fitch |          21
 113069 | Chen Associates | Paul Cruz   |          22
 112987 | Acme Mfg.       | Bill Adams  |          13
(4 rows)

-- 35bis.- Llista les comandes superiors a 25000, mostrant el nom del client que el
-- va ordenar, el venedor associat al client, i l'oficina on el venedor treballa. També cal que mostris la
-- descripció del producte.
select num_pedido as pedido,empresa as cliente,clie.nombre as rep_clie,rep.nombre as nom_rep,rep.oficina_rep,descripcion
from pedidos
    join clientes on clie=num_clie
    join repventas clie on rep_clie=clie.num_empl
    join repventas rep on rep=rep.num_empl
    join productos on producto=id_producto and fab=id_fab
where importe > 25000;

 pedido |     cliente     |  rep_clie   | oficina_rep |  descripcion   
--------+-----------------+-------------+-------------+----------------
 112961 | J.P. Sinclair   | Sam Clark   |          11 | Bisagra Izqda.
 113045 | Zetacorp        | Larry Fitch |          21 | Bisagra Dcha.
 113069 | Chen Associates | Paul Cruz   |          22 | Riostra 1-Tm
 112987 | Acme Mfg.       | Bill Adams  |          13 | Extractor
(4 rows)

-- *36.Trobar totes les comandes rebudes en els dies en que un nou venedor va ser contractat.
select num_pedido from pedidos
    left join repventas on fecha_pedido=contrato 
where fecha_pedido=contrato;

 num_pedido 
------------
     112968
     112968
     112979
     112979
(4 rows)

-- *37.Llista totes les combinacions de venedors i oficines on la quota del venedor és superior a l'objectiu de
-- l'oficina.
select num_empl,oficina from repventas
join oficinas on oficina_rep=oficina
where cuota >= objetivo;

 num_empl | oficina 
----------+---------
      105 |      13
      107 |      22
(2 rows)

-- *38.Mostra el nom, les vendes i l'oficina de cada venedor.
select nombre,oficinas.ventas,oficina_rep
from repventas
    left join oficinas on oficina_rep=oficina;

    nombre     |  ventas   | oficina_rep 
---------------+-----------+-------------
 Bill Adams    | 367911.00 |          13
 Mary Jones    | 692637.00 |          11
 Sue Smith     | 835915.00 |          21
 Sam Clark     | 692637.00 |          11
 Bob Smith     | 735042.00 |          12
 Dan Roberts   | 735042.00 |          12
 Tom Snyder    |           |            
 Larry Fitch   | 835915.00 |          21
 Paul Cruz     | 735042.00 |          12
 Nancy Angelli | 186042.00 |          22
(10 rows)

-- *39.Informa sobre tots els venedors i les oficines en les que treballen.
select num_empl,oficina
from repventas
    left join oficinas on oficina_rep=oficina;

 num_empl | oficina 
----------+---------
      105 |      13
      109 |      11
      102 |      21
      106 |      11
      104 |      12
      101 |      12
      110 |        
      108 |      21
      103 |      12
      107 |      22
(10 rows)
 
-- *40.Informa sobre tots els venedors (tota la informació de repventas) més la ciutat i regió on treballen.
select repventas.*,ciudad,region
from repventas
    left join oficinas on oficina_rep=oficina;

 num_empl |    nombre     | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   |   ciudad    | region 
----------+---------------+------+-------------+------------+------------+----------+-----------+-----------+-------------+--------
      105 | Bill Adams    |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367911.00 | Atlanta     | Este
      109 | Mary Jones    |   31 |          11 | Rep Ventas | 1989-10-12 |      106 | 300000.00 | 392725.00 | New York    | Este
      102 | Sue Smith     |   48 |          21 | Rep Ventas | 1986-12-10 |      108 | 350000.00 | 474050.00 | Los Angeles | Oeste
      106 | Sam Clark     |   52 |          11 | VP Ventas  | 1988-06-14 |          | 275000.00 | 299912.00 | New York    | Este
      104 | Bob Smith     |   33 |          12 | Dir Ventas | 1987-05-19 |      106 | 200000.00 | 142594.00 | Chicago     | Este
      101 | Dan Roberts   |   45 |          12 | Rep Ventas | 1986-10-20 |      104 | 300000.00 | 305673.00 | Chicago     | Este
      110 | Tom Snyder    |   41 |             | Rep Ventas | 1990-01-13 |      101 |           |  75985.00 |             | 
      108 | Larry Fitch   |   62 |          21 | Dir Ventas | 1989-10-12 |      106 | 350000.00 | 361865.00 | Los Angeles | Oeste
      103 | Paul Cruz     |   29 |          12 | Rep Ventas | 1987-03-01 |      104 | 275000.00 | 286775.00 | Chicago     | Este
      107 | Nancy Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00 | Denver      | Oeste
(10 rows)

-- (*)41.Llista el nom dels venedors i el del seu director.
select rep.nombre,dir.nombre
from repventas rep
    join repventas dir on rep.director=dir.num_empl;

    nombre     |   nombre    
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

-- 42.Llista els venedors amb una quota superior a la dels seus directors.
select rep.nombre,rep.cuota from repventas rep
    left join repventas dir on rep.director=dir.num_empl
where rep.cuota > dir.cuota;

   nombre    |   cuota   
-------------+-----------
 Bill Adams  | 350000.00
 Mary Jones  | 300000.00
 Dan Roberts | 300000.00
 Larry Fitch | 350000.00
 Paul Cruz   | 275000.00
(5 rows)

-- 43.Llista totes les combinacions possibles de venedors i ciutats.
select nombre,ciudad from repventas
    join oficinas on oficina_rep=oficina;

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

-- 44.Llistar el nom de l'empresa i totes les comandes fetes pel client 2.103.
select empresa,num_pedido from clientes
    join pedidos on num_clie=clie
where num_clie=2103;

  empresa  | num_pedido 
-----------+------------
 Acme Mfg. |     112963
 Acme Mfg. |     112983
 Acme Mfg. |     113027
 Acme Mfg. |     112987
(4 rows)

-- 45.Llista els venedors i les oficines en què treballen.
select num_empl,oficina
from repventas
    join oficinas on oficina_rep=oficina;

 num_empl | oficina 
----------+---------
      105 |      13
      109 |      11
      102 |      21
      106 |      11
      104 |      12
      101 |      12
      108 |      21
      103 |      12
      107 |      22
(9 rows)

-- 46.Llista els venedors i les ciutats en què treballen.
select num_empl,ciudad
from repventas
    join oficinas on oficina_rep=oficina;

 num_empl |   ciudad    
----------+-------------
      105 | Atlanta
      109 | New York
      102 | Los Angeles
      106 | New York
      104 | Chicago
      101 | Chicago
      108 | Los Angeles
      103 | Chicago
      107 | Denver
(9 rows)

-- 47.Fes que la consulta anterior mostri les dades dels deu venedors.
select repventas.*,ciudad
from repventas
    left join oficinas on oficina_rep=oficina;

 num_empl |    nombre     | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   |   ciudad    
----------+---------------+------+-------------+------------+------------+----------+-----------+-----------+-------------
      105 | Bill Adams    |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367911.00 | Atlanta
      109 | Mary Jones    |   31 |          11 | Rep Ventas | 1989-10-12 |      106 | 300000.00 | 392725.00 | New York
      102 | Sue Smith     |   48 |          21 | Rep Ventas | 1986-12-10 |      108 | 350000.00 | 474050.00 | Los Angeles
      106 | Sam Clark     |   52 |          11 | VP Ventas  | 1988-06-14 |          | 275000.00 | 299912.00 | New York
      104 | Bob Smith     |   33 |          12 | Dir Ventas | 1987-05-19 |      106 | 200000.00 | 142594.00 | Chicago
      101 | Dan Roberts   |   45 |          12 | Rep Ventas | 1986-10-20 |      104 | 300000.00 | 305673.00 | Chicago
      110 | Tom Snyder    |   41 |             | Rep Ventas | 1990-01-13 |      101 |           |  75985.00 | 
      108 | Larry Fitch   |   62 |          21 | Dir Ventas | 1989-10-12 |      106 | 350000.00 | 361865.00 | Los Angeles
      103 | Paul Cruz     |   29 |          12 | Rep Ventas | 1987-03-01 |      104 | 275000.00 | 286775.00 | Chicago
      107 | Nancy Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00 | Denver
(10 rows)

-- 48. Quants representants de ventes té cada oficina?. Visualitza el codi d’oficina, el nom de la ciutat, el
-- nom del cap de l’oficina i el número de treballadors assignats.
select oficina,ciudad,dir.nombre,count(rep.*) from oficinas
    join repventas rep on oficina=rep.oficina_rep
    join repventas dir on dir=dir.num_empl
group by oficina,dir.nombre;

 oficina |   ciudad    |   nombre    | count 
---------+-------------+-------------+-------
      22 | Denver      | Larry Fitch |     1
      21 | Los Angeles | Larry Fitch |     2
      11 | New York    | Sam Clark   |     2
      12 | Chicago     | Bob Smith   |     3
      13 | Atlanta     | Bill Adams  |     1
(5 rows)

-- 49.Mostra el nom dels clients que han comprat productes de les fàbriques amb un codi que contingui la
-- lletra 'i' o la lletra 'a' però no la lletra 'm'.
select empresa from clientes
    join pedidos on num_clie=clie
where (fab like '%i%' or fab like '%a%') and fab not like '%m%';

      empresa      
-------------------
 J.P. Sinclair
 JCP Inc.
 Jones Mfg.
 Midwest Systems
 First Corp.
 Ace International
 Zetacorp
 Acme Mfg.
 Midwest Systems
 Holm & Landis
 Peter Brothers
 Acme Mfg.
 Orion Corp
 Peter Brothers
 Orion Corp
 Acme Mfg.
 Ace International
 Midwest Systems
 JCP Inc.
 Holm & Landis
 Fred Lewis Corp.
 Fred Lewis Corp.
 Midwest Systems
 Acme Mfg.
 JCP Inc.
 Ian & Schmidt
(26 rows)

-- 50.Mostra els noms dels productes que han comprat els clients que tenen dos espais en blanc en el seu
-- nom.
select descripcion,empresa from productos
    join pedidos on id_fab=fab and id_producto=producto
    join clientes on clie=num_clie
where empresa like '% % %';

    descripcion    |     empresa      
-------------------+------------------
 Cubierta          | Holm & Landis
 Ajustador         | Holm & Landis
 V Stago Trinquete | Fred Lewis Corp.
 Reductor          | Fred Lewis Corp.
 Riostra 2-Tm      | Holm & Landis
 Bisagra Dcha.     | Ian & Schmidt
(6 rows)

-- 51. Per cada proveïdor mostra el total d'import de ventes que ha facturat el director de la seva oficina dels
-- productes de la fabrica 'imm' amb qualsevol preu o dels productes qualsevol altra fàbrica si tenen un preu
-- superior a 75 i inferior a 300. Cal que surtin tots els proveïdors, tant si tenen director com si no.
select num_empl,dir,sum(importe) from repventas
    left join oficinas on director=dir
    left join pedidos on dir=rep
    left join productos on producto=id_producto and fab=id_fab
where id_fab='imm' or (id_fab!='imm' and (precio >= 75 and precio <= 300))
group by num_empl,dir;

 num_empl | dir |   sum   
----------+-----+---------
      102 | 108 | 7370.00
      104 | 106 | 1458.00
      107 | 108 | 7370.00
      108 | 106 | 1458.00
      109 | 106 | 1458.00
(5 rows)

-- 52. Mostra el nom del producte de cadascuna de les comandes, la data de comanda, l'import i el nom de la
-- ciutat de l'oficina que ha fet la venta. Ordena la sortida per ciutat i per data de comanda.
select num_pedido,descripcion,fecha_pedido,importe,ciudad from pedidos
    join productos on producto=id_producto and fab=id_fab
    join repventas on rep=num_empl
    join oficinas on oficina_rep=oficina
order by ciudad,fecha_pedido;

 num_pedido |    descripcion    | fecha_pedido | importe  |   ciudad    
------------+-------------------+--------------+----------+-------------
     112963 | Articulo Tipo 4   | 1989-12-17   |  3276.00 | Atlanta
     112983 | Articulo Tipo 4   | 1989-12-27   |   702.00 | Atlanta
     112987 | Extractor         | 1989-12-31   | 27500.00 | Atlanta
     113012 | Articulo Tipo 3   | 1990-01-11   |  3745.00 | Atlanta
     113027 | Articulo Tipo 2   | 1990-01-22   |  4104.00 | Atlanta
     112968 | Articulo Tipo 4   | 1989-10-12   |  3978.00 | Chicago
     112975 | Pasador Bisagra   | 1989-12-12   |  2100.00 | Chicago
     113042 | Bisagra Dcha.     | 1990-02-02   | 22500.00 | Chicago
     113055 | Ajustador         | 1990-02-15   |   150.00 | Chicago
     113057 | Ajustador         | 1990-02-18   |   600.00 | Chicago
     112997 | Manivela          | 1990-01-08   |   652.00 | Denver
     113062 | Bancada Motor     | 1990-02-24   |  2430.00 | Denver
     113069 | Riostra 1-Tm      | 1990-03-02   | 31350.00 | Denver
     112993 | V Stago Trinquete | 1989-01-04   |  1896.00 | Los Angeles
     112979 | Montador          | 1989-10-12   | 15000.00 | Los Angeles
     112992 | Articulo Tipo 2   | 1989-11-04   |   760.00 | Los Angeles
     113007 | Riostra 1/2-Tm    | 1990-01-08   |  2925.00 | Los Angeles
     113013 | Manivela          | 1990-01-14   |   652.00 | Los Angeles
     113024 | Reductor          | 1990-01-20   |  7100.00 | Los Angeles
     113045 | Bisagra Dcha.     | 1990-02-02   | 45000.00 | Los Angeles
     113049 | Reductor          | 1990-02-10   |   776.00 | Los Angeles
     113048 | Riostra 2-Tm      | 1990-02-10   |  3750.00 | Los Angeles
     113065 | Reductor          | 1990-02-27   |  2130.00 | Los Angeles
     112961 | Bisagra Izqda.    | 1989-12-17   | 31500.00 | New York
     112989 | Bancada Motor     | 1990-01-03   |  1458.00 | New York
     113003 | Riostra 2-Tm      | 1990-01-25   |  5625.00 | New York
     113058 | Cubierta          | 1990-02-23   |  1480.00 | New York
(27 rows)
