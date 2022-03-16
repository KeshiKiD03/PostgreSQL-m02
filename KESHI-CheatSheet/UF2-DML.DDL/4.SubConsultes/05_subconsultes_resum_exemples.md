# RESUM SUBCONSULTES

## Subconsultes monoregistre

Retornen un únic valor (una única fila i columna)

Operadors: =, >, >=, <, <=, <>

> Llista els venedors tals que la seva oficina sigui Chicago

Amb JOIN:
```
SELECT nom
FROM rep_vendes
JOIN oficines
ON oficina_rep = oficina
WHERE ciutat = 'Chicago';
```

Amb subconsulta:
```
SELECT nom
FROM rep_vendes
WHERE oficina_rep = 
   (SELECT oficina
	  FROM oficines 
	 WHERE ciutat = 'Chicago');
```
						   
> Llista tots els venedors tals que les seves vendes siguin superiors a les
vendes de Sam Clark

```
SELECT nom
FROM rep_vendes
WHERE vendes >
       (SELECT vendes
	      FROM rep_vendes
         WHERE nom = 'Sam Clark');
```                        

> Llista els clients que les seves compres hagin superat el seu límit de crèdit.

```
SELECT empresa
  FROM clients
 WHERE limit_credit <
       (SELECT SUM(import)
          FROM comandes
         WHERE clie = num_clie);
```

## Subconsultes multiregistre

Retornen més d'un registre

Operadors: IN, op + ANY, op + ALL, EXISTS

### IN

_Alguna fila de la subconsulta coincideix amb el camp avaluat._
    
> Mostra els clients, el representant de vendes dels quals ha fet una comanda
superior a 10000.

```
SELECT empresa
  FROM clients
 WHERE rep_clie IN 
       (SELECT rep
          FROM comandes
         WHERE import > 10000);
```    
    
### op ANY

_Alguna fila de la subconsulta compleix la condició._
    
> Mostra els clients que el seu límit de crèdit és superior al 30% de la quota
d'algun representant de vendes.

```
SELECT empresa
  FROM clients
 WHERE limit_credit > ANY
       (SELECT 0.3 * quota
	     FROM rep_vendes);
```

### op ALL

_Totes les files de la subconsulta compleixen la condició._
    
> Mostra els clients el límit de crèdit dels quals és superior al 10% de les vendes
de tots els representant de vendes.

```
SELECT empresa
  FROM clients
 WHERE limit_credit > ALL
       (SELECT 0.1 * vendes
          FROM rep_vendes);
```

### EXISTS

_La subconsulta retorna algun resultat._
    
> Clients que han fet una comanda l'any 89.

```
SELECT empresa
  FROM clients
 WHERE EXISTS 
       (SELECT *
	      FROM comandes
         WHERE num_clie = clie
           AND DATE_PART( 'year', data) = 1989);
```

> Clients que no han fet cap comanda l'any 89.

```
SELECT empresa
  FROM clients
 WHERE NOT EXISTS
       (SELECT *
          FROM comandes
         WHERE num_clie = clie
           AND DATE_PART( 'year', data) = 1989);
```
