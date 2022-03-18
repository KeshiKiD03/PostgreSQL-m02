# Concurrència i bloquejos

Quan diversos usuaris/processos ataquen una base de dades podem tenir problemes amb la consistència de les dades. És per això que cada gestor de bases de dades intenta solucionar aquest problema de diverses maneres. Anem a veure com funciona PostgreSQL amb un exemple. (Basat en [Exploring Query Locks in Postgres](http://big-elephants.com/2013-09/exploring-query-locks-in-postgres/))

### Creant el parc de sorra

![Sandbox](ht_BuildaSandbox_hero_image.jpg)

Creem la base de dades _sandbox_, la taula _toys_ i afegim  un _cotxet_, una _excavadora_ i una _pala_.

```SQL
CREATE DATABASE sandbox;

\c sandbox

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
\set PROMPT1 '[Alice] %/%R%# '
```

Bob:
```SQL
psql sandbox
\set PROMPT1 '[Bob] %/%R%# '
```

Si fem `man psql` i busquem la cadena PROMPT veurem els diferents valors _%/_ o
_%R_ ...


### Alice i Bob miren les joguines (AccessShareLock)


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

Cap problema, cadascú usa la joguina que vol. S'estan bloquejant files
diferents. En quant es fan els dos COMMIT a la base de dades queden modificades
les dues files.

### Alice i Bob volen jugar amb el cotxe (RowExclusiveLock)

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
```

Ara el terminal es queda "penjat" ja que Alice té bloquejada la fila (és a dir,
de moment no li deixa el cotxe).

Alice decideix no jugar amb el cotxe i fa un ROLLBACK:

```SQL
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
```

### Alice vol jugar amb totes les joguines alhora (AccessExclusiveLock)

Alice vol jugar amb tot, fem un bloqueig explícit amb l'ordre LOCK:



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
```

Li diem a Alice que això de tenir-ho tot sense jugar-hi no està bé. La convencem i fa un COMMIT:

```SQL
[Alice] sandbox=> COMMIT;
COMMIT
```

Ara Bob ja pot jugar amb l'excavadora!

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

Similar al que ha fet abans, les mira i les bloqueja...

Fem servir l'ordre _SELECT ... FROM table FOR UPDATE_ que bloqueja les files
retornades pel SELECT fins que termini l'actual transacció.


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
```

Bob no deixa l'excavadora, però intenta jugar amb el cotxe, però Alice el té bloquejat i es queda esperant... Però no pot Alice no el pot desbloquejar perquè ella està esperant el desbloqueig de Bob!!!

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

