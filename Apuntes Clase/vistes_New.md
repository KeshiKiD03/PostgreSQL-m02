# Vistes (VIEWS)


## L'origen de les vistes. 

Perquè necessitem les vistes?

Dos dels problemes que s'han de resoldre quan es treballa amb una SGBD són:

- Les consultes de gran complexitat, amb una gran quantitat de JOIN's, subconsultes i/o agrupacions en una única query.
- L'accés d'usuaris a taules de la base de dades, que pertany al camp de la seguretat de la base de dades.

Hi ha diferents maneres de resoldre aquests problemes i una d'aquestes és la creació d'una vista(VIEW).


## Definició de vista

Una vista és una taula virtual que no està emmagatzemada enlloc (en cap esquema) i que està definida per una _query_. La vista NO conté l'estructura, ni les dades d'una taula, sinó una sentència SELECT. 

Aquesta sentència (query) s'executa cada cop que volem fer servir la vista.

Podem pensar una VIEW com una _visió_ de la query.

## Sintaxi

Una primera aproximació seria:

```
CREATE VIEW oficines_est
    AS SELECT oficina, ciutat, regio
         FROM oficines
        WHERE regio = 'Est'
        ORDER BY ciutat;
```


Mostrem informació de la vista:

```
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

```
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

```
INSERT INTO  oficines_est
VALUES (88, 'Sofia', 'Est');

INSERT INTO  oficines_est 
VALUES (55, 'Madrit', 'Sud');
```

El programa psql respon a les nostres insercions:

```
INSERT 0 1
INSERT 0 1
```

És a dir sembla que ens ha inserit dues oficines a la vista oficines_est, però
no ho hauria d'haver fet.

Comprovem què ha passat a la vista:

```
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

```
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

	```
	CREATE VIEW oficines_est
		AS SELECT oficina, ciutat, regio
			 FROM oficines
			WHERE regio = 'Est'
			ORDER BY ciutat
	  WITH LOCAL CHECK OPTION;
	```

	>També podem utilitzar l'ordre `CREATE OR REPLACE VIEW` (tot i que no és ANSI és
	vàlida a molts SGBDR: PostgreSQL, MySQL, Oracle ...)

+ Si tornem a executar els INSERTs d'abans:

	```
	INSERT INTO  oficines_est
	VALUES (88, 'Sofia', 'Est');

	INSERT INTO  oficines_est
	VALUES (55, 'Madrit', 'Sud');
	```

	Veiem que ara el resultat és diferent:

	```
	INSERT 0 1
	ERROR:  new row violates check option for view "oficines_est"
	DETAIL:  Failing row contains (55, Madrit, Sud, null, null, null).
	```

	La primera instrucció compleix la condició `WHERE regio = 'Est'`, en canvi la
	2a no i per tant salta un error. Podem comprovar que només s'ha inserit una
	nova oficina a la taula oficines.




## Limitació vistes actualitzables  

A PostgreSQL només es pot fer INSERT/UPDATE/DELETE en una vista que està feta a
partir d'una taula. Això inclou JOINs i subconsultes.


Exemple:

```
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


## Vistes materialitzades

Cada cop que cridem a una vista s'executa la seva query associada i això pot tenir un cost considerable. 

Per tant, ens podem preguntar si farem servir molt sovint aquesta vista.

Si la resposta és afirmativa ens podem plantejar en fer servir una `MATERIALIZED VIEW`.

Una MATERIALIZED VIEW és una vista que emmagatzema les files de la vista, estalviant el temps de computació de la query, sempre i quan sigui una taula amb poques actualitzacions.


```
CREATE MATERIALIZED VIEW ...
```

## Resum

Resumint, la vista ens ajuda a resoldre el problema de seguretat a una base de dades i de les consultes molt complexes:

+ Podem permetre l'accès a la vista però NO a la taula o taules a partir de les quals s'ha creat.
+ D'altra banda una vista descompon una query al menys en 'dues queries', si més no divideix la complexitat de la query original.


## OBS

Si l'inserció ens dona problemes amb una constraint nullable i considerem que es pot canviar l'estat
això es pot fer de la següent manera (suposem que el camp és _regio_ de la taula _oficines_):

```
ALTER TABLE oficines
ALTER COLUMN regio DROP NOT NULL;
```
