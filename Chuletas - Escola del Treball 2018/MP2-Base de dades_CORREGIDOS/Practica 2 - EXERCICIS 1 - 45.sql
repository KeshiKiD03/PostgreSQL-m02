-- 2.1- Els identificadors de les oficines amb la seva ciutat, els objectius i les vendes reals.

training=# SELECT oficina , ciudad , objetivo , ventas FROM oficinas;           
oficina |   ciudad    | objetivo  |  ventas   
---------+-------------+-----------+-----------
      22 | Denver      | 300000.00 | 186042.00
      11 | New York    | 575000.00 | 692637.00
      12 | Chicago     | 800000.00 | 735042.00
      13 | Atlanta     | 350000.00 | 367911.00
      21 | Los Angeles | 725000.00 | 835915.00
(5 rows)

-- 2.2- Els identificadors de les oficines de la regió est amb la seva ciutat, els objectius i les vendes reals.

training=# SELECT oficina , ciudad , objetivo , ventas FROM oficinas WHERE region = 'Este'; 
 oficina |  ciudad  | objetivo  |  ventas   
---------+----------+-----------+-----------
      11 | New York | 575000.00 | 692637.00
      12 | Chicago  | 800000.00 | 735042.00
      13 | Atlanta  | 350000.00 | 367911.00
(3 rows)

-- 2.3- Les ciutats en ordre alfabètic de les oficines de la regió est amb els objectius i les vendes reals.

training=# SELECT ciudad , objetivo , ventas FROM oficinas WHERE region = 'Este' ORDER BY ciudad; 
  ciudad  | objetivo  |  ventas   
----------+-----------+-----------
 Atlanta  | 350000.00 | 367911.00
 Chicago  | 800000.00 | 735042.00
 New York | 575000.00 | 692637.00
(3 rows)

-- 2.4- Les ciutats, els objectius i les vendes d'aquelles oficines que les seves vendes superin els seus objectius.

training=# SELECT ciudad , objetivo , ventas FROM oficinas WHERE ventas > objetivo; 
   ciudad    | objetivo  |  ventas   
-------------+-----------+-----------
 New York    | 575000.00 | 692637.00
 Atlanta     | 350000.00 | 367911.00
 Los Angeles | 725000.00 | 835915.00
(3 rows)

-- 2.5- Nom, quota i vendes de l'empleat representant de vendes número 107.

training# SELECT nombre , cuota , ventas  FROM repventas WHERE num_empl = 107 ;
    nombre     |   cuota   |  ventas   
---------------+-----------+-----------
 Nancy Angelli | 300000.00 | 186042.00
(1 row)



-- 2.6- Nom i data de contracte dels representants de vendes amb vendes superiors a 300000.

training=# SELECT nombre , contrato FROM repventas WHERE ventas > 300000 ;
   nombre    |  contrato  
-------------+------------
 Bill Adams  | 1988-02-12
 Mary Jones  | 1989-10-12
 Sue Smith   | 1986-12-10
 Dan Roberts | 1986-10-20
 Larry Fitch | 1989-10-12
(5 rows)

-- 2.7- Nom dels representants de vendes dirigits per l'empleat numero 104 Bob Smith.

training=# SELECT nombre FROM repventas WHERE director = 104;
   nombre    
-------------
 Bill Adams
 Dan Roberts
 Paul Cruz
(3 rows)


-- 2.8- Nom dels venedors i data de contracte d'aquells que han estat contractats abans del 1988.

training=# SELECT nombre , contrato  FROM repventas WHERE contrato < '1988-01-01';
   nombre    |  contrato  
-------------+------------
 Sue Smith   | 1986-12-10
 Bob Smith   | 1987-05-19
 Dan Roberts | 1986-10-20
 Paul Cruz   | 1987-03-01
(4 rows)



-- 2.9- Identificador de les oficines i ciutat d'aquelles oficines que el seu objectiu és diferent a 800000.

training=# select oficina , ciudad FROM oficinas WHERE objetivo != 800000.00;
 oficina |   ciudad    
---------+-------------
      22 | Denver
      11 | New York
      13 | Atlanta
      21 | Los Angeles
(4 rows)


-- 2.10- Nom de l'empresa i limit de crèdit del client número 2107.

training=# SELECT empresa , limite_credito  FROM clientes WHERE num_clie = 2107;
      empresa      | limite_credito 
-------------------+----------------
 Ace International |       35000.00
(1 row)


-- 2.11- id_fab com a "Identificador del fabricant", id_producto com a "Identificador del producte" i descripcion com a "descripció" dels productes.

training=# SELECT id_fab AS "Identificador del fabricant" , id_producto AS "Identificador del producte" , descripcion AS "descripció" FROM productos ;
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

training=# SELECT id_fab AS "Identificador del fabricant" , id_producto AS "Identificador del producte" , 
descripcion AS "descripció" 
FROM productos 
WHERE id_fab LIKE '%i';
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

training=# SELECT nombre , num_empl FROM repventas WHERE cuota > ventas AND ventas < 300000;
    nombre     | num_empl 
---------------+----------
 Bob Smith     |      104
 Nancy Angelli |      107
(2 rows)

-- 2.14- Identificador i nom dels venedors que treballen a les oficines 11 o 13.

training=# SELECT num_empl , nombre FROM repventas WHERE oficina_rep = 11 OR oficina_rep = 13 ;
 num_empl |   nombre   
----------+------------
      105 | Bill Adams
      109 | Mary Jones
      106 | Sam Clark
(3 rows)

-- 2.15- Identificador, descripció i preu dels productes ordenats del més car al més barat.

training=# SELECT id_producto , descripcion , precio FROM productos ORDER BY precio DESC;
 id_producto |    descripcion    | precio  
-------------+-------------------+---------
 2a44r       | Bisagra Dcha.     | 4500.00
 2a44l       | Bisagra Izqda.    | 4500.00
 4100y       | Extractor         | 2750.00
 4100z       | Montador          | 2500.00
 779c        | Riostra 2-Tm      | 1875.00
 775c        | Riostra 1-Tm      | 1425.00
 773c        | Riostra 1/2-Tm    |  975.00
 41003       | Manivela          |  652.00
 887x        | Retenedor Riostra |  475.00
 xk47        | Reductor          |  355.00
 2a44g       | Pasador Bisagra   |  350.00
 887p        | Perno Riostra     |  250.00
 114         | Bancada Motor     |  243.00
 41089       | Retn              |  225.00
 41672       | Plate             |  180.00
 112         | Cubierta          |  148.00
 xk48        | Reductor          |  134.00
 xk48a       | Reductor          |  117.00
 41004       | Articulo Tipo 4   |  117.00
 41003       | Articulo Tipo 3   |  107.00
 2a45c       | V Stago Trinquete |   79.00
 41002       | Articulo Tipo 2   |   76.00
 41001       | Articulo Tipo 1   |   55.00
 887h        | Soporte Riostra   |   54.00
 4100x       | Ajustador         |   25.00
(25 rows)

-- 2.16- Identificador i descripció de producte amb el valor d'inventari (existencies * preu).

--training=# ALTER TABLE productos ADD COLUMN inventari character varying (50);
--ALTER TABLE
--training=# UPDATE productos SET inventari = existencias * precio;
--UPDATE 25
--training=# SELECT id_producto , descripcion , inventari FROM productos ;
-- id_producto |    descripcion    | inventari 
---------------+-------------------+-----------
-- 2a45c       | V Stago Trinquete | 16590.00
-- 4100y       | Extractor         | 68750.00
-- xk47        | Reductor          | 13490.00
-- 41672       | Plate             | 0.00
-- 779c        | Riostra 2-Tm      | 16875.00
-- 41003       | Articulo Tipo 3   | 22149.00
-- 41004       | Articulo Tipo 4   | 16263.00
-- 41003       | Manivela          | 1956.00
-- 887p        | Perno Riostra     | 6000.00
-- xk48        | Reductor          | 27202.00
-- 2a44l       | Bisagra Izqda.    | 54000.00
-- 112         | Cubierta          | 17020.00
-- 887h        | Soporte Riostra   | 12042.00
-- 41089       | Retn              | 17550.00
-- 41001       | Articulo Tipo 1   | 15235.00
-- 775c        | Riostra 1-Tm      | 7125.00
-- 4100z       | Montador          | 70000.00
-- xk48a       | Reductor          | 4329.00
-- 41002       | Articulo Tipo 2   | 12692.00
-- 2a44r       | Bisagra Dcha.     | 54000.00
-- 773c        | Riostra 1/2-Tm    | 27300.00
-- 4100x       | Ajustador         | 925.00
-- 114         | Bancada Motor     | 3645.00
-- 887x        | Retenedor Riostra | 15200.00
-- 2a44g       | Pasador Bisagra   | 4900.00
--(25 rows)

training=# SELECT id_producto , descripcion , (existencias * precio) AS inventari FROM productos ;

-- 2.17- Vendes de cada oficina en una sola columna i format amb format "<ciutat> te unes vendes de <vendes>", 
--		 exemple "Denver te unes vendes de 186042.00".

training=# SELECT ciudad , 'te unes vendes de' , ventas FROM oficinas ;
   ciudad    |     ?column?      |  ventas   
-------------+-------------------+-----------
 Denver      | te unes vendes de | 186042.00
 New York    | te unes vendes de | 692637.00
 Chicago     | te unes vendes de | 735042.00
 Atlanta     | te unes vendes de | 367911.00
 Los Angeles | te unes vendes de | 835915.00
(5 rows)

training=# SELECT ciudad || ' te unes vendes de ' || ventas FROM oficinas ;
                ?column?                 
-----------------------------------------
 Denver te unes vendes de 186042.00
 New York te unes vendes de 692637.00
 Chicago te unes vendes de 735042.00
 Atlanta te unes vendes de 367911.00
 Los Angeles te unes vendes de 835915.00
(5 rows)



-- 2.18- Codis d'empleats que són directors d'oficines.

training=# SELECT dir FROM oficinas;
 dir 
-----
 108
 106
 104
 105
 108
(5 rows)

-- 2.19- Identificador i ciutat de les oficines que tinguin ventes per sota el 80% del seu objectiu.

training=# SELECT oficina , ciudad FROM oficinas WHERE ventas < 0.8 * objetivo;
 oficina | ciudad 
---------+--------
      22 | Denver
(1 row)

-- 2.20- Identificador, ciutat i director de les oficines que no siguin dirigides per l'empleat 108.

training=# SELECT oficina , ciudad , dir FROM oficinas WHERE dir != 108;
 oficina |  ciudad  | dir 
---------+----------+-----
      11 | New York | 106
      12 | Chicago  | 104
      13 | Atlanta  | 105
(3 rows)


-- 2.21- Identificadors i noms dels venedors amb vendes entre el 80% i el 120% de llur quota.

training=# SELECT num_empl , nombre FROM repventas WHERE ventas BETWEEN 0.8*cuota AND 1.2*cuota ;
 num_empl |   nombre    
----------+-------------
      105 | Bill Adams
      106 | Sam Clark
      101 | Dan Roberts
      108 | Larry Fitch
      103 | Paul Cruz
(5 rows)



-- 2.22- Identificador, vendes i ciutat de cada oficina ordenades alfabèticament per regió i, 
--		 dintre de cada regió ordenades per ciutat.

training=# SELECT oficina , ventas , ciudad FROM oficinas ORDER BY region , ciudad;
 oficina |  ventas   |   ciudad    
---------+-----------+-------------
      13 | 367911.00 | Atlanta
      12 | 735042.00 | Chicago
      11 | 692637.00 | New York
      22 | 186042.00 | Denver
      21 | 835915.00 | Los Angeles
(5 rows)


-- 2.23- Llista d'oficines classificades alfabèticament per regió i, per cada regió, 
--		 en ordre descendent de rendiment de vendes (vendes-objectiu).

training=# SELECT ciudad FROM oficinas ORDER BY region , (ventas - objetivo) DESC;
   ciudad    
-------------
 New York
 Atlanta
 Chicago
 Los Angeles
 Denver
(5 rows)


-- 2.24- Codi i nom dels tres venedors que tinguin unes vendes superiors.

training=# SELECT num_empl , nombre FROM repventas ORDER BY ventas DESC LIMIT 3;
 num_empl |   nombre   
----------+------------
      102 | Sue Smith
      109 | Mary Jones
      105 | Bill Adams
(3 rows)


-- 2.25- Nom i data de contracte dels empleats que les seves vendes siguin superiors a 500000.

training=# SELECT nombre , contrato FROM repventas WHERE ventas > 500000 ;
 nombre | contrato 
--------+----------
(0 rows)


-- 2.26- Nom i quota actual dels venedors amb el calcul d'una "nova possible quota" que serà la quota de 
--		 cada venedor augmentada un 3 per cent de les seves propies vendes.

training=# SELECT nombre , cuota , (cuota + ventas * 0.03) AS "nova possible quota" FROM repventas ;
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

training=# SELECT oficina , ciudad FROM oficinas WHERE ventas < 0.8 * objetivo;
 oficina | ciudad 
---------+--------
      22 | Denver
(1 row)


-- 2.28- Numero i import de les comandes que el seu import oscil·li entre 20000 i 29999.

training=# SELECT num_pedido , importe FROM pedidos WHERE (importe >= 20000 AND importe <30000);
 num_pedido | importe  
------------+----------
     110036 | 22500.00
     112987 | 27500.00
     113042 | 22500.00
(3 rows)


-- 2.29- Nom, ventes i quota dels venedors que les seves vendes no estan entre el 80% i el 120% de la seva quota.

training=# SELECT nombre , ventas , cuota FROM repventas WHERE ventas NOT BETWEEN 0.8*cuota AND 1.2*cuota ;
    nombre     |  ventas   |   cuota   
---------------+-----------+-----------
 Mary Jones    | 392725.00 | 300000.00
 Sue Smith     | 474050.00 | 350000.00
 Bob Smith     | 142594.00 | 200000.00
 Nancy Angelli | 186042.00 | 300000.00
(4 rows)


-- 2.30- Nom de l'empresa i el seu limit de crèdit, de les empreses que el seu nom comença per Smith.

training=# SELECT empresa , limite_credito FROM clientes WHERE empresa LIKE 'Smith%';
    empresa     | limite_credito 
----------------+----------------
 Smithson Corp. |       20000.00
(1 row)


-- 2.31- Identificador i nom dels venedors que no tenen assignada oficina.

training=# SELECT num_empl , nombre FROM repventas WHERE oficina_rep IS NULL; 
 num_empl |   nombre   
----------+------------
      110 | Tom Snyder
(1 row)


-- 2.32- Identificador i nom dels venedors, amb l'identificador de l'oficina d'aquells venedors que tenen una oficina assignada.

training=# SELECT num_empl , nombre , oficina_rep FROM repventas WHERE oficina_rep  IS NOT NULL; 
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


-- 2.33- Identificador i descripció dels productes del fabricant identificat per imm dels quals hi hagin existències 
--		 superiors o iguals 200, també del fabricant bic amb existències superiors o iguals a 50.

training=# SELECT id_producto , descripcion FROM productos 
training-# WHERE id_fab = 'imm' AND existencias >= 200 OR id_fab = 'bic' AND existencias >= 50; 
 id_producto |   descripcion   
-------------+-----------------
 887h        | Soporte Riostra
 41089       | Retn
(2 rows)


-- 2.34- Identificador i nom dels venedors que treballen a les oficines 11, 12 o 22 i compleixen algun dels següents supòsits:
-- a) han estat contractats a partir de juny del 1988 i no tenen director
-- b) estan per sobre la quota però tenen vendes de 600000 o menors.

training=# SELECT num_empl , nombre FROM repventas
training-# WHERE (oficina_rep = 11 OR oficina_rep =12 OR oficina_rep = 22) AND
training-# ((contrato >= '1988-06-01' AND director IS NULL) OR (ventas > cuota AND ventas <= 600000));                                                 
 num_empl |   nombre    
----------+-------------
      109 | Mary Jones
      106 | Sam Clark
      101 | Dan Roberts
      103 | Paul Cruz
(4 rows)




-- 2.35- Identificador i descripció dels productes amb un preu superior a 1000 i siguin del fabricant amb 
-- 		 identificador rei o les existències siguin superiors a 20.

training=# SELECT id_producto , descripcion FROM productos WHERE precio > 1000 AND (id_fab = 'rei' OR existencias > 20);
 id_producto |  descripcion   
-------------+----------------
 4100y       | Extractor
 2a44l       | Bisagra Izqda.
 4100z       | Montador
 2a44r       | Bisagra Dcha.
(4 rows)


-- 2.36- Identificador del fabricant,identificador i descripció dels productes amb fabricats 
--		 pels fabricants que tenen una lletra qualsevol, una lletra 'i' i una altre lletra qualsevol com a 
--		 identificador de fabricant.

training=# SELECT id_fab , id_producto , descripcion FROM productos WHERE id_fab LIKE '_i_';
 id_fab | id_producto | descripcion 
--------+-------------+-------------
 bic    | 41672       | Plate
 bic    | 41003       | Manivela
 bic    | 41089       | Retn
(3 rows)


-- 2.37- Identificador i descripció dels productes que la seva descripció comença per "art" 
--		 sense tenir en compte les majúscules i minúscules.

training=# SELECT id_producto , descripcion FROM productos WHERE descripcion ILIKE 'art%';
 id_producto |   descripcion   
-------------+-----------------
 41003       | Articulo Tipo 3
 41004       | Articulo Tipo 4
 41001       | Articulo Tipo 1
 41002       | Articulo Tipo 2
(4 rows)


-- 2.38- Identificador i nom dels clients que la segona lletra del nom sigui una "a" minúscula o majuscula.

training=# SELECT num_clie , empresa FROM clientes WHERE empresa ILIKE '_a%';
 num_clie |     empresa     
----------+-----------------
     2123 | Carter & Sons
     2113 | Ian & Schmidt
     2105 | AAA Investments
(3 rows)


-- 2.39- Identificador i ciutat de les oficines que compleixen algun dels següents supòsits:
-- 	a) És de la regió est amb unes vendes inferiors a 700000.
-- 	b) És de la regió oest amb unes vendes inferiors a 600000.

training=# SELECT oficina , ciudad , region , ventas FROM oficinas WHERE (region = 'Este' AND ventas < 700000) OR 
training-# (region = 'Oeste' and ventas < 600000);
 oficina |  ciudad  | region |  ventas   
---------+----------+--------+-----------
      22 | Denver   | Oeste  | 186042.00
      11 | New York | Este   | 692637.00
      13 | Atlanta  | Este   | 367911.00
(3 rows)


-- 2.40- Identificador del fabricant, identificació i descripció dels productes que compleixen tots els següents supòsits:
-- 	a) L'identificador del fabricant és "imm" o el preu és menor a 500.
-- 	b) Les existències són inferiors a 5 o el producte te l'identificador 41003.  

training=# SELECT id_fab , id_producto , descripcion FROM productos WHERE (id_fab = 'imm' OR precio < 500) AND 
training-# (existencias < 5 OR id_producto = '41003')  ;
 id_fab | id_producto |   descripcion   
--------+-------------+-----------------
 bic    | 41672       | Plate
 aci    | 41003       | Articulo Tipo 3
(2 rows)


-- 2.41- Identificador de les comandes del fabricant amb identificador "rei" amb una quantitat superior o 
--		 igual a 10 o amb un import superior o igual a 10000.

training=# SELECT num_pedido , fab , cant FROM pedidos WHERE fab = 'rei' AND (cant >= 10 OR importe >= 10000);
 num_pedido | fab | cant 
------------+-----+------
     112961 | rei |    7
     113045 | rei |   10
     112993 | rei |   24
     113042 | rei |    5
(4 rows)

-- 2.42- Data de les comandes amb una quantitat superior a 20 i un import superior a 1000 dels clients 2102, 2106 i 2109.

training=# SELECT fecha_pedido , cant , importe , clie FROM pedidos WHERE (cant > 20 AND importe > 1000) AND 
training-# (clie = 2102 OR clie = 2106 or clie = 2109); 
 fecha_pedido | cant | importe  | clie 
--------------+------+----------+------
 1989-10-12   |   34 |  3978.00 | 2102
 1990-03-02   |   22 | 31350.00 | 2109
 1989-01-04   |   24 |  1896.00 | 2106
(3 rows)


-- 2.43- Identificador dels clients que el seu nom no conté " Corp." o " Inc." amb crèdit major a 30000.

training=# SELECT num_clie , empresa , limite_credito FROM clientes 
training-# WHERE (empresa NOT LIKE '%Corp.' AND empresa NOT LIKE '%Inc.') AND limite_credito > 30000;
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


-- 2.44- Identificador dels representants de vendes majors de 40 anys amb vendes inferiors a 400000.

training=# SELECT num_empl , edad , ventas FROM repventas WHERE edad > 40 AND ventas < 400000;
 num_empl | edad |  ventas   
----------+------+-----------
      106 |   52 | 299912.00
      101 |   45 | 305673.00
      110 |   41 |  75985.00
      108 |   62 | 361865.00
      107 |   49 | 186042.00
(5 rows)


-- 2.45- Identificador dels representants de vendes menors de 35 anys amb vendes superiors a 350000.

training=# SELECT num_empl , edad , ventas FROM repventas WHERE edad < 35 AND ventas > 350000;
 num_empl | edad |  ventas   
----------+------+-----------
      109 |   31 | 392725.00
(1 row)


