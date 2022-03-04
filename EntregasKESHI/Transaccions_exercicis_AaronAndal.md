# Exercicis de transaccions


## Exercici 1

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```
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

* Realiza el primer **SELECT** pero no se guarda la información y porque hace un ROLLBACK.

* Muestra el último select **SELECT**



## Exercici 2

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```
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

## Exercici 3

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```
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

## Exercici 4

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```
DELETE FROM punts;
INSERT INTO punts (id, valor)
VALUES (40,5);
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

## Exercici 5

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```
INSERT INTO punts (id, valor)
VALUES (50,5);
BEGIN;
SELECT id, valor
 WHERE punts;
UPDATE punts
   SET valor = 4
 WHERE id = 50;
COMMIT;
SELECT valor
  FROM punts
 WHERE id = 50;
```

## Exercici 6

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT.

```
DELETE FROM punts;
INSERT INTO punts (id, valor)
VALUES (60,5);
BEGIN;
UPDATE punts
   SET valor = 4
 WHERE id = 60;
SAVEPOINT a;
INSERT INTO punts (id, valor)
VALUES (61,8);
SAVEPOINT b;
INSERT punts (id, valor)
VALUES (62,9);
ROLLBACK TO b;
COMMIT;
SELECT SUM(valor)
  FROM punts;
```


## Exercici 7

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en
compte que cada sentència s'executa en una connexió determinada.

```
DELETE FROM punts; -- Connexió 0
INSERT INTO punts (id, valor)
VALUES (70,5); -- Connexió 0

BEGIN; -- Connexió 1
DELETE FROM punts; -- Connexió 1

SELECT COUNT(*) 
  FROM punts; -- Connexió 2
```

## Exercici 8

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en
compte que cada sentència s'executa en una connexió determinada.

```
INSERT INTO punts (id, valor)
VALUES (80,5); -- Connexió 0
INSERT INTO punts (id, valor)
VALUES (81,9); -- Connexió 0

BEGIN; -- Connexió 1
UPDATE punts 
   SET valor = 4
 WHERE id = 80; -- Connexió 1

BEGIN; -- Connexió 2
UPDATE punts 
   SET valor = 8
 WHERE id = 81; -- Connexió 2

UPDATE punts
   SET valor = 10
 WHERE id = 81; -- Connexió 1

UPDATE punts
   SET valor = 6
 WHERE id = 80; -- Connexió 2
COMMIT; -- Connexió 2

COMMIT; -- Connexió 1

SELECT valor
  FROM punts
 WHERE id = 80; -- Connexió 0
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

BEGIN; -- Connexió 2
INSERT INTO punts (id, valor)
VALUES (91,9); -- Connexió 2
COMMIT; -- Connexió 2

COMMIT; -- Connexió 1

SELECT valor
  FROM punts
 WHERE id = 91; -- Connexió 0
```

## Exercici 10

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en
compte que cada sentència s'executa en una connexió determinada.

```
INSERT INTO punts (id, valor)
VALUES (100,5); -- Connexió 0

BEGIN; -- Connexió 1
UPDATE punts
   SET valor = 6
 WHERE id = 100; -- Connexió 1

BEGIN; -- Connexió 2
UPDATE punts
   SET valor = 7
 WHERE id = 100; -- Connexió 2
COMMIT; -- Connexió 2

COMMIT; -- Connexió 1

SELECT valor FROM punts
 WHERE id = 100; -- Connexió 0
```

## Exercici 11

Analitzant les següents sentències explica quins canvis es realitzen i on es realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en compte que cada sentència s'executa en una connexió determinada.

```
INSERT INTO punts (id, valor)
VALUES (110,5); -- Connexió 0
INSERT INTO punts (id, valor)
VALUES (111,5); -- Connexió 0

BEGIN; -- Connexió 1
UPDATE punts
   SET valor = 6
 WHERE id = 110; -- Connexió 1

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

COMMIT; -- Connexió 1

SELECT valor 
  FROM punts 
 WHERE id = 111; -- Connexió 0
```

## Exercici 12

Analitzant les següents sentències explica quins canvis es realitzen i on es
realitzen. Finalment digues quin valor s'obtindrà amb l'últim SELECT. Tenint en
compte que cada sentència s'executa en una connexió determinada.

```
INSERT INTO punts (id, valor)
VALUES (120,5); -- Connexió 0
INSERT INTO punts (id, valor) 
VALUES (121,5); -- Connexió 0

BEGIN; -- Connexió 1
UPDATE punts
   SET valor = 6
 WHERE id = 121; -- Connexió 1
SAVEPOINT a;
UPDATE punts
   SET valor = 9
 WHERE id = 120; -- Connexió 1

BEGIN; -- Connexió 2
UPDATE punts 
   SET valor = 7
 WHERE id = 120; -- Connexió 2

ROLLBACK TO a; -- Connexió 1

SAVEPOINT a; -- Connexió 2
UPDATE punts
   SET valor = 8
 WHERE id = 120; -- Connexió 2
ROLLBACK TO a; -- Connexió 2
COMMIT; -- Connexió 2

COMMIT; -- Connexió 1

SELECT valor
  FROM punts
 WHERE id = 121; -- Connexió 0
```

