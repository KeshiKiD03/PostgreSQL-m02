-- --------------------------------------------
--    Funcions predefinides
-- --------------------------------------------

-- 10.1- Mostreu la longitud de la cadena "hola que tal"

training=# SELECT char_length('hola que tal');
 char_length 
-------------
          12
(1 row)


-- 10.2- Mostreu la longitud dels valors del camp "id_producto".

training=# SELECT length(id_producto) FROM productos;
 length 
--------
      5
      5
      4
      5
      4
      5
      5
      5
      4
      4
      5
      3
      4
      5
      5
      4
      5
      5
      5
      5
      4
      5
      3
      4
      5
(25 rows)


-- 10.3- Mostrar la longitud dels valors del camp "descripcion".

training=# SELECT length(descripcion) FROM productos;
 length 
--------
     17
      9
      8
      5
     12
     15
     15
      8
     13
      8
     14
      8
     15
      4
     15
     12
      8
      8
     15
     13
     14
      9
     13
     17
     15
(25 rows)



-- 10.4- Mostreu els noms dels venedors en majúscules.

training=# SELECT upper(nombre) FROM repventas;
     upper     
---------------
 BILL ADAMS
 MARY JONES
 SUE SMITH
 SAM CLARK
 BOB SMITH
 DAN ROBERTS
 TOM SNYDER
 LARRY FITCH
 PAUL CRUZ
 NANCY ANGELLI
(10 rows)


-- 10.5- Mostreu els noms dels venedors en minúscules.

training=# SELECT lower(nombre) FROM repventas;
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


SELECT upper(left(nombre, strpos(nombre, ' '))) FROM repventas;

training=# SELECT upper(split_part(nombre,' ',1)) FROM repventas;
 upper 
-------
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

training=# SELECT num_empl, left (nombre, strpos(nombre, ' ')), right (nombre, strpos(nombre, ' ')) FROM repventas;
 num_empl |  left  | right  
----------+--------+--------
      105 | Bill   | Adams
      109 | Mary   | Jones
      102 | Sue    | mith
      106 | Sam    | lark
      104 | Bob    | mith
      101 | Dan    | erts
      110 | Tom    | yder
      108 | Larry  |  Fitch
      103 | Paul   |  Cruz
      107 | Nancy  | ngelli
(10 rows)


-- 10.9- Mostreu els valors del camp nombre de manera que 'Bill Adams' sorti com 'B. Adams'.
 



-- 10.10- Mostreu els valors del camp nombre de manera que 'Bill Adams' sorti com 'Adams, Bill'.

training=# SELECT right(nombre, -strpos(nombre, ' ')) || ', ' || left(nombre, -strpos(nombre, ' ')) FROM repventas;
     ?column?     
------------------
 Adams, Bill 
 Jones, Mary 
 Smith, Sue S
 Clark, Sam C
 Smith, Bob S
 Roberts, Dan Rob
 Snyder, Tom Sn
 Fitch, Larry
 Cruz, Paul
 Angelli, Nancy A
(10 rows)


-- 10.11- Volem mostrar el camp descripcion de la taula productos però que en comptes de sortir espais en blanc, volem subratllats ('_').

training=# SELECT id_producto, descripcion, replace(descripcion, ' ', '_') FROM productos;
 id_producto |    descripcion    |      replace      
-------------+-------------------+-------------------
 2a45c       | V Stago Trinquete | V_Stago_Trinquete
 4100y       | Extractor         | Extractor
 xk47        | Reductor          | Reductor
 41672       | Plate             | Plate
 779c        | Riostra 2-Tm      | Riostra_2-Tm
 41003       | Articulo Tipo 3   | Articulo_Tipo_3
 41004       | Articulo Tipo 4   | Articulo_Tipo_4
 41003       | Manivela          | Manivela
 887p        | Perno Riostra     | Perno_Riostra
 xk48        | Reductor          | Reductor
 2a44l       | Bisagra Izqda.    | Bisagra_Izqda.
 112         | Cubierta          | Cubierta
 887h        | Soporte Riostra   | Soporte_Riostra
 41089       | Retn              | Retn
 41001       | Articulo Tipo 1   | Articulo_Tipo_1
 775c        | Riostra 1-Tm      | Riostra_1-Tm
 4100z       | Montador          | Montador
 xk48a       | Reductor          | Reductor
 41002       | Articulo Tipo 2   | Articulo_Tipo_2
 2a44r       | Bisagra Dcha.     | Bisagra_Dcha.
 773c        | Riostra 1/2-Tm    | Riostra_1/2-Tm
 4100x       | Ajustador         | Ajustador
 114         | Bancada Motor     | Bancada_Motor
 887x        | Retenedor Riostra | Retenedor_Riostra
 2a44g       | Pasador Bisagra   | Pasador_Bisagra
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

training=# SELECT rpad(nombre,15,'.') || ventas as "vendes dels empleats" FROM repventas;
   vendes dels empleats   
--------------------------
 Bill Adams.....367911.00
 Mary Jones.....392725.00
 Sue Smith......474050.00
 Sam Clark......299912.00
 Bob Smith......142594.00
 Dan Roberts....305673.00
 Tom Snyder.....75985.00
 Larry Fitch....361865.00
 Paul Cruz......286775.00
 Nancy Angelli..186042.00
(10 rows)



-- 10.13- Treieu per pantalla el temps total que fa que estan contractats els treballadors, ordenat pels cognoms dels treballadors amb un estil semblant al següent:
--       nombre  |     tiempo_trabajando
--    -----------+-------------------------
--    Mary Jones | 13 years 4 months 6 days

 
-- 10.14- Cal fer un llistat dels productes dels quals les existències són inferiors al total d'unitats venudes d'aquell producte els darrers 60 dies, a comptar des de la data actual. Cal mostrar els codis de fabricant i de producte, les existències, i les unitats totals venudes dels darrers 60 dies.


-- 10.15- Com l'exercici anterior però en comptes de 60 dies ara es volen aquells productes venuts durant el mes actual o durant l'anterior.


-- 10.16- Per fer un estudi previ de la campanya de Nadal es vol un llistat on, per cada any del qual hi hagi comandes a la base de dades, el nombre de clients diferents que hagin fet comandes en el mes de desembre d'aquell any. Cal mostrar l'any i el número de clients, ordenat ascendent per anys.


-- 10.17- Llisteu codi(s) i descripció dels productes. La descripció ha d'aperèixer en majúscules. Ha d'estar ordenat per la longitud de les descripcions (les més curtes primer).


-- 10.18- LListar el nom dels treballadors i la data del seu contracte mostrant-la amb el següent format:
-- Dia_de_la_setmana dia_mes_numeric, mes_text del any_4digits
-- per exemple:
-- Bill Adams    | Friday    12, February del 1988


-- 10.19- Modificar els imports de les comandes que s'han realitzat durant l'estiu augmentant-lo un 20% i arrodonint a l'alça el resultat.


-- 10.20- Mostar les dades de les oficines llistant en primera instància aquelles oficines que tenen una desviació entre vendes i objectius més gran.


-- 10.21- Llistar les dades d'aquells representants de vendes que tenen un identificador senar i són directors d'algun representants de vendes.


