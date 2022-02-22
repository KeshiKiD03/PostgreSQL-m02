1 ¿Quina es la quota mitjana y las vendes mitjanas de tots els empleats?

practica1=# SELECT avg(cuota) AS "quota_mitjana",avg(ventas) AS "venta_mitjana",num_empl   
FROM repventas
GROUP BY num_empl;
    quota_mitjana    |    venta_mitjana    | num_empl 
---------------------+---------------------+----------
 350000.000000000000 | 474050.000000000000 |      102
 275000.000000000000 | 299912.000000000000 |      106
 300000.000000000000 | 186042.000000000000 |      107
 350000.000000000000 | 361865.000000000000 |      108
 350000.000000000000 | 367911.000000000000 |      105
 300000.000000000000 | 392725.000000000000 |      109
 275000.000000000000 | 286775.000000000000 |      103
 300000.000000000000 | 305673.000000000000 |      101
                     |  75985.000000000000 |      110
 200000.000000000000 | 142594.000000000000 |      104
(10 rows)



2 Trobar l'import mitjà de comandes,l'import total de comandes i el preu mig de venda.

practica1=# SELECT avg(importe) AS "import_mitja", sum(importe) AS "import_total", avg(importe/cant) AS "preu_mitja"
FROM pedidos
;
     import_mitja      | import_total |      preu_mitja       
-----------------------+--------------+-----------------------
 8256.3666666666666667 |    247691.00 | 1056.9666666666666667
(1 row)

3 Trobar el preu mitjà dels productes del fabricant aci.

     preu_mitja       | id_fab | id_producto 
-----------------------+--------+-------------
 2750.0000000000000000 | aci    | 4100y
   55.0000000000000000 | aci    | 41001
  107.0000000000000000 | aci    | 41003
   25.0000000000000000 | aci    | 4100x
  117.0000000000000000 | aci    | 41004
 2500.0000000000000000 | aci    | 4100z
   76.0000000000000000 | aci    | 41002


4 Quin es l'import total de les comandes realizades per l'empleat amb identificador 105?

practica1=# SELECT sum(importe) AS "import_total",rep
FROM pedidos
WHERE rep= 105
;
 import_total | rep 
--------------+-----
     39327.00 | 105
(1 row)


5 Trobar la data en que es va realitzar la primera comando.

practica1=# SELECT fecha_pedido,num_pedido
FROM pedidos
ORDER BY fecha_pedido LIMIT 1;
 fecha_pedido | num_pedido 
--------------+------------
 1989-01-04   |     112993
(1 row)




6 Trobar quantes comandes hi ha de més 25000.

practica1=# SELECT count(*) AS "numero_de_comandes",importe
FROM pedidos
WHERE importe > 25000
practica1-# GROUP BY importe;
 numero_de_comandes | importe  
--------------------+----------
                  1 | 45000.00
                  1 | 27500.00
                  1 | 31500.00
                  1 | 31350.00
(4 rows)


7 Llistar quants empleats estan assignats a cada oficina, indicar el identificador doficina, i quants té assignats.

practica1=# SELECT count(*) AS "nombre_de_empleats",oficina_rep
FROM repventas
WHERE oficina_rep IS NOT NULL GROUP BY oficina_rep
;
 nombre_de_empleats | oficina_rep 
--------------------+-------------
                  3 |          12
                  2 |          21
                  2 |          11
                  1 |          13
                  1 |          22
(5 rows)


8 Per a cada empleat, identificador, import venut a cada client, identificador de client.

practica1=# SELECT count(*)rep,sum(importe),clie
practica1-# FROM pedidos
practica1-# GROUP BY rep,clie
 count | rep | importe  | clie 
-------+-----+----------+------
     1 | 106 |  1458.00 | 2101
     1 | 105 | 27500.00 | 2103
     1 | 107 | 31350.00 | 2109
     1 | 110 |   632.00 | 2107
     1 | 102 |  1896.00 | 2106
     1 | 105 |   702.00 | 2103
     1 | 103 |  2100.00 | 2111
     1 | 101 |  3978.00 | 2102
     1 | 105 |  3276.00 | 2103
     1 | 101 | 22500.00 | 2113
     1 | 102 |  2130.00 | 2106
     1 | 109 |  1480.00 | 2108
     1 | 102 |  3750.00 | 2120
     1 | 108 |  7100.00 | 2114
     1 | 108 |  1420.00 | 2118
     1 | 108 |   776.00 | 2118
     1 | 108 |   760.00 | 2118
     1 | 109 |  5625.00 | 2108
     1 | 107 |   652.00 | 2124
     1 | 102 | 15000.00 | 2114
     1 | 101 |   150.00 | 2108


9 Per a cada empleat on les comandes sumin més de 30000, trobar limport mitjà de cada comanda.

practica1=# SELECT count(*),rep,avg(importe) AS "import_mitja"
FROM pedidos
GROUP BY rep             
HAVING sum(importe) > 30000;
 count | rep |      import_mitja      
-------+-----+------------------------
     2 | 106 |     16479.000000000000
     3 | 107 | 11477.3333333333333333
     7 | 108 |  8376.1428571428571429
     5 | 105 |  7865.4000000000000000
(4 rows)


10 Quina quantitat doficines tenen empleats amb vendes superiors a la seva quota.

SELECT count(distinct oficina_rep) FROM repventas WHERE ventas > cuota
