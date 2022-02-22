-- 1.- Quina és la comanda promig de cada venedor?

SELECT rep, avg(importe) FROM pedidos GROUP BY rep;
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


-- 2.- Quin és el rang de quotes asignades a cada oficina? ( es a dir, el mínim i el màxim)

training=# SELECT oficina_rep, max(cuota),min (cuota) from repventas group by oficina_rep;
 oficina_rep |    max    |    min    
-------------+-----------+-----------
             |           |          
          13 | 350000.00 | 350000.00
          22 | 300000.00 | 300000.00
          21 | 350000.00 | 350000.00
          11 | 300000.00 | 275000.00
          12 | 300000.00 | 200000.00
(6 rows)

-- 3.- Quants venedors estan asignats a cada oficina?

training=# SELECT oficina_rep,count(*) from repventas group by oficina_rep;
 oficina_rep | count 
-------------+-------
             |     1
          13 |     1
          22 |     1
          21 |     2
          11 |     2
          12 |     3
(6 rows)



-- 4.- Quants clients són atesos per (tenen com a representant oficial a) cada cada venedor?


training=# SELECT count(rep_clie),rep_clie from clientes group by rep_clie order by rep_clie;
 count | rep_clie 
-------+----------
     3 |      101
     4 |      102
     3 |      103
     1 |      104
     2 |      105
     2 |      106
     1 |      107
     2 |      108
     2 |      109
     1 |      110
(10 rows)



-- 5.- Calcula el total de l'import de les comandes per cada venedor i per cada client.


 clie | rep | total importe | total cantitat 
------+-----+---------------+----------------
 2101 | 106 |       1458.00 |              6
 2102 | 101 |       3978.00 |             34
 2103 | 105 |      35582.00 |             99
 2106 | 102 |       4026.00 |             30
 2107 | 110 |      23132.00 |             17
 2108 | 109 |       7105.00 |             13
 2108 | 101 |        150.00 |              6
 2109 | 107 |      31350.00 |             22
 2111 | 103 |       2700.00 |             30
 2111 | 105 |       3745.00 |             35
 2112 | 108 |      47925.00 |             13
 2113 | 101 |      22500.00 |              5
 2114 | 108 |       7100.00 |             20
 2114 | 102 |      15000.00 |              6
 2117 | 106 |      31500.00 |              7
 2118 | 108 |       3608.00 |             17
 2120 | 102 |       3750.00 |              2
 2124 | 107 |       3082.00 |             11
(18 rows)

--6.-- El mateix que a la qüestió anterior, però ordenat per client i dintre de client per venedor.

 


-- 7.- Calcula les comandes (imports) totals per a cada venedor.

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


-- 8.- Quin és l'import promig de les comandes per cada venedor, les comandes dels quals sumen més de 30 000?


training=# SELECT rep,avg(importe) as "promig" from pedidos group by rep having sum(importe) >30000;
 rep |         promig         
-----+------------------------
 106 |     16479.000000000000
 105 |  7865.4000000000000000
 107 | 11477.3333333333333333
 108 |  8376.1428571428571429
(4 rows)


-- 9.- Per cada oficina amb 2 o més persones, calculeu la quota 
--total i les vendes totals per a tots els venedors que treballen a la oficina (volem que sorti la ciutat de l'oficina a la consulta) 

training=# SELECT oficina_rep, sum(cuota),sum(cuota),count(*)as "Numero treballadors"  from repventas GROUP BY oficina_rep HAVING count(oficina_rep)>=2;;
 oficina_rep |    sum    |    sum    | Numero treballadors 
-------------+-----------+-----------+---------------------
          21 | 700000.00 | 700000.00 |                   2
          11 | 575000.00 | 575000.00 |                   2
          12 | 775000.00 | 775000.00 |                   3
