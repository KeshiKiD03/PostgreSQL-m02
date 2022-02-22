-- 1.- Quantes oficines tenim a cada regió?

training=# SELECT count(*), region FROM oficinas GROUP BY region;
 count | region 
-------+--------
     3 | Este
     2 | Oeste
(2 rows)

-- 2.- Quants representants de ventes hi ha a cada oficina?

training=# SELECT count(titulo) AS "Representants de ventes en cada oficina",  oficina_rep FROM repventas WHERE oficina_rep IS NOT NULL GROUP BY oficina_rep;
 Representants de ventes en cada oficina | oficina_rep 
-----------------------------------------+-------------
                                       1 |            
                                       1 |          13
                                       1 |          22
                                       2 |          21
                                       2 |          11
                                       3 |          12
(6 rows)

-- 3.- Quants representants de ventes té assignats cada cap de respresentants?

training=# SELECT count(*), director FROM repventas WHERE director IS NOT NULL GROUP BY director;
 count | director 
-------+----------
     1 |         
     3 |      106
     1 |      101
     2 |      108
     3 |      104
(5 rows)

-- 4.- Quina és, per cada oficina, la suma de les quotes dels seus representants? I la mitjana de les quotes per oficina?

training=# SELECT oficina_rep, sum(cuota) AS "Suma de cuota", avg(cuota) FROM repventas WHERE oficina_rep IS NOT NULL GROUP BY oficina_rep;
 oficina_rep | Suma de cuota |         avg         
-------------+---------------+---------------------
          13 |     350000.00 | 350000.000000000000
          22 |     300000.00 | 300000.000000000000
          21 |     700000.00 | 350000.000000000000
          11 |     575000.00 | 287500.000000000000
          12 |     775000.00 | 258333.333333333333
(5 rows)



-- 5.- Quin és el representant que té la quota més alta de cada oficina?

training=# SELECT max(cuota), oficina_rep FROM repventas GROUP BY oficina_rep;
    max    | oficina_rep 
-----------+-------------
           |            
 350000.00 |          13
 300000.00 |          22
 350000.00 |          21
 300000.00 |          11
 300000.00 |          12
(6 rows)


-- 6.- Quants clients representa cada venedor-repventas?

training=# SELECT count(num_clie), rep_clie FROM clientes GROUP BY rep_clie; 
 count | rep_clie 
-------+----------
     2 |      106
     3 |      103
     1 |      110
     3 |      101
     2 |      105
     1 |      107
     2 |      108
     2 |      109
     1 |      104
     4 |      102
(10 rows)



-- 7.- Quin és el client de cada  venedor-repventas amb el límit de crèdit més alt?

training=# SELECT rep_clie, max(limite_credito) FROM clientes GROUP BY rep_clie;
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

training=# SELECT id_fab, count(id_producto) FROM productos GROUP BY id_fab;
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

training=# SELECT id_producto, count(id_fab) FROM productos GROUP BY id_producto;
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

training=# SELECT descripcion, count(id_producto) FROM productos GROUP BY descripcion;
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

training=# SELECT fab, producto, count(num_pedido) FROM pedidos GROUP BY fab, producto;
 fab | producto | count 
-----+----------+-------
 fea | 114      |     2
 qsa | xk47     |     3
 rei | 2a44g    |     1
 bic | 41003    |     2
 rei | 2a45c    |     2
 imm | 773c     |     1
 qsa | k47      |     1
 rei | 2a44r    |     2
 aci | 41003    |     1
 aci | 4100x    |     2
 aci | 4100z    |     2
 imm | 775c     |     1
 aci | 41002    |     2
 imm | 779c     |     2
 rei | 2a44l    |     1
 aci | 41004    |     3
 aci | 4100y    |     1
 fea | 112      |     1
(18 rows)

-- 12.- Per cada client, quantes comandes tenim?

training=# SELECT clie, count(num_pedido) FROM pedidos GROUP BY clie;
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

training=# SELECT clie, count(num_pedido) FROM pedidos GROUP BY clie ORDER BY 2 DESC;
 clie | count 
------+-------
 2118 |     4
 2103 |     4
 2111 |     3
 2108 |     3
 2124 |     2
 2107 |     2
 2112 |     2
 2114 |     2
 2106 |     2
 2113 |     1
 2109 |     1
 2101 |     1
 2120 |     1
 2117 |     1
 2102 |     1
(15 rows)


-- 13.- Quantes comandes ha realitzat cada representant de vendes?

training=# SELECT count(num_pedido), rep FROM pedidos GROUP BY rep;
 count | rep 
-------+-----
     2 | 106
     2 | 103
     2 | 110
     3 | 101
     5 | 105
     3 | 107
     7 | 108
     2 | 109
     4 | 102
(9 rows)

training=# SELECT rep, count(*) FROM pedidos GROUP BY rep ORDER BY 2 DESC;
 rep | count 
-----+-------
 108 |     7
 105 |     5
 102 |     4
 101 |     3
 107 |     3
 110 |     2
 103 |     2
 109 |     2
 106 |     2
(9 rows)


-- 14.- Quina és la comanda promig de cada venedor?

training=# SELECT rep, avg(importe) AS "comanda promig" FROM pedidos GROUP BY rep ORDER BY 2 DESC;
 rep |     comanda promig     
-----+------------------------
 106 |     16479.000000000000
 110 | 11566.0000000000000000
 107 | 11477.3333333333333333
 101 |  8876.0000000000000000
 108 |  8376.1428571428571429
 105 |  7865.4000000000000000
 102 |  5694.0000000000000000
 109 |  3552.5000000000000000
 103 |  1350.0000000000000000
(9 rows)


-- 15.- Quin és el rang de quotes asignades a cada oficina? ( es a dir, el mínim i el màxim)

training=# SELECT oficina_rep, count(*), max(cuota), min(cuota) FROM repventas WHERE oficina_rep IS NOT NULL GROUP BY oficina_rep;
 oficina_rep | count |    max    |    min    
-------------+-------+-----------+-----------
          13 |     1 | 350000.00 | 350000.00
          22 |     1 | 300000.00 | 300000.00
          21 |     2 | 350000.00 | 350000.00
          11 |     2 | 300000.00 | 275000.00
          12 |     3 | 300000.00 | 200000.00
(5 rows)


-- 16.- Quants venedors estan asignats a cada oficina?

training=# SELECT count(*),oficina_rep FROM repventas GROUP BY oficina_rep;
 count | oficina_rep 
-------+-------------
     1 |            
     1 |          13
     1 |          22
     2 |          21
     2 |          11
     3 |          12
(6 rows)


-- 17.- Quants clients són atesos per (tenen com a representant oficial a) cada cada venedor?

training=# SELECT rep_clie, count(num_clie) FROM clientes GROUP BY rep_clie;
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

training=# SELECT rep,clie,sum(importe) FROM pedidos GROUP BY rep,clie;
 rep | clie |   sum    
-----+------+----------
 109 | 2108 |  7105.00
 110 | 2107 | 23132.00
 106 | 2117 | 31500.00
 102 | 2120 |  3750.00
 102 | 2106 |  4026.00
 108 | 2112 | 47925.00
 108 | 2118 |  3608.00
 107 | 2109 | 31350.00
 105 | 2111 |  3745.00
 101 | 2102 |  3978.00
 105 | 2103 | 35582.00
 108 | 2114 |  7100.00
 103 | 2111 |  2700.00
 107 | 2124 |  3082.00
 101 | 2108 |   150.00
 101 | 2113 | 22500.00
 102 | 2114 | 15000.00
 106 | 2101 |  1458.00
(18 rows)


-- 19.- El mateix que a la qüestió anterior, però ordenat per client i dintre de client per venedor.

training=# SELECT rep,clie,sum(importe) FROM pedidos GROUP BY rep,clie ORDER BY rep, clie;
 rep | clie |   sum    
-----+------+----------
 101 | 2102 |  3978.00
 101 | 2108 |   150.00
 101 | 2113 | 22500.00
 102 | 2106 |  4026.00
 102 | 2114 | 15000.00
 102 | 2120 |  3750.00
 103 | 2111 |  2700.00
 105 | 2103 | 35582.00
 105 | 2111 |  3745.00
 106 | 2101 |  1458.00
 106 | 2117 | 31500.00
 107 | 2109 | 31350.00
 107 | 2124 |  3082.00
 108 | 2112 | 47925.00
 108 | 2114 |  7100.00
 108 | 2118 |  3608.00
 109 | 2108 |  7105.00
 110 | 2107 | 23132.00
(18 rows)

-- 20.- Calcula les comandes (imports) totals per a cada venedor.

training=# SELECT rep, sum(importe) AS "total importe" FROM pedidos GROUP BY rep;
 rep | total importe 
-----+---------------
 106 |      32958.00
 103 |       2700.00
 110 |      23132.00
 101 |      26628.00
 105 |      39327.00
 107 |      34432.00
 108 |      58633.00
 109 |       7105.00
 102 |      22776.00
(9 rows)


-- 21.- Quin és l'import promig de les comandes per cada venedor, les comandes dels quals sumen més de 30 000?

training=# SELECT rep, avg(importe) FROM pedidos GROUP BY rep HAVING sum(importe) > 30000;
 rep |          avg           
-----+------------------------
 106 |     16479.000000000000
 105 |  7865.4000000000000000
 107 | 11477.3333333333333333
 108 |  8376.1428571428571429
(4 rows)

-- 22.- Per cada oficina amb 2 o més persones, calculeu la quota total i les vendes totals per a tots els venedors que treballen a la oficina (volem que sorti la ciutat de l'oficina a la consulta) 

training=# SELECT oficina_rep, sum(cuota),sum(ventas),count(*)as "Numero treballadors"  from repventas GROUP BY oficina_rep HAVING count(oficina_rep)>= 2;
 oficina_rep |    sum    |    sum    | Numero treballadors 
-------------+-----------+-----------+---------------------
          21 | 700000.00 | 835915.00 |                   2
          11 | 575000.00 | 692637.00 |                   2
          12 | 775000.00 | 735042.00 |                   3
(3 rows)
