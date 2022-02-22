1-- ¿Quina es la quota mitjana y las vendes mitjanas de tots els empleats?

training=# SELECT avg(cuota), avg(ventas), num_empl FROM repventas GROUP BY num_empl;
         avg         |         avg         | num_empl 
---------------------+---------------------+----------
 275000.000000000000 | 299912.000000000000 |      106
 300000.000000000000 | 305673.000000000000 |      101
 300000.000000000000 | 392725.000000000000 |      109
 200000.000000000000 | 142594.000000000000 |      104
 350000.000000000000 | 474050.000000000000 |      102
 300000.000000000000 | 186042.000000000000 |      107
 350000.000000000000 | 361865.000000000000 |      108
                     |  75985.000000000000 |      110
 275000.000000000000 | 286775.000000000000 |      103
 350000.000000000000 | 367911.000000000000 |      105
(10 rows)




2-- Trobar l'import mitjà de comandes,l'import total de comandes i el preu mig de venda.

training=# SELECT avg(importe) AS "Import mitja comandes", sum(importe) AS "Import Total", avg(importe/cant) AS "Preu mig Venta" FROM pedidos;
 Import mitja comandes | Import Total |    Preu mig Venta     
-----------------------+--------------+-----------------------
 8256.3666666666666667 |    247691.00 | 1056.9666666666666667
(1 row)


3-- Trobar el preu mitjà dels productes del fabricant aci.

training=# SELECT avg(importe/cant), fab FROM pedidos WHERE fab = 'aci' GROUP BY fab;
         avg          | fab 
----------------------+-----
 741.8181818181818182 | aci
(1 row)


4-- Quin es l'import total de les comandes realizades per l'empleat amb identificador 105?

training=# SELECT sum(importe), rep FROM pedidos WHERE rep = 105 GROUP BY rep;
   sum    | rep 
----------+-----
 39327.00 | 105
(1 row)


5-- Trobar la data en que es va realitzar la primera comando.

training=# SELECT fecha_pedido FROM pedidos ORDER BY fecha_pedido ASC LIMIT 1;
 fecha_pedido 
--------------
 1989-01-04
(1 row)

training=# SELECT min(fecha_pedido) FROM pedidos;
    min     
------------
 1989-01-04
(1 row)

6-- Trobar quantes comandes hi ha de més 25000.

training=# SELECT count(*) AS "Cantidad de comandas" FROM pedidos WHERE importe >= 25000;
 Cantidad de comandas 
----------------------
                    4
(1 row)


7-- Llistar quants empleats estan assignats a cada oficina, indicar el identificador d'oficina, i quants té assignats.

training=# SELECT count(num_empl), oficina_rep FROM repventas WHERE oficina_rep IS NOT NULL GROUP BY oficina_rep;
 count | oficina_rep 
-------+-------------
     1 |          13
     1 |          22
     2 |          21
     2 |          11
     3 |          12
(5 rows)


8-- Per a cada empleat, identificador, import venut a cada client, identificador de client.

training=# SELECT rep, sum(importe), clie FROM pedidos GROUP BY rep, clie ORDER BY rep, clie ASC;
 rep |   sum    | clie 
-----+----------+------
 101 |  3978.00 | 2102
 101 |   150.00 | 2108
 101 | 22500.00 | 2113
 102 |  4026.00 | 2106
 102 | 15000.00 | 2114
 102 |  3750.00 | 2120
 103 |  2700.00 | 2111
 105 | 35582.00 | 2103
 105 |  3745.00 | 2111
 106 |  1458.00 | 2101
 106 | 31500.00 | 2117
 107 | 31350.00 | 2109
 107 |  3082.00 | 2124
 108 | 47925.00 | 2112
 108 |  7100.00 | 2114
 108 |  3608.00 | 2118
 109 |  7105.00 | 2108
 110 | 23132.00 | 2107
(18 rows)


9-- Per a cada empleat on les comandes sumin més de 30000, trobar l'import mitjà de cada comanda.

training=# SELECT rep, sum(importe), avg(importe) FROM pedidos GROUP BY rep HAVING sum(importe) > 30000;
 rep |   sum    |          avg           
-----+----------+------------------------
 106 | 32958.00 |     16479.000000000000
 105 | 39327.00 |  7865.4000000000000000
 107 | 34432.00 | 11477.3333333333333333
 108 | 58633.00 |  8376.1428571428571429
(4 rows)


10-- Quina quantitat d'oficines tenen empleats amb vendes superiors a la seva quota.

training=# SELECT COUNT(DISTINCT oficina_rep) FROM repventas WHERE ventas > cuota;
 count 
-------
     4
(1 row)
