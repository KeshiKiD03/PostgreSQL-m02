-- muestra los datos de las fechas de pedidos:
-- to_char()
select to_char(fecha_pedido, 'yyyy') as año, to_char(fecha_pedido,'FMMM') as mes,
       count(distinct clie) as clientes,
       count(distinct (fab || producto)) as productos,
       count(*) as pedidos,
       sum(importe) as total
from pedidos
group by 1,2
order by 1,2;
 año  | mes | clientes | productos | pedidos |  total   
------+-----+----------+-----------+---------+----------
 1989 | 1   |        1 |         1 |       1 |  1896.00
 1989 | 10  |        2 |         2 |       2 | 18978.00
 1989 | 11  |        1 |         1 |       1 |   760.00
 1989 | 12  |        3 |         4 |       5 | 65078.00
 1990 | 1   |        9 |         9 |      10 | 49393.00
 1990 | 2   |        8 |         7 |      10 | 80236.00
 1990 | 3   |        1 |         1 |       1 | 31350.00
(7 rows)

-- extract()
select extract('year' from fecha_pedido) as año, extract('month' from fecha_pedido) as mes,
       count(distinct clie) as clientes,
       count(distinct (fab || producto)) as productos,
       count(*) as pedidos,
       sum(importe) as total
from pedidos
group by 1,2
order by 1,2;
 año  | mes | clientes | productos | pedidos |  total   
------+-----+----------+-----------+---------+----------
 1989 |   1 |        1 |         1 |       1 |  1896.00
 1989 |  10 |        2 |         2 |       2 | 18978.00
 1989 |  11 |        1 |         1 |       1 |   760.00
 1989 |  12 |        3 |         4 |       5 | 65078.00
 1990 |   1 |        9 |         9 |      10 | 49393.00
 1990 |   2 |        8 |         7 |      10 | 80236.00
 1990 |   3 |        1 |         1 |       1 | 31350.00
(7 rows)

-- date_part()
select date_part('year',fecha_pedido) as año,date_part('month',fecha_pedido) as mes,
       count(distinct clie) as clientes,
       count(distinct (fab || producto)) as productos,
       count(*) as pedidos,
       sum(importe) as total
from pedidos
group by 1,2
order by 1,2;
 año  | mes | clientes | productos | pedidos |  total   
------+-----+----------+-----------+---------+----------
 1989 |   1 |        1 |         1 |       1 |  1896.00
 1989 |  10 |        2 |         2 |       2 | 18978.00
 1989 |  11 |        1 |         1 |       1 |   760.00
 1989 |  12 |        3 |         4 |       5 | 65078.00
 1990 |   1 |        9 |         9 |      10 | 49393.00
 1990 |   2 |        8 |         7 |      10 | 80236.00
 1990 |   3 |        1 |         1 |       1 | 31350.00
(7 rows)
