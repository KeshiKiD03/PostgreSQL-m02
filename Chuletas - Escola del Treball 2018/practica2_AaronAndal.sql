-- 2.1- Els identificadors de les oficines amb la seva ciutat, els objectius i les vendes reals.

SELECT oficinas, ciudad, objetivo, ventas FROM oficinas;


-- 2.2- Els identificadors de les oficines de la regió est amb la seva ciutat, els objectius i les vendes reals.

SELECT * FROM oficinas WHERE region = ‘Este’;


-- 2.3- Les ciutats en ordre alfabètic de les oficines de la regió est amb els objectius i les vendes reals.

SELECT objetivo, ciudad, ventas FROM oficinas WHERE region = ‘Este’ ORDER BY ciudad;


-- 2.4- Les ciutats, els objectius i les vendes d'aquelles oficines que les seves vendes superin els seus objectius.

SELECT ciudad, objetivo, ventas FROM oficinas WHERE ventas > objetivo;


-- 2.5- Nom, quota i vendes de l'empleat representant de vendes número 107.

SELECT nombre, cuota, ventas, num_empl FROM repventas WHERE num_empl = 107;


-- 2.6- Nom i data de contracte dels representants de vendes amb vendes superiors a 300000.

SELECT nombre, contrato, ventas FROM repventas WHERE ventas > 300000;


-- 2.7- Nom dels representants de vendes dirigits per l'empleat numero 104 Bob Smith.

SELECT * FROM repventas WHERE num_empl = 104;


-- 2.8- Nom dels venedors i data de contracte d'aquells que han estat contractats abans del 1988.

SELECT * nombre, contrato FROM repventas WHERE contrato < ‘1998-01-01’;


-- 2.9- Identificador de les oficines i ciutat d'aquelles oficines que el seu objectiu és diferent a 800000.

SELECT  oficina, ciudad, ventas, objetivo FROM oficinas WHERE ventas < 0.8*objetivo;


-- 2.10- Nom de l'empresa i limit de crèdit del client número 2107.

SELECT empresa, limite_credito FROM clientes WHERE num_clie = 2107;


-- 2.11- id_fab com a "Identificador del fabricant", id_producto com a "Identificador del producte" i descripcion com a "descripció" dels productes.

SELECT id_fab AS "Identificador del fabricant", id_producto AS "Identificador del producte", descripcion AS "descripció" FROM productos;


-- 2.12- Identificador del fabricant, identificador del producte i descripció del producte d'aquells productes que el seu identificador de fabricant acabi amb la lletra i.

SELECT id_fab, id_producto, descripcion FROM productos WHERE id_fab LIKE ‘%i’;


-- 2.13- Nom i identificador dels venedors que estan per sota la quota i tenen vendes inferiors a 300000.

SELECT nombre, num_empl FROM repventas WHERE cuota > ventas AND ventas < 300000;


-- 2.14- Identificador i nom dels venedors que treballen a les oficines 11 o 13.

SELECT num_empl, nombre FROM repventas WHERE oficina_rep = 11 OR oficina_rep = 13;


-- 2.15- Identificador, descripció i preu dels productes ordenats del més car al més barat.

SELECT id_producto, descripcion, precio FROM productos ORDER BY precio DESC;


-- 2.16- Identificador i descripció de producte amb el valor d'inventari (existencies * preu).

SELECT id_producto, descripcion, existencias*precio AS "Valor d'inventari" FROM productos;


-- -- 2.17- Vendes de cada oficina en una sola columna i format amb format "<ciutat> te unes vendes de <vendes>", exemple "Denver te unes vendes de 186042.00".

SELECT ciudad || ' te unes vendes de ' || ventas FROM oficinas;


-- 2.18- Codis d'empleats que són directors d'oficines.

SELECT DISTINCT dir FROM oficinas;


-- 2.19- Identificador i ciutat de les oficines que tinguin ventes per sota el 80% del seu objectiu.

SELECT oficina, ciudad FROM oficinas WHERE ventas < 0.8*objetivo;


-- 2.20- Identificador, ciutat i director de les oficines que no siguin dirigides per l'empleat 108.

SELECT oficina, ciudad, dir FROM oficinas WHERE NOT dir = 108;

SELECT oficina, ciudad, dir FROM oficinas WHERE dir != 108;


-- 2.21- Identificadors i noms dels venedors amb vendes entre el 80% i el 120% de llur quota.

SELECT num_empl, nombre FROM repventas WHERE ventas > 0.8*cuota AND ventas < 1.2*cuota;


-- 2.22- Identificador, vendes i ciutat de cada oficina ordenades alfabèticament per regió i, dintre de cada regió ordenades per ciutat.

SELECT oficina, ventas, ciudad FROM oficinas ORDER BY region ASC, ciudad ASC;


-- 2.23- Llista d'oficines classificades alfabèticament per regió i, per cada regió, en ordre descendent de rendiment de vendes (vendes-objectiu).

SELECT oficina, ventas-objetivo AS "Rendiment de ventas" FROM oficinas ORDER BY region ASC, ventas-objetivo DESC;

 oficina | Rendiment de ventas 
---------+---------------------
      11 |           117637.00
      13 |            17911.00
      12 |           -64958.00
      21 |           110915.00
      22 |          -113958.00
(5 rows)


-- 2.24- Codi i nom dels tres venedors que tinguin unes vendes superiors.

SELECT num_empl, nombre FROM repventas WHERE ventas > cuota LIMIT 3;

num_empl |   nombre   
----------+------------
      105 | Bill Adams
      109 | Mary Jones
      102 | Sue Smith
(3 rows)


-- 2.25- Nom i data de contracte dels empleats que les seves vendes siguin superiors a 500000.

SELECT nombre, contrato FROM repventas WHERE ventas > 500000;

 nombre | contrato 
--------+----------
(0 rows)


-- 2.26- Nom i quota actual dels venedors amb el calcul d'una "nova possible quota" que serà la quota de cada venedor augmentada un 3 per cent de les seves propies vendes.

SELECT nombre, cuota, (cuota + ventas * 0.03) AS "Nova cuota +3%" FROM repventas;

    nombre     |   cuota   | Nova cuota +3% 
---------------+-----------+----------------
 Bill Adams    | 350000.00 |    361037.3300
 Mary Jones    | 300000.00 |    311781.7500
 Sue Smith     | 350000.00 |    364221.5000
 Sam Clark     | 275000.00 |    283997.3600
 Bob Smith     | 200000.00 |    204277.8200
 Dan Roberts   | 300000.00 |    309170.1900
 Tom Snyder    |           |               
 Larry Fitch   | 350000.00 |    360855.9500
 Paul Cruz     | 275000.00 |    283603.2500
 Nancy Angelli | 300000.00 |    305581.2600
(10 rows)


-- 2.27- Identificador i nom de les oficines que les seves vendes estan per sota del 80% de l'objectiu.

SELECT oficina, ciudad FROM oficinas WHERE ventas < (0.8*objetivo);

 oficina | ciudad 
---------+--------
      22 | Denver
(1 row)


-- 2.28- Numero i import de les comandes que el seu import oscil·li entre 20000 i 29999.

SELECT cant, importe FROM pedidos WHERE importe BETWEEN 20000 AND 29999;

 cant | importe  
------+----------
    9 | 22500.00
   11 | 27500.00
    5 | 22500.00
(3 rows)

SELECT cant, importe FROM pedidos WHERE importe >= 20000 AND importe <= 29999;

 cant | importe  
------+----------
    9 | 22500.00
   11 | 27500.00
    5 | 22500.00
(3 rows)



-- 2.29- Nom, ventes i quota dels venedors que les seves vendes no estan entre el 80% i el 120% de la seva quota.

SELECT nombre, ventas, cuota FROM repventas WHERE ventas NOT BETWEEN 0.8*cuota AND 1.2*cuota;

    nombre     |  ventas   |   cuota   
---------------+-----------+-----------
 Mary Jones    | 392725.00 | 300000.00
 Sue Smith     | 474050.00 | 350000.00
 Bob Smith     | 142594.00 | 200000.00
 Nancy Angelli | 186042.00 | 300000.00
(4 rows)

SELECT nombre, ventas, cuota FROM repventas WHERE NOT (ventas >= 0.8*cuota AND ventas <= 1.2*cuota);

    nombre     |  ventas   |   cuota   
---------------+-----------+-----------
 Mary Jones    | 392725.00 | 300000.00
 Sue Smith     | 474050.00 | 350000.00
 Bob Smith     | 142594.00 | 200000.00
 Nancy Angelli | 186042.00 | 300000.00
(4 rows)


-- 2.30- Nom de l'empresa i el seu limit de crèdit, de les empreses que el seu nom comença per Smith.

SELECT empresa, limite_credito FROM clientes WHERE empresa LIKE 'Smith%';

    empresa     | limite_credito 
----------------+----------------
 Smithson Corp. |       20000.00
(1 row)

-- Extra DIES FESTIUS DE L'ANY 2017 QUE CAIGUIN ELS DIES DILLUNS I DIVENDRES

SELECT dia_festivo = 1 AND (dia_setmana = "dilluns" OR dia_setmana = "divendres");

-- 2.31- Identificador i nom dels venedors que no tenen assignada oficina.

SELECT num_empl, nombre FROM repventas WHERE oficina_rep IS NULL;

 num_empl |   nombre   
----------+------------
      110 | Tom Snyder
(1 row)


-- 2.32- Identificador i nom dels venedors, amb l'identificador de l'oficina d'aquells venedors que tenen una oficina assignada.

SELECT num_empl, nombre, oficina_rep FROM repventas WHERE oficina_rep IS NOT NULL;

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


-- 2.33- Identificador i descripció dels productes del fabricant identificat per imm dels quals hi hagin existències superiors o iguals 200, també del fabricant bic amb existències superiors o iguals a 50.

SELECT id_producto, descripcion FROM productos WHERE id_fab = 'imm' AND (existencias >= 200) OR id_fab = 'bic' (AND existencias >= 50);

 id_producto |   descripcion   
-------------+-----------------
 887h        | Soporte Riostra
 41089       | Retn
(2 rows)


-- 2.34- Identificador i nom dels venedors que treballen a les oficines 11, 12 o 22 i compleixen algun dels següents supòsits:
-- a) han estat contractats a partir de juny del 1988 i no tenen director

SELECT num_empl, nombre FROM repventas WHERE oficina_rep IN (11, 12, 22) OR (contrato >= '1998-06-01' AND director IS NULL);

 num_empl |    nombre     
----------+---------------
      109 | Mary Jones
      106 | Sam Clark
      104 | Bob Smith
      101 | Dan Roberts
      103 | Paul Cruz
      107 | Nancy Angelli
(6 rows)


-- b) estan per sobre la quota però tenen vendes de 600000 o menors.

SELECT num_empl, nombre FROM repventas WHERE oficina_rep IN (11, 12, 22) OR (cuota > ventas AND ventas <= 60000);

 num_empl |    nombre     
----------+---------------
      109 | Mary Jones
      106 | Sam Clark
      104 | Bob Smith
      101 | Dan Roberts
      103 | Paul Cruz
      107 | Nancy Angelli
(6 rows)



-- 2.35- Identificador i descripció dels productes amb un preu superior a 1000 i siguin del fabricant amb identificador rei o les existències siguin superiors a 20.

SELECT id_producto, descripcion FROM productos WHERE precio > 1000 AND (id_fab = 'rei' OR existencias > 20); 

 id_producto |  descripcion   
-------------+----------------
 4100y       | Extractor
 2a44l       | Bisagra Izqda.
 4100z       | Montador
 2a44r       | Bisagra Dcha.
(4 rows)


-- 2.36- Identificador del fabricant,identificador i descripció dels productes amb fabricats pels fabricants que tenen una lletra qualsevol, una lletra 'i' i una altre lletra qualsevol com a identificador de fabricant.

SELECT id_fab, id_producto, descripcion FROM productos WHERE id_fab LIKE '_i_';

 id_fab | id_producto | descripcion 
--------+-------------+-------------
 bic    | 41672       | Plate
 bic    | 41003       | Manivela
 bic    | 41089       | Retn
(3 rows)


-- 2.37- Identificador i descripció dels productes que la seva descripció comenÃ§a per "art" sense tenir en compte les majúscules i minúscules.

SELECT id_producto, descripcion FROM productos WHERE descripcion ILIKE '%art%';

 id_producto |   descripcion   
-------------+-----------------
 41003       | Articulo Tipo 3
 41004       | Articulo Tipo 4
 41001       | Articulo Tipo 1
 41002       | Articulo Tipo 2
(4 rows)


-- 2.38- Identificador i nom dels clients que la segona lletra del nom sigui una "a" minúscula o majuscula.

SELECT num_clie, empresa FROM clientes WHERE empresa ILIKE '_a%';

 num_clie |     empresa     
----------+-----------------
     2123 | Carter & Sons
     2113 | Ian & Schmidt
     2105 | AAA Investments
(3 rows)


-- 2.39- Identificador i ciutat de les oficines que compleixen algun dels següents supòsits:

-- a) És de la regió est amb unes vendes inferiors a 700000.

SELECT oficina, ciudad FROM oficinas WHERE region = 'Este' AND ventas < 700000;

 oficina |  ciudad  
---------+----------
      11 | New York
      13 | Atlanta
(2 rows)


-- b) És de la regió oest amb unes vendes inferiors a 600000.

SELECT oficina, ciudad FROM oficinas WHERE region = 'Oeste' AND ventas < 600000;

 oficina | ciudad 
---------+--------
      22 | Denver
(1 row)


-- 2.40- Identificador del fabricant, identificació i descripció dels productes que compleixen tots els següents supòsits:

-- a) L'identificador del fabricant és "imm" o el preu és menor a 500.

SELECT id_fab, id_producto, descripcion FROM productos WHERE id_fab = 'imm' OR precio < 500;

 id_fab | id_producto |    descripcion    
--------+-------------+-------------------
 rei    | 2a45c       | V Stago Trinquete
 qsa    | xk47        | Reductor
 bic    | 41672       | Plate
 imm    | 779c        | Riostra 2-Tm
 aci    | 41003       | Articulo Tipo 3
 aci    | 41004       | Articulo Tipo 4
 imm    | 887p        | Perno Riostra
 qsa    | xk48        | Reductor
 fea    | 112         | Cubierta
 imm    | 887h        | Soporte Riostra
 bic    | 41089       | Retn
 aci    | 41001       | Articulo Tipo 1
 imm    | 775c        | Riostra 1-Tm
 qsa    | xk48a       | Reductor
 aci    | 41002       | Articulo Tipo 2
 imm    | 773c        | Riostra 1/2-Tm
 aci    | 4100x       | Ajustador
 fea    | 114         | Bancada Motor
 imm    | 887x        | Retenedor Riostra
 rei    | 2a44g       | Pasador Bisagra
(20 rows)


-- b) Les existències són inferiors a 5 o el producte te l'identificador 41003.  

SELECT id_fab, id_producto, descripcion FROM productos WHERE existencias < 5 OR id_producto = 41003;

 id_fab | id_producto |   descripcion   
--------+-------------+-----------------
 bic    | 41672       | Plate
 aci    | 41003       | Articulo Tipo 3
 bic    | 41003       | Manivela
(3 rows)

-- 2.41- Identificador de les comandes del fabricant amb identificador "rei" amb una quantitat superior o igual a 10 o amb un import superior o igual a 10000.

SELECT num_pedido FROM pedidos WHERE fab = 'rei' AND (cant >= 10 OR importe >= 10000);

 num_pedido 
------------
     112961
     113045
     112993
     113042
(4 rows)


-- 2.42- Data de les comandes amb una quantitat superior a 20 i un import superior a 1000 dels clients 2102, 2106 i 2109.

SELECT fecha_pedido FROM pedidos WHERE cant > 20 AND importe > 1000 AND clie IN ('2102', '2106', '2109');

 fecha_pedido 
--------------
 1989-10-12
 1990-03-02
 1989-01-04
(3 rows)



-- 2.43- Identificador dels clients que el seu nom no conté " Corp." o " Inc." amb crèdit major a 30000.

SELECT num_clie FROM clientes WHERE NOT (empresa LIKE '%Corp%' OR empresa LIKE '%Inc%') AND limite_credito > 30000;
 num_clie 
----------
     2103
     2123
     2107
     2101
     2112
     2121
     2124
     2108
     2117
     2120
     2118
     2105
(12 rows)




-- 2.44- Identificador dels representants de vendes majors de 40 anys amb vendes inferiors a 400000.

SELECT num_empl FROM repventas WHERE titulo = 'Rep Ventas' AND edad > 40 AND ventas < 400000;

 num_empl 
----------
      101
      110
      107
(3 rows)


-- 2.45- Identificador dels representants de vendes menors de 35 anys amb vendes superiors a 350000.

SELECT num_empl FROM repventas WHERE edad < 35 AND ventas > 350000;

 num_empl 
----------
      109
(1 row)

-- 1 

SELECT * FROM productos WHERE (id_fab = 'rei' OR id_fab = 'aci' OR id_fab = 'imm') AND (precio > 50 AND precio < 100);

SELECT * FROM productos WHERE (id_fab = 'rei' OR id_fab = 'aci' OR id_fab = 'imm') AND (precio BETWEEN 50 AND 100);

SELECT * FROM productos WHERE id_fab IN ('rei', 'aci', 'imm') AND (precio > 50 AND precio < 100);

SELECT * FROM productos WHERE id_fab IN ('rei', 'aci', 'imm') AND (precio BETWEEN 50 AND 100);


---------------------

SELECT * FROM productos WHERE (id_fab = 'rei' OR id_fab = 'aci' OR id_fab = 'imm') AND (precio > 50 AND precio < 100);
 id_fab | id_producto |    descripcion    | precio  | existencias 
--------+-------------+-------------------+---------+-------------
 rei    | 2a45c       | V Stago Trinquete |   79.00 |         210
 aci    | 4100y       | Extractor         | 2750.00 |          25
 aci    | 41003       | Articulo Tipo 3   |  107.00 |         207
 aci    | 41004       | Articulo Tipo 4   |  117.00 |         139
 rei    | 2a44l       | Bisagra Izqda.    | 4500.00 |          12
 imm    | 887h        | Soporte Riostra   |   54.00 |         223
 aci    | 41001       | Articulo Tipo 1   |   55.00 |         277
 aci    | 4100z       | Montador          | 2500.00 |          28
 aci    | 41002       | Articulo Tipo 2   |   76.00 |         167
 rei    | 2a44r       | Bisagra Dcha.     | 4500.00 |          12
 aci    | 4100x       | Ajustador         |   25.00 |          37
 rei    | 2a44g       | Pasador Bisagra   |  350.00 |          14
(12 rows)

training=# SELECT * FROM productos WHERE id_fab IN ('rei', 'aci', 'imm') AND (precio > 50 AND precio < 100);
 id_fab | id_producto |    descripcion    | precio | existencias 
--------+-------------+-------------------+--------+-------------
 rei    | 2a45c       | V Stago Trinquete |  79.00 |         210
 imm    | 887h        | Soporte Riostra   |  54.00 |         223
 aci    | 41001       | Articulo Tipo 1   |  55.00 |         277
 aci    | 41002       | Articulo Tipo 2   |  76.00 |         167
(4 rows)

-- AND Y OR SE NECESITAN PARENTESIS !! importante

SELECT * FROM productos WHERE (id_fab = 'rei' OR id_fab = 'aci' OR id_fab = 'imm') AND (precio > 50 AND precio < 100);

 id_fab | id_producto |    descripcion    | precio | existencias 
--------+-------------+-------------------+--------+-------------
 rei    | 2a45c       | V Stago Trinquete |  79.00 |         210
 imm    | 887h        | Soporte Riostra   |  54.00 |         223
 aci    | 41001       | Articulo Tipo 1   |  55.00 |         277
 aci    | 41002       | Articulo Tipo 2   |  76.00 |         167
(4 rows)

-- 2 

SELECT * FROM productos WHERE descripcion LIKE '%el%' OR descripcion LIKE '%ma%' OR descripcion LIKE '%ce%' AND (precio > 1000 AND precio < 100);

SELECT * FROM productos WHERE (descripcion LIKE '%el%' OR descripcion LIKE '%ma%' OR descripcion LIKE '%ce%') AND (precio > 1000 AND precio < 100);
 id_fab | id_producto | descripcion | precio | existencias 
--------+-------------+-------------+--------+-------------
(0 rows)

