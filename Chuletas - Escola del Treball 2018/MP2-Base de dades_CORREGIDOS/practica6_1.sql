Base de dades Practica 6_1
Nom: Fran Cuno

-- 1.- Quina és la comanda promig de cada venedor?
training=# SELECT avg(importe) AS"promig" , rep FROM pedidos GROUP BY rep, importe;
          avg           | rep 
------------------------+-----
   652.0000000000000000 | 107
  3745.0000000000000000 | 105
  3750.0000000000000000 | 102
   150.0000000000000000 | 101
     31500.000000000000 | 106
  5625.0000000000000000 | 109
 15000.0000000000000000 | 102
  2925.0000000000000000 | 108
   652.0000000000000000 | 108
   776.0000000000000000 | 108
     27500.000000000000 | 105
  2430.0000000000000000 | 107
   632.0000000000000000 | 110
   760.0000000000000000 | 108
   702.0000000000000000 | 105
  2130.0000000000000000 | 102
     22500.000000000000 | 101
   600.0000000000000000 | 103
     45000.000000000000 | 108
  2100.0000000000000000 | 103
  3978.0000000000000000 | 101
  1896.0000000000000000 | 102
  7100.0000000000000000 | 108
  1420.0000000000000000 | 108
  3276.0000000000000000 | 105
  4104.0000000000000000 | 105
     22500.000000000000 | 110
     31350.000000000000 | 107
  1458.0000000000000000 | 106
  1480.0000000000000000 | 109
(30 rows)

-- 2.- Quin és el rang de quotes asignades a cada oficina? ( es a dir, el mínim i el màxim)
training=# SELECT max(cuota),min(cuota),oficina_rep FROM repventas WHERE oficina_rep IS NOT NULL GROUP BY oficina_rep;
    max    |    min    | oficina_rep 
-----------+-----------+-------------
 300000.00 | 200000.00 |          12
 350000.00 | 350000.00 |          21
 300000.00 | 275000.00 |          11
 350000.00 | 350000.00 |          13
 300000.00 | 300000.00 |          22
(5 rows)

-- 3.- Quants venedors estan asignats a cada oficina?
training=# SELECT count(*),oficina_rep FROM repventas WHERE oficina_rep IS NOT NULL GROUP BY oficina_rep;
 count | oficina_rep 
-------+-------------
     3 |          12
     2 |          21
     2 |          11
     1 |          13
     1 |          22
(5 rows)


-- 4.- Quants clients són atesos per (tenen com a representant oficial a) cada cada venedor?
training=# SELECT count(*) AS "numero_clientes",rep_clie FROM clientes GROUP BY rep_clie;
 numero_clientes | rep_clie 
-----------------+----------
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

-- 5.- Calcula el total de l'import de les comandes per cada venedor i per cada client.
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

-- 6.- El mateix que a la qüestió anterior, però ordenat per client i dintre de client per venedor.
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

-- 7.- Calcula les comandes (imports) totals per a cada venedor.
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

-- 8.- Quin és l'import promig de les comandes per cada venedor, les comandes dels quals sumen més de 30 000?
training=# SELECT rep, avg(importe) FROM pedidos GROUP BY rep HAVING sum(importe) > 30000;
 rep |          avg           
-----+------------------------
 106 |     16479.000000000000
 105 |  7865.4000000000000000
 107 | 11477.3333333333333333
 108 |  8376.1428571428571429
(4 rows)

-- 9.- Per cada oficina amb 2 o més persones, calculeu la quota total i les vendes totals per a tots els venedors que treballen a la oficina (volem que sorti la ciutat de l'oficina a la consulta) 
training=# SELECT oficina_rep, sum(cuota),sum(ventas),count(*)as "Numero treballadors"  from repventas GROUP BY oficina_rep HAVING count(oficina_rep)>= 2;
 oficina_rep |    sum    |    sum    | Numero treballadors 
-------------+-----------+-----------+---------------------
          21 | 700000.00 | 835915.00 |                   2
          11 | 575000.00 | 692637.00 |                   2
          12 | 775000.00 | 735042.00 |                   3
(3 rows)
