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

- Primer fem 'INSERT' a la taula 'punts' i introduïm dos valors nous.
- A continuació començem la transacció ('BEGIN;').
- Fem un 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 4 quan es compleixi la condició.
- Tot el que és fa abans del 'ROLLBACK;' (dins del 'BEGIN;') no és desarà, tornarà enrere i ens treurà de la transacció.
- Quan fem el 'SELECT' (fora de la transacció), no ens sotirà cap valor ja que no s'ha efectuat l'update que volíem fer.

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

- Primer fem 'INSERT' a la taula 'punts' i introduïm dos valors nous.
- A continuació començem la transacció ('BEGIN;').
- Fem un 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 4 quan es compleixi la condició.
- Tot el que és fa abans del 'COMMIT;' (dins del 'BEGIN;') quedarà desat i ens treurà de la transacció.
- Quan fem el 'SELECT' (fora de la transacció), ens sotirà el valor pel que filtrem ja que s'ha efectuat l'update que volíem fer.

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

- Primer fem 'INSERT' a la taula 'punts' i introduïm dos valors nous.
- A continuació començem la transacció ('BEGIN;').
- Fem un 'SELECT' sobre la taula 'punts' seleccionant dos valors en concret però en comptes de posar 'FROM <taula>', posem 'WHERE <taula>' (la sentència està mal estructurada).
- Fem un 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 4 quan es compleixi la condició.
- Fem 'COMMIT;' però ens farà automàticament 'ROLLBACK', no desarà els canvis, tot el que hem fet no es guardarà.
- Quan fem el 'SELECT' (fora de la transacció), no ens sotiràn cap valor ja que no s'han efectuat els canvis ('UPDATE').

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

```
DELETE FROM punts; -- Connexió 0
INSERT INTO punts (id, valor)
VALUES (70,5); -- Connexió 0

BEGIN; -- Connexió 1
DELETE FROM punts; -- Connexió 1

SELECT COUNT(*)
  FROM punts; -- Connexió 2
```

- Des de la 'Connexió 0' fem 'DELETE' a la taula 'punts' i eliminem per complert tots els valors d'aquesta.
- Des de la mateixa connexió, fem 'INSERT' a la taula 'punts' i introduïm dos valors nous.
- Des de la 'Connexió 1' començem la transacció ('BEGIN;').
- Des de la mateixa connexió, fem 'DELETE' a la taula 'punts' i eliminem per complert tots els valors d'aquesta.
- Des de la 'Connexió 2'fa un 'COUNT(*)' li surt un valor ja que des de la 'Connexió 1' no s'ha desat cap canvi.

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

- Des de la 'Connexió 0' fem 'INSERT' dos cops sobre la taula 'punts' per inserir nous valors.
- Des de la 'Connexió 1' començem la transacció ('BEGIN;').
- Des de la mateixa connexió fem 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 6 quan es compleixi la condició.
- Des de la 'Connexió 2' començem la transacció ('BEGIN;').
- Des de la mateixa connexió fem 'UPDATE' sobre la taula 'punts' i canviem el valor del camp 'valor' a 7 quan es compleixi la condició.
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

