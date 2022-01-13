-- Examen de Base de Datos  -   Cristian Fernando  Condolo Jimenez  -   25/02/2021
-- ================================================================================
-- 1.
select empresa,sum(importe) as total from clientes
    join pedidos on num_clie=clie
where not (empresa like 'I%' or empresa like 'J%') 
group by empresa
having sum(importe) > 20000;

      empresa      |   total   
-------------------+----------
 Chen Associates   | 31350.00
 Orion Corp        | 22100.00
 Ace International | 23132.00
 Acme Mfg.         | 35582.00
 Zetacorp          | 47925.00
(5 rows)

-- 2.
select num_pedido,importe,empresa,rep.nombre,rep.oficina_rep,clie.nombre as rep_clie,clie.oficina_rep as oficina_clie from pedidos
    join clientes on clie=num_clie
    join repventas rep on rep=rep.num_empl
    join repventas clie on rep_clie=clie.num_empl
where rep != rep_clie and (rep.oficina_rep is not null or clie.oficina_rep is not null)
group by num_pedido,empresa,rep.nombre,rep.oficina_rep,clie.nombre,clie.oficina_rep;

 num_pedido | importe  |     empresa     |    nombre     | oficina_rep |  rep_clie  | oficina_clie 
------------+----------+-----------------+---------------+-------------+------------+--------------
     113055 |   150.00 | Holm & Landis   | Dan Roberts   |          12 | Mary Jones |           11
     113042 | 22500.00 | Ian & Schmidt   | Dan Roberts   |          12 | Bob Smith  |           12
     113024 |  7100.00 | Orion Corp      | Larry Fitch   |          21 | Sue Smith  |           21
     113012 |  3745.00 | JCP Inc.        | Bill Adams    |          13 | Paul Cruz  |           12
     113069 | 31350.00 | Chen Associates | Nancy Angelli |          22 | Paul Cruz  |           12
(5 rows)

-- 3.
select productos.*,sum(cant) as cant,count(pedidos.*) as clientes from productos
    left join pedidos on id_fab=fab and id_producto=producto
group by id_fab,id_producto
order by precio;

 id_fab | id_producto |    descripcion    | precio  | existencias | cant | clientes 
--------+-------------+-------------------+---------+-------------+------+----------
 aci    | 4100x       | Ajustador         |   25.00 |          37 |   30 |        2
 imm    | 887h        | Soporte Riostra   |   54.00 |         223 |      |        0
 aci    | 41001       | Articulo Tipo 1   |   55.00 |         277 |      |        0
 aci    | 41002       | Articulo Tipo 2   |   76.00 |         167 |   64 |        2
 rei    | 2a45c       | V Stago Trinquete |   79.00 |         210 |   32 |        2
 aci    | 41003       | Articulo Tipo 3   |  107.00 |         207 |   35 |        1
 qsa    | xk48a       | Reductor          |  117.00 |          37 |      |        0
 aci    | 41004       | Articulo Tipo 4   |  117.00 |         139 |   68 |        3
 qsa    | xk48        | Reductor          |  134.00 |         203 |      |        0
 fea    | 112         | Cubierta          |  148.00 |         115 |   10 |        1
 bic    | 41672       | Plate             |  180.00 |           0 |      |        0
 bic    | 41089       | Retn              |  225.00 |          78 |      |        0
 fea    | 114         | Bancada Motor     |  243.00 |          15 |   16 |        2
 imm    | 887p        | Perno Riostra     |  250.00 |          24 |      |        0
 rei    | 2a44g       | Pasador Bisagra   |  350.00 |          14 |    6 |        1
 qsa    | xk47        | Reductor          |  355.00 |          38 |   28 |        3
 imm    | 887x        | Retenedor Riostra |  475.00 |          32 |      |        0
 bic    | 41003       | Manivela          |  652.00 |           3 |    2 |        2
 imm    | 773c        | Riostra 1/2-Tm    |  975.00 |          28 |    3 |        1
 imm    | 775c        | Riostra 1-Tm      | 1425.00 |           5 |   22 |        1
 imm    | 779c        | Riostra 2-Tm      | 1875.00 |           9 |    5 |        2
 aci    | 4100z       | Montador          | 2500.00 |          28 |   15 |        2
 aci    | 4100y       | Extractor         | 2750.00 |          25 |   11 |        1
 rei    | 2a44l       | Bisagra Izqda.    | 4500.00 |          12 |    7 |        1
 rei    | 2a44r       | Bisagra Dcha.     | 4500.00 |          12 |   15 |        2
(25 rows)

-- 4.

-- 5.
select region,nombre,empresa,count(pedidos.*) as pedidos,sum(cant) as total_unidades from pedidos
    join clientes on clie=num_clie
    join repventas on rep=num_empl
    join oficinas on oficina_rep=oficina
group by empresa,nombre
order by region,nombre,empresa;

 region |    nombre     |     empresa      | pedidos | total_unidades 
--------+---------------+------------------+---------+----------------
 Este   | Bill Adams    | Acme Mfg.        |       4 |             99
 Este   | Bill Adams    | JCP Inc.         |       1 |             35
 Este   | Dan Roberts   | First Corp.      |       1 |             34
 Este   | Dan Roberts   | Holm & Landis    |       1 |              6
 Este   | Dan Roberts   | Ian & Schmidt    |       1 |              5
 Este   | Mary Jones    | Holm & Landis    |       2 |             13
 Este   | Paul Cruz     | JCP Inc.         |       2 |             30
 Este   | Sam Clark     | Jones Mfg.       |       1 |              6
 Este   | Sam Clark     | J.P. Sinclair    |       1 |              7
 Oeste  | Larry Fitch   | Midwest Systems  |       4 |             17
 Oeste  | Larry Fitch   | Orion Corp       |       1 |             20
 Oeste  | Larry Fitch   | Zetacorp         |       2 |             13
 Oeste  | Nancy Angelli | Chen Associates  |       1 |             22
 Oeste  | Nancy Angelli | Peter Brothers   |       2 |             11
 Oeste  | Sue Smith     | Fred Lewis Corp. |       2 |             30
 Oeste  | Sue Smith     | Orion Corp       |       1 |              6
 Oeste  | Sue Smith     | Rico Enterprises |       1 |              2
(17 rows)

-- 6.
select region,ciudad,count(distinct num_empl) as empleados,count(num_pedido) as pedidos from oficinas
    join repventas on oficina=oficina_rep
    join pedidos on num_empl=rep
group by region,ciudad
order by region,ciudad;

 region |   ciudad    | empleados | pedidos 
--------+-------------+-----------+---------
 Este   | Atlanta     |         1 |       5
 Este   | Chicago     |         2 |       5
 Este   | New York    |         2 |       4
 Oeste  | Denver      |         1 |       3
 Oeste  | Los Angeles |         2 |      11
(5 rows)

-- 7.

-- 8.
select empresa,id_fab,id_producto,precio,rep.nombre as rep_clie,dir.nombre as dir_rep from clientes
    right join pedidos on num_clie=clie
    join productos on producto=id_producto and fab=id_fab
    join repventas rep on rep=rep.num_empl
    join repventas dir on rep.director=dir.num_empl
where (id_fab='imm' or id_fab='rei') and (precio < 1500 or precio > 2000)
group by empresa,id_fab,id_producto,rep.nombre,dir.nombre;

      empresa      | id_fab | id_producto | precio  |   rep_clie    |   dir_rep   
-------------------+--------+-------------+---------+---------------+-------------
 Ace International | rei    | 2a45c       |   79.00 | Tom Snyder    | Dan Roberts
 Chen Associates   | imm    | 775c        | 1425.00 | Nancy Angelli | Larry Fitch
 Fred Lewis Corp.  | rei    | 2a45c       |   79.00 | Sue Smith     | Larry Fitch
 Ian & Schmidt     | rei    | 2a44r       | 4500.00 | Dan Roberts   | Bob Smith
 JCP Inc.          | rei    | 2a44g       |  350.00 | Paul Cruz     | Bob Smith
 Zetacorp          | imm    | 773c        |  975.00 | Larry Fitch   | Sam Clark
 Zetacorp          | rei    | 2a44r       | 4500.00 | Larry Fitch   | Sam Clark
(7 rows)

-- 9.
select num_pedido,region,nombre,importe,empresa from pedidos
    left join repventas on rep=num_empl
    left join oficinas on oficina_rep=oficina
    left join clientes on clie=num_clie
order by 1,2;

 num_pedido | region |    nombre     | importe  |      empresa      
------------+--------+---------------+----------+-------------------
     110036 |        | Tom Snyder    | 22500.00 | Ace International
     112961 | Este   | Sam Clark     | 31500.00 | J.P. Sinclair
     112963 | Este   | Bill Adams    |  3276.00 | Acme Mfg.
     112968 | Este   | Dan Roberts   |  3978.00 | First Corp.
     112975 | Este   | Paul Cruz     |  2100.00 | JCP Inc.
     112979 | Oeste  | Sue Smith     | 15000.00 | Orion Corp
     112983 | Este   | Bill Adams    |   702.00 | Acme Mfg.
     112987 | Este   | Bill Adams    | 27500.00 | Acme Mfg.
     112989 | Este   | Sam Clark     |  1458.00 | Jones Mfg.
     112992 | Oeste  | Larry Fitch   |   760.00 | Midwest Systems
     112993 | Oeste  | Sue Smith     |  1896.00 | Fred Lewis Corp.
     112997 | Oeste  | Nancy Angelli |   652.00 | Peter Brothers
     113003 | Este   | Mary Jones    |  5625.00 | Holm & Landis
     113007 | Oeste  | Larry Fitch   |  2925.00 | Zetacorp
     113012 | Este   | Bill Adams    |  3745.00 | JCP Inc.
     113013 | Oeste  | Larry Fitch   |   652.00 | Midwest Systems
     113024 | Oeste  | Larry Fitch   |  7100.00 | Orion Corp
     113027 | Este   | Bill Adams    |  4104.00 | Acme Mfg.
     113034 |        | Tom Snyder    |   632.00 | Ace International
     113042 | Este   | Dan Roberts   | 22500.00 | Ian & Schmidt
     113045 | Oeste  | Larry Fitch   | 45000.00 | Zetacorp
     113048 | Oeste  | Sue Smith     |  3750.00 | Rico Enterprises
     113049 | Oeste  | Larry Fitch   |   776.00 | Midwest Systems
     113051 | Oeste  | Larry Fitch   |  1420.00 | Midwest Systems
     113055 | Este   | Dan Roberts   |   150.00 | Holm & Landis
     113057 | Este   | Paul Cruz     |   600.00 | JCP Inc.
     113058 | Este   | Mary Jones    |  1480.00 | Holm & Landis
     113062 | Oeste  | Nancy Angelli |  2430.00 | Peter Brothers
     113065 | Oeste  | Sue Smith     |  2130.00 | Fred Lewis Corp.
     113069 | Oeste  | Nancy Angelli | 31350.00 | Chen Associates
(30 rows)
