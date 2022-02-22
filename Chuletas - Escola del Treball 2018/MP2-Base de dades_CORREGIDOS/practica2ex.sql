-- 2.1- Els identificadors de les oficines amb la seva ciutat, els objectius i les vendes reals.

training=# SELECT oficina, objetivo, ventas, ciudad FROM oficinas;
 oficina | objetivo  |  ventas   |   ciudad    
---------+-----------+-----------+-------------
      22 | 300000.00 | 186042.00 | Denver
      11 | 575000.00 | 692637.00 | New York
      12 | 800000.00 | 735042.00 | Chicago
      13 | 350000.00 | 367911.00 | Atlanta
      21 | 725000.00 | 835915.00 | Los Angeles
(5 rows)

-- 2.2- Els identificadors de les oficines de la regió est amb la seva ciutat, els objectius i les vendes reals.

training=# SELECT region, oficina, ciudad, objetivo, ventas FROM oficinas WHERE region = 'Este';
 region | oficina |  ciudad  | objetivo  |  ventas   
--------+---------+----------+-----------+-----------
 Este   |      11 | New York | 575000.00 | 692637.00
 Este   |      12 | Chicago  | 800000.00 | 735042.00
 Este   |      13 | Atlanta  | 350000.00 | 367911.00
(3 rows)

-- 2.3- Les ciutats en ordre alfabètic de les oficines de la regió est amb els objectius i les vendes reals.

training=# SELECT ciudad, objetivo, ventas FROM oficinas WHERE region = 'Este' ORDER BY ciudad;
  ciudad  | objetivo  |  ventas   
----------+-----------+-----------
 Atlanta  | 350000.00 | 367911.00
 Chicago  | 800000.00 | 735042.00
 New York | 575000.00 | 692637.00
(3 rows)

-- 2.4- Les ciutats, els objectius i les vendes d'aquelles oficines que les seves vendes superin els seus objectius.

training=# SELECT ciudad, objetivo, ventas, oficina FROM oficinas WHERE 'ventas' > 'objetivo';
   ciudad    | objetivo  |  ventas   | oficina 
-------------+-----------+-----------+---------
 Denver      | 300000.00 | 186042.00 |      22
 New York    | 575000.00 | 692637.00 |      11
 Chicago     | 800000.00 | 735042.00 |      12
 Atlanta     | 350000.00 | 367911.00 |      13
 Los Angeles | 725000.00 | 835915.00 |      21
(5 rows)

-- 2.5- Nom, quota i vendes de l'empleat representant de vendes número 107.

training=# select nombre, cuota, ventas FROM repventas WHERE num_empl = 107;
    nombre     |   cuota   |  ventas   
---------------+-----------+-----------
 Nancy Angelli | 300000.00 | 186042.00
(1 row)

-- 2.6- Nom i data de contracte dels representants de vendes amb vendes superiors a 300000.

training=# select nombre, contrato, ventas FROM repventas WHERE ventas > 300000;
   nombre    |  contrato  |  ventas   
-------------+------------+-----------
 Bill Adams  | 1988-02-12 | 367911.00
 Mary Jones  | 1989-10-12 | 392725.00
 Sue Smith   | 1986-12-10 | 474050.00
 Dan Roberts | 1986-10-20 | 305673.00
 Larry Fitch | 1989-10-12 | 361865.00
(5 rows)

-- 2.7- Nom dels representants de vendes dirigits per l'empleat numero 104 Bob Smith.

training=# select nombre FROM repventas WHERE director = 104;
   nombre    
-------------
 Bill Adams
 Dan Roberts
 Paul Cruz
(3 rows)

-- 2.8- Nom dels venedors i data de contracte d'aquells que han estat contractats abans del 1988.

training=# select nombre, contrato FROM repventas WHERE contrato < '1988-01-01';
   nombre    |  contrato  
-------------+------------
 Sue Smith   | 1986-12-10
 Bob Smith   | 1987-05-19
 Dan Roberts | 1986-10-20
 Paul Cruz   | 1987-03-01
(4 rows)

-- 2.9- Identificador de les oficines i ciutat d'aquelles oficines que el seu objectiu és diferent a 800000.

training=# select oficina, ciudad FROM oficinas WHERE objetivo != 800000;
 oficina |   ciudad    
---------+-------------
      22 | Denver
      11 | New York
      13 | Atlanta
      21 | Los Angeles
(4 rows)

-- 2.10- Nom de l'empresa i limit de crèdit del client número 2107.

training=# select empresa, limite_credito FROM clientes WHERE num_clie = 2107;
      empresa      | limite_credito 
-------------------+----------------
 Ace International |       35000.00
(1 row)

-- 2.11- id_fab com a "Identificador del fabricant", id_producto com a "Identificador del producte" i descripcion com a "descripció" dels productes.

training=# select id_fab AS "Identificador del fabricant", id_producto AS "Identificador del producte", descripcion AS "descripció" FROM productos;
 Identificador del fabricant | Identificador del producte |    descripció     
-----------------------------+----------------------------+-------------------
 rei                         | 2a45c                      | V Stago Trinquete
 aci                         | 4100y                      | Extractor
 qsa                         | xk47                       | Reductor
 bic                         | 41672                      | Plate
 imm                         | 779c                       | Riostra 2-Tm
 aci                         | 41003                      | Articulo Tipo 3
 aci                         | 41004                      | Articulo Tipo 4
 bic                         | 41003                      | Manivela
 imm                         | 887p                       | Perno Riostra
 qsa                         | xk48                       | Reductor
 rei                         | 2a44l                      | Bisagra Izqda.
 fea                         | 112                        | Cubierta
 imm                         | 887h                       | Soporte Riostra
 bic                         | 41089                      | Retn
 aci                         | 41001                      | Articulo Tipo 1
 imm                         | 775c                       | Riostra 1-Tm
 aci                         | 4100z                      | Montador
 qsa                         | xk48a                      | Reductor
 aci                         | 41002                      | Articulo Tipo 2
 rei                         | 2a44r                      | Bisagra Dcha.
 imm                         | 773c                       | Riostra 1/2-Tm
 aci                         | 4100x                      | Ajustador
 fea                         | 114                        | Bancada Motor
 imm                         | 887x                       | Retenedor Riostra
 rei                         | 2a44g                      | Pasador Bisagra
(25 rows)

-- 2.12- Identificador del fabricant, identificador del producte i descripció del producte d'aquells productes que el seu identificador de fabricant acabi amb la lletra i.

training=# select id_fab AS "Identificador del fabricant", id_producto AS "Identificador del producte", descripcion AS "descripció" FROM productos WHERE id_fab LIKE '%i';
 Identificador del fabricant | Identificador del producte |    descripció     
-----------------------------+----------------------------+-------------------
 rei                         | 2a45c                      | V Stago Trinquete
 aci                         | 4100y                      | Extractor
 aci                         | 41003                      | Articulo Tipo 3
 aci                         | 41004                      | Articulo Tipo 4
 rei                         | 2a44l                      | Bisagra Izqda.
 aci                         | 41001                      | Articulo Tipo 1
 aci                         | 4100z                      | Montador
 aci                         | 41002                      | Articulo Tipo 2
 rei                         | 2a44r                      | Bisagra Dcha.
 aci                         | 4100x                      | Ajustador
 rei                         | 2a44g                      | Pasador Bisagra
(11 rows)

-- 2.13- Nom i identificador dels venedors que estan per sota la quota i tenen vendes inferiors a 300000.

training=# select nombre, num_empl from repventas where ventas < cuota and ventas < 300000;
    nombre     | num_empl 
---------------+----------
 Bob Smith     |      104
 Nancy Angelli |      107
(2 rows)

-- 2.14- Identificador i nom dels venedors que treballen a les oficines 11 o 13.

training=# select nombre, num_empl from repventas where oficina_rep=11 or oficina_rep=13;
   nombre   | num_empl 
------------+----------
 Bill Adams |      105
 Mary Jones |      109
 Sam Clark  |      106
(3 rows)

-- 2.15- Identificador, descripció i preu dels productes ordenats del més car al més barat.

training=# select id_producto, precio, descripcion from productos order by precio desc;
 id_producto | precio  |    descripcion    
-------------+---------+-------------------
 2a44r       | 4500.00 | Bisagra Dcha.
 2a44l       | 4500.00 | Bisagra Izqda.
 4100y       | 2750.00 | Extractor
 4100z       | 2500.00 | Montador
 779c        | 1875.00 | Riostra 2-Tm
 775c        | 1425.00 | Riostra 1-Tm
 773c        |  975.00 | Riostra 1/2-Tm
 41003       |  652.00 | Manivela
 887x        |  475.00 | Retenedor Riostra
 xk47        |  355.00 | Reductor
 2a44g       |  350.00 | Pasador Bisagra
 887p        |  250.00 | Perno Riostra
 114         |  243.00 | Bancada Motor
 41089       |  225.00 | Retn
 41672       |  180.00 | Plate
 112         |  148.00 | Cubierta
 xk48        |  134.00 | Reductor
 xk48a       |  117.00 | Reductor
 41004       |  117.00 | Articulo Tipo 4
 41003       |  107.00 | Articulo Tipo 3
 2a45c       |   79.00 | V Stago Trinquete
 41002       |   76.00 | Articulo Tipo 2
 41001       |   55.00 | Articulo Tipo 1
 887h        |   54.00 | Soporte Riostra
 4100x       |   25.00 | Ajustador
(25 rows)

-- 2.16- Identificador i descripció de producte amb el valor d'inventari (existencies * preu).

training=# alter table productos add column inventari character varying(50);
ALTER TABLE
training=# UPDATE productos SET inventari = (existencias * precio);
UPDATE 25
training=# select id_producto, descripcion, inventari from productos;
 id_producto |    descripcion    | inventari 
-------------+-------------------+-----------
 2a45c       | V Stago Trinquete | 16590.00
 4100y       | Extractor         | 68750.00
 xk47        | Reductor          | 13490.00
 41672       | Plate             | 0.00
 779c        | Riostra 2-Tm      | 16875.00
 41003       | Articulo Tipo 3   | 22149.00
 41004       | Articulo Tipo 4   | 16263.00
 41003       | Manivela          | 1956.00
 887p        | Perno Riostra     | 6000.00
 xk48        | Reductor          | 27202.00
 2a44l       | Bisagra Izqda.    | 54000.00
 112         | Cubierta          | 17020.00
 887h        | Soporte Riostra   | 12042.00
 41089       | Retn              | 17550.00
 41001       | Articulo Tipo 1   | 15235.00
 775c        | Riostra 1-Tm      | 7125.00
 4100z       | Montador          | 70000.00
 xk48a       | Reductor          | 4329.00
 41002       | Articulo Tipo 2   | 12692.00
 2a44r       | Bisagra Dcha.     | 54000.00
 773c        | Riostra 1/2-Tm    | 27300.00
 4100x       | Ajustador         | 925.00
 114         | Bancada Motor     | 3645.00
 887x        | Retenedor Riostra | 15200.00
 2a44g       | Pasador Bisagra   | 4900.00
(25 rows)

training=# alter table productos drop column inventari;
ALTER TABLE
training=# select * from productos;
 id_fab | id_producto |    descripcion    | precio  | existencias 
--------+-------------+-------------------+---------+-------------
 rei    | 2a45c       | V Stago Trinquete |   79.00 |         210
 aci    | 4100y       | Extractor         | 2750.00 |          25
 qsa    | xk47        | Reductor          |  355.00 |          38
 bic    | 41672       | Plate             |  180.00 |           0
 imm    | 779c        | Riostra 2-Tm      | 1875.00 |           9
 aci    | 41003       | Articulo Tipo 3   |  107.00 |         207
 aci    | 41004       | Articulo Tipo 4   |  117.00 |         139
 bic    | 41003       | Manivela          |  652.00 |           3
 imm    | 887p        | Perno Riostra     |  250.00 |          24
 qsa    | xk48        | Reductor          |  134.00 |         203
 rei    | 2a44l       | Bisagra Izqda.    | 4500.00 |          12
 fea    | 112         | Cubierta          |  148.00 |         115
 imm    | 887h        | Soporte Riostra   |   54.00 |         223
 bic    | 41089       | Retn              |  225.00 |          78
 aci    | 41001       | Articulo Tipo 1   |   55.00 |         277
 imm    | 775c        | Riostra 1-Tm      | 1425.00 |           5
 aci    | 4100z       | Montador          | 2500.00 |          28
 qsa    | xk48a       | Reductor          |  117.00 |          37
 aci    | 41002       | Articulo Tipo 2   |   76.00 |         167
 rei    | 2a44r       | Bisagra Dcha.     | 4500.00 |          12
 imm    | 773c        | Riostra 1/2-Tm    |  975.00 |          28
 aci    | 4100x       | Ajustador         |   25.00 |          37
 fea    | 114         | Bancada Motor     |  243.00 |          15
 imm    | 887x        | Retenedor Riostra |  475.00 |          32
 rei    | 2a44g       | Pasador Bisagra   |  350.00 |          14
(25 rows)

training=# select id_producto, descripcion,(existencias * precio) as inventari from productos;
 id_producto |    descripcion    | inventari 
-------------+-------------------+-----------
 2a45c       | V Stago Trinquete |  16590.00
 4100y       | Extractor         |  68750.00
 xk47        | Reductor          |  13490.00
 41672       | Plate             |      0.00
 779c        | Riostra 2-Tm      |  16875.00
 41003       | Articulo Tipo 3   |  22149.00
 41004       | Articulo Tipo 4   |  16263.00
 41003       | Manivela          |   1956.00
 887p        | Perno Riostra     |   6000.00
 xk48        | Reductor          |  27202.00
 2a44l       | Bisagra Izqda.    |  54000.00
 112         | Cubierta          |  17020.00
 887h        | Soporte Riostra   |  12042.00
 41089       | Retn              |  17550.00
 41001       | Articulo Tipo 1   |  15235.00
 775c        | Riostra 1-Tm      |   7125.00
 4100z       | Montador          |  70000.00
 xk48a       | Reductor          |   4329.00
 41002       | Articulo Tipo 2   |  12692.00
 2a44r       | Bisagra Dcha.     |  54000.00
 773c        | Riostra 1/2-Tm    |  27300.00
 4100x       | Ajustador         |    925.00
 114         | Bancada Motor     |   3645.00
 887x        | Retenedor Riostra |  15200.00
 2a44g       | Pasador Bisagra   |   4900.00
(25 rows)

	
-- 2.17- Vendes de cada oficina en una sola columna i format amb format "<ciutat> te unes vendes de <vendes>", exemple "Denver te unes vendes de 186042.00".

training=# select ciudad, 'te unes vendes de', ventas from oficinas;
   ciudad    |     ?column?      |  ventas   
-------------+-------------------+-----------
 Denver      | te unes vendes de | 186042.00
 New York    | te unes vendes de | 692637.00
 Chicago     | te unes vendes de | 735042.00
 Atlanta     | te unes vendes de | 367911.00
 Los Angeles | te unes vendes de | 835915.00
(5 rows)

training=# select ciudad || ' te unes ventes de ' || ventas from oficinas; 
                ?column?                 
-----------------------------------------
 Denver te unes ventes de 186042.00
 New York te unes ventes de 692637.00
 Chicago te unes ventes de 735042.00
 Atlanta te unes ventes de 367911.00
 Los Angeles te unes ventes de 835915.00
(5 rows)

training=# 

-- 2.18- Codis d'empleats que són directors d'oficines.

training=# select dir from oficinas;
 dir 
-----
 108
 106
 104
 105
 108
(5 rows)


-- 2.19- Identificador i ciutat de les oficines que tinguin ventes per sota el 80% del seu objectiu.

training=# select oficina, ciudad from oficinas where ventas < objetivo * 0.8;
 oficina | ciudad 
---------+--------
      22 | Denver
(1 row)

-- 2.20- Identificador, ciutat i director de les oficines que no siguin dirigides per l'empleat 108.

training=# select oficina, ciudad, dir from oficinas where dir != 108;
 oficina |  ciudad  | dir 
---------+----------+-----
      11 | New York | 106
      12 | Chicago  | 104
      13 | Atlanta  | 105
(3 rows)

-- 2.21- Identificadors i noms dels venedors amb vendes entre el 80% i el 120% de llur quota.

 training=# select num_empl, nombre from repventas where ventas > cuota * 0.8 and ventas < cuota * 1.2; 
 num_empl |   nombre    
----------+-------------
      105 | Bill Adams
      106 | Sam Clark
      101 | Dan Roberts
      108 | Larry Fitch
      103 | Paul Cruz
(5 rows)

-- 2.22- Identificador, vendes i ciutat de cada oficina ordenades alfabèticament per regió i, dintre de cada regió ordenades per ciutat.

training=# select oficina, ventas, region, ciudad from oficinas order by region, ciudad;
 oficina |  ventas   |   ciudad    
---------+-----------+-------------
      13 | 367911.00 | Atlanta
      12 | 735042.00 | Chicago
      11 | 692637.00 | New York
      22 | 186042.00 | Denver
      21 | 835915.00 | Los Angeles
(5 rows)

-- 2.23- Llista d'oficines classificades alfabèticament per regió i, per cada regió, en ordre descendent de rendiment de vendes (vendes-objectiu).

training=# select oficina, region, (ventas-objetivo) as "rendimiento de ventas" from oficinas;
 oficina | region | rendimiento de ventas 
---------+--------+-----------------------
      22 | Oeste  |            -113958.00
      11 | Este   |             117637.00
      12 | Este   |             -64958.00
      13 | Este   |              17911.00
      21 | Oeste  |             110915.00
(5 rows)

-- 2.24- Codi i nom dels tres venedors que tinguin unes vendes superiors.

training=# select num_empl, nombre, ventas from repventas order by ventas desc limit 3;
 num_empl |   nombre   |  ventas   
----------+------------+-----------
      102 | Sue Smith  | 474050.00
      109 | Mary Jones | 392725.00
      105 | Bill Adams | 367911.00
(3 rows)


-- 2.25- Nom i data de contracte dels empleats que les seves vendes siguin superiors a 500000.

training=# select nombre, contrato, ventas from repventas where ventas > 500000;
 nombre | contrato | ventas 
--------+----------+--------
(0 rows)

-- 2.26- Nom i quota actual dels venedors amb el calcul d'una "nova possible quota" que serà la quota de cada venedor augmentada un 3 per cent de les seves propies vendes.

training=# select nombre, cuota, (cuota + ventas * 0.03) as "nova possible quota" from repventas;
    nombre     |   cuota   | nova possible quota 
---------------+-----------+---------------------
 Bill Adams    | 350000.00 |         361037.3300
 Mary Jones    | 300000.00 |         311781.7500
 Sue Smith     | 350000.00 |         364221.5000
 Sam Clark     | 275000.00 |         283997.3600
 Bob Smith     | 200000.00 |         204277.8200
 Dan Roberts   | 300000.00 |         309170.1900
 Tom Snyder    |           |                    
 Larry Fitch   | 350000.00 |         360855.9500
 Paul Cruz     | 275000.00 |         283603.2500
 Nancy Angelli | 300000.00 |         305581.2600
(10 rows)

-- 2.27- Identificador i nom de les oficines que les seves vendes estan per sota del 80% de l'objectiu.

training=# select oficina, ciudad from oficinas where ventas < objetivo * 0.8;
 oficina | ciudad 
---------+--------
      22 | Denver
(1 row)

-- 2.28- Numero i import de les comandes que el seu import oscil·li entre 20000 i 29999.

training=# select num_pedido, importe from pedidos where importe between 20000 and 29999;
 num_pedido | importe  
------------+----------
     110036 | 22500.00
     112987 | 27500.00
     113042 | 22500.00
(3 rows)

-- 2.29- Nom, ventes i quota dels venedors que les seves vendes no estan entre el 80% i el 120% de la seva quota.

training=# select nombre, ventas, cuota from repventas where ventas not between cuota * 0.8 and cuota * 1.2;
    nombre     |  ventas   |   cuota   
---------------+-----------+-----------
 Mary Jones    | 392725.00 | 300000.00
 Sue Smith     | 474050.00 | 350000.00
 Bob Smith     | 142594.00 | 200000.00
 Nancy Angelli | 186042.00 | 300000.00
(4 rows)

-- 2.30- Nom de l'empresa i el seu limit de crèdit, de les empreses que el seu nom comença per Smith.

training=# select empresa, limite_credito from clientes  where empresa like 'Smith%';
    empresa     | limite_credito 
----------------+----------------
 Smithson Corp. |       20000.00
(1 row)

-- 2.31- Identificador i nom dels venedors que no tenen assignada oficina.



-- 2.32- Identificador i nom dels venedors, amb l'identificador de l'oficina d'aquells venedors que tenen una oficina assignada.



-- 2.33- Identificador i descripció dels productes del fabricant identificat per imm dels quals hi hagin existències superiors o iguals 200, també del fabricant bic amb existències superiors o iguals a 50.



-- 2.34- Identificador i nom dels venedors que treballen a les oficines 11, 12 o 22 i compleixen algun dels següents supòsits:
-- a) han estat contractats a partir de juny del 1988 i no tenen director
-- b) estan per sobre la quota però tenen vendes de 600000 o menors.



-- 2.35- Identificador i descripció dels productes amb un preu superior a 1000 i siguin del fabricant amb identificador rei o les existències siguin superiors a 20.



-- 2.36- Identificador del fabricant,identificador i descripció dels productes amb fabricats pels fabricants que tenen una lletra qualsevol, una lletra 'i' i una altre lletra qualsevol com a identificador de fabricant.



-- 2.37- Identificador i descripció dels productes que la seva descripció comenÃ§a per "art" sense tenir en compte les majúscules i minúscules.



-- 2.38- Identificador i nom dels clients que la segona lletra del nom sigui una "a" minúscula o majuscula.



-- 2.39- Identificador i ciutat de les oficines que compleixen algun dels següents supòsits:
-- a) És de la regió est amb unes vendes inferiors a 700000.
-- b) És de la regió oest amb unes vendes inferiors a 600000.



-- 2.40- Identificador del fabricant, identificació i descripció dels productes que compleixen tots els següents supòsits:
-- a) L'identificador del fabricant és "imm" o el preu és menor a 500.
-- b) Les existències són inferiors a 5 o el producte te l'identificador 41003.  

-- 2.41- Identificador de les comandes del fabricant amb identificador "rei" amb una quantitat superior o igual a 10 o amb un import superior o igual a 10000.



-- 2.42- Data de les comandes amb una quantitat superior a 20 i un import superior a 1000 dels clients 2102, 2106 i 2109.



-- 2.43- Identificador dels clients que el seu nom no conté " Corp." o " Inc." amb crèdit major a 30000.



-- 2.44- Identificador dels representants de vendes majors de 40 anys amb vendes inferiors a 400000.



-- 2.45- Identificador dels representants de vendes menors de 35 anys amb vendes superiors a 350000.

