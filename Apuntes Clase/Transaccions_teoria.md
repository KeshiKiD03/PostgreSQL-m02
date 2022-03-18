# Transaccions

Una *transacció* és l'agrupament d'un conjunt d'instruccions en una única operació. O es fa tot o no es fa res. Els passos intermitjos d'una transacció no són visibles fora de la transacció i si alguna cosa falla durant la transacció no es fa cap instrucció d'aquesta.

## BEGIN - COMMIT

* **BEGIN:** Inici de la transacció
* **COMMIT:** Es fan efectives les instruccions de la transacció

**Exemple:**

```SQL
BEGIN;

UPDATE clients
   SET rep_clie = 106
 WHERE rep_clie = 105;

UPDATE oficines
   SET director = 106
 WHERE director = 105;

DELETE FROM rep_vendes
 WHERE num_empl = 105;

COMMIT;
```

Si obriu un altre sessió de PostgreSQL i mireu la base de dades abans de fer el COMMIT, veureu que no s'ha produït cap canvi. Si mireu després del COMMIT, sí que s'han fet els canvis.

## BEGIN - ROLLBACK

* **ROLLBACK:** No s'executen els canvis de la transacció.

**Exemple:**

```SQL
BEGIN;

UPDATE clients
   SET rep_clie = 106
 WHERE rep_clie = 105;

UPDATE oficines
   SET director = 106
 WHERE director = 105;

DELETE FROM rep_vendes
 WHERE num_empl = 105;

ROLLBACK;
```

Si mirem la base de dades després del ROLLBACK, veureu que no s'ha produït cap canvi.

### ROLLBACK "automàtic" ###

Si hi ha algun error durant la transacció, es fa un ROLLBACK, tot i que posem COMMIT.

**Exemple:**

```SQL
BEGIN;

UPDATE clients
   SET rep_clie = 106
 WHERE rep_clie = 105;

UPDATE comandes;

UPDATE oficines
   SET director = 106
 WHERE director = 105;

DELETE FROM rep_vendes
 WHERE num_empl = 105;

COMMIT;

ROLLBACK -- <= Tot i executar COMMIT s'acaba fent un ROLLBACK
```

## SAVEPOINT - ROLLBACK TO

* **SAVEPOINT:** Estableix una marca en la seqüència d'instruccions de la transacció.
* **ROLLBACK TO:** Desfa els canvis fins a un SAVEPOINT definit anteriorment.

**Exemple:**

```SQL
BEGIN;

UPDATE clients
   SET rep_clie = 106
 WHERE rep_clie = 105;

SAVEPOINT ofi_comandes;

DELETE FROM oficines
 WHERE director = 106;

UPDATE comandes
   SET rep = 106
 WHERE rep = 105;

ROLLBACK TO ofi_comandes;

UPDATE oficines
   SET director = 106
 WHERE director = 105;

DELETE FROM rep_vendes
 WHERE num_empl = 105;

COMMIT;
```

