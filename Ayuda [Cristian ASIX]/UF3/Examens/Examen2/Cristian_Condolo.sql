-- Examen A de M02. Base de Datos
-- UF2. Subqueries
-- Cristian Condolo 1HISX 2020-21
-- 19/04/2021
--===========================================
--===========================================
-- 1. Volem veure la llista del representants de ventes assignats a clients que no han fet cap comanda, també volem veure el nom del cap 
-- de ventes d'aquest representant. Ordenar pel nom del cap de vendes.
select e.num_empl,e.nombre as empleado,( select d.nombre from repventas d where e.director=d.num_empl ) as director from repventas e
where num_empl in ( select rep_clie from clientes
                    where not exists ( select distinct clie from pedidos where num_clie=clie ))
order by 3;
 num_empl |  empleado   |  director   
----------+-------------+-------------
      105 | Bill Adams  | Bob Smith
      101 | Dan Roberts | Bob Smith
      103 | Paul Cruz   | Bob Smith
      102 | Sue Smith   | Larry Fitch
      109 | Mary Jones  | Sam Clark
(5 rows)

-- 2. Quins són els clients que no han comprat els productes de les fàbriques 'qsa' i 'bic' que tenen un preu inferior a 1000.
select num_clie,empresa from clientes
where num_clie not in ( select distinct clie from pedidos
                        where (fab,producto) in ( select id_fab,id_producto from productos
                                                  where precio < 1000 ))
order by 1;
 num_clie |     empresa      
----------+------------------
     2105 | AAA Investments
     2109 | Chen Associates
     2113 | Ian & Schmidt
     2115 | Smithson Corp.
     2117 | J.P. Sinclair
     2119 | Solomon Inc.
     2120 | Rico Enterprises
     2121 | QMA Assoc.
     2122 | Three-Way Lines
     2123 | Carter & Sons
(10 rows)

-- 3. Volem veure qui és el client que ha comprat més amb el total d'import de les seves comades i quin és el client que ha comprat menys.
-- Per aixó volem una consulta on surti les 5 columnes següents:
-- Num_clie, nom empresa, codi del seu representant, nom del representant i total d'import del client.
select num_clie,empresa,rep_clie,( select nombre from repventas where rep_clie=num_empl ),( select sum(importe) from pedidos where num_clie=clie ) as t_importe from clientes
where num_clie = ( select clie from pedidos
                   group by clie
                   having sum(importe) >= ( select sum(importe) from pedidos group by clie order by 1 desc limit 1 ))
or num_clie = ( select clie from pedidos
                group by clie
                having sum(importe) <= ( select sum(importe) from pedidos group by clie order by 1 asc limit 1 ))
order by t_importe desc;
 num_clie |  empresa   | rep_clie |   nombre    | t_importe 
----------+------------+----------+-------------+-----------
     2112 | Zetacorp   |      108 | Larry Fitch |  47925.00
     2101 | Jones Mfg. |      106 | Sam Clark   |   1458.00
(2 rows)

-- 4. Quin ès el preu mínim i el preu màxim dels productes que no s'han venut mai o s'han venut tres o més vegades?
select precio from productos
where precio = ( select max(precio) from productos
                 where not exists ( select * from pedidos
                                    where id_fab=fab and id_producto=producto )
                 or 3 <= ( select count(*) from pedidos
                           where id_fab=fab and id_producto=producto ))
or precio = ( select min(precio) from productos
              where not exists ( select * from pedidos
                                 where id_fab=fab and id_producto=producto )
              or 3 <= ( select count(*) from pedidos
                        where id_fab=fab and id_producto=producto ));
 precio 
--------
  54.00
 475.00
(2 rows)
