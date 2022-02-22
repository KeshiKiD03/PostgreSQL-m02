-- 1.- Quina és la comanda promig de cada venedor?

practica1=# SELECT DISTINCT AVG(importe),rep
practica1-# FROM pedidos
practica1-# GROUP BY rep;
 
-- 2.- Quin és el rang de quotes asignades a cada oficina? ( es a dir, el mínim i el màxim)

practica1=# SELECT max(cuota),min(cuota),oficina_rep
FROM repventas
WHERE oficina_rep IS NOT NULL
GROUP BY oficina_rep;
    max    |    min    | oficina_rep 
-----------+-----------+-------------
 300000.00 | 200000.00 |          12
 350000.00 | 350000.00 |          21
 300000.00 | 275000.00 |          11
 350000.00 | 350000.00 |          13
 300000.00 | 300000.00 |          22
(5 rows)

-- 3.- Quants venedors estan asignats a cada oficina?

practica1=# SELECT count(*),oficina_rep
FROM repventas
WHERE oficina_rep IS NOT NULL
GROUP BY oficina_rep;
 count | oficina_rep 
-------+-------------
     3 |          12
     2 |          21
     2 |          11
     1 |          13
     1 |          22
(5 rows)


-- 4.- Quants clients són atesos per (tenen com a representant oficial a) cada cada venedor?

practica1=# SELECT count(*),rep_clie
FROM clientes
GROUP BY rep_clie;
 count | rep_clie 
-------+----------
     2 |      106
     1 |      107
     1 |      104
     4 |      102
     2 |      108
     2 |      105
     2 |      109
     3 |      103
     3 |      101
     1 |      110
(10 rows)

-- 5.- Calcula el total de l'import de les comandes per cada venedor i per cada client.
practica1=# SELECT sum(importe),rep,clie
FROM pedidos
GROUP BY rep,clie;
   sum    | rep | clie 
----------+-----+------
  7105.00 | 109 | 2108
 23132.00 | 110 | 2107
 31500.00 | 106 | 2117
  3750.00 | 102 | 2120
  4026.00 | 102 | 2106
 47925.00 | 108 | 2112
  3608.00 | 108 | 2118
 31350.00 | 107 | 2109
  3745.00 | 105 | 2111
  3978.00 | 101 | 2102
 35582.00 | 105 | 2103
  7100.00 | 108 | 2114
  2700.00 | 103 | 2111
  3082.00 | 107 | 2124
   150.00 | 101 | 2108
 22500.00 | 101 | 2113
 15000.00 | 102 | 2114
  1458.00 | 106 | 2101
(18 rows)



-- 6.- El mateix que a la qüestió anterior, però ordenat per client i dintre de client per venedor.

practica1=# SELECT sum(importe),clie,rep
FROM pedidos 
GROUP BY clie ,rep;
   sum    | clie | rep 
----------+------+-----
  3745.00 | 2111 | 105
  3082.00 | 2124 | 107
  2700.00 | 2111 | 103
 22500.00 | 2113 | 101
   150.00 | 2108 | 101
  3750.00 | 2120 | 102
  4026.00 | 2106 | 102
 31500.00 | 2117 | 106
 35582.00 | 2103 | 105
  7105.00 | 2108 | 109
 15000.00 | 2114 | 102
 31350.00 | 2109 | 107
  7100.00 | 2114 | 108
 23132.00 | 2107 | 110
  1458.00 | 2101 | 106
  3608.00 | 2118 | 108
  3978.00 | 2102 | 101
 47925.00 | 2112 | 108
(18 rows)


-- 7.- Calcula les comandes (imports) totals per a cada venedor.
practica1=# SELECT sum(importe),rep
practica1-# FROM pedidos
practica1-# GROUP BY rep;
   sum    | rep 
----------+-----
 32958.00 | 106
 34432.00 | 107
 22776.00 | 102
 58633.00 | 108
 39327.00 | 105
  7105.00 | 109
  2700.00 | 103
 26628.00 | 101
 23132.00 | 110
(9 rows)

-- 8.- Quin és l'import promig de les comandes per cada venedor, les comandes dels quals sumen més de 30 000?

practica1=# SELECT DISTINCT avg(importe),rep
FROM pedidos
GROUP BY rep
HAVING sum(importe) > 30000;
          avg           | rep 
------------------------+-----
 11477.3333333333333333 | 107
  7865.4000000000000000 | 105
     16479.000000000000 | 106
  8376.1428571428571429 | 108
(4 rows)



-- 9.- Per cada oficina amb 2 o més persones, calculeu la quota 

practica1=# SELECT count(*),oficina_rep,cuota
FROM repventas 
GROUP BY oficina_rep,cuota
HAVING count(*) >= 2;
 
 count | oficina_rep |   cuota   
-------+-------------+-----------
     2 |          21 | 350000.00
(1 row)
