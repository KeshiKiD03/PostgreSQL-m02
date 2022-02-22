Base de dades Practica 4
# !/usr/bin/python
# -*-coding: utf-8-*-
#Nom: AARON ANDAL

-- 1. Fabricant, número i import de les comandes que el seu import oscil·li entre 10000 i 39999, i ordenat per fabricant de forma 
-- ascendent i pel número descendent.
training=# SELECT fab, num_pedido, importe FROM pedidos WHERE (importe >= 10000 AND importe <= 39999) ORDER BY fab ASC ,num_pedido DESC;
 fab | num_pedido | importe  
-----+------------+----------
 aci |     112987 | 27500.00
 aci |     112979 | 15000.00
 aci |     110036 | 22500.00
 imm |     113069 | 31350.00
 rei |     113042 | 22500.00
 rei |     112961 | 31500.00
(6 rows)

-- 2. Identificador i nom dels venedors, amb l'identificador de l'oficina d'aquells venedors que tenen una oficina assignada.
training=# SELECT num_empl, nombre, oficina_rep FROM repventas WHERE oficina_rep IS NOT NULL;
 num_empl |    nombre     | oficina_rep 
----------+---------------+-------------
      105 | Bill Adams    |          13
      109 | Mary Jones    |          11
      102 | Sue Smith     |          21
      106 | Sam Clark     |          11
      104 | Bob Smith     |          12
      101 | Dan Roberts   |          12
      108 | Larry Fitch   |          21
      103 | Paul Cruz     |          12
      107 | Nancy Angelli |          22
(9 rows)

-- 3. Trobar la data en que es va realitzar la primera i la última comanda.
training=# SELECT max(fecha_pedido) AS "Primer pedido", min(fecha_pedido) AS "Ultim pedido" FROM pedidos;
 Primer pedido | Ultim pedido 
---------------+--------------
 1990-03-02    | 1989-01-04
(1 row)

-- 4. Llistar quants empleats estan assignats a cada oficina, indicar el identificador d'oficina, i quants té assignats, no s'han 
-- de mostrar els nulls.
training=# SELECT oficina_rep, count(*) FROM repventas WHERE oficina_rep IS NOT NULL GROUP BY oficina_rep;
 oficina_rep | count 
-------------+-------
          13 |     1
          22 |     1
          21 |     2
          11 |     2
          12 |     3
(5 rows)

-- 5. Per a cada empleat que tingui més d'una comanda a algún client que sumi més de 2000, trobar la mitja per a cada empleat i 
-- client.

-- 6. Trobar el fabricant, producte i preu dels productes on el seu identificador comenci i acabi per 4.
training=# SELECT id_fab, id_producto, precio FROM productos WHERE id_producto LIKE '%4%';
 id_fab | id_producto | precio 
--------+-------------+--------
 aci    | 41004       | 117.00
(1 row)


-- 7. Trobar el fabricant, producte i preu dels productes amb un preu superior a 100 i unes existemcias menors de 10. i mostralo 
-- ordenat per fabricant en ordre descencent, i per id_producte de forma ascendent.
training=# SELECT id_fab, id_producto, descripcion, precio FROM productos WHERE precio>100 AND existencias<10 ORDER BY id_fab DESC, id_producto;
 id_fab | id_producto | descripcion  | precio  
--------+-------------+--------------+---------
 imm    | 775c        | Riostra 1-Tm | 1425.00
 imm    | 779c        | Riostra 2-Tm | 1875.00
 bic    | 41003       | Manivela     |  652.00
 bic    | 41672       | Plate        |  180.00
(4 rows)

-- 8. Identificador fabricant, producte i descripció dels productes amb un preu superior a 1000 i siguin del fabricant amb 
-- identificador rei o les existències siguin superiors a 20.
training=# SELECT id_fab, id_producto, descripcion FROM productos WHERE precio > 1000 AND (id_fab = 'rei' OR existencias > 20);
 id_fab | id_producto |  descripcion   
--------+-------------+----------------
 aci    | 4100y       | Extractor
 rei    | 2a44l       | Bisagra Izqda.
 aci    | 4100z       | Montador
 rei    | 2a44r       | Bisagra Dcha.
(4 rows)

-- 9. Identificador i ciutat de les oficines de la regió est amb unes vendes inferiors a 700000 o de la regió oest amb unes vendes 
-- inferiors a 600000.
training=# SELECT oficina, ciudad FROM oficinas WHERE region='Este' AND ventas<700000 OR region='Oeste' AND ventas<600000;
 oficina |  ciudad  
---------+----------
      22 | Denver
      11 | New York
      13 | Atlanta
(3 rows)

-- 10. Identificador del fabricant, identificació i descripció dels productes on l'identificador del fabricant és "rei" o el preu 
-- és menor a 500.
training=# SELECT id_fab, id_producto, descripcion FROM productos WHERE id_fab LIKE 'rei' OR precio < 500;
 id_fab | id_producto |    descripcion    
--------+-------------+-------------------
 rei    | 2a45c       | V Stago Trinquete
 qsa    | xk47        | Reductor
 bic    | 41672       | Plate
 aci    | 41003       | Articulo Tipo 3
 aci    | 41004       | Articulo Tipo 4
 imm    | 887p        | Perno Riostra
 qsa    | xk48        | Reductor
 rei    | 2a44l       | Bisagra Izqda.
 fea    | 112         | Cubierta
 imm    | 887h        | Soporte Riostra
 bic    | 41089       | Retn
 aci    | 41001       | Articulo Tipo 1
 qsa    | xk48a       | Reductor
 aci    | 41002       | Articulo Tipo 2
 rei    | 2a44r       | Bisagra Dcha.
 aci    | 4100x       | Ajustador
 fea    | 114         | Bancada Motor
 imm    | 887x        | Retenedor Riostra
 rei    | 2a44g       | Pasador Bisagra
(19 rows)

-- 11. Identificador dels clients que el seu nom no conté " Corp." o " Inc." amb crèdit major a 30000.
training=# SELECT num_clie FROM clientes WHERE NOT (empresa LIKE '%Corp.%' OR  empresa LIKE '%Inc.%') AND limite_credito > 30000;
 num_clie |      empresa      | limite_credito 
----------+-------------------+----------------
     2103 | Acme Mfg.         |       50000.00
     2123 | Carter & Sons     |       40000.00
     2107 | Ace International |       35000.00
     2101 | Jones Mfg.        |       65000.00
     2112 | Zetacorp          |       50000.00
     2121 | QMA Assoc.        |       45000.00
     2124 | Peter Brothers    |       40000.00
     2108 | Holm & Landis     |       55000.00
     2117 | J.P. Sinclair     |       35000.00
     2120 | Rico Enterprises  |       50000.00
     2118 | Midwest Systems   |       60000.00
     2105 | AAA Investments   |       45000.00
(12 rows)

-- 12. Identificador i mitja d'edad per a cada oficina.
training=# SELECT oficina_rep, edad FROM repventas order by oficina_rep;
 oficina_rep | edad 
-------------+------
          11 |   31
          11 |   52
          12 |   45
          12 |   29
          12 |   33
          13 |   37
          21 |   62
          21 |   48
          22 |   49
             |   41
(10 rows)

training=# SELECT oficina_rep, avg(edad)  FROM repventas GROUP BY oficina_rep;
 oficina_rep |         avg         
-------------+---------------------
             | 41.0000000000000000
          13 | 37.0000000000000000
          22 | 49.0000000000000000
          21 | 55.0000000000000000
          11 | 41.5000000000000000
          12 | 35.6666666666666667
(6 rows)

-- 13. Regió i diferència entre la mitjana aritmètica dels objectius i la de les vendes, per a cada regió.
training=# SELECT region, avg(objetivo) - avg(ventas) AS "media" FROM oficinas GROUP BY region;
 region |        media        
--------+---------------------
 Este   | -23530.000000000000
 Oeste  |   1521.500000000000
(2 rows)

-- 14. Trobar l'import mitjà de comandes,l'import total de comandes i el preu mig de venda.
training=# SELECT avg(importe) AS "Import mitja comandes", sum(importe) AS "Import Total", avg(importe/cant) AS "Preu mig Venta" 
FROM pedidos;
 Import mitja comandes | Import Total |    Preu mig Venta     
-----------------------+--------------+-----------------------
 8256.3666666666666667 |    247691.00 | 1056.9666666666666667
(1 row)

-- Per saber el preu es te que dividir el camp "importe" i el camp "cant"
-- 15. Ciutat oficines i diferència entre vendes i objectius ordenada per aquesta diferència. 
training=# SELECT ciudad, ventas-objetivo AS "Diferencia", objetivo FROM oficinas ORDER BY 2;
   ciudad    | Diferencia | objetivo  
-------------+------------+-----------
 Denver      | -113958.00 | 300000.00
 Chicago     |  -64958.00 | 800000.00
 Atlanta     |   17911.00 | 350000.00
 Los Angeles |  110915.00 | 725000.00
 New York    |  117637.00 | 575000.00
(5 rows)

-- 16. Número comanda, data comanda, codi fabricant, codi producte i import comandes per comandes entre els dies '1989-09-1' i 
-- '1989-12-31'.

training=# SELECT num_pedido, fecha_pedido, fab, producto, importe FROM pedidos WHERE fecha_pedido BETWEEN '1989-09-1' AND '1989-12-31';
 num_pedido | fecha_pedido | fab | producto | importe  
------------+--------------+-----+----------+----------
     112961 | 1989-12-17   | rei | 2a44l    | 31500.00
     112968 | 1989-10-12   | aci | 41004    |  3978.00
     112963 | 1989-12-17   | aci | 41004    |  3276.00
     112983 | 1989-12-27   | aci | 41004    |   702.00
     112979 | 1989-10-12   | aci | 4100z    | 15000.00
     112992 | 1989-11-04   | aci | 41002    |   760.00
     112975 | 1989-12-12   | rei | 2a44g    |  2100.00
     112987 | 1989-12-31   | aci | 4100y    | 27500.00
(8 rows)


-- 17. Ciutat oficines, regions i diferència entre vendes i objectius ordenades per regió i per diferència entre vendes i 
-- objectius de major a menor. 

training=# SELECT ciudad, oficina, region, ventas-objetivo AS "Diferencia" FROM oficinas ORDER BY region, objetivo DESC;
   ciudad    | oficina | region | Diferencia 
-------------+---------+--------+------------
 Chicago     |      12 | Este   |  -64958.00
 New York    |      11 | Este   |  117637.00
 Atlanta     |      13 | Este   |   17911.00
 Los Angeles |      21 | Oeste  |  110915.00
 Denver      |      22 | Oeste  | -113958.00
(5 rows)


-- 18. Número total de comandes.

training=# SELECT num_pedido, count(*) FROM pedidos GROUP BY num_pedido;
 num_pedido | count 
------------+-------
     112989 |     1
     113003 |     1
     113013 |     1
     113048 |     1
     113065 |     1
     112993 |     1
     113057 |     1
     112987 |     1
     113042 |     1
     113007 |     1
     113069 |     1
     110036 |     1
     112997 |     1
     112983 |     1
     113027 |     1
     113012 |     1
     113051 |     1
     112968 |     1
     112992 |     1
     112979 |     1
     113034 |   

-- 19. Nom i data de contracte dels empleats que les seves vendes siguin superiors a 200000 i mostrar ordenat per contracte de més 
-- nou a més vell.

training=# SELECT nombre, contrato FROM repventas WHERE ventas > 200000 ORDER BY contrato DESC;
   nombre    |  contrato  
-------------+------------
 Larry Fitch | 1989-10-12
 Mary Jones  | 1989-10-12
 Sam Clark   | 1988-06-14
 Bill Adams  | 1988-02-12
 Paul Cruz   | 1987-03-01
 Sue Smith   | 1986-12-10
 Dan Roberts | 1986-10-20
(7 rows)


-- 20. Codi i nom de les tres ciutats que tinguin unes vendes superiors. 

training=# SELECT oficina, ciudad FROM oficinas ORDER BY ventas LIMIT 3 OFFSET 1;
 oficina |  ciudad  
---------+----------
      13 | Atlanta
      11 | New York
      12 | Chicago
(3 rows)
