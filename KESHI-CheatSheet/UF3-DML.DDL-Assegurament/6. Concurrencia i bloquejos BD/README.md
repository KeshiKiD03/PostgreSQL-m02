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

# Exercicis de transaccions

## Preparació del terreny de joc (setup)

Sembla que haurem de construir primer una taula i per tant una base de dades.
Som-hi:

```SQL
CREATE DATABASE transaccions_db;
\c transaccions_db
CREATE TABLE punts (
	id		INTEGER	NOT NULL, -- identificador de la puntuació
	valor	INTEGER	NOT NULL  --valor de la puntuació
);
```

## Exercici 1

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```SQL
-- 1
INSERT INTO punts (id, valor)
VALUES (10, 5);
-- 2 
BEGIN;
UPDATE punts
   SET valor = 4
 WHERE id = 10;
ROLLBACK;
-- 3
SELECT valor
  FROM punts
 WHERE id = 10;
```

**Solució:**

+ Afegeix la tupla (10, 5).

+ La modificació no es fa perquè hi ha un `ROLLBACK`.

KESHI: El --2 no se actualiza. Se inserta --1 y muestra --3.


```
 valor 
-------
     5
(1 row)
```

## Exercici 2

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```sql
-- 1
INSERT INTO punts (id, valor)
VALUES (20,5);
-- 2
BEGIN;
UPDATE punts
   SET valor = 4
 WHERE id = 20;
-- 3 
COMMIT;
SELECT valor
  FROM punts
 WHERE id = 20;
```
**Solució:**

+ Afegeix la tupla (20,5)

+ Modifica la tupla (20,5) -> (20,4), es fa el COMMIT

KESHI: El --1 se inserta, el --2 se modifica el valor y se guarda. Muestra el SELECT con nuevo Valor.

```
 valor
-------
     4
(1 row)
```

## Exercici 3

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```sql
-- 1 Insert OK
INSERT INTO punts (id, valor)
VALUES (30,5);
-- 2 Inicio BEGIN
BEGIN;
UPDATE punts
   SET valor = 4
 WHERE id = 30;
SAVEPOINT a;
-- 3 
INSERT INTO punts (id, valor)
VALUES (31,7);
ROLLBACK; -- Vuelve al INICIO, especificar
-- 4
SELECT valor
  FROM punts
 WHERE id = 30;
```

**Solució:**


+ S'insereix la tupla (30,5).

+ Alerta! Es perd la actualització i la inserció perquè no es fa un `ROLLBACK
TO` al punt _a_ sinó que es fa un `ROLLBACK` genèric i per tant es perd tot el
que s'ha fet entre el BEGIN i el ROLLBACK.

```
 valor 
-------
     5
(1 row)
```

## Exercici 4

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```sql
-- 1 Delete OK S'esborren tots els registres de la taula.
DELETE FROM punts;
INSERT INTO punts (id, valor)
VALUES (40,5);
-- 2 S'insereix la tupla (40, 5).
BEGIN;
UPDATE punts 
   SET valor = 4
 WHERE id = 40;
SAVEPOINT a;
-- 3
INSERT INTO punts (id, valor)
VALUES (41,7);
ROLLBACK TO a; -- S'insereix una nova tupla, però es cancel·larà aquesta acció perquè fem un `ROLLBACK TO`tornant just al punt anterior a aquesta acció.
-- 4
SELECT COUNT(*)
  FROM punts;
```

**Solució:**


+ S'esborren tots els registres de la taula.

+ S'insereix la tupla (40, 5).

+ Es modifica la tupla (40, 5) -> (40, 4)

+ S'insereix una nova tupla, però es cancel·larà aquesta acció perquè fem un
`ROLLBACK TO`tornant just al punt anterior a aquesta acció.

```
 count 
-------
     1
(1 row)
```

Fixem-nos que el prompt ens indica (amb el caràcter _*_) que encara estem a una
transacció, de manera que hauríem d'acabar-la: COMMIT.

Si fem `END` també l'acabarà com a COMMIT, però si fem ROLLBACK anularà tot el
que hi havia després del BEGIN.


## Exercici 5

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```sql
-- 1
INSERT INTO punts (id, valor)
VALUES (50,5);
-- 2 + La transacció no s'executa perquè hi ha una consulta amb un error.
BEGIN;
SELECT id, valor
 WHERE punts;
UPDATE punts
   SET valor = 4
 WHERE id = 50;
COMMIT;
-- 3
SELECT valor
  FROM punts
 WHERE id = 50;
```

**Solució:**

+ Afegeix punt (50,5)

+ La transacció no s'executa perquè hi ha una consulta amb un error.

```
valor
-----
5
```

## Exercici 6

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```sql
-- 1
DELETE FROM punts;
INSERT INTO punts (id, valor)
VALUES (60,5);
-- 2
BEGIN;
UPDATE punts
   SET valor = 4
 WHERE id = 60;
SAVEPOINT a;
-- 3
INSERT INTO punts (id, valor)
VALUES (61,8);
SAVEPOINT b;
INSERT INTO punts (id, valor)
VALUES (62,9);
ROLLBACK TO b;
COMMIT;
-- 4
SELECT SUM(valor)
  FROM punts;
```

**Solució:**

+ Afegeix la tupla (60,5)

+ Modifica la tupla ((60,5) -> (60,4)

+ Afegeix la tupla (61,8)

+ No s'afegeix la tupla (62, 9) perquè es fa un ROLLBACK fins el SAVEPOINT b

```
 sum 
-----
  12
(1 row)
```

## Exercici 7

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en
compte que cada sentència s'executa en una connexió determinada.

```sql
DELETE FROM punts; -- Connexió 0
INSERT INTO punts (id, valor)
VALUES (70,5); -- Connexió 0
BEGIN; -- Connexió 1
DELETE FROM punts; -- Connexió 1
-- Se queda pillado aquí
SELECT COUNT(*) 
  FROM punts; -- Connexió 2
```

C0: 
+ Esborra totes les tuples de la taula punts.
+ Afegeix la tupla (70,5).

C1:
+ Esborra totes les tuples de la taula punts.

C2:
+ Com que a la connexió C1 encara no s'ha finalitzat la transacció:

```
 count 
-------
     1
(1 row)
```

## Exercici 8

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en
compte que cada sentència s'executa en una connexió determinada.

```sql
-- Se realizan los INSERTS
INSERT INTO punts (id, valor)
VALUES (80,5); -- Connexió 0
INSERT INTO punts (id, valor)
VALUES (81,9); -- Connexió 0
-- Con1 inicia la transacción
BEGIN; -- Connexió 1
UPDATE punts 
   SET valor = 4
 WHERE id = 80; -- Connexió 1
-- Se modifica OK --> ID: 80 - Valor: 4.
BEGIN; -- Connexió 2
UPDATE punts 
   SET valor = 8
 WHERE id = 81; -- Connexió 2
-- Se modifica OK --> ID: 81 - Valor: 8.
-- id: 80 - valor: 5 y id: 81 - valor: 8
UPDATE punts
   SET valor = 10
 WHERE id = 81; -- Connexió 1
-- Se queda pillado aquí
UPDATE punts
   SET valor = 6
 WHERE id = 80; -- Connexió 2
COMMIT; -- Connexió 2
-- Se genera un DEADLOCK y desbloquea la Con 1 que estaba pillada.
COMMIT; -- Connexió 1
SELECT valor
  FROM punts
 WHERE id = 80; -- Connexió 0
 valor 
-------
     4
(1 row)
```

```
      ┌────────────────────┬────────────────┬───────────────┬──────────────────────────────────────────────────────────────────┐
      │     Conn 0         │       Conn 1   │     Conn 2    │   Comentaris                                                     │
      ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │Afegeix punt (80,5) │                │               │                                                                  │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │Afegeix punt (81,9) │                │               │                                                                  │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │Begin Trans.    │               │                                                                  │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │Update(80,4)    │               │                                                                  │
TEMPS ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │                │Begin Trans.   │                                                                  │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │                │Update(81,8)   │                                                                  │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │Update(81,10)   │               │Es queda esperant a que la Conn 2 acabi, amb rollback o commit    │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │                │Update(80,6)   │S'hauria d'esperar a que Conn 1 acabi però Conn 1 ja està esperant│
  │   │                    │                │               │ a Conn 2 ->  DEADLOCK!                                           │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │                │Commit         │No es fa el commit sinó rollback ja que hi ha hagut errors        │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  ▼   │                    │Commit          │               │Es fan els canvis d'aquesta transacció                            │
      ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
      │SELECT -> 4         │                │               │                                                                  │
      └────────────────────┴────────────────┴───────────────┴──────────────────────────────────────────────────────────────────┘
```


## Exercici 9

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en
compte que cada sentència s'executa en una connexió determinada.

```SQL
INSERT INTO punts (id, valor)
VALUES (90,5); -- Connexió 0
BEGIN; -- Connexió 1
DELETE FROM punts; -- Connexió 1
-- Borra valor del primer INSERT OK
-- Pero Con0 sigue viendo su valor.
BEGIN; -- Connexió 2
INSERT INTO punts (id, valor)
VALUES (91,9); -- Connexió 2
-- Con2 ve los datos de Con0 y su INSERT pero el DELETE de Con1 no sale todavía porque no ha hecho Commit o Rollback.
COMMIT; -- Connexió 2
-- Ok commit
COMMIT; -- Connexió 1
-- Su delete se hace efectivo
SELECT valor
  FROM punts
 WHERE id = 91; -- Connexió 0
  valor 
-------
     9
```

```
      ┌────────────────────┬────────────────┬───────────────┬──────────────────────────────────────────────────────────────────┐
      │       Conn 0       │    Conn 1      │    Conn 2     │                        Comentaris                                │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │Afegeix punt (90,5) │                │               │                                                                  │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │Begin Trans.    │               │                                                                  │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │Delete          │               │A la transacció, s'esborra el que veu de la taula: el punt (90,5) │
TEMPS ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │                │Begin Trans.   │                                                                  │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │                │Insert(91,9)   │S'afegeix aquest punt. Aquesta transacc. ara veu 2 punts          │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │                │Commit         │Ara mateix es veuen els punts (90,5) i (91,9)                     │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │Commit          │               │Es fa efectiva la transacció, esborrant el punt (90,5)            │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  ▼   │ SELECT -> 9        │                │               │                                                                  │
      └────────────────────┴────────────────┴───────────────┴──────────────────────────────────────────────────────────────────┘
```

## Exercici 10

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en
compte que cada sentència s'executa en una connexió determinada.

```sql
INSERT INTO punts (id, valor)
VALUES (100,5); -- Connexió 0
-- Insert OK
BEGIN; -- Connexió 1
UPDATE punts
   SET valor = 6
 WHERE id = 100; -- Connexió 1
-- Inicia transacción, realiza el UPDATE OK
BEGIN; -- Connexió 2
UPDATE punts
   SET valor = 7
 WHERE id = 100; -- Connexió 2
-- Se queda pillado aquí esperando que hace Conexión 1.
COMMIT; -- Connexió 2
-- Inicia transacción, pero se espera porque la Trasacción lo tiene Con1, realizará Update pero ve sólo el primer INSERT.
-- sE GUARDA SU VALOR PRIMERO antes que Conexión1.
COMMIT; -- Connexió 1
-- Se guarda ahora y machaca el Update de Conexión2 y añade su valor.
SELECT valor FROM punts
 WHERE id = 100; -- Connexió 0
-- Muestra id:100 - valor=7
```

```
      ┌────────────────────┬────────────────┬───────────────┬──────────────────────────────────────────────────────────────────┐
      │       Conn 0       │    Conn 1      │    Conn 2     │                        Comentaris                                │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │Afegeix punt (100,5)│                │               │                                                                  │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │Begin Trans.    │               │                                                                  │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │Update (100,6)  │               │                                                                  │
TEMPS ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │                │Begin Trans.   │                                                                  │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │                │Update(100,7)  │Es queda esperant a veure què fa la Conn 1                        │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │                │Commit         │No s'executa fins que acaba la transacció de Conn 1               │
  │   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
  │   │                    │Commit          │               │Modifica el punt (100,6) , però en fer el commit es desbloqueja   │
  │   │                    │                │               │la Conn 2 i per tant es fa la modificació (100,7)                 │
  ▼   ├────────────────────┼────────────────┼───────────────┼──────────────────────────────────────────────────────────────────┤
      │ SELECT -> 7        │                │               │                                                                  │
      └────────────────────┴────────────────┴───────────────┴──────────────────────────────────────────────────────────────────┘
```



## Exercici 11

Analitzant les següents sentències explica quins canvis es realitzen i on es realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en compte que cada sentència s'executa en una connexió determinada.

```sql
-- Se realizan OK los inserts
INSERT INTO punts (id, valor)
VALUES (110,5); -- Connexió 0
INSERT INTO punts (id, valor)
VALUES (111,5); -- Connexió 0
-- Se inicia el la Transacción OK
BEGIN; -- Connexió 1
UPDATE punts
   SET valor = 6
 WHERE id = 110; -- Connexió 1
-- Se realiza el UPDATE OK
-- Se realiza la Transacción OK
BEGIN; -- Connexió 2
UPDATE punts
   SET valor = 7
 WHERE id = 110; -- Connexió 2
-- Se quedará pillado AQUÍ - BEGIN - Pero podemos seguir poniendo DML.
UPDATE punts
   SET valor = 7
 WHERE id = 111; -- Connexió 2
SAVEPOINT a; -- Connexió 2
-- Se quedará pillado esperando PERO PODEMOS SEGUIR PONIENDO
UPDATE punts
   SET valor = 8
 WHERE id = 110; -- Connexió 2
ROLLBACK TO a; -- Connexió 2
COMMIT; -- Connexió 2
-- Todavía en el pillado, esperando a CONNEXIÓN 1.
COMMIT; -- Connexió 1
-- Se libera CONEXIÓN 2.
SELECT valor 
  FROM punts 
 WHERE id = 111; -- Connexió 0
 
 -- Resultado
 
  valor 
-------
     7
(1 row)
 
```

```
      ┌────────────────────┬────────────────┬───────────────┬─────────────────────────────────────────────────────────────┐
      │     Conn 0         │       Conn 1   │     Conn 2    │   Comentaris                                                │
      ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │Afegeix punt (110,5)│                │               │                                                             │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │Afegeix punt (111,5)│                │               │                                                             │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │Begin Trans.    │               │                                                             │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │Update(110,6)   │               │                                                             │
TEMPS ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │                │Begin Trans.   │                                                             │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │                │Update(110,7)  │Es queda bloquejat fins que Conn 1 acabi                     │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │                │Update(111,7)  │"                                                            │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │                │Savepoint a    │                                                             │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │                │Update(110,8)  │                                                             │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │                │Rollback to a  │Es desfa la modificació (110,8)                              │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │                │Commit         │Encara espera                                                │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │Commit          │               │Es fa el commit es modifica (110,6) i després (110,7),(111,7)│
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  ▼   │SELECT -> 7         │                │               │                                                             │
      └────────────────────┴────────────────┴───────────────┴─────────────────────────────────────────────────────────────┘
```



## Exercici 12

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en
compte que cada sentència s'executa en una connexió determinada.

```sql
-- Insert 
INSERT INTO punts (id, valor)
VALUES (120,5); -- Connexió 0
INSERT INTO punts (id, valor) 
VALUES (121,5); -- Connexió 0
 -- Abre Transacción - Realiza el update OK de 121 a 6 - Crea Savepoint A - Realiza otro update a otro campo de 120. Pêndiente de COMMIT o ROLLBACK;
BEGIN; -- Connexió 1
UPDATE punts
   SET valor = 6
 WHERE id = 121; -- Connexió 1
SAVEPOINT a;
UPDATE punts
   SET valor = 9
 WHERE id = 120; -- Connexió 1
 
 -- Inicia Transacción - Realiza el UPDATE pero se queda esperando ya que hay un bloqueo de ROW por parte de Conexión 1
 
BEGIN; -- Connexió 2
UPDATE punts 
   SET valor = 7
 WHERE id = 120; -- Connexió 2
-- Se queda colgado aquí, esperando a que Conexión 1 libere id = 120
ROLLBACK TO a; -- Connexió 1
-- Libera la espera de CONEXIÓN 2 ya que ha hecho un ROLLBACK a un savepoint a;
SAVEPOINT a; -- Connexió 2
-- Este sigue en la conexión
UPDATE punts
   SET valor = 8
 WHERE id = 120; -- Connexió 2
 
 -- Update OK ya que no hay nadie bloqueandola.
 
ROLLBACK TO a; -- Connexió 2
-- Se omite el UPDATE anterior ya que hicimos un ROLLBACK TO a;
COMMIT; -- Connexió 2
COMMIT; -- Connexió 1
SELECT valor
  FROM punts
 WHERE id = 121; -- Connexió 0
 
 -- Solución:
 
  valor 
-------
     6
(1 row)
 
```

```
      ┌────────────────────┬────────────────┬───────────────┬─────────────────────────────────────────────────────────────┐
      │     Conn 0         │       Conn 1   │     Conn 2    │   Comentaris                                                │
      ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │Afegeix punt (120,5)│                │               │                                                             │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │Afegeix punt (121,5)│                │               │                                                             │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │Begin Trans.    │               │                                                             │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │Update(121,6)   │               │                                                             │
TEMPS ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │Savepoint a     │               │                                                             │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │Update(120,9)   │               │                                                             │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │                │2egin Trans.   │                                                             │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │                │Update(120,7)  │Es queda bloquejat fins que Conn 1 acabi                     │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │Rollback to a   │               │Es desbloqueja el punt 120 de la Conn 2-> (120,7)            │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │                │Savepoint a    │                                                             │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │                │Update(120,8)  │                                                             │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │                │Rollback to a  │                                                             │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │                │Commit         │Es fa ja (120,7)                                             │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │                    │Commit          │               │Es fa (121,6)                                                │
  │   ├────────────────────┼────────────────┼───────────────┼─────────────────────────────────────────────────────────────┤
  │   │SELECT -> 6         │                │               │                                                             │
  ▼   └────────────────────┴────────────────┴───────────────┴─────────────────────────────────────────────────────────────┘
```

El punt 120 queda (120,7)





