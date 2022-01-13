
-- DATOS POR CADA PEDIDO:
select fecha_pedido, to_char(a.fecha_pedido,'MM'),a.clie,empresa,upper(id_fab || '-' || id_producto),right(descripcion,10),round(a.importe/a.cant,2),
      (select round(avg(b.importe/b.cant),2) from pedidos b 
       where a.clie=b.clie and a.fab=b.fab and a.producto=b.producto),
      (select round(avg(c.importe/c.cant),2) from pedidos c
       where a.clie=c.clie and a.fab=c.fab and a.producto=c.producto),
       precio
from pedidos a
    join productos on id_fab=a.fab and id_producto=a.producto
    join clientes on a.clie=num_clie
order by 1;
 fecha_pedido | to_char | clie |      empresa      |   upper   |   right    |  round  |  round  |  round  | precio  
--------------+---------+------+-------------------+-----------+------------+---------+---------+---------+---------
 1989-01-04   | 01      | 2106 | Fred Lewis Corp.  | REI-2A45C |  Trinquete |   79.00 |   79.00 |   79.00 |   79.00
 1989-10-12   | 10      | 2102 | First Corp.       | ACI-41004 | ulo Tipo 4 |  117.00 |  117.00 |  117.00 |  117.00
 1989-10-12   | 10      | 2114 | Orion Corp        | ACI-4100Z | Montador   | 2500.00 | 2500.00 | 2500.00 | 2500.00
 1989-11-04   | 11      | 2118 | Midwest Systems   | ACI-41002 | ulo Tipo 2 |   76.00 |   76.00 |   76.00 |   76.00
 1989-12-12   | 12      | 2111 | JCP Inc.          | REI-2A44G | or Bisagra |  350.00 |  350.00 |  350.00 |  350.00
 1989-12-17   | 12      | 2117 | J.P. Sinclair     | REI-2A44L | gra Izqda. | 4500.00 | 4500.00 | 4500.00 | 4500.00
 1989-12-17   | 12      | 2103 | Acme Mfg.         | ACI-41004 | ulo Tipo 4 |  117.00 |  117.00 |  117.00 |  117.00
 1989-12-27   | 12      | 2103 | Acme Mfg.         | ACI-41004 | ulo Tipo 4 |  117.00 |  117.00 |  117.00 |  117.00
 1989-12-31   | 12      | 2103 | Acme Mfg.         | ACI-4100Y | Extractor  | 2500.00 | 2500.00 | 2500.00 | 2750.00
 1990-01-03   | 01      | 2101 | Jones Mfg.        | FEA-114   | cada Motor |  243.00 |  243.00 |  243.00 |  243.00
 1990-01-08   | 01      | 2112 | Zetacorp          | IMM-773C  | tra 1/2-Tm |  975.00 |  975.00 |  975.00 |  975.00
 1990-01-08   | 01      | 2124 | Peter Brothers    | BIC-41003 | Manivela   |  652.00 |  652.00 |  652.00 |  652.00
 1990-01-11   | 01      | 2111 | JCP Inc.          | ACI-41003 | ulo Tipo 3 |  107.00 |  107.00 |  107.00 |  107.00
 1990-01-14   | 01      | 2118 | Midwest Systems   | BIC-41003 | Manivela   |  652.00 |  652.00 |  652.00 |  652.00
 1990-01-20   | 01      | 2114 | Orion Corp        | QSA-XK47  | Reductor   |  355.00 |  355.00 |  355.00 |  355.00
 1990-01-22   | 01      | 2103 | Acme Mfg.         | ACI-41002 | ulo Tipo 2 |   76.00 |   76.00 |   76.00 |   76.00
 1990-01-25   | 01      | 2108 | Holm & Landis     | IMM-779C  | ostra 2-Tm | 1875.00 | 1875.00 | 1875.00 | 1875.00
 1990-01-29   | 01      | 2107 | Ace International | REI-2A45C |  Trinquete |   79.00 |   79.00 |   79.00 |   79.00
 1990-01-30   | 01      | 2107 | Ace International | ACI-4100Z | Montador   | 2500.00 | 2500.00 | 2500.00 | 2500.00
 1990-02-02   | 02      | 2113 | Ian & Schmidt     | REI-2A44R | agra Dcha. | 4500.00 | 4500.00 | 4500.00 | 4500.00
 1990-02-02   | 02      | 2112 | Zetacorp          | REI-2A44R | agra Dcha. | 4500.00 | 4500.00 | 4500.00 | 4500.00
 1990-02-10   | 02      | 2120 | Rico Enterprises  | IMM-779C  | ostra 2-Tm | 1875.00 | 1875.00 | 1875.00 | 1875.00
 1990-02-10   | 02      | 2118 | Midwest Systems   | QSA-XK47  | Reductor   |  388.00 |  388.00 |  388.00 |  355.00
 1990-02-15   | 02      | 2108 | Holm & Landis     | ACI-4100X | Ajustador  |   25.00 |   25.00 |   25.00 |   25.00
 1990-02-18   | 02      | 2111 | JCP Inc.          | ACI-4100X | Ajustador  |   25.00 |   25.00 |   25.00 |   25.00
 1990-02-23   | 02      | 2108 | Holm & Landis     | FEA-112   | Cubierta   |  148.00 |  148.00 |  148.00 |  148.00
 1990-02-24   | 02      | 2124 | Peter Brothers    | FEA-114   | cada Motor |  243.00 |  243.00 |  243.00 |  243.00
 1990-02-27   | 02      | 2106 | Fred Lewis Corp.  | QSA-XK47  | Reductor   |  355.00 |  355.00 |  355.00 |  355.00
 1990-03-02   | 03      | 2109 | Chen Associates   | IMM-775C  | ostra 1-Tm | 1425.00 | 1425.00 | 1425.00 | 1425.00
(29 rows)


-- WHERE
select fecha_pedido, to_char(a.fecha_pedido,'MM'),a.clie,empresa,upper(id_fab || '-' || id_producto),right(descripcion,10),round(a.importe/a.cant,2),
      (select round(avg(b.importe/b.cant),2) from pedidos b 
       where a.clie=b.clie and a.fab=b.fab and a.producto=b.producto),
      (select round(avg(c.importe/c.cant),2) from pedidos c
       where a.clie=c.clie and a.fab=c.fab and a.producto=c.producto),
       precio
from pedidos a
    join productos on id_fab=a.fab and id_producto=a.producto
    join clientes on a.clie=num_clie

where to_char(a.fecha_pedido,'MM') = '01' and
( select sum(p.importe) from pedidos p
  where p.clie=a.clie
  and to_char(p.fecha_pedido,'MM') = '01' )
>
( select sum(q.importe) from pedidos q
  where q.clie=a.clie
  and to_char(q.fecha_pedido,'MM') = '12')
order by 7,1;
 fecha_pedido | to_char | clie | empresa  |   upper   |   right    | round  | round  | round  | precio 
--------------+---------+------+----------+-----------+------------+--------+--------+--------+--------
 1990-01-11   | 01      | 2111 | JCP Inc. | ACI-41003 | ulo Tipo 3 | 107.00 | 107.00 | 107.00 | 107.00
(1 row)

-- FUNCION COALESCE(VALOR_CONSULTA,0) = o compara con el VALOR_CONSULTA o compara con 0, si su valor es NULL.
select fecha_pedido, to_char(a.fecha_pedido,'MM'),a.clie,empresa,upper(id_fab || '-' || id_producto),right(descripcion,10),round(a.importe/a.cant,2),
      (select round(avg(b.importe/b.cant),2) from pedidos b 
       where a.clie=b.clie and a.fab=b.fab and a.producto=b.producto),
      (select round(avg(c.importe/c.cant),2) from pedidos c
       where a.clie=c.clie and a.fab=c.fab and a.producto=c.producto),
       precio
from pedidos a
    join productos on id_fab=a.fab and id_producto=a.producto
    join clientes on a.clie=num_clie

where to_char(a.fecha_pedido,'MM') = '01' and
COALESCE((select sum(p.importe) from pedidos p
          where p.clie=a.clie
          and to_char(p.fecha_pedido,'MM') = '01'),0)
>
COALESCE((select sum(q.importe) from pedidos q
          where q.clie=a.clie
          and to_char(q.fecha_pedido,'MM') = '12'),0)
order by 7,1;
 fecha_pedido | to_char | clie |      empresa      |   upper   |   right    |  round  |  round  |  round  | precio  
--------------+---------+------+-------------------+-----------+------------+---------+---------+---------+---------
 1989-01-04   | 01      | 2106 | Fred Lewis Corp.  | REI-2A45C |  Trinquete |   79.00 |   79.00 |   79.00 |   79.00
 1990-01-29   | 01      | 2107 | Ace International | REI-2A45C |  Trinquete |   79.00 |   79.00 |   79.00 |   79.00
 1990-01-11   | 01      | 2111 | JCP Inc.          | ACI-41003 | ulo Tipo 3 |  107.00 |  107.00 |  107.00 |  107.00
 1990-01-03   | 01      | 2101 | Jones Mfg.        | FEA-114   | cada Motor |  243.00 |  243.00 |  243.00 |  243.00
 1990-01-20   | 01      | 2114 | Orion Corp        | QSA-XK47  | Reductor   |  355.00 |  355.00 |  355.00 |  355.00
 1990-01-08   | 01      | 2124 | Peter Brothers    | BIC-41003 | Manivela   |  652.00 |  652.00 |  652.00 |  652.00
 1990-01-14   | 01      | 2118 | Midwest Systems   | BIC-41003 | Manivela   |  652.00 |  652.00 |  652.00 |  652.00
 1990-01-08   | 01      | 2112 | Zetacorp          | IMM-773C  | tra 1/2-Tm |  975.00 |  975.00 |  975.00 |  975.00
 1990-01-25   | 01      | 2108 | Holm & Landis     | IMM-779C  | ostra 2-Tm | 1875.00 | 1875.00 | 1875.00 | 1875.00
 1990-01-30   | 01      | 2107 | Ace International | ACI-4100Z | Montador   | 2500.00 | 2500.00 | 2500.00 | 2500.00
(10 rows)