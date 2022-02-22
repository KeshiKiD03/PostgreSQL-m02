1. Fabricant, número i import de les comandes que el seu import oscil·li entre 10000 i 39999, i ordenat per fabricant de forma ascendent i pel número descendent.

training=# SELECT fab,num_pedido,importe
FROM pedidos
WHERE importe BETWEEN  10000 AND  39999 ORDER BY fab,num_pedido desc;
 fab | num_pedido | importe  
-----+------------+----------
 aci |     112987 | 27500.00
 aci |     112979 | 15000.00
 aci |     110036 | 22500.00
 imm |     113069 | 31350.00
 rei |     113042 | 22500.00
 rei |     112961 | 31500.00


2. Identificador i nom dels venedors, amb l'identificador de l'oficina d'aquells venedors que tenen una oficina assignada.


training=# SELECT num_empl,nombre,oficina_rep
training-# FROM repventas
training-# WHERE oficina_rep IS NOT NULL;
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


3. Trobar la data en que es va realitzar la primera i la última comanda.

training=# SELECT max(fecha_pedido) AS "ultima comanda",min(fecha_pedido) AS "primera comanda" FROM pedidos;
 ultima comanda | primera comanda 
----------------+-----------------
 1990-03-02     | 1989-01-04



4. Llistar quants empleats estan assignats a cada oficina, indicar el identificador d'oficina, i quants té assignats, no s'han de mostrar els nulls.

training=# SELECT oficina_rep, count(*) AS "nombre de treballadors" FROM repventas WHERE oficina_rep IS NOT NULL
GROUP BY oficina_rep;
 oficina_rep | nombre de treballadors 
-------------+------------------------
          13 |                      1
          22 |                      1
          21 |                      2
          11 |                      2
          12 |                      3
(5 filas)



5. Trobar la mitjana de la comanda per a cada empleat i client.

training=# SELECT rep,clie,avg(importe) AS "mitjana de la comanda" FROM pedidos GROUP BY clie,rep;
 rep | clie | mitjana de la comanda  
-----+------+------------------------
 107 | 2109 |     31350.000000000000
 108 | 2114 |  7100.0000000000000000
 103 | 2111 |  1350.0000000000000000
 102 | 2120 |  3750.0000000000000000
 102 | 2106 |  2013.0000000000000000
 109 | 2108 |  3552.5000000000000000
 108 | 2118 |   902.0000000000000000
 101 | 2102 |  3978.0000000000000000
 108 | 2112 |     23962.500000000000
 105 | 2111 |  3745.0000000000000000



6. Trobar el fabricant, producte i preu dels productes on el seu identificador comenci i acabi per 4.

training=# SELECT id_fab,id_producto,precio FROM productos WHERE id_producto LIKE '4%' AND id_producto LIKE '%4';
 id_fab | id_producto | precio 
--------+-------------+--------
 aci    | 41004       | 117.00
(1 fila)



7. Trobar el fabricant, producte i preu dels productes amb un preu superior a 100 i unes existemcias menors de 10. i mostralo ordenat per fabricant en ordre descencent, i per id_producte de forma ascendent.

training=# SELECT id_fab,id_producto,precio FROM productos WHERE precio > 100 AND existencias < 10 ORDER BY id_fab desc,id_producto;
 id_fab | id_producto | precio  
--------+-------------+---------
 imm    | 775c        | 1425.00
 imm    | 779c        | 1875.00
 bic    | 41003       |  652.00
 bic    | 41672       |  180.00


8. Identificador fabricant, producte i descripció dels productes amb un preu superior a 1000 i siguin del fabricant amb identificador rei o les existències siguin superiors a 20.

training=# SELECT id_fab,id_producto,descripcion FROM productos WHERE precio > 1000 AND ( id_fab= 'rei' OR existencias > 20);
 id_fab | id_producto |  descripcion   
--------+-------------+----------------
 aci    | 4100y       | Extractor
 rei    | 2a44l       | Bisagra Izqda.
 aci    | 4100z       | Montador
 rei    | 2a44r       | Bisagra Dcha.
(4 filas)


9. Identificador i ciutat de les oficines de la regió est amb unes vendes inferiors a 700000 o de la regió oest amb unes vendes inferiors a 600000.

training=# SELECT oficina,ciudad,region FROM oficinas WHERE (region='Este' AND  ventas < 700000) OR (region='Oeste' AND ventas < 600000);
 oficina |  ciudad  | region 
---------+----------+--------
      22 | Denver   | Oeste
      11 | New York | Este
      13 | Atlanta  | Este
(3 filas)

 


10. Identificador del fabricant, identificació i descripció dels productes on l'identificador del fabricant és "rei" o el preu és menor a 500.
training=# SELECT id_fab,id_producto,descripcion FROM productos WHERE id_fab='rei' OR precio < 500;
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


11. Identificador dels clients que el seu nom no conté " Corp." o " Inc." amb crèdit major a 30000.

SELECT num_clie FROM clientes WHERE NOT LIKE '%Corp.%' OR NOT LIKE '%Inc% AND limite_credit > 30000;


12. Identificador i mitja d'edad per a cada oficina.

                ^
training=# SELECT num_empl,avg(edad) AS "mitja edat" FROM repventas GROUP BY num_empl;
 num_empl |     mitja edat      
----------+---------------------
      106 | 52.0000000000000000
      101 | 45.0000000000000000
      109 | 31.0000000000000000
      104 | 33.0000000000000000
      102 | 48.0000000000000000
      107 | 49.0000000000000000
      108 | 62.0000000000000000
      110 | 41.0000000000000000
      103 | 29.0000000000000000
      105 | 37.0000000000000000
(10 filas)




13. Regió i diferència entre la mitjana aritmètica dels objectius i la de les vendes, per a cada regió.

training=# SELECT region, avg(objetivo) - avg(ventas) AS "mitjana aritmètica"  FROM oficinas GROUP BY region;
 region | mitjana aritmètica  
--------+---------------------
 Este   | -23530.000000000000
 Oeste  |   1521.500000000000
(2 filas)




14. Trobar l'import mitjà de comandes,l'import total de comandes i el preu mig de venda.

training=# SELECT avg(importe) AS "import mitja", sum(importe) AS "import total comandes", avg(importe / cant) "preu mitg" FROM pedidos;
     import mitja      | import total comandes |       preu mitg       
-----------------------+-----------------------+-----------------------
 8256.3666666666666667 |             247691.00 | 1056.9666666666666667
(1 row)



15. Ciutat oficines i diferència entre vendes i objectius ordenada per aquesta diferència. 

training=# SELECT ciudad,oficina, ( ventas - objetivo ) AS "diferencia" FROM oficinas ORDER BY diferencia;   ciudad    | oficina | diferencia 
-------------+---------+------------
 Denver      |      22 | -113958.00
 Chicago     |      12 |  -64958.00
 Atlanta     |      13 |   17911.00
 Los Angeles |      21 |  110915.00
 New York    |      11 |  117637.00
(5 rows)


16. Número comanda, data comanda, codi fabricant, codi producte i import comandes per comandes entre els dies '1989-09-1' i '1989-12-31'.

training=# SELECT num_pedido,fecha_pedido,fab,producto,importe
FROM pedidos
WHERE fecha_pedido >= '1989-09-01' AND fecha_pedido <= '1989-12-31';
 num_pedido | fecha_pedido | fab | producto | importe  
------------+--------------+-----+----------+----------
     112961 | 1989-12-17   | rei | 2a44l    | 31500.00
     112968 | 1989-10-12   | aci | 41004    |  3978.00
     112963 | 1989-12-17   | aci | 41004    |  3276.00
     112983 | 1989-12-27   | aci | 41004    |   702.00
     112979 | 1989-10-12   | aci | 4100z    | 15000.00
     112992 | 1989-11-04   | aci | 41002    |   760.00
--More--


17. Ciutat oficines, regions i diferència entre vendes i objectius ordenades per regió i per diferència entre vendes i objectius de major a menor. 

training=# SELECT ciudad,region,(ventas - objetivo) AS "diferencia"
from oficinas
GROUP BY region,diferencia,ciudad ORDER BY diferencia desc;
   ciudad    | region | diferencia 
-------------+--------+------------
 New York    | Este   |  117637.00
 Los Angeles | Oeste  |  110915.00
 Atlanta     | Este   |   17911.00
 Chicago     | Este   |  -64958.00
 Denver      | Oeste  | -113958.00
(5 rows)

training=# 

18. Número total de comandes.

training=# SELECT count(*) AS "pedidos" From pedidos;
 pedidos 
---------
      30
(1 row)


19. Nom i data de contracte dels empleats que les seves vendes siguin superiors a 200000 i mostrar ordenat per contracte de més nou a més vell.

training=# SELECT nombre,contrato 
FROM repventas
WHERE ventas > 200000 ORDER BY contrato desc;
   nombre    |  contrato  
-------------+------------
 Larry Fitch | 1989-10-12
 Mary Jones  | 1989-10-12
 Sam Clark   | 1988-06-14
 Bill Adams  | 1988-02-12
 Paul Cruz   | 1987-03-01
 Sue Smith   | 1986-12-10
training=# 


20. Codi i nom de les tres ciutats que tinguin unes vendes superiors. 

training=# SELECT oficina,ciudad,ventas
FROM oficinas
ORDER BY ventas desc LIMIT 3;
 oficina |   ciudad    |  ventas   
---------+-------------+-----------
      21 | Los Angeles | 835915.00
      12 | Chicago     | 735042.00
      11 | New York    | 692637.00
(3 rows)




