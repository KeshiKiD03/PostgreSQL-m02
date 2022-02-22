-- 1. Quantes comandes s'han fet, quina és la suma total dels imports d'aquestes comandes i quina és la mitjana de l'import de 
-- la comada : les comandes amb una quantitat d'entre 20 i 30 productes i de les fàbriques que continguin una 'i' o una 'a'.

training=# SELECT sum(importe), avg(importe), count(*) FROM pedidos WHERE cant >= 20 AND cant <= 30 AND (fab LIKE 'i%' OR fab 
LIKE '%a%');
   sum    |          avg           | count 
----------+------------------------+-------
 42326.00 | 10581.5000000000000000 |     4
(1 row)

-- 2. De quina fàbrica s'han venut menys unitats de producte (alerta : no menys comandes, menys unitats)
training=# SELECT sum(cant) FROM pedidos GROUP BY fab ORDER BY 1 ASC LIMIT 1;
 sum 
-----
   2
(1 row)

-- 3. Quins són els 3 venedors que han fet més comandes?
training=# SELECT rep, count(num_pedido) FROM pedidos GROUP BY rep ORDER BY count(num_pedido) DESC LIMIT 3;
 rep | count 
-----+-------
 108 |     7
 105 |     5
 102 |     4
(3 rows)

-- 4. Mostra quants clients amb un nom que contingui 2 espais en blanc té assignat cada venedor.
training=# SELECT count(num_clie), empresa, rep_clie FROM clientes WHERE empresa LIKE '% % %' GROUP BY empresa, rep_clie;
 count |     empresa      | rep_clie 
-------+------------------+----------
     1 | Carter & Sons    |      102
     1 | Fred Lewis Corp. |      102
     1 | Ian & Schmidt    |      104
     1 | Holm & Landis    |      109
(4 rows)

training=# SELECT count(num_clie), rep_clie FROM clientes WHERE empresa LIKE '% % %' GROUP BY rep_clie; 
 count | rep_clie 
-------+----------
     1 |      109
     1 |      104
     2 |      102
(3 rows)

-- 5. Mostra quantes comandes ha fet cada venedor a cada client que tingui un codi múltiple de 5 o múltiple de 3 i, a més a més, que el codi de client no sigui ni el 110 ni el 102.
training=# SELECT rep, clie, count(num_pedido) FROM pedidos WHERE (clie % 5=0 OR clie % 3=0) AND rep != 102 AND rep != 110 GROUP BY rep, clie;
 rep | clie | count 
-----+------+-------
 107 | 2109 |     1
 108 | 2118 |     4
 107 | 2124 |     2
 108 | 2112 |     2
 105 | 2103 |     4
(5 rows)


-- 6. Quin és el producte amb el qual s'ha facturat més diners?
training=# SELECT fab, producto, sum(importe) FROM pedidos GROUP BY fab, producto ORDER BY 3 DESC LIMIT 1;
 fab | producto |   sum    
-----+----------+----------
 rei | 2a44r    | 67500.00
(1 row)

codi producte (identificiar) fab + producto

-- 7. Quins codis de venedor han fet més d'una comanda al mateix client?
training=# SELECT rep, clie, count(*) FROM pedidos GROUP BY rep, clie HAVING count(*) > 1;
 rep | clie | count 
-----+------+-------
 108 | 2112 |     2
 105 | 2103 |     4
 103 | 2111 |     2
 110 | 2107 |     2
 102 | 2106 |     2
 109 | 2108 |     2
 108 | 2118 |     4
 107 | 2124 |     2
(8 rows)

-- 8. Quins són els  id_producto de la taula productos que es fabriquen a més d'una fàbrica?
training=# SELECT id_producto, count(distinct id_fab) FROM productos GROUP BY id_producto HAVING count(distinct id_fab) > 1;
 id_producto | count 
-------------+-------
 41003       |     2
(1 row)


