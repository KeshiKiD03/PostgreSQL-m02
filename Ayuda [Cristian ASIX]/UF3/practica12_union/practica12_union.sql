-- 1. Mostar les ventes individuals dels productes dels fabricants 'aci' i 'rei' que comencin per 'Bisagra'
-- o 'Articulo'. Mostrar també el total venut d'aquests productes.
select id_fab,id_producto,descripcion,'Precio:',precio from pedidos
    join productos on producto=id_producto and fab=id_fab
where (fab='aci' or fab='rei') and (descripcion like 'Bisagra%' or descripcion like 'Articulo%')

union

select id_fab,id_producto,descripcion,'Total:',sum(importe) from pedidos
    join productos on producto=id_producto and fab=id_fab
where (fab='aci' or fab='rei') and (descripcion like 'Bisagra%' or descripcion like 'Articulo%')

group by id_fab,id_producto
order by id_fab,id_producto;

 id_fab | id_producto |   descripcion   | ?column? |  precio  
--------+-------------+-----------------+----------+----------
 aci    | 41002       | Articulo Tipo 2 | Precio:  |    76.00
 aci    | 41002       | Articulo Tipo 2 | Total:   |  4864.00
 aci    | 41003       | Articulo Tipo 3 | Precio:  |   107.00
 aci    | 41003       | Articulo Tipo 3 | Total:   |  3745.00
 aci    | 41004       | Articulo Tipo 4 | Precio:  |   117.00
 aci    | 41004       | Articulo Tipo 4 | Total:   |  7956.00
 rei    | 2a44l       | Bisagra Izqda.  | Precio:  |  4500.00
 rei    | 2a44l       | Bisagra Izqda.  | Total:   | 31500.00
 rei    | 2a44r       | Bisagra Dcha.   | Precio:  |  4500.00
 rei    | 2a44r       | Bisagra Dcha.   | Total:   | 67500.00
(10 rows)

-- 2. Mostrar les ventes individuals fetes pels venedors de New York i de Chicago que superin els
-- 2500€. Mostrar també el total de ventes de cada oficina.
select ciudad,'Venta individual:',importe
from oficinas
    join repventas on oficina=oficina_rep
    join pedidos on rep=num_empl
where (ciudad='New York' or ciudad='Chicago') and importe > 2500

union

select ciudad,'Total oficina:',sum(importe)
from oficinas
    join repventas on oficina=oficina_rep
    join pedidos on rep=num_empl
where (ciudad='New York' or ciudad='Chicago') and importe > 2500

group by oficina
order by 1,2 desc;

  ciudad  |     ?column?      | importe  
----------+-------------------+----------
 Chicago  | Venta individual: |  3978.00
 Chicago  | Venta individual: | 22500.00
 Chicago  | Total oficina:    | 26478.00
 New York | Venta individual: |  5625.00
 New York | Venta individual: | 31500.00
 New York | Total oficina:    | 37125.00
(6 rows)

-- 3. Mostrar quantes ventes ha fet cada venedor, la mitjana de numero de ventes dels venedors de cada
-- oficina i el numero de ventes total.
select 'Vendedor:',oficina_rep,rep,count(*)
from pedidos
    join repventas on rep=num_empl
group by rep,oficina_rep

union

select 'Oficina:',oficina_rep,null,(count(*) / count(distinct(rep))) from pedidos
    join repventas on rep=num_empl
group by oficina_rep

union

select 'Total:',null,null,count(*) from pedidos

order by 2,3;

 ?column?  | oficina_rep | rep | count 
-----------+-------------+-----+-------
 Vendedor: |          11 | 106 |     2
 Vendedor: |          11 | 109 |     2
 Oficina:  |          11 |     |     2
 Vendedor: |          12 | 101 |     3
 Vendedor: |          12 | 103 |     2
 Oficina:  |          12 |     |     2
 Vendedor: |          13 | 105 |     5
 Oficina:  |          13 |     |     5
 Vendedor: |          21 | 102 |     4
 Vendedor: |          21 | 108 |     7
 Oficina:  |          21 |     |     5
 Vendedor: |          22 | 107 |     3
 Oficina:  |          22 |     |     3
 Vendedor: |             | 110 |     2
 Oficina:  |             |     |     2
 Total:    |             |     |    30
(16 rows)

-- 4. Mostrar les compres de productes de la fabrica 'aci' que han fet els clients del Bill Adams i el Dan
-- Roberts. Mostrar també l'import total per cada client.
select 'Producto:',producto,clie,null as importe from pedidos
    join repventas on rep=num_empl
where (nombre='Bill Adams' or nombre='Dan Roberts') and fab='aci'

union

select 'Cliente:',null,clie,sum(importe) from pedidos
    join repventas on rep=num_empl
where (nombre='Bill Adams' or nombre='Dan Roberts') and fab='aci'
group by clie
order by clie,1 desc;

 ?column?  | producto | clie | importe  
-----------+----------+------+----------
 Producto: | 41004    | 2102 |         
 Cliente:  |          | 2102 |  3978.00
 Producto: | 4100y    | 2103 |         
 Producto: | 41002    | 2103 |         
 Producto: | 41004    | 2103 |         
 Cliente:  |          | 2103 | 35582.00
 Producto: | 4100x    | 2108 |         
 Cliente:  |          | 2108 |   150.00
 Producto: | 41003    | 2111 |         
 Cliente:  |          | 2111 |  3745.00
(10 rows)

-- 5. Mostrar el total de ventes de cada oficina i el total de ventes de cada regió
select 'Oficina:',oficina,region,sum(repventas.ventas) as ventas from oficinas
    join repventas on oficina=oficina_rep
group by oficina

union

select 'Region:',null,region,sum(repventas.ventas) as ventas from oficinas
    join repventas on oficina=oficina_rep
group by region

order by region;

 ?column? | oficina | region |   ventas   
----------+---------+--------+------------
 Oficina: |      12 | Este   |  735042.00
 Oficina: |      13 | Este   |  367911.00
 Region:  |         | Este   | 1795590.00
 Oficina: |      11 | Este   |  692637.00
 Oficina: |      21 | Oeste  |  835915.00
 Oficina: |      22 | Oeste  |  186042.00
 Region:  |         | Oeste  | 1021957.00
(7 rows)

-- 6. Mostrar els noms dels venedors de cada ciutat i el numero total de venedors per ciutat
select 'Vendedor:',nombre,ciudad,null from oficinas
    join repventas on oficina=oficina_rep
group by ciudad,nombre

union

select 'Oficina:',null,ciudad,count(repventas.*) from oficinas
    join repventas on oficina=oficina_rep
group by oficina

order by ciudad,nombre;

 ?column?  |    nombre     |   ciudad    | ?column? 
-----------+---------------+-------------+----------
 Vendedor: | Bill Adams    | Atlanta     |         
 Oficina:  |               | Atlanta     |        1
 Vendedor: | Bob Smith     | Chicago     |         
 Vendedor: | Dan Roberts   | Chicago     |         
 Vendedor: | Paul Cruz     | Chicago     |         
 Oficina:  |               | Chicago     |        3
 Vendedor: | Nancy Angelli | Denver      |         
 Oficina:  |               | Denver      |        1
 Vendedor: | Larry Fitch   | Los Angeles |         
 Vendedor: | Sue Smith     | Los Angeles |         
 Oficina:  |               | Los Angeles |        2
 Vendedor: | Mary Jones    | New York    |         
 Vendedor: | Sam Clark     | New York    |         
 Oficina:  |               | New York    |        2
(14 rows)

-- 7. Mostrat els noms dels clients de cada ciutat i el numero total de clients per ciutat.
select 'Clientes:',empresa,ciudad,null from clientes
    join repventas on num_empl=rep_clie
    join oficinas on oficina_rep=oficina
group by oficina,empresa

union

select 'Total:',null,ciudad,count(clientes.*) from oficinas
    join repventas on oficina=oficina_rep
    join clientes on num_empl=rep_clie
group by oficina

order by ciudad,empresa;

 ?column?  |     empresa      |   ciudad    | ?column? 
-----------+------------------+-------------+----------
 Clientes: | Acme Mfg.        | Atlanta     |         
 Clientes: | Three-Way Lines  | Atlanta     |         
 Total:    |                  | Atlanta     |        2
 Clientes: | AAA Investments  | Chicago     |         
 Clientes: | Chen Associates  | Chicago     |         
 Clientes: | First Corp.      | Chicago     |         
 Clientes: | Ian & Schmidt    | Chicago     |         
 Clientes: | JCP Inc.         | Chicago     |         
 Clientes: | QMA Assoc.       | Chicago     |         
 Clientes: | Smithson Corp.   | Chicago     |         
 Total:    |                  | Chicago     |        7
 Clientes: | Peter Brothers   | Denver      |         
 Total:    |                  | Denver      |        1
 Clientes: | Carter & Sons    | Los Angeles |         
 Clientes: | Fred Lewis Corp. | Los Angeles |         
 Clientes: | Midwest Systems  | Los Angeles |         
 Clientes: | Orion Corp       | Los Angeles |         
 Clientes: | Rico Enterprises | Los Angeles |         
 Clientes: | Zetacorp         | Los Angeles |         
 Total:    |                  | Los Angeles |        6
 Clientes: | Holm & Landis    | New York    |         
 Clientes: | Jones Mfg.       | New York    |         
 Clientes: | J.P. Sinclair    | New York    |         
 Clientes: | Solomon Inc.     | New York    |         
 Total:    |                  | New York    |        4
(25 rows)

-- 8. Mostrat els noms dels treballadors que son -caps- d'algú, els noms dels seus -
-- subordinats- i el numero de treballadors que té assignat cada cap.

-- 9. Llistar els productes amb existències no superiors a 200 i no inferiors a 20 de la fàbrica aci 
-- o de la fabrica imm, i els nom dels clients que han comprat aquests productes. Si algun producte 
-- no l'ha comprat ningú ha de sortir sense nom de client.
select ' Cliente :',null,empresa,id_fab,id_producto from productos
    left join pedidos on id_producto=producto and id_fab=fab
    left join clientes on clie=num_clie
where existencias <= 200 and existencias >= 20 and (id_fab='aci' or id_fab='imm')

union

select 'Producto :',descripcion,null,id_fab,id_producto from productos
    left join pedidos on id_producto=producto and id_fab=fab
    left join clientes on clie=num_clie
where existencias <= 200 and existencias >= 20 and (id_fab='aci' or id_fab='imm')
order by 4,5,1 desc;

  ?column?  |     ?column?      |      empresa      | id_fab | id_producto 
------------+-------------------+-------------------+--------+-------------
 Producto : | Articulo Tipo 2   |                   | aci    | 41002
  Cliente : |                   | Acme Mfg.         | aci    | 41002
  Cliente : |                   | Midwest Systems   | aci    | 41002
 Producto : | Articulo Tipo 4   |                   | aci    | 41004
  Cliente : |                   | Acme Mfg.         | aci    | 41004
  Cliente : |                   | First Corp.       | aci    | 41004
 Producto : | Ajustador         |                   | aci    | 4100x
  Cliente : |                   | JCP Inc.          | aci    | 4100x
  Cliente : |                   | Holm & Landis     | aci    | 4100x
 Producto : | Extractor         |                   | aci    | 4100y
  Cliente : |                   | Acme Mfg.         | aci    | 4100y
 Producto : | Montador          |                   | aci    | 4100z
  Cliente : |                   | Ace International | aci    | 4100z
  Cliente : |                   | Orion Corp        | aci    | 4100z
 Producto : | Riostra 1/2-Tm    |                   | imm    | 773c 
  Cliente : |                   | Zetacorp          | imm    | 773c 
 Producto : | Perno Riostra     |                   | imm    | 887p 
  Cliente : |                   |                   | imm    | 887p 
 Producto : | Retenedor Riostra |                   | imm    | 887x 
  Cliente : |                   |                   | imm    | 887x 
(20 rows)

-- 10. Llistar la ciutat de cada oficina, el número total de treballadors, el nom del cap de l'oficina
-- i el nom de cadascun dels treballadors (incloent al cap com a treballador).
select 'Director  :',oficina,ciudad,count(rep.*),dir.nombre from oficinas
    join repventas rep on oficina=oficina_rep
    join repventas dir on dir=dir.num_empl
group by ciudad,dir.nombre,oficina

union

select ' Empleado :',oficina,null,null,rep.nombre from oficinas
    join repventas rep on oficina=oficina_rep
    join repventas dir on dir=dir.num_empl
group by ciudad,rep.nombre,oficina
order by oficina,1;

  ?column?   | oficina |   ciudad    | count |    nombre     
-------------+---------+-------------+-------+---------------
 Director  : |      11 | New York    |     2 | Sam Clark
  Empleado : |      11 |             |       | Mary Jones
  Empleado : |      11 |             |       | Sam Clark
 Director  : |      12 | Chicago     |     3 | Bob Smith
  Empleado : |      12 |             |       | Paul Cruz
  Empleado : |      12 |             |       | Bob Smith
  Empleado : |      12 |             |       | Dan Roberts
 Director  : |      13 | Atlanta     |     1 | Bill Adams
  Empleado : |      13 |             |       | Bill Adams
 Director  : |      21 | Los Angeles |     2 | Larry Fitch
  Empleado : |      21 |             |       | Sue Smith
  Empleado : |      21 |             |       | Larry Fitch
 Director  : |      22 | Denver      |     1 | Larry Fitch
  Empleado : |      22 |             |       | Nancy Angelli
(14 rows)

-- 11. Llistar els noms i preus dels productes de la fàbrica imm i de la fàbrica rei que contenen 'gr'
-- o 'tr' en el seu nom i que valen entre 900 i 5000€, i els noms dels venedors que han venut aquests
-- productes. Si algun producte no l'ha comprat ningú ha de sortir sense nom venedor.
select 'Productos :',descripcion,precio,null from productos
    left join pedidos on id_producto=producto and id_fab=fab
    left join repventas on rep=num_empl
where (fab='imm' or fab='rei') and (descripcion like '%gr%' or descripcion like '%tr%')
and precio between 900 and 5000

union

select 'Vendedor :',descripcion,null,nombre from productos
    left join pedidos on id_producto=producto and id_fab=fab
    left join repventas on rep=num_empl
where (fab='imm' or fab='rei') and (descripcion like '%gr%' or descripcion like '%tr%')
and precio between 900 and 5000

order by descripcion,1;

  ?column?   |  descripcion   | precio  |   ?column?    
-------------+----------------+---------+---------------
 Productos : | Bisagra Dcha.  | 4500.00 | 
 Vendedor :  | Bisagra Dcha.  |         | Larry Fitch
 Vendedor :  | Bisagra Dcha.  |         | Dan Roberts
 Productos : | Bisagra Izqda. | 4500.00 | 
 Vendedor :  | Bisagra Izqda. |         | Sam Clark
 Productos : | Riostra 1/2-Tm |  975.00 | 
 Vendedor :  | Riostra 1/2-Tm |         | Larry Fitch
 Productos : | Riostra 1-Tm   | 1425.00 | 
 Vendedor :  | Riostra 1-Tm   |         | Nancy Angelli
 Productos : | Riostra 2-Tm   | 1875.00 | 
 Vendedor :  | Riostra 2-Tm   |         | Sue Smith
 Vendedor :  | Riostra 2-Tm   |         | Mary Jones
(12 rows)

-- 12. Llistar els noms dels productes, el número total de ventes que s'ha fet d'aquell producte, la
-- quantitat total d'unitats que s'han venut d'aquell producte, i el nom de cada client que l'ha comprat.
select 'Producto:',descripcion,count(pedidos.clie),sum(cant),null from productos
    join pedidos on id_producto=producto and id_fab=fab
    join clientes on clie=num_clie
group by descripcion

union

select 'Cliente:',descripcion,null,null,empresa from productos
    join pedidos on id_producto=producto and id_fab=fab
    join clientes on clie=num_clie
group by descripcion,empresa

order by 2,1 desc;

 ?column?  |    descripcion    | count | sum |     ?column?      
-----------+-------------------+-------+-----+-------------------
 Producto: | Ajustador         |     2 |  30 | 
 Cliente:  | Ajustador         |       |     | Holm & Landis
 Cliente:  | Ajustador         |       |     | JCP Inc.
 Producto: | Articulo Tipo 2   |     2 |  64 | 
 Cliente:  | Articulo Tipo 2   |       |     | Acme Mfg.
 Cliente:  | Articulo Tipo 2   |       |     | Midwest Systems
 Producto: | Articulo Tipo 3   |     1 |  35 | 
 Cliente:  | Articulo Tipo 3   |       |     | JCP Inc.
 Producto: | Articulo Tipo 4   |     3 |  68 | 
 Cliente:  | Articulo Tipo 4   |       |     | First Corp.
 Cliente:  | Articulo Tipo 4   |       |     | Acme Mfg.
 Producto: | Bancada Motor     |     2 |  16 | 
 Cliente:  | Bancada Motor     |       |     | Peter Brothers
 Cliente:  | Bancada Motor     |       |     | Jones Mfg.
 Producto: | Bisagra Dcha.     |     2 |  15 | 
 Cliente:  | Bisagra Dcha.     |       |     | Ian & Schmidt
 Cliente:  | Bisagra Dcha.     |       |     | Zetacorp
 Producto: | Bisagra Izqda.    |     1 |   7 | 
 Cliente:  | Bisagra Izqda.    |       |     | J.P. Sinclair
 Producto: | Cubierta          |     1 |  10 | 
 Cliente:  | Cubierta          |       |     | Holm & Landis
 Producto: | Extractor         |     1 |  11 | 
 Cliente:  | Extractor         |       |     | Acme Mfg.
 Producto: | Manivela          |     2 |   2 | 
 Cliente:  | Manivela          |       |     | Peter Brothers
 Cliente:  | Manivela          |       |     | Midwest Systems
 Producto: | Montador          |     2 |  15 | 
 Cliente:  | Montador          |       |     | Ace International
 Cliente:  | Montador          |       |     | Orion Corp
 Producto: | Pasador Bisagra   |     1 |   6 | 
 Cliente:  | Pasador Bisagra   |       |     | JCP Inc.
 Producto: | Reductor          |     3 |  28 | 
 Cliente:  | Reductor          |       |     | Fred Lewis Corp.
 Cliente:  | Reductor          |       |     | Midwest Systems
 Cliente:  | Reductor          |       |     | Orion Corp
 Producto: | Riostra 1/2-Tm    |     1 |   3 | 
 Cliente:  | Riostra 1/2-Tm    |       |     | Zetacorp
 Producto: | Riostra 1-Tm      |     1 |  22 | 
 Cliente:  | Riostra 1-Tm      |       |     | Chen Associates
 Producto: | Riostra 2-Tm      |     2 |   5 | 
 Cliente:  | Riostra 2-Tm      |       |     | Rico Enterprises
 Cliente:  | Riostra 2-Tm      |       |     | Holm & Landis
 Producto: | V Stago Trinquete |     2 |  32 | 
 Cliente:  | V Stago Trinquete |       |     | Ace International
 Cliente:  | V Stago Trinquete |       |     | Fred Lewis Corp.
(45 rows)

-- 13. Llistar els poductes que costen més de 1000 o no són ni de la fàbrica imm ni de la fàbrica rei, ni
-- de la fàbrica ací, i el total que n'ha comprat cada client. Si algun producte no l'ha comprat ningú
-- ha de sortir sense nom de client.

-- 14. Llistar els codis de fabricants, el número total de productes d'aquell fabricant i el nom de
-- cadascun dels productes.
select 'Fabricant :',id_fab,count(*),null from productos
group by id_fab

union

select 'Producto :',id_fab,null,descripcion from productos
group by id_fab,descripcion

order by id_fab,1;

  ?column?   | id_fab | count |     ?column?      
-------------+--------+-------+-------------------
 Fabricant : | aci    |     7 | 
 Producto :  | aci    |       | Ajustador
 Producto :  | aci    |       | Extractor
 Producto :  | aci    |       | Articulo Tipo 1
 Producto :  | aci    |       | Articulo Tipo 3
 Producto :  | aci    |       | Articulo Tipo 2
 Producto :  | aci    |       | Articulo Tipo 4
 Producto :  | aci    |       | Montador
 Fabricant : | bic    |     3 | 
 Producto :  | bic    |       | Plate
 Producto :  | bic    |       | Manivela
 Producto :  | bic    |       | Retn
 Fabricant : | fea    |     2 | 
 Producto :  | fea    |       | Cubierta
 Producto :  | fea    |       | Bancada Motor
 Fabricant : | imm    |     6 | 
 Producto :  | imm    |       | Riostra 2-Tm
 Producto :  | imm    |       | Soporte Riostra
 Producto :  | imm    |       | Riostra 1-Tm
 Producto :  | imm    |       | Perno Riostra
 Producto :  | imm    |       | Riostra 1/2-Tm
 Producto :  | imm    |       | Retenedor Riostra
 Fabricant : | qsa    |     3 | 
 Producto :  | qsa    |       | Reductor
 Fabricant : | rei    |     4 | 
 Producto :  | rei    |       | Pasador Bisagra
 Producto :  | rei    |       | V Stago Trinquete
 Producto :  | rei    |       | Bisagra Dcha.
 Producto :  | rei    |       | Bisagra Izqda.
(29 rows)

-- 15. Llistar els venedors i els seus imports totals de ventes, que tinguin més de 30 anys i treballin a
-- l'oficina 12 i els que tinguin més de 20 anys i treballin a l'oficina 21. Llistar els clients a qui ha
-- venut cadascun d'aquests venedors
select 'Representante :',num_empl,ventas,null from repventas
    join clientes on num_empl=rep_clie
where (edad > 30 and oficina_rep=12) or (edad > 20 and oficina_rep=21)

union

select 'Cliente :',num_empl,null,empresa from repventas
    join clientes on num_empl=rep_clie
where (edad > 30 and oficina_rep=12) or (edad > 20 and oficina_rep=21)

order by num_empl,1 desc;

    ?column?     | num_empl |  ventas   |     ?column?     
-----------------+----------+-----------+------------------
 Representante : |      101 | 305673.00 | 
 Cliente :       |      101 |           | First Corp.
 Cliente :       |      101 |           | AAA Investments
 Cliente :       |      101 |           | Smithson Corp.
 Representante : |      102 | 474050.00 | 
 Cliente :       |      102 |           | Fred Lewis Corp.
 Cliente :       |      102 |           | Rico Enterprises
 Cliente :       |      102 |           | Carter & Sons
 Cliente :       |      102 |           | Orion Corp
 Representante : |      104 | 142594.00 | 
 Cliente :       |      104 |           | Ian & Schmidt
 Representante : |      108 | 361865.00 | 
 Cliente :       |      108 |           | Zetacorp
 Cliente :       |      108 |           | Midwest Systems
(14 rows)
