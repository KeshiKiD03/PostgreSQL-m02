# Clàusula UNION

Resolem un parell de consultes simples:


+ Els productes que tinguin un preu inferior a 70

	```
	SELECT id_fabricant, id_producte
	FROM productes
	WHERE preu < 70;
	```

	```
	 id_fabricant | id_producte 
	--------------+-------------
	 imm          | 887h 
	 aci          | 41001
	 aci          | 4100x
	(3 rows)
	```

+ Els productes dels quals s'hagi demanat una comanda amb un import superior a 20000.

	```
	SELECT  DISTINCT fabricant, producte
	FROM comandes
	WHERE import > 20000;
	```
	```
	 fabricant | producte 
	-----------+----------
	 rei       | 2a44r
	 rei       | 2a44l
	 aci       | 4100z
	 imm       | 775c 
 	 aci       | 4100y
	 (5 rows)
	```

	_Com que es molt probable que hi hagi repeticions farem servir la clàusula
DISTINCT. Si en comptes de 20000 l'import fos de 30000 no hi hauria repeticions
però això no ho podem saber a priori, de manera que la posem. Per què a la
primera no la hem de posar?_

Ara, suposem que volem resoldre aquesta altra consulta:

+ Els productes que tinguin un preu inferior a 70 i els productes dels quals
s'hagi demanat una comanda amb un import superior a 20000.

	La sentència UNION ens resol aquest problema

    ```
    SELECT id_fabricant, id_producte
    FROM productes
    WHERE preu < 70
	UNION
    SELECT  DISTINCT fabricant, producte
    FROM comandes
    WHERE import > 20000;
	```	

	```
	 id_fabricant | id_producte 
	--------------+-------------
	 rei          | 2a44l
	 imm          | 775c 
	 aci          | 4100y
	 imm          | 887h 
	 rei          | 2a44r
	 aci          | 4100z
	 aci          | 41001
	 aci          | 4100x
	(8 rows)
	```

Al següent tema veurem consultes multitaula i us preguntaré si amb una consulta multitaula es podria fer el mateix que aqui, i en el cas de que es pogués, quina opció seria més eficient.

**SOLUCIÓ**:
Una consulta de tipus:

```
SELECT DISTINCT id_fabricant, id_producte
FROM productes, comandes
WHERE id_fabricant = fabricant and id_producte = producte
AND ( import > 20000 or preu < 70);
```

No ens funcionarà si per exemple existeix algun producte que encara no s'hagi
venut i per tant no estigui a la taula comandes. Tot i així, si ens garantissin
que això no passa i que de tots els productes s'ha realitzat al menys una
venda, per a aquesta consulta concreta és molt més eficient el UNION.

---

## Restriccions a tenir en compte quan utilitzem la clàusula UNION:

1. Que podem dir respecte a les columnes de les dues consultes?

	- Ambdues taules resultants han de tenir el mateix número de columnes (les respectivas de cada consulta)
	- El tipus de dades de cada columna de la 1a taula resultant ha de ser el mateix que la columna corresponent a la 2a taula resultant.

2. Es poden ordenar les taules a un UNION?

	- Cap de les taules pot ser ordenada per separat, cosa que d'altra banda no és gaire útil, si podem fer servir un ORDER BY al final però utilitzant els números per referir-nos a una columna concreta, a no ser que aquesta columna tingui el mateix nom a totes dues consultes.

3. La clàusula UNION es pot fer servir per 3 consultes o més?

	- Sí. 

4. La clàusula UNION elimina files duplicades?

	- Sí.

5. Es pot indicar al UNION que no elimini les files duplicades?

	- Sí, amb UNION ALL  


EFICIÈNCIA: Fixem-nos en aquest darrer comportament, que és el contrari que amb
la sentència SELECT, la qual per defecte reté les files duplicades.

Aquest és un dels **comportaments** criticats pels experts: la gestió de les files duplicades a SQL.

D'una banda aquest **comportament** es basa en dues suposicions:

- La majoria de sentències SELECT no produeixen files repetides.
- La majoria de sentències UNION sí produeixen files repetides.

D'altra banda l'eliminació de files duplicades és un procés que consumeix molt de temps (evidentment sempre que parlem d'un nombre gran de files)

Per tant, si se sap, en base a consultes individuals implicades, que la operació UNION no produirà repeticion, **qué hauríem de fer servir per guanyar temps?**

**Solució**:

UNION ALL


OBS: Depenent de la implementació SQL la clàusula UNION té més restriccions.


## Exercici 1

Ordeneu la consulta anterior per l'identificador de fabricant (a l'inrevés) i l'identificadro de producte.

SOLUCIÓ:

```
SELECT id_fabricant, id_producte
FROM productes
WHERE preu < 70
UNION
SELECT  DISTINCT fabricant, producte
FROM comandes
WHERE import > 20000 order by 1 DESC, 2 ;
```
```
 id_fabricant | id_producte 
--------------+-------------
 rei          | 2a44l
 rei          | 2a44r
 imm          | 775c 
 imm          | 887h 
 aci          | 41001
 aci          | 4100x
 aci          | 4100y
 aci          | 4100z
(8 rows)

```

## Exercici 2

Feu una consulta que mostri les oficines que tinguin un treballador que sigui
director de vendes i les oficines que siguin de la regió Est i ordenat.

```
SELECT DISTINCT oficina_rep 
FROM rep_vendes
WHERE carrec = 'Dir Vendes'
UNION
SELECT oficina
FROM oficines
WHERE regio = 'Est' order by 1;


```
 oficina_rep 
-------------
          11
          12
          13
          21
(4 rows)
```
