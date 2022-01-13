# Aaron Andal isx36579183

# Borrar CK_REP_VENDES_VENDES

# Modificació

## Exercici 1:

Inseriu un nou venedor amb nom "Enric Jimenez" amb identificador 1012, oficina 18, títol "Dir Vendes", contracte d'1 de febrer del 2012, cap 101 i vendes 0.

INSERT INTO REP_VENDES


## Exercici 2:

Inseriu un nou client "C1" i una nova comanda pel venedor anterior.

INSERT INTO



## Exercici 3:

Inseriu un nou venedor amb nom "Pere Mendoza" amb identificador 1013, contracte del 15 de agost del 2011 i vendes 0. La resta de camps a null.

INSERT INTO

## Exercici 4:

Inseriu un nou client "C2" omplint els mínims camps.

INSERT INTO

## Exercici 5:

Inseriu una nova comanda del client "C2" al venedor "Pere Mendoza" sense especificar la llista de camps pero si la de valors.


## Exercici 6:

Esborreu de la còpia de la base de dades el venedor afegit anteriorment anomenat "Enric Jimenez".

   
## Exercici 7:

Elimineu totes les comandes del client "C1" afegit anteriorment.


## Exercici 8:

Esborreu totes les comandes d'abans del 15-11-1989.


## Exercici 9:

Esborreu tots els clients dels venedors: Adams, Jones i Roberts.


## Exercici 10:

Esborreu tots els venedors contractats abans del juliol del 1988 que encara no se'ls ha assignat una quota.

## Exercici 11:

Esborreu totes les comandes.


## Exercici 12:

Esborreu totes les comandes acceptades per la Sue Smith (cal tornar a disposar de la taula comandes)


## Exercici 13:

Suprimeix els clients atesos per venedors les vendes dels quals són inferiors al 80% de la seva quota.


## Exercici 14:

Suprimiu els venedors els quals el seu total de comandes actual (imports) és menor que el 2% de la seva quota.

## Exercici 15:

Suprimiu els clients que no han realitzat comandes des del 10-11-1989.

## Exercici 16:

Eleva el límit de crèdit de l'empresa Acme Manufacturing a 60000 i la reassignes a Mary Jones.

## Exercici 17:

Transferiu tots els venedors de l'oficina de Chicago (12) a la de Nova York (11), i rebaixa les seves quotes un 10%.

## Exercici 18:

Reassigna tots els clients atesos pels empleats 105, 106, 107, a l'empleat 102.

## Exercici 19:

Assigna una quota de 100000 a tots aquells venedors que actualment no tenen quota.

## Exercici 20:

Eleva totes les quotes un 5%.

## Exercici 21:

Eleva en 5000 el límit de crèdit de qualsevol client que ha fet una comanda d'import superior a 25000.

## Exercici 22:

Reassigna tots els clients atesos pels venedors les vendes dels quals són menors al 80% de les seves quotes. Reassignar al venedor 105.

## Exercici 23:

Feu que tots els venedors que atenen a més de tres clients estiguin sota de les ordres de Sam Clark (106).

## Exercici 24:

Augmenteu un 50% el límit de credit d'aquells clients que totes les seves comandes tenen un import major a 30000.

## Exercici 25:

Disminuiu un 2% el preu d'aquells productes que tenen un estoc superior a 200 i no han tingut comandes.

## Exercici 26:

Establiu un nou objectiu per aquelles oficines en que l'objectiu actual sigui inferior a les vendes. Aquest nou objectiu serà el doble de la suma de les vendes dels treballadors assignats a l'oficina.

## Exercici 27:

Modifiqueu la quota dels caps d'oficina que tinguin una quota superior a la quota d'algun empleat de la seva oficina. Aquests caps han de tenir la mateixa quota que l'empleat de la seva oficina que tingui una quota menor.

## Exercici 28:

Cal que els 5 clients amb un total de compres (quantitat) més alt siguin transferits a l'empleat Tom Snyder i que se'ls augmenti el límit de crèdit en un 50%.

## Exercici 29:

Es volen donar de baixa els productes dels que no tenen estoc i alhora no se n'ha venut cap des de l'any 89.

## Exercici 30:

Afegiu una oficina de la ciutat de "San Francisco", regió oest, el cap ha de ser "Larry Fitch", les vendes 0, l'objectiu ha de ser la mitja de l'objectiu de les oficines de l'oest i l'identificador de l'oficina ha de ser el següent valor després del valor més alt.


## BACKUP i RESTORE de la Base de DADES training:

Una manera de fer un backup ràpid des del bash és:

```
pg_dump -Fc training > training.dump
```
Podem eliminar també la base de dades:

```
dropdb training
```
Podem restaurar una base de dades amb:
```
pg_restore -C -d postgres training.dump
```

Una altra manera de fer el mateix:

Backup en fitxer pla
```
pg_dump -f training.dump   training
```

Eliminem la base de dades:

```
dropdb training
```

Creem la base de dades:
```
createdb training
```
Reconstruim l'estructura i dades:
```
psql training < training.dump
```
 




