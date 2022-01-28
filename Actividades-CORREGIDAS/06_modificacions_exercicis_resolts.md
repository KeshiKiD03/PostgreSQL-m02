# Modificació

## Exercici 1:

Inserir un nou venedor amb nom "Enric Jimenez" amb identificador 1012, oficina
12, títol "Dir Ventas", data_contracte d'1 de febrer del 2012, cap 101 i vendes
0.

Hi ha algun problema? Si n'hi ha, pensa en les diferents solucions.

**Solució:**
El problema es dona si n'hi ha alguna _constraint_, per exemple que les vendes siguin 0. Podriem eliminar-la o canviar-la.

```
ALTER TABLE rep_vendes 
 DROP CONSTRAINT "ck_rep_vendes_vendes",
  ADD CONSTRAINT "ck_rep_vendes_vendes"
      CHECK (vendes >= 0::numeric);
```


```
INSERT INTO rep_vendes (num_empl, nom, oficina_rep, carrec, data_contracte, cap, vendes)
VALUES (1012, 'Enric Jimenez', 12, 'Dir Ventas', '2012-02-01', 101, 0);
```
o equivalentment:

```
INSERT INTO rep_vendes
VALUES (1012, 'Enric Jimenez', NULL, 12, 'Dir Ventas', '2012-02-01', 101, NULL, 0);
```

## Exercici 2:

Inserir un nou client "C1" i una nova comanda pel venedor anterior.

```
INSERT INTO clients
VALUES (2125, 'C1', 1012, NULL);
```
```
INSERT INTO comandes
VALUES (113070, '2015-11-16', 2125, 1012, 'rei', '2a45c', 1, 79);
```

## Exercici 3:

Inserir un nou venedor amb nom "Pere Mendoza" amb identificador 1013,
data_contracte del 15 de agost del 2011 i vendes 0. La resta de camps a null.

```
INSERT INTO rep_vendes (num_empl, nom, data_contracte, vendes)
VALUES (1013, 'Pere Mendoza', '2011-11-16', 0);
```

o equivalentment:

```
INSERT INTO rep_vendes
VALUES (1013, 'Pere Mendoza', NULL, NULL, NULL, '2011-11-16', NULL, NULL, 0);
```

## Exercici 4:

Inserir un nou client "C2" omplint els mínims camps.

```
INSERT INTO clients
VALUES (2126, 'C2', 1012, NULL);
```

## Exercici 5:

Inserir una nova comanda del client "C2" al venedor "Pere Mendoza" sense especificar la llista de camps pero si la de valors.

```
INSERT INTO comandes
VALUES (113071, '2015-11-16', 2126, 1013, 'aci', 41004, 1, 117);
```

O si no coneixem els valors:

```
INSERT INTO comandes
VALUES (113071, '2015-11-16',
       (SELECT num_clie
          FROM clients
         WHERE empresa = 'C2'),
       (SELECT num_empl
          FROM rep_vendes
         WHERE nom = 'Pere Mendoza'),
       'aci', 41004, 1, 117);
```

## Exercici 6:

Esborrar de la còpia de la base de dades el venedor afegit anteriorment anomenat "Enric Jimenez".

```
DELETE FROM rep_vendes
 WHERE nom = 'Enric Jimenez';
```

Ens mostra el següent error ja que volem eliminar un venedor amb comandes:

```
ERROR:  update or delete on table "rep_vendes" violates foreign key constraint "fk_clients_rep_clie" on table "clients"
DETAIL:  Key (num_empl)=(1012) is still referenced from table "clients".
```

## Exercici 7:

Eliminar totes les comandes del client "C1" afegit anteriorment.

```
DELETE FROM comandes
WHERE clie = 
      (SELECT num_clie
         FROM clients
        WHERE empresa = 'C1');
```

```
DELETE 1
```

## Exercici 8:

Esborrar totes les comandes d'abans del 15-11-1989.

```
DELETE FROM comandes
 WHERE data <
       '1989-11-15';
```

```
DELETE 4
```


## Exercici 9:

Esborrar tots els clients dels venedors: Adams, Jones i Roberts.

```
DELETE FROM clients
 WHERE rep_clie IN 
       (SELECT num_empl 
          FROM rep_vendes 
         WHERE nom LIKE '%Adams%'
            OR nom LIKE '%Jones%'
            OR nom LIKE '%Roberts%');
```

```
ERROR:  update or delete on table "clients" violates foreign key constraint "fk_comandes_clie" on table "comandes"
DETAIL:  Key (num_clie)=(2103) is still referenced from table "comandes".
```

## Exercici 10:

Esborrar tots els venedors contractats abans del juliol del 1988 que encara no
se'ls ha assignat una quota.

```
DELETE FROM rep_vendes 
 WHERE data_contracte <
       '1988-07-01'
   AND quota IS NULL;
```

O si ho volem fer perquè no hi hagi problemes amb el _locale_ de les dates:

```
DELETE FROM rep_vendes
 WHERE DATE_PART('year', data_contracte) = 1988 AND DATE_PART('month', data_contracte) < 7 
    OR DATE_PART('year', data_contracte) < 1988 
```

## Exercici 11:

Esborrar totes les comandes.

```
DELETE FROM comandes;
```


## Exercici 12:

Esborrar totes les comandes acceptades per la Sue Smith (cal tornar a disposar  de la taula comandes)


```
DELETE FROM comandes
 WHERE rep =
       (SELECT num_empl 
          FROM rep_vendes 
         WHERE nom = 'Sue Smith');
```
```
DELETE 2
```

## Exercici 13:

Suprimeix els clients atesos per venedors les vendes dels quals són inferiors
al 80% de la seva quota.

```
DELETE FROM clients 
 WHERE rep_clie IN 
       (SELECT num_empl
          FROM rep_vendes 
         WHERE vendes < 0.8 * quota);
```
```
ERROR:  update or delete on table "clients" violates foreign key constraint "fk_comandes_clie" on table "comandes"
DETAIL:  Key (num_clie)=(2124) is still referenced from table "comandes".
```

## Exercici 14:

Suprimir els venedors els quals el seu total de comandes actual (imports) és
menor que el 2% de la seva quota.

```
DELETE FROM rep_vendes
 WHERE 0.02 * quota >
       (SELECT SUM(import) 
          FROM comandes 
         WHERE rep = num_empl);
```

```
ERROR:  update or delete on table "rep_vendes" violates foreign key constraint "fk_clients_rep_clie" on table "clients"
DETAIL:  Key (num_empl)=(102) is still referenced from table "clients".
```

   
## Exercici 15:

Suprimeix els clients que no han realitzat comandes des del 10-11-1989.

```
DELETE FROM clients
 WHERE num_clie NOT IN 
       (SELECT clie 
          FROM comandes 
         WHERE data > '1989-11-10');
```

Amb independència del locale i estàndard ANSI:

```
DELETE FROM clients
 WHERE num_clie NOT IN
       (SELECT clie
          FROM comandes
         WHERE DATE_PART('year', data) = 1989 AND DATE_PART('month', data) = 11 AND DATE_PART('day', data) > 10 
           AND DATE_PART('year', data) = 1989 AND DATE_PART('month', data) > 11
           AND DATE_PART('year', data) > 1989);
```

## Exercici 16: 

Eleva el límit de crèdit de l'empresa Acme Manufacturing a 60000 i canvies el seu representant a Mary Jones.

```
UPDATE clients                                    
   SET limit_credit = 60000, 
       rep_clie = (SELECT num_empl 
                     FROM rep_vendes 
                    WHERE nom = 'Mary Jones')
 WHERE empresa = 'Acme Mfg.';
```


## Exercici 17:

Transferir tots els venedors de l'oficina de Chicago (12) a la de Nova York (11), i rebaixa les seves quotes un 10%.

```
UPDATE rep_vendes
   SET oficina_rep = 11,
       quota = quota - 0.1 * quota
 WHERE oficina_rep = 12;
```

```
UPDATE 4
```

## Exercici 18:

Reassigna tots els clients atesos pels empleats 105, 106, 107, a l'empleat 102.

```
UPDATE clients 
   SET rep_clie = 102
 WHERE rep_clie IN 
       (105, 106, 107);
```

```
UPDATE 5
```

## Exercici 19:

Assigna una quota de 100000 a tots aquells venedors que actualment no tenen quota.

```
UPDATE rep_vendes
   SET quota = 100000
 WHERE quota IS NULL;
```
```
UPDATE 3
```

## Exercici 20:

Eleva totes les quotes un 5%.

```
UPDATE rep_vendes
   SET quota = quota + quota * 0.05;
```

```
UPDATE 12
```

## Exercici 21:

Eleva en 5000 el límit de crèdit de qualsevol client que ha fet una comanda d'import superior a 25000.

```
UPDATE clients
   SET limit_credit = limit_credit + 5000
 WHERE num_clie IN 
       (SELECT clie 
          FROM comandes 
         WHERE import > 25000);
```
```
UPDATE 4
```

## Exercici 22:

Reassigna tots els clients atesos pels venedors les vendes dels quals són
menors al 80% de les seves quotes. Reassignar al venedor 105.

```
UPDATE clients
   SET rep_clie = 105
 WHERE rep_clie IN
       (SELECT num_empl 
          FROM rep_vendes 
         WHERE vendes < 0.8 * quota);
```
```
UPDATE 2
```

## Exercici 23:

Fer que tots els venedors que atenen a més de tres clients estiguin sota de les
ordres de Sam Clark (106).

```
UPDATE rep_vendes
   SET cap = 106
 WHERE num_empl IN
       (SELECT rep_clie  
          FROM clients
         GROUP BY rep_clie
        HAVING COUNT(*) > 3);
```

```
UPDATE 1
``` 
O una altra manera:

```
UPDATE rep_vendes
   SET cap = 106
 WHERE 3 <
       (SELECT COUNT(*) 
          FROM clients 
         WHERE rep_clie = num_empl);
```


## Exercici 24:

Augmentar un 50% el límit de credit d'aquells clients que totes les seves
comandes tenen un import major a 30000.

```
UPDATE clients
   SET limit_credit = limit_credit + 0.5 * limit_credit
 WHERE 30000 < ALL 
       (SELECT import 
          FROM comandes 
         WHERE clie = num_clie);
```

Segur que està bé?

Pensa-ho una mica i després mira la solució al final

## Exercici 25:

Disminuir un 2% el preu d'aquells productes que tenen un estoc superior a 200 i no han tingut comandes.

```
UPDATE productes
   SET preu = preu - 0.02 * preu
 WHERE estoc > 200 
   AND NOT EXISTS
       (SELECT num_comanda 
          FROM comandes 
         WHERE fabricant = id_fabricant
           AND producte = id_producte);
```
```
UPDATE 3
```

## Exercici 26:

Establir un nou objectiu per aquelles oficines en que l'objectiu actual sigui
inferior a les vendes. Aquest nou objectiu serà el doble de la suma de les
vendes dels treballadors assignats a l'oficina.


```
UPDATE oficines
   SET objectiu = 
       2 * (SELECT SUM(vendes) 
              FROM rep_vendes 
             WHERE oficina_rep = oficina)
 WHERE objectiu < vendes;
```
```
UPDATE 3
```

## Exercici 27:

Modifiqueu la quota dels caps d'oficina que tinguin una quota superior a la
quota d'algun empleat de la seva oficina. Aquests caps han de tenir la mateixa
quota que l'empleat de la seva oficina que tingui la quota més petita.



Consulta que troba els caps d'oficina amb la condició demanada:

```
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

Una altra manera de resoldre la consulta anterior.

```
SELECT director
  FROM oficines
       JOIN rep_vendes directors
       ON director = num_empl
 WHERE quota > ANY
       (SELECT quota
          FROM rep_vendes venedors
         WHERE venedors.oficina_rep = oficina);
```

```
 director 
----------
      108
(1 row)
```

Consulta que troba la quota mínima 

```
SELECT MIN(quota)
  FROM rep_vendes
WHERE oficina_rep =
     (SELECT oficina
        FROM oficines
             JOIN rep_vendes
             ON director = num_empl
       WHERE quota > ANY
             (SELECT quota 
                    FROM rep_vendes
               WHERE oficina_rep = oficina));
```

Finalment la consulta que fa els canvis:

```
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

Una altra manera:

```
START TRANSACTION;
UPDATE rep_vendes directors
   SET quota =
       (SELECT MIN(venedors.quota)
          FROM rep_vendes venedors
         WHERE venedors.oficina_rep IN 
               (SELECT oficina
                  FROM oficines
                 WHERE director = directors.num_empl))
 WHERE num_empl IN
       (SELECT director
          FROM oficines)
   AND quota > ANY
       (SELECT quota
          FROM rep_vendes empleats
         WHERE empleats.oficina_rep IN 
               (SELECT oficina
                  FROM oficines
                 WHERE director = directors.num_empl));
```


### OBSERVACIÓ:

Tinguem en compte que hi ha un treballador que és director de dues oficines, de
manera que el mínim de la quota fa referència a la quota més petita de tots els
venedors que treballen a la mateixa oficina que el director.  Si ho enfoquem
com la mínima quota de cada oficina, tindrem dos valors i el problema no serà
resoluble. 

## Exercici 28:

Cal que els 5 clients amb un total de compres (quantitat) més alt siguin transferits a l'empleat Tom Snyder i que se'ls augmenti el límit de crèdit en un 50%.

```
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

```
UPDATE 5
```

## Exercici 29:

Es volen donar de baixa els productes que no tenen estoc i alhora no
se n'ha venut cap des de l'any 89.

```
DELETE FROM productes
 WHERE estoc = 0
   AND NOT EXISTS
       (SELECT * 
          FROM comandes 
         WHERE id_fabricant = fabricant
           AND id_producte = producte 
           AND DATE_PART('year', data) >= 1990);
```

```
DELETE 1
```

## Exercici 30:

Afegir una oficina de la ciutat de "San Francisco", regió oest, el director ha
de ser "Larry Fitch", les vendes 0, l'objectiu ha de ser la mitja de l'objectiu
de les oficines de l'oest i l'identificador de l'oficina ha de ser el següent
valor després del valor més alt.

```
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
```
INSERT 0 1
```

## Extres

+ Exercici 24


En realitat la consulta hauria de ser:

```
UPDATE clients
   SET limit_credit = limit_credit + 0.5 * limit_credit
 WHERE 30000 < ALL
       (SELECT import
          FROM comandes
         WHERE clie = num_clie);
   AND EXISTS 
       (SELECT import
          FROM comandes
         WHERE clie = num_clie);
```


Sense l'EXISTS la consulta que proposàvem també augmenta el límit de crèdit dels
clients que no tenen comandes.

