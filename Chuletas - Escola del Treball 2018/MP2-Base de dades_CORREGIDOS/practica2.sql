- 2.1- Els identificadors de les oficines amb la seva ciutat, els objectius i les vendes reals.

training=# select oficina,ciudad,objetivo,ventas  from oficinas;
 oficina |   ciudad    | objetivo  |  ventas   
---------+-------------+-----------+-----------
      22 | Denver      | 300000.00 | 186042.00
      11 | New York    | 575000.00 | 692637.00
      12 | Chicago     | 800000.00 | 735042.00
      13 | Atlanta     | 350000.00 | 367911.00
      21 | Los Angeles | 725000.00 | 835915.00
(5 rows)

-- 2.2- Els identificadors de les oficines de la regió est amb la seva ciutat, els objectius i les vendes reals.

training=# select * from oficinas where region ='Este';
 oficina |  ciudad  | region | dir | objetivo  |  ventas   
---------+----------+--------+-----+-----------+-----------
      11 | New York | Este   | 106 | 575000.00 | 692637.00
      12 | Chicago  | Este   | 104 | 800000.00 | 735042.00
      13 | Atlanta  | Este   | 105 | 350000.00 | 367911.00
(3 rows)


-- 2.3- Les ciutats en ordre alfabètic de les oficines de la regió est amb els objectius i les vendes reals.


training=> select ciudad,objetivo,ventas from oficinas where region='Este' ORDER BY ciudad;
  ciudad  | objetivo  |  ventas   
----------+-----------+-----------
 Atlanta  | 350000.00 | 367911.00
 Chicago  | 800000.00 | 735042.00
 New York | 575000.00 | 692637.00
(3 rows)


-- 2.4- Les ciutats, els objectius i les vendes d'aquelles oficines que les seves vendes superin els seus objectius.


training=> select ciudad,ventas,objetivo from oficinas where ventas > objetivo;
   ciudad    |  ventas   | objetivo  
-------------+-----------+-----------
 New York    | 692637.00 | 575000.00
 Atlanta     | 367911.00 | 350000.00
 Los Angeles | 835915.00 | 725000.00
(3 rows)


-- 2.5- Nom, quota i vendes de l'empleat representant de vendes número 107.


training=> select nombre,cuota,ventas from repventas where num_empl='107';
    nombre     |   cuota   |  ventas   
---------------+-----------+-----------
 Nancy Angelli | 300000.00 | 186042.00
(1 row)



-- 2.6- Nom i data de contracte dels representants de vendes amb vendes superiors a 300000.


training=> select nombre,contrato from repventas where ventas > 300000;
   nombre    |  contrato  
-------------+------------
 Bill Adams  | 1988-02-12
 Mary Jones  | 1989-10-12
 Sue Smith   | 1986-12-10
 Dan Roberts | 1986-10-20
 Larry Fitch | 1989-10-12
(5 rows)


-- 2.7- Nom dels representants de vendes dirigits per l'empleat numero 104 Bob Smith.


training=> select nombre from repventas where director ='104';
   nombre    
-------------
 Bill Adams
 Dan Roberts
 Paul Cruz
(3 rows)


-- 2.8- Nom dels venedors i data de contracte d'aquells que han estat contractats abans del 1988.

training=> select nombre,contrato from repventas where contrato < '1988-01-01';
   nombre    |  contrato  
-------------+------------
 Sue Smith   | 1986-12-10
 Bob Smith   | 1987-05-19
 Dan Roberts | 1986-10-20
 Paul Cruz   | 1987-03-01
(4 rows)


-- 2.9- Identificador de les oficines i ciutat d'aquelles oficines que el seu objectiu és diferent a 800000.

training=> select oficina,ciudad from oficinas where objetivo != 800000;
 oficina |   ciudad    
---------+-------------
      22 | Denver
      11 | New York
      13 | Atlanta
      21 | Los Angeles
(4 rows)


-- 2.10- Nom de l'empresa i limit de crèdit del client número 2107.


training=> select empresa,limite_credito from clientes where num_clie ='2107';
      empresa      | limite_credito 
-------------------+----------------
 Ace International |       35000.00
(1 row)


-- 2.11- id_fab com a "Identificador del fabricant", id_producto com a "Identificador del producte" 
--i descripcion com a "descripció" dels productes.


training=> select id_fab AS "Identificador del fabricant", id_producto AS "Identificador del producte", 
descripcion AS " Descripcio del producte" from productos;

 Identificador del fabricant | Identificador del producte |  Descripcio del producte 
-----------------------------+----------------------------+--------------------------
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


-- 2.12- Identificador del fabricant, identificador del producte i 
--descripció del producte d'aquells productes que el seu identificador de fabricant acabi amb la lletra i.


training=> select id_fab AS "Identificador del fabricant", id_producto AS "Identificador del producte", 
descripcion AS " Descripcio del producte" from productos where id_fab LIKE '%i';

 Identificador del fabricant | Identificador del producte |  Descripcio del producte 
-----------------------------+----------------------------+--------------------------
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

training=> select num_empl,nombre,ventas from repventas where cuota > ventas and ventas<300000;
 num_empl |    nombre     |  ventas   
----------+---------------+-----------
      104 | Bob Smith     | 142594.00
      107 | Nancy Angelli | 186042.00
(2 rows)


-- 2.14- Identificador i nom dels venedors que treballen a les oficines 11 o 13.


training=> select num_empl,nombre from repventas where oficina_rep = '11' or oficina_rep='13';
 num_empl |   nombre   
----------+------------
      105 | Bill Adams
      109 | Mary Jones
      106 | Sam Clark
(3 rows)



-- 2.15- Identificador, descripció i preu dels productes ordenats del més car al més barat.


training=> select id_fab,descripcion,precio from productos ORDER BY precio DESC;
 id_fab |    descripcion    | precio  
--------+-------------------+---------
 rei    | Bisagra Dcha.     | 4500.00
 rei    | Bisagra Izqda.    | 4500.00
 aci    | Extractor         | 2750.00
 aci    | Montador          | 2500.00
 imm    | Riostra 2-Tm      | 1875.00
 imm    | Riostra 1-Tm      | 1425.00
 imm    | Riostra 1/2-Tm    |  975.00
 bic    | Manivela          |  652.00
 imm    | Retenedor Riostra |  475.00
 qsa    | Reductor          |  355.00
 rei    | Pasador Bisagra   |  350.00
 imm    | Perno Riostra     |  250.00
 fea    | Bancada Motor     |  243.00
 bic    | Retn              |  225.00
 bic    | Plate             |  180.00
 fea    | Cubierta          |  148.00
 qsa    | Reductor          |  134.00
 qsa    | Reductor          |  117.00
 aci    | Articulo Tipo 4   |  117.00
 aci    | Articulo Tipo 3   |  107.00
 rei    | V Stago Trinquete |   79.00
 aci    | Articulo Tipo 2   |   76.00
 aci    | Articulo Tipo 1   |   55.00
 imm    | Soporte Riostra   |   54.00
 aci    | Ajustador         |   25.00
(25 rows)


-- 2.16- Identificador i descripció de producte amb el valor d'inventari (existencies * preu).

training=> select id_fab,descripcion,(existencias*precio) as "Valor inventari" from productos;
 id_fab |    descripcion    | Valor inventari 
--------+-------------------+-----------------
 rei    | V Stago Trinquete |        16590.00
 aci    | Extractor         |        68750.00
 qsa    | Reductor          |        13490.00
 bic    | Plate             |            0.00
 imm    | Riostra 2-Tm      |        16875.00
 aci    | Articulo Tipo 3   |        22149.00
 aci    | Articulo Tipo 4   |        16263.00
 bic    | Manivela          |         1956.00
 imm    | Perno Riostra     |         6000.00
 qsa    | Reductor          |        27202.00
 rei    | Bisagra Izqda.    |        54000.00
 fea    | Cubierta          |        17020.00
 imm    | Soporte Riostra   |        12042.00
 bic    | Retn              |        17550.00
 aci    | Articulo Tipo 1   |        15235.00
 imm    | Riostra 1-Tm      |         7125.00
 aci    | Montador          |        70000.00
 qsa    | Reductor          |         4329.00
 aci    | Articulo Tipo 2   |        12692.00
 rei    | Bisagra Dcha.     |        54000.00
 imm    | Riostra 1/2-Tm    |        27300.00
 aci    | Ajustador         |          925.00
 fea    | Bancada Motor     |         3645.00
 imm    | Retenedor Riostra |        15200.00
 rei    | Pasador Bisagra   |         4900.00
(25 rows)



-- 2.17- Vendes de cada oficina en una sola columna i format amb format "<ciutat> te unes vendes de <vendes>", exemple "Denver te unes vendes de 186042.00".

training=> select ciudad ||' te unes ventas de '|| ventas AS " ventas oficina" from oficinas;
              ventas oficina             
-----------------------------------------
 Denver te unes ventas de 186042.00
 New York te unes ventas de 692637.00
 Chicago te unes ventas de 735042.00
 Atlanta te unes ventas de 367911.00
 Los Angeles te unes ventas de 835915.00
(5 rows)

-- 2.18- Codis d'empleats que són directors d'oficines.

training=> select distinct director from repventas where director is not null order by 1 desc;
 director 
----------
      108
      106
      104
      101
(4 rows)


-- 2.19- Identificador i ciutat de les oficines que tinguin ventes per sota el 80% del seu objectiu.


training=> select oficina,ciudad from oficinas where ventas < 0.8*objetivo;
 oficina | ciudad 
---------+--------
      22 | Denver
(1 row)


-- 2.20- Identificador, ciutat i director de les oficines que no siguin dirigides per l'empleat 108.


training=> select oficina,ciudad,dir from oficinas where dir !=108;
 oficina |  ciudad  | dir 
---------+----------+-----
      11 | New York | 106
      12 | Chicago  | 104
      13 | Atlanta  | 105
(3 rows)

-- 2.21- Identificadors i noms dels venedors amb vendes entre el 80% i el 120% de llur quota.


training=> select num_empl,nombre from repventas where ventas between 0.8*cuota and 1.2*cuota;
 num_empl |   nombre    
----------+-------------
      105 | Bill Adams
      106 | Sam Clark
      101 | Dan Roberts
      108 | Larry Fitch
      103 | Paul Cruz
(5 rows)


-- 2.22- Identificador, vendes i ciutat de cada oficina ordenades alfabèticament per regió i, dintre de cada regió ordenades per ciutat.

training=> select oficina,ciudad,ventas,region from oficinas ORDER BY 4,2;
 oficina |   ciudad    |  ventas   | region 
---------+-------------+-----------+--------
      13 | Atlanta     | 367911.00 | Este
      12 | Chicago     | 735042.00 | Este
      11 | New York    | 692637.00 | Este
      22 | Denver      | 186042.00 | Oeste
      21 | Los Angeles | 835915.00 | Oeste
(5 rows)



-- 2.23- Llista d'oficines classificades alfabèticament per regió i, per cada regió, en ordre descendent de rendiment de vendes (vendes-objectiu).


-- 2.24- Codi i nom dels tres venedors que tinguin unes vendes superiors.

training=> SELECT num_empl,nombre,ventas from repventas order by ventas DESC LIMIT 3;
 num_empl |   nombre   |  ventas   
----------+------------+-----------
      102 | Sue Smith  | 474050.00
      109 | Mary Jones | 392725.00
      105 | Bill Adams | 367911.00
(3 rows)


-- 2.25- Nom i data de contracte dels empleats que les seves vendes siguin superiors a 500000.


training=> select nombre,contrato from repventas where ventas > 500000;
 nombre | contrato 
--------+----------
(0 rows)


-- 2.26- Nom i quota actual dels venedors amb el calcul d'una "nova possible quota" que serà la quota de cada venedor 
--augmentada un 3 per cent de les seves propies vendes.


training=> select nombre,cuota,cuota *0.3 AS "nova possible quota" from repventas;
    nombre     |   cuota   | nova possible quota 
---------------+-----------+---------------------
 Bill Adams    | 350000.00 |          105000.000
 Mary Jones    | 300000.00 |           90000.000
 Sue Smith     | 350000.00 |          105000.000
 Sam Clark     | 275000.00 |           82500.000
 Bob Smith     | 200000.00 |           60000.000
 Dan Roberts   | 300000.00 |           90000.000
 Tom Snyder    |           |                    
 Larry Fitch   | 350000.00 |          105000.000
 Paul Cruz     | 275000.00 |           82500.000
 Nancy Angelli | 300000.00 |           90000.000
(10 rows)



-- 2.27- Identificador i nom de les oficines que les seves vendes estan per sota del 80% de l'objectiu.


training=> select oficina,ciudad from oficinas where ventas < 0.8*objetivo;
 oficina | ciudad 
---------+--------
      22 | Denver
(1 row)

-- 2.28- Numero i import de les comandes que el seu import oscil·li entre 20000 i 29999.

training=> select num_pedido,importe from pedidos where importe between 20000 AND 29999;
 num_pedido | importe  
------------+----------
     110036 | 22500.00
     112987 | 27500.00
     113042 | 22500.00
(3 rows)


-- 2.29- Nom, ventes i quota dels venedors que les seves vendes no estan entre el 80% i el 120% de la seva quota.

training=> select nombre,ventas,cuota from repventas where ventas not between 0.8*cuota and 1.2*cuota;
    nombre     |  ventas   |   cuota   
---------------+-----------+-----------
 Mary Jones    | 392725.00 | 300000.00
 Sue Smith     | 474050.00 | 350000.00
 Bob Smith     | 142594.00 | 200000.00
 Nancy Angelli | 186042.00 | 300000.00
(4 rows)


-- 2.30- Nom de l'empresa i el seu limit de crèdit, de les empreses que el seu nom comença per Smith.

training=> select empresa,limite_credito from clientes where empresa LIKE 'Smith%';
    empresa     | limite_credito 
----------------+----------------
 Smithson Corp. |       20000.00
(1 row)


-- 2.31- Identificador i nom dels venedors que no tenen assignada oficina.

training=> select num_empl,nombre from repventas where oficina_rep is null;
 num_empl |   nombre   
----------+------------
      110 | Tom Snyder
(1 row)


-- 2.32- Identificador i nom dels venedors, amb l'identificador de l'oficina d'aquells venedors que tenen una oficina assignada.

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


-- 2.33- Identificador i descripció dels productes del fabricant identificat per imm dels 
--quals hi hagin existències superiors o iguals 200, també del fabricant bic amb existències superiors o iguals a 50.



training=> select id_producto,descripcion from productos where (id_fab='imm' and existencias >= 200) OR (id_fab='bic' and existencias >=50);
 id_producto |   descripcion   
-------------+-----------------
 887h        | Soporte Riostra
 41089       | Retn
(2 rows)




-- 2.34- Identificador i nom dels venedors que treballen a les oficines 11, 12 o 22 i compleixen algun dels següents supòsits:
-- a) han estat contractats a partir de juny del 1988 i no tenen director
-- b) estan per sobre la quota però tenen vendes de 600000 o menors.


select num_empl,nombre,oficina_rep from repventas where (oficina_rep=11 or oficina_rep=12 or oficina_rep=22) 
and ((contrato>'1988-06-01' and director is NULL) or (ventas>cuota and ventas<=600000));

 num_empl |   nombre    | oficina_rep 
----------+-------------+-------------
      109 | Mary Jones  |          11
      106 | Sam Clark   |          11
      101 | Dan Roberts |          12
      103 | Paul Cruz   |          12
(4 rows)



-- 2.35- Identificador i descripció dels productes amb un preu superior a 1000 i siguin del fabricant amb identificador rei o les existències siguin superiors a 20.


training=> select id_producto,descripcion from productos where precio > 1000 AND (id_fab='imm' OR existencias > 20);
 id_producto | descripcion  
-------------+--------------
 4100y       | Extractor
 779c        | Riostra 2-Tm
 775c        | Riostra 1-Tm
 4100z       | Montador
(4 rows)



-- 2.36- Identificador del fabricant,identificador i descripció dels productes amb fabricats pels 
--fabricants que tenen una lletra qualsevol, una lletra 'i' i una altre lletra qualsevol com a identificador de fabricant.

training=> select id_fab,id_producto,descripcion from productos where id_fab LIKE '_i_';
 id_fab | id_producto | descripcion 
--------+-------------+-------------
 bic    | 41672       | Plate
 bic    | 41003       | Manivela
 bic    | 41089       | Retn
(3 rows)



-- 2.37- Identificador i descripció dels productes que la seva descripció comenÃ§a per "art" sense tenir en compte les majúscules i minúscules.

training=> select id_producto,descripcion from productos where descripcion ILIKE 'art%'; 
 id_producto |   descripcion   
-------------+-----------------
 41003       | Articulo Tipo 3
 41004       | Articulo Tipo 4
 41001       | Articulo Tipo 1
 41002       | Articulo Tipo 2
(4 rows)


-- 2.38- Identificador i nom dels clients que la segona lletra del nom sigui una "a" minúscula o majuscula.

training=> select num_empl,nombre from repventas where nombre ILIKE '_a%';
 num_empl |    nombre     
----------+---------------
      109 | Mary Jones
      106 | Sam Clark
      101 | Dan Roberts
      108 | Larry Fitch
      103 | Paul Cruz
      107 | Nancy Angelli
(6 rows)



-- 2.39- Identificador i ciutat de les oficines que compleixen algun dels següents supòsits:
-- a) És de la regió est amb unes vendes inferiors a 700000.
-- b) És de la regió oest amb unes vendes inferiors a 600000.


training=> select oficina,ciudad from oficinas where (region='Este' and ventas <700000) OR (region='Oeste' and ventas <600000);
 oficina |  ciudad  
---------+----------
      22 | Denver
      11 | New York
      13 | Atlanta
(3 rows)



-- 2.40- Identificador del fabricant, identificació i descripció dels productes que compleixen tots els següents supòsits:
-- a) L'identificador del fabricant és "imm" o el preu és menor a 500.
-- b) Les existències són inferiors a 5 o el producte te l'identificador 41003.  

training=# SELECT id_fab , id_producto , descripcion FROM productos WHERE (id_fab = 'imm' OR precio < 500) AND 
(existencias < 5 OR id_producto = '41003')  ;
 id_fab | id_producto |   descripcion   
--------+-------------+-----------------
 bic    | 41672       | Plate
 aci    | 41003       | Articulo Tipo 3
(2 rows)



-- 2.41- Identificador de les comandes del fabricant amb identificador "rei" amb una quantitat superior o igual a 10 o amb un import superior o igual a 10000.
training=> select num_pedido,fab from pedidos where (fab='rei' and cant >=10) AND  (importe >=10000);
 num_pedido | fab 
------------+-----
     113045 | rei
(1 row)


training=> select num_pedido,fab from pedidos where (fab='rei' and cant >=10) OR (importe >=10000);
 num_pedido | fab 
------------+-----
     112961 | rei
     110036 | aci
     113045 | rei
     112979 | aci
     113069 | imm
     112993 | rei
     112987 | aci
     113042 | rei
(8 rows)



-- 2.42- Data de les comandes amb una quantitat superior a 20 i un import superior a 1000 dels clients 2102, 2106 i 2109.

training=> select clie,fecha_pedido,cant,importe from pedidos where cant > 20 and importe >1000 and (clie=2102 or clie=2106 or clie=2109);
 clie | fecha_pedido | cant | importe  
------+--------------+------+----------
 2102 | 1989-10-12   |   34 |  3978.00
 2109 | 1990-03-02   |   22 | 31350.00
 2106 | 1989-01-04   |   24 |  1896.00
(3 rows)

-- 2.43- Identificador dels clients que el seu nom no conté " Corp." o " Inc." amb crèdit major a 30000.

training=> SELECT num_clie,empresa from clientes where (empresa NOT ILIKE '%Corp.%' AND empresa NOT ILIKE '%Inc.%') AND limite_credito > 30000;
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
(12 rows)




-- 2.44- Identificador dels representants de vendes majors de training=> select num_empl,nombre from repventas where contrato < '1982-1-1' AND ventas > 350000;
 num_empl | nombre 
----------+--------
(0 rows)
40 anys amb vendes inferiors a 400000.

training=> select num_empl,nombre from repventas where contrato > '1977-1-1' AND ventas < 400000;
 num_empl |    nombre     
----------+---------------
      105 | Bill Adams
      109 | Mary Jones
      106 | Sam Clark
      104 | Bob Smith
      101 | Dan Roberts
      110 | Tom Snyder
      108 | Larry Fitch
      103 | Paul Cruz
      107 | Nancy Angelli
(9 rows)



-- 2.45- Identificador dels representants de vendes menors de 35 anys amb vendes superiors a 350000.


training=> select num_empl,nombre from repventas where contrato < '1982-1-1' AND ventas > 350000;
 num_empl | nombre 
----------+--------
(0 rows)

