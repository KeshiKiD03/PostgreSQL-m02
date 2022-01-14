# Ejercicio 1 Consultas Simples RUBEN

Escriu la consulta SELECT que mostra el que es demana a cada exercici i la seva sortida.

# Exercici 1:

Els identificadors de les oficines amb la seva ciutat, els objectius i les vendes reals.

training=> SELECT oficina, objectiu, vendes FROM oficines;
oficina | objectiu  |  vendes
---------+-----------+-----------
22 | 300000.00 | 186042.00
11 | 575000.00 | 692637.00
12 | 800000.00 | 735042.00
13 | 350000.00 | 367911.00
21 | 725000.00 | 835915.00
(5 rows)

# Exercici 2:

Els identificadors de les oficines de la regió est amb la seva ciutat, els objectius i les vendes reals.

training=> SELECT oficina, objectiu, vendes FROM oficines WHERE regio = 'Est';
oficina | objectiu  |  vendes
---------+-----------+-----------
11 | 575000.00 | 692637.00
12 | 800000.00 | 735042.00
13 | 350000.00 | 367911.00
(3 rows)

# Exercici 3:

Les ciutats en ordre alfabètic de les oficines de la regió est amb els objectius i les vendes reals.

training=> SELECT ciutat, objectiu, vendes FROM oficines WHERE regio = 'Est' ORDER BY 1;
ciutat  | objectiu  |  vendes
----------+-----------+-----------
Atlanta  | 350000.00 | 367911.00
Chicago  | 800000.00 | 735042.00
New York | 575000.00 | 692637.00
(3 rows)

# Exercici 4:

Les ciutats, els objectius i les vendes d'aquelles oficines que les seves vendes superin els seus objectius.

training=> SELECT ciutat, objectiu, vendes FROM oficines WHERE vendes > objectiu;
ciutat    | objectiu  |  vendes
-------------+-----------+-----------
New York    | 575000.00 | 692637.00
Atlanta     | 350000.00 | 367911.00
Los Angeles | 725000.00 | 835915.00
(3 rows)

# Exercici 5:

Nom, quota i vendes de l'empleat representant de vendes número 107.

training=> SELECT nom, quota, vendes FROM rep_vendes WHERE num_empl = 107;
nom      |   quota   |  vendes
---------------+-----------+-----------
Nancy Angelli | 300000.00 | 186042.00
(1 row)

# Exercici 6:

Nom i data de contracte dels representants de vendes amb vendes superiors a 300000.

training=> SELECT nom, data_contracte FROM rep_vendes WHERE vendes > 300000;
nom     | data_contracte
-------------+----------------
Bill Adams  | 1988-02-12
Mary Jones  | 1989-10-12
Sue Smith   | 1986-12-10
Dan Roberts | 1986-10-20
Larry Fitch | 1989-10-12
(5 rows)

# Exercici 7:

Nom dels representants de vendes dirigits per l'empleat numero 104 Bob Smith.

training=> SELECT nom FROM rep_vendes WHERE cap = 104;
nom
Bill Adams
Dan Roberts
Paul Cruz
(3 rows)

# Exercici 8:

Nom dels venedors i data de contracte d'aquells que han estat contractats abans del 1988.

training=> SELECT nom, data_contracte FROM rep_vendes WHERE data_contracte < '1988-01-01';
nom           | data_contracte
-------------+----------------
Sue Smith   | 1986-12-10
Bob Smith   | 1987-05-19
Dan Roberts | 1986-10-20
Paul Cruz   | 1987-03-01
(4 rows)

training=> SELECT nom, data_contracte FROM rep_vendes WHERE to_char(data_contracte, 'YYYY') < '1988';
nom     | data_contracte
-------------+----------------
Sue Smith   | 1986-12-10
Bob Smith   | 1987-05-19
Dan Roberts | 1986-10-20
Paul Cruz   | 1987-03-01
(4 rows)

# Exercici 9:

Identificador de les oficines i ciutat d'aquelles oficines que el seu objectiu és diferent a 800000.

training=> SELECT oficina, ciutat FROM oficines WHERE objectiu != 800000;
oficina |   ciutat
---------+-------------
22     | Denver
11     | New York
13     | Atlanta
21     | Los Angeles
(4 rows)

# Exercici 10:

Nom de l'empresa i limit de crèdit del client número 2107.

training=> SELECT empresa, limit_credit FROM clients WHERE num_clie = 2107;
empresa            | limit_credit
-------------------+--------------
Ace International |     35000.00
(1 row)

# Exercici 11:

id_fab com a "Identificador del fabricant", id_producto com a "Identificador del producte" i descripcion com a "Descripció" dels productes.

training=> SELECT id_fabricant "Identificador fabricant", id_producte "Identificador producte", descripcio "Descripció" FROM productes;
Identificador fabricant | Identificador producte |     Descripció
-------------------------+------------------------+--------------------
rei                     | 2a45c                  | V Stago Trinquet
aci                     | 4100y                  | Extractor
qsa                     | xk47                   | Reductor
...
rei                     | 2a44g                  | Passador Frontissa
(25 rows)

# Exercici 12:

Identificador del fabricant, identificador del producte i descripció del producte d'aquells productes que el seu identificador de fabricant acabi amb la lletra i.

training=> SELECT id_fabricant, id_producte, descripcio FROM productes WHERE id_fabricant LIKE '%i';
id_fabricant | id_producte |     descripcio
--------------+-------------+--------------------
rei          | 2a45c       | V Stago Trinquet
aci          | 4100y       | Extractor
aci          | 41003       | Article Tipus 3
aci          | 41004       | Article Tipus 4
rei          | 2a44l       | Frontissa Esq.
aci          | 41001       | Article Tipus 1
aci          | 4100z       | Muntador
aci          | 41002       | Article Tipus 2
rei          | 2a44r       | Frontissa Dta.
aci          | 4100x       | Peu de rei
rei          | 2a44g       | Passador Frontissa
(11 rows)

# Exercici 13:

Nom i identificador dels venedors que estan per sota la quota i tenen vendes inferiors a 300000.

training=> SELECT num_empl, nom FROM rep_vendes WHERE quota > vendes AND vendes < 300000;
num_empl |      nom
----------+---------------
104 | Bob Smith
107 | Nancy Angelli
(2 rows)

# Exercici 14:

Identificador i nom dels venedors que treballen a les oficines 11 o 13.

training=> SELECT num_empl, nom FROM rep_vendes WHERE oficina_rep = 11 or oficina_rep = 13;
num_empl |    nom
----------+------------
105 | Bill Adams
109 | Mary Jones
106 | Sam Clark
(3 rows)

# Exercici 15:

Identificador, descripció i preu dels productes ordenats del més car al més barat.

training=> SELECT id_fabricant, id_producte, preu FROM productes ORDER BY 3 DESC;
id_fabricant | id_producte |  preu
--------------+-------------+---------
rei          | 2a44r       | 4500.00
rei          | 2a44l       | 4500.00
...
aci          | 4100x       |   25.00
(25 rows)

# Exercici 16:

Identificador i descripció de producte amb el valor_inventario (existencies * preu).

training=> SELECT id_fabricant, id_producte, descripcio, (estoc * preu) "Valor inventari" FROM productes ORDER BY 3 DESC;
id_fabricant | id_producte |     descripcio     | Valor inventari
--------------+-------------+--------------------+-----------------
rei           | 2a45c         | V Stago Trinquet|        16590.00
imm          | 887h          | Suport Riosta   |        12042.00
...
aci           | 41001         | Article Tipus 1    |        15235.00
(25 rows)

# Exercici 17:

Vendes de cada oficina en una sola columna i format amb format " té unes vendes de ", exemple "Denver te unes vendes de 186042.00".

training=> SELECT ciutat || ' té unes vendes de ' || vendes AS "Ventes per ciutat" FROM oficines;
Ventes per ciutat
Denver té unes vendes de 186042.00
New York té unes vendes de 692637.00
Chicago té unes vendes de 735042.00
Atlanta té unes vendes de 367911.00
Los Angeles té unes vendes de 835915.00
(5 rows)

# Exercici 18:

Codis d'empleats que són directors d'oficines.

training=> SELECT director FROM oficines WHERE director = 104 or director = 106 or director = 108;
director
108
106
104
108
(4 rows)

# Exercici 19:

Identificador i ciutat de les oficines que tinguin ventes per sota el 80% del seu objectiu.

training=> SELECT oficina, ciutat FROM oficines WHERE vendes < objectiu * 0.80;
oficina | ciutat
---------+--------
22 | Denver
(1 row)

# Exercici 20:

Identificador, ciutat i director de les oficines que no siguin dirigides per l'empleat 108.

training=> SELECT oficina, ciutat, director FROM oficines WHERE director != 108;
oficina |  ciutat  | director
---------+----------+----------
11 | New York |      106
12 | Chicago   |      104
13 | Atlanta     |      105
(3 rows)

# Exercici 21:

Identificadors i noms dels venedors amb vendes entre el 80% i el 120% de llur quota.

training=> SELECT num_empl, nom, vendes FROM rep_vendes WHERE vendes BETWEEN 0.8 * quota AND 1.2 * quota;
num_empl |     nom     |  vendes
----------+-------------+-----------
105 | Bill Adams  | 367911.00
106 | Sam Clark   | 299912.00
101 | Dan Roberts | 305673.00
108 | Larry Fitch | 361865.00
103 | Paul Cruz   | 286775.00
(5 rows)

# Exercici 22:

Identificador, vendes i ciutat de cada oficina ordenades alfabèticament per regió i, dintre de cada regió ordenades per ciutat.

training=> SELECT oficina, vendes, ciutat, regio FROM oficines ORDER BY regio, ciutat;
oficina |  vendes   |   ciutat    | regio
---------+-----------+-------------+-------
13 | 367911.00 | Atlanta     | Est
12 | 735042.00 | Chicago     | Est
11 | 692637.00 | New York    | Est
22 | 186042.00 | Denver      | Oest
21 | 835915.00 | Los Angeles | Oest
(5 rows)

# Exercici 23:

Llista d'oficines classificades alfabèticament per regió i, per cada regió, en ordre descendent de rendiment de vendes (vendes-objectiu).

training=> SELECT oficina, ciutat, (vendes-objectiu) AS "vendes" FROM oficines ORDER BY regio, (vendes-objectiu) DESC;
oficina |   ciutat    |   vendes
---------+-------------+------------
11 | New York    |  117637.00
13 | Atlanta     |   17911.00
12 | Chicago     |  -64958.00
21 | Los Angeles |  110915.00
22 | Denver      | -113958.00
(5 rows)

# Exercici 24:

Codi i nom dels tres venedors que tinguin unes vendes superiors.

training=> SELECT num_empl, vendes FROM rep_vendes ORDER BY 2 DESC LIMIT 3;
num_empl |  vendes
----------+-----------
102 | 474050.00
109 | 392725.00
105 | 367911.00
(3 rows)

# Exercici 25:

Nom i data de contracte dels empleats que les seves vendes siguin superiors a 500000.

training=> SELECT nom, data_contracte, vendes FROM rep_vendes WHERE vendes > 500000;
nom | data_contracte | vendes
-----+----------------+--------
(0 rows)

# Exercici 26:

Nom i quota actual dels venedors amb el calcul d'una "nova possible quota" que serà la quota de cada venedor augmentada un 3 per cent de les seves pròpies vendes.

training=> SELECT nom,quota,(vendes * 1.03) as "nova quota" FROM rep_vendes ;
nom      |   quota   | nova quota
---------------+-----------+-------------
Bill Adams    | 350000.00 | 378948.3300
Mary Jones    | 300000.00 | 404506.7500
Sue Smith     | 350000.00 | 488271.5000
Sam Clark     | 275000.00 | 308909.3600
Bob Smith     | 200000.00 | 146871.8200
Dan Roberts   | 300000.00 | 314843.1900
Tom Snyder    |           |  78264.5500
Larry Fitch   | 350000.00 | 372720.9500
Paul Cruz     | 275000.00 | 295378.2500
Nancy Angelli | 300000.00 | 191623.2600
(10 rows)

# Exercici 27:

Identificador i nom de les oficines que les seves vendes estan per sota del 80% de l'objectiu.

training=> SELECT oficina,ciutat,vendes,objectiu FROM oficines WHERE vendes < 0.8 * objectiu;
oficina | ciutat |  vendes   | objectiu
---------+--------+-----------+-----------
22 | Denver | 186042.00 | 300000.00
(1 row)

# Exercici 28:

Número i import de les comandes que el seu import oscil·li entre 20000 i 29999.

training=> SELECT num_comanda,import FROM comandes WHERE import BETWEEN 20000 AND 29999;
num_comanda |  import
-------------+----------
110036 | 22500.00
112987 | 27500.00
113042 | 22500.00
(3 rows)

# Exercici 29:

Nom, ventes i quota dels venedors que les seves vendes no estan entre el 80% i el 120% de la seva quota.

training=> SELECT nom,vendes,quota FROM rep_vendes WHERE NOT vendes BETWEEN 0.8 * quota AND 1.2 * quota;
nom      |  vendes   |   quota
---------------+-----------+-----------
Mary Jones    | 392725.00 | 300000.00
Sue Smith     | 474050.00 | 350000.00
Bob Smith     | 142594.00 | 200000.00
Nancy Angelli | 186042.00 | 300000.00
(4 rows)

# Exercici 30:

Nom de l'empresa i el seu limit de crèdit de les empreses que el seu nom comença per Smith.

training=> SELECT empresa,limit_credit FROM clients WHERE empresa LIKE 'Smith%' ;
empresa     | limit_credit
----------------+--------------
Smithson Corp. |     20000.00
(1 row)

# Exercici 31:

Identificador i nom dels venedors que no tenen assignada oficina.

training=> SELECT num_empl,nom,oficina_rep FROM rep_vendes WHERE oficina_rep is null ;
num_empl |    nom     | oficina_rep
----------+------------+-------------
110 | Tom Snyder |
(1 row)

# Exercici 32:

Identificador i nom dels venedors, amb l'identificador de l'oficina d'aquells venedors que tenen una oficina assignada.

training=> SELECT num_empl,nom,oficina_rep FROM rep_vendes WHERE oficina_rep is NOT null;
num_empl |      nom      | oficina_rep
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

# Exercici 33:

Identificador i descripció dels productes del fabricant identificat per imm dels quals hi hagin existències superiors o iguals 200, també del fabricant bic amb existències superiors o iguals a 50.

training=> SELECT id_producte,id_fabricant,estoc,descripcio FROM productes WHERE id_fabricant = 'imm' AND estoc >= 200 or id_fabricant= 'bic' AND estoc >=50;
id_producte | id_fabricant | estoc |  descripcio
-------------+--------------+-------+---------------
887h        | imm          |   223 | Suport Riosta
41089       | bic          |    78 | Retn
(2 rows)

# Exercici 34:

Identificador i nom dels venedors que treballen a les oficines 11, 12 o 22 i compleixen algun dels següents supòsits:
han estat contractats a partir de juny del 1988 i no tenen director

training=> SELECT num_empl,nom,data_contracte FROM rep_vendes WHERE (oficina_rep=11 or oficina_rep=12 or oficina_rep=22) AND data_contracte > '1988-06-01' AND cap is null;
num_empl |    nom    | data_contracte
----------+-----------+----------------
106 | Sam Clark | 1988-06-14
(1 row)

estàn per sobre la quota però tenen vendes de 600000 o menors.

training=> SELECT num_empl,nom,data_contracte FROM rep_vendes WHERE (oficina_rep=11 or oficina_rep=12 or oficina_rep=22) AND vendes > quota AND vendes <= 600000;
num_empl |     nom     | data_contracte
----------+-------------+----------------
109 | Mary Jones  | 1989-10-12
106 | Sam Clark   | 1988-06-14
101 | Dan Roberts | 1986-10-20
103 | Paul Cruz   | 1987-03-01
(4 rows)

# Exercici 35:

Identificador i descripció dels productes amb un preu superior a 1000 i siguin del fabricant amb identificador rei o les existències siguin superiors a 20.

training=> SELECT id_producte,id_fabricant,descripcio FROM productes WHERE preu > 1000 AND id_fabricant='rei' or estoc > 20;
id_producte | id_fabricant |    descripcio
-------------+--------------+------------------
2a45c       | rei          | V Stago Trinquet
4100y       | aci          | Extractor
xk47        | qsa          | Reductor
41003       | aci          | Article Tipus 3
41004       | aci          | Article Tipus 4
887p        | imm          | Pern Riosta
xk48        | qsa          | Reductor
2a44l       | rei          | Frontissa Esq.
112         | fea          | Coberta
887h        | imm          | Suport Riosta
41089       | bic          | Retn
41001       | aci          | Article Tipus 1
4100z       | aci          | Muntador
xk48a       | qsa          | Reductor
41002       | aci          | Article Tipus 2
2a44r       | rei          | Frontissa Dta.
773c        | imm          | Riosta 1/2-Tm
4100x       | aci          | Peu de rei
887x        | imm          | Retenidor Riosta
(19 rows)

# Exercici 36:

Identificador del fabricant,identificador i descripció dels productes fabricats pels fabricants que tenen una lletra qualsevol, una lletra 'i' i una altre lletra qualsevol com a identificador de fabricant.

training=> SELECT id_fabricant,id_producte,descripcio FROM productes WHERE id_fabricant LIKE 'i';
id_fabricant | id_producte | descripcio
--------------+-------------+------------
bic          | 41672       | Plate
bic          | 41003       | Manovella
bic          | 41089       | Retn
(3 rows)

# Exercici 37:

Identificador i descripció dels productes que la seva descripció comença per "art" sense tenir en compte les majúscules i minúscules.

training=> SELECT id_producte,descripcio FROM productes WHERE descripcio iLIKE 'art%' ;
id_producte |   descripcio
-------------+-----------------
41003       | Article Tipus 3
41004       | Article Tipus 4
41001       | Article Tipus 1
41002       | Article Tipus 2
(4 rows)

# Exercici 38:

Identificador i nom dels clients que la segona lletra del nom sigui una "a" minúscula o majuscula.

training=> SELECT num_clie,empresa FROM clients WHERE empresa iLIKE '_a%';
num_clie |     empresa
----------+-----------------
2123 | Carter & Sons
2113 | Ian & Schmidt
2105 | AAA Investments
(3 rows)

# Exercici 39:

Identificador i ciutat de les oficines que compleixen algun dels següents supòsits:
És de la regió est amb unes vendes inferiors a 700000.

training=> SELECT oficina,ciutat FROM oficines WHERE regio='Est' AND vendes >700000 ;
oficina | ciutat
---------+---------
12 | Chicago
(1 row)

És de la regió oest amb unes vendes inferiors a 600000.

training=> SELECT oficina,ciutat FROM oficines WHERE regio='Oest' AND vendes < 600000 ;
oficina | ciutat
---------+--------
22 | Denver
(1 row)

# Exercici 40:

Identificador del fabricant, identificació i descripció dels productes que compleixen tots els següents supòsits:

L'identificador del fabricant és "imm" o el preu és menor a 500.

training=> SELECT id_fabricant,id_producte,descripcio FROM productes WHERE id_fabricant='imm' or preu < 500;
id_fabricant | id_producte |     descripcio
--------------+-------------+--------------------
rei          | 2a45c       | V Stago Trinquet
qsa          | xk47        | Reductor
bic          | 41672       | Plate
imm          | 779c        | Riosta 2-Tm
aci          | 41003       | Article Tipus 3
aci          | 41004       | Article Tipus 4
imm          | 887p        | Pern Riosta
qsa          | xk48        | Reductor
fea          | 112         | Coberta
imm          | 887h        | Suport Riosta
bic          | 41089       | Retn
aci          | 41001       | Article Tipus 1
imm          | 775c        | Riosta 1-Tm
qsa          | xk48a       | Reductor
aci          | 41002       | Article Tipus 2
imm          | 773c        | Riosta 1/2-Tm
aci          | 4100x       | Peu de rei
fea          | 114         | Bancada Motor
imm          | 887x        | Retenidor Riosta
rei          | 2a44g       | Passador Frontissa
(20 rows)
Les existències són inferiors a 5 o el producte te l'identificador 41003.
training=> SELECT id_fabricant,id_producte,descripcio FROM productes WHERE estoc < 5 AND id_producte='41003';
id_fabricant | id_producte | descripcio
--------------+-------------+------------
bic          | 41003       | Manovella
(1 row)

# Exercici 41:

Identificador de les comandes del fabricant amb identificador "rei" amb una quantitat superior o igual a 10 o amb un import superior o igual a 10000.
 training=> SELECT fabricant FROM comandes WHERE fabricant = 'rei' AND quantitat >= 10 AND import >= 10000;
fabricant
rei
(1 row)

# Exercici 42:

Data de les comandes amb una quantitat superior a 20 i un import superior a 1000 dels clients 2102, 2106 i 2109.

training=> SELECT data FROM comandes WHERE (quantitat > 20 AND import > 1000) AND (clie = 2102 AND clie = 2106 AND clie = 2109);
data
(0 rows)

# Exercici 43:

Identificador dels clients que el seu nom no conté " Corp." o " Inc." amb crèdit major a 30000.

training=> SELECT num_clie, empresa FROM clients WHERE NOT (empresa LIKE '% Corp.' or empresa LIKE '% Inc.') AND (limit_credit > 30000);
num_clie |      empresa
----------+-------------------
2103 | Acme Mfg.
2123 | Carter & Sons
2107 | Ace International
2101 | Jones Mfg.
2112 | Zetacorp
2121 | QMA Assoc.
2124 | Peter Brothers
2108 | Holm & LANDis
2117 | J.P. Sinclair
2120 | Rico Enterprises
2118 | Midwest Systems
2105 | AAA Investments
(12 rows)

# Exercici 44:
Identificador dels representants de vendes majors de 40 anys amb vendes inferiors a 400000.

training=> SELECT num_empl, nom FROM rep_vendes WHERE edat > 40 AND vendes < 400000;
num_empl |      nom
----------+---------------
106 | Sam Clark
101 | Dan Roberts
110 | Tom Snyder
108 | Larry Fitch
107 | Nancy Angelli
(5 rows)

# Exercici 45:
Identificador dels representants de vendes menors de 35 anys amb vendes superiors a 350000.
training=> SELECT num_empl, nom FROM rep_vendes WHERE edat > 35 AND vendes > 350000;
num_empl |     nom
----------+-------------
105 | Bill Adams
102 | Sue Smith
108 | Larry Fitch
(3 rows)
