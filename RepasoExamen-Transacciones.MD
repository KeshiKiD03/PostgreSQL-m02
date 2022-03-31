BEGIN o START TRANSACTION;

SENTENCIA;

SAVEPOINT X;

SENTENCIA;

SAVEPOINT Y;

SENTENCIA;

SAVEPOINT Z;

ROLLBACK TO [];

COMMIT;

------------------

BEGIN TRANSACTION;

BEGIN WORK;

# ROLLBACK AUTOMÁTICO

* Si hay algún error durante la transacción, hace un ROLLBACK AUNQUE PONGAMOS COMMIT.


# SAVEPOINT - ROLLBACK TO

*     SAVEPOINT: Estableix una marca en la seqüència d'instruccions de la transacció.

*    ROLLBACK TO: Desfa els canvis fins a un SAVEPOINT definit anteriorment.


--------------------

# ACID Atomicidad, Consistencia, Isolada, Durabilidad

--------------------

# CONCURRENCIA Y BLOQUEOS