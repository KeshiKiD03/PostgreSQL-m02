-- 1.- Quantes oficines tenim a cada regió amb un nom de ciutat que contingui una 'a'?
practica1=# SELECT count(*),region
FROM oficinas
WHERE ciudad ILIKE '%a%'
GROUP BY region;
 count | region 
-------+--------
     2 | Este
     1 | Oeste
(2 rows)


-- 2.- Quants representants de ventes amb un objectiu superior a 10000 hi ha a cada oficina ?

practica1=# SELECT count(*),oficina
practica1-# FROM oficinas
practica1-# WHERE objetivo > 10000 AND oficina IS NOT NULL
practica1-# GROUP BY oficina;
 count | oficina 
-------+---------
     1 |      22
     1 |      11
     1 |      21
     1 |      12
     1 |      13
(5 rows)


-- 3.- Per cada codi de fàbrica diferent, quants productes hi ha amb un preu superior a 50?

practica1=# SELECT count(*),id_producto
practica1-# FROM productos
practica1-# WHERE precio > 50
practica1-# GROUP BY id_producto;
 count | id_producto 
-------+-------------
     1 | 887p 
     1 | 2a44r
     1 | 773c 
     1 | 41004
     1 | xk48a
     1 | 114  
     1 | 779c 
     1 | 887h 
     1 | 112  
     1 | 4100z

-- 4.- Visualitza cada codi de fàbrica diferent amb més de 6 productes-
select id_fab,count(*) from productos group by id_fab having coun
-- 5.- Per cada codi de producte diferent, a quantes fàbriques es fabrica?

practica1=# SELECT count(id_fab),id_producto
practica1-# FROM productos
practica1-# GROUP BY id_producto;
 count | id_producto 
-------+-------------
     1 | 887p 
     1 | 2a44r
     1 | 773c 
     1 | 41004
     1 | xk48a
     1 | 114  
     1 | 779c 
     1 | 887h 
     1 | 112  
     1 | 4100z
     1 | xk47 
     1 | 775c 
     1 | xk48 
     1 | 41672
     1 | 2a45c
     1 | 41089
     1 | 887x 
     1 | 2a44g
     1 | 2a44l
     1 | 41002
     2 | 41003
--More--


-- 6.- Quantes comades superiors a 10000 ha fet cada representant de ventes?

practica1=# SELECT count(*),rep
FROM pedidos
WHERE importe > 10000 GROUP BY rep
practica1-# ;
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

practica1=# 

-- 7.- Quins codis de representant han fet comades amb un import total superior a 40000?

practica1=# SELECT sum(importe),rep
FROM pedidos
GROUP BY rep
HAVING sum(importe) >= 40000;
   sum    | rep 
----------+-----
 58633.00 | 108
(1 row)

-- 8.- Quins codis de representant han fet més de dues comandes?

practica1=# SELECT count(*),rep
practica1-# FROM pedidos
practica1-# GROUP BY rep
practica1-# HAVING count(*) > 2;
 count | rep 
-------+-----
     3 | 107
     4 | 102
     7 | 108
     5 | 105
     3 | 101
(5 rows)

practica1=# 

-- 9.- Quins codis de representant han venut a més de 2 clients diferents?

SELECT count(distinct clie

-- 10.-  Quins codis de representant han venut productes de més d'una fàbrica?

practica1=# SELECT count(distinc fab),rep
FRsOM pedidos
GROUP BY rep
HAVING count(distinct fab) > 1;
 count | rep 
-------+-----
     2 | 106
     3 | 107
     4 | 102
     7 | 108
     5 | 105
     2 | 109
     2 | 103
     3 | 101
     2 | 110
(9 rows)



-- 11.- Quins codis de representant han venut comandes de més de 6 unitats a més de 2 clients diferents ?

practica1=# SELECT count(DISTINCT clie),rep
FROM pedidos 
GROUP BY rep
WHERE cant > 6
practica1-# HAVING  count(clie) > 2;

-- 12.- Quins codis de representant han fet més de 1 coamanda amb un 'import superior a 2000?


practica1=# SELECT count(*),rep 
FROM pedidos
WHERE importe > 2000
practica1-# GROUP BY rep
practica1-# HAVING count(*) > 1;
 count | rep 
-------+-----
     3 | 102
     2 | 107
     3 | 108
     4 | 105
     2 | 101
(5 rows)


