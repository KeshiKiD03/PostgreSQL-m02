Base de dades Practica 6 (GROUP BY)
Nom: Fran Cuno

-- 1.- Quantes oficines tenim a cada regió amb un nom de ciutat que contingui una 'a'?
training=# SELECT ciudad, region, count(*) FROM oficinas WHERE ciudad ILIKE '%a%' GROUP BY ciudad, region;
 ciudad  | region | count 
---------+--------+-------
 Atlanta | Este   |     1
 Chicago | Este   |     1
(2 rows)

-- 2.- Quants representants de ventes amb un objectiu superior a 10000 hi ha a cada oficina ?
training=# SELECT count(*),oficina FROM oficinas WHERE objetivo > 10000 AND oficina IS NOT NULL GROUP BY oficina;
 count | oficina 
-------+---------
     1 |      13
     1 |      22
     1 |      21
     1 |      11
     1 |      12
(5 rows)

-- 3.- Per cada codi de fàbrica diferent, quants productes hi ha amb un preu superior a 50?
training=# SELECT id_fab, count(*) FROM productos WHERE precio>50 GROUP BY id_fab;
 id_fab | count 
--------+-------
 fea    |     2
 qsa    |     3
 imm    |     6
 aci    |     6
 rei    |     4
 bic    |     3
(6 rows)

-- 4.- Visualitza cada codi de fàbrica diferent amb més de 6 productes-
training=# SELECT id_fab, count(*) FROM productos GROUP BY id_fab HAVING count(*)>6;
 id_fab | count 
--------+-------
 aci    |     7
(1 row)

-- 5.- Per cada codi de producte diferent, a quantes fàbriques es fabrica?
training=# SELECT id_producto, count(*) FROM productos GROUP BY id_producto;
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

-- 6.- Quantes comades superiors a 10000 ha fet cada representant de ventes?
training=# SELECT count(*),rep FROM pedidos WHERE importe > 10000 GROUP BY rep;
 count | rep 
-------+-----
     1 | 102
     1 | 106
     1 | 107
     1 | 108
     1 | 105
     1 | 101
     1 | 110
(7 rows)

-- 7.- Quins codis de representant han fet comades amb un import total superior a 40000?
training=# SELECT sum(importe),rep FROM pedidos GROUP BY rep HAVING sum(importe) > 40000;
   sum    | rep 
----------+-----
 58633.00 | 108
(1 row)

-- 8.- Quins codis de representant han fet més de dues comandes?
training=# SELECT count(*),rep FROM pedidos GROUP BY rep HAVING count(*) > 2;
 count | rep 
-------+-----
     3 | 107
     4 | 102
     7 | 108
     5 | 105
     3 | 101
(5 rows)

-- 9.- Quins codis de representant han venut a més de 2 clients diferents?
training=# SELECT count(distinct clie), rep FROM pedidos GROUP BY rep HAVING count(distinct clie) > 2;
 count | rep 
-------+-----
     3 | 101
     3 | 102
     3 | 108
(3 rows)

-- 10.-  Quins codis de representant han venut productes de més d'una fàbrica?
training=# SELECT rep, count(distinct fab) FROM pedidos GROUP BY rep HAVING count(distinct fab) > 1;
 rep | count 
-----+-------
 101 |     2
 102 |     4
 103 |     2
 106 |     2
 107 |     3
 108 |     5
 109 |     2
 110 |     2
(8 rows)

-- 11.- Quins codis de representant han venut comandes de més de 6 unitats a més de 2 clients diferents ?
* training=# SELECT rep, count(distinct clie) from pedidos WHERE cant > 6 GROUP BY rep HAVING count(distinct clie)>2;
 rep | count 
-----+-------
 108 |     3
(1 row)

-- 12.- Quins codis de representant han fet més de 1 coamanda amb un 'import superior a 2000?
training=# SELECT count(*),rep FROM pedidos WHERE importe > 2000 GROUP BY rep HAVING count(*) > 1;
 count | rep 
-------+-----
     2 | 107
     3 | 108
     2 | 101
     3 | 102
     4 | 105
(5 rows)








