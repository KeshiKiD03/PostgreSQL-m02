--1. Fabricant, número i import de les comandes que el seu import oscil·li entre 10000 i 39999, 
--	 i ordenat per fabricant de forma ascendent i pel número descendent.

training=# SELECT fab , num_pedido , importe  FROM pedidos WHERE importe >= 10000 and importe < 40000 ORDER BY fab , num_pedido DESC;
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

training=# SELECT num_empl , nombre , oficina_rep FROM repventas WHERE oficina_rep IS NOT NULL;
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

training=# SELECT max(fecha_pedido) AS "Ultima comanda" , min(fecha_pedido) AS "Primera comanda" FROM pedidos ;
 Ultima comanda | Primera comanda 
----------------+-----------------
 1990-03-02     | 1989-01-04
(1 row)


--4. Llistar quants empleats estan assignats a cada oficina, indicar el identificador d'oficina, 
--	 i quants té assignats, no s'han de mostrar els nulls.

training=# SELECT  oficina_rep , count(*)  FROM repventas WHERE oficina_rep IS NOT NULL GROUP BY oficina_rep;
 oficina_rep | count 
-------------+-------
          13 |     1
          22 |     1
          21 |     2
          11 |     2
          12 |     3
(5 rows)


--5. Per a cada empleat que tingui més d'una comanda a algún client que sumi més de 2000, trobar la mitja per a 
-- cada empleat i client.

	training=# SELECT rep , clie , AVG (importe) FROM pedidos WHERE importe > 2000 GROUP BY rep , clie ORDER BY rep;
 rep | clie |          avg           
-----+------+------------------------
 101 | 2113 |     22500.000000000000
 101 | 2102 |  3978.0000000000000000
 102 | 2120 |  3750.0000000000000000
 102 | 2114 | 15000.0000000000000000
 102 | 2106 |  2130.0000000000000000
 103 | 2111 |  2100.0000000000000000
 105 | 2103 | 11626.6666666666666667
 105 | 2111 |  3745.0000000000000000
 106 | 2117 |     31500.000000000000
 107 | 2124 |  2430.0000000000000000
 107 | 2109 |     31350.000000000000
 108 | 2114 |  7100.0000000000000000
 108 | 2112 |     23962.500000000000
 109 | 2108 |  5625.0000000000000000
 110 | 2107 |     22500.000000000000
(15 rows)


--6. Trobar el fabricant, producte i preu dels productes on el seu identificador comenci i acabi per 4.

	training=# SELECT id_fab , id_producto , precio FROM productos WHERE id_producto LIKE '4%4';
 id_fab | id_producto | precio 
--------+-------------+--------
 aci    | 41004       | 117.00
(1 row)


--7. Trobar el fabricant, producte i preu dels productes amb un preu superior a 100 i unes existemcias menors de 10 
--	 i mostralo ordenat per fabricant en ordre descencent, i per id_producte de forma ascendent.

	training=# SELECT id_fab , id_producto , precio FROM productos 
	WHERE precio > 100 and existencias < 10 ORDER BY id_fab DESC , id_producto ;
 id_fab | id_producto | precio  
--------+-------------+---------
 imm    | 775c        | 1425.00
 imm    | 779c        | 1875.00
 bic    | 41003       |  652.00
 bic    | 41672       |  180.00
(4 rows)


--8. Identificador fabricant, producte i descripció dels productes amb un preu superior a 1000 i siguin del fabricant 
--	 amb identificador rei o les existències siguin superiors a 20.

	training=# SELECT id_fab , id_producto , descripcion , precio , existencias FROM productos 
	WHERE precio > 1000 and (id_fab = 'rei' OR existencias > 20);
 id_fab | id_producto |  descripcion   | precio  | existencias 
--------+-------------+----------------+---------+-------------
 aci    | 4100y       | Extractor      | 2750.00 |          25
 rei    | 2a44l       | Bisagra Izqda. | 4500.00 |          12
 aci    | 4100z       | Montador       | 2500.00 |          28
 rei    | 2a44r       | Bisagra Dcha.  | 4500.00 |          12
(4 rows)


--9. Identificador i ciutat de les oficines de la regió est amb unes vendes inferiors a 700000 o de la regió oest 
--	 amb unes vendes inferiors a 600000.

	training=# SELECT oficina , ciudad FROM oficinas WHERE ventas < 700000 or (region = 'Este' and ventas < 600000);
 oficina |  ciudad  
---------+----------
      22 | Denver
      11 | New York
      13 | Atlanta
(3 rows)


--10. Identificador del fabricant, identificació i descripció dels productes on l'identificador del fabricant 
--	 és "rei" o el preu és menor a 500.

	training=# SELECT id_fab , id_producto , descripcion , precio FROM productos 
	WHERE id_fab = 'rei' OR precio < 500; id_fab | id_producto |    descripcion    | precio  
--------+-------------+-------------------+---------
 rei    | 2a45c       | V Stago Trinquete |   79.00
 qsa    | xk47        | Reductor          |  355.00
 bic    | 41672       | Plate             |  180.00
 aci    | 41003       | Articulo Tipo 3   |  107.00
 aci    | 41004       | Articulo Tipo 4   |  117.00
 imm    | 887p        | Perno Riostra     |  250.00
 qsa    | xk48        | Reductor          |  134.00
 rei    | 2a44l       | Bisagra Izqda.    | 4500.00
 fea    | 112         | Cubierta          |  148.00
 imm    | 887h        | Soporte Riostra   |   54.00
 bic    | 41089       | Retn              |  225.00
 aci    | 41001       | Articulo Tipo 1   |   55.00
 qsa    | xk48a       | Reductor          |  117.00
 aci    | 41002       | Articulo Tipo 2   |   76.00
 rei    | 2a44r       | Bisagra Dcha.     | 4500.00
 aci    | 4100x       | Ajustador         |   25.00
 fea    | 114         | Bancada Motor     |  243.00
 imm    | 887x        | Retenedor Riostra |  475.00
 rei    | 2a44g       | Pasador Bisagra   |  350.00
(19 rows)


--11. Identificador dels clients que el seu nom no conté " Corp." o " Inc." amb crèdit major a 30000.

	training=# SELECT num_clie , empresa , limite_credito FROM clientes 
	WHERE empresa NOT LIKE '% Corp.%' and empresa NOT LIKE '% Inc.%' and limite_credito > 30000;
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


--12. Identificador i mitja d'edad per a cada oficina.

	training=# SELECT oficina_rep , AVG(edad) FROM repventas WHERE oficina_rep IS NOT NULL GROUP BY oficina_rep , num_empl;
 oficina_rep |         avg         
-------------+---------------------
          11 | 52.0000000000000000
          12 | 33.0000000000000000
          11 | 31.0000000000000000
          12 | 45.0000000000000000
          13 | 37.0000000000000000
          21 | 48.0000000000000000
          12 | 29.0000000000000000
          22 | 49.0000000000000000
          21 | 62.0000000000000000
(9 rows)


--13. Regió i diferència entre la mitjana aritmètica dels objectius i la de les vendes, per a cada regió.

	training=# SELECT region , (AVG(objetivo) - AVG(ventas)) AS "Mitjana obj -  mitjana ventas" FROM oficinas GROUP BY region ;
 region | Mitjana obj -  mitjana ventas 
--------+-------------------------------
 Este   |           -23530.000000000000
 Oeste  |             1521.500000000000
(2 rows)

--14. Trobar l'import mitjà de comandes,l'import total de comandes i el preu mig de venda.

	training=# SELECT AVG(cant) as "Mitja comandes" , SUM(importe) AS "Total import" , AVG(importe) AS "Mitja import" 
	FROM pedidos;   
	Mitja comandes    | Total import |     Mitja import      
 ---------------------+--------------+-----------------------
  12.4333333333333333 |    247691.00 | 8256.3666666666666667
 (1 row)


--15. Ciutat oficines i diferència entre vendes i objectius ordenada per aquesta diferència. 

	training=# SELECT ciudad , oficina , (ventas - objetivo) AS "Dif ventas i obj" FROM oficinas ORDER BY (ventas - objetivo);
   ciudad    | oficina | Dif ventas i obj 
-------------+---------+------------------
 Denver      |      22 |       -113958.00
 Chicago     |      12 |        -64958.00
 Atlanta     |      13 |         17911.00
 Los Angeles |      21 |        110915.00
 New York    |      11 |        117637.00
(5 rows)


--16. Número comanda, data comanda, codi fabricant, codi producte i import comandes per comandes entre els dies '1989-09-1' i '1989-12-31'.

--17. Ciutat oficines, regions i diferència entre vendes i objectius ordenades per regió i per diferència entre vendes i objectius de major a menor. 

--18. Número total de comandes.

--19. Nom i data de contracte dels empleats que les seves vendes siguin superiors a 200000 i mostrar ordenat per contracte de més nou a més vell.

--20. Codi i nom de les tres ciutats que tinguin unes vendes superiors. 
