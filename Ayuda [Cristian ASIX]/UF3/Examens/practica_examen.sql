--  Practica examen BBdDD
-- 1. Quin son els clients assignats als venedors que dirigeix directament el Sam Clark:
--   1) primer busque els venedors que dirigeix el Sam Clark
select dir.nombre,rep.nombre from repventas dir
    join repventas rep on dir.num_empl=dir.director                                       
where dir.nombre='Sam Clark';

  nombre   |   nombre    
-----------+-------------
 Sam Clark | Mary Jones
 Sam Clark | Bob Smith
 Sam Clark | Larry Fitch
(3 rows)

--   2) ara trobem el clients assignats aquells venedors
select dir.nombre,rep.nombre,empresa from repventas dir
    join repventas rep on dir.num_empl=rep.director
    join clientes on rep.num_empl=rep_clie
where dir.nombre='Sam Clark';

  nombre   |   nombre    |     empresa     
-----------+-------------+-----------------
 Sam Clark | Larry Fitch | Zetacorp
 Sam Clark | Mary Jones  | Holm & Landis
 Sam Clark | Mary Jones  | Solomon Inc.
 Sam Clark | Larry Fitch | Midwest Systems
 Sam Clark | Bob Smith   | Ian & Schmidt
(5 rows)

-- 2. Quin son els clients assignats als venedors de la oficina que dirigeix el Bob Smith:
--   1) busque la oficina que dirigeix el Bob Smith
select nombre as director,oficina from repventas
    join oficinas on oficina_rep=oficina
where nombre='Bob Smith';

 director  | oficina 
-----------+---------
 Bob Smith |      12
(1 row)

--   2) quins venedors que treballen a la oficina
select dir.nombre as director,rep.nombre as venedor from repventas dir
    join oficinas on oficina_rep=oficina
    join repventas rep on oficina=rep.oficina_rep
where dir.nombre='Bob Smith';

 director  |   venedor   
-----------+-------------
 Bob Smith | Bob Smith
 Bob Smith | Dan Roberts
 Bob Smith | Paul Cruz
(3 rows)

--   3) busca els clientes que representen aquells treballadors
select dir.nombre as director,rep.nombre as venedor,empresa from repventas dir
    join oficinas on oficina_rep=oficina
    join repventas rep on oficina=rep.oficina_rep
    join clientes on rep.num_empl=rep_clie
where dir.nombre='Bob Smith';

 director  |   venedor   |     empresa     
-----------+-------------+-----------------
 Bob Smith | Paul Cruz   | JCP Inc.
 Bob Smith | Dan Roberts | First Corp.
 Bob Smith | Dan Roberts | Smithson Corp.
 Bob Smith | Paul Cruz   | QMA Assoc.
 Bob Smith | Bob Smith   | Ian & Schmidt
 Bob Smith | Paul Cruz   | Chen Associates
 Bob Smith | Dan Roberts | AAA Investments
(7 rows)

-- 3. Quantes comandes s'han fet de cada producte:
-- a) que nomes surtin els productes que s'han venut 
select id_producto,id_fab,count(pedidos.*) from productos
    join pedidos on id_producto=producto and id_fab=fab
group by id_producto,id_fab
order by 3;

 id_producto | id_fab | count 
-------------+--------+-------
 41003       | aci    |     1
 112         | fea    |     1
 775c        | imm    |     1
 2a44l       | rei    |     1
 4100y       | aci    |     1
 2a44g       | rei    |     1
 773c        | imm    |     1
 41003       | bic    |     2
 114         | fea    |     2
 2a44r       | rei    |     2
 2a45c       | rei    |     2
 41002       | aci    |     2
 4100x       | aci    |     2
 4100z       | aci    |     2
 779c        | imm    |     2
 xk47        | qsa    |     3
 41004       | aci    |     3
(17 rows)

-- b) que surtin tots els productes existents
select id_producto,id_fab,count(pedidos.*) from productos
    left join pedidos on id_producto=producto and id_fab=fab
group by id_producto,id_fab
order by 3;

 id_producto | id_fab | count 
-------------+--------+-------
 41672       | bic    |     0
 887x        | imm    |     0
 xk48a       | qsa    |     0
 41001       | aci    |     0
 xk48        | qsa    |     0
 887h        | imm    |     0
 887p        | imm    |     0
 41089       | bic    |     0
 41003       | aci    |     1
 2a44l       | rei    |     1
 4100y       | aci    |     1
 2a44g       | rei    |     1
 112         | fea    |     1
 773c        | imm    |     1
 775c        | imm    |     1
 2a45c       | rei    |     2
 114         | fea    |     2
 4100x       | aci    |     2
 4100z       | aci    |     2
 2a44r       | rei    |     2
 779c        | imm    |     2
 41002       | aci    |     2
 41003       | bic    |     2
 xk47        | qsa    |     3
 41004       | aci    |     3
(25 rows)
