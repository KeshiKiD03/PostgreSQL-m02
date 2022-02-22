-- --------------------------------------------
--    Funcions predefinides
-- --------------------------------------------

-- 10.1- Mostreu la longitud de la cadena "hola que tal"

	training=# SELECT length('hola que tal');
 length 
--------
     12
(1 row)


-- 10.2- Mostreu la longitud dels valors del camp "id_producto".

	training=# SELECT id_producto , length(id_producto) FROM productos ;
 id_producto | length 
-------------+--------
 2a45c       |      5
 4100y       |      5
 xk47        |      4
 41672       |      5
 779c        |      4
 41003       |      5
 41004       |      5
 41003       |      5
 887p        |      4
 xk48        |      4
 2a44l       |      5
 112         |      3
 887h        |      4
 41089       |      5
 41001       |      5
 775c        |      4
 4100z       |      5
 xk48a       |      5
 41002       |      5
 2a44r       |      5
 773c        |      4
 4100x       |      5
 114         |      3
 887x        |      4
 2a44g       |      5
(25 rows)


-- 10.3- Mostrar la longitud dels valors del camp "descripcion".

	training=# SELECT descripcion , length(descripcion) FROM productos ;
    descripcion    | length 
-------------------+--------
 V Stago Trinquete |     17
 Extractor         |      9
 Reductor          |      8
 Plate             |      5
 Riostra 2-Tm      |     12
 Articulo Tipo 3   |     15
 Articulo Tipo 4   |     15
 Manivela          |      8
 Perno Riostra     |     13
 Reductor          |      8
 Bisagra Izqda.    |     14
 Cubierta          |      8
 Soporte Riostra   |     15
 Retn              |      4
 Articulo Tipo 1   |     15
 Riostra 1-Tm      |     12
 Montador          |      8
 Reductor          |      8
 Articulo Tipo 2   |     15
 Bisagra Dcha.     |     13
 Riostra 1/2-Tm    |     14
 Ajustador         |      9
 Bancada Motor     |     13
 Retenedor Riostra |     17
 Pasador Bisagra   |     15
(25 rows)


-- 10.4- Mostreu els noms dels venedors en majúscules.

	training=# SELECT initcap(nombre) FROM repventas ;
    initcap    
---------------
 Bill Adams
 Mary Jones
 Sue Smith
 Sam Clark
 Bob Smith
 Dan Roberts
 Tom Snyder
 Larry Fitch
 Paul Cruz
 Nancy Angelli
(10 rows)


-- 10.5- Mostreu els noms dels venedors en minúscules.

	training=# SELECT lower(nombre) FROM repventas ;
     lower     
---------------
 bill adams
 mary jones
 sue smith
 sam clark
 bob smith
 dan roberts
 tom snyder
 larry fitch
 paul cruz
 nancy angelli
(10 rows)


-- 10.6- Trobeu on és la posició de l'espai en blanc de la cadena 'potser 7'.

	training=# SELECT position(' ' in 'potser 7');
 position 
----------
        7
(1 row)


-- 10.7- Volem mostrar el nom, només el nom dels venedors sense el cognom, en majúscules.

	training=# SELECT split_part(upper(nombre), ' ', 1) FROM repventas;
 split_part 
------------
 BILL
 MARY
 SUE
 SAM
 BOB
 DAN
 TOM
 LARRY
 PAUL
 NANCY
(10 rows)

	training=# SELECT upper(left(nombre, strpos(nombre, ' '))) FROM repventas;
 upper  
--------
 BILL 
 MARY 
 SUE 
 SAM 
 BOB 
 DAN 
 TOM 
 LARRY 
 PAUL 
 NANCY 
(10 rows)


-- 10.8- Crear una vista que mostri l'identificador dels representants de vendes i en columnes separades el nom i el cognom.

	training=# SELECT num_empl , split_part(nombre , ' ' , 1) , split_part(nombre , ' ' , 2)  FROM repventas ;
 num_empl | split_part | split_part 
----------+------------+------------
      105 | Bill       | Adams
      109 | Mary       | Jones
      102 | Sue        | Smith
      106 | Sam        | Clark
      104 | Bob        | Smith
      101 | Dan        | Roberts
      110 | Tom        | Snyder
      108 | Larry      | Fitch
      103 | Paul       | Cruz
      107 | Nancy      | Angelli
(10 rows)


-- 10.9- Mostreu els valors del camp nombre de manera que 'Bill Adams' sorti com 'B. Adams'.
 
	training=# SELECT left(nombre,1)||'. '||split_part(nombre , ' ' , 2) FROM repventas;
  ?column?  
------------
 B. Adams
 M. Jones
 S. Smith
 S. Clark
 B. Smith
 D. Roberts
 T. Snyder
 L. Fitch
 P. Cruz
 N. Angelli
(10 rows)

	training=# SELECT left(nombre,1)||'. '||right(nombre, strpos(nombre, ' ')) FROM repventas;
  ?column?  
------------
 B. Adams
 M. Jones
 S. Smith
 S. Clark
 B. Smith
 D. Roberts
 T. Snyder
 L. Fitch
 P. Cruz
 N. Angelli
(10 rows)

-- 10.10- Mostreu els valors del camp nombre de manera que 'Bill Adams' sorti com 'Adams, Bill'.

	training=# SELECT split_part(nombre , ' ' , 2)||', '|| split_part(nombre , ' ' , 1) FROM repventas;
    ?column?    
----------------
 Adams, Bill
 Jones, Mary
 Smith, Sue
 Clark, Sam
 Smith, Bob
 Roberts, Dan
 Snyder, Tom
 Fitch, Larry
 Cruz, Paul
 Angelli, Nancy
(10 rows)


-- 10.11- Volem mostrar el camp descripcion de la taula productos però que en comptes de sortir espais en blanc, volem subratllats ('_').

	training=# SELECT replace(descripcion, ' ', '_') FROM productos ;
      replace      
-------------------
 V_Stago_Trinquete
 Extractor
 Reductor
 Plate
 Riostra_2-Tm
 Articulo_Tipo_3
 Articulo_Tipo_4
 Manivela
 Perno_Riostra
 Reductor
 Bisagra_Izqda.
 Cubierta
 Soporte_Riostra
 Retn
 Articulo_Tipo_1
 Riostra_1-Tm
 Montador
 Reductor
 Articulo_Tipo_2
 Bisagra_Dcha.
 Riostra_1/2-Tm
 Ajustador
 Bancada_Motor
 Retenedor_Riostra
 Pasador_Bisagra
(25 rows)


-- 10.12- Volem treure per pantalla una columna, que conté el nom i les vendes, amb els següent estil:
--   vendes dels empleats
-- ---------------------------
--  Bill Adams..... 367911,00
--  Mary Jones..... 392725,00
--  Sue Smith...... 474050,00
--  Sam Clark...... 299912,00
--  Bob Smith...... 142594,00
--  Dan Roberts.... 305673,00
--  Tom Snyder.....  75985,00
--  Larry Fitch.... 361865,00
--  Paul Cruz...... 286775,00
--  Nancy Angelli.. 186042,00
-- (10 rows)
	
	training=# SELECT rpad(nombre,15,'.') || ' ' || repeat(' ',10 - length(ventas::text)) || ventas FROM repventas ;
         ?column?          
---------------------------
 Bill Adams..... 367911.00
 Mary Jones..... 392725.00
 Sue Smith...... 474050.00
 Sam Clark...... 299912.00
 Bob Smith...... 142594.00
 Dan Roberts.... 305673.00
 Tom Snyder.....  75985.00
 Larry Fitch.... 361865.00
 Paul Cruz...... 286775.00
 Nancy Angelli.. 186042.00
(10 rows)

	training=# SELECT overlay('...............' placing nombre from 1) || ' ' || repeat(' ',10 - length(ventas::text)) || ventas FROM repventas ;
         ?column?          
---------------------------
 Bill Adams..... 367911.00
 Mary Jones..... 392725.00
 Sue Smith...... 474050.00
 Sam Clark...... 299912.00
 Bob Smith...... 142594.00
 Dan Roberts.... 305673.00
 Tom Snyder.....  75985.00
 Larry Fitch.... 361865.00
 Paul Cruz...... 286775.00
 Nancy Angelli.. 186042.00
(10 rows)

	training=# SELECT nombre || repeat('.', 15 - length(nombre)) || ' ' || repeat(' ',10 - length(ventas::text)) || ventas FROM repventas ;
          ?column?          
----------------------------
 Bill Adams.....  367911.00
 Mary Jones.....  392725.00
 Sue Smith......  474050.00
 Sam Clark......  299912.00
 Bob Smith......  142594.00
 Dan Roberts....  305673.00
 Tom Snyder.....   75985.00
 Larry Fitch....  361865.00
 Paul Cruz......  286775.00
 Nancy Angelli..  186042.00
(10 rows)



-- 10.13- Treieu per pantalla el temps total que fa que estan contractats els treballadors, ordenat pels cognoms 
-- dels treballadors amb un estil semblant al següent:
--       nombre  |     tiempo_trabajando
--    -----------+-------------------------
--    Mary Jones | 13 years 4 months 6 days

training=# SELECT nombre , age(contrato) FROM repventas ORDER BY split_part(nombre , ' ' , 2);
    nombre     |           age           
---------------+-------------------------
 Bill Adams    | 30 years 1 mon 5 days
 Nancy Angelli | 29 years 4 mons 3 days
 Sam Clark     | 29 years 9 mons 3 days
 Paul Cruz     | 31 years 16 days
 Larry Fitch   | 28 years 5 mons 5 days
 Mary Jones    | 28 years 5 mons 5 days
 Dan Roberts   | 31 years 4 mons 28 days
 Sue Smith     | 31 years 3 mons 7 days
 Bob Smith     | 30 years 9 mons 29 days
 Tom Snyder    | 28 years 2 mons 4 days
(10 rows)
 
-- 10.14- Cal fer un llistat dels productes dels quals les existències són inferiors al total d'unitats venudes d'aquell 
-- producte els darrers 60 dies, a comptar des de la data actual. Cal mostrar els codis de fabricant i de producte, 
-- les existències, i les unitats totals venudes dels darrers 60 dies.

	training=# SELECT id_fab , id_producto , existencias , (SELECT sum(cant) 
															FROM pedidos 
															WHERE id_fab = fab and id_producto = producto) 
	FROM productos 
	WHERE existencias < (SELECT sum(cant) 
						 FROM pedidos 
						 WHERE id_fab = fab and id_producto = producto and fecha_pedido > current_date - interval '60' day);
 id_fab | id_producto | existencias | sum 
--------+-------------+-------------+-----
(0 rows)


-- 10.15- Com l'exercici anterior però en comptes de 60 dies ara es volen aquells productes venuts durant el mes actual 
-- o durant l'anterior.

	training=# SELECT id_fab , id_producto , existencias , (SELECT sum(cant) 
															FROM pedidos 
															WHERE id_fab = fab and id_producto = producto)             
			   FROM productos 
			   WHERE existencias < (SELECT sum(cant) 
									FROM pedidos
									WHERE id_fab = fab and id_producto = producto and fecha_pedido > date_trunc('month', current_date - interval '1' month)::date);
 id_fab | id_producto | existencias | sum 
--------+-------------+-------------+-----
(0 rows)

training=# SELECT id_fab , id_producto , existencias , (SELECT sum(cant) 
														FROM pedidos 
														WHERE id_fab = fab and id_producto = producto)             
   FROM productos 
   WHERE existencias < (SELECT sum(cant) 
						FROM pedidos
						WHERE id_fab = fab and id_producto = producto 
						  and EXTRACT(year FROM fecha_pedido) > EXTRACT(year FROM current_date) and (EXTRACT(month FROM fecha_pedido) > EXTRACT(month FROM current_date) 
						  or EXTRACT(month FROM fecha_pedido) > EXTRACT(month FROM current_date) - 1));
 id_fab | id_producto | existencias | sum 
--------+-------------+-------------+-----
(0 rows)


-- 10.16- Per fer un estudi previ de la campanya de Nadal es vol un llistat on, per cada any del qual hi hagi comandes a la 
-- base de dades, el nombre de clients diferents que hagin fet comandes en el mes de desembre d'aquell any. Cal mostrar l'any 
-- i el número de clients, ordenat ascendent per anys.

		training=# SELECT left(fecha_pedido::text, 4) AS año , count(DISTINCT clie) 
				   FROM pedidos 
				   WHERE (SELECT split_part(fecha_pedido::text,'-',2)) = '12' GROUP BY 1;
 año  | count 
------+-------
 1989 |     3
(1 row)


-- 10.17- Llisteu codi(s) i descripció dels productes. La descripció ha d'aperèixer en majúscules. Ha d'estar ordenat per la
-- longitud de les descripcions (les més curtes primer).

	training=# SELECT id_fab , id_producto , upper(descripcion) 
			   FROM productos 
			   ORDER BY length(descripcion);
 id_fab | id_producto |       upper       
--------+-------------+-------------------
 bic    | 41089       | RETN
 bic    | 41672       | PLATE
 qsa    | xk48a       | REDUCTOR
 qsa    | xk47        | REDUCTOR
 bic    | 41003       | MANIVELA
 qsa    | xk48        | REDUCTOR
 fea    | 112         | CUBIERTA
 aci    | 4100z       | MONTADOR
 aci    | 4100x       | AJUSTADOR
 aci    | 4100y       | EXTRACTOR
 imm    | 779c        | RIOSTRA 2-TM
 imm    | 775c        | RIOSTRA 1-TM
 imm    | 887p        | PERNO RIOSTRA
 fea    | 114         | BANCADA MOTOR
 rei    | 2a44r       | BISAGRA DCHA.
 imm    | 773c        | RIOSTRA 1/2-TM
 rei    | 2a44l       | BISAGRA IZQDA.
 rei    | 2a44g       | PASADOR BISAGRA
 aci    | 41003       | ARTICULO TIPO 3
 aci    | 41004       | ARTICULO TIPO 4
 imm    | 887h        | SOPORTE RIOSTRA
 aci    | 41001       | ARTICULO TIPO 1
 aci    | 41002       | ARTICULO TIPO 2
 imm    | 887x        | RETENEDOR RIOSTRA
 rei    | 2a45c       | V STAGO TRINQUETE
(25 rows)


-- 10.18- LListar el nom dels treballadors i la data del seu contracte mostrant-la amb el següent format:
-- Dia_de_la_setmana dia_mes_numeric, mes_text del any_4digits
-- per exemple:
-- Bill Adams    | Friday    12, February del 1988

	training=# SELECT nombre , to_char(contrato, 'Day') || '    ' || repeat(' ', 2 -  length(EXTRACT(day FROM contrato)::text)) || EXTRACT(day FROM contrato)  
				|| ', ' || to_char(contrato, 'Month') || ' del ' || EXTRACT(year FROM contrato)  
			   FROM repventas;
    nombre     |              ?column?               
---------------+-------------------------------------
 Bill Adams    | Friday       12, February  del 1988
 Mary Jones    | Thursday     12, October   del 1989
 Sue Smith     | Wednesday    10, December  del 1986
 Sam Clark     | Tuesday      14, June      del 1988
 Bob Smith     | Tuesday      19, May       del 1987
 Dan Roberts   | Monday       20, October   del 1986
 Tom Snyder    | Saturday     13, January   del 1990
 Larry Fitch   | Thursday     12, October   del 1989
 Paul Cruz     | Sunday        1, March     del 1987
 Nancy Angelli | Monday       14, November  del 1988
(10 rows)






-- 10.19- Modificar els imports de les comandes que s'han realitzat durant l'estiu augmentant-lo un 20% i arrodonint a l'alça 
-- el resultat.

	training=# SELECT ceil(0.2*importe) 
			   FROM pedidos 
			   WHERE (extract(month from fecha_pedido) > 6 and extract(month from fecha_pedido) < 9) 
					  or (extract(month from fecha_pedido) = 6 and extract(day from fecha_pedido) >= 21) 
					  or (extract(month from fecha_pedido) = 9 and extract(day from fecha_pedido) <= 23);
 ceil 
------
(0 rows)


-- 10.20- Mostar les dades de les oficines llistant en primera instància aquelles oficines que tenen una desviació entre 
-- vendes i objectius més gran.

	training=# SELECT * 
			   FROM oficinas 
			   ORDER BY @(objetivo - ventas) DESC;
 oficina |   ciudad    | region | dir | objetivo  |  ventas   
---------+-------------+--------+-----+-----------+-----------
      11 | New York    | Este   | 106 | 575000.00 | 692637.00
      22 | Denver      | Oeste  | 108 | 300000.00 | 186042.00
      21 | Los Angeles | Oeste  | 108 | 725000.00 | 835915.00
      12 | Chicago     | Este   | 104 | 800000.00 | 735042.00
      13 | Atlanta     | Este   | 105 | 350000.00 | 367911.00
(5 rows)


-- 10.21- Llistar les dades d'aquells representants de vendes que tenen un identificador senar i són directors d'algun 
-- representants de vendes.

	training=# SELECT DISTINCT boss.* 
			   FROM repventas 
			   JOIN repventas boss ON boss.num_empl = repventas.director 
			   WHERE boss.num_empl % 2 != 0;
 num_empl |   nombre    | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   
----------+-------------+------+-------------+------------+------------+----------+-----------+-----------
      101 | Dan Roberts |   45 |          12 | Rep Ventas | 1986-10-20 |      104 | 300000.00 | 305673.00
(1 row)

