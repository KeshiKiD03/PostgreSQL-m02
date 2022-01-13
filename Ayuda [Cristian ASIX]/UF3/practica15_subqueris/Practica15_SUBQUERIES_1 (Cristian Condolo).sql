-- 5.1- Llista els venedors que tinguin una quota igual o inferior al objectiu de la oficina de vendes d'Atlanta.
select num_empl from repventas
where cuota <= ( select objetivo from oficinas
                where ciudad = 'Atlanta' );
 num_empl 
----------
      105
      109
      102
      106
      104
      101
      108
      103
      107
(9 rows)

-- 5.2- Tots els clients, identificador i nom de l'empresa, que han estat atesos per (que han fet comanda amb) Bill Adams.
select num_clie,empresa from clientes
where num_clie in ( select clie from pedidos
                    where rep = ( select num_empl from repventas
                                  where nombre = 'Bill Adams' ));
 num_clie |  empresa  
----------+-----------
     2111 | JCP Inc.
     2103 | Acme Mfg.
(2 rows)

-- 5.3- Venedors amb quotes que siguin iguals o superiors a l'objectiu de llur oficina de vendes.
select nombre from repventas 
where cuota >= ( select objetivo from oficinas 
                 where oficina = oficina_rep );
    nombre     
---------------
 Bill Adams
 Nancy Angelli
(2 rows)

-- 5.4- Mostrar l'identificador de l'oficina i la ciutat de les oficines on l'objectiu de vendes de l'oficina excedeix la suma 
-- de quotes dels venedors d'aquella oficina.
select oficina,ciudad from oficinas
where objetivo > ( select sum(cuota) from repventas
                   where oficina_rep=oficina );
 oficina |   ciudad    
---------+-------------
      12 | Chicago
      21 | Los Angeles
(2 rows)

select oficina,ciudad,objetivo,num_empl,cuota from oficinas
      join repventas on oficina=oficina_rep
order by 1,3;
 oficina |   ciudad    | objetivo  | num_empl |   cuota   
---------+-------------+-----------+----------+-----------
      11 | New York    | 575000.00 |      109 | 300000.00
      11 | New York    | 575000.00 |      106 | 275000.00
      12 | Chicago     | 800000.00 |      101 | 300000.00
      12 | Chicago     | 800000.00 |      103 | 275000.00
      12 | Chicago     | 800000.00 |      104 | 200000.00
      13 | Atlanta     | 350000.00 |      105 | 350000.00
      21 | Los Angeles | 725000.00 |      108 | 350000.00
      21 | Los Angeles | 725000.00 |      102 | 350000.00
      22 | Denver      | 300000.00 |      107 | 300000.00
(9 rows)

select oficina,ciudad,objetivo from oficinas
      join repventas on oficina=oficina_rep
group by 1
having sum(cuota) < objetivo
order by 1,3;
 oficina |   ciudad    | objetivo  
---------+-------------+-----------
      12 | Chicago     | 800000.00
      21 | Los Angeles | 725000.00
(2 rows)

-- 5.5- Llista dels productes del fabricant amb identificador "aci" que les existències superen les existències del producte
-- amb identificador de producte "41004" i identificador de fabricant "aci".
select * from productos 
where id_fab='aci' and existencias > ( select existencias from productos
                                       where id_producto='41004' and id_fab='aci' );
 id_fab | id_producto |   descripcion   | precio | existencias 
--------+-------------+-----------------+--------+-------------
 aci    | 41003       | Articulo Tipo 3 | 107.00 |         207
 aci    | 41001       | Articulo Tipo 1 |  55.00 |         277
 aci    | 41002       | Articulo Tipo 2 |  76.00 |         167
(3 rows)

-- 5.6- Llistar els venedors que han acceptat una comanda que representa més del 10% de la seva quota.
select * from repventas
where num_empl in ( select rep from pedidos
                    where num_empl=rep 
                    and importe > cuota );
 num_empl |    nombre     | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   
----------+---------------+------+-------------+------------+------------+----------+-----------+-----------
      106 | Sam Clark     |   52 |          11 | VP Ventas  | 1988-06-14 |          | 275000.00 | 299912.00
      108 | Larry Fitch   |   62 |          21 | Dir Ventas | 1989-10-12 |      106 | 350000.00 | 361865.00
      107 | Nancy Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00
(3 rows)

select * from repventas
where cuota * 0.1 < any ( select importe from pedidos
                          where num_empl=rep );
 num_empl |    nombre     | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   
----------+---------------+------+-------------+------------+------------+----------+-----------+-----------
      106 | Sam Clark     |   52 |          11 | VP Ventas  | 1988-06-14 |          | 275000.00 | 299912.00
      108 | Larry Fitch   |   62 |          21 | Dir Ventas | 1989-10-12 |      106 | 350000.00 | 361865.00
      107 | Nancy Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00
(3 rows)

-- 5.7- Llistar el nom i l'edat de totes les persones de l'equip de vendes que no dirigeixen una oficina.
select nombre,edad from repventas
where num_empl not in ( select dir from oficinas );
    nombre     | edad 
---------------+------
 Mary Jones    |   31
 Sue Smith     |   48
 Dan Roberts   |   45
 Tom Snyder    |   41
 Paul Cruz     |   29
 Nancy Angelli |   49
(6 rows)

-- 5.8- Llistar aquelles oficines, i els seus objectius, que tots els seus venedors tinguin unes vendes que superen el 50%
-- de l'objectiu de l'oficina.
select oficina,objetivo from oficinas
where objetivo * 0.5 < all ( select ventas from repventas
                             where oficina_rep=oficina );
 oficina | objetivo  
---------+-----------
      22 | 300000.00
      11 | 575000.00
      13 | 350000.00
(3 rows)

-- 5.9- Llistar aquells clients que els seus representants de vendes estàn assignats a oficines de la regió est.
select empresa from clientes
where rep_clie in ( select num_empl from repventas
                    where oficina_rep in ( select oficina from oficinas
                                           where region='Este' ));
     empresa     
-----------------
 JCP Inc.
 First Corp.
 Acme Mfg.
 Smithson Corp.
 Jones Mfg.
 QMA Assoc.
 Holm & Landis
 J.P. Sinclair
 Three-Way Lines
 Solomon Inc.
 Ian & Schmidt
 Chen Associates
 AAA Investments
(13 rows)

select empresa from clientes
where rep_clie in ( select num_empl from repventas
                        join oficinas on oficina_rep=oficina
                    where region='Este'select empresa from clientes );
     empresa     
-----------------
 JCP Inc.
 First Corp.
 Acme Mfg.
 Smithson Corp.
 Jones Mfg.
 QMA Assoc.
 Holm & Landis
 J.P. Sinclair
 Three-Way Lines
 Solomon Inc.
 Ian & Schmidt
 Chen Associates
 AAA Investments
(13 rows)

-- 5.10- Llistar els venedors que treballen en oficines que superen el seu objectiu.
select nombre from repventas
where oficina_rep in ( select oficina from oficinas
                       where ventas > objetivo );
   nombre    
-------------
 Bill Adams
 Mary Jones
 Sue Smith
 Sam Clark
 Larry Fitch
(5 rows)

-- 5.11- Llistar els venedors que treballen en oficines que superen el seu objectiu. Mostrar també les següents dades de
-- l'oficina: ciutat i la diferència entre les vendes i l'objectiu. Ordenar el resultat per aquest últim valor. Proposa dos
-- sentències SQL, una amb subconsultes i una sense.
select num_empl,nombre,ciudad,oficinas.ventas - objetivo as dif from repventas
      join oficinas on oficina_rep=oficina 
where oficinas.ventas > objetivo
order by dif;
 num_empl |   nombre    |   ciudad    |    dif    
----------+-------------+-------------+-----------
      105 | Bill Adams  | Atlanta     |  17911.00
      102 | Sue Smith   | Los Angeles | 110915.00
      108 | Larry Fitch | Los Angeles | 110915.00
      109 | Mary Jones  | New York    | 117637.00
      106 | Sam Clark   | New York    | 117637.00
(5 rows)

select num_empl,nombre,ciudad,oficinas.ventas - objetivo as dif from repventas
      join oficinas on oficina_rep=oficina 
where oficina_rep in ( select oficina from oficinas
                       where ventas > objetivo )
order by dif;
 num_empl |   nombre    |   ciudad    |    dif    
----------+-------------+-------------+-----------
      105 | Bill Adams  | Atlanta     |  17911.00
      102 | Sue Smith   | Los Angeles | 110915.00
      108 | Larry Fitch | Los Angeles | 110915.00
      109 | Mary Jones  | New York    | 117637.00
      106 | Sam Clark   | New York    | 117637.00
(5 rows)

select num_empl,nombre,
(select ciudad from oficinas where oficina_rep=oficina),
(select ventas-objetivo as neto from oficinas where oficina_rep=oficina) as dif from repventas
where oficina_rep in ( select oficina from oficinas
                       where ventas > objetivo )
order by dif;
 num_empl |   nombre    |   ciudad    |    dif    
----------+-------------+-------------+-----------
      105 | Bill Adams  | Atlanta     |  17911.00
      102 | Sue Smith   | Los Angeles | 110915.00
      108 | Larry Fitch | Los Angeles | 110915.00
      109 | Mary Jones  | New York    | 117637.00
      106 | Sam Clark   | New York    | 117637.00
(5 rows)

-- 5.12- Llista els venedors que no treballen en oficines dirigides per Larry Fitch, o que no treballen a cap oficina. Sense usar
-- consultes multitaula.
select nombre from repventas
where oficina_rep is null or oficina_rep not in ( select oficina from oficinas
                                                  where dir = ( select num_empl from repventas
                                                                where nombre = 'Larry Fitch' ));
   nombre    
-------------
 Bill Adams
 Mary Jones
 Sam Clark
 Bob Smith
 Dan Roberts
 Tom Snyder
 Paul Cruz
(7 rows)

select nombre from repventas rep
where rep.oficina_rep is null or rep.oficina_rep not in ( select oficina from oficinas
                                                                join repventas dir on dir.num_empl=dir
                                                          where nombre = 'Larry Fitch' );
   nombre    
-------------
 Bill Adams
 Mary Jones
 Sam Clark
 Bob Smith
 Dan Roberts
 Tom Snyder
 Paul Cruz
(7 rows)

-- 5.13- Llistar els venedors que no treballen en oficines dirigides per Larry Fitch, o que no treballen a cap oficina.
-- Mostrant també la ciutat de l'oficina on treballa l'empleat i l'identificador del director de la oficina.
-- Proposa dos sentències SQL, una amb subconsultes i una sense.



-- 5.14- Llistar tots els clients que han realitzat comandes del productes de la família ACI Widgets entre gener i juny del 1990.
-- Els productes de la famíla ACI Widgets són aquells que tenen identificador de fabricant "aci" i que l'identificador del producte
-- comença per "4100".
select clie,fecha_pedido from pedidos
where (fab,producto) in ( select id_fab,id_producto from productos
                          where id_fab = 'aci' and id_producto like '4100%' )
and fecha_pedido > '1990-01-01' and fecha_pedido < '1990-06-30';
 clie | fecha_pedido 
------+--------------
 2111 | 1990-01-11
 2107 | 1990-01-30
 2103 | 1990-01-22
 2108 | 1990-02-15
 2111 | 1990-02-18
(5 rows)

-- 5.15- Llistar els clients que no tenen cap comanda.
select * from clientes
where num_clie not in ( select distinct clie from pedidos );
 num_clie |     empresa     | rep_clie | limite_credito 
----------+-----------------+----------+----------------
     2123 | Carter & Sons   |      102 |       40000.00
     2115 | Smithson Corp.  |      101 |       20000.00
     2121 | QMA Assoc.      |      103 |       45000.00
     2122 | Three-Way Lines |      105 |       30000.00
     2119 | Solomon Inc.    |      109 |       25000.00
     2105 | AAA Investments |      101 |       45000.00
(6 rows)

select num_clie,empresa,count(*) from clientes
      left join pedidos on num_clie=clie
group by num_clie;

select empresa,count(distinct num_pedido) from clientes
      left join pedidos on num_clie=clie
group by num_clie
having count(distinct num_pedido) = 0
order by 1;
     empresa     | count 
-----------------+-------
 AAA Investments |     0
 Carter & Sons   |     0
 QMA Assoc.      |     0
 Smithson Corp.  |     0
 Solomon Inc.    |     0
 Three-Way Lines |     0
(6 rows)

-- 5.16- Llistar els clients que tenen assignat el venedor que porta més temps a contractat.
select num_clie from clientes
where rep_clie = ( select num_empl from repventas
                   order by contrato
                   limit 1 );
 num_clie 
----------
     2102
     2115
     2105
(3 rows)

-- 5.17- Llistar els clients assignats a Sue Smith que no han fet cap comanda amb un import superior a 30000. Proposa una
-- sentència SQL sense usar multitaula i una altre en que s'usi multitaula i subconsultes.
select empresa from clientes
where rep_clie = ( select num_empl from repventas
                   where nombre = 'Sue Smith' )
and not exists ( select num_pedido from pedidos
                 where clie=num_clie
                 and importe > 30000 );
     empresa      
------------------
 Carter & Sons
 Orion Corp
 Rico Enterprises
 Fred Lewis Corp.
(4 rows)

select empresa from clientes
where rep_clie = ( select num_empl from repventas
                   where nombre = 'Sue Smith' )
and num_clie not in ( select clie from pedidos
                      where importe > 30000 );
     empresa      
------------------
 Carter & Sons
 Orion Corp
 Rico Enterprises
 Fred Lewis Corp.
(4 rows)

-- 5.18- Llistar l'identificador i el nom dels directors d'empleats que tenen més de 40 anys i que dirigeixen un venedor que té
-- unes vendes superiors a la seva pròpia quota.
select num_empl,nombre from repventas
where num_empl in ( select director from repventas
                    where edad > 40 and (ventas > cuota) );
 num_empl |   nombre    
----------+-------------
      106 | Sam Clark
      104 | Bob Smith
      108 | Larry Fitch
(3 rows)

-- 5.19- Llista d'oficines on hi hagi --algun-- venedor tal que la seva quota representi més del 50% de l'objectiu de l'oficina
select * from oficinas
where oficina in ( select oficina_rep from repventas 
                         join oficinas on oficina_rep=oficina
                   where cuota > objetivo * 0.5 );
 oficina |  ciudad  | region | dir | objetivo  |  ventas   
---------+----------+--------+-----+-----------+-----------
      22 | Denver   | Oeste  | 108 | 300000.00 | 186042.00
      11 | New York | Este   | 106 | 575000.00 | 692637.00
      13 | Atlanta  | Este   | 105 | 350000.00 | 367911.00
(3 rows)

select * from oficinas
where objetivo * 0.5 < any ( select cuota from repventas
                             where oficina=oficina_rep );
 oficina |  ciudad  | region | dir | objetivo  |  ventas   
---------+----------+--------+-----+-----------+-----------
      22 | Denver   | Oeste  | 108 | 300000.00 | 186042.00
      11 | New York | Este   | 106 | 575000.00 | 692637.00
      13 | Atlanta  | Este   | 105 | 350000.00 | 367911.00
(3 rows)

-- 5.20- Llista d'oficines on --tots-- els venedors tinguin la seva quota superior al 55% de l'objectiu de l'oficina.
select * from oficinas
where objetivo * 0.55 < all ( select cuota from repventas
                              where oficina=oficina_rep );
 oficina | ciudad  | region | dir | objetivo  |  ventas   
---------+---------+--------+-----+-----------+-----------
      22 | Denver  | Oeste  | 108 | 300000.00 | 186042.00
      13 | Atlanta | Este   | 105 | 350000.00 | 367911.00
(2 rows)

-- 5.21- Transforma el següent JOIN a una comanda amb subconsultes:
-- SELECT num_pedido, importe, clie, num_clie, limite_credito
-- FROM pedidos JOIN clientes
-- ON clie = num_clie;


-- 5.22- Transforma el següent JOIN a una comanda amb subconsultes:
-- SELECT empl.nombre, empl.cuota, dir.nombre, dir.cuota
-- FROM repventas AS empl JOIN repventas AS dir
-- ON empl.director = dir.num_empl
-- WHERE empl.cuota > dir.cuota;



-- 5.23- Transforma la següent consulta amb un ANY a una consulta amb un EXISTS i també en una altre consulta amb un ALL:
-- SELECT oficina FROM oficinas
-- WHERE ventas*0.8 < ANY (SELECT ventas FROM repventas
--                         WHERE oficina_rep = oficina);



-- 5.24- Transforma la següent consulta amb un ALL a una consutla amb un EXISTS i també en una altre consulta amb un ANY:
-- SELECT num_clie FROM clientes
-- WHERE limite_credito < ALL (SELECT importe FROM pedidos
--                             WHERE num_clie = clie);



-- 5.25- Transforma la següent consulta amb un EXISTS a una consulta amb un ALL i també a una altre consulta amb un ANY:
-- SELECT num_clie, empresa FROM clientes
-- WHERE EXISTS (SELECT * FROM repventas
--               WHERE rep_clie = num_empl AND edad BETWEEN 40 AND 50);



-- 5.26- Transforma la següent consulta amb subconsultes a una consulta sense subconsultes.
-- SELECT * FROM productos
-- WHERE id_fab IN(SELECT fab FROM pedidos
--                 WHERE cant > 30) AND id_producto IN(SELECT producto FROM pedidos
--                                                     WHERE cant > 30);



-- 5.27- Transforma la següent consulta amb subconsultes a una consulta sense subconsultes.
-- SELECT num_empl, nombre FROM repventas
-- WHERE num_empl = ANY ( SELECT rep_clie FROM clientes
--                        WHERE empresa LIKE '%Inc.');



-- 5.28- Transforma la següent consulta amb un IN a una consulta amb un EXISTS i també a una altre consulta amb un ALL.
-- SELECT num_empl, nombre FROM repventas
-- WHERE num_empl IN(SELECT director FROM repventas);



-- 5.29- Modifica la següent consulta perquè mostri la ciutat de l'oficina, proposa una consulta simplificada.
-- SELECT num_pedido FROM pedidos WHERE rep IN
-- (
--     SELECT num_empl FROM repventas WHERE ventas >
--     (
--         SELECT avg(ventas) FROM repventas
--     )
--     AND oficina_rep IN
--     (
--         SELECT oficina FROM oficinas WHERE region ILIKE 'este'
--     )
-- );



-- 5.30- Transforma la següent consulta amb subconsultes a una consulta amb les mínimes subconsultes possibles.
-- SELECT num_clie, empresa, (SELECT nombre FROM repventas WHERE rep_clie = num_empl) AS rep_nombre FROM clientes
-- WHERE rep_clie = ANY (SELECT num_empl FROM repventas
--                       WHERE ventas > (SELECT MAX(cuota) FROM repventas));