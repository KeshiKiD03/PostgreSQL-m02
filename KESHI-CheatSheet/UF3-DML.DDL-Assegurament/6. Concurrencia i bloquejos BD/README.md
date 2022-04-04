# CHEATSHEET KESHI [11]

# CONCURRENCIA Y BLOQUEOS 

## CONCURRENCIA Y BLOQUEOS DE BD

### KESHI
# Concurrència i bloquejos

Quan diversos usuaris/processos ataquen una base de dades podem tenir problemes amb la consistència de les dades. És per això que cada gestor de bases de dades intenta solucionar aquest problema de diverses maneres. Anem a veure com funciona PostgreSQL amb un exemple. (Basat en [Exploring Query Locks in Postgres](http://big-elephants.com/2013-09/exploring-query-locks-in-postgres/))

### Creant el parc de sorra

![Sandbox](ht_BuildaSandbox_hero_image.jpg)

Creem la base de dades _sandbox_, la taula _toys_ i afegim  un _cotxet_, una _excavadora_ i una _pala_.

```SQL

-- Creem la DB

CREATE DATABASE sandbox;

-- Ens conectem a la sandbox

\c sandbox

-- Creem la taula de TOYS

CREATE TABLE toys (
	PRIMARY KEY(id),
	id      SERIAL          NOT NULL,   -- identificador de la joguina
	name    VARCHAR(36),                -- nom de la joguina
	usage   INTEGER         NOT NULL
	                        DEFAULT 0   -- número de cops que s'ha usat
);

INSERT INTO toys (name)
VALUES ('car'), ('digger'), ('shovel');

\q
```

### Alice i Bob entren al parc de sorra

Anem a simular que dos usuaris accedeixen a la base de dades al mateix temps.
Hi ha concurrència.

Alice:
```SQL
psql sandbox
\set PROMPT1 '[Alice] %/%R%# ' -- %R es el nombre de la DATABASE
```

Bob:
```SQL
psql sandbox
\set PROMPT1 '[Bob] %/%R%# '
```

Si fem `man psql` i busquem la cadena PROMPT veurem els diferents valors _%/_ o
_%R_ ...


### Alice i Bob miren les joguines (AccessShareLock)

* Sol: No pasa nada, todo good

Alice:
```SQL
[Alice] sandbox=> BEGIN;
BEGIN
[Alice] sandbox=> SELECT * FROM toys;
 id |  name  | usage 
----+--------+-------
  1 | car    |     0
  2 | digger |     0
  3 | shovel |     0
(3 rows)
```

Bob:
```SQL
[Bob] sandbox=> BEGIN;
BEGIN
[Bob] sandbox=>  SELECT * FROM toys;
 id |  name  | usage 
----+--------+-------
  1 | car    |     0
  2 | digger |     0
  3 | shovel |     0
(3 rows)
```

No hi ha problema!!!

### Alice vol jugar amb l'excavadora i Bob vol jugar amb la pala (RowExclusiveLock)

* Sol: No interfieren ya que se bloquean filas diferentes.

Alice juga amb l'excavadora (digger): incrementem en 1 el número de cops que
s'utilitza aquesta joguina.

```SQL
[Alice] sandbox=> UPDATE toys SET usage = usage + 1 WHERE id = 2;
UPDATE 1
[Alice] sandbox=> SELECT * FROM toys;
 id |  name  | usage
----+--------+-------
  1 | car    |     0
  3 | shovel |     0
  2 | digger |     1
(3 rows)
```

Bob fa el mateix amb la pala (shovel).

```SQL
[Bob] sandbox=> UPDATE toys SET usage = usage + 1 WHERE id = 3;
UPDATE 1
[Bob] sandbox=> SELECT * FROM toys;
 id |  name  | usage 
----+--------+-------
  1 | car    |     0
  2 | digger |     0
  3 | shovel |     1
(3 rows)
```


Alice acaba la seva transacció:

```SQL
[Alice] sandbox=> COMMIT;
COMMIT
[Alice] sandbox=> SELECT * FROM toys;
 id |  name  | usage 
----+--------+-------
  1 | car    |     0
  3 | shovel |     0
  2 | digger |     1
(3 rows)
```

Bob fa el mateix:

```SQL
[Bob] sandbox=> COMMIT;
COMMIT
[Bob] sandbox=> SELECT * FROM toys;
 id |  name  | usage 
----+--------+-------
  1 | car    |     0
  2 | digger |     1
  3 | shovel |     1
(3 rows)
```

Cap problema, cadascú usa la joguina que **vol**. S'estan __bloquejant__ __files__
__diferents__. En quant es fan els dos __COMMIT__ a la base de dades queden modificades
les __dues files__.

### Alice i Bob volen jugar amb el cotxe (RowExclusiveLock)

* Sol: RowExclusiveLock - Usan el mismo campo por lo cual FCFS y el otro se espera.

Alice és la que agafa primer el cotxe:

```SQL
[Alice] sandbox=> BEGIN;
BEGIN
[Alice] sandbox=> UPDATE toys SET usage = usage+1 WHERE id = 1;
UPDATE 1
```

Bob encara veu les dades antigues, perquè Alice no ha fet el COMMIT:

```SQL
[Bob] sandbox=> BEGIN;
BEGIN

-- Todavía ve lo antiguo ya que Alice no ha hecho COMMIT.

[Bob] sandbox=> SELECT * FROM toys;
 id |  name  | usage
----+--------+-------
  1 | car    |     0
  2 | digger |     1
  3 | shovel |     1
(3 rows)
```

Però ara Bob també vol el cotxe!

```SQL
[Bob] sandbox=> UPDATE toys SET usage = usage + 1 WHERE id = 1;

-- A partir de aquí se hace el BLOQUEO, porque usan el mismo juguete.
```

Ara el terminal es queda "penjat" ja que Alice té bloquejada la fila (és a dir,
de moment no li deixa el cotxe).

Alice decideix no jugar amb el cotxe i fa un ROLLBACK:

```SQL

-- Para que Alice deje el juguete tiene que hacer un ROLLBACK o COMMIT. Este caso es ROLLBACK;

[Alice] sandbox=> ROLLBACK;
ROLLBACK
```

En aquest cas la instrucció de Bob s'executa.

Finalment Bob fa un COMMIT ja que ell sí que vol jugar amb el cotxe.

```SQL
UPDATE 1
[Bob] sandbox=> COMMIT;
COMMIT
[Bob] sandbox=> SELECT * FROM toys;
 id |  name  | usage
----+--------+-------
  2 | digger |     1
  3 | shovel |     1
  1 | car    |     1
(3 rows)

-- Bob ha usado el juguete.
```

### Alice vol jugar amb totes les joguines alhora (AccessExclusiveLock)

Alice vol jugar amb tot, fem un bloqueig explícit amb l'ordre LOCK:

* Sol: LOCK TABLE toys IN ACCESS EXCLUSIVE MODE; --> Bloquea la tabla

```SQL
[Alice] sandbox=> BEGIN;
BEGIN
[Alice] sandbox=> LOCK TABLE toys IN ACCESS EXCLUSIVE MODE;
LOCK TABLE
```

Bob intenta jugar amb l'excavadora, però no pot, tot i que l'Alice no està
jugant-hi la té bloquejada!

```SQL
[Bob] sandbox=> BEGIN; UPDATE toys SET usage = usage+1 WHERE id = 2;
BEGIN

-- Aquí se queda colgada
```

Li diem a Alice que això de tenir-ho tot sense jugar-hi no està bé. La convencem i fa un COMMIT:

```SQL
[Alice] sandbox=> COMMIT;
COMMIT
```

``Ara Bob ja pot jugar amb l'excavadora!``

```SQL
UPDATE 1
[Bob] sandbox=> COMMIT;
COMMIT
[Bob] sandbox=> SELECT * FROM toys;
 id |  name  | usage 
----+--------+-------
  3 | shovel |     1
  1 | car    |     1
  2 | digger |     2
(3 rows)
```

### Alice vol triar una joguina i que ningú li tregui fins que es decideixi (RowExclusiveLock)

* Sol: FOR UPDATE - RowExclusiveLock --> FOR UPDATE, lo mismo que el anterior, las mira y las bloquea. FCFS.

Similar al que ha fet abans, les mira i les bloqueja...

Fem servir l'ordre _SELECT ... FROM table FOR UPDATE_ que 
bloqueja les files retornades pel SELECT fins que termini l'actual transacció.


```SQL
[Alice] sandbox=> BEGIN; SELECT * FROM toys FOR UPDATE;
BEGIN
 id |  name  | usage 
----+--------+-------
  3 | shovel |     1
  1 | car    |     1
  2 | digger |     2
(3 rows)
```

Bob intenta jugar amb la pala:

```SQL
[Bob] sandbox=> UPDATE toys SET usage = usage + 1 WHERE id = 2;

-- Se queda colgado a aquí
```

I no pot.

En quant Alice desbloqueja...

```SQL
[Alice] sandbox=> COMMIT;
COMMIT
```

...ja pot jugar-hi!

```SQL
UPDATE 1
[Bob] sandbox=> SELECT * FROM toys;
 id |  name  | usage 
----+--------+-------
  3 | shovel |     1
  1 | car    |     1
  2 | digger |     3
(3 rows)
```

### No es pot jugar amb dues joguines alhora! (deadlock)

* Sol: Cuando se intenta hacer un UPDATE y otro quiere hacer otro UPDATE en el mismo campo, se produce un DEADLOCK y reactiva el primero que lo ha __UTILIZADO__. En este caso Alice hace un update el COCHE y luego BOB hace un UPDATE de la PALA, ALICE no puede USAR la PALA al mismo tiempo, porque lo tiene BOB y se le queda pillado a ALICE.
Bob realiza un UPDATE al COCHE (Lo tiene Alice), saldrá el error de DEADLOCK a BOB y desbloquea a ALICE.

Alice juga amb el cotxe

```SQL
[Alice] sandbox=> BEGIN; UPDATE toys SET usage = usage+1 WHERE id = 1;
BEGIN
UPDATE 1
```

Bob juga amb l'excavadora

```SQL
[Bob] sandbox=> BEGIN; UPDATE toys SET usage = usage + 1 WHERE id = 2;
BEGIN
UPDATE 1
```

Alice intenta jugar amb l'excavadora, però Bob la té bloquejada. Alice es queda esperant...

```SQL
[Alice] sandbox=> UPDATE toys SET usage = usage + 1 WHERE id = 2;

-- Se queda colgado aquí
```

Bob no deixa __l'excavadora__, però intenta jugar amb el cotxe, però Alice el té bloquejat i es queda esperant... Però no pot Alice no el pot desbloquejar perquè ella està esperant el desbloqueig de Bob!!!

```SQL
[Bob] sandbox=> UPDATE toys SET usage = usage + 1 WHERE id = 1;
ERROR:  deadlock detected
DETAIL:  Process 19208 waits for ShareLock on transaction 1268; blocked by process 19166.
Process 19166 waits for ShareLock on transaction 1269; blocked by process 19208.
HINT:  See server log for query details.
CONTEXT:  while updating tuple (0,1) in relation "toys"
```

La transacció de Bob ha donat un error, ja no es farà res. Per tant Alice pot jugar amb l'excavadora que ha quedat desbloquejada.

```SQL
UPDATE 1
[Alice] sandbox=> COMMIT;
COMMIT
[Alice] sandbox=> SELECT * FROM toys;
 id |  name  | usage 
----+--------+-------
  3 | shovel |     1
  1 | car    |     2
  2 | digger |     4
(3 rows)
```


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Ejercicio Transacciones + Concurrencia y bloqueos

# Exercicis de transaccions


## Exercici 1

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```sql
INSERT INTO punts (id, valor)
VALUES (10, 5);
BEGIN;
UPDATE punts
   SET valor = 4
 WHERE id = 10;
ROLLBACK;
SELECT valor
  FROM punts
 WHERE id = 10;
```

* Realiza un INSERT a la tabla PUNTOS y añade dos valores nuevos.

* Empieza la transacción con BEGIN. Antes de ello hay un autocomit.

* Realiza un UPDATE de la tabla PUNTOS y cambia el valor de 4 filtrando a ID = 10.

* Hace un ROLLBACK y no guardará el UPDATE y volverá atrás y saldrá de la transacción.

* Muestra el último select **SELECT**

## Solución

- Primer fem 'INSERT' a la taula 'punts' i introduïm dos valors nous.

- A continuació començem la transacció ('BEGIN;').

- Fem un 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 4 quan es compleixi la condició.

- Tot el que és fa abans del 'ROLLBACK;' (dins del 'BEGIN;') no és desarà, tornarà enrere i ens treurà de la transacció.

- Quan fem el 'SELECT' (fora de la transacció), no ens sotirà cap valor ja que no s'ha efectuat l'update que volíem fer.


## Exercici 2

Analitzant les següents sentències explica quins canvis es realitzen i on es realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```sql
INSERT INTO punts (id, valor)
VALUES (20,5);

BEGIN;
UPDATE punts
   SET valor = 4
 WHERE id = 20;
COMMIT;

SELECT valor
  FROM punts
 WHERE id = 20;
```


* Realiza un INSERT a la tabla PUNTOS y añade dos valores nuevos.

* Empieza la transacción con BEGIN. Antes de ello hay un autocomit.

* Realiza un UPDATE de la tabla PUNTOS y cambia el valor de 4 filtrando a ID = 10.

* Se realiza un COMMIT, se guarda todo lo que hay antes (DENTRO DEL COMIT). Saca de la TRANSACCIÓN.

* Muestra EL SELECT FINAL.

## Solución

- Primer fem 'INSERT' a la taula 'punts' i introduïm dos valors nous.

- A continuació començem la transacció ('BEGIN;').

- Fem un 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 4 quan es compleixi la condició.

- Tot el que és fa abans del 'COMMIT;' (dins del 'BEGIN;') quedarà desat i ens treurà de la transacció.

- Quan fem el 'SELECT' (fora de la transacció), ens sotirà el valor pel que filtrem ja que s'ha efectuat l'update que volíem fer.

## Exercici 3

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```sql
INSERT INTO punts (id, valor)
VALUES (30,5);

BEGIN;
UPDATE punts
   SET valor = 4
 WHERE id = 30;

SAVEPOINT a;
INSERT INTO punts (id, valor)
VALUES (31,7);

ROLLBACK;
SELECT valor
  FROM punts
 WHERE id = 30;
```

* Se realiza el INSERT.

* Se inicializa un BEGIN y posteriormente un UPDATE y un SAVEPOINT al final.

* Se vuelve a hacer otro INSERT de una fila nueva.

* Hay un ROLLBACK y deshace el cambio y vuelve al BEGIN (INICIO) ya que no especifica el ROLLBACK TO (En este caso al SAVEPOINT).

* Muestra 30 y 5. Ya que antes del BEGIN hay un AUTOCOMMIT.


 ## Solución

- Primer fem 'INSERT' a la taula 'punts' i introduïm dos valors nous.

- A continuació començem la transacció ('BEGIN;').

- Fem un 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 4 quan es compleixi la condició.

- Fem un 'checkpoint' i li assignem un alias ('SAVEPOINT a;').

- Fem 'INSERT' i introduïm més valors a la taula 'punts'.

- Tot el que és fa abans del 'ROLLBACK;' (dins del 'BEGIN;' i incloent el que s'ha fet abans del 'SAVEPOINT a;') no és desarà, no és desarà ja que tornarà enrere (TOT) perquè no li hem especifcat que volem eliminar els canvis fins el nostre 'SAVEPOINT', llavors, ens treurà de la transacció sense efectuar cap modificació.

- Quan fem el 'SELECT' (fora de la transacció), no ens sotirà cap valor ja que no s'ha efectuat l'update que volíem fer.

## Exercici 4

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```sql
DELETE FROM punts;
INSERT INTO punts (id, valor)
VALUES (40,5);

# AUTOCOMIT

BEGIN;
UPDATE punts 
   SET valor = 4
 WHERE id = 40;

SAVEPOINT a;
INSERT INTO punts (id, valor)
VALUES (41,7);
ROLLBACK TO a;
SELECT COUNT(*)
  FROM punts;
```

* Se realiza DML de borrado

* Hay un autocomit antes del BEGIN.

* Se inicializa el BEGIN y sentencia DML de UPDATE.

* Se crea un punto de guardado - SAVEPOINT.

* El último DML de INSERT no se guarda ya que hace un ROLLBACK a SAVEPOINT A.

* Muestra un count de punts.

## Solución

- Primer fem 'INSERT' a la taula 'punts' i introduïm dos valors nous.

- A continuació començem la transacció ('BEGIN;').

- Fem un 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 4 quan es compleixi la condició.

- Fem un 'checkpoint' i li assignem un alias ('SAVEPOINT a;').

- Fem 'INSERT' i introduïm més valors a la taula 'punts'.

- Tot el que és fa després del 'ROLLBACK TO a;' (sense incloure el que s'ha fet abans del 'SAVEPOINT a;') no és desarà, no és desarà ja que tornarà enrere (fins el 'SAVEPOINT a;') perquè li hem especifcat que volem eliminar els canvis efecuats després del nostre 'SAVEPOINT', llavors, ens treurà de la transacció efectuant només el que s'ha fet abans del 'SAVEPOINT a;'.

- Quan fem el 'SELECT' (dins de la transacció), no ens sotiràn més camps ja que no s'ha efectuat l'insert de després del 'SAVEPOINT a;'.

- Per sortir de la transacció i efectuar els canvis, falta un 'COMMIT;'.

## Exercici 5

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```sql
INSERT INTO punts (id, valor)
VALUES (50,5);

# Autocomit

# A partir de aquí se hace EL DML

BEGIN;
SELECT id, valor
 WHERE punts;
UPDATE punts
   SET valor = 4
 WHERE id = 50;

COMMIT;

--Se realiza el BEGIN y la sentencia DML

SELECT valor
  FROM punts
 WHERE id = 50;

--El SELECT mostrará valor = 4.


```

## Solución

- Primer fem 'INSERT' a la taula 'punts' i introduïm dos valors nous.

- A continuació començem la transacció ('BEGIN;').

- Fem un 'SELECT' sobre la taula 'punts' seleccionant dos valors en concret però en comptes de posar 'FROM <taula>', posem 'WHERE <taula>' (la sentència està mal estructurada).

- Fem un 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 4 quan es compleixi la condició.

- Fem 'COMMIT;' però ens farà automàticament 'ROLLBACK', no desarà els canvis, tot el que hem fet no es guardarà.

- Quan fem el 'SELECT' (fora de la transacció), no ens sotiràn cap valor ja que no s'han efectuat els canvis ('UPDATE').

## Exercici 6

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```sql
DELETE FROM punts;
INSERT INTO punts (id, valor)
VALUES (60,5);

--Autocomit

--Se guarda lo que hay antes de aquí

BEGIN;

--Se inicia la transacciçon

UPDATE punts
   SET valor = 4
 WHERE id = 60;


SAVEPOINT a;

--Se crea un SAVE POINT a

INSERT INTO punts (id, valor)
VALUES (61,8);

--DML

SAVEPOINT b;
INSERT punts (id, valor)
VALUES (62,9);

ROLLBACK TO b;

--Se comite el último INSERT y vuelve al SAVEPOINT b.

COMMIT;

SELECT SUM(valor)
  FROM punts;


--Muestra una suma de los valores pero omite el Savepoint B en adelante hasta el ROLLBACK.

```

## Solución

- Primer fem 'DELETE' a la taula 'punts' i eliminem per complert tots els valors d'aquesta.

- Ara fem 'INSERT' a la taula 'punts' i introduïm dos valors nous.

- A continuació començem la transacció ('BEGIN;').

- Fem un 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 4 quan es compleixi la condició.

- Fem un 'checkpoint' i li assignem un alias ('SAVEPOINT a;').

- Fem 'INSERT' i introduïm més valors a la taula 'punts'.

- Fem altre 'checkpoint' i li assignem un alias ('SAVEPOINT b;').

- Fem 'INSERT' i introduïm més valors a la taula 'punts'.

- Tot el que és fa després del 'ROLLBACK TO b;' (sense incloure el que s'ha fet abans del 'SAVEPOINT b;') no és desarà, no és desarà ja que tornarà enrere (fins el 'SAVEPOINT b;') perquè li hem especifcat que volem eliminar els canvis efecuats després del nostre 'SAVEPOINT'.

- Fem un 'COMMIT;' per efectuar els canvis.

- Quan fem el 'SELECT' (fora de la transacció), no ens sotiràn més camps ja que no s'ha efectuat l'insert de després del 'SAVEPOINT a;'.

## Exercici 7

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en
compte que cada sentència s'executa en una connexió determinada.

```sql
DELETE FROM punts; -- Connexió 0
INSERT INTO punts (id, valor)
VALUES (70,5); -- Connexió 0

--Bob inicia su conexión y hace DML

BEGIN; -- Connexió 1
DELETE FROM punts; -- Connexió 1

--Con el autocomit de antes Alice realiza DML pero hasta que no haga COMMIT o ROLLBACK no se verán los cambios

SELECT COUNT(*) 
  FROM punts; -- Connexió 2

--Tanjiro - Este último mostrará sólo la de la conexión 0 , no la 1.

```

## Solución

- Des de la 'Connexió 0' fem 'DELETE' a la taula 'punts' i eliminem per complert tots els valors d'aquesta.

- Des de la mateixa connexió, fem 'INSERT' a la taula 'punts' i introduïm dos valors nous.

- Des de la 'Connexió 1' començem la transacció ('BEGIN;').

- Des de la mateixa connexió, fem 'DELETE' a la taula 'punts' i eliminem per complert tots els valors d'aquesta.

- Des de la 'Connexió 2'fa un 'COUNT(*)' li surt un valor ja que des de la 'Connexió 1' no s'ha desat cap canvi.


## Exercici 8

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en
compte que cada sentència s'executa en una connexió determinada.

```sql
INSERT INTO punts (id, valor)
VALUES (80,5); -- Connexió 0

INSERT INTO punts (id, valor)
VALUES (81,9); -- Connexió 0

--Autocomit

--Bob realiza los DML. Inicia la transacción.

BEGIN; -- Connexió 1

UPDATE punts 
   SET valor = 4
 WHERE id = 80; -- Connexió 1

--Autocomit

--Inicio de la transacción de Alice con los DML de update.

BEGIN; -- Connexió 2
UPDATE punts 
   SET valor = 8
 WHERE id = 81; -- Connexió 2

# Se quedará pillada la conexión de BOB. # DEADLOCK HACE UN ROLLBACK AUTOMÁTICO

UPDATE punts
   SET valor = 10
 WHERE id = 81; -- Connexió 1

-- BOB realiza otra conexión paralela a la BD e intenta hacer el UPDATE, tiene que hacer el COMMIT o ROLLBACK --> ALICE

-- Alice sigue con su UPDATE

UPDATE punts
   SET valor = 6
 WHERE id = 80; -- Connexió 2

COMMIT; -- Connexió 2

-- Alice hace el COMMIT; 

COMMIT; -- Connexió 1

--Bob hace su 2do update y hace el COMIT.
 


--Ahora si los cambios se verán reflejadas

SELECT valor
  FROM punts
 WHERE id = 80; -- Connexió 0

--Hasta que no terminen de hacer COMMIT o ROLLBACK ninguno de los dos conexión 0 no podrá ver los cambios.

```

## Solución

- Des de la 'Connexió 0' fem 'INSERT' dos cops sobre la taula 'punts' per inserir nous valors.

- Des de la 'Connexió 1' començem la transacció ('BEGIN;').

- Des de la mateixa connexió fem un 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 4 quan es compleixi la condició.

- Des de la 'Connexió 2' començem la transacció ('BEGIN;').

- Des de la mateixa connexió fem un 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 8 quan es compleixi la condició.

- Des de la 'Connexió 1' fem un 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 10 quan es compleixi la condició.

- Tornem a la 'Connexió 2' i fem un 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 6 quan es compleixi la condició però es bloquejarà perquè aquest valor està sent utilitzat per la 'Connexió 1' --> (DEADLOCK), llavorns, farà un 'ROLLBACK' automàtic.

- Tornem a la 'Connexió 1' i fem un 'COMMIT;'.

- Tornem a la 'Connexió 0' i fem un 'SELECT;' sobre la taula 'punts' quan es compleixi la condició i ens retorna 4 com a valor.


## Exercici 9

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en
compte que cada sentència s'executa en una connexió determinada.

```SQL
INSERT INTO punts (id, valor)
VALUES (90,5); -- Connexió 0

BEGIN; -- Connexió 1
DELETE FROM punts; -- Connexió 1

BEGIN; -- Connexió 2
INSERT INTO punts (id, valor)
VALUES (91,9); -- Connexió 2
COMMIT; -- Connexió 2

COMMIT; -- Connexió 1

SELECT valor
  FROM punts
 WHERE id = 91; -- Connexió 0
```

## Solución

- Des de la 'Connexió 0' fem un 'INSERT' sobre la taula 'punts' i introduïm els valors necesaris.

- Des de la 'Connexió 1' començem la transacció ('BEGIN;').

- Des de la mateixa connexió fem un 'DELETE' i esborrem tot el contingut de la taula 'punts'.

- Des de la 'Connexió 2' començem un altra transacció ('BEGIN;').

- Des de la mateixa connexió fem 'INSERT' i inserim dos valors nous.

- Des de la mateixa connexió desem els canvis fent un 'COMMIT;'

- Des de la 'Connexió 1' desem els canvis fent un 'COMMIT;'.

- Des de la 'Connexió 0' fem un 'SELECT;' sobre la taula 'punts' quan es compleixi la condició i ens retorna 9 com a valor.

## Exercici 10

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en
compte que cada sentència s'executa en una connexió determinada.

```sql
INSERT INTO punts (id, valor)
VALUES (100,5); -- Connexió 0

--Autocomit

--Inicio de la transacción

BEGIN; -- Connexió 1
UPDATE punts
   SET valor = 6
 WHERE id = 100; -- Connexió 1

# Autocomit

# Inicio de la transacción

BEGIN; -- Connexió 2
UPDATE punts
   SET valor = 7
 WHERE id = 100; -- Connexió 2
COMMIT; -- Connexió 2

COMMIT; -- Connexió 1

SELECT valor FROM punts
 WHERE id = 100; -- Connexió 0
```

## Solución

- Des de la 'Connexió 0' fem 'INSERT' sobre la taula 'punts' i introduïm els valor necesaris.

- Des de la 'Connexió 1' començem la transacció ('BEGIN;'). 

- Des de la mateixa connexió fem 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 6 quan es compleixi la condició.

- Des de la 'Connexió 2' començem la transacció ('BEGIN;').

- Des de la mateixa connexió fem 'update 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 7 quan es compleixi la condició, però es queda bloquejat ja que aquest valor s'està modificant en la 'Connexió 1'. F

- Des de la mateixa connexió fem un 'COMMIT' però no s’executarà fins que la 'Connexió 1' acabi la transacció.

- Des de la 'Connexió 1' fem un 'COMMIT' de la transacció.

- Ara, des de la 'Connexió 0' fem un 'SELECT' de la taula 'punts' quan és compleixi la condició i ens retorna 7 degut a que després s’acabi la transacció de 'Connexió 1', s’executa la transacció de la 'Connexió 2'.

## Exercici 11

Analitzant les següents sentències explica quins canvis es realitzen i on es realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en compte que cada sentència s'executa en una connexió determinada.

```SQL
INSERT INTO punts (id, valor)
VALUES (110,5); -- Connexió 0
INSERT INTO punts (id, valor)
VALUES (111,5); -- Connexió 0

--AUTOCOMIT

-- INICIO DE LA TRANSACCIÓN BOB

BEGIN; -- Connexió 1
UPDATE punts
   SET valor = 6
 WHERE id = 110; -- Connexió 1

-- AUTOCOMMIT

-- SE REALIZA DML UPDATE

-- INICIO DE LA TRANSACCIÓN DE ALICE

BEGIN; -- Connexió 2
UPDATE punts
   SET valor = 7
 WHERE id = 110; -- Connexió 2


UPDATE punts
   SET valor = 7
 WHERE id = 111; -- Connexió 2


SAVEPOINT a; -- Connexió 2
UPDATE punts
   SET valor = 8
 WHERE id = 110; -- Connexió 2
ROLLBACK TO a; -- Connexió 2
COMMIT; -- Connexió 2

-- Realiza operaciones y un savepoint y cierra con commit.

COMMIT; -- Connexió 1

-- Vuelve a hacer otro commit.

SELECT valor 
  FROM punts 
 WHERE id = 111; -- Connexió 0

-- Muestra valores

```

## Solución

- Des de la 'Connexió 0' fem 'INSERT' dos cops sobre la taula 'punts' per inserir nous valors.

- Des de la 'Connexió 1' començem la transacció ('BEGIN;').

- Des de la mateixa connexió fem 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 6 quan es compleixi la condició.

- Des de la 'Connexió 2' començem la transacció ('BEGIN;').

- Des de la mateixa connexió fem 'UPDATE' sobre la taula 'punts' i canviem el  valor del camp 'valor' a 7 quan es compleixi la condició.

- Des de la mateixa connexió fem 'UPDATE' i tornem a modificar la taula 'punts' i canviem el valor del camp 'valor' a 7 quan es compleixi la condició.

- Des de la mateixa connexió creem un 'checkpoint' ('SAVEPOINT a;') però igualment, la transacció continua bloquejada per la anterior acció.

- Des de la mateixa connexió fem 'UPDATE'  sobre la taula 'punts' i canviem el valor del camp 'valor' a 8 quan es compleixi la condició.

- Des de la mateixa connexió fem 'ROLLBACK TO a;' i l'UPDATE fet anteriorment, no s'efectuarà.

- Des de la mateixa connexió fem 'COMMIT'.

- Des de la 'Connexió 1' fem 'COMMIT'.

- Des de la 'Connexió 0' fem un 'SELECT' de la taula 'punts' quan és compleixi la condició i ens retorna 7 .

## Exercici 12

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en
compte que cada sentència s'executa en una connexió determinada.

```sql
INSERT INTO punts (id, valor)
VALUES (120,5); -- Connexió 0
INSERT INTO punts (id, valor) 
VALUES (121,5); -- Connexió 0

-- INSERT

BEGIN; -- Connexió 1
UPDATE punts
   SET valor = 6
 WHERE id = 121; -- Connexió 1
SAVEPOINT a;
UPDATE punts
   SET valor = 9
 WHERE id = 120; -- Connexió 1

-- AUTOCOMIT

BEGIN; -- Connexió 2
UPDATE punts 
   SET valor = 7
 WHERE id = 120; -- Connexió 2

ROLLBACK TO a; -- Connexió 1

-- VUELVE A SAVEPOINT A

-- SE GENERA OTRO SAVEPOINT A

SAVEPOINT a; -- Connexió 2
UPDATE punts
   SET valor = 8
 WHERE id = 120; -- Connexió 2
ROLLBACK TO a; -- Connexió 2
COMMIT; -- Connexió 2

-- SE GUARDA HASTA AQUÍ

COMMIT; -- Connexió 1

-- SE REALIZA UN COMIT

SELECT valor
  FROM punts
 WHERE id = 121; -- Connexió 0

-- MUESTRA 8

```

## Solución

- Des de la 'Connexió 0' fem 'INSERT' dos cops sobre la taula 'punts' per inserir nous valors.

- Des de la 'Connexió 1' començem una transacció ('BEGIN;').

- Des de la mateixa connexió fem 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 6 quan es compleixi la condició.

- Des de la mateixa connexió creem un 'checkpoint' ('SAVEPOINT a;).

- Des de la mateixa connexió fem 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 9 quan es compleixi la condició.

- Des de la 'Connexió 2' començem una transacció ('BEGIN;').

- Des de la mateixa connexió fem 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 7 quan es compleixi la condició.

- Des de la 'Connexió 1' fem 'ROLLBACK TO a' --> el que hem fet després del 'SAVEPOINT a' no es desarà.

- Des de la 'Connexió 2' creem un 'checkpoint' --> 'SAVEPOINT a'.

- Des de la mateixa connexió fem 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 8 quan es compleixi la condició.

- Des de la mateixa connexió fem un 'ROLLBACK TO a' fins al 'SAVEPOINT a;'.

- Des de la mateixa connexió fem un 'COMMIT;'.

- Des de la 'Connexió 1' fem un 'COMMIT;'.

- Per últim, des de la 'Connexió 0' fem un 'SELECT' de la taula 'punts' quan és compleixi la condició i ens retorna 6.
