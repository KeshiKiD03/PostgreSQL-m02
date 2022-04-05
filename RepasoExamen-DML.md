
# DML

## REPASO

```SQL
-- PRIMER EJEMPLO

BEGIN;

CREATE TABLE keshiserial (idserial serial, nom varchar(20), data date DEFAULT current_date, limit_credit numeric(8,2));

SAVEPOINT insert1;

-- Insert explícito

INSERT INTO keshiserial VALUES (0,'Keshi', DEFAULT, 45678);

SAVEPOINT insert2;

-- Insert implícito

INSERT INTO keshiserial (nom, data, limit_credit) VALUES ('John', DEFAULT, 45674);

SAVEPOINT insert3;

ROLLBACK;

------ EJEMPLO OTRO

BEGIN;

CREATE TABLE keshiserial (idserial serial, nom varchar(20), data date DEFAULT current_date, limit_credit numeric(8,2));

SAVEPOINT insert1;

insert into keshiserial (nom, data, limit_credit) values ('John', DEFAULT, 45678);

SAVEPOINT insert2;

INSERT INTO keshiserial (nom, data, limit_credit) VALUES ('John', DEFAULT, 45674);

SAVEPOINT insert3;
```

```SQL
-- INSERT CON NULL

INSERT INTO keshiserial (nom, data, limit_credit) VALUES ('Nom', NULL, 43986);

```

keshi=> SELECT * FROM keshiserial;
 idserial | nom  |    data    | limit_credit 
----------+------+------------+--------------
        1 | John | 2022-04-03 |     45678.00
        2 | John | 2022-04-03 |     45674.00
        3 | Nom  |            |     43986.00
(3 rows)

```
BEGIN;

CREATE TABLE keshiserial (idserial serial, nom varchar(20), data timestamp DEFAULT current_timestamp, limit_credit numeric(8,2));

INSERT INTO keshiserial (nom, data, limit_credit) VALUES ('Keshi', DEFAULT, 56897);

INSERT INTO keshiserial (nom, data, limit_credit) VALUES ('John', NULL, 56897);

SAVEPOINT insertd1;

```

keshi=> SELECT * FROM keshiserial;
 idserial |  nom  |            data            | limit_credit 
----------+-------+----------------------------+--------------
        1 | Keshi | 2022-04-03 11:43:38.094037 |     56897.00
        2 | John  |                            |     56897.00
(2 rows)

* Insert a partir de SUBCONSULTAS

```
INSERT INTO directors(id, nom, carrec)
SELECT num_empl, nom, carrec
FROM rep_vendes
WHERE carrec = 'Dir Vendes';
```


# INSERT

```sql
INSERT INTO tabla [(campo1 [, camp2 ...])]
VALUES (lista de valores separados por coma);
```


* Explícito, omitiendo campos

```sql
INSERT INTO oficines
VALUES (66, 'Barcelona', 'Sud', NULL, 111, 0);
```

* Implícito, con campos

```sql
INSERT INTO oficines (oficina, ciutat, regio, director, vendes)
VALUES (66, 'Barcelona', 'Sud', 111, 0);
```

# CURRENT_DATE registra la fecha y hora actual.


```sql
INSERT INTO rep_vendes
VALUES (666, 'M. Rajoy', 68, 22, 'Representant Vendes', CURRENT_DATE, 104, 300000, 88888 );
```

# TO_DATE(text, format) convierte una cadena en una fecha en segundos, según el formato que se le pase.


```sql
INSERT INTO rep_vendes
VALUES ( 666, 'M. Rajoy', 68, 22, 'Representant Vendes',
	TO_DATE('1988-10-14', 'YYYY-MM-DD'), 104,
	300000, 88888 );
```

# Inserción con SUBCONSULTAS


```sql
INSERT INTO directors(id, nom, carrec)
SELECT num_empl, nom, carrec
FROM rep_vendes
WHERE carrec = 'Dir Vendes';
```

* 

    Ha de coincidir el número de columnas de la clausula INSERT con la de la subconsulta.

    No se usa la clausula VALUES.

## REPASO UPDATE


UPDATE *nombreTabla*
SET *columnaACambiar*
[WHERE];

Se ha de modificar la categoria y la oficina del emplado 666, con los valores actuales que son 110.

* Subconsultas

UPDATE rep_vendes
	SET (carrec, oficina_rep) =
	(SELECT carrec, oficina_rep
		FROM rep_vendes
		WHERE num_empl = 110)
WHERE num_empl = 666;


# UPDATE

* 

    Modifica filas existentes.

    Puede afectar a más de una fila al mismo tiempo.

    Se usa la clausula WHERE, para especificar.


```sql
UPDATE taula
SET camp1 = valor1 [, camp2 = valor2]
[WHERE condicio/ns];
```




```sql
UPDATE rep_vendes
SET oficina_rep = 21
WHERE num_empl = 666;
```


# UPDATE CON SUBCONSULTAS

* Se ha de modificar la categoria y la oficina del emplado 666, con los valores actuales que son 110.

```sql
UPDATE rep_vendes
	SET (carrec, oficina_rep) =
	(SELECT carrec, oficina_rep
		FROM rep_vendes
		WHERE num_empl = 110)
WHERE num_empl = 666;
```


# DELETE

* 

    Elimina filas existentes.

    Puede afectar a más de una fila al mismo tiempo.

    Se usa la clausula WHERE, para especificar.


```sql
DELETE FROM taula
[WHERE condición/es];
```




```sql
DELETE FROM comandes
WHERE num_comanda = 8888;
```

# DELETE CON SUBCONSULTAS


* Se ha de modificar la categoria y la oficina del emplado 666, con los valores actuales que son 110.

```sql
DELETE FROM rep_vendes
	WHERE oficina_rep = ANY
		(SELECT oficina
		FROM oficines
		WHERE regio ='Est');
```

* 

    «Elimina els venedors que siguin d’una oficina de la regió Est.»

    En una subconsulta puede retornar más de una fila. Hemos de especificar el operador multiregistro ANY.


> Cuidado con los errores de INTEGRIDAD


```sql
DELETE FROM rep_vendes
	WHERE oficina_rep = ANY
		(SELECT oficina
		FROM oficines
		WHERE regio ='Est');


ERROR: update or delete on table "rep_vendes"
violates foreign key constraint "fk_clients_rep_clie"
on table "clients"
DETAIL: Key (num_empl)=(105) is still referenced
from table "clients"
```

* 

    Al intentar eliminar un vendedor de la tabla rep_vendes --> ERROR DE INTEGRIDAD REFERENCIAL.

    Básicamente incumple la constraint de FK a la tabla Clients. Para ello se debe eliminar primero el registro en CLIENTES y luego en REP_VENDES.



# EJERCICIOS DML

* Inseriu un nou venedor amb nom "Enric Jimenez" amb identificador 1012, oficina 18, títol "Dir Vendes", contracte d'1 de febrer del 2012, cap 101 i vendes 0.

```sql
INSERT INTO rep_vendes (num_empl, 
			nom, 
			oficina_rep, 
			carrec, 
			data_contracte, 
			cap, 
			vendes
			) 
			
			VALUES (
				1012, 
				'Enric Jimenez',
				13,
				'Dir Vendes',
				'2012-02-01',
				101,
				0
				);
```



* Inseriu un nou client "C1" i una nova comanda pel venedor anterior.

```sql
INSERT INTO clients (num_clie, empresa, rep_clie, limit_credit) VALUES (1245,'C1',103,50000);
```

* Inseriu un nou client "C2" omplint els mínims camps.


```sql
INSERT INTO clients (num_clie, empresa, rep_clie, limit_credit) VALUES (1234, 'C2', (SELECT num_empl FROM rep_vendes WHERE nom = 'Pere Mendoza'), 0);
```


* Solución

```sql
INSERT INTO clients
VALUES (2126, 'C2', 1012, NULL);
```

* Inseriu una nova comanda del client "C2" al venedor "Pere Mendoza" sense especificar la llista de camps pero si la de valors.


```sql
INSERT INTO comandes VALUES (113333, 
                            '1990-01-22', 
                            (SELECT num_clie 
                                FROM clients 
                                WHERE empresa = 'C2'), 
                            (SELECT num_empl 
                                FROM rep_vendes 
                                WHERE nom = 'Pere Mendoza'), 
                            'rei', 
                            '2a45c', 
                            2, 
                            158
);
```


* Suprimiu els venedors els quals el seu total de comandes actual (imports) és menor que el 2% de la seva quota.

1. Primero hacer el SELECT y luego el DELETE

```sql

SELECT * FROM rep_vendes 
	WHERE (SELECT SUM(import) FROM comandes WHERE rep = num_empl) 
		< (quota*0.2);

```



* Transferiu tots els venedors de l'oficina de Chicago (12) a la de Nova York (11), i rebaixa les seves quotes un 10%.


```sql
UPDATE rep_vendes SET oficina_rep = 11, quota = (quota-(quota*0.1)) WHERE oficina_rep = 12;
```

```sql
UPDATE rep_vendes
   SET oficina_rep = 11,
       quota = quota - 0.1 * quota
 WHERE oficina_rep = 12;
```

UPDATE 3


* Reassigna tots els clients atesos pels empleats 105, 106, 107, a l'empleat 102.

1. SELECT PARA FILTRAR

```sql
SELECT * FROM CLIENTS WHERE rep_clie IN (105, 106, 107); 
```

2. UPDATE

```sql
UPDATE CLIENTS SET rep_clie = 102 WHERE rep_clie IN (105, 106, 107);
```


* Solución

```sql
UPDATE clients 
   SET rep_clie = 102
 WHERE rep_clie IN 
       (105, 106, 107);
```




* Eleva en 5000 el límit de crèdit de qualsevol client que ha fet una comanda d'import superior a 25000.

```sql
UPDATE clients

        SET limit_credit = limit_credit + 5000
        
WHERE num_clie = ANY
        (
                SELECT clie
                FROM comandes
                WHERE import > 25000
        
        );
```

```SQL
UPDATE clients

        SET limit_credit = limit_credit + 5000
        
WHERE num_clie IN
        (
                SELECT clie
                FROM comandes
                WHERE import > 25000
        
        );
```


* Solución

```sql
UPDATE clients
   SET limit_credit = limit_credit + 5000
 WHERE num_clie IN 
       (SELECT clie 
          FROM comandes 
         WHERE import > 25000);
```



* Reassigna tots els clients atesos pels venedors, les vendes dels quals són menors al 80% de les seves quotes. Reassignar al venedor 105.


```sql
UPDATE clients SET rep_clie = 105
WHERE rep_clie IN (
	SELECT num_empl 
	FROM rep_vendes 
	WHERE vendes < (quota*0.8));
```


* Solución

```sql
UPDATE clients
   SET rep_clie = 105
 WHERE rep_clie IN
       (SELECT num_empl 
          FROM rep_vendes 
         WHERE vendes < 0.8 * quota);
```



* Feu que tots els venedors que atenen a més de tres clients estiguin sota de les ordres de Sam Clark (106).

1. SELECT

```sql
training=> SELECT rep_clie, COUNT(rep_clie) FROM clients GROUP BY rep_clie HAVING COUNT(rep_clie) > 3; 
 rep_clie | count 
----------+-------
      102 |     4
(1 row)

```

2. UPDATE

```sql
UPDATE rep_vendes SET num_empl = 106 WHERE num_empl = (SELECT rep_clie FROM clients GROUP BY rep_clie HAVING COUNT(rep_clie) > 3);
```

* SOLUCIÓ

```sql
UPDATE rep_vendes
   SET cap = 106
 WHERE num_empl IN
       (SELECT rep_clie  
          FROM clients
         GROUP BY rep_clie
        HAVING COUNT(*) > 3);
```



* Disminuiu un 2% el preu d'aquells productes que tenen un estoc superior a 200 i no han tingut comandes.

```sql
UPDATE productes
   SET preu = preu - 0.02 * preu
 WHERE estoc > 200 
   AND NOT EXISTS
       (SELECT num_comanda 
          FROM comandes 
         WHERE fabricant = id_fabricant
           AND producte = id_producte);
```


* Establiu un `nou objectiu` per aquelles oficines en que `l'objectiu actual` sigui `inferior` a les `vendes`. 

* Aquest `nou objectiu` serà el `doble` de la `suma` de les `vendes` dels `treballadors` assignats a l'oficina.

```sql
UPDATE oficines
   SET objectiu = 
       2 * (SELECT SUM(vendes) 
              FROM rep_vendes 
             WHERE oficina_rep = oficina)
 WHERE objectiu < vendes;
```


* Modifiqueu la `quota` dels `caps d'oficina` que tinguin una `quota superior` a la `quota` d'algun `empleat` de la `seva oficina`. 

* Aquests `caps` han de tenir `la mateixa quota` que `l'empleat` de la `seva oficina` que tingui `la quota més petita`.


```sql
SELECT *
  FROM rep_vendes d
 WHERE num_empl IN 
       (SELECT director
          FROM oficines)
   AND quota > ANY
             (SELECT quota
                FROM rep_vendes e
               WHERE e.oficina_rep IN
                     (SELECT oficina
                        FROM oficines
                       WHERE director = d.num_empl));
```


* V2

```sql
SELECT director
  FROM oficines
       JOIN rep_vendes directors
       ON director = num_empl
 WHERE quota > ANY
       (SELECT quota
          FROM rep_vendes venedors
         WHERE venedors.oficina_rep = oficina);
```




```sql
START TRANSACTION;
UPDATE rep_vendes
   SET quota =
       (SELECT MIN(quota)
          FROM rep_vendes
         WHERE oficina_rep =
               (SELECT oficina
                  FROM oficines
                       JOIN rep_vendes
                       ON director = num_empl
                 WHERE quota > ANY
                       (SELECT quota
                          FROM rep_vendes
                         WHERE oficina_rep = oficina)))
 WHERE num_empl IN
      (SELECT director           
         FROM oficines
              JOIN rep_vendes directors
              ON director = num_empl
        WHERE quota > ANY
              (SELECT quota
                 FROM rep_vendes 
                WHERE oficina_rep = oficina));

```

* Tinguem en compte que hi ha un treballador que és director de dues oficines.

    De manera que el mínim de la quota fa referència a la quota més petita de tots els venedors que treballen a la mateixa oficina que el director.

    Si ho enfoquem com la mínima quota de cada oficina, tindrem dos valors i el problema no serà resoluble.



* Cal que els 5 clients amb un total de compres (quantitat) més alt siguin transferits a l'empleat Tom Snyder i que se'ls augmenti el límit de crèdit en un 50%.

```sql
UPDATE clients
   SET rep_clie = 
       (SELECT num_empl 
          FROM rep_vendes 
         WHERE nom = 'Tom Snyder'), 
       limit_credit = limit_credit + 0.5 * limit_credit
WHERE num_clie IN
      (SELECT clie 
         FROM comandes 
        GROUP BY clie 
        ORDER BY SUM(quantitat) DESC
        FETCH  FIRST 5 ROWS ONLY);
```

* Es volen donar de baixa els productes dels que no tenen estoc i alhora no se n'ha venut cap des de l'any 89.

```sql
DELETE FROM productes
 WHERE estoc = 0
   AND NOT EXISTS
       (SELECT * 
          FROM comandes 
         WHERE id_fabricant = fabricant
           AND id_producte = producte 
           AND DATE_PART('year', data) >= 1990);
```

SELECT FROM productes
 WHERE estoc = 0
   AND NOT EXISTS
       (SELECT * 
          FROM comandes 
         WHERE id_fabricant = fabricant
           AND id_producte = producte 
           AND DATE_PART('year', data) >= 1990);

* Afegiu una oficina de la ciutat de "San Francisco", regió oest, el cap ha de ser "Larry Fitch", les vendes 0, l'objectiu ha de ser la mitja de l'objectiu de les oficines de l'oest i l'identificador de l'oficina ha de ser el següent valor després del valor més alt.


```sql
INSERT INTO oficines
VALUES ((SELECT MAX(oficina) + 1 
            FROM oficines), 
       'San Francisco', 'Oest',
       (SELECT num_empl
          FROM rep_vendes
         WHERE nom = 'Larry Fitch'),
       (SELECT AVG(objectiu)
          FROM oficines
         WHERE regio = 'Oest'),
       0);

```




```sql

```





```sql

```




```sql

```







```sql

```




```sql

```




```sql

```




```sql

```




```sql

```




```sql

```




```sql

```




```sql

```




```sql

```





```sql

```




```sql

```







```sql

```




```sql

```




```sql

```




```sql

```




```sql

```




```sql

```




```sql

```




```sql

```




```sql

```





```sql

```




```sql

```






```sql

```




```sql

```




```sql

```




```sql

```




```sql

```




```sql

```




```sql

```




```sql

```




```sql

```





```sql

```




```sql

```


