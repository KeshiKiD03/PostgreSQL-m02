# Exercicis Vistes

## Exercici 1

Defineix una vista anomenada "oficina_est" que contingui únicament les dades de les oficines de la regió est.

1.Veiem els usuaris de l'oficina = 'Est'

```
training=> SELECT * FROM oficines WHERE regio = 'Est';
 oficina |  ciutat  | regio | director | objectiu  |  vendes   
---------+----------+-------+----------+-----------+-----------
      11 | New York | Est   |      106 | 575000.00 | 692637.00
      12 | Chicago  | Est   |      104 | 800000.00 | 735042.00
      13 | Atlanta  | Est   |      105 | 350000.00 | 367911.00
(3 rows)
```

2. Creem la vista oficina_est

CREATE OR REPLACE VIEW oficina_est AS 
	SELECT * FROM oficines WHERE regio = 'Est'
	WITH LOCAL CHECK OPTION;
	
```
training=> CREATE OR REPLACE VIEW oficina_est AS 
        SELECT * FROM oficines WHERE regio = 'Est'
        WITH LOCAL CHECK OPTION;
CREATE VIEW
training=> 

```

3. Veiem la vista creada. 

```
training=> SELECT * FROM oficina_est
training-> ;
 oficina |  ciutat  | regio | director | objectiu  |  vendes   
---------+----------+-------+----------+-----------+-----------
      11 | New York | Est   |      106 | 575000.00 | 692637.00
      12 | Chicago  | Est   |      104 | 800000.00 | 735042.00
      13 | Atlanta  | Est   |      105 | 350000.00 | 367911.00
(3 rows)

```

\d+ 

```
                                 View "public.oficina_est"
  Column  |         Type          | Collation | Nullable | Default | Storage  | Description 
----------+-----------------------+-----------+----------+---------+----------+-------------
 oficina  | smallint              |           |          |         | plain    | 
 ciutat   | character varying(15) |           |          |         | extended | 
 regio    | character varying(10) |           |          |         | extended | 
 director | smallint              |           |          |         | plain    | 
 objectiu | numeric(9,2)          |           |          |         | main     | 
 vendes   | numeric(9,2)          |           |          |         | main     | 
View definition:
 SELECT oficines.oficina,
    oficines.ciutat,
    oficines.regio,
    oficines.director,
    oficines.objectiu,
    oficines.vendes
   FROM oficines
  WHERE oficines.regio::text = 'Est'::text;
Options: check_option=local

```


## Exercici 2

Crear una vista de nom "rep_oest" que mostri les dades dels venedors de la
regió oest.

1. Filtrem per saber els usuaris de l'oficina_rep

```
SELECT * FROM rep_vendes WHERE oficina_rep IN (SELECT oficina FROM oficines WHERE regio = 'Oest');

```
```
 num_empl |      nom      | edat | oficina_rep |       carrec        | data_contracte | cap |   quota   |  vendes   
----------+---------------+------+-------------+---------------------+----------------+-----+-----------+-----------
      102 | Sue Smith     |   48 |          21 | Representant Vendes | 1986-12-10     | 108 | 350000.00 | 474050.00
      108 | Larry Fitch   |   62 |          21 | Dir Vendes          | 1989-10-12     | 106 | 350000.00 | 361865.00
      107 | Nancy Angelli |   49 |          22 | Representant Vendes | 1988-11-14     | 108 | 300000.00 | 186042.00
(3 rows)

```

2. Creem la vista.

CREATE OR REPLACE VIEW rep_oest AS 
	SELECT * FROM rep_vendes WHERE oficina_rep IN (SELECT oficina FROM oficines WHERE regio = 'Oest');
	
```
training=> CREATE OR REPLACE VIEW rep_oest AS 
        SELECT * FROM rep_vendes WHERE oficina_rep IN (SELECT oficina FROM oficines WHERE regio = 'Oest');
CREATE VIEW

```

```
 num_empl |      nom      | edat | oficina_rep |       carrec        | data_contracte | cap |   quota   |  vendes   
----------+---------------+------+-------------+---------------------+----------------+-----+-----------+-----------
      102 | Sue Smith     |   48 |          21 | Representant Vendes | 1986-12-10     | 108 | 350000.00 | 474050.00
      108 | Larry Fitch   |   62 |          21 | Dir Vendes          | 1989-10-12     | 106 | 350000.00 | 361865.00
      107 | Nancy Angelli |   49 |          22 | Representant Vendes | 1988-11-14     | 108 | 300000.00 | 186042.00
(3 rows)

```
	

## Exercici 3

Crea una vista temporal de nom "comandes_sue" que contingui únicament les
comandes fetes per clients assignats la representant de vendes Sue.


1. Comandes de la Sue Smith
```
training=> SELECT * FROM comandes WHERE rep IN (SELECT num_empl FROM rep_vendes WHERE nom = 'Sue Smith');

```

2. Creem la Vista

CREATE OR REPLACE VIEW comandes_sue AS 
	SELECT * FROM comandes WHERE rep IN (SELECT num_empl FROM rep_vendes WHERE nom = 'Sue Smith');
	
```
training=> CREATE OR REPLACE VIEW comandes_sue AS 
        SELECT * FROM comandes WHERE rep IN (SELECT num_empl FROM rep_vendes WHERE nom = 'Sue Smith');
CREATE VIEW

```

```
 num_comanda |    data    | clie | rep | fabricant | producte | quantitat |  import  
-------------+------------+------+-----+-----------+----------+-----------+----------
      112979 | 1989-10-12 | 2114 | 102 | aci       | 4100z    |         6 | 15000.00
      113048 | 1990-02-10 | 2120 | 102 | imm       | 779c     |         2 |  3750.00
      112993 | 1989-01-04 | 2106 | 102 | rei       | 2a45c    |        24 |  1896.00
      113065 | 1990-02-27 | 2106 | 102 | qsa       | xk47     |         6 |  2130.00
(4 rows)

```

## Exercici 4

Crea una vista de nom "clientes_vip" mostri únicament aquells clients que la
suma dels imports de les seves comandes superin 30000.

## Exercici 5

Crear una vista de nom "info_rep" amb les següents dades dels venedors:
num_empl, nombre, oficina_rep.

## Exercici 6

Crear una vista de nom "info_oficina" que mostri les oficines amb
l'identificador de l'oficina, la ciutat i la regió.

## Exercici 7

Crear una vista de nom "info_clie" que contingui el nom de l'empresa dels
clients i l'identificador del venedor que tenen assignat.

## Exercici 8

Crea una vista de nom "clie_bill" que conté el número de client, el nom de
empresa i el límit de crèdit de tots els clients assignats al representant de
vendes "Bill Adams".

## Exercici 9

Crea una vista de nom comanda_per_rep que conté les següents dades de les
comandes de cada venedor: id_representant_vendes, quantitat_pedidos,
import_total, import_minim, import_maxim, import_promig.

## Exercici 10

De la vista anterior volem una nova vista per mostrar el nom del representant
de vendes, números de comandes, import total de les comandes i el promig de les
comandes per a cada venedor. S'han d'ordenar per tal que primer es mostrin els
que tenen major import total.

## Exercici 11

Crear una vista de nom "info_comanda" amb les dades de les comandes però amb
els noms del client i venedor en lloc dels seus identificadors.

## Exercici 12

Crear una vista anomenada "clie_rep" que mostri l'import total de les comandes
que ha fet cada client a cada representant de vendes. Cal mostrar el nom de
l'empresa i el nom del representant de vendes.

## Exercici 13

Crear una vista temporal per substituir la taula "comandes" que mostri les
comandes amb import més gran a 20000 i ordenades per import de forma
descendent.

## Exercici 14

Crea una vista anomenada "top_clie" que mostri el nom de l'empresa client i el
total dels imports de les comandes del client. S'han d'ordenar per tal que
primer es mostrin els que tenen major import total.

## Exercici 15

Crea una vista anomenata "top_prod" que mostri les dades de tots els productes
seguit d'un camp anomenat "quant_total" en que es mostri la quantitat de cada
producte que s'ha demanat en totes les comandes. S'ha d'ordenar per tal que
primer es mostrin els productes que tenen més comandes.
    

## Exercici 16

Crea una vista anomenada "responsables" que mostri un llistat de tots els
representants de vendes. En un camp anomenat "empl" ha de mostrar el nom de
cada representant de vendes. També ha de mostrar un camp anomenat "superior"
que mostri el nom del cap del representant de vendes, en cas que el
representant de vendes tingui cap. També ha de mostrar un camp anomenat
"oficina_superior" que mostri el nom del director de l'oficina en que treballa
el representant de vendes, en cas que el representant de vendes tingui
assignada una oficina aquesta tingui un director.

