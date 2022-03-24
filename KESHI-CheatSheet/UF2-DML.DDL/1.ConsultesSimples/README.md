# CHEATSHEET KESHI [01]

# CONSULTAS SIMPLES

```sql
SELECT * 
FROM DEPT;
```


```sql
SELECT deptno, loc
FROM dept;
```

----------------------------------------------------------------------------------


* Operadores aritméticos

+ - * /

### OPERADORES ARITMÉTICOS

```sql
SQL> SELECT ename, sal, 12*sal+100
FROM emp;
```

* Tiene precedencia si tiene paréntesis

```sql
SQL> SELECT ename, sal, 12*(sal+100)
2 FROM emp;
```

* Null = Absencia de


----------------------------------------------------------------------------------

**ALIAS** = AS o
 
"alias"

### ALIAS


```sql
SELECT ename AS name, sal AS salary FROM emp;
```


```sql
SELECT ename "Name", sal*12 "Anual Salary"
```

----------------------------------------------------------------------------------


**CONCATENACIÓN** = CON ||

### CONCATENACIÓN

```sql
SQL> SELECT ename || job AS "Empleats"
2 FROM emp;
```

**CADENAS DE CARÁCTERES** = CON ||

```sql
SQL> SELECT ename ||' '||'is a'||' '||job
AS “Detall d’empleats"
FROM emp;
```

#### output

```sql
Detall d’empleats
-------------------------
KING is a PRESIDENT
BLAKE is a MANAGER
CLARK is a MANAGER
JONES is a MANAGER
MARTIN is a SALESMAN
...
14 rows selected.
```

----------------------------------------------------------------------------------

**Files Duplicades** = CON DISTINCT

```sql
SQL> SELECT DISTINCT deptno
FROM emp;
```


----------------------------------------------------------------------------------

**EJEMPLOS CONSULTAS SIMPLES**

### EXTRACT


* Funció de SQL estàndard: `extract`

```sql
SELECT nom, data_contracte
FROM rep_vendes
WHERE extract(year from data_contracte) < 1988;
```

### DATE_PART

* Funció de PostgreSQL: `date_part`

```sql
SELECT nom, data_contracte 
FROM rep_vendes 
WHERE date_part('year', data_contracte) < 1988;
```

----------------------------------------------------------------------------------

**LIKE**

### LIKE

* Identificador del fabricant, identificador del producte i descripció del producte d'aquells productes que el seu identificador de fabricant acabi amb la lletra i.

```sql
SELECT id_fabricant, id_producte, descripcio
FROM productes
WHERE id_fabricant LIKE '%i';
```


* Fabricant, producte i preu dels productes on el seu identificador comenci per 4 acabi per 3 i contingui tres caracters entre mig.

```sql
SELECT id_fabricant, id_producte, preu
FROM productes 
WHERE id_producte like '4___3';
```

```sql
 id_fabricant | id_producte |  preu  
--------------+-------------+--------
 aci          | 41003       | 107.00
 bic          | 41003       | 652.00
(2 rows)
```

* Si en comptes de 3 guions baixos possem '%' penseu que seria correcte la consulta? NO


* Identificador dels clients, el nom dels quals no conté la cadena " Mfg." o " Inc." o " Corp." i que tingui crèdit major a 30000.

```SQL
SELECT num_clie,empresa FROM clientes 
WHERE (empresa NOT LIKE '%Corp.%' AND empresa NOT LIKE '%Inc.%' AND empresa NOT LIKE '%Mfg.%') AND limite_credito > 30000;
```

----------------------------------------------------------------------------------

* Nom i identificador dels venedors que estan per sota la quota i tenen vendes inferiors a 300000.

```sql
SELECT nom, num_empl
FROM rep_vendes
WHERE vendes < quota AND vendes < 300000;
```

----------------------------------------------------------------------------------

### IN

* Identificador i nom dels venedors que treballen a les oficines 11 o 13.

```SQL
SELECT num_empl, nom
FROM rep_vendes
WHERE oficina_rep IN(11,13);
```


Una altra possible solució:

```SQL
SELECT num_empl, nom
FROM rep_vendes
WHERE oficina_rep = 11 OR oficina_rep = 13;
```

----------------------------------------------------------------------------------


### ORDER BY

## Exercici 15:

Identificador, descripció i preu dels productes ordenats del més car al més
barat.

```SQL
SELECT id_producte, descripcio, preu
FROM productes
ORDER BY preu DESC;
```

----------------------------------------------------------------------------------

### OPERADORES LÓGICOS


Identificadors i noms dels venedors amb vendes entre el 80% i el 120% de llur quota.

```sql
SELECT num_empl,nom
FROM rep_vendes
WHERE vendes > 80 * quota / 100 AND vendes < 120 * quota / 100;
```

El mateix d'una altra manera:

```sql
SELECT num_empl,nom
FROM rep_vendes
WHERE (vendes/quota) BETWEEN  0.8 AND 1.20;
      -- (vendes/quota) > 0.8
      --AND (vendes/quota) < 1.20;
```

```
 num_empl |   nom    
----------+-------------
      105 | Bill Adams
      106 | Sam Clark
      101 | Dan Roberts
      108 | Larry Fitch
      103 | Paul Cruz
(5 rows)
```

O si volem mostrar una 3a columna amb el percentatge entre 80 i 120:

```sql
SELECT num_empl, nom, 100 * vendes / quota as percentatge
FROM rep_vendes
WHERE vendes > 80 * quota / 100 AND vendes < 120 * quota / 100;
```

```
 num_empl |     nom     |     percentatge      
----------+-------------+----------------------
      105 | Bill Adams  | 105.1174285714285714
      106 | Sam Clark   | 109.0589090909090909
      101 | Dan Roberts | 101.8910000000000000
      108 | Larry Fitch | 103.3900000000000000
      103 | Paul Cruz   | 104.2818181818181818
(5 rows)
```

* I si volem només dos decimals podem fer servir la funció SQL ANSI CAST:

```sql
SELECT num_empl, nom, cast(100 * vendes / quota as numeric(5,2) ) as percentatge
FROM rep_vendes
WHERE vendes > 80 * quota / 100 AND vendes < 120 * quota / 100;
```

```
 num_empl |     nom     | percentatge 
----------+-------------+-------------
      105 | Bill Adams  |      105.12
      106 | Sam Clark   |      109.06
      101 | Dan Roberts |      101.89
      108 | Larry Fitch |      103.39
      103 | Paul Cruz   |      104.28
(5 rows)
``` 

----------------------------------------------------------------------------------

### FETCH

## Exercici 24:

* Codi i nom dels tres venedors que tinguin unes vendes superiors.

* Solució fent servir SQL ANSI:

```sql
SELECT num_empl,nom
FROM rep_vendes
ORDER BY vendes DESC
FETCH FIRST 3 ROWS ONLY;
```

[Solució de PostgreSQL (i MySQL, MAriaDB, SQLite)...](https://en.wikipedia.org/wiki/Select_(SQL)#FETCH_FIRST_clause):

```sql
SELECT num_empl,nom
FROM rep_vendes
ORDER BY vendes DESC
LIMIT 3;
```
```
  num_empl |   nom   
----------+------------
      102 | Sue Smith
      109 | Mary Jones
      105 | Bill Adams
(3 rows)
```

----------------------------------------------------------------------------------

### BETWEEN

* Excloent els extrems no podem fer servir BETWEEN:

## Exercici 1:

* Fabricant, número i import de les comandes, l'import de les quals oscil·li entre 10000 i 39999, i ordenades pel número de forma ascendent i pel fabricant descendent.

```sql
SELECT num_comanda, fabricant, import
FROM comandes
WHERE import BETWEEN 10000 AND 39999
ORDER BY fabricant, num_comanda DESC;
```

```
 num_comanda | fabricant |  import  
-------------+-----------+----------
      110036 | aci       | 22500.00
      112961 | rei       | 31500.00
      112979 | aci       | 15000.00
      112987 | aci       | 27500.00
      113042 | rei       | 22500.00
      113069 | imm       | 31350.00
(6 rows)
```


* Número de comanda, data comanda, codi fabricant, codi producte i import de les comandes realitzades entre els dies '1989-09-1' i '1989-12-31'.


* Mateixa consulta però sense inlcoure les dates dels extrems.

```SQL
SELECT num_comanda, data, fabricant,producte, import
FROM comandes
WHERE data >= '1989-09-01' AND  data <= '1989-12-31';
```

* O també podríem fer:

```SQL
SELECT num_comanda, data, fabricant,producte, import
FROM comandes
WHERE data BETWEEN '1989-09-01' AND '1989-12-31';
```

```
 num_comanda |    data    | fabricant | producte |  import  
-------------+------------+-----------+----------+----------
      112961 | 1989-12-17 | rei       | 2a44l    | 31500.00
      112968 | 1989-10-12 | aci       | 41004    |  3978.00
      112963 | 1989-12-17 | aci       | 41004    |  3276.00
      112983 | 1989-12-27 | aci       | 41004    |   702.00
      112979 | 1989-10-12 | aci       | 4100z    | 15000.00
      112992 | 1989-11-04 | aci       | 41002    |   760.00
      112975 | 1989-12-12 | rei       | 2a44g    |  2100.00
      112987 | 1989-12-31 | aci       | 4100y    | 27500.00
(8 rows)
```

* Excloent els extrems no podem fer servir BETWEEN:

```SQL
SELECT num_comanda, data, fabricant,producte, import
FROM comandes
WHERE data > '1989-09-01' AND  data < '1989-12-31';
```

```
 num_comanda |    data    | fabricant | producte |  import  
-------------+------------+-----------+----------+----------
      112961 | 1989-12-17 | rei       | 2a44l    | 31500.00
      112968 | 1989-10-12 | aci       | 41004    |  3978.00
      112963 | 1989-12-17 | aci       | 41004    |  3276.00
      112983 | 1989-12-27 | aci       | 41004    |   702.00
      112979 | 1989-10-12 | aci       | 4100z    | 15000.00
      112992 | 1989-11-04 | aci       | 41002    |   760.00
      112975 | 1989-12-12 | rei       | 2a44g    |  2100.00
(7 rows)

```


----------------------------------------------------------------------------------

# Clàusula UNION

Resolem un parell de consultes simples:


+ Els productes que tinguin un preu inferior a 70

```sql
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

```sql
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

* Com que es molt probable que hi hagi repeticions farem servir la clàusula DISTINCT. Si en comptes de 20000 l'import fos de 30000 no hi hauria repeticions però això no ho podem saber a priori, de manera que la posem. Per què a la primera no la hem de posar?_

Ara, suposem que volem resoldre aquesta altra consulta:

+ Els productes que tinguin un preu inferior a 70 i els productes dels quals
s'hagi demanat una comanda amb un import superior a 20000.

	La sentència UNION ens resol aquest problema

    ```sql
    SELECT id_fabricant, id_producte
    FROM productes
    WHERE preu < 70
	UNION
    SELECT  DISTINCT fabricant, producte
    FROM comandes
    WHERE import > 20000;
	```	

	```sql
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

```sql
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
