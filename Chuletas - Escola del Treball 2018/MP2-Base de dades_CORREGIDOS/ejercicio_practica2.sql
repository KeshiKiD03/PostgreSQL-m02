#Nom: Adrián Narváez
#Hisx: isx39448945

-- 2.1- Els identificadors de les oficines amb la seva ciutat, els objectius i les vendes reals.

select oficina, ciudad, objetivo, ventas 
from oficinas;

   ciudad    | objetivo  |  ventas   
-------------+-----------+-----------
 Denver      | 300000.00 | 186042.00
 New York    | 575000.00 | 692637.00
 Chicago     | 800000.00 | 735042.00
 Atlanta     | 350000.00 | 367911.00
 Los Angeles | 725000.00 | 835915.00


-- 2.2- Els identificadors de les oficines de la regió est amb la seva ciutat, els objectius i les vendes reals.

select ciudad, objetivo, ventas 
from oficinas 
where region = 'Este';

 region |   ciudad    | objetivo  |  ventas   
--------+-------------+-----------+-----------
 Este   | New York    | 575000.00 | 692637.00
 Este   | Chicago     | 800000.00 | 735042.00
 Este   | Atlanta     | 350000.00 | 367911.00


-- 2.3- Les ciutats en ordre alfabètic de les oficines de la regió est amb els objectius i les vendes reals.

select objetivo, ciudad, ventas 
from oficinas 
where region = 'Este' 
order by ciudad;

 objetivo  |  ciudad  |  ventas   
-----------+----------+-----------
 350000.00 | Atlanta  | 367911.00
 800000.00 | Chicago  | 735042.00
 575000.00 | New York | 692637.00

-- 2.4- Les ciutats, els objectius i les vendes d'aquelles oficines que les seves vendes superin els seus objectius.

select ciudad, objetivo, ventas 
from oficinas 
where ventas > objetivo;

   ciudad    | objetivo  |  ventas   
-------------+-----------+-----------
 New York    | 575000.00 | 692637.00
 Atlanta     | 350000.00 | 367911.00
 Los Angeles | 725000.00 | 835915.00


-- 2.5- Nom, quota i vendes de l'empleat representant de vendes número 107.

select nombre, cuota, ventas 
from repventas 
where num_empl = 107;

    nombre     |   cuota   |  ventas   
---------------+-----------+-----------
 Nancy Angelli | 300000.00 | 186042.00


-- 2.6- Nom i data de contracte dels representants de vendes amb vendes superiors a 300000.

select nombre, contrato 
from repventas  
where ventas > 300000;

   nombre    |  contrato  
-------------+------------
 Bill Adams  | 1988-02-12
 Mary Jones  | 1989-10-12
 Sue Smith   | 1986-12-10
 Dan Roberts | 1986-10-20
 Larry Fitch | 1989-10-12


-- 2.7- Nom dels representants de vendes dirigits per l'empleat numero 104 Bob Smith.

select nombre 
from repventas 
where director = 104;

   nombre    
-------------
 Bill Adams
 Dan Roberts
 Paul Cruz

-- 2.8- Nom dels venedors i data de contracte d'aquells que han estat contractats abans del 1988.

select nombre, contrato 
from repventas 
where contrato < '1988-01-01';

   nombre    |  contrato  
-------------+------------
 Sue Smith   | 1986-12-10
 Bob Smith   | 1987-05-19
 Dan Roberts | 1986-10-20
 Paul Cruz   | 1987-03-01


-- 2.9- Identificador de les oficines i ciutat d'aquelles oficines que el seu objectiu és diferent a 800000.

select oficina, ciudad 
from oficinas 
where objetivo != 800000;

 oficina |   ciudad    
---------+-------------
      22 | Denver
      11 | New York
      13 | Atlanta
      21 | Los Angeles


-- 2.10- Nom de l'empresa i limit de crèdit del client número 2107.

select empresa, limite_credito 
from clientes 
where num_clie = 2107;

      empresa      | limite_credito 
-------------------+----------------
 Ace International |       35000.00


-- 2.11- id_fab com a "Identificador del fabricant", id_producto com a "Identificador del producte" i descripcion com a "descripció" dels productes.

select id_fab as "Identificador del fabricant", id_producto as "Identificador del producte", descripcion as "descripció" from productos;

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


-- 2.12- Identificador del fabricant, identificador del producte i descripció del producte d'aquells productes que el seu identificador de fabricant acabi amb la lletra i.

select id_fab, id_producto, descripcion 
from productos 
where id_fab like '%i';

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


-- 2.13- Nom i identificador dels venedors que estan per sota la quota i tenen vendes inferiors a 300000.

select nombre, num_empl 
from repventas 
where ventas < 300000 and cuota > ventas;

    nombre     | num_empl 
---------------+----------
 Bob Smith     |      104
 Nancy Angelli |      107

-- 2.14- Identificador i nom dels venedors que treballen a les oficines 11 o 13.

select num_empl, nombre 
from repventas 
where oficina_rep = 11 or oficina_rep = 13;

 num_empl |   nombre   
----------+------------
      105 | Bill Adams
      109 | Mary Jones
      106 | Sam Clark


-- 2.15- Identificador, descripció i preu dels productes ordenats del més car al més barat.

select id_fab, descripcion, precio 
from productos 
order by precio desc;

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

-- 2.16- Identificador i descripció de producte amb el valor d'inventari (existencies * preu).

select id_fab, descripcion, existencias*precio 
as valor_inv 
from productos; 

 id_fab |    descripcion    | valor_inv 
--------+-------------------+-----------
 rei    | V Stago Trinquete |  16590.00
 aci    | Extractor         |  68750.00
 qsa    | Reductor          |  13490.00
 bic    | Plate             |      0.00
 imm    | Riostra 2-Tm      |  16875.00
 aci    | Articulo Tipo 3   |  22149.00
 aci    | Articulo Tipo 4   |  16263.00
 bic    | Manivela          |   1956.00
 imm    | Perno Riostra     |   6000.00
 qsa    | Reductor          |  27202.00
 rei    | Bisagra Izqda.    |  54000.00
 fea    | Cubierta          |  17020.00
 imm    | Soporte Riostra   |  12042.00
 bic    | Retn              |  17550.00
 aci    | Articulo Tipo 1   |  15235.00


-- 2.17- Vendes de cada oficina en una sola columna i format amb format "<ciutat> te unes vendes de <vendes>", exemple "Denver te unes vendes de 186042.00".

select ciudad || ' tiene unas ventas de ' || ventas 
from oficinas;

                  ?column?                  
--------------------------------------------
 Denver tiene unas ventas de 186042.00
 New York tiene unas ventas de 692637.00
 Chicago tiene unas ventas de 735042.00
 Atlanta tiene unas ventas de 367911.00
 Los Angeles tiene unas ventas de 835915.00


-- 2.18- Codis d'empleats que són directors d'oficines.

select distinct dir 
from oficinas;

 dir 
-----
 106
 105
 108
 104

-- 2.19- Identificador i ciutat de les oficines que tinguin ventes per sota el 80% del seu objectiu.

select oficina, ciudad 
from oficinas 
where ventas < objetivo * 0.8;

 oficina | ciudad 
---------+--------
      22 | Denver


-- 2.20- Identificador, ciutat i director de les oficines que no siguin dirigides per l'empleat 108.

select oficina, ciudad, dir 
from oficinas 
where dir != 108;

 oficina |  ciudad  | dir 
---------+----------+-----
      11 | New York | 106
      12 | Chicago  | 104
      13 | Atlanta  | 105

-- 2.21- Identificadors i noms dels venedors amb vendes entre el 80% i el 120% de llur quota.

select num_empl, nombre from repventas where ventas > cuota * 0.8 and ventas < cuota * 1.2;
select num_empl, nombre from repventas where ventas between 0.8 * cuota and 1.2 * cuota;

 num_empl |   nombre    
----------+-------------
      105 | Bill Adams
      106 | Sam Clark
      101 | Dan Roberts
      108 | Larry Fitch
      103 | Paul Cruz

-- 2.22- Identificador, vendes i ciutat de cada oficina ordenades alfabèticament per regió i, dintre de cada regió ordenades per ciutat.

select oficina, ventas, ciudad 
from oficinas 
order by region, ciudad;

 oficina |  ventas   |   ciudad    
---------+-----------+-------------
      13 | 367911.00 | Atlanta
      12 | 735042.00 | Chicago
      11 | 692637.00 | New York
      22 | 186042.00 | Denver
      21 | 835915.00 | Los Angeles


-- 2.23- Llista d'oficines classificades alfabèticament per regió i, per cada regió, en ordre descendent de rendiment de vendes (vendes-objectiu).

select oficina, ciudad, region, (ventas-objetivo) 
as rendiment_ventas 
from oficinas 
order by region, (ventas-objetivo) desc;

 oficina |   ciudad    | region | rendiment_ventas 
---------+-------------+--------+------------------
      11 | New York    | Este   |        117637.00
      13 | Atlanta     | Este   |         17911.00
      12 | Chicago     | Este   |        -64958.00
      21 | Los Angeles | Oeste  |        110915.00
      22 | Denver      | Oeste  |       -113958.00



-- 2.24- Codi i nom dels tres venedors que tinguin unes vendes superiors.

select num_empl, nombre 
from repventas 
order by ventas desc limit 3;

 num_empl |   nombre   
----------+------------
      102 | Sue Smith
      109 | Mary Jones
      105 | Bill Adams


-- 2.25- Nom i data de contracte dels empleats que les seves vendes siguin superiors a 500000.

select nombre, contrato 
from repventas 
where ventas > 500000;

 nombre | contrato 
--------+----------

-- 2.26- Nom i quota actual dels venedors amb el calcul d'una "nova possible quota" que serà la quota de cada venedor augmentada un 3 per cent de les seves propies vendes.

select nombre, cuota, (cuota*0.03 + cuota) as nova_possible_quota 
from repventas;

    nombre     |   cuota   | nova_possible_quota 
---------------+-----------+---------------------
 Bill Adams    | 350000.00 |         360500.0000
 Mary Jones    | 300000.00 |         309000.0000
 Sue Smith     | 350000.00 |         360500.0000
 Sam Clark     | 275000.00 |         283250.0000
 Bob Smith     | 200000.00 |         206000.0000
 Dan Roberts   | 300000.00 |         309000.0000
 Tom Snyder    |           |                    
 Larry Fitch   | 350000.00 |         360500.0000
 Paul Cruz     | 275000.00 |         283250.0000
 Nancy Angelli | 300000.00 |         309000.0000

-- 2.27- Identificador i nom de les oficines que les seves vendes estan per sota del 80% de l'objectiu.

select oficina, ciudad 
from oficinas 
where ventas < objetivo * 0.8;

 oficina | ciudad 
---------+--------
      22 | Denver


-- 2.28- Numero i import de les comandes que el seu import oscil·li entre 20000 i 29999.

select num_pedido, importe from pedidos where importe >= 20000 and importe <= 29999;
select num_pedido, importe from pedidos where importe between 20000 and 29999;

 num_pedido | importe  
------------+----------
     110036 | 22500.00
     112987 | 27500.00
     113042 | 22500.00


-- 2.29- Nom, ventes i quota dels venedors que les seves vendes no estan entre el 80% i el 120% de la seva quota.

select nombre, ventas, cuota 
from repventas 
where not (ventas >= cuota * 0.8 and ventas <= cuota * 1.2);

    nombre     |  ventas   |   cuota   
---------------+-----------+-----------
 Mary Jones    | 392725.00 | 300000.00
 Sue Smith     | 474050.00 | 350000.00
 Bob Smith     | 142594.00 | 200000.00
 Nancy Angelli | 186042.00 | 300000.00

-- 2.30- Nom de l'empresa i el seu limit de crèdit, de les empreses que el seu nom comença per Smith.

select empresa, limite_credito 
from clientes 
where empresa like 'Smith%';

    empresa     | limite_credito 
----------------+----------------
 Smithson Corp. |       20000.00
 
 -- 2.31- Identificador i nom dels venedors que no tenen assignada oficina.

select num_empl, nombre 
from repventas 
where oficina_rep is null;

 num_empl |   nombre   
----------+------------
      110 | Tom Snyder


-- 2.32- Identificador i nom dels venedors, amb l'identificador de l'oficina d'aquells venedors que tenen una oficina assignada.

select num_empl, nombre 
from repventas 
where oficina_rep is not null;

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


-- 2.33- Identificador i descripció dels productes
-- del fabricant identificat per imm dels quals hi hagin existències superiors o iguals 200,
-- també del fabricant bic amb existències superiors o iguals a 50.

select id_fab, id_producto 
from productos 
where (id_fab='imm' and existencias >= 200) or (id_fab='bic' and existencias >=50);

 id_fab | id_producto 
--------+-------------
 imm    | 887h 
 bic    | 41089


-- 2.34- Identificador i nom dels venedors que treballen a les oficines 11, 12 o 22 i compleixen algun dels següents supòsits:
-- a) han estat contractats a partir de juny del 1988 i no tenen director
-- b) estan per sobre la quota però tenen vendes de 600000 o menors.

select num_empl, nombre 
from repventas 
where (oficina_rep = 11 or oficina_rep = 12 or oficina_rep = 22) and ((contrato >= '1988-06-01' and director is null) or (cuota < ventas and ventas <= 600000));

 num_empl |   nombre    
----------+-------------
      109 | Mary Jones
      106 | Sam Clark
      101 | Dan Roberts
      103 | Paul Cruz

-- 2.35- Identificador i descripció dels productes amb un preu superior a 1000 i siguin del fabricant amb identificador rei o les existències siguin superiors a 20.

select id_producto, descripcion 
from productos 
where precio > 1000 and (id_fab = 'rei' or existencias > 20);

 id_producto |  descripcion   
-------------+----------------
 4100y       | Extractor
 2a44l       | Bisagra Izqda.
 4100z       | Montador
 2a44r       | Bisagra Dcha.

-- 2.36- Identificador del fabricant,identificador i descripció dels productes amb fabricats pels fabricants que tenen una lletra qualsevol, una lletra 'i' i una altre lletra qualsevol com a identificador de fabricant.

select id_fab, id_producto, descripcion 
from productos 
where id_fab like '_i_';

 id_fab | id_producto | descripcion 
--------+-------------+-------------
 bic    | 41672       | Plate
 bic    | 41003       | Manivela
 bic    | 41089       | Retn


-- 2.37- Identificador i descripció dels productes que la seva descripció comenÃ§a per "art" sense tenir en compte les majúscules i minúscules.

select id_producto, descripcion 
from productos 
where descripcion ilike 'art%';

 id_producto |   descripcion   
-------------+-----------------
 41003       | Articulo Tipo 3
 41004       | Articulo Tipo 4
 41001       | Articulo Tipo 1
 41002       | Articulo Tipo 2


-- 2.38- Identificador i nom dels clients que la segona lletra del nom sigui una "a" minúscula o majuscula.

select num_clie, empresa 
from clientes 
where empresa ilike ('_a%');

 num_clie |     empresa     
----------+-----------------
     2123 | Carter & Sons
     2113 | Ian & Schmidt
     2105 | AAA Investments


-- 2.39- Identificador i ciutat de les oficines que compleixen algun dels següents supòsits:
-- a) És de la regió est amb unes vendes inferiors a 700000.
-- b) És de la regió oest amb unes vendes inferiors a 600000.

select oficina, ciudad 
from oficinas 
where region='Este' and ventas < 700000 or region='Oeste' and ventas < 600000;

 oficina |  ciudad  
---------+----------
      22 | Denver
      11 | New York
      13 | Atlanta

-- 2.40- Identificador del fabricant, identificació i descripció dels productes que compleixen tots els següents supòsits:
-- a) L'identificador del fabricant és "imm" o el preu és menor a 500.
-- b) Les existències són inferiors a 5 o el producte te l'identificador 41003.  

select id_fab, id_producto, descripcion 
from productos 
where (id_fab = 'imm' or precio < 500) and (existencias < 5 or id_producto = '41003');

 id_fab | id_producto |   descripcion   
--------+-------------+-----------------
 bic    | 41672       | Plate
 aci    | 41003       | Articulo Tipo 3


-- 2.41- Identificador de les comandes del fabricant amb identificador "rei" amb una quantitat superior o igual a 10 o amb un import superior o igual a 10000.

select num_pedido, producto 
from pedidos 
where fab = 'rei' and (cant >= 10 or importe >= 10000);

 num_pedido | producto 
------------+----------
     112961 | 2a44l
     113045 | 2a44r
     112993 | 2a45c
     113042 | 2a44r



-- 2.42- Data de les comandes amb una quantitat superior a 20 i un import superior a 1000 dels clients 2102, 2106 i 2109.

select fecha_pedido 
from pedidos 
where (cant > 20 and importe > 1000) and (clie = 2102 or clie = 2106 or clie = 2109);

 fecha_pedido 
--------------
 1989-10-12
 1990-03-02
 1989-01-04

-- 2.43- Identificador dels clients que el seu nom no conté " Corp." o " Inc." amb crèdit major a 30000.

select num_clie 
from clientes 
where not empresa like 'Corp.%' and not empresa like 'Inc.%' and limite_credito > 30000;

 num_clie 
----------
     2111
     2102
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
     2106
     2118
     2105


-- 2.44- Identificador dels representants de vendes majors de 40 anys amb vendes inferiors a 400000.

select num_empl, nombre 
from repventas 
where contrato > '1977-01-01' and ventas < 400000;

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


-- 2.45- Identificador dels representants de vendes menors de 35 anys amb vendes superiors a 350000.

select num_empl, nombre 
from repventas 
where contrato < '1982-01-01' and ventas > 350000;

 num_empl | nombre 
----------+--------

