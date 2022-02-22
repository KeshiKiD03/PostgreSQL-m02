-- 1.- Quantes oficines tenim a cada regió?
training=> select count(oficinas),region from oficinas group by region;
 count | region 
-------+--------
     3 | Este
     2 | Oeste
(2 rows)

-- 2.- Quants representants de ventes hi ha a cada oficina?

training=> select count(num_empl),oficina_rep from repventas group by oficina_rep;
 count | oficina_rep 
-------+-------------
     1 |            
     3 |          12
     2 |          21
     2 |          11
     1 |          13
     1 |          22
(6 rows)


-- 3.- Quants representants de ventes té assignats cada cap de respresentants?


training=# select director,count(num_empl) from repventas group by director;
 director | count 
----------+-------
          |     1
      106 |     3
      101 |     1
      108 |     2
      104 |     3
(5 rows)


-- 4.- Quina és, per cada oficina, la suma de les quotes dels seus representants? I la mitjana de les quotes per oficina?


training=# select oficina_rep,sum(cuota),avg(cuota) from repventas group by oficina_rep;
 oficina_rep |    sum    |         avg         
-------------+-----------+---------------------
             |           |                    
          13 | 350000.00 | 350000.000000000000
          22 | 300000.00 | 300000.000000000000
          21 | 700000.00 | 350000.000000000000
          11 | 575000.00 | 287500.000000000000
          12 | 775000.00 | 258333.333333333333
(6 rows)

-- 5.- Quin és el representant que té la quota més alta de cada oficina?
                                                                  ^
training=# select oficina_rep,nombre,max(cuota) as "cuota" from repventas where oficina_rep is not null group by oficina_rep,nombre;
 oficina_rep |    nombre     |   cuota   
-------------+---------------+-----------
          13 | Bill Adams    | 350000.00
          22 | Nancy Angelli | 300000.00
          21 | Sue Smith     | 350000.00
          12 | Bob Smith     | 200000.00
          12 | Paul Cruz     | 275000.00
          11 | Mary Jones    | 300000.00
          11 | Sam Clark     | 275000.00
          12 | Dan Roberts   | 300000.00
          21 | Larry Fitch   | 350000.00
(9 rows)



-- 6.- Quants clients representa cada venedor-repventas?

training=# select rep_clie,count(num_clie) from clientes group by rep_clie;
 rep_clie | count 
----------+-------
      106 |     2
      107 |     1
      104 |     1
      102 |     4
      108 |     2
      105 |     2
      109 |     2
      103 |     3
      101 |     3
      110 |     1
(10 rows)


-- 7.- Quin és el client de cada  venedor-repventas amb el límit de crèdit més alt?

training=# select rep_clie,count(num_clie),max(limite_credito) from clientes group by rep_clie;
 rep_clie | count |   max    
----------+-------+----------
      106 |     2 | 65000.00
      107 |     1 | 40000.00
      104 |     1 | 20000.00
      102 |     4 | 65000.00
      108 |     2 | 60000.00
      105 |     2 | 50000.00
      109 |     2 | 55000.00
      103 |     3 | 50000.00
      101 |     3 | 65000.00
      110 |     1 | 35000.00
(10 rows)



-- 8.- Per cada codi de fàbrica diferents, quants productes hi ha?

training=# select id_fab,count(id_producto) from productos group by id_fab;
 id_fab | count 
--------+-------
 aci    |     7
 qsa    |     3
 bic    |     3
 imm    |     6
 fea    |     2
 rei    |     4
(6 rows)

-- 9.- Per cada codi de producte diferent, a quantes fàbriques es fabrica?


training=# select id_producto,count(id_fab) from productos group by id_producto;
 id_producto | count 
-------------+-------
 887p        |     1
 2a44r       |     1
 773c        |     1
 41004       |     1
 xk48a       |     1
 114         |     1
 779c        |     1
 887h        |     1
 112         |     1
 4100z       |     1
 xk47        |     1
 775c        |     1
 xk48        |     1
 41672       |     1
 2a45c       |     1
 41089       |     1
 887x        |     1
 2a44g       |     1
 2a44l       |     1
 41002       |     1
 41003       |     2
 4100x       |     1
 4100y       |     1
 41001       |     1
(24 rows)

-- 10.- Per cada nom de producte diferent, quants codis (id_fab + id_prod) tenim?

training=# select descripcion,count(id_producto) from productos group by descripcion;
    descripcion    | count 
-------------------+-------
 Montador          |     1
 Riostra 1/2-Tm    |     1
 Riostra 2-Tm      |     1
 Ajustador         |     1
 Reductor          |     3
 Articulo Tipo 3   |     1
 Cubierta          |     1
 Retn              |     1
 Perno Riostra     |     1
 V Stago Trinquete |     1
 Articulo Tipo 2   |     1
 Soporte Riostra   |     1
 Articulo Tipo 4   |     1
 Riostra 1-Tm      |     1
 Bisagra Izqda.    |     1
 Articulo Tipo 1   |     1
 Bancada Motor     |     1
 Extractor         |     1
 Bisagra Dcha.     |     1
 Manivela          |     1
 Pasador Bisagra   |     1
 Plate             |     1
 Retenedor Riostra |     1
(23 rows)



-- 11.- Per cada producte (id_fab + id_prod), quantes comandes tenim?

training=# select producto,count(*) from pedidos group by fab,producto;
 producto | count 
----------+-------
 2a44g    |     1
 2a45c    |     2
 k47      |     1
 112      |     1
 41003    |     2
 4100z    |     2
 41004    |     3
 2a44r    |     2
 114      |     2
 4100y    |     1
 41003    |     1
 4100x    |     2
 775c     |     1
 41002    |     2
 779c     |     2
 2a44l    |     1
 xk47     |     3
 773c     |     1
(18 rows)


-- 12.- Per cada client, quantes comandes tenim?

training=# select clie,count(num_pedido) from pedidos group by clie;
 clie | count 
------+-------
 2102 |     1
 2117 |     1
 2112 |     2
 2118 |     4
 2120 |     1
 2106 |     2
 2108 |     3
 2113 |     1
 2107 |     2
 2124 |     2
 2109 |     1
 2111 |     3
 2101 |     1
 2114 |     2
 2103 |     4
(15 rows)


-- 13.- Quantes comandes ha realitzat cada representant de vendes?


training=# select rep,count(*) from pedidos group by rep;
 rep | count 
-----+-------
 106 |     2
 107 |     3
 102 |     4
 108 |     7
 105 |     5
 109 |     2
 103 |     2
 101 |     3
 110 |     2
(9 rows)


-- 14.- Quina és la comanda promig de cada venedor?

training=# select rep,avg(importe) as "comanda promig" from pedidos group by rep;
 rep |     comanda promig     
-----+------------------------
 106 |     16479.000000000000
 107 | 11477.3333333333333333
 102 |  5694.0000000000000000
 108 |  8376.1428571428571429
 105 |  7865.4000000000000000
 109 |  3552.5000000000000000
 103 |  1350.0000000000000000
 101 |  8876.0000000000000000
 110 | 11566.0000000000000000
(9 rows)


training=# select rep,avg(importe) as "comanda promig" from pedidos group by rep order by 2 desc;
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

training=# select oficina_Rep,max(cuota),min(cuota) from repventas group by oficina_rep;
 oficina_rep |    max    |    min    
-------------+-----------+-----------
             |           |          
          12 | 300000.00 | 200000.00
          21 | 350000.00 | 350000.00
          11 | 300000.00 | 275000.00
          13 | 350000.00 | 350000.00
          22 | 300000.00 | 300000.00
(6 rows)

training=# select  count(num_empl), oficina_rep,max(cuota),min(cuota) from repventas group by oficina_rep;
 count | oficina_rep |    max    |    min    
-------+-------------+-----------+-----------
     1 |             |           |          
     3 |          12 | 300000.00 | 200000.00
     2 |          21 | 350000.00 | 350000.00
     2 |          11 | 300000.00 | 275000.00
     1 |          13 | 350000.00 | 350000.00
     1 |          22 | 300000.00 | 300000.00
(6 rows)

-- 16.- Quants venedors estan asignats a cada oficina?

training=# select count(*),oficina_rep from repventas group by oficina_rep;
 count | oficina_rep 
-------+-------------
     1 |            
     3 |          12
     2 |          21
     2 |          11
     1 |          13
     1 |          22
(6 rows)

training=# select count(*),oficina_rep from repventas where oficina_rep is not null group by oficina_rep;
 count | oficina_rep 
-------+-------------
     3 |          12
     2 |          21
     2 |          11
     1 |          13
     1 |          22
(5 rows)


-- 17.- Quants clients són atesos per (tenen com a representant oficial a) cada cada venedor?

training=# select rep_clie,count(*) from clientes group by rep_clie;
 rep_clie | count 
----------+-------
      106 |     2
      107 |     1
      104 |     1
      102 |     4
      108 |     2
      105 |     2
      109 |     2
      103 |     3
      101 |     3
      110 |     1
(10 rows)

-- 18.- Calcula el total de l'import de les comandes per cada venedor i per cada client.

training=# select rep,clie,sum(importe) from pedidos group by rep,clie;
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

-- 20.- Calcula les comandes (imports) totals per a cada venedor.

training=# select rep, sum(importe) as "total importe" from pedidos group by rep;
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







-- 21.- Quin és l'import promig de les comandes per cada venedor, les comandes dels quals sumen més de 30 000?


training=# SELECT rep,avg(importe) as "promig" from pedidos group by rep having sum(importe) >30000;
 rep |         promig         
-----+------------------------
 106 |     16479.000000000000
 105 |  7865.4000000000000000
 107 | 11477.3333333333333333
 108 |  8376.1428571428571429
(4 rows)




-- 22.- Per cada oficina amb 2 o més persones, calculeu la quota
--total i les vendes totals per a tots els venedors que treballen a la oficina (volem que sorti la ciutat de l'oficina a la consulta) 

training=# SELECT oficina_rep, sum(cuota),sum(cuota),count(*)as "Numero treballadors"  from repventas GROUP BY oficina_rep HAVING count(oficina_rep)>=2;;
 oficina_rep |    sum    |    sum    | Numero treballadors 
-------------+-----------+-----------+---------------------
          21 | 700000.00 | 700000.00 |                   2
          11 | 575000.00 | 575000.00 |                   2
          12 | 775000.00 | 775000.00 |                   3




