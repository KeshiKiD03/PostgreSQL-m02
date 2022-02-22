-- 1.- Quantes oficines tenim a cada regió?

training=# SELECT count(*) oficina,region
FROM oficinas
GROUP BY region;
 oficina | region 
---------+--------
       3 | Este
       2 | Oeste
(2 rows)



-- 2.- Quants representants de ventes hi ha a cada oficina?
training=# SELECT count(*)num_empl AS "numero_empleats",oficina_rep
training-# FROM repventas
training-# WHERE oficina_rep IS NOT NULL GROUP BY oficina_rep;
 numero empleados | oficina_rep 
----------+-------------
        3 |          12
        2 |          21
        2 |          11
        1 |          13
        1 |          22
(5 rows)


-- 3.- Quants representants de ventes té assignats cada cap de respresentants?

training=# SELECT count(*)num_empl,director
FROM repventas
WHERE director IS NOT NULL  GROUP BY director;
 num_empl | director 
----------+----------
        3 |      106
        2 |      108
        1 |      101
        3 |      104
(4 rows)


-- 4.- Quina és, per cada oficina, la suma de les quotes dels seus representants? I la mitjana de les quotes per oficina?

SELECT sum(cuota) AS "suma_quota",avg(cuota) AS "mitja_quota",oficina_rep
FROM repventas
WHERE oficina_rep IS NOT NULL GROUP BY suma_quota,mitja_quota,oficina_rep

-- 5.- Quin és el representant que té la quota més alta de cada oficina?



  
   
-- 6.- Quants clients representa cada venedor-repventas?

training=# SELECT count(*)num_clie,rep_clie
training-# FROM clientes
training-# GROUP BY rep_clie;

 num_clie | rep_clie 
----------+----------
        2 |      106
        1 |      107
        1 |      104
        4 |      102
        2 |      108
        2 |      105
--More--



-- 7.- Quin és el client de cada  venedor-repventas amb el límit de crèdit més alt?

training=# SELECT rep_clie,max(limite_credito)
training-# FROM clientes
training-# GROUP BY num_clie ORDER BY limite_credito desc;
 num_clie | rep_clie 
----------+----------
     2106 |      102
     2102 |      101
     2101 |      106
     2118 |      108
     2108 |      109
     2103 |      105

-- 8.- Per cada codi de fàbrica diferents, quants productes hi ha?

painting=# select count(*),id_fab from productos group by id_fab;
 count | id_fab 
-------+--------
     7 | aci
     3 | qsa
     3 | bic
     6 | imm
     2 | fea
     4 | rei

-- 9.- Per cada codi de producte diferent, a quantes fàbriques es fabrica?

painting=# select count(*),id_producto from productos group by id_producto;
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
     1 | 41002q
     2 | 41003

-- 10.- Per cada nom de producte diferent, quants codis (if_fab + id_prod) tenim?
-- 11.- Per cada producte (if_fab + id_prod), quantes comandes tenim?
 count | producto 
-------+----------
     2 | 2a44r
     1 | 773c 
     3 | 41004
     2 | 114  

-- 12.- Per cada client, quantes comandes tenim?
 count | clie 
-------+------
     1 | 2102
     1 | 2117
     2 | 2112
     4 | 2118

-- 13.- Quantes comandes ha realitzat cada representant de vendes?

painting=# SELECT count(*),num_empl
painting-# FROM repventas
painting-# GROUP BY num_empl;
 count | num_empl 
-------+----------
     1 |      102
     1 |      106
     1 |      107
     1 |      108
painting=# 

-- 14.- Quina és la comanda promig de cada venedor?

painting=# SELECT DISTINCT rep,avg(cant)
FROM pedidos
GROUP BY rep;
 rep |         avg         
-----+---------------------
 107 | 11.0000000000000000
 110 |  8.5000000000000000
 105 | 26.8000000000000000
 101 | 15.0000000000000000
--More--



-- 15.- Quin és el rang de quotes asignades a cada oficina? ( es a dir, el mínim i el màxim)
select count(*),max(cuota),min(cuota)
from repventas
GROUP BY max(cuota),min(cuota);


-- 16.- Quants venedors estan asignats a cada oficina?
painting=# SELECT count(*),oficina_rep
FROM repventas
GROUP BY oficina_rep;
 count | oficina_rep 
-------+-------------
     1 |            
     3 |          12
     2 |          21
     2 |          11
painting=# SELECT count(*),oficina_rep
FROM repventas
WHERE oficina_rep IS NOT NULL ORDER BY oficina_rep;
ERROR:  column "repventas.oficina_rep" must appear in the GROUP BY clause or be used in an aggregate function
LINE 1: SELECT count(*),oficina_rep



      painting=# SELECT count(*),oficina_rep
FROM repventas
WHERE oficina_rep IS NOT NULL GROUP BY oficina_rep;
 count | oficina_rep 
-------+-------------
     3 |          12
     2 |          21
     2 |          11
     1 |          13
                  ^






-- 17.- Quants clients són atesos per (tenen com a representant oficial a) cada cada venedor?

painting=# SELECT count(*) AS "numero_clientes",rep_clie FROM clientes GROUP BY rep_clie;
 numero_clientes | rep_clie 
-----------------+----------
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


-- 18.- Calcula el total de l'import de les comandes per cada venedor i per cada client.

painting=# SELECT sum(importe),clie,rep
FROM pedidos
GROUP BY rep,clie ORDER BY clie;
   sum    | clie | rep 
----------+------+-----
  7105.00 | 2108 | 109
 23132.00 | 2107 | 110
 31500.00 | 2117 | 106
  3750.00 | 2120 | 102
  4026.00 | 2106 | 102
 47925.00 | 2112 | 108
  3608.00 | 2118 | 108
 31350.00 | 2109 | 107
  3745.00 | 2111 | 105
  3978.00 | 2102 | 101
 35582.00 | 2103 | 105


-- 19.- El mateix que a la qüestió anterior, però ordenat per client i dintre de client per venedor.

practica1=# SELECT sum(importe),clie,rep
practica1-# FROM pedidos
practica1-# GROUP BY clie,rep;
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

-- 20.- Calcula les comandes (imports) totals per a cada venedor.
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


-- 21.- Quin és l'import promig de les comandes per cada venedor, les comandes dels quals sumen més de 30 000?

practica1=# SELECT  avg(importe),rep
practica1-# FROM pedidos
practica1-# GROUP BY rep
practica1-# HAVING sum(importe) > 30000;
          avg           | rep 
------------------------+-----
 11477.3333333333333333 | 107
  7865.4000000000000000 | 105
     16479.000000000000 | 106
  8376.1428571428571429 | 108
(4 rows)




-- 22.- Per cada oficina amb 2 o més persones, calculeu la quota

practica1=# SELECT  count(*),oficina_rep,cuota
FROM repventas
WHERE oficina_rep IS NOT NULL GROUP BY oficina_rep,cuota
HAVING count (*)>=2;
 count | oficina_rep |   cuota   
-------+-------------+-----------
     2 |          21 | 350000.00
(1 row)





