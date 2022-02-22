-- 1.- Quantes oficines tenim a cada regió?

select region, count(oficina) as "oficinas por region" from oficinas group by region;

 region | oficinas por region 
--------+---------------------
 Este   |                   3
 Oeste  |                   2
(2 rows)

-- 2.- Quants representants de ventes hi ha a cada oficina?

select oficina_rep, count(nombre) as "numero de representants de ventas" 
from repventas where oficina_rep is not null group by oficina_rep;

 oficina_rep | numero de representants de ventas 
-------------+-----------------------------------
          13 |                                 1
          22 |                                 1
          21 |                                 2
          11 |                                 2
          12 |                                 3
(5 rows)

-- 3.- Quants representants de ventes té assignats cada cap de respresentants?

select director, count(nombre) as "repventas assignats" from repventas where director is not null group by director;

 director | repventas assignats 
----------+---------------------
      106 |                   3
      101 |                   1
      108 |                   2
      104 |                   3
(4 rows)

select director, count(nombre) as "repventas assignats" from repventas group by director having director is not null;

 director | repventas assignats 
----------+---------------------
      106 |                   3
      101 |                   1
      108 |                   2
      104 |                   3
(4 rows)

-- 4.- Quina és, per cada oficina, la suma de les quotes dels seus representants? I la mitjana de les quotes per oficina?

select oficina_rep, sum(cuota) as "suma de quotas", avg(cuota) as "mitjana de quotas" 
from repventas where oficina_rep is not null group by oficina_rep;

 oficina_rep | suma de quotas |  mitjana de quotas  
-------------+----------------+---------------------
          13 |      350000.00 | 350000.000000000000
          22 |      300000.00 | 300000.000000000000
          21 |      700000.00 | 350000.000000000000
          11 |      575000.00 | 287500.000000000000
          12 |      775000.00 | 258333.333333333333
(5 rows)

-- 5.- Quin és el representant que té la quota més alta de cada oficina?

select num_empl,nombre,oficina_rep,max(cuota) from repventas where oficina_rep is not null group by num_empl,nombre,oficina_rep;

 num_empl |    nombre     | oficina_rep |    max    
----------+---------------+-------------+-----------
      107 | Nancy Angelli |          22 | 300000.00
      105 | Bill Adams    |          13 | 350000.00
      101 | Dan Roberts   |          12 | 300000.00
      109 | Mary Jones    |          11 | 300000.00
      103 | Paul Cruz     |          12 | 275000.00
      102 | Sue Smith     |          21 | 350000.00
      104 | Bob Smith     |          12 | 200000.00
      106 | Sam Clark     |          11 | 275000.00
      108 | Larry Fitch   |          21 | 350000.00
(9 rows)

select num_empl,nombre,oficina_rep,max(cuota) from repventas group by num_empl,nombre,oficina_rep having oficina_rep is not null;

 num_empl |    nombre     | oficina_rep |    max    
----------+---------------+-------------+-----------
      107 | Nancy Angelli |          22 | 300000.00
      105 | Bill Adams    |          13 | 350000.00
      101 | Dan Roberts   |          12 | 300000.00
      109 | Mary Jones    |          11 | 300000.00
      103 | Paul Cruz     |          12 | 275000.00
      102 | Sue Smith     |          21 | 350000.00
      104 | Bob Smith     |          12 | 200000.00
      106 | Sam Clark     |          11 | 275000.00
      108 | Larry Fitch   |          21 | 350000.00
(9 rows)


-- 6.- Quants clients representa cada venedor-repventas?

select rep_clie, count(num_clie) from clientes group by rep_clie;

 rep_clie | count 
----------+-------
      106 |     2
      103 |     3
      110 |     1
      101 |     3
      105 |     2
      107 |     1
      108 |     2
      109 |     2
      104 |     1
      102 |     4
(10 rows)


-- 7.- Quin és el client de cada  venedor-repventas amb el límit de crèdit més alt?

select rep_clie,  max(limite_credito) from clientes group by rep_clie;
 
 rep_clie |   max    
----------+----------
      106 | 65000.00
      103 | 50000.00
      110 | 35000.00
      101 | 65000.00
      105 | 50000.00
      107 | 40000.00
      108 | 60000.00
      109 | 55000.00
      104 | 20000.00
      102 | 65000.00
(10 rows)

-- 8.- Per cada codi de fàbrica diferents, quants productes hi ha?

select distinct(id_fab),count(descripcion) from productos group by id_fab;

 id_fab | count 
--------+-------
 bic    |     3
 aci    |     7
 rei    |     4
 imm    |     6
 qsa    |     3
 fea    |     2
(6 rows)

select id_producto, count(id_fab) from productos group by id_producto;

 id_fab | count 
--------+-------
 bic    |     3
 aci    |     7
 rei    |     4
 imm    |     6
 qsa    |     3
 fea    |     2
(6 rows)

-- 9.- Per cada codi de producte diferent, a quantes fàbriques es fabrica?

select id_producto, count(id_fab) from productos group by id_producto;

 id_producto | count 
-------------+-------
 887p        |     1
 773c        |     1
 4100z       |     1
 41002       |     1
 41004       |     1
 xk48a       |     1
 114         |     1
 2a44l       |     1
 4100y       |     1
 xk47        |     1
 xk48        |     1
 887x        |     1
 887h        |     1
 2a44g       |     1
 41672       |     1
 41089       |     1
 2a44r       |     1
 779c        |     1
 112         |     1
 775c        |     1
 2a45c       |     1
 41003       |     2
 4100x       |     1
 41001       |     1
(24 rows)


 select distinct(id_producto),count(id_fab) from productos group by id_producto;
 
 id_producto | count 
-------------+-------
 114         |     1
 xk48a       |     1
 41004       |     1
 41003       |     2
 41089       |     1
 41672       |     1
 2a44l       |     1
 4100y       |     1
 773c        |     1
 887p        |     1
 887h        |     1
 4100z       |     1
 2a44g       |     1
 41002       |     1
 887x        |     1
 2a45c       |     1
 41001       |     1
 4100x       |     1
 2a44r       |     1
 779c        |     1
 xk48        |     1
 775c        |     1
 xk47        |     1
 112         |     1
(24 rows)

-- 10.- Per cada nom de producte diferent, quants codis (if_fab + id_prod) tenim?
select distinct(descripcion), count(id_producto) from productos group by descripcion;

    descripcion    | count 
-------------------+-------
 Articulo Tipo 3   |     1
 Riostra 1/2-Tm    |     1
 Articulo Tipo 2   |     1
 V Stago Trinquete |     1
 Bisagra Izqda.    |     1
 Pasador Bisagra   |     1
 Cubierta          |     1
 Articulo Tipo 4   |     1
 Extractor         |     1
 Bancada Motor     |     1
 Manivela          |     1
 Riostra 2-Tm      |     1
 Montador          |     1
 Reductor          |     3
 Soporte Riostra   |     1
 Riostra 1-Tm      |     1
 Bisagra Dcha.     |     1
 Ajustador         |     1
 Perno Riostra     |     1
 Retn              |     1
 Articulo Tipo 1   |     1
 Retenedor Riostra |     1
 Plate             |     1
(23 rows)

select descripcion, count(id_producto) from productos group by descripcion;

    descripcion    | count 
-------------------+-------
 Reductor          |     3
 Cubierta          |     1
 Extractor         |     1
 Manivela          |     1
 Articulo Tipo 3   |     1
 V Stago Trinquete |     1
 Articulo Tipo 2   |     1
 Pasador Bisagra   |     1
 Ajustador         |     1
 Articulo Tipo 1   |     1
 Montador          |     1
 Soporte Riostra   |     1
 Riostra 1-Tm      |     1
 Articulo Tipo 4   |     1
 Bancada Motor     |     1
 Riostra 1/2-Tm    |     1
 Bisagra Izqda.    |     1
 Retn              |     1
 Perno Riostra     |     1
 Plate             |     1
 Retenedor Riostra |     1
 Riostra 2-Tm      |     1
 Bisagra Dcha.     |     1
(23 rows)

-- 11.- Per cada producte (if_fab + id_prod), quantes comandes tenim?
select producto,fab,count(*) from pedidos group by producto,fab;

 producto | fab | count 
----------+-----+-------
 41004    | aci |     3
 112      | fea |     1
 2a45c    | rei |     2
 41003    | bic |     2
 773c     | imm |     1
 4100y    | aci |     1
 xk47     | qsa |     3
 4100z    | aci |     2
 2a44r    | rei |     2
 41002    | aci |     2
 779c     | imm |     2
 775c     | imm |     1
 2a44l    | rei |     1
 41003    | aci |     1
 4100x    | aci |     2
 k47      | qsa |     1
 2a44g    | rei |     1
 114      | fea |     2
(18 rows)

-- 12.- Per cada client, quantes comandes tenim?

select clie, count(num_pedido) from pedidos group by clie;

 clie | count 
------+-------
 2102 |     1
 2111 |     3
 2112 |     2
 2109 |     1
 2101 |     1
 2114 |     2
 2120 |     1
 2106 |     2
 2107 |     2
 2124 |     2
 2117 |     1
 2118 |     4
 2108 |     3
 2103 |     4
 2113 |     1
(15 rows)

select clie, count(num_pedido) from pedidos group by clie order by count(num_pedido) DESC;

 clie | count 
------+-------
 2102 |     1
 2109 |     1
 2101 |     1
 2120 |     1
 2117 |     1
 2113 |     1
 2112 |     2
 2114 |     2
 2107 |     2
 2124 |     2
 2106 |     2
 2111 |     3
 2108 |     3
 2118 |     4
 2103 |     4
(15 rows)


-- 13.- Quantes comandes ha realitzat cada representant de vendes?

select rep,count(num_pedido) from pedidos group by rep;
 rep | count 
-----+-------
 106 |     2
 103 |     2
 110 |     2
 101 |     3
 105 |     5
 107 |     3
 108 |     7
 109 |     2
 102 |     4
(9 rows)



-- 14.- Quina és la comanda promig de cada venedor?

select rep, avg(importe) from pedidos group by rep;

 rep |          avg           
-----+------------------------
 106 |     16479.000000000000
 103 |  1350.0000000000000000
 110 | 11566.0000000000000000
 101 |  8876.0000000000000000
 105 |  7865.4000000000000000
 107 | 11477.3333333333333333
 108 |  8376.1428571428571429
 109 |  3552.5000000000000000
 102 |  5694.0000000000000000
(9 rows)


-- 15.- Quin és el rang de quotes asignades a cada oficina? ( es a dir, el mínim i el màxim)

select oficina_rep, max(cuota), min(cuota) from repventas group by oficina_rep;
 oficina_rep |    max    |    min    
-------------+-----------+-----------
             |           |          
          13 | 350000.00 | 350000.00
          22 | 300000.00 | 300000.00
          21 | 350000.00 | 350000.00
          11 | 300000.00 | 275000.00
          12 | 300000.00 | 200000.00
(6 rows)

-- 16.- Quants venedors estan asignats a cada oficina?

select oficina_rep, count(*) from repventas group by oficina_rep HAVING oficina_rep is not null;

 oficina_rep | count 
-------------+-------
          13 |     1
          22 |     1
          21 |     2
          11 |     2
          12 |     3
(5 rows)


select oficina_rep, count(*) from repventas where oficina_rep is not null group by oficina_rep;
 oficina_rep | count 
-------------+-------
          13 |     1
          22 |     1
          21 |     2
          11 |     2
          12 |     3
(5 rows)

-- 17.- Quants clients són atesos per (tenen com a representant oficial a) cada cada venedor?

select rep,count(clie) from pedidos group by rep;

 rep | count 
-----+-------
 106 |     2
 103 |     2
 110 |     2
 101 |     3
 105 |     5
 107 |     3
 108 |     7
 109 |     2
 102 |     4
(9 rows)


 select rep_clie,count(num_clie) from clientes group by rep_clie;
 rep_clie | count 
----------+-------
      106 |     2
      103 |     3
      110 |     1
      101 |     3
      105 |     2
      107 |     1
      108 |     2
      109 |     2
      104 |     1
      102 |     4
(10 rows)




-- 18.- Calcula el total de l'import de les comandes per cada venedor i per cada client.

select rep,clie,sum(importe) from pedidos group by rep,clie;

 rep | clie |   sum    
-----+------+----------
 107 | 2109 | 31350.00
 108 | 2112 | 47925.00
 105 | 2103 | 35582.00
 108 | 2114 |  7100.00
 103 | 2111 |  2700.00
 110 | 2107 | 23132.00
 106 | 2101 |  1458.00
 101 | 2102 |  3978.00
 102 | 2120 |  3750.00
 102 | 2106 |  4026.00
 101 | 2113 | 22500.00
 109 | 2108 |  7105.00
 108 | 2118 |  3608.00
 101 | 2108 |   150.00
 102 | 2114 | 15000.00
 106 | 2117 | 31500.00
 105 | 2111 |  3745.00
 107 | 2124 |  3082.00
(18 rows)



-- 19.- El mateix que a la qüestió anterior, però ordenat per client i dintre de client per venedor.

select rep,clie,sum(importe) from pedidos group by rep,clie order by clie,rep;

 rep | clie |   sum    
-----+------+----------
 106 | 2101 |  1458.00
 101 | 2102 |  3978.00
 105 | 2103 | 35582.00
 102 | 2106 |  4026.00
 110 | 2107 | 23132.00
 101 | 2108 |   150.00
 109 | 2108 |  7105.00
 107 | 2109 | 31350.00
 103 | 2111 |  2700.00
 105 | 2111 |  3745.00
 108 | 2112 | 47925.00
 101 | 2113 | 22500.00
 102 | 2114 | 15000.00
 108 | 2114 |  7100.00
 106 | 2117 | 31500.00
 108 | 2118 |  3608.00
 102 | 2120 |  3750.00
 107 | 2124 |  3082.00
(18 rows)


-- 20.- Calcula les comandes (imports) totals per a cada venedor.

 select rep,sum(importe) from pedidos group by rep;

 
 rep |   sum    
-----+----------
 106 | 32958.00
 103 |  2700.00
 110 | 23132.00
 101 | 26628.00
 105 | 39327.00
 107 | 34432.00
 108 | 58633.00
 109 |  7105.00
 102 | 22776.00
(9 rows)


-- 21.- Quin és l'import promig de les comandes per cada venedor, les comandes dels quals sumen més de 30 000?

 select rep,avg(importe) from pedidos group by rep having sum(importe) > 30000;

 rep |          avg           
-----+------------------------
 106 |     16479.000000000000
 105 |  7865.4000000000000000
 107 | 11477.3333333333333333
 108 |  8376.1428571428571429
(4 rows)




-- 22.- Per cada oficina amb 2 o més persones, calculeu la quota total i les vendes totals 
--per a tots els venedors que treballen a la oficina (volem que sorti la ciutat de l'oficina a la consulta) 

select oficina_rep,count(num_empl),sum(cuota),sum(ventas) from repventas where oficina_rep is not null group by oficina_rep 
having count(num_empl)>= 2;

 oficina_rep | count |    sum    |    sum    
-------------+-------+-----------+-----------
          21 |     2 | 700000.00 | 835915.00
          11 |     2 | 575000.00 | 692637.00
          12 |     3 | 775000.00 | 735042.00
(3 rows)


          

select oficina_rep,ciudad,count(num_empl),sum(cuota),sum(repventas.ventas) from repventas JOIN oficinas 
ON oficina=oficina_rep group by oficina_rep,ciudad having count(num_empl) >=2;

 oficina_rep |   ciudad    | count |    sum    |    sum    
-------------+-------------+-------+-----------+-----------
          21 | Los Angeles |     2 | 700000.00 | 835915.00
          11 | New York    |     2 | 575000.00 | 692637.00
          12 | Chicago     |     3 | 775000.00 | 735042.00
(3 rows)
