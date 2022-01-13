-------------------------------------------------------------------------------
--          Modificació
-------------------------------------------------------------------------------
-- 6.1-  Inserir un nou venedor amb nom "Enric Jimenez" amb identificador 1012, oficina 18, títol "Dir Ventas", contracte d'1 de febrer del 2012, director 101
-- i vendes 0.
INSERT INTO copia_repventas(nombre,num_empl,oficina_rep,titulo,contrato,director,ventas)
VALUES ('Enric Jimenez',1012,18,'Dir Ventas','2012-02-01',101,0);

SELECT * FROM copia_repventas
WHERE nombre = 'Enric Jimenez';
 num_empl |    nombre     | edad | oficina_rep |   titulo   |  contrato  | director | cuota | ventas 
----------+---------------+------+-------------+------------+------------+----------+-------+--------
     1012 | Enric Jimenez |      |          18 | Dir Ventas | 2012-02-01 |      101 |       |   0.00
(1 row)

-- 6.2- Inserir un nou client "C1" i una nova comanda pel venedor anterior.
INSERT INTO copia_clientes(num_clie,empresa,rep_clie,limite_credito)
VALUES (1245,'C1',1012,0);

SELECT * FROM copia_clientes
WHERE empresa = 'C1';
 num_clie | empresa | rep_clie | limite_credito 
----------+---------+----------+----------------
     1245 | C1      |     1012 |           0.00   
(1 row)

INSERT INTO copia_pedidos(rep)
VALUES ((SELECT num_empl FROM copia_repventas WHERE nombre = 'Enric Jimenez'));

SELECT * FROM copia_pedidos WHERE rep = (SELECT num_empl FROM copia_repventas WHERE nombre = 'Enric Jimenez');
 num_pedido | fecha_pedido | clie | rep  | fab | producto | cant | importe 
------------+--------------+------+------+-----+----------+------+---------
            |              | 1245 | 1012 |     |          |      |        
(1 row)

-- 6.3- Inserir un nou venedor amb nom "Pere Mendoza" amb identificador 1013, contracte del 15 de agost del 2011 i vendes 0. La resta de camps a null.
INSERT INTO copia_repventas(nombre,num_empl,contrato,ventas,edad,oficina_rep,titulo,director,cuota)
VALUES ('Pere Mendoza',1013,'2011-08-15',0,NULL,NULL,NULL,NULL,NULL);

SELECT * FROM copia_repventas
WHERE nombre = 'Pere Mendoza';
 num_empl |    nombre    | edad | oficina_rep | titulo |  contrato  | director | cuota | ventas 
----------+--------------+------+-------------+--------+------------+----------+-------+--------
     1013 | Pere Mendoza |      |             |        | 2011-08-15 |          |       |   0.00
(1 row)

-- 6.4- Inserir un nou client "C2" omplint els mínims camps.
INSERT INTO copia_clientes(num_clie,empresa,rep_clie,limite_credito)
VALUES (1234,'C2',(SELECT num_empl FROM copia_repventas WHERE nombre = 'Pere Mendoza'),0);

SELECT * FROM copia_clientes
WHERE empresa = 'C2';
 num_clie | empresa | rep_clie | limite_credito 
----------+---------+----------+----------------
     1234 | C2      |     1013 |           0.00
(1 row)

-- 6.5- Inserir una nova comanda del client "C2" al venedor "Pere Mendoza" sense especificar la llista de camps pero si la de valors.
INSERT INTO copia_pedidos
VALUES(NULL,NULL,(SELECT num_clie FROM copia_clientes WHERE empresa = 'C2'),(SELECT num_empl FROM copia_repventas WHERE nombre = 'Pere Mendoza'),NULL,NULL,NULL,NULL);

SELECT * FROM copia_pedidos
WHERE clie = (SELECT num_clie FROM copia_clientes WHERE empresa = 'C2');
 num_pedido | fecha_pedido | clie | rep  | fab | producto | cant | importe 
------------+--------------+------+------+-----+----------+------+---------
            |              | 1234 | 1013 |     |          |      |        
(1 row)

-- 6.6- Esborrar de la còpia de la base de dades el venedor afegit anteriorment anomenat "Enric Jimenez".
DELETE FROM copia_repventas
WHERE nombre = 'Enric Jimenez';

SELECT * FROM copia_repventas
WHERE nombre = 'Enric Jimenez';
 num_empl | nombre | edad | oficina_rep | titulo | contrato | director | cuota | ventas 
----------+--------+------+-------------+--------+----------+----------+-------+--------
(0 rows)

-- 6.7- Eliminar totes les comandes del client "C1" afegit anteriorment.
DELETE FROM copia_pedidos
WHERE clie = 1245;

DELETE FROM copia_pedidos
WHERE clie = (SELECT num_clie FROM copia_clientes where empresa = 'C1');

SELECT * FROM copia_pedidos
WHERE clie = (SELECT num_clie FROM copia_clientes where empresa = 'C1');
 num_pedido | fecha_pedido | clie | rep | fab | producto | cant | importe 
------------+--------------+------+-----+-----+----------+------+---------
(0 rows)

-- 6.8- Esborrar totes les comandes d'abans del 15-11-1989.
SELECT * FROM copia_pedidos
WHERE fecha_pedido < '1989-11-15';
 num_pedido | fecha_pedido | clie | rep | fab | producto | cant | importe  
------------+--------------+------+-----+-----+----------+------+----------
     112968 | 1989-10-12   | 2102 | 101 | aci | 41004    |   34 |  3978.00
     112979 | 1989-10-12   | 2114 | 102 | aci | 4100z    |    6 | 15000.00
     112992 | 1989-11-04   | 2118 | 108 | aci | 41002    |   10 |   760.00
     112993 | 1989-01-04   | 2106 | 102 | rei | 2a45c    |   24 |  1896.00
(4 rows)

DELETE FROM copia_pedidos
WHERE fecha_pedido < '1989-11-15';

SELECT * FROM copia_pedidos
WHERE fecha_pedido < '1989-11-15';
 num_pedido | fecha_pedido | clie | rep | fab | producto | cant | importe 
------------+--------------+------+-----+-----+----------+------+---------
(0 rows)

-- 6.9- Esborrar tots els clients dels venedors: Adams, Jones i Roberts.
SELECT * FROM copia_clientes
WHERE rep_clie IN (SELECT num_empl FROM copia_repventas WHERE nombre LIKE '%Adams%' OR nombre LIKE '%Jones' OR nombre LIKE '%Roberts%');
 num_clie |     empresa     | rep_clie | limite_credito 
----------+-----------------+----------+----------------
     2102 | First Corp.     |      101 |       65000.00
     2103 | Acme Mfg.       |      105 |       50000.00
     2115 | Smithson Corp.  |      101 |       20000.00
     2108 | Holm & Landis   |      109 |       55000.00
     2122 | Three-Way Lines |      105 |       30000.00
     2119 | Solomon Inc.    |      109 |       25000.00
     2105 | AAA Investments |      101 |       45000.00
(7 rows)

DELETE FROM copia_clientes
WHERE rep_clie IN (SELECT num_empl FROM copia_repventas WHERE nombre LIKE '%Adams%' OR nombre LIKE '%Jones' OR nombre LIKE '%Roberts%');

SELECT * FROM copia_clientes
WHERE rep_clie IN (SELECT num_empl FROM copia_repventas WHERE nombre LIKE '%Adams%' OR nombre LIKE '%Jones' OR nombre LIKE '%Roberts%');
 num_clie | empresa | rep_clie | limite_credito 
----------+---------+----------+----------------
(0 rows)

-- 6.10- Esborrar tots els venedors contractats abans del juliol del 1988 que encara no se'ls ha assignat una quota.
SELECT * FROM copia_repventas
WHERE contrato < '1988-07-01' AND cuota IS NULL;

DELETE FROM copia_repventas
WHERE contrato < '1988-07-01' AND cuota IS NULL;

SELECT * FROM copia_repventas
WHERE contrato < '1988-07-01' AND cuota IS NULL;
 num_empl | nombre | edad | oficina_rep | titulo | contrato | director | cuota | ventas 
----------+--------+------+-------------+--------+----------+----------+-------+--------
(0 rows)

-- 6.11- Esborrar totes les comandes.
DELETE FROM copia_pedidos;

SELECT * FROM copia_pedidos;
 num_pedido | fecha_pedido | clie | rep | fab | producto | cant | importe 
------------+--------------+------+-----+-----+----------+------+---------
(0 rows)

-- 6.12- Esborrar totes les comandes acceptades per la Sue Smith (cal tornar a disposar  de la taula pedidos)
INSERT INTO copia_pedidos (SELECT * FROM pedidos);

SELECT * FROM copia_pedidos
WHERE rep = (SELECT num_empl FROM copia_repventas WHERE nombre = 'Sue Smith');

DELETE FROM copia_pedidos
WHERE rep = (SELECT num_empl
             FROM copia_repventas
             WHERE nombre = 'Sue Smith');

-- 6.13- Suprimeix els clients atesos per venedors les vendes dels quals són inferiors al 80% de la seva quota.
DELETE FROM copia_clientes
WHERE rep_clie IN ( SELECT num_empl from copia_repventas
                    WHERE ventas < 0.8 * cuota);

-- 6.14- Suprimir els venedors els quals el seu total de comandes actual (imports) és menor que el 2% de la seva quota.
DELETE FROM copia_repventas
WHERE (SELECT sum(IMPORT) FROM copia_pedidos
       WHERE rep = num_empl) < 0.02 * cuota;

-- 6.15- Suprimeix els clients que no han realitzat comandes des del 10-11-1989.
DELETE FROM copia_clientes
WHERE num_clie = NOT IN (SELECT clie from copia_pedidos
                         GROUP BY clie
                         HAVING max(fecha_pedido) <= '1989-11-10');


-- 6.16 Eleva el límit de crèdit de l'empresa Acme Manufacturing a 60000 i la reassignes a Mary Jones.
 

-- 6.17- Transferir tots els venedors de l'oficina de Chicago (12) a la de Nova York (11), i rebaixa les seves quotes un 10%.


-- 6.18- Reassigna tots els clients atesos pels empleats 105, 106, 107, a l'emleat 102.



-- 6.19- Assigna una quota de 100000 a tots aquells venedors que actualment no tenen quota.


-- 6.20- Eleva totes les quotes un 5%.


-- 6.21- Eleva en 5000 el límit de crèdit de qualsevol client que ha fet una comanda d'import superior a 25000.

   
-- 6.22- Reassigna tots els clients atesos pels venedors les vendes dels quals són menors al 80% de les seves quotes. Reassignar al venedor 105.

   
-- 6.23- Fer que tots els venedors que atenen a més de tres clients estiguin sota de les ordres de Sam Clark (106).


-- 6.24- Augmentar un 50% el límit de credit d'aquells clients que totes les seves comandes tenen un import major a 30000.


-- ALERTA sense l'EXISTS augmenta el limit de credit dels clients que no tenen comandes.

-- 6.25- Disminuir un 2% el preu d'aquells productes que tenen un estoc superior a 200 i no han tingut comandes.


-- 6.26- Establir un nou objectiu per aquelles oficines en que l'objectiu actual sigui inferior a les vendes. Aquest nou objectiu serà el doble de la suma de les vendes dels treballadors assignats a l'oficina.



-- 6.27- Modificar la quota dels directors d'oficina que tinguin una quota superior a la quota d'algun empleat de la seva oficina. Aquests directors han de tenir la mateixa quota que l'empleat de la seva oficina que tingui una quota menor.



-- 6.28- Cal que els 5 clients amb un total de compres (cantidad) més alt siguin transferits a l'empleat Tom Snyder i que se'ls augmenti el límit de crèdit en un 50%.



-- 6.29- Es volen donar de baixa els productes dels que no tenen existències i alhora no se n'ha venut cap des de l'any 89.



-- 6.30- Afegir una oficina de la ciutat de "San Francisco", regió oest, el director ha de ser "Larry Fitch", les vendes 0, l'objectiu ha de ser la mitja de l'objectiu de les oficines de l'oest i l'identificador de l'oficina ha de ser el següent valor després del valor més alt.


