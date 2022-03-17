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

