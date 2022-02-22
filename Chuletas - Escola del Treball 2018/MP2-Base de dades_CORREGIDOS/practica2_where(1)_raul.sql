-- 2.1- Els identificadors de les oficines amb la seva ciutat, els objectius i les vendes reals.
SELECT oficina, ciudad, objetivo, ventas FROM oficinas;
 oficina |   ciudad    | objetivo  |  ventas   
---------+-------------+-----------+-----------
      22 | Denver      | 300000.00 | 186042.00
      11 | New York    | 575000.00 | 692637.00
      12 | Chicago     | 800000.00 | 735042.00
      13 | Atlanta     | 350000.00 | 367911.00
      21 | Los Angeles | 725000.00 | 835915.00
(5 rows)

-- 2.2- Els identificadors de les oficines de la regió est amb la seva ciutat, els objectius i les vendes reals.
 region |   ciudad    | objetivo  |  ventas   
--------+-------------+-----------+-----------
 Este   | New York    | 575000.00 | 692637.00
 Este   | Chicago     | 800000.00 | 735042.00
 Este   | Atlanta     | 350000.00 | 367911.00
(3 rows)



-- 2.3- Les ciutats en ordre alfabètic de les oficines de la regió est amb els objectius i les vendes reals.
SELECT oficina, region, ciudad, objetivo, ventas FROM oficinas WHERE region='Este' ORDER BY ciudad;
 oficina | region |  ciudad  | objetivo  |  ventas   
---------+--------+----------+-----------+-----------
      13 | Este   | Atlanta  | 350000.00 | 367911.00
      12 | Este   | Chicago  | 800000.00 | 735042.00
      11 | Este   | New York | 575000.00 | 692637.00
(3 rows)


-- 2.4- Les ciutats, els objectius i les vendes d'aquelles oficines que les seves vendes superin els seus objectius.
SELECT ciudad, objetivo, ventas FROM oficinas WHERE ventas > objetivo;
   ciudad    | objetivo  |  ventas   
-------------+-----------+-----------
 New York    | 575000.00 | 692637.00
 Atlanta     | 350000.00 | 367911.00
 Los Angeles | 725000.00 | 835915.00
(3 rows)


-- 2.5- Nom, quota i vendes de l'empleat representant de vendes número 107.
SELECT nombre, cuota, ventas FROM repventas WHERE num_empl=107;
    nombre     |   cuota   |  ventas   
---------------+-----------+-----------
 Nancy Angelli | 300000.00 | 186042.00
(1 row)


-- 2.6- Nom i data de contracte dels representants de vendes amb vendes superiors a 300000.
SELECT nombre, contrato FROM repventas WHERE ventas>300000;
   nombre    |  contrato  
-------------+------------
 Bill Adams  | 1988-02-12
 Mary Jones  | 1989-10-12
 Sue Smith   | 1986-12-10
 Dan Roberts | 1986-10-20
 Larry Fitch | 1989-10-12
(5 rows)


-- 2.7- Nom dels representants de vendes dirigits per l'empleat numero 104 Bob Smith.
SELECT nombre FROM repventas WHERE director=104;
   nombre    
-------------
 Bill Adams
 Dan Roberts
 Paul Cruz
(3 rows)

-- 2.8- Nom dels venedors i data de contracte d'aquells que han estat contractats abans del 1988.
SELECT nombre, contrato FROM repventas WHERE contrato<'1988-1-1';
   nombre    |  contrato  
-------------+------------
 Sue Smith   | 1986-12-10
 Bob Smith   | 1987-05-19
 Dan Roberts | 1986-10-20
 Paul Cruz   | 1987-03-01
(4 rows)

-- 2.9- Identificador de les oficines i ciutat d'aquelles oficines que el seu objectiu és diferent a 800000.
SELECT oficina, ciudad FROM oficinas WHERE objetivo != 800000;
 oficina |   ciudad    
---------+-------------
      22 | Denver
      11 | New York
      13 | Atlanta
      21 | Los Angeles
(4 rows)



-- 2.10- Nom de l'empresa i limit de crèdit del client número 2107.
SELECT empresa, limite_credito FROM clientes WHERE num_clie=2107;
      empresa      | limite_credito 
-------------------+----------------
 Ace International |       35000.00
(1 row)


-- 2.11- id_fab com a "Identificador del fabricant", id_producto com a "Identificador del producte" i descripcion com a "descripció" dels productes.
SELECT id_fab, id_producto, descripcion FROM productos;
 id_fab | id_producto |    descripcion    
--------+-------------+-------------------
 rei    | 2a45c       | V Stago Trinquete
 aci    | 4100y       | Extractor
 qsa    | xk47        | Reductor
 bic    | 41672       | Plate
 imm    | 779c        | Riostra 2-Tm
 aci    | 41003       | Articulo Tipo 3
 aci    | 41004       | Articulo Tipo 4
 bic    | 41003       | Manivela
 imm    | 887p        | Perno Riostra
 qsa    | xk48        | Reductor
 rei    | 2a44l       | Bisagra Izqda.
 fea    | 112         | Cubierta
 imm    | 887h        | Soporte Riostra
 bic    | 41089       | Retn
 aci    | 41001       | Articulo Tipo 1
 imm    | 775c        | Riostra 1-Tm
 aci    | 4100z       | Montador
 qsa    | xk48a       | Reductor
 aci    | 41002       | Articulo Tipo 2
 rei    | 2a44r       | Bisagra Dcha.
 imm    | 773c        | Riostra 1/2-Tm
 aci    | 4100x       | Ajustador
 fea    | 114         | Bancada Motor
 imm    | 887x        | Retenedor Riostra
 rei    | 2a44g       | Pasador Bisagra
(25 rows)

-- 2.12- Identificador del fabricant, identificador del producte i descripció del producte d'aquells productes que el seu identificador de fabricant acabi amb la lletra i.
SELECT id_fab, id_producto, descripcion FROM productos WHERE id_fab LIKE '%i';
 id_fab | id_producto |    descripcion    
--------+-------------+-------------------
 rei    | 2a45c       | V Stago Trinquete
 aci    | 4100y       | Extractor
 aci    | 41003       | Articulo Tipo 3
 aci    | 41004       | Articulo Tipo 4
 rei    | 2a44l       | Bisagra Izqda.
 aci    | 41001       | Articulo Tipo 1
 aci    | 4100z       | Montador
 aci    | 41002       | Articulo Tipo 2
 rei    | 2a44r       | Bisagra Dcha.
 aci    | 4100x       | Ajustador
 rei    | 2a44g       | Pasador Bisagra
(11 rows)


-- 2.13- Nom i identificador dels venedors que estan per sota la quota i tenen vendes inferiors a 300000.
SELECT num_empl, nombre FROM repventas WHERE ventas < cuota and ventas < 300000;
 num_empl |    nombre     
----------+---------------
      104 | Bob Smith
      107 | Nancy Angelli
(2 rows)

-- 2.14- Identificador i nom dels venedors que treballen a les oficines 11 o 13.
SELECT num_empl, nombre FROM repventas WHERE oficina_rep=11 or oficina_rep=13;
 num_empl |   nombre   
----------+------------
      105 | Bill Adams
      109 | Mary Jones
      106 | Sam Clark
(3 rows)


-- 2.15- Identificador, descripció i preu dels productes ordenats del més car al més barat.
SELECT id_producto, descripcion, precio FROM productos ORDER BY precio DESC;
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
SELECT id_producto, descripcion, existencias*precio FROM productos;
 id_producto |    descripcion    | ?column? 
-------------+-------------------+----------
 2a45c       | V Stago Trinquete | 16590.00
 4100y       | Extractor         | 68750.00
 xk47        | Reductor          | 13490.00
 41672       | Plate             |     0.00
 779c        | Riostra 2-Tm      | 16875.00
 41003       | Articulo Tipo 3   | 22149.00
 41004       | Articulo Tipo 4   | 16263.00
 41003       | Manivela          |  1956.00
 887p        | Perno Riostra     |  6000.00
 xk48        | Reductor          | 27202.00
 2a44l       | Bisagra Izqda.    | 54000.00
 112         | Cubierta          | 17020.00
 887h        | Soporte Riostra   | 12042.00
 41089       | Retn              | 17550.00
 41001       | Articulo Tipo 1   | 15235.00
 775c        | Riostra 1-Tm      |  7125.00
 4100z       | Montador          | 70000.00
 xk48a       | Reductor          |  4329.00
 41002       | Articulo Tipo 2   | 12692.00
 2a44r       | Bisagra Dcha.     | 54000.00
 773c        | Riostra 1/2-Tm    | 27300.00
 4100x       | Ajustador         |   925.00
 114         | Bancada Motor     |  3645.00
 887x        | Retenedor Riostra | 15200.00
 2a44g       | Pasador Bisagra   |  4900.00
(25 rows)


-- 2.17- Vendes de cada oficina en una sola columna i format amb format "<ciutat> te unes vendes de <vendes>", exemple "Denver te unes vendes de 186042.00".



-- 2.18- Codis d'empleats que són directors d'oficines.
SELECT dir FROM oficinas;
 dir 
-----
 108
 106
 104
 105
 108
(5 rows)

-- 2.19- Identificador i ciutat de les oficines que tinguin ventes per sota el 80% del seu objectiu.
SELECT oficina, ciudad FROM oficinas WHERE ventas < (objetivo*0.8);
 oficina | ciudad 
---------+--------
      22 | Denver
(1 row)

-- 2.20- Identificador, ciutat i director de les oficines que no siguin dirigides per l'empleat 108.
SELECT oficina, ciudad, dir FROM oficinas WHERE dir!=108;
 oficina |  ciudad  | dir 
---------+----------+-----
      11 | New York | 106
      12 | Chicago  | 104
      13 | Atlanta  | 105
(3 rows)

-- 2.21- Identificadors i noms dels venedors amb vendes entre el 80% i el 120% de llur quota.
SELECT num_empl, nombre FROM repventas WHERE ventas > cuota*0.8 and ventas < cuota * 1.2;
 num_empl |   nombre    
----------+-------------
      105 | Bill Adams
      106 | Sam Clark
      101 | Dan Roberts
      108 | Larry Fitch
      103 | Paul Cruz
(5 rows)



-- 2.22- Identificador, vendes i ciutat de cada oficina ordenades alfabèticament per regió i, dintre de cada regió ordenades per ciutat.
SELECT oficina, ventas, ciudad, region FROM oficinas ORDER BY region,ciudad;
 oficina |  ventas   |   ciudad    | region 
---------+-----------+-------------+--------
      13 | 367911.00 | Atlanta     | Este
      12 | 735042.00 | Chicago     | Este
      11 | 692637.00 | New York    | Este
      22 | 186042.00 | Denver      | Oeste
      21 | 835915.00 | Los Angeles | Oeste
(5 rows)


-- 2.23- Llista d'oficines classificades alfabèticament per regió i, per cada regió, en ordre descendent de rendiment de vendes (vendes-objectiu).
SELECT oficina, ventas, ciudad, region FROM oficinas ORDER BY region,(ventas-objetivo) desc;
 oficina |  ventas   |   ciudad    | region 
---------+-----------+-------------+--------
      11 | 692637.00 | New York    | Este
      13 | 367911.00 | Atlanta     | Este
      12 | 735042.00 | Chicago     | Este
      21 | 835915.00 | Los Angeles | Oeste
      22 | 186042.00 | Denver      | Oeste
(5 rows)

-- 2.24- Codi i nom dels tres venedors que tinguin unes vendes superiors.
SELECT num_empl, nombre FROM repventas ORDER BY ventas DESC LIMIT 3;
 num_empl |   nombre   
----------+------------
      102 | Sue Smith
      109 | Mary Jones
      105 | Bill Adams
(3 rows)

-- 2.25- Nom i data de contracte dels empleats que les seves vendes siguin superiors a 500000.
SELECT nombre, contrato, ventas FROM repventas WHERE ventas > 500000;
 nombre | contrato | ventas 
--------+----------+--------
(0 rows)

-- 2.26- Nom i quota actual dels venedors amb el calcul d'una "nova possible quota" que serà la quota de cada venedor augmentada un 3 per cent de les seves propies vendes.
SELECT nombre, cuota, (cuota*0.3)+cuota AS "nova possible cuota" FROM repventas;
    nombre     |   cuota   | nova possible cuota 
---------------+-----------+---------------------
 Bill Adams    | 350000.00 |          455000.000
 Mary Jones    | 300000.00 |          390000.000
 Sue Smith     | 350000.00 |          455000.000
 Sam Clark     | 275000.00 |          357500.000
 Bob Smith     | 200000.00 |          260000.000
 Dan Roberts   | 300000.00 |          390000.000
 Tom Snyder    |           |                    
 Larry Fitch   | 350000.00 |          455000.000
 Paul Cruz     | 275000.00 |          357500.000
 Nancy Angelli | 300000.00 |          390000.000
(10 rows)

-- 2.27- Identificador i nom de les oficines que les seves vendes estan per sota del 80% de l'objectiu.
SELECT oficina, ciudad FROM oficinas WHERE ventas < objetivo*0.8;
 oficina | ciudad 
---------+--------
      22 | Denver
(1 row)


-- 2.28- Numero i import de les comandes que el seu import oscil·li entre 20000 i 29999.
SELECT num_pedido, importe FROM pedidos WHERE importe BETWEEN 20000 and 29999;
 num_pedido | importe  
------------+----------
     110036 | 22500.00
     112987 | 27500.00
     113042 | 22500.00
(3 rows)

-- 2.29- Nom, ventes i quota dels venedors que les seves vendes no estan entre el 80% i el 120% de la seva quota.
SELECT nombre, ventas, cuota FROM repventas WHERE ventas!=cuota*0.8 and ventas!=cuota*0.12;
    nombre     |  ventas   |   cuota   
---------------+-----------+-----------
 Bill Adams    | 367911.00 | 350000.00
 Mary Jones    | 392725.00 | 300000.00
 Sue Smith     | 474050.00 | 350000.00
 Sam Clark     | 299912.00 | 275000.00
 Bob Smith     | 142594.00 | 200000.00
 Dan Roberts   | 305673.00 | 300000.00
 Larry Fitch   | 361865.00 | 350000.00
 Paul Cruz     | 286775.00 | 275000.00
 Nancy Angelli | 186042.00 | 300000.00
(9 rows)

-- 2.30- Nom de l'empresa i el seu limit de crèdit, de les empreses que el seu nom comença per Smith
SELECT empresa, limite_credito FROM clientes WHERE empresa LIKE 'Smith%';
    empresa     | limite_credito 
----------------+----------------
 Smithson Corp. |       20000.00
(1 row)

-- 2.31- Identificador i nom dels venedors que no tenen assignada oficina.
SELECT num_empl, nombre FROM repventas WHERE oficina_rep IS NULL;
 num_empl |   nombre   
----------+------------
      110 | Tom Snyder
(1 row) 

-- 2.32- Identificador i nom dels venedors, amb l'identificador de l'oficina d'aquells venedors que tenen una oficina assignada.
SELECT num_empl, nombre FROM repventas WHERE oficina_rep IS NOT NULL;
 num_empl |    nombre     
----------+---------------
      105 | Bill Adams
      109 | Mary Jones
      102 | Sue Smith
      106 | Sam Clark
      104 | Bob Smith
      101 | Dan Roberts
      108 | Larry Fitch
      103 | Paul Cruz
      107 | Nancy Angelli
(9 rows)

-- 2.33- Identificador i descripció dels productes del fabricant identificat per imm dels quals hi hagin existències superiors o iguals 200, també del fabricant bic amb existències superiors o iguals a 50.
SELECT id_producto, descripcion FROM productos WHERE (id_fab LIKE 'imm' and existencias >= 200) OR (id_fab LIKE 'bic' and existencias >= 50);
 id_producto |   descripcion   
-------------+-----------------
 887h        | Soporte Riostra
 41089       | Retn
(2 rows)

-- 2.34- Identificador i nom dels venedors que treballen a les oficines 11, 12 o 22 i compleixen algun dels següents supòsits:
-- a) han estat contractats a partir de juny del 1988 i no tenen director
SELECT num_empl, nombre FROM repventas WHERE (oficina_rep=11 or oficina_rep=12 or oficina_rep=22) and contrato>'1988-6-1' and director IS NULL;
 num_empl |  nombre   
----------+-----------
      106 | Sam Clark
(1 row)

-- b) estan per sobre la quota però tenen vendes de 600000 o menors.
SELECT num_empl, nombre FROM repventas WHERE (oficina_rep=11 or oficina_rep=12 or oficina_rep=22) and contrato>'1988-6-1' and director IS NULL and ventas<=600000;

-- 2.35- Identificador i descripció dels productes amb un preu superior a 1000 i siguin del fabricant amb identificador rei o les existències siguin superiors a 20.
SELECT id_fab, descripcion FROM productos WHERE precio > 1000 and id_fab='rei' or existencias > 20

-- 2.36- Identificador del fabricant,identificador i descripció dels productes amb
-- fabricats pels fabricants que tenen una lletra qualsevol, una lletra 'i' i una 
--altre lletra qualsevol com a identificador de fabricant.
SELECT id_fab, id_producto, descripcion FROM productos WHERE id_fab LIKE '_i_'; 
 id_fab | id_producto | descripcion 
--------+-------------+-------------
 bic    | 41672       | Plate
 bic    | 41003       | Manivela
 bic    | 41089       | Retn
(3 rows)

-- 2.37- Identificador i descripció dels productes que la seva descripció comenÃ§a per "art" sense tenir en compte les majúscules i minúscules.
SELECT id_fab, descripcion FROM productos WHERE descripcion ILIKE 'art%';
 id_fab |   descripcion   
--------+-----------------
 aci    | Articulo Tipo 3
 aci    | Articulo Tipo 4
 aci    | Articulo Tipo 1
 aci    | Articulo Tipo 2
(4 rows)

-- 2.38- Identificador i nom dels clients que la segona lletra del nom sigui una "a" minúscula o majuscula.
SELECT rep_clie, empresa FROM clientes WHERE empresa ILIKE '_a';


-- 2.39- Identificador i ciutat de les oficines que compleixen algun dels següents supòsits:
SELECT oficina, ciudad FROM oficina 

-- a) És de la regió est amb unes vendes inferiors a 700000.
SELECT oficina, ciudad FROM oficinas WHERE ventas < 700000 and region='Este';
 oficina |  ciudad  
---------+----------
      11 | New York
      13 | Atlanta
(2 rows)

-- b) És de la regió oest amb unes vendes inferiors a 600000.
SELECT oficina, ciudad FROM oficinas WHERE ventas < 600000 and region='Oeste';
 oficina | ciudad 
---------+--------
      22 | Denver
(1 row)

-- 2.40- Identificador del fabricant, identificació i descripció dels productes que compleixen tots els següents supòsits:
SELECT id_fab, id_producto, descripcion FROM productos
-- a) L'identificador del fabricant és "imm" o el preu és menor a 500.
SELECT id_fab, id_producto, descripcion FROM productos WHERE id_fab='imm' or precio < 500;
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
SELECT id_fab, id_producto, descripcion FROM productos WHERE existencias < 5 or id_fab='41003';
 id_fab | id_producto | descripcion 
--------+-------------+-------------
 bic    | 41672       | Plate
 bic    | 41003       | Manivela
(2 rows)

-- 2.41- Identificador de les comandes del fabricant amb identificador "rei" amb una quantitat superior o igual a 10 o amb un import superior o igual a 10000.
SELECT num_pedido, fab FROM pedidos WHERE fab='rei' and (cant >= 10 or importe >= 10000);
 num_pedido | fab 
------------+-----
     112961 | rei
     113045 | rei
     112993 | rei
     113042 | rei
(4 rows)

-- 2.42- Data de les comandes amb una quantitat superior a 20 i un import superior a 1000 dels clients 2102, 2106 i 2109.
SELECT fecha_pedido FROM pedidos WHERE cant > 20 and importe > 1000 and (clie=2102 or clie=2106 or clie=2109);
 fecha_pedido 
--------------
 1989-10-12
 1990-03-02
 1989-01-04
(3 rows)

-- 2.43- Identificador dels clients que el seu nom no conté " Corp." o " Inc." amb crèdit major a 30000.
SELECT num_clie, empresa, limite_credito FROM clientes WHERE empresa NOT LIKE '%Corp%' and empresa NOT LIKE '%Ibc%' and limite_credito > 30000;
num_clie |      empresa      | limite_credito 
----------+-------------------+----------------
     2111 | JCP Inc.          |       50000.00
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
(13 rows)

-- 2.44- Identificador dels representants de vendes majors de 40 anys amb vendes inferiors a 400000.
SELECT num_empl FROM repventas WHERE edad > 40 and ventas < 400000;
 num_empl 
----------
      106
      101
      110
      108
      107
(5 rows)

-- 2.45- Identificador dels representants de vendes menors de 35 anys amb vendes superiors a 350000.
SELECT num_empl FROM repventas WHERE edad < 35 and ventas < 400000;
 num_empl 
----------
      109
      104
      103
(3 rows)


