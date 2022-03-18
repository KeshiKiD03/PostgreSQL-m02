# Exercicis Vistes

## Exercici 1

Defineix una vista anomenada "oficines_est" que contingui únicament les dades de
les oficines de la regió est.

```
CREATE VIEW oficines_est
    AS SELECT *
         FROM oficines
        WHERE regio='Est';
```

## Exercici 2

Crear una vista de nom "rep_oest" que mostri les dades dels venedors de la
regió oest.

```
CREATE VIEW rep_oest
    AS SELECT * 
         FROM rep_vendes 
        WHERE oficina_rep IN
              (SELECT oficina 
                 FROM oficines 
                WHERE regio = 'Oest');
```

La següent vista també seria correcta però seria una vista _read-only_:

```
CREATE VIEW rep_oest
    AS SELECT rep_vendes.*
         FROM rep_vendes
              JOIN oficines
                ON oficina_rep = oficina
        WHERE regio = 'Oest';
```

Perquè seria una vista només _read-only_? Abans de mirar la solució al final dels exercicis, pensa-ho una mica.


## Exercici 3

Crea una vista temporal de nom "comandes_sue" que contingui únicament les
comandes fetes per clients assignats la representant de vendes Sue.

 
PostgreSQL (i altres SGBDR) permet crear vistes temporals, però aquesta
característica no pertany ni tan sols a les _features_ opcionals de SQL
estàndard (a diferència de les taules temporals).

```
CREATE TEMP VIEW comandes_sue
    AS SELECT * 
         FROM comandes
        WHERE clie IN 
              (SELECT num_clie 
                 FROM clients 
                WHERE rep_clie IN
                      (SELECT num_empl 
                         FROM rep_vendes 
                        WHERE nom LIKE 'Sue%'));
```


## Exercici 4

Crea una vista de nom "clients_vip" que mostri únicament aquells clients amb
una suma dels imports de les seves comandes superior a 30000.

```
CREATE VIEW clients_vip
    AS SELECT *
         FROM clients 
        WHERE num_clie IN
              (SELECT clie 
                 FROM comandes 
                GROUP BY clie 
               HAVING SUM(import) > 30000);
```
```
CREATE VIEW clients_vip
    AS SELECT * 
         FROM clients 
        WHERE 30000 <
             (SELECT SUM(import) 
                FROM comandes 
               WHERE clie = num_clie);
```

## Exercici 5

Crea una vista de nom "info_rep" amb les següents dades dels venedors:
num_empl, nom, oficina_rep.

```
CREATE VIEW info_rep
    AS SELECT num_empl, nom, oficina_rep
         FROM rep_vendes;
```

## Exercici 6

Crear una vista de nom "info_oficina" que mostri les oficines amb
l'identificador de l'oficina, la ciutat i la regió.

```
CREATE VIEW info_oficina
    AS SELECT oficina, ciutat, regio
         FROM oficines;
```

## Exercici 7

Crea una vista de nom "info_clie" que contingui el nom de l'empresa dels
clients i l'identificador del venedor que tenen assignat.

```
CREATE VIEW info_clie
    AS SELECT empresa, rep_clie
         FROM clients;
```

## Exercici 8

Crea una vista de nom "clie_bill" que contingui el número de client, el nom de
empresa i el límit de crèdit de tots els clients assignats al representant de
vendes "Bill Adams".
   
```
CREATE VIEW clie_bill
    AS SELECT num_clie, empresa, limit_credit
         FROM clients 
        WHERE rep_clie IN
              (SELECT num_empl 
                 FROM rep_vendes 
                WHERE nom = 'Bill Adams');
```

## Exercici 9

Crea una vista de nom comanda_per_rep que contingui les següents dades de les
comandes de cada venedor: id_representant_vendes, quantitat_comandes,
import_total, import_minim, import_maxim, import_promig.
   
```
CREATE VIEW ped_por_rep
    AS SELECT rep AS id_representant_vendes, 
              COUNT(*) AS quantitat_comandes, 
              SUM(import) AS import_total, 
              MIN(import) AS import_minim, 
              MAX(import) AS import_maxim, 
              ROUND(AVG(import), 2) AS import_promig
         FROM comandes
        WHERE rep IS NOT NULL 
        GROUP BY rep;
```



## Exercici 10

De la vista anterior volem una nova vista per mostrar el nom del representant
de vendes, números de comandes, import total de les comandes i el promig de les
comandes per a cada venedor. S'han d'ordenar per tal que primer es mostrin els
que tenen major import total.
   
```
CREATE VIEW top_rep
    AS SELECT nom, quantitat_comandes, import_total, import_promig
         FROM ped_por_rep
              JOIN rep_vendes
              ON id_representant_vendes = num_empl
        ORDER BY import_maxim DESC;
```

## Exercici 11

Crea una vista de nom "info_comanda" amb les dades de les comandes però amb els
noms del client i venedor en lloc dels seus identificadors.

```
CREATE VIEW info_comanda
    AS SELECT num_comanda, data, empresa, nom,
              fabricant, producte, quantitat, import
         FROM comandes
              JOIN clients
              ON clie = num_clie
    
              JOIN rep_vendes
              ON rep = num_empl;
```

## Exercici 12

Crear una vista anomenada "clie_rep" que mostri l'import total de les comandes
que ha fet cada client a cada representant de vendes. Cal mostrar el nom de
l'empresa i el nom del representant de vendes.

```
CREATE VIEW clie_rep
    AS SELECT empresa, nom, SUM(import) 
         FROM info_comanda 
        GROUP BY empresa, nom;
```


## Exercici 13

Crear una vista temporal per substituir la taula "comandes" que mostri les
comandes amb import més gran a 20000 i ordenades per import de forma
descendent.
  
```
CREATE TEMP VIEW comandes
    AS SELECT * 
         FROM comandes
        WHERE import > 20000 
        ORDER BY import DESC;
```

## Exercici 14

Crea una vista anomenada "top_clie" que mostri el nom de l'empresa client i el
total dels imports de les comandes del client. S'han d'ordenar per tal que
primer es mostrin els que tenen major import total.

```
CREATE VIEW top_clie
    AS SELECT empresa, SUM(import) 
         FROM info_comanda 
        GROUP BY empresa 
        ORDER BY SUM(import) DESC;
```

## Exercici 15

Crea una vista anomenada "top_prod" que mostri les dades de tots els productes
seguit d'un camp anomenat "quant_total" en que es mostri la quantitat de cada
producte que s'ha demanat en totes les comandes. S'ha d'ordenar per tal que
primer es mostrin els productes que tenen més comandes.

```
CREATE VIEW top_prod
    AS SELECT productes.*, SUM(quantitat)
         FROM productes
              JOIN comandes
              ON (id_fabricant, id_producte) = (fabricant, producte)
        GROUP BY id_fabricant, id_producte
        ORDER BY COUNT(*) DESC;
``` 

## Exercici 16

Crea una vista anomenada "responsables" que mostri un llistat de tots els
representants de vendes. En un camp anomenat "empl" ha de mostrar el nom de
cada representant de vendes. També ha de mostrar un camp anomenat "superior"
que mostri el nom del cap del representant de vendes, en cas que el
representant de vendes tingui cap. També ha de mostrar un camp anomenat
"oficina_superior" que mostri el nom del director de l'oficina en que treballa
el representant de vendes, en cas que el representant de vendes tingui
assignada una oficina aquesta tingui un director.

```
CREATE VIEW responsables
    AS SELECT empleats.nom AS empl, caps.nom AS superior, directors.nom AS ofi_dire 
         FROM rep_vendes empleats 
              LEFT JOIN rep_vendes caps
              ON empleats.cap = caps.num_empl 
              
              LEFT JOIN oficines
              ON empleats.oficina_rep = oficina 

              LEFT JOIN rep_vendes directors
              ON director = directors.num_empl;
```

## Extres

+ Exercici2: recordem que a PostreSQL tenim la limitació de les vistes actualitzables (tot i que se li podria donar una volta amb les RULES, fora del temari), per exemple una consulta multitaula no ho serà, ni una agrupada ... Al manual d'ajuda de PostgreSQL tenim:

	- The view must have exactly one entry in its FROM list, which must be a table or another updatable view.
	- The view definition must not contain WITH, DISTINCT, GROUP BY, HAVING, LIMIT, or OFFSET clauses at the top level.
	- The view definition must not contain set operations (UNION, INTERSECT or EXCEPT) at the top level.
	- The view's select list must not contain any aggregates, window functions or set-returning functions.


