-- 1.- Quantes oficines tenim a cada regió?

training=# select region, count(oficina) as "oficinas por region" from oficinas group by region;
 region | oficinas por region 
--------+---------------------
 Este   |                   3
 Oeste  |                   2
(2 rows)

-- 2.- Quants representants de ventes hi ha a cada oficina?

training=# select oficina_rep, count(nombre) as "numero de representants de ventas" from repventas where oficina_rep is not null group by oficina_rep;
 oficina_rep | numero de representants de ventas 
-------------+-----------------------------------
          13 |                                 1
          22 |                                 1
          21 |                                 2
          11 |                                 2
          12 |                                 3
(5 rows)

-- 3.- Quants representants de ventes té assignats cada cap de respresentants?

training=# select director, count(nombre) as "repventas assignats" from repventas where director is not null group by director; director | repventas assignats 
----------+---------------------
      106 |                   3
      101 |                   1
      108 |                   2
      104 |                   3
(4 rows)

-- 4.- Quina és, per cada oficina, la suma de les quotes dels seus representants? I la mitjana de les quotes per oficina?

training=# select oficina_rep, sum(cuota) as "suma de quotas" from repventas where oficina_rep is not null group by oficina_rep; oficina_rep | suma de quotas 
-------------+----------------
          13 |      350000.00
          22 |      300000.00
          21 |      700000.00
          11 |      575000.00
          12 |      775000.00
(5 rows)

-- 5.- Quin és el representant que té la quota més alta de cada oficina?

training=# select oficina_rep,  max(cuota) as "cuota" from repventas where oficina_rep is not null group by oficina_rep;
 oficina_rep |   cuota   
-------------+-----------
          13 | 350000.00
          22 | 300000.00
          21 | 350000.00
          11 | 300000.00
          12 | 300000.00
(5 rows)

-- 6.- Quants clients representa cada venedor-repventas?

training=# select rep_clie, count(num_clie) from clientes group by rep_clie;
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

training=# select rep_clie, count(num_clie), max(limite_credito) from clientes group by rep_clie;
 rep_clie | count |   max    
----------+-------+----------
      106 |     2 | 65000.00
      103 |     3 | 50000.00
      110 |     1 | 35000.00
      101 |     3 | 65000.00
      105 |     2 | 50000.00
      107 |     1 | 40000.00
      108 |     2 | 60000.00
      109 |     2 | 55000.00
      104 |     1 | 20000.00
      102 |     4 | 65000.00
(10 rows)

-- 8.- Per cada codi de fàbrica diferents, quants productes hi ha?

training=# select id_fab, count(descripcion) from productos group by id_fab;
 id_fab | count 
--------+-------
 imm    |     6
 aci    |     7
 fea    |     2
 qsa    |     3
 rei    |     4
 bic    |     3
(6 rows)

-- 9.- Per cada codi de producte diferent, a quantes fàbriques es fabrica?

training=# select id_producto, count(id_fab) from productos group by id_producto;
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

-- 10.- Per cada nom de producte diferent, quants codis (if_fab + id_prod) tenim?

training=# select descripcion, count(id_producto) from productos group by descripcion;
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

training=# select producto, count(num_pedido) from pedidos group by producto;
 producto | count 
----------+-------
 773c     |     1
 4100z    |     2
 41002    |     2
 41004    |     3
 114      |     2
 2a44l    |     1
 k47      |     1
 4100y    |     1
 xk47     |     3
 2a44g    |     1
 2a44r    |     2
 779c     |     2
 112      |     1
 775c     |     1
 2a45c    |     2
 41003    |     3
 4100x    |     2
(17 rows)

-- 12.- Per cada client, quantes comandes tenim?

training=# select clie, count(num_pedido) from pedidos group by clie;
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

-- 13.- Quantes comandes ha realitzat cada representant de vendes?

training=# select rep, count(num_pedido) from pedidos group by rep;
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

training=# select rep, avg(importe) as "comanda promig" from pedidos group by rep;
 rep |     comanda promig     
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

training=# select oficina_rep, max(cuota), min(cuota) from repventas group by oficina_rep;
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

-- 17.- Quants clients són atesos per (tenen com a representant oficial a) cada cada venedor?

-- 18.- Calcula el total de l'import de les comandes per cada venedor i per cada client.

-- 19.- El mateix que a la qüestió anterior, però ordenat per client i dintre de client per venedor.

-- 20.- Calcula les comandes (imports) totals per a cada venedor.

-- 21.- Quin és l'import promig de les comandes per cada venedor, les comandes dels quals sumen més de 30 000?

-- 22.- Per cada oficina amb 2 o més persones, calculeu la quota
--total i les vendes totals per a tots els venedors que treballen a la oficina (volem que sorti la ciutat de l'oficina a la consulta) 
