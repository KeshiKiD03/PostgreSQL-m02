# CHEATSHEET KESHI [08]

# Vistas

* Una vista nos ayuda en la seguridad y en la complejidad con una gran cantidad de JOIN o subconsultas, agrupaciones de una query.

* Es una tabla virtual que no está almacenada en ningún lugar. Está definida por una QUERY.

	* La vista NO tiene estructura, ni los datos de una tabla. 
	
		* SINO DE UNA SENTENCIA SELECT.

* Guarda la CONSULTA dentro del INDICE. --> Es una TABLA VIRTUAL.

	* Definida por una QUERY.
	
		* No tiene DATOS sólo --> SELECT.
		
		
* Una vista es una visión de la QUERY.

## SINTAXI

* CREATE VIEW "tabla"

	AS SELECT "campos"
	
		FROM "tabla"
		
			WHERE ... [campos]
			
			ORDER BY [campo];




## VIEW Apunts de clase

* Una vista es una tabla virtual que guarda una QUERY.

* No guarda datos físicos en el disco duro.

* Si se ejecuta la VISTA, ejecuta la QUERY que tiene dentro.

## DML

* Si se inserta/modifica/borra algo en la vista afecta a la tabla ORIGINAL.

* Pero depende de la QUERY de filtro que tengan, mostrará o no.



## _WITH LOCAL CHECK OPTION_

* Permite verificar errores a la hora de hacer DML en la VISTA.

* Podemos asegurarnos que se cumpla.

Exemple:

```SQL
CREATE VIEW clients_repvendes
    AS SELECT num_clie, empresa, rep_clie, nom
         FROM clients
              JOIN rep_vendes
              ON rep_clie = num_empl
  WITH LOCAL CHECK OPTION;
```

Ens mostrarà el següent error:

```
ERROR:  WITH CHECK OPTION is supported only on automatically updatable views
HINT:  Views that do not select from a single table or view are not automatically updatable.
```



## CREATE OR REPLACE VIEW 

* Si el índice no existe, la CREA.

* Si el índice existe, reemplaza el contenido del índice.


```SQL
	CREATE VIEW oficines_est
		AS SELECT oficina, ciutat, regio
			 FROM oficines
			WHERE regio = 'Est'
			ORDER BY ciutat
	  WITH LOCAL CHECK OPTION;
	```

>També podem utilitzar l'ordre `CREATE OR REPLACE VIEW` (tot i que no és ANSI és vàlida a molts SGBDR: PostgreSQL, MySQL, Oracle ...)


-----------------------------------------------------------------------------------

# Vistes (VIEWS) / Teoría Clase


## L'origen de les vistes. 

Perquè necessitem les **vistes**?

Dos dels problemes que s'han de resoldre quan es treballa amb una SGBD són:

- Les consultes de gran complexitat, amb una gran quantitat de JOIN's, subconsultes i/o agrupacions en una única query.

- L'accés d'usuaris a taules de la base de dades, que pertany al camp de la seguretat de la base de dades.

Hi ha diferents maneres de resoldre aquests problemes i una d'aquestes és la creació d'una vista(VIEW).


## Definició de vista

Una vista és una **taula virtual** que no està emmagatzemada enlloc (en cap esquema) i que està definida per una _query_. La vista NO conté l'estructura, ni les dades d'una taula, sinó una sentència SELECT. 

Aquesta sentència (query) s'executa cada cop que volem fer servir la vista.

Podem pensar una VIEW com una _visió_ de la query.

## Sintaxi

Una primera aproximació seria:

```SQL
CREATE VIEW oficines_est
    AS SELECT oficina, ciutat, regio
         FROM oficines
        WHERE regio = 'Est'
        ORDER BY ciutat;
```


Mostrem informació de la vista:

```sql
training=> \d+ oficines_est
                                View "public.oficines_est"
 Column  |         Type          | Collation | Nullable | Default | Storage  | Description 
---------+-----------------------+-----------+----------+---------+----------+-------------
 oficina | smallint              |           |          |         | plain    | 
 ciutat  | character varying(15) |           |          |         | extended | 
 regio   | character varying(10) |           |          |         | extended | 
View definition:
 SELECT oficines.oficina,
    oficines.ciutat,
    oficines.regio
   FROM oficines
  WHERE oficines.regio::text = 'Est'::text
  ORDER BY oficines.ciutat;
```

Mirem el contingut de la vista:

```sql
training=> SELECT *
  FROM oficines_est;

oficina |  ciutat  | regio 
---------+----------+-------
      13 | Atlanta  | Est
      12 | Chicago  | Est
      11 | New York | Est
(3 rows)
```

## Modificació (INSERT, UPDATE, DELETE) d'una vista

Es pot treballar amb les instruccions DML amb una vista, però fixem-nos una
mica com funciona i quin és el seu significat.


Anem a inserir un parell de registres a la vista:

```sql
INSERT INTO  oficines_est
VALUES (88, 'Sofia', 'Est');

INSERT INTO  oficines_est 
VALUES (55, 'Madrit', 'Sud');
```

El programa psql respon a les nostres insercions:

```sql
INSERT 0 1
INSERT 0 1
```

És a dir sembla que ens ha inserit dues oficines a la vista oficines_est, però
no ho hauria d'haver fet.

Comprovem què ha passat a la vista:

```sql
training=> SELECT * FROM oficines_est;

 oficina |  ciutat  | regio 
---------+----------+-------
      13 | Atlanta  | Est
      12 | Chicago  | Est
      11 | New York | Est
      88 | Sofia    | Est
(4 rows)
```

Ep! llavors sí que ho ha fet bé?

Però un moment, una vista és una query, s'executa cada cop que jo la faig servir. Llavors no existeix cap fila inserida a la vista.

**Exercici: a on s'haurà inserit la fila?**

**Solució:**

Fem un cop d'ull a la taula oficina:

```sql
training=> SELECT * FROM oficines;

 oficina |   ciutat    | regio | director | objectiu  |  vendes   
---------+-------------+-------+----------+-----------+-----------
      22 | Denver      | Oest  |      108 | 300000.00 | 186042.00
      11 | New York    | Est   |      106 | 575000.00 | 692637.00
      12 | Chicago     | Est   |      104 | 800000.00 | 735042.00
      13 | Atlanta     | Est   |      105 | 350000.00 | 367911.00
      21 | Los Angeles | Oest  |      108 | 725000.00 | 835915.00
      66 | Barcelona   | Sud   |          |    111.00 |      0.00
      88 | Sofia       | Est   |          |           |          
      55 | Madrit      | Sud   |          |           |          
(8 rows)
```

En efecte, les insercions es fan a la taula mare.

El problema que veiem aquí però, és que si inserim a la vista, se suposa que
volem que es compleixin las condicions (WHERE ...) amb les que vam crear la
vista.

La solució a aquest problema, o sigui comprovar abans d'inserir una fila que compleix les condicions de la vista ens la proporciona la clàusula
_WITH LOCAL CHECK OPTION_


Recomencem per tant l'exercici:

+ Eliminem la vista amb `DROP VIEW ...` (es pot fer d'una altra manera)

+ Eliminem també amb `DELETE FROM oficines WHERE ...` les dues oficines
  esmentades. 

+ Creem la vista imposant ara que es comprovi la condició del WHERE:

```SQL
	CREATE VIEW oficines_est
		AS SELECT oficina, ciutat, regio
			 FROM oficines
			WHERE regio = 'Est'
			ORDER BY ciutat
	  WITH LOCAL CHECK OPTION;
	```

>També podem utilitzar l'ordre `CREATE OR REPLACE VIEW` (tot i que no és ANSI és vàlida a molts SGBDR: PostgreSQL, MySQL, Oracle ...)

+ Si tornem a executar els INSERTs d'abans:

```SQL
	INSERT INTO  oficines_est
	VALUES (88, 'Sofia', 'Est');

	INSERT INTO  oficines_est
	VALUES (55, 'Madrit', 'Sud');
```

Veiem que ara el resultat és diferent:

```SQL
	INSERT 0 1
	ERROR:  new row violates check option for view "oficines_est"
	DETAIL:  Failing row contains (55, Madrit, Sud, null, null, null).
```

La primera instrucció compleix la condició `WHERE regio = 'Est'`, en canvi la 2a no i per tant salta un error. Podem comprovar que només s'ha inserit una nova oficina a la taula oficines.



## Limitació vistes actualitzables  

A PostgreSQL només es pot fer INSERT/UPDATE/DELETE en una vista que està feta a
partir d'una taula. Això inclou JOINs i subconsultes.


Exemple:

```SQL
CREATE VIEW clients_repvendes
    AS SELECT num_clie, empresa, rep_clie, nom
         FROM clients
              JOIN rep_vendes
              ON rep_clie = num_empl
  WITH LOCAL CHECK OPTION;
```

Ens mostrarà el següent error:

```SQL
ERROR:  WITH CHECK OPTION is supported only on automatically updatable views
HINT:  Views that do not select from a single table or view are not automatically updatable.
```


## Vistes materialitzades

Cada cop que cridem a una vista s'executa la seva query associada i això pot tenir un cost considerable. 

Per tant, ens podem preguntar si farem servir molt sovint aquesta vista.

Si la resposta és afirmativa ens podem plantejar en fer servir una `MATERIALIZED VIEW`.

Una MATERIALIZED VIEW és una vista que emmagatzema les files de la vista, estalviant el temps de computació de la query, sempre i quan sigui una taula amb poques actualitzacions.


```SQL
CREATE MATERIALIZED VIEW ...
```

## Resum

Resumint, la vista ens ajuda a resoldre el problema de seguretat a una base de dades i de les consultes molt complexes:

+ Podem permetre l'accès a la vista però NO a la taula o taules a partir de les quals s'ha creat.
+ D'altra banda una vista descompon una query al menys en 'dues queries', si més no divideix la complexitat de la query original.


## OBS

Si l'inserció ens dona problemes amb una constraint nullable i considerem que es pot canviar l'estat
això es pot fer de la següent manera (suposem que el camp és _regio_ de la taula _oficines_):

```SQL
ALTER TABLE oficines
ALTER COLUMN regio DROP NOT NULL;
```




## 10.02.22 - VISTAS COMPLEJAS (JORDI ANDIUJAR)

* Operació DML sobre Vistes.

* Una VISTA es una QUERY ALMACENADA.


```SQL
training=> CREATE OR REPLACE VIEW topemp AS SELECT oficina_rep, SUM(vendes) FROM rep_vendes GROUP BY oficina_rep;
CREATE VIEW
training=> SELECT * FROM topemp
training-> ;
 oficina_rep |    sum    
-------------+-----------
             |  75985.00
          22 | 186042.00
          11 | 692637.00
          21 | 835915.00
          13 | 367911.00
          12 | 735042.00
(6 rows)
```

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

```SQL
training=> \d
                    List of relations
 Schema |           Name           | Type  |    Owner    
--------+--------------------------+-------+-------------
 public | clients                  | table | isx36579183
 public | comandes                 | table | isx36579183
 public | oficines                 | table | isx36579183
 public | productes                | table | isx36579183
 public | productes_sense_comandes | table | isx36579183
 public | rep_vendes               | table | isx36579183
 public | rep_vendes_baixa         | table | isx36579183
 public | topemp                   | view  | isx36579183
(8 rows)
```
```SQL
training=> INSERT INTO topemp VALUES(14, 186017)
;
ERROR:  cannot insert into view "topemp"
DETAIL:  Views containing GROUP BY are not automatically updatable.
HINT:  To enable inserting into the view, provide an INSTEAD OF INSERT trigger or an unconditional ON INSERT DO INSTEAD rule.
training=> 
```

### NO SE AÑADE PORQUE ES COMPLEJA


> ¿Saber si una VISTA es SIMPLE o COMPLEJA?.

**VISTAS** 

* _SIMPLES_
	(Permeten)*
	
	
* COMPLEXES --> Té més de una __TAULA__ i/o __CAMPS CALCULATS__.
	
	No permeten DML*
		
	* Els camps calculats poden ser operacions aritmétiques o operacions de GRUP.
		(A TRIGGERS SI)
		
	* Camps calculats (Operaciones aritméticas o be definidos por GRUPO)
		
		OP. TAULA
		
* 	-->		VISTA ---> TAULA

	SGBD
			
			
### WITH CHECK OPTION ES UNA VISTA SIMPLE --> POR ESO SE PUEDEN HACER OPERACIONES DML.


### Cuando se HAGA TRIGGERS, permitirá el DML.



> WITH LOCAL CHECK OPTION ES IMPRESCINDIBLE


> La creación de una VISTA sirve para limitar la seguridad y aislar la base de datos a USUARIOS.

* El jefe hará un SELECT * FROM 
	
* La vista tiene operaciones complejas, para hacer que el usuario sin mucho conocimiento haga operaciones.
	
* Simplifica CONSULTAS
	
* Con JOINS unimos información en diferentes TABLAS. UNION VS JOIN.
	
		
## KEYS Y VISTAS se NECESITAN
	

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Exercicis Vistes

## Exercici 1

Defineix una vista anomenada "oficina_est" que contingui únicament les dades de les oficines de la regió est.

1.Veiem els usuaris de l'oficina = 'Est'

```sql
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
	
```sql
training=> CREATE OR REPLACE VIEW oficina_est AS 
        SELECT * FROM oficines WHERE regio = 'Est'
        WITH LOCAL CHECK OPTION;
CREATE VIEW
training=> 

```

3. Veiem la vista creada. 

```sql
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

```sql
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

```sql
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
	
```sql
training=> CREATE OR REPLACE VIEW rep_oest AS 
        SELECT * FROM rep_vendes WHERE oficina_rep IN (SELECT oficina FROM oficines WHERE regio = 'Oest');
CREATE VIEW

```

```sql
 num_empl |      nom      | edat | oficina_rep |       carrec        | data_contracte | cap |   quota   |  vendes   
----------+---------------+------+-------------+---------------------+----------------+-----+-----------+-----------
      102 | Sue Smith     |   48 |          21 | Representant Vendes | 1986-12-10     | 108 | 350000.00 | 474050.00
      108 | Larry Fitch   |   62 |          21 | Dir Vendes          | 1989-10-12     | 106 | 350000.00 | 361865.00
      107 | Nancy Angelli |   49 |          22 | Representant Vendes | 1988-11-14     | 108 | 300000.00 | 186042.00
(3 rows)

```

## Solución

La següent vista també seria correcta però seria una vista _read-only_:

```sql
CREATE VIEW rep_oest
    AS SELECT rep_vendes.*
         FROM rep_vendes
              JOIN oficines
                ON oficina_rep = oficina
        WHERE regio = 'Oest';
```

Perquè seria una vista només _read-only_? Abans de mirar la solució al final dels exercicis, pensa-ho una mica.
	

## Exercici 3

Crea una vista temporal de nom "comandes_sue" que contingui únicament les
comandes fetes per clients assignats la representant de vendes Sue.


1. Comandes de la Sue Smith
```sql
training=> SELECT * FROM comandes WHERE rep IN (SELECT num_empl FROM rep_vendes WHERE nom = 'Sue Smith');

```

2. Creem la Vista

CREATE OR REPLACE VIEW comandes_sue AS 
	SELECT * FROM comandes WHERE rep IN (SELECT num_empl FROM rep_vendes WHERE nom = 'Sue Smith');
	
```sql
training=> CREATE OR REPLACE VIEW comandes_sue AS 
        SELECT * FROM comandes WHERE rep IN (SELECT num_empl FROM rep_vendes WHERE nom = 'Sue Smith');
CREATE VIEW

```

```sql
 num_comanda |    data    | clie | rep | fabricant | producte | quantitat |  import  
-------------+------------+------+-----+-----------+----------+-----------+----------
      112979 | 1989-10-12 | 2114 | 102 | aci       | 4100z    |         6 | 15000.00
      113048 | 1990-02-10 | 2120 | 102 | imm       | 779c     |         2 |  3750.00
      112993 | 1989-01-04 | 2106 | 102 | rei       | 2a45c    |        24 |  1896.00
      113065 | 1990-02-27 | 2106 | 102 | qsa       | xk47     |         6 |  2130.00
(4 rows)

```

## Solución

PostgreSQL (i altres SGBDR) permet crear vistes temporals, però aquesta
característica no pertany ni tan sols a les _features_ opcionals de SQL
estàndard (a diferència de les taules temporals).

```sql
CREATE TEMP VIEW comandes_sue
    AS SELECT * 
         FROM comandes
        WHERE clie IN 
              (SELECT num_clie 
                 FROM clients 
                WHERE rep_clie IN
                      (SELECT num_empl 
                         FROM rep_vendes 
                        WHERE nom LIKE 'Sue%'));
```


## Exercici 4

Crea una vista de nom "clientes_vip" mostri únicament aquells clients que la
suma dels imports de les seves comandes superin 30000.

```sql
training=*> CREATE VIEW clients_vip
                    AS SELECT cli.*
                         FROM clients cli
                        WHERE cli.num_clie = ANY (SELECT com.clie
                                                    FROM comandes com
                                                GROUP BY com.clie
                                                  HAVING SUM(com.import) > 30000);
CREATE VIEW
training=*> SELECT * FROM clients_vip;
 num_clie |     empresa     | rep_clie | limit_credit
----------+-----------------+----------+--------------
     2103 | Acme Mfg.       |      105 |     50000.00
     2112 | Zetacorp        |      108 |     50000.00
     2117 | J.P. Sinclair   |      106 |     35000.00
     2109 | Chen Associates |      103 |     25000.00
(4 rows)
```

## Solución

```sql
CREATE VIEW clients_vip
    AS SELECT *
         FROM clients 
        WHERE num_clie IN
              (SELECT clie 
                 FROM comandes 
                GROUP BY clie 
               HAVING SUM(import) > 30000);
```

```sql
CREATE VIEW clients_vip
    AS SELECT * 
         FROM clients 
        WHERE 30000 <
             (SELECT SUM(import) 
                FROM comandes 
               WHERE clie = num_clie);
```


## Exercici 5

Crear una vista de nom "info_rep" amb les següents dades dels venedors:
num_empl, nombre, oficina_rep.

```sql
training=*> CREATE VIEW info_rep
                    AS SELECT num_empl, nom, oficina_rep
                         FROM rep_vendes;
CREATE VIEW

training=*> SELECT * FROM info_rep;
 num_empl |      nom      | oficina_rep
----------+---------------+-------------
      105 | Bill Adams    |          13
      109 | Mary Jones    |          11
      102 | Sue Smith     |          21
      106 | Sam Clark     |          11
      104 | Bob Smith     |          12
      101 | Dan Roberts   |          12
      110 | Tom Snyder    |
      108 | Larry Fitch   |          21
      103 | Paul Cruz     |          12
      107 | Nancy Angelli |          22
(10 rows)
```

## Solución

```sql
CREATE VIEW info_rep
    AS SELECT num_empl, nom, oficina_rep
         FROM rep_vendes;
```


## Exercici 6

Crear una vista de nom "info_oficina" que mostri les oficines amb
l'identificador de l'oficina, la ciutat i la regió.

```sql
training=*> CREATE VIEW info_oficina
                    AS SELECT oficina, ciutat, regio
                         FROM oficines;
CREATE VIEW

training=*> SELECT * FROM info_oficina;
 oficina |   ciutat    | regio
---------+-------------+-------
      22 | Denver      | Oest
      11 | New York    | Est
      12 | Chicago     | Est
      13 | Atlanta     | Est
      21 | Los Angeles | Oest
(5 rows)
```

## Solución

```sql
CREATE VIEW info_oficina
    AS SELECT oficina, ciutat, regio
         FROM oficines;
```

## Exercici 7

Crear una vista de nom "info_clie" que contingui el nom de l'empresa dels
clients i l'identificador del venedor que tenen assignat.

```sql
training=*> CREATE VIEW info_clie
                    AS SELECT empresa, rep_clie
                         FROM clients;
CREATE VIEW
training=*> SELECT * FROM info_clie;
      empresa      | rep_clie
-------------------+----------
 JCP Inc.          |      103
 First Corp.       |      101
 Acme Mfg.         |      105
...
(21 rows)
```

## Solución

```sql
CREATE VIEW info_clie
    AS SELECT empresa, rep_clie
         FROM clients;
```

## Exercici 8

Crea una vista de nom "clie_bill" que conté el número de client, el nom de
empresa i el límit de crèdit de tots els clients assignats al representant de
vendes "Bill Adams".

```sql
training=*> CREATE VIEW clie_bill
                    AS SELECT num_clie, empresa, limit_credit
                         FROM clients
                        WHERE rep_clie IN (SELECT num_empl
                                             FROM rep_vendes
                                            WHERE nom = 'Bill Adams');
CREATE VIEW
training=*> SELECT * FROM clie_bill;
 num_clie |     empresa     | limit_credit
----------+-----------------+--------------
     2103 | Acme Mfg.       |     50000.00
     2122 | Three-Way Lines |     30000.00
(2 rows)
```

```sql
CREATE VIEW clie_bill
    AS SELECT num_clie, empresa, limit_credit
         FROM clients 
        WHERE rep_clie IN
              (SELECT num_empl 
                 FROM rep_vendes 
                WHERE nom = 'Bill Adams');
```

## Solución


## Exercici 9

Crea una vista de nom comanda_per_rep que conté les següents dades de les
comandes de cada venedor: id_representant_vendes, quantitat_pedidos,
import_total, import_minim, import_maxim, import_promig.

```sql
training=*> CREATE VIEW comanda_per_rep
                    AS SELECT rep AS id_representant_vendes,
                              COUNT(*) AS quantitat_pedidos,
                              SUM(import) AS import_total,
                              MIN(import) AS import_minim,
                              MAX(import) AS import_maxim,
                              AVG(import) AS import_promig
                         FROM comandes
                         GROUP BY rep;
training=*> SELECT * FROM comanda_per_rep;
 id_representant_vendes | quantitat_pedidos | import_total | import_minim | import_maxim |     import_promig
------------------------+-------------------+--------------+--------------+--------------+------------------------
                    101 |                 3 |     26628.00 |       150.00 |     22500.00 |  8876.0000000000000000
                    108 |                 7 |     58633.00 |       652.00 |     45000.00 |  8376.1428571428571429
                    103 |                 2 |      2700.00 |       600.00 |      2100.00 |  1350.0000000000000000
                    105 |                 5 |     39327.00 |       702.00 |     27500.00 |  7865.4000000000000000
                    107 |                 3 |     34432.00 |       652.00 |     31350.00 | 11477.3333333333333333
                    102 |                 4 |     22776.00 |      1896.00 |     15000.00 |  5694.0000000000000000
                    109 |                 2 |      7105.00 |      1480.00 |      5625.00 |  3552.5000000000000000
                    106 |                 2 |     32958.00 |      1458.00 |     31500.00 |     16479.000000000000
                    110 |                 2 |     23132.00 |       632.00 |     22500.00 | 11566.0000000000000000
(9 rows)
```

## Solución

```sql
CREATE VIEW ped_por_rep
    AS SELECT rep AS id_representant_vendes, 
              COUNT(*) AS quantitat_comandes, 
              SUM(import) AS import_total, 
              MIN(import) AS import_minim, 
              MAX(import) AS import_maxim, 
              ROUND(AVG(import), 2) AS import_promig
         FROM comandes
        WHERE rep IS NOT NULL 
        GROUP BY rep;
```


## Exercici 10

De la vista anterior volem una nova vista per mostrar el nom del representant
de vendes, números de comandes, import total de les comandes i el promig de les
comandes per a cada venedor. S'han d'ordenar per tal que primer es mostrin els
que tenen major import total.

```sql
training=*> CREATE VIEW top_rep
                    AS SELECT nom, quantitat_pedidos, import_total,
                              import_promig
                         FROM comanda_per_rep
                         JOIN rep_vendes ON id_representant_vendes =
                              num_empl
                         ORDER BY import_maxim
                         DESC;
CREATE VIEW
training=*> SELECT * FROM top_rep;
      nom      | quantitat_pedidos | import_total |     import_promig
---------------+-------------------+--------------+------------------------
 Larry Fitch   |                 7 |     58633.00 |  8376.1428571428571429
 Sam Clark     |                 2 |     32958.00 |     16479.000000000000
 Nancy Angelli |                 3 |     34432.00 | 11477.3333333333333333
 Bill Adams    |                 5 |     39327.00 |  7865.4000000000000000
 Dan Roberts   |                 3 |     26628.00 |  8876.0000000000000000
 Tom Snyder    |                 2 |     23132.00 | 11566.0000000000000000
 Sue Smith     |                 4 |     22776.00 |  5694.0000000000000000
 Mary Jones    |                 2 |      7105.00 |  3552.5000000000000000
 Paul Cruz     |                 2 |      2700.00 |  1350.0000000000000000
(9 rows)
```

## Solución

```sql
CREATE VIEW top_rep
    AS SELECT nom, quantitat_comandes, import_total, import_promig
         FROM ped_por_rep
              JOIN rep_vendes
              ON id_representant_vendes = num_empl
        ORDER BY import_maxim DESC;
```



## Exercici 11

Crear una vista de nom "info_comanda" amb les dades de les comandes però amb
els noms del client i venedor en lloc dels seus identificadors.

```sql
training=*> CREATE VIEW info_comanda
                    AS SELECT num_comanda, data, clie.empresa AS nom_client,
                              r.nom AS nom_rep, fabricant, producte,
                              quantitat, import
                         FROM comandes com
                         JOIN clients clie
                           ON com.clie = clie.num_clie
                         JOIN rep_vendes r
                           ON r.num_empl = com.rep;
CREATE VIEW
training=*> SELECT * FROM info_comanda ;
 num_comanda |    data    |    nom_client     |    nom_rep    | fabricant | producte | quantitat |  import
-------------+------------+-------------------+---------------+-----------+----------+-----------+----------
      112961 | 1989-12-17 | J.P. Sinclair     | Sam Clark     | rei       | 2a44l    |         7 | 31500.00
      113012 | 1990-01-11 | JCP Inc.          | Bill Adams    | aci       | 41003    |        35 |  3745.00
      112989 | 1990-01-03 | Jones Mfg.        | Sam Clark     | fea       | 114      |         6 |  1458.00

...
(30 rows)
```

## Solución

```sql
CREATE VIEW info_comanda
    AS SELECT num_comanda, data, empresa, nom,
              fabricant, producte, quantitat, import
         FROM comandes
              JOIN clients
              ON clie = num_clie
    
              JOIN rep_vendes
              ON rep = num_empl;
```

## Exercici 12

Crear una vista anomenada "clie_rep" que mostri l'import total de les comandes
que ha fet cada client a cada representant de vendes. Cal mostrar el nom de
l'empresa i el nom del representant de vendes.

```sql
training=*> CREATE VIEW clie_rep
                    AS SELECT nom_client, nom_rep, SUM(import)
                        FROM info_comanda
                        GROUP BY nom_client, nom_rep;
CREATE VIEW
training=*> SELECT * FROM clie_rep;
    nom_client     |    nom_rep    |   sum
-------------------+---------------+----------
 Holm & Landis     | Dan Roberts   |   150.00
 Ace International | Tom Snyder    | 23132.00
 JCP Inc.          | Paul Cruz     |  2700.00
 First Corp.       | Dan Roberts   |  3978.00
 JCP Inc.          | Bill Adams    |  3745.00
 Acme Mfg.         | Bill Adams    | 35582.00
 Chen Associates   | Nancy Angelli | 31350.00
 Fred Lewis Corp.  | Sue Smith     |  4026.00
 Midwest Systems   | Larry Fitch   |  3608.00
 Holm & Landis     | Mary Jones    |  7105.00
 Peter Brothers    | Nancy Angelli |  3082.00
 Ian & Schmidt     | Dan Roberts   | 22500.00
 J.P. Sinclair     | Sam Clark     | 31500.00
 Orion Corp        | Sue Smith     | 15000.00
 Jones Mfg.        | Sam Clark     |  1458.00
 Orion Corp        | Larry Fitch   |  7100.00
 Rico Enterprises  | Sue Smith     |  3750.00
 Zetacorp          | Larry Fitch   | 47925.00
(18 rows)
```

## Solución

```sql
CREATE VIEW clie_rep
    AS SELECT empresa, nom, SUM(import) 
         FROM info_comanda 
        GROUP BY empresa, nom;
```


## Exercici 13

Crear una vista temporal per substituir la taula "comandes" que mostri les
comandes amb import més gran a 20000 i ordenades per import de forma
descendent.

```sql
training=*> CREATE LOCAL TEMPORARY VIEW comandes_v2
                                    AS SELECT *
                                         FROM comandes
                                        WHERE import > 20000
                                        ORDER BY import DESC;
CREATE VIEW
training=*# SELECT * FROM comandes_v2;
 num_comanda |    data    | clie | rep | fabricant | producte | quantitat |  import  
-------------+------------+------+-----+-----------+----------+-----------+----------
      113045 | 1990-02-02 | 2112 | 108 | rei       | 2a44r    |        10 | 45000.00
      112961 | 1989-12-17 | 2117 | 106 | rei       | 2a44l    |         7 | 31500.00
      113069 | 1990-03-02 | 2109 | 107 | imm       | 775c     |        22 | 31350.00
      112987 | 1989-12-31 | 2103 | 105 | aci       | 4100y    |        11 | 27500.00
      110036 | 1990-01-30 | 2107 | 110 | aci       | 4100z    |         9 | 22500.00
      113042 | 1990-02-02 | 2113 | 101 | rei       | 2a44r    |         5 | 22500.00
(6 rows)
```

## Solución

```sql
CREATE TEMP VIEW comandes
    AS SELECT * 
         FROM comandes
        WHERE import > 20000 
        ORDER BY import DESC;
```


## Exercici 14

Crea una vista anomenada "top_clie" que mostri el nom de l'empresa client i el
total dels imports de les comandes del client. S'han d'ordenar per tal que
primer es mostrin els que tenen major import total.

```sql
training=*> CREATE VIEW top_clie
                     AS SELECT nom_client, SUM(import)
                          FROM info_comanda
                        GROUP BY nom_client
                        ORDER BY SUM(import)
                        DESC;
CREATE VIEW
training=*> SELECT * FROM top_clie;
    nom_client     |   sum
-------------------+----------
 Zetacorp          | 47925.00
 Acme Mfg.         | 35582.00
 J.P. Sinclair     | 31500.00
 Chen Associates   | 31350.00
 Ace International | 23132.00
 Ian & Schmidt     | 22500.00
 Orion Corp        | 22100.00
 Holm & Landis     |  7255.00
 JCP Inc.          |  6445.00
 Fred Lewis Corp.  |  4026.00
 First Corp.       |  3978.00
 Rico Enterprises  |  3750.00
 Midwest Systems   |  3608.00
 Peter Brothers    |  3082.00
 Jones Mfg.        |  1458.00
(15 rows)
```

## Solución

```sql
CREATE VIEW top_clie
    AS SELECT empresa, SUM(import) 
         FROM info_comanda 
        GROUP BY empresa 
        ORDER BY SUM(import) DESC;
```


## Exercici 15

Crea una vista anomenata "top_prod" que mostri les dades de tots els productes
seguit d'un camp anomenat "quant_total" en que es mostri la quantitat de cada
producte que s'ha demanat en totes les comandes. S'ha d'ordenar per tal que
primer es mostrin els productes que tenen més comandes.

```sql
training=*> CREATE VIEW top_prod
                    AS SELECT p.*, SUM(quantitat)
                         FROM productes p
                         JOIN comandes c
                           ON (p.id_fabricant, p.id_producte) =
                              (c.fabricant, c.producte)
                        GROUP BY p.id_fabricant, p.id_producte
                        ORDER BY COUNT(*)
                        DESC;
CREATE VIEW
training=*> SELECT * FROM top_prod;
 id_fabricant | id_producte |     descripcio     |  preu   | estoc | sum 
--------------+-------------+--------------------+---------+-------+-----
 aci          | 41004       | Article Tipus 4    |  117.00 |   139 |  68
 qsa          | xk47        | Reductor           |  355.00 |    38 |  28
 rei          | 2a45c       | V Stago Trinquet   |   79.00 |   210 |  32
 aci          | 4100x       | Peu de rei         |   25.00 |    37 |  30
 aci          | 4100z       | Muntador           | 2500.00 |    28 |  15
 bic          | 41003       | Manovella          |  652.00 |     3 |   2
 fea          | 114         | Bancada Motor      |  243.00 |    15 |  16
 imm          | 779c        | Riosta 2-Tm        | 1875.00 |     9 |   5
 rei          | 2a44r       | Frontissa Dta.     | 4500.00 |    12 |  15
 aci          | 41002       | Article Tipus 2    |   76.00 |   167 |  64
 imm          | 775c        | Riosta 1-Tm        | 1425.00 |     5 |  22
 aci          | 4100y       | Extractor          | 2750.00 |    25 |  11
 rei          | 2a44l       | Frontissa Esq.     | 4500.00 |    12 |   7
 aci          | 41003       | Article Tipus 3    |  107.00 |   207 |  35
 fea          | 112         | Coberta            |  148.00 |   115 |  10
 rei          | 2a44g       | Passador Frontissa |  350.00 |    14 |   6
 imm          | 773c        | Riosta 1/2-Tm      |  975.00 |    28 |   3
(17 rows)
```
    
## Solución

```sql
CREATE VIEW top_prod
    AS SELECT productes.*, SUM(quantitat)
         FROM productes
              JOIN comandes
              ON (id_fabricant, id_producte) = (fabricant, producte)
        GROUP BY id_fabricant, id_producte
        ORDER BY COUNT(*) DESC;
``` 



## Exercici 16

Crea una vista anomenada "responsables" que mostri un llistat de tots els
representants de vendes. En un camp anomenat "empl" ha de mostrar el nom de
cada representant de vendes. També ha de mostrar un camp anomenat "superior"
que mostri el nom del cap del representant de vendes, en cas que el
representant de vendes tingui cap. També ha de mostrar un camp anomenat
"oficina_superior" que mostri el nom del director de l'oficina en que treballa
el representant de vendes, en cas que el representant de vendes tingui
assignada una oficina aquesta tingui un director.

```sql
training=*> CREATE VIEW responsables
                    AS SELECT empl.nom AS empl, jefe.nom AS jefe,
                              dir_emp.nom AS dir_emp
                         FROM rep_vendes empl
                    LEFT JOIN rep_vendes jefe
                           ON empl.cap = jefe.num_empl
                    LEFT JOIN oficines o
                           ON empl.oficina_rep = o.oficina
                    LEFT JOIN rep_vendes dir_emp
                           ON dir_emp.num_empl = o.director;
CREATE VIEW
training=*> SELECT * FROM responsables;
     empl      |    jefe     |   dir_emp
---------------+-------------+-------------
 Bill Adams    | Bob Smith   | Bill Adams
 Mary Jones    | Sam Clark   | Sam Clark
 Sue Smith     | Larry Fitch | Larry Fitch
 Sam Clark     |             | Sam Clark
 Bob Smith     | Sam Clark   | Bob Smith
 Dan Roberts   | Bob Smith   | Bob Smith
 Tom Snyder    | Dan Roberts |
 Larry Fitch   | Sam Clark   | Larry Fitch
 Paul Cruz     | Bob Smith   | Bob Smith
 Nancy Angelli | Larry Fitch | Larry Fitch
(10 rows)
```

## Solución

```sql
CREATE VIEW responsables
    AS SELECT empleats.nom AS empl, caps.nom AS superior, directors.nom AS ofi_dire 
         FROM rep_vendes empleats 
              LEFT JOIN rep_vendes caps
              ON empleats.cap = caps.num_empl 
              
              LEFT JOIN oficines
              ON empleats.oficina_rep = oficina 

              LEFT JOIN rep_vendes directors
              ON director = directors.num_empl;
```

## Extres

+ Exercici2: recordem que a PostreSQL tenim la limitació de les vistes actualitzables (tot i que se li podria donar una volta amb les RULES, fora del temari), per exemple una consulta multitaula no ho serà, ni una agrupada ... Al manual d'ajuda de PostgreSQL tenim:

	- The view must have exactly one entry in its FROM list, which must be a table or another updatable view.
	- The view definition must not contain WITH, DISTINCT, GROUP BY, HAVING, LIMIT, or OFFSET clauses at the top level.
	- The view definition must not contain set operations (UNION, INTERSECT or EXCEPT) at the top level.
	- The view's select list must not contain any aggregates, window functions or set-returning functions.

