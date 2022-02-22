--1. Fabricant, número i import de les comandes que el seu import oscil·li entre 10000 i 39999, 
--i ordenat per fabricant de forma ascendent i pel número descendent.

training=> select fab,num_pedido,importe from pedidos where (importe >=10000 AND importe <=39999) ORDER BY 1 ASC,2 DESC;
 fab | num_pedido | importe  
-----+------------+----------
 aci |     112987 | 27500.00
 aci |     112979 | 15000.00
 aci |     110036 | 22500.00
 imm |     113069 | 31350.00
 rei |     113042 | 22500.00
 rei |     112961 | 31500.00
(6 rows)



--2. Identificador i nom dels venedors, amb l'identificador de l'oficina d'aquells venedors que tenen una oficina assignada.


training=> select num_empl,nombre,oficina_rep from repventas where oficina_rep is not null;
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


--3. Trobar la data en que es va realitzar la primera i la última comanda.

training=> select min(fecha_pedido),max(fecha_pedido) from pedidos;
    min     |    max     
------------+------------
 1989-01-04 | 1990-03-02
(1 row)


--4. Llistar quants empleats estan assignats a cada oficina, 
--indicar el identificador d'oficina, i quants té assignats, no s'han de mostrar els nulls.

training=> select oficina_rep,count(*) from repventas where oficina_rep IS NOT NULL GROUP BY oficina_rep;
 oficina_rep | count 
-------------+-------
          12 |     3
          21 |     2
          11 |     2
          13 |     1
          22 |     1
(5 rows)




--5. Per a cada empleat que tingui més d'una comanda a algún client que sumi més de 2000, trobar la mitja per a cada empleat i client.


--6. Trobar el fabricant, producte i preu dels productes on el seu identificador comenci i acabi per 4.


SELECT id_fab, descripcion, precio FROM productos WHERE id_producto LIKE '4%4';
 id_fab |   descripcion   | precio 
--------+-----------------+--------
 aci    | Articulo Tipo 4 | 117.00
(1 row)



--7. Trobar el fabricant, producte i preu dels productes amb un preu superior a 100 i unes existemcias menors de 10. i mostralo ordenat per fabricant en ordre descencent, i per id_producte de forma ascendent.


SELECT id_fab, descripcion, precio FROM productos WHERE precio > 100 AND existencias < 10 ORDER BY id_fab DESC , id_producto ASC;
 id_fab | descripcion  | precio  
--------+--------------+---------
 imm    | Riostra 1-Tm | 1425.00
 imm    | Riostra 2-Tm | 1875.00
 bic    | Manivela     |  652.00
 bic    | Plate        |  180.00


--8. Identificador fabricant, producte i descripció dels productes amb un preu superior a 1000 i siguin del fabricant amb identificador rei o les existències siguin superiors a 20.


SELECT id_fab, id_producto, descripcion FROM productos WHERE precio >1000 AND (id_fab LIKE 'rei' OR existencias > 20);
 id_fab | id_producto |  descripcion   
--------+-------------+----------------
 aci    | 4100y       | Extractor
 rei    | 2a44l       | Bisagra Izqda.
 aci    | 4100z       | Montador
 rei    | 2a44r       | Bisagra Dcha.
(4 rows)





--9. Identificador i ciutat de les oficines de la regió est amb unes vendes inferiors a 700000 o de la regió oest amb unes vendes inferiors a 600000.

SELECT oficina, ciudad , region FROM oficinas WHERE (ventas < 700000 and region='Este') OR ( ventas < 600000 AND region='Oeste');
 oficina |  ciudad  | region 
---------+----------+--------
      22 | Denver   | Oeste
      11 | New York | Este
      13 | Atlanta  | Este
(3 rows)


--10. Identificador del fabricant, identificació i descripció dels productes on l'identificador del fabricant és "rei" o el preu és menor a 500.


SELECT id_fab, id_producto, descripcion FROM productos WHERE id_fab LIKE 'rei' OR precio < 500;
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


--11. Identificador dels clients que el seu nom no conté " Corp." o " Inc." amb crèdit major a 30000.


SELECT num_clie, empresa FROM clientes WHERE empresa NOT LIKE '%Corp.%' AND empresa NOT LIKE '%Inc.%' AND limite_credito > 30000;
 num_clie |      empresa      
----------+-------------------
     2103 | Acme Mfg.
     2123 | Carter & Sons
     2107 | Ace International
     2101 | Jones Mfg.
     2112 | Zetacorp
     2121 | QMA Assoc.
     2124 | Peter Brothers
     2108 | Holm & Landis
     2117 | J.P. Sinclair
     2120 | Rico Enterprises
     2118 | Midwest Systems
     2105 | AAA Investments


--12. Identificador i mitja d'edad per a cada oficina'.


SELECT oficina_rep, avg(edad) FROM repventas GROUP BY oficina_rep;
 oficina_rep |         avg         
-------------+---------------------
             | 41.0000000000000000
          13 | 37.0000000000000000
          22 | 49.0000000000000000
          21 | 55.0000000000000000
          11 | 41.5000000000000000
          12 | 35.6666666666666667



--13. Regió i diferència entre la mitjana aritmètica dels objectius i la de les vendes, per a cada regió.

	training=# SELECT region , (AVG(objetivo) - AVG(ventas)) FROM oficinas GROUP BY region ;
 region | 				???????
--------+-------------------------------
 Este   |           -23530.000000000000
 Oeste  |             1521.500000000000
(2 rows)


--14. Trobar l'import mitjà de comandes,l'import total de comandes i el preu mig de venda.

training=# SELECT avg(importe) AS import_mitja, sum(importe) AS import_total, avg(importe/cant) AS preu_mig_venda FROM pedidos;
     import_mitja      | import_total |    preu_mig_venda     
-----------------------+--------------+-----------------------
 8256.3666666666666667 |    247691.00 | 1056.9666666666666667


--15. Ciutat oficines i diferència entre vendes i objectius ordenada per aquesta diferència. 


training=# SELECT oficina,ciudad, (ventas-objetivo) AS diferencia FROM oficinas ORDER BY diferencia;
 oficina |   ciudad    | diferencia 
---------+-------------+------------
      22 | Denver      | -113958.00
      12 | Chicago     |  -64958.00
      13 | Atlanta     |   17911.00
      21 | Los Angeles |  110915.00
      11 | New York    |  117637.00
(5 rows)


