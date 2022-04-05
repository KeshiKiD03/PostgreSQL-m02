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

**Solució:**

+ Afegeix la tupla (10, 5).

+ La modificació no es fa perquè hi ha un `ROLLBACK`.


```
 valor 
-------
     5
(1 row)
```

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
**Solució:**

+ Afegeix la tupla (20,5)

+ Modifica la tupla (20,5) -> (20,4), es fa el COMMIT


```
 valor
-------
     4
(1 row)
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

```
DELETE FROM punts; -- Connexió 0
INSERT INTO punts (id, valor)
VALUES (70,5); -- Connexió 0

BEGIN; -- Connexió 1
DELETE FROM punts; -- Connexió 1

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

