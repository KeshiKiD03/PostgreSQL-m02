# Gestió de Bases de Dades
# Curs: 2021-22 (1HISX)
# Autor: Aaron Andal

# UF2 - Llenguatges SQL: DML i DDL.

## INDEX

* **CHEATSHEET KESHI [01]**: [Consultas Simples](https://github.com/KeshiKiD03/m02#cheatsheet-keshi-01)

* **CHEATSHEET KESHI [02]**: [UNION](https://github.com/KeshiKiD03/m02#cheatsheet-keshi-02)

* **CHEATSHEET KESHI [03]**: [JOIN - Multi Tabla](https://github.com/KeshiKiD03/m02#cheatsheet-keshi-03)

* **CHEATSHEET KESHI [04]**: [Funciones de grupo - Aggregate - GROUP BY - HAVING](https://github.com/KeshiKiD03/m02#cheatsheet-keshi-04)

* **CHEATSHEET KESHI [05]**: [Subconsultas - ANY - ALL - IN - NOT IN](https://github.com/KeshiKiD03/m02#cheatsheet-keshi-05)

* **CHEATSHEET KESHI [06]**: [JOIN - Multi Tabla](https://github.com/KeshiKiD03/m02#cheatsheet-keshi-06)

* **CHEATSHEET KESHI [07]**: [Consultas Simples](https://github.com/KeshiKiD03/m02#cheatsheet-keshi-07)

* **CHEATSHEET KESHI [08]**: [UNION](https://github.com/KeshiKiD03/m02#cheatsheet-keshi-08)

* **CHEATSHEET KESHI [09]**: [JOIN - Multi Tabla](https://github.com/KeshiKiD03/m02#cheatsheet-keshi-09)

* **CHEATSHEET KESHI [10]**: [Consultas Simples](https://github.com/KeshiKiD03/m02#cheatsheet-keshi-10)

* **CHEATSHEET KESHI [11]**: [UNION](https://github.com/KeshiKiD03/m02#cheatsheet-keshi-11)

* **CHEATSHEET KESHI [12]**: [JOIN - Multi Tabla](https://github.com/KeshiKiD03/m02#cheatsheet-keshi-12)

## Links de Interes

* **Instalación POSTGRESQL Debian**: [INSTALL](https://gitlab.com/isx-m02-m10-bd/uf2-sql-ddl-i-dml-public/-/raw/main/introduccio/0_install_config_postgreSQL.md)

* **Configuración POSTGRESQL Debian**: [INSTALL Y CONFIGURACIÓN](https://gitlab.com/jandugar/m02-bd/-/blob/master/UF2_SQL/apunts/0_install_config_postgreSQL_DEBIAN.md)

* **Instalación POSTGRESQL Debian**: [GITLAB_ANDUJAR]https://gitlab.com/jandugar/m02-bd

# POSTGRESQL

* **POSTGRESQL - CHEATSHEET**: [CHEATSHEET_POSTGRESQL](https://github.com/KeshiKiD03/m02/Help-Postgres.md)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/SQL-Commands.png)



### CheatSheet PostgreSQL

* `\du` --> Ver tu usuario.

---------------------------------------------------------------------------------

## BACKUP i RESTORE de la Base de DADES training:

**V1**

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

---------------------------------------------------------------------------------

**V2**

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

---------------------------------------------------------------------------------

 


* 

* 

* 

* 

---------------------------------------------------------------------------------

# CHEATSHEET KESHI [01]

## CONSULTAS SIMPLES

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

```sql
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

```sql
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

```sql
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
```sql
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

```sql
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

```sql
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

```sql
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
```sql
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

```sql
SELECT id_fabricant, id_producte
FROM productes
WHERE preu < 70
UNION
SELECT  DISTINCT fabricant, producte
FROM comandes
WHERE import > 20000 order by 1 DESC, 2 ;
```
```sql
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


```sql
 oficina_rep 
-------------
          11
          12
          13
          21
(4 rows)
```

----------------------------------------------------------------------------------

# CHEATSHEET KESHI [02]

# Clàusula UNION

Resolem un parell de consultes simples:


+ Els productes que tinguin un preu inferior a 70

```sql
	SELECT id_fabricant, id_producte
	FROM productes
	WHERE preu < 70;
```

```sql
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

4. `La clàusula UNION elimina files duplicades?`

	- Sí.

5. `Es pot indicar al UNION que no elimini les files duplicades?`

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

```sql
SELECT id_fabricant, id_producte
FROM productes
WHERE preu < 70
UNION
SELECT  DISTINCT fabricant, producte
FROM comandes
WHERE import > 20000 order by 1 DESC, 2 ;
```
```sql
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

```sql
SELECT DISTINCT oficina_rep 
FROM rep_vendes
WHERE carrec = 'Dir Vendes'
UNION
SELECT oficina
FROM oficines
WHERE regio = 'Est' order by 1;


```sql
 oficina_rep 
-------------
          11
          12
          13
          21
(4 rows)
```

----------------------------------------------------------------------------------

# Examen consultes simples

## Consulta 0

```sql
SELECT cognom1, cognom2, nom
FROM el_meu_NIF_o_NIE;
```

```
┌───────────────────┬─────────────────────┬──────────────────┐
│     cognom1       │       cognom2       │       nom        │
├───────────────────┼─────────────────────┼──────────────────┤
│                   │                     │                  │
└───────────────────┴─────────────────────┴──────────────────┘
```



__La llegibilitat és molt important__
+ Si no fas la consulta 0 tens un 0.
+ Utilitzeu MAJÚSCULES per TOTES les clàusules SQL: SELECT, FROM, WHERE, OR, AND ... 
+ Trenqueu les consultes en diferents línies tal i com fem a classe:

	```
	SELECT ...
	  FROM ...
	 WHERE ...
	```

## Consulta 1

Llisteu la descripció i l'estoc dels productes amb un preu superior a 100 i que compleixin tots els següents supòsits:
+ L'identificador del fabricant comenci per la lletra _q_ o bé l'estoc sigui inferior o igual a 100.
+ L'estoc sigui superior a 100 o bé la descripció del producte acabi amb les lletres _Tm_.

```sql
	SELECT descripcio, estoc
	  FROM productes
	 WHERE preu > 100
	   AND ( id_fabricant LIKE 'q%' OR estoc <= 100)
	   AND ( estoc > 100 OR descripcio LIKE '%Tm');
```
```sql
	  descripcio   | estoc 
	---------------+-------
	 Riosta 2-Tm   |     9
	 Reductor      |   203
	 Riosta 1-Tm   |     5
	 Riosta 1/2-Tm |    28
	(4 rows)
```

## Consulta 2

Llisteu l'identificador, la data i l'import de les comandes anteriors a l'11 de gener de 1990 i que compleixin algun dels següents supòsits:

+ La quantitat de la comanda sigui superior o igual a 20 i l'identificador del fabricant sigui _aci_.
+ L'import de la comanda sigui superior a 10000 i sigui del client número 2114.
```sql
	SELECT num_comanda, data, import
	  FROM comandes
	 WHERE data < '1990-01-11'
	   AND ( quantitat >= 20 AND fabricant = 'aci' OR import > 10000 AND clie = 2114 ); 
```
	
```sql
	 num_comanda |    data    |  import  
	-------------+------------+----------
	      112968 | 1989-10-12 |  3978.00
	      112963 | 1989-12-17 |  3276.00
	      112979 | 1989-10-12 | 15000.00
	(3 rows)
```

## Consulta 3
Llisteu el nom i límit de crèdit dels clients amb un límit de crèdit superior a 20000, ordenats en primera instància pel límit de crèdit, de major crèdit a menor, i en segona instància pel nom de l'empresa en ordre alfabètic.

```sql
SELECT empresa, limit_credit
  FROM clients
 WHERE limit_credit > 20000
 ORDER BY limit_credit DESC, empresa;
```
```sql
      empresa      | limit_credit 
-------------------+--------------
 First Corp.       |     65000.00
 Fred Lewis Corp.  |     65000.00
 Jones Mfg.        |     65000.00
 Midwest Systems   |     60000.00
 Holm & Landis     |     55000.00
 Acme Mfg.         |     50000.00
 JCP Inc.          |     50000.00
 Rico Enterprises  |     50000.00
 Zetacorp          |     50000.00
 AAA Investments   |     45000.00
 QMA Assoc.        |     45000.00
 Carter & Sons     |     40000.00
 Peter Brothers    |     40000.00
 Ace International |     35000.00
 J.P. Sinclair     |     35000.00
 Three-Way Lines   |     30000.00
 Chen Associates   |     25000.00
 Solomon Inc.      |     25000.00
(18 rows)
```

## Consulta 4
Llisteu l'identificador i el nom dels representants de vendes que no tinguin un director assignat o que no tinguin una quota assignada. També s'han de llistar aquells que les seves vendes no hagin superat la seva quota.

```sql
SELECT num_empl, nom
  FROM rep_vendes
 WHERE cap IS NULL
    OR quota IS NULL
    OR vendes <= quota;
```
```sql
 num_empl |      nom      
----------+---------------
      106 | Sam Clark
      104 | Bob Smith
      110 | Tom Snyder
      107 | Nancy Angelli
(4 rows)
```

## Consulta 5
Llisteu l'identificador i la ciutat de les oficines l'objectiu de les quals sigui superior a les vendes i de les que tinguin vendes majors o iguals a 300000 i menors o iguals a 700000. **ATENCIÓ**: NO pots fer servir l'operador _<_ ni _<=_.

```sql
SELECT oficina, ciutat
  FROM oficines
 WHERE objectiu > vendes
    OR vendes >= 300000 AND 700000 >= vendes;
```	
o també:
```sql
 WHERE objectiu > vendes
    OR vendes BETWEEN 300000 AND 700000;
```

```sql
 oficina |  ciutat  
---------+----------
      22 | Denver
      11 | New York
      12 | Chicago
      13 | Atlanta
(4 rows)
```

## Consulta 6
Llisteu els productes amb el seu valor d'estoc, és a dir el preu del producte multiplicat per l'estoc del producte. S'ha de mostrar l'identificador del producte, l'identificador del fabricant i el valor d'estoc com a _valor_.

```sql
SELECT id_fabricant, id_producte, preu * estoc AS valor
  FROM productes;
```

```sql
 id_fabricant | id_producte |  valor   
--------------+-------------+----------
 rei          | 2a45c       | 16590.00
 aci          | 4100y       | 68750.00
 qsa          | xk47        | 13490.00
 bic          | 41672       |     0.00
 imm          | 779c        | 16875.00
 aci          | 41003       | 22149.00
 aci          | 41004       | 16263.00
 bic          | 41003       |  1956.00
 imm          | 887p        |  6000.00
 qsa          | xk48        | 27202.00
 rei          | 2a44l       | 54000.00
 fea          | 112         | 17020.00
 imm          | 887h        | 12042.00
 bic          | 41089       | 17550.00
 aci          | 41001       | 15235.00
 imm          | 775c        |  7125.00
 aci          | 4100z       | 70000.00
 qsa          | xk48a       |  4329.00
 aci          | 41002       | 12692.00
 rei          | 2a44r       | 54000.00
 imm          | 773c        | 27300.00
 aci          | 4100x       |   925.00
 fea          | 114         |  3645.00
 imm          | 887x        | 15200.00
 rei          | 2a44g       |  4900.00
(25 rows)
```

## Consulta 7
Llisteu els 2 representants de vendes amb les vendes més baixes. Per a cada representant es mostrarà un camp de nom *nom_vendes* amb la següent frase *NOM ha venut VENDES €*. 

Per exemple: *Tom Snyder ha venut 75985.00 €*.

```sql
SELECT nom || ' ha venut ' || vendes || ' €' AS nom_vendes
  FROM rep_vendes
 ORDER BY vendes
 FETCH FIRST 2 ROWS ONLY;
```

_ASC_ és opcional aquí.

```sql
           nom_vendes           
--------------------------------
 Tom Snyder ha venut 75985.00 €
 Bob Smith ha venut 142594.00 €
(2 rows)
```

## Consulta 8
Llisteu les regions de les oficines, només mostrant un cop cada regió.

```sql
SELECT DISTINCT regio
  FROM oficines;
```
```sql
 regio 
-------
 Est
 Oest
(2 rows)
```

## Consulta 9
Llisteu totes les dades de les oficines amb un objectiu major a 500000 amb director identificat amb el nombre 104 o 108. **ATENCIÓ**: No pots fer servir la clàusula OR.

```sql
SELECT * 
  FROM oficines
 WHERE objectiu > 500000 AND director IN (104,108);
```
```sql
 oficina |   ciutat    | regio | director | objectiu  |  vendes   
---------+-------------+-------+----------+-----------+-----------
      12 | Chicago     | Est   |      104 | 800000.00 | 735042.00
      21 | Los Angeles | Oest  |      108 | 725000.00 | 835915.00
(2 rows)
```

## Consulta 10

Llisteu l'identificador i venedor assignat dels clients que tinguin un límit de crèdit inferior a 25000 i dels que hagin fet una comanda superior a 20000.

```sql
(SELECT num_clie, rep_clie
  FROM clients
 WHERE limit_credit < 25000)
 
 UNION

(SELECT DISTINCT clie, rep
  FROM comandes
 WHERE import > 20000);
```

```sql
 num_clie | rep_clie 
----------+----------
     2115 |      101
     2113 |      104
     2114 |      102
     2113 |      101
     2107 |      110
     2103 |      105
     2112 |      108
     2117 |      106
     2109 |      107
(9 rows)
```

---------------------------------------------------------------------------------

# CHEATSHEET KESHI [03]

# JOIN

* Utilitzem la clàusula JOIN per a consultar dades que es troben en més d’una taula.

* És una reunió o composició de les files d’una taula amb les d’una altra.

```sql
SELECT taula1.columna1, taula2.columna2
FROM taula1 [INNER] JOIN taula2
ON taula1.clau_forana = taula2.clau_primaria;
```

### CROSS JOIN

* Producto cartesiano - Forma explícita o implícita

* Se unen campos de dos tablas o más tablas.

### INNER JOIN O WHERE

`JOIN` sólo se produce cuando las filas cumplen con la clausula `ON`

`FORMA EXPLÍCITA`

```sql
SELECT * FROM propietaris INNER JOIN gats 
ON gats.propietari = propietaris.id;
```

`FORMA EMPLÍCITA`

```sql
SELECT * FROM propietaris, gats WHERE gats.propietari = propietaris.id;
```

#### ALIAS

* Ayudan a simplificar

```sql
SELECT e.empno, e.ename, e.deptno,
d.deptno, d.loc
FROM emp e JOIN dept d
ON e.deptno = d.deptno;
```


### OUTER JOIN

S’utilitza per afegir, al resultat, les files de la taula
que vulguem (left, right o les dues) que
NO acompleixen la condició del JOIN.
● Left join
● Rigth join*
● Full join

```sql
SELECT taula1.columna1, taula2.columna2
FROM taula1 LEFT [OUTER] JOIN taula2
ON taula1.clau_forana = taula2.clau_primaria;
```


```sql
SELECT taula1.columna1, taula2.columna2
FROM taula1 RIGHT [OUTER] JOIN taula2
ON taula1.clau_forana = taula2.clau_primaria;
```

*  Un RIGHT JOIN sempre es pot expressar com un LEFT JOIN,

* És suficient canviar l’ordre de les taules, però quan hi ha més de dues taules podria resultar + còmode no canviar-ho.



#### LEFT JOIN




#### RIGHT JOIN



#### FULL JOIN



----------------------------------------------------------------------------------

**EJEMPLOS**


# Consultes multitaula

## Exercici 1

Llista la ciutat de les oficines, i el nom i càrrec dels directors de cada oficina.

```sql
SELECT ciutat, nom, carrec
  FROM oficines
       JOIN rep_vendes
       ON oficines.director = rep_vendes.num_empl;
```
```sql
   ciutat    |     nom     |       carrec        
-------------+-------------+---------------------
 Denver      | Larry Fitch | Dir Vendes
 New York    | Sam Clark   | VP Vendes
 Chicago     | Bob Smith   | Dir Vendes
 Atlanta     | Bill Adams  | Representant Vendes
 Los Angeles | Larry Fitch | Dir Vendes
```

Però clar, segur que aquesta és tota la informació que ens demanen? Podria ser
que hi hagués un oficina sense director? La resposta és sí:

```sql
\d oficines
                      Table "public.oficines"
  Column  |         Type          | Collation | Nullable |
----------+-----------------------+-----------+----------+...
 oficina  | smallint              |           | not null | 
 ciutat   | character varying(15) |           | not null | 
 regio    | character varying(10) |           | not null | 
 director | smallint              |           |          | <==
 objectiu | numeric(9,2)          |           |          | 
 vendes   | numeric(9,2)          |           |          | 
```

De manera que és interessant veure totes les oficines, i que es vegi si n'hi ha
alguna sense director:

```sql
SELECT ciutat, nom, carrec
  FROM oficines
       LEFT JOIN rep_vendes
       ON  oficines.director = rep_vendes.num_empl ;
```

```sql
   ciutat    |     nom     |       carrec        
-------------+-------------+---------------------
 Denver      | Larry Fitch | Dir Vendes
 New York    | Sam Clark   | VP Vendes
 Chicago     | Bob Smith   | Dir Vendes
 Atlanta     | Bill Adams  | Representant Vendes
 Los Angeles | Larry Fitch | Dir Vendes
(5 rows)
```

## Exercici 2

Llista totes les comandes mostrant el seu número, import, número de client i límit de crèdit.

```sql
SELECT num_comanda, import, empresa, limit_credit
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie;
```

```
 num_comanda |  import  |      empresa      | limit_credit 
-------------+----------+-------------------+--------------
      112961 | 31500.00 | J.P. Sinclair     |     35000.00
      113012 |  3745.00 | JCP Inc.          |     50000.00
      112989 |  1458.00 | Jones Mfg.        |     65000.00
      113051 |  1420.00 | Midwest Systems   |     60000.00
      112968 |  3978.00 | First Corp.       |     65000.00
      110036 | 22500.00 | Ace International |     35000.00
      113045 | 45000.00 | Zetacorp          |     50000.00
      112963 |  3276.00 | Acme Mfg.         |     50000.00
      113013 |   652.00 | Midwest Systems   |     60000.00
      113058 |  1480.00 | Holm & Landis     |     55000.00
      112997 |   652.00 | Peter Brothers    |     40000.00
      112983 |   702.00 | Acme Mfg.         |     50000.00
      113024 |  7100.00 | Orion Corp        |     20000.00
      113062 |  2430.00 | Peter Brothers    |     40000.00
      112979 | 15000.00 | Orion Corp        |     20000.00
      113027 |  4104.00 | Acme Mfg.         |     50000.00
      113007 |  2925.00 | Zetacorp          |     50000.00
      113069 | 31350.00 | Chen Associates   |     25000.00
      113034 |   632.00 | Ace International |     35000.00
      112992 |   760.00 | Midwest Systems   |     60000.00
      112975 |  2100.00 | JCP Inc.          |     50000.00
      113055 |   150.00 | Holm & Landis     |     55000.00
      113048 |  3750.00 | Rico Enterprises  |     50000.00
      112993 |  1896.00 | Fred Lewis Corp.  |     65000.00
      113065 |  2130.00 | Fred Lewis Corp.  |     65000.00
      113003 |  5625.00 | Holm & Landis     |     55000.00
      113049 |   776.00 | Midwest Systems   |     60000.00
      112987 | 27500.00 | Acme Mfg.         |     50000.00
      113057 |   600.00 | JCP Inc.          |     50000.00
      113042 | 22500.00 | Ian & Schmidt     |     20000.00
(30 rows)
```

Aquí no es pot donar el mateix cas d'abans, ja que les comandes tenen totes el
camp _clie_ amb _not null_.

## Exercici 3

Llista el número de totes les comandes amb la descripció del producte demanat.

```sql
SELECT num_comanda, descripcio
  FROM comandes
       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte;
```

```sql
 num_comanda |     descripcio     
-------------+--------------------
      112961 | Frontissa Esq.
      113012 | Article Tipus 3
      112989 | Bancada Motor
      112968 | Article Tipus 4
      110036 | Muntador
      113045 | Frontissa Dta.
      112963 | Article Tipus 4
      113013 | Manovella
      113058 | Coberta
      112997 | Manovella
      112983 | Article Tipus 4
      113024 | Reductor
      113062 | Bancada Motor
      112979 | Muntador
      113027 | Article Tipus 2
      113007 | Riosta 1/2-Tm
      113069 | Riosta 1-Tm
      113034 | V Stago Trinquet
      112992 | Article Tipus 2
      112975 | Passador Frontissa
      113055 | Peu de rei
      113048 | Riosta 2-Tm
      112993 | V Stago Trinquet
      113065 | Reductor
      113003 | Riosta 2-Tm
      113049 | Reductor
      112987 | Extractor
      113057 | Peu de rei
      113042 | Frontissa Dta.
(29 rows)
```

Trobes quelcom estrany?

En efecte només surten 29 en comptes de 30, en trobar una inconsistència a la
base de dades: un dels productes que surten a una comanda no el venem! Això és
perquè hi ha una errada en l'entrada d'informació. Aquesta errada es podria
haver evitat amb una senzilla regla a la taula. Més endavant resoldrem aquest
problema.

Si la taula no contingués aquest error, una consulta INNER JOIN seria la resposta aquí però com que no és el cas, necessitem un LEFT JOIN perquè sorti aquesta comanda amb el producte fantasma.


## Exercici 4

Llista el nom de tots els clients amb el nom del representant de vendes assignat.

```sql
SELECT empresa, nom
  FROM clients
       JOIN rep_vendes
       ON clients.rep_clie = rep_vendes.num_empl;
```
```sql
      empresa      |      nom      
-------------------+---------------
 JCP Inc.          | Paul Cruz
 First Corp.       | Dan Roberts
 Acme Mfg.         | Bill Adams
 Carter & Sons     | Sue Smith
 Ace International | Tom Snyder
 Smithson Corp.    | Dan Roberts
 Jones Mfg.        | Sam Clark
 Zetacorp          | Larry Fitch
 QMA Assoc.        | Paul Cruz
 Orion Corp        | Sue Smith
 Peter Brothers    | Nancy Angelli
 Holm & Landis     | Mary Jones
 J.P. Sinclair     | Sam Clark
 Three-Way Lines   | Bill Adams
 Rico Enterprises  | Sue Smith
 Fred Lewis Corp.  | Sue Smith
 Solomon Inc.      | Mary Jones
 Midwest Systems   | Larry Fitch
 Ian & Schmidt     | Bob Smith
 Chen Associates   | Paul Cruz
 AAA Investments   | Dan Roberts
(21 rows)
```

## Exercici 5

Llista la data de totes les comandes amb el numero i nom del client de la comanda.

```sql
SELECT data, num_clie, empresa
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie; 
```
```
    data    | num_clie |      empresa      
------------+----------+-------------------
 1989-12-17 |     2117 | J.P. Sinclair
 1990-01-11 |     2111 | JCP Inc.
 1990-01-03 |     2101 | Jones Mfg.
 1990-02-10 |     2118 | Midwest Systems
 1989-10-12 |     2102 | First Corp.
 1990-01-30 |     2107 | Ace International
 1990-02-02 |     2112 | Zetacorp
 1989-12-17 |     2103 | Acme Mfg.
 1990-01-14 |     2118 | Midwest Systems
 1990-02-23 |     2108 | Holm & Landis
 1990-01-08 |     2124 | Peter Brothers
 1989-12-27 |     2103 | Acme Mfg.
 1990-01-20 |     2114 | Orion Corp
 1990-02-24 |     2124 | Peter Brothers
 1989-10-12 |     2114 | Orion Corp
 1990-01-22 |     2103 | Acme Mfg.
 1990-01-08 |     2112 | Zetacorp
 1990-03-02 |     2109 | Chen Associates
 1990-01-29 |     2107 | Ace International
 1989-11-04 |     2118 | Midwest Systems
 1989-12-12 |     2111 | JCP Inc.
 1990-02-15 |     2108 | Holm & Landis
 1990-02-10 |     2120 | Rico Enterprises
 1989-01-04 |     2106 | Fred Lewis Corp.
 1990-02-27 |     2106 | Fred Lewis Corp.
 1990-01-25 |     2108 | Holm & Landis
 1990-02-10 |     2118 | Midwest Systems
 1989-12-31 |     2103 | Acme Mfg.
 1990-02-18 |     2111 | JCP Inc.
 1990-02-02 |     2113 | Ian & Schmidt
(30 rows)
```

## Exercici 6

Llista les oficines, noms i títols del seus directors amb un objectiu superior a 600.000.

```sql
SELECT oficina, nom, carrec, objectiu
  FROM oficines
       JOIN rep_vendes
       ON oficines.director = rep_vendes.num_empl
 WHERE oficines.objectiu > 600000;	
```

```
 oficina |     nom     |   carrec   | objectiu  
---------+-------------+------------+-----------
      12 | Bob Smith   | Dir Vendes | 800000.00
      21 | Larry Fitch | Dir Vendes | 725000.00
(2 rows)
```

Mateix cas que a la consulta de l'exercici 1, com el camp _director_ de la
taula _oficines_ pot ser null, podriem estar interessats en mostrar totes les
oficines, fins i tot les que no tenenen director:

```sql
SELECT  oficina, nom, carrec, objectiu
  FROM  oficines
        LEFT JOIN rep_vendes
        ON oficines.director = rep_vendes.num_empl
 WHERE  oficines.objectiu > 600000;
```

Bastaria afegir una oficina sense director per veure la diferència:

```sql
INSERT INTO oficines VALUES(88, 'Vielha', 'Vathd''Aran', NULL, 700000, 666000);
```

## Exercici 7

Llista els venedors de les oficines de la regió est.

```sql
SELECT nom, ciutat
  FROM rep_vendes
       JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina
 WHERE regio = 'Est';
```

```
     nom     |  ciutat  
-------------+----------
 Bill Adams  | Atlanta
 Mary Jones  | New York
 Sam Clark   | New York
 Bob Smith   | Chicago
 Dan Roberts | Chicago
 Paul Cruz   | Chicago
```


Si mirem la taula de venedors _rep_vendes_ veurem que el camp _oficina_rep_ pot
ser NULL, però aquí no té sentit afegir aquests casos, ja que la consulta és
clara, _volem els treballadors que siguin de l'oficina 'Est'_, això obliga a
que el treballador tingui alguna oficina assignada.

## Exercici 8

Llista les comandes superiors a 25000, incloent el nom del venedor que va
servir la comanda i el nom del client que el va sol·licitar.

```sql
SELECT nom, empresa, import
  FROM comandes
       JOIN rep_vendes
       ON comandes.rep = rep_vendes.num_empl

       JOIN clients
       ON comandes.clie = clients.num_clie
 WHERE import > 25000;  
```

```
 num_comanda |      nom      |     empresa     |  import  
-------------+---------------+-----------------+----------
      112961 | Sam Clark     | J.P. Sinclair   | 31500.00
      113045 | Larry Fitch   | Zetacorp        | 45000.00
      113069 | Nancy Angelli | Chen Associates | 31350.00
      112987 | Bill Adams    | Acme Mfg.       | 27500.00
(4 rows)
```

Però com la taula _comandes_ pot tenir com a NULL el camp _rep_ hauríem de fer
un OUTER JOIN mirant a quin costat es troba la taula que pot tenir un NULL.
Afegim una comanda sense venedor a la taula comandes per comprovar la
diferència de resultats.

```sql
INSERT INTO comandes VALUES ( 88888, '2021-11-11', 2111, NULL, 'vi', 'Bages', 2600, 26000);
```

```sql
SELECT num_comanda, nom, empresa, import
  FROM comandes
       LEFT JOIN rep_vendes
       ON comandes.rep = rep_vendes.num_empl

       JOIN clients
       ON comandes.clie = clients.num_clie 
 WHERE import > 25000;
```

```
 num_comanda |      nom      |     empresa     |  import  
-------------+---------------+-----------------+----------
      112961 | Sam Clark     | J.P. Sinclair   | 31500.00
      113045 | Larry Fitch   | Zetacorp        | 45000.00
      113069 | Nancy Angelli | Chen Associates | 31350.00
      112987 | Bill Adams    | Acme Mfg.       | 27500.00
       88888 |               | JCP Inc.        | 26000.00
(5 rows)
```

## Exercici 9

Llista les comandes superiors a 25000, mostrant el client que va servir la comanda i el nom del venedor que té assignat el client.

```sql
SELECT  num_comanda, empresa, rep_clie, nom,import
  FROM  comandes
        JOIN clients
        ON comandes.clie = clients.num_clie

        JOIN rep_vendes
        ON clients.rep_clie = rep_vendes.num_empl  
 WHERE  import > 25000;
```

```
 num_comanda |     empresa     | rep_clie |  import  
-------------+-----------------+----------+----------
      112961 | J.P. Sinclair   |      106 | 31500.00
      113045 | Zetacorp        |      108 | 45000.00
      113069 | Chen Associates |      103 | 31350.00
      112987 | Acme Mfg.       |      105 | 27500.00
(4 rows)
```

## Exercici 10

Llista les comandes superiors a 22000, mostrant el nom del client que el va ordenar, el venedor associat al client, i la ciutat a on treballa aquest venedor.

```sql
SELECT num_comanda, empresa, rep_clie, oficina_rep, ciutat, import
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes
       ON clients.rep_clie = rep_vendes.num_empl

       JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina
 WHERE import > 22000;
```

Aquí podem tenir problemes amb els venedors que no tinguin associada una oficina, de manera que hauríem de fer un LEFT JOIN:

```sql
SELECT num_comanda, empresa, nom, oficina_rep, ciutat, import
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes
       ON clients.rep_clie = rep_vendes.num_empl

       LEFT JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina
 WHERE import > 22000;
```

```
 num_comanda |      empresa      |     nom     | oficina_rep |   ciutat    |  import  
-------------+-------------------+-------------+-------------+-------------+----------
      112961 | J.P. Sinclair     | Sam Clark   |          11 | New York    | 31500.00
      110036 | Ace International | Tom Snyder  |             |             | 22500.00
      113045 | Zetacorp          | Larry Fitch |          21 | Los Angeles | 45000.00
      113069 | Chen Associates   | Paul Cruz   |          12 | Chicago     | 31350.00
      112987 | Acme Mfg.         | Bill Adams  |          13 | Atlanta     | 27500.00
      113042 | Ian & Schmidt     | Bob Smith   |          12 | Chicago     | 22500.00
(6 rows)
```

## Exercici 11

Llista totes les combinacions de venedors i oficines on la quota del venedor és superior a l'objectiu de l'oficina.

És una consulta poc pràctica, sense relació entre venedors i oficines. De manera que farem el producte cartesià. Tots amb tots.

```sql
SELECT nom, ciutat, quota, objectiu
  FROM rep_vendes, oficines
 WHERE quota > objectiu;
```
o

```sql
SELECT nom, ciutat, quota, objectiu 
  FROM rep_vendes
       JOIN oficines
       ON 1 = 1
 WHERE quota > objectiu;
``` 

```sql
     nom     | ciutat |   quota   | objectiu  
-------------+--------+-----------+-----------
 Bill Adams  | Denver | 350000.00 | 300000.00
 Sue Smith   | Denver | 350000.00 | 300000.00
 Larry Fitch | Denver | 350000.00 | 300000.00
(3 rows)
```

## Exercici 12

Informa sobre tots els venedors i les oficines en les que treballen.

```sql
SELECT nom, ciutat
  FROM rep_vendes
       LEFT JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina;
```

```
      nom      |   ciutat    
---------------+-------------
 Bill Adams    | Atlanta
 Mary Jones    | New York
 Sue Smith     | Los Angeles
 Sam Clark     | New York
 Bob Smith     | Chicago
 Dan Roberts   | Chicago
 Tom Snyder    | 
 Larry Fitch   | Los Angeles
 Paul Cruz     | Chicago
 Nancy Angelli | Denver
(10 rows)
```


## Exercici 13

Llista els venedors amb una quota superior a la dels seus caps.

```sql
SELECT venedors.nom, venedors.quota, caps.nom, caps.quota
  FROM rep_vendes AS venedors
       JOIN rep_vendes AS caps
       ON venedors.cap  = caps.num_empl
 WHERE venedors.quota > caps.quota;
```

Aquí volem que hi una comparació de quotes, de manera que no té sentit jugar amb els OUTER, però si la consulta que ens demanessin fos:

"Llista els venedors amb una quota superior a la dels seus caps o d'aquells venedors amb quota però que no tinguin cap: "

```sql
SELECT venedors.nom, venedors.quota, caps.nom, caps.quota
  FROM rep_vendes AS venedors
       LEFT JOIN rep_vendes AS caps
       ON venedors.cap  = caps.num_empl   
 WHERE venedors.quota > caps.quota
    OR venedors.cap IS NULL;
``` 

Aquí és clau fer el LEFT JOIN, sinó no surt Sam Clark

```
     nom     |   quota   |    nom    |   quota   
-------------+-----------+-----------+-----------
 Bill Adams  | 350000.00 | Bob Smith | 200000.00
 Mary Jones  | 300000.00 | Sam Clark | 275000.00
 Dan Roberts | 300000.00 | Bob Smith | 200000.00
 Larry Fitch | 350000.00 | Sam Clark | 275000.00
 Paul Cruz   | 275000.00 | Bob Smith | 200000.00
(5 rows)
```

## Exercici 14

Llistar el nom de l'empresa i totes les comandes fetes pel client 2103.

```sql
SELECT empresa, num_comanda
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie
 WHERE clients.num_clie = 2103;
```

```
  empresa  | num_comanda | producte |  import  
-----------+-------------+----------+----------
 Acme Mfg. |      112963 | 41004    |  3276.00
 Acme Mfg. |      112983 | 41004    |   702.00
 Acme Mfg. |      113027 | 41002    |  4104.00
 Acme Mfg. |      112987 | 4100y    | 27500.00
(4 rows)
```

## Exercici 15

Llista aquelles comandes que el seu import sigui superior a 10000, mostrant el
numero de comanda, els imports i les descripcions del producte.

```sql
SELECT num_comanda, import, descripcio
  FROM comandes
       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte
 WHERE import > 10000;
```

```
 num_comanda |  import  |   descripcio   
-------------+----------+----------------
      112961 | 31500.00 | Frontissa Esq.
      110036 | 22500.00 | Muntador
      113045 | 45000.00 | Frontissa Dta.
      112979 | 15000.00 | Muntador
      113069 | 31350.00 | Riosta 1-Tm
      112987 | 27500.00 | Extractor
      113042 | 22500.00 | Frontissa Dta.
(7 rows)
```

Aquí recordem que per culpa de l'errada d'entrada de dades, tenim una comanda
amb un producte inventat, per tant hauriem de posar LEFT JOIN perquè sortís (si
no surt és perquè no compleix la condició del WHERE)


## Exercici 16

Llista les comandes superiors a 22000, mostrant el nom del client que la va
demanar, el venedor associat al client, i l'oficina on el venedor treballa.
També cal mostrar la descripció del producte.

```sql
SELECT empresa, nom, ciutat, descripcio, import
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes
       ON clients.rep_clie = rep_vendes.num_empl

       JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina

       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte
 WHERE import > 22000;
```

```
     empresa     |     nom     |   ciutat    |   descripcio   |  import  
-----------------+-------------+-------------+----------------+----------
 J.P. Sinclair   | Sam Clark   | New York    | Frontissa Esq. | 31500.00
 Zetacorp        | Larry Fitch | Los Angeles | Frontissa Dta. | 45000.00
 Chen Associates | Paul Cruz   | Chicago     | Riosta 1-Tm    | 31350.00
 Acme Mfg.       | Bill Adams  | Atlanta     | Extractor      | 27500.00
(4 rows)
```

Però en realitat per veure tots els cassos hauríem de fer un parell de OUTERs,
recordem que el segon si s'haguessin fet les coses bé en l'entrada de dades de
la Base de Dades no caldria. 

```sql
SELECT empresa, nom, ciutat, descripcio, import
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes
       ON clients.rep_clie = rep_vendes.num_empl

       LEFT JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina

       LEFT JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte
 WHERE import > 22000;
```

## Exercici 17

Trobar totes les comandes rebudes en els dies en que un nou venedor va ser
contractat. Per cada comanda mostrar un cop el número, import i data de la
comanda.

```sql
SELECT DISTINCT num_comanda, import, data
  FROM comandes
       JOIN rep_vendes
       ON comandes.data = rep_vendes.data_contracte;
```
```
 num_comanda |  import  |    data    
-------------+----------+------------
      112968 |  3978.00 | 1989-10-12
      112979 | 15000.00 | 1989-10-12
(2 rows)
```

## Exercici 18

Mostra el nom, les vendes dels treballadors que tenen assignada una oficina,
amb la ciutat i l'objectiu de l'oficina de cada venedor.


Ens diuen clarament _que tenen assignada una oficina_ per tant no n'hi haurà OUTER JOIN

```sql
SELECT nom, rep_vendes.vendes, ciutat, objectiu
  FROM rep_vendes
       JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina;
```

```
      nom      |  vendes   |   ciutat    | objectiu  
---------------+-----------+-------------+-----------
 Bill Adams    | 367911.00 | Atlanta     | 350000.00
 Mary Jones    | 392725.00 | New York    | 575000.00
 Sue Smith     | 474050.00 | Los Angeles | 725000.00
 Sam Clark     | 299912.00 | New York    | 575000.00
 Bob Smith     | 142594.00 | Chicago     | 800000.00
 Dan Roberts   | 305673.00 | Chicago     | 800000.00
 Larry Fitch   | 361865.00 | Los Angeles | 725000.00
 Paul Cruz     | 286775.00 | Chicago     | 800000.00
 Nancy Angelli | 186042.00 | Denver      | 300000.00
(9 rows)
```

## Exercici 19

Llista el nom de tots els venedors i el del seu cap en cas de tenir-ne. El camp
que conté el nom del treballador s'ha d'identificar com a _empleat_ i el camp
que conté el nom del cap amb _cap_.

```sql
SELECT empleats.nom AS empleat, caps.nom AS cap
  FROM rep_vendes AS empleats
       LEFT JOIN rep_vendes AS caps
       ON empleats.cap = caps.num_empl;
```
```
    empleat    |     cap     
---------------+-------------
 Bill Adams    | Bob Smith
 Mary Jones    | Sam Clark
 Sue Smith     | Larry Fitch
 Sam Clark     | 
 Bob Smith     | Sam Clark
 Dan Roberts   | Bob Smith
 Tom Snyder    | Dan Roberts
 Larry Fitch   | Sam Clark
 Paul Cruz     | Bob Smith
 Nancy Angelli | Larry Fitch
(10 rows)
```

## Exercici 20

Llista totes les combinacions possibles de venedors i ciutats.

```sql
SELECT nom, ciutat
  FROM rep_vendes, oficines;
```

Surten les 50 files 5 x 10 habituals.

o

```sql
SELECT nom, ciutat
  FROM rep_vendes
       CROSS JOIN oficines;
```

o

```sql
SELECT nom, ciutat
  FROM rep_vendes
       JOIN oficines
       ON 1=1;
```
en canvi, si fem aquesta:

```sql
SELECT nom, ciutat
  FROM rep_vendes
       JOIN oficines
       ON true;
```

Però aquesta darrera consulta no és SQL ANSI, podem comprovar-ho
[aquí](https://developer.mimer.com/sql-2016-validator/)

## Exercici 21

Per a cada venedor, mostrar el nom, les vendes i la ciutat de l'oficina en cas
de tenir-ne una d'assignada.

```sql
SELECT nom, rep_vendes.vendes, ciutat
  FROM rep_vendes
       LEFT JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina;
```
```
      nom      |  vendes   |   ciutat    
---------------+-----------+-------------
 Bill Adams    | 367911.00 | Atlanta
 Mary Jones    | 392725.00 | New York
 Sue Smith     | 474050.00 | Los Angeles
 Sam Clark     | 299912.00 | New York
 Bob Smith     | 142594.00 | Chicago
 Dan Roberts   | 305673.00 | Chicago
 Tom Snyder    |  75985.00 | 
 Larry Fitch   | 361865.00 | Los Angeles
 Paul Cruz     | 286775.00 | Chicago
 Nancy Angelli | 186042.00 | Denver
(10 rows)
```

Aquesta consulta es diferencia de la consulta 18 en el _LEFT_.

## Exercici 22

Mostra les comandes de productes que tenen un estoc inferior a 10.  Llistar el
numero de comanda, la data de la comanda, el nom del client que ha fet la
comanda, identificador del fabricant i l'identificador de producte de la
comanda.

```sql
SELECT num_comanda, data, empresa, id_fabricant, id_producte
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie
       
       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte
 WHERE estoc < 10;
```
```
 num_comanda |    data    |     empresa      | id_fabricant | id_producte 
-------------+------------+------------------+--------------+-------------
      113013 | 1990-01-14 | Midwest Systems  | bic          | 41003
      112997 | 1990-01-08 | Peter Brothers   | bic          | 41003
      113069 | 1990-03-02 | Chen Associates  | imm          | 775c 
      113048 | 1990-02-10 | Rico Enterprises | imm          | 779c 
      113003 | 1990-01-25 | Holm & Landis    | imm          | 779c 
(5 rows)
```

## Exercici 23

Llista les 5 comandes amb un import superior. Mostrar l'identificador de la
comanda, import de la comanda, preu del producte, nom del client, nom del
representant de vendes que va efectuar la comanda i ciutat de l'oficina, en cas
de tenir oficina assignada.

```sql
  SELECT num_comanda, import, preu, empresa, rep, ciutat
    FROM comandes
         JOIN clients
         ON comandes.clie = clients.num_clie

         LEFT JOIN productes
         ON comandes.fabricant = productes.id_fabricant
           AND comandes.producte = productes.id_producte

         LEFT JOIN rep_vendes
         ON comandes.rep = rep_vendes.num_empl

         LEFT JOIN oficines
         ON rep_vendes.oficina_rep = oficines.oficina
ORDER BY import DESC;
FETCH FIRST 3 ROWS ONLY;
```
```
 num_comanda |  import  |  preu   |     empresa     | rep |   ciutat    
-------------+----------+---------+-----------------+-----+-------------
      113045 | 45000.00 | 4500.00 | Zetacorp        | 108 | Los Angeles
      112961 | 31500.00 | 4500.00 | J.P. Sinclair   | 106 | New York
      113069 | 31350.00 | 1425.00 | Chen Associates | 107 | Denver
(3 rows)
```

## Exercici 24

Llista les comandes que han estat preses per un representant de vendes que no
és l'actual representant de vendes del client pel que s'ha realitzat la
comanda. Mostra el número de comanda, el nom del client, el nom de l'actual
representant de vendes del client com a "rep_client" i el nom del representant
de vendes que va realitzar la comanda com a "rep_comanda".

```sql
SELECT num_comanda, empresa, rep_vendes.nom AS rep_client, venedor_comanda.nom AS rep_comanda
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes
       ON rep_vendes.num_empl = clients.rep_clie

       JOIN rep_vendes AS venedor_comanda
       ON venedor_comanda.num_empl = comandes.rep 
 WHERE clients.rep_clie != comandes.rep;
```

```sql
 num_comanda |     empresa     | rep_client |  rep_comanda  
-------------+-----------------+------------+---------------
      113012 | JCP Inc.        | Paul Cruz  | Bill Adams
      113024 | Orion Corp      | Sue Smith  | Larry Fitch
      113069 | Chen Associates | Paul Cruz  | Nancy Angelli
      113055 | Holm & Landis   | Mary Jones | Dan Roberts
      113042 | Ian & Schmidt   | Bob Smith  | Dan Roberts
(5 rows)
```

Pregunta, solucionem la consulta amb els [INNER] JOIN o potser necessitem algun
LEFT o algun RIGHT?

En realitat hauríem de fer un cop d'ull a les taules i als possibles valors de
les columnes. I veuríem que la columna _rep_ de la taula _comandes_ pot ser
null. En efecte, si executem:

```sql
\d comandes
```

obtenim:

```sql
                   Table "public.comandes"
   Column    |     Type     | Collation | Nullable | Default 
-------------+--------------+-----------+----------+---------
 num_comanda | integer      |           | not null | 
 data        | date         |           | not null | 
 clie        | smallint     |           | not null | 
 rep         | smallint     |           |          | 
 fabricant   | character(3) |           | not null | 
 producte    | character(5) |           | not null | 
 quantitat   | smallint     |           | not null | 
 import      | numeric(7,2) |           | not null | 

```

La resta de camps que intervenen a la consulta, d'altres
taules també, tenen la condició `not null` i per tant no es pot donar aquest
cas. 

Però, com que la condició de reps diferents no la pot complir una comanda sense
venedor, no fem OUTERs.


## Exercici 25

Llista les comandes amb un import superior a 5000 i també aquelles comandes
realitzades per un client amb un crèdit inferior a 30000. Mostrar
l'identificador de la comanda, el nom del client i el nom del representant de
vendes que va prendre la comanda.

```sql
SELECT num_comanda, empresa, rep_vendes.nom 
  FROM comandes 
       JOIN clients
       ON comandes.clie = clients.num_clie 

       JOIN rep_vendes
       ON rep_vendes.num_empl = clients.rep_clie 

 WHERE comandes.import > 5000
       OR limit_credit < 30000; 
```



```sql
 num_comanda |      empresa      |     nom     
-------------+-------------------+-------------
      112961 | J.P. Sinclair     | Sam Clark
      110036 | Ace International | Tom Snyder
      113045 | Zetacorp          | Larry Fitch
      113024 | Orion Corp        | Sue Smith
      112979 | Orion Corp        | Sue Smith
      113069 | Chen Associates   | Paul Cruz
      113003 | Holm & Landis     | Mary Jones
      112987 | Acme Mfg.         | Bill Adams
      113042 | Ian & Schmidt     | Bob Smith
(9 rows)
```



---------------------------------------------------------------------------------


# CHEATSHEET KESHI [04]

# Funciones de grupo - Aggregate 

* TIPOS FUNCIONES

```sql
SELECT AVG(sal), MAX(sal), MIN(sal), SUM(sal) FROM emp WHERE Lower(job) = 'salesman';
```

* RETORNA EL NÚMERO DE FILAS DE UNA TABLA

```sql
SELECT COUNT(*) FROM emp;
```

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ways-to-count.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/example-baby-feedings.png)

* Las funciones de grupo ignoran los valores nulos.

```sql

```

**COALESCE** = Transforma los valores nulos - Falsea los datos.

```sql
SELECT AVG(coalesce(comm,0)) FROM emp;
```

**Creación de Grupos de Datos** **GROUP BY**

```sql
SELECT camp/s, funció_grup
FROM taula/es
[WHERE condició/ons]
[GROUP BY camp/s_d’agrupació]
[ORDER BY camp/s];
```

`Totes les columnes esmentades al SELECT que no són funcions de gruphan d’estar a la clàusula GROUP BY*`

```sql
SELECT deptno, AVG(sal)
FROM emp
GROUP BY deptno;
```

* Group By con múltiples columnas

```sql
SELECT deptno, job, sum(sal)
FROM emp
GROUP BY deptno, job;
```

`¿CORRECTO?`

```sql
SELECT deptno, COUNT(ename)
FROM emp;
```

`NO`

```sql
SELECT deptno, COUNT(ename)
FROM emp;

ERROR: column "emp.deptno" must appear in the
GROUP BY clause or be used in an aggregate function
LINE 1: SELECT deptno, COUNT(ename)
```

`Qualsevol columna o expressió en una consulta SELECT que no sigui una funció d’agrupació s’ha de escriure a la clàusula GROUP BY*`

```sql
SELECT deptno, COUNT(ename)
FROM emp
GROUP BY deptno;
```

**HAVING** = SE USA COMO WHERE EN LOS **GROUP BY**.

```sql
SELECT camp/s, funció_grup
FROM taul
[WHERE condició/ons]
[GROUP BY camps d’agrupació]
[HAVING condició de grup]
[ORDER BY camps];
```

* *S’agrupen les files segons el camp d’agrupació
* *S’aplica la funció d’agrupament
* *Es filtren les files resultants segons HAVING

```sql
SELECT deptno, avg(sal)
FROM emp
GROUP BY deptno
HAVING avg(sal) > 2900;
```


* Muestra Job, Suma el Salario, donde Job no empiece por SALES y la suma de salario sea mayor que 5000.

```sql
SELECT job, SUM(sal) AS "Suma de salaris"
FROM emp
WHERE job NOT LIKE 'SALES%'
GROUP BY job
HAVING SUM(sal) > 5000
ORDER BY SUM(sal);
```


----------------------------------------------------------------------------------

# Ejemplos y ejercicios PART1

# Consultes resum

## Exercici 0
En una mateixa consulta, calcula la suma de les quotes, quants venedors n'hi
ha, i finalment mostra la quota promig calculada a partir de les funcions
anteriors i també amb una funció especial per al promig. Compara aquests dos
últims resultats. Si volguéssim que la darrera funció actui com la penúltima
com ho faries?


```sql
SELECT SUM(quota), COUNT(*), SUM(quota) / COUNT(*) AS mitjana, AVG(quota)
  FROM rep_vendes;
``` 
```sql
    sum     | count |       mitjana       |         avg         
------------+-------+---------------------+---------------------
 2700000.00 |    10 | 270000.000000000000 | 300000.000000000000
(1 row)
```

**CAST** = Convert a value to an int datatype:

```sql
SELECT SUM(quota), COUNT(*), CAST( SUM(quota) / COUNT(*) as NUMERIC(8,2) )  AS mitjana, 
       CAST( AVG(quota) as NUMERIC(8,2) )
 FROM rep_vendes;
```

Depenent del que vulguem ens convindrà més una o altra. Però responent a la pregunta plantejada:

```sql
SELECT CAST( SUM(quota) / COUNT(*) as NUMERIC(8,2) )  AS mitjana, CAST( AVG(COALESCE(quota,0)) as NUMERIC(8,2) )
 FROM rep_vendes; 
```

```sql
  mitjana  |    avg    
-----------+-----------
 270000.00 | 270000.20
(1 row)
```

Nota: no posem COALESCE a la funció d'agrupament SUM ja que no influiria en el
resultat, ja és el que fa SUM.


## Exercici 1
Quina és la quota promig mostrada com a "prom_quota" i la venda promig
mostrades com a "prom_vendes" dels venedors?

```sql
SELECT AVG(quota) AS prom_vendes, AVG(vendes) AS prom_vendes
FROM rep_vendes;
```

## Exercici 2
Quin és el promig del rendiment dels venedors (promig del percentatge de les vendes
respecte la quota)?

```sql
SELECT CAST( 100 * AVG( vendes / quota ) AS NUMERIC(5,2) )
  FROM rep_vendes;
```
```
 numeric 
---------
  102.60
(1 row)
```

### Nota 1 
Si deixem el 100 fora del `CAST` perdem alguns decimals i el resultat és menys exacte.

### Nota 2

Fixem-nos que hi ha un quocient que es descarta perquè no hi ha quota:

En efecte el quocient de Tom Snyder, l'únic venedor que no té quota no entra:

```sql
SELECT CAST( 100 * AVG( vendes / quota ) AS NUMERIC(5,2) )
  FROM rep_vendes
 WHERE quota IS NOT NULL;
```
dona el mateix resultat
```sql
 numeric
---------
  102.60
(1 row)
```

Ens podria interessar fer el següent:

Volem calcular la mitjana dels quocients vendes / quota i quan ens trobem un
venedor sense quota li assignarem un valor, quin valor li podríem assignar?


Una possibilitat podria ser _La mitjana de les quotes_

De manera que tindríem que la consulta la podríem calcular de la següent manera:


```sql
SELECT CAST(100 * AVG( vendes / COALESCE( quota, AVG(quota) )) AS NUMERIC(5,2))
  FROM rep_vendes; 
```

Però tenim un problema, PostgreSQL no admet funcions d'agrupació niuades.

`ERROR:  aggregate function calls cannot be nested`

De manera que s'hauria de resoldre amb una subconsulta. Com encara no sabem
fer-les, no podrem escriure una cosa com aquesta:

```sql
SELECT CAST(100 * AVG( vendes / COALESCE( quota, 
       ( SELECT AVG(quota) from rep_vendes AS taula ) )) AS NUMERIC(5,2))
  FROM rep_vendes; 
```
```
 numeric 
---------
   94.87
(1 row)
```

Tot i que no entenguem encara com s'ha resolt aquesta darrera consulta. Ens
sembla raonable aquesta baixada del 102.60 % al 94.87% ?


## Exercici 3

Quines són les quotes totals com a *t_quota* i vendes totals com a *t_vendes*
de tots els venedors?

```sql
SELECT SUM(quota) AS t_quota, SUM(vendes) AS t_vendes
  FROM rep_vendes;
```
```sql
  t_quota   |  t_vendes  
------------+------------
 2700000.00 | 2893532.00
(1 row)
```

## Exercici 4
Calcula el preu mig dels productes del fabricant amb identificador "aci".

```sql
SELECT CAST(AVG(preu) AS NUMERIC(6,2) ) AS preu_mig_aci
  FROM productes
 WHERE id_fabricant = 'aci';
```
```sql
 preu_mig_aci 
--------------
       804.29
(1 row)
```

## Exercici 5
Quines són les quotes assignades mínima i màxima?

```sql
SELECT MIN(quota), MAX(quota)
  FROM rep_vendes;
```
```sql
    min    |    max    
-----------+-----------
 200000.00 | 350000.00
(1 row)
```


## Exercici 6
Quina és la data de comanda més antiga?

```sql
SELECT MIN(data)
  FROM comandes;
```

``` sql
    min     
------------
 1989-01-04
(1 row)
```

## Exercici 7
Quin és el major percentatge de rendiment de vendes respecte les quotes de tots els venedors?
(o sigui el major percentatge de les vendes respecte a la quota)


```sql
SELECT ROUND(MAX(100 * vendes / quota),2)
  FROM rep_vendes;
```
o
```sql
SELECT  CAST(100 * MAX( vendes / quota ) AS NUMERIC(5,2))
  FROM rep_vendes;
```

```sql
 numeric 
---------
  135.44
(1 row)
```

### Nota 1:

Si fem el mateix que a l'exercici 2 veiem que amb el màxim no canvia res.
```sql
SELECT  CAST( 100 * MAX( vendes / COALESCE( quota,
       ( SELECT AVG(quota) from rep_vendes AS taula ) )) AS NUMERIC(5,2))
  FROM rep_vendes;
```
```sql
 numeric 
---------
  135.44
(1 row)
```

Però què passa si calculem el mínim?

El mínim:

```sql
SELECT  CAST(100 * MIN( vendes / quota ) AS NUMERIC(5,2))
  FROM rep_vendes;
```
ens dona:

```sql
 numeric 
---------
   62.01
(1 row)
```



Ara al afegir el quocient de Tom Snyder (recordem que li posem com a quota la
mitjana de la resta de venedors)

```sql
SELECT  CAST( 100 * MIN( vendes / COALESCE( quota,
       ( SELECT AVG(quota) from rep_vendes AS taula ) )) AS NUMERIC(5,2))
  FROM rep_vendes;
```

Ens dona:

```sql
 numeric 
---------
   25.33
(1 row)
```

que es el quocient que obtenim de dividir les vendes de Tom Snyder per la quota
_mitjana de la resta de treballadors_.


## Exercici 8
Quants clients hi ha?

```sql
SELECT COUNT(*)  AS nombre_clients
FROM clients;
```
```sql
 nombre_clients 
----------------
             21
(1 row)

```


## Exercici 9
Quants venedors superen la seva quota?

```sql
SELECT COUNT(*) AS venedors_superen_quota
  FROM rep_vendes 
 WHERE vendes > quota;
```
```sql
 venedors_superen_quota 
------------------------
                      7
(1 row)
```

## Exercici 10
Quantes comandes amb un import superior a 25000 hi ha en els registres?

```sql
SELECT COUNT(*) AS "import comandes > 25000"
  FROM comandes 
 WHERE import > 25000;
```
```sql
 import comandes > 25000 
--------------------------
                        5
(1 row)
```


## Exercici 11

Trobar l'import mitjà de les comandes, l'import total de les
comandes, la mitjana del percentatge de l'import mitjà de les comandes respecte
del límit de crèdit del client i la mitjana del percentatge de l'import mitjà
de comandes respecte a la quota del venedor.

```sql
SELECT ROUND(AVG(import),2) AS import_mitja, ROUND(SUM(import),2) AS import_total,
       ROUND(AVG(100 * import / limit_credit),2) AS "mitjana import/credit",
       ROUND(AVG(100 * import / quota),2) AS "mitjana import/quota"
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes
       ON comandes.rep = rep_vendes.num_empl;
```
```sql
 import_mitja | import_total | mitjana import/credit | mitjana import/quota 
--------------+--------------+-----------------------+----------------------
      8256.37 |    247691.00 |                 24.45 |                 2.51
(1 row)

```

## Exercici 12
Compta les files que hi ha a repventas, les files del camp vendes i les del camp quota.

```sql
SELECT COUNT(*), COUNT(vendes), COUNT(quota)
  FROM rep_vendes;
```
```sql
 count | count | count 
-------+-------+-------
    10 |    10 |     9
(1 row)
```

## Exercici 13

Demostra que la suma de restar vendes menys quota és diferent que sumar vendes i restar-li la suma de quotes.

```sql
SELECT SUM(vendes - quota) AS "SUM(vendes-quota)",
       SUM(vendes) - SUM(quota) AS "SUM(vendes) - SUM(quota)" 
  FROM rep_vendes;
```
```sql
 SUM(vendes-quota) | SUM(vendes) - SUM(quota) 
-------------------+--------------------------
         117547.00 |                193532.00
(1 row)
```
La diferència ve donada pel valor NULL a la quota que fa que la resta de Tom Snyder (75985.00 - NULL) no es faci, en canvi quan es suma primer tots els valors de vendes aquest 75985 sí que es suma.

Si volguéssim obtenir el mateix valor ho podríem solucionar amb un _coalesce_:

```sql
SELECT SUM(vendes - COALESCE(quota,0)) AS "SUM(vendes-quota)",
       SUM(vendes) - SUM(quota) AS "SUM(vendes) - SUM(quota)"
  FROM rep_vendes;
```
```sql
 SUM(vendes-quota) | SUM(vendes) - SUM(quota) 
-------------------+--------------------------
         193532.00 |                193532.00
(1 row)
```

## Exercici 14
Quants tipus de càrrecs hi ha de venedors?

```sql
SELECT COUNT(DISTINCT carrec)
FROM repventas;
```
```sql
 count 
-------
     3
(1 row)
```


## Exercici 15

Quantes oficines de vendes tenen venedors que superen les seves quotes?

```sql
SELECT COUNT(DISTINCT oficina_rep) AS "oficines amb grans venedors"
  FROM rep_vendes
 WHERE vendes > quota;
```

```sql
 oficines amb grans venedors 
-----------------------------
                           4
(1 row)
```

## Exercici 16
De la taula clients quants clients diferents i venedors diferents hi ha.

```sql
SELECT COUNT(num_clie) AS "total clients", COUNT(DISTINCT rep_clie) AS "total venedors"  
  FROM clients;
```
```sql
 total clients | total venedors 
---------------+----------------
            21 |             10
(1 row)
```



## Exercici 17
De la taula comandes seleccionar quantes comandes diferents i clients diferents hi ha

```sql
SELECT COUNT(num_comanda)  AS "total comandes", COUNT(DISTINCT clie) AS "total clients"
  FROM comandes;
```
```sql
 total comandes | total clients 
----------------+---------------
             31 |            15
(1 row)
```

## Exercici 18
Calcular la mitjana dels imports de les comandes.

Ja fet(11)

```sql
SELECT AVG(import) 
  FROM comandes;
```

## Exercici 19
Calcula la mitjana de l'import d'una comanda realitzada pel client amb nom d'empresa "Acme Mfg."

```sql
SELECT ROUND(AVG(import),2) AS "import mitjà Acme" 
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie
 WHERE empresa = 'Acme Mfg.';
```

```sql
 import mitjà Acme 
-------------------
           8895.50
(1 row)
```


----------------------------------------------------------------------------------

# EJERCICIOS - PART 2



# Consultes resum

## Exercici 20

Quina és l'import promig de les comandes de cada venedor?

```sql
  SELECT rep, ROUND(AVG(import),2) AS promig_comandes
    FROM comandes
GROUP BY rep
ORDER BY rep;
```
```sql
 rep | promig_comandes 
-----+-----------------
 101 |         8876.00
 102 |         5694.00
 103 |         1350.00
 105 |         7865.40
 106 |        16479.00
 107 |        11477.33
 108 |         8376.14
 109 |         3552.50
 110 |        11566.00
     |        18000.00 <- comanda afegida extra (la del vi¹)
(10 rows)
```

Però si volguéssim els noms necessitaríem un JOIN:

```sql
  SELECT nom, ROUND(AVG(import),2) AS promig_comandes
    FROM comandes
         JOIN rep_vendes
         ON comandes.rep = rep_vendes.num_empl
GROUP BY nom
ORDER BY promig_comandes;
```

```sql
      nom      | promig_comandes 
---------------+-----------------
 Larry Fitch   |         8376.14
 Sue Smith     |         5694.00
 Tom Snyder    |        11566.00
 Nancy Angelli |        11477.33
 Mary Jones    |         3552.50
 Bill Adams    |         7865.40
 Dan Roberts   |         8876.00
 Sam Clark     |        16479.00
 Paul Cruz     |         1350.00
(9 rows)
```

El problema és que podria haver-hi comandes amb venedors NULL, el grup dels venedors NULL i no sortirien aqui.

La solució passa per fer un LEFT JOIN: 

```sql
  SELECT nom, ROUND(AVG(import),2) AS promig_comandes
    FROM comandes
         LEFT JOIN rep_vendes
         ON comandes.rep = rep_vendes.num_empl
GROUP BY nom
ORDER BY promig_comandes;
```

## Exercici 21

Quin és el rang (màxim i mínim) de quotes dels venedors per cada oficina?

```sql
  SELECT oficina_rep, MAX(quota) AS max_quota, MIN(quota) AS MIN_quota
    FROM rep_vendes
   WHERE oficina_rep IS NOT NULL
GROUP BY oficina_rep
ORDER BY oficina_rep;
```
```sql
 oficina_rep | max_quota | min_quota 
-------------+-----------+-----------
          11 | 300000.00 | 275000.00
          12 | 300000.00 | 200000.00
          13 | 350000.00 | 350000.00
          21 | 350000.00 | 350000.00
          22 | 300000.00 | 300000.00
(5 rows)
```

## Exercici 22

Quants venedors estan asignats a cada oficina?

```sql
  SELECT oficina_rep, count(num_empl)
    FROM rep_vendes
GROUP BY oficina_rep
ORDER BY oficina_rep;
```
```sql
 oficina_rep | count 
-------------+-------
             |     1
          22 |     1
          11 |     2
          21 |     2
          13 |     1
          12 |     3
(6 rows)
```

Fixem-nos que també ens compten aquells camps nuls. En principi això pot ser
interessant, ja que també ens informa de quants vendors no tenen oficina
assignada.

Però si se'ns digués explícitament que només volem l'informació de les oficines
assignades, llavors la consulta seria:

```sql
  SELECT oficina_rep, count(num_empl)
    FROM rep_vendes
   WHERE oficina_rep IS NOT NULL        
GROUP BY oficina_rep;
```

## Exercici 23

Per cada venedor calcular quants clients diferents ha atès ( atès = atendre una comanda)?

```sql
  SELECT rep, COUNT(DISTINCT clie)
    FROM comandes
GROUP BY rep
ORDER BY rep;
```
```sql
 rep | count 
-----+-------
 101 |     3
 102 |     3
 103 |     1
 105 |     2
 106 |     2
 107 |     2
 108 |     3
 109 |     1
 110 |     1
     |     1
(10 rows)
```

## Exercici 24

Calcula el total dels imports de les comandes fetes per cada client a cada vendedor.

```sql
SELECT clie, rep, SUM(import) AS total_import
  FROM comandes
 GROUP BY clie, rep;
```

```sql
 clie | rep | total_import 
------+-----+--------------
 2113 | 101 |     22500.00
 2107 | 110 |     23132.00
 2103 | 105 |     35582.00
 2120 | 102 |      3750.00
 2106 | 102 |      4026.00
 2112 | 108 |     47925.00
 2117 | 106 |     31500.00
 2118 | 108 |      3608.00
 2108 | 101 |       150.00
 2111 | 105 |      3745.00
 2114 | 108 |      7100.00
 2102 | 101 |      3978.00
 2111 | 103 |      2700.00
 2109 | 107 |     31350.00
 2114 | 102 |     15000.00
 2101 | 106 |      1458.00
 2124 | 107 |      3082.00
 2108 | 109 |      7105.00
(18 rows)
```

Tot i que a la taula comandes ara mateix no hi ha cap comanda amb el camp rep
NULL ho podria haver en un futur ja que no tenim cap restricció que ho
impedeixi. Si no volem que surtin aquestes comandes amb el camp rep NULL, com
sempre:

```sql
SELECT clie, rep, SUM(import) AS total_import
  FROM comandes
 WHERE rep IS NOT NULL
 GROUP BY clie, rep;
```

## Exercici 25

El mateix que a la qüestió anterior, però ordenat per client i dintre de client per venedor.

```sql
SELECT clie, rep, SUM(import) AS total_import
  FROM comandes
 GROUP BY clie, rep
 ORDER BY clie, rep;
``` 
```sql
 clie | rep | total_import 
------+-----+--------------
 2101 | 106 |      1458.00
 2102 | 101 |      3978.00
 2103 | 105 |     35582.00
 2106 | 102 |      4026.00
 2107 | 110 |     23132.00
 2108 | 101 |       150.00
 2108 | 109 |      7105.00
 2109 | 107 |     31350.00
 2111 | 103 |      2700.00
 2111 | 105 |      3745.00
 2112 | 108 |     47925.00
 2113 | 101 |     22500.00
 2114 | 102 |     15000.00
 2114 | 108 |      7100.00
 2117 | 106 |     31500.00
 2118 | 108 |      3608.00
 2120 | 102 |      3750.00
 2124 | 107 |      3082.00
(18 rows)
```

## Exercici 26

Calcula les comandes totals per a cada venedor.


Si el que ens estan preguntant és el número total de comandes que ha fet cada
venedor:

```sql
  SELECT rep, COUNT(*)
    FROM comandes
   WHERE rep IS NOT NULL
GROUP BY rep;
```
```sql
 rep | count 
-----+-------
 101 |     3
 108 |     7
 103 |     2
 105 |     5
 107 |     3
 102 |     4
 109 |     2
 106 |     2
 110 |     2
(9 rows)
```

Si ens demanen pel total de l'import de les comandes de cada venedor:


```sql
  SELECT rep, SUM(import)
    FROM comandes
   WHERE rep IS NOT NULL
GROUP BY rep;
```

```sql
 rep |   sum    
-----+----------
 101 | 26628.00
 108 | 58633.00
 103 |  2700.00
 105 | 39327.00
 107 | 34432.00
 102 | 22776.00
 109 |  7105.00
 106 | 32958.00
 110 | 23132.00
(9 rows)
```

Si volem que surti el NULL eliminem la clàusula WHERE.


## Exercici 27

Quin és l'import promig de les comandes per cada venedor, les comandes dels
quals sumen més de 30000?

```sql
  SELECT rep, round(AVG(import),2) AS "import promig"
    FROM comandes 
GROUP BY rep
  HAVING SUM(import) > 30000;
```
```sql
 rep | import promig 
-----+---------------
 108 |       8376.14
 105 |       7865.40
 107 |      11477.33
 106 |      16479.00
(4 rows)
```

## Exercici 28

Per cada oficina amb dos o més empleats, calcular la quota total i les vendes
totals per a tots els venedors que treballen a la oficina (volem mostrar la
ciutat de l'oficina a la consulta)

```sql
  SELECT ciutat, oficina_rep, SUM(quota) AS "suma quotes", SUM(rep_vendes.vendes) AS "suma de vendes"
    FROM rep_vendes
         JOIN oficines
         ON rep_vendes.oficina_rep = oficines.oficina
GROUP BY oficina_rep, ciutat
  HAVING COUNT(*) >= 2;
```

```sql
   ciutat    | oficina_rep | suma quotes | suma de vendes 
-------------+-------------+-------------+----------------
 Los Angeles |          21 |   700000.00 |      835915.00
 Chicago     |          12 |   775000.00 |      735042.00
 New York    |          11 |   575000.00 |      692637.00
(3 rows)
```

Si tenim la garantia de que el camp ciutat serà sempre únic, podríem fer `GROUP
BY ciutat` sempre que no necessitem mostrar a la selecció de columnes el número
d'oficina.


## Exercici 29

Mostra el preu, l'estoc i la quantitat total de les comandes de cada producte
per als quals la quantitat total demanada està per sobre del 75% de l'estoc.

ALERTA amb el tema de que totes les columnes que surten al SELECT han de sortir al GROUP BY. No és cert, si són columnes que tenen el mateix valor al fer el GROUP BY no cal.

```sql
SELECT id_fabricant, id_producte, preu, estoc, SUM(quantitat) AS suma_quantitat
  FROM comandes
       JOIN productes
       ON fabricant = id_fabricant
         AND producte = id_producte
 GROUP BY id_fabricant, id_producte
HAVING SUM(quantitat) > 75 * estoc / 100;
```

```sql
 id_fabricant | id_producte |  preu   | estoc | suma_quantitat 
--------------+-------------+---------+-------+----------------
 aci          | 4100x       |   25.00 |    37 |             30
 fea          | 114         |  243.00 |    15 |             16
 imm          | 775c        | 1425.00 |     5 |             22
 rei          | 2a44r       | 4500.00 |    12 |             15
(4 rows)
```

Aquesta possibilitat, no posar columnes que depenen funcionalment de la que
surt al group by, és una feature.

Què vol dir dependència funcional o funcionalment dependent?

Direm que _edat_ és **funcionalment dependent** de _num_empl_ perquè en el
moment que ens diguin quin és el valor de _num_empl_ automàticament sabem quin
és el valor de _edat_ 


Les preguntes serien

+ És _preu_ funcionalment dependent de *id_fabricant* i *id_producte* ?
+ I estoc?
+ I desripció?
+ I quantitat?



Executem aquesta instrucció:

```sql
SELECT *                       
  FROM comandes
       JOIN productes
       ON fabricant = id_fabricant
         AND producte = id_producte
 ORDER BY id_fabricant, id_producte; 
```

Mirem com son els camps en funció del _producte_ (recordem que un producte
queda determinat per 2 camps)

Veiem per tant que les files que tenen la mateixa "clau primària" per al producte tenen els mateixos valors en els camps que són dependents funcionalment (preu, descripció, estoc). 



## Exercici 30

Es desitja un llistat d'identificadors de fabricants de productes. Només volem tenir en compte els productes de preu superior a 54. Només volem que apareguin els fabricants amb un nombre total d'unitats superior a 300.

Anem a pams (Slow motion):
```sql
SELECT id_fabricant, estoc			SELECT id_fabricant, SUM(estoc) AS suma_estoc
  FROM productes 				  FROM productes
 ORDER BY id_fabricant;				 GROUP BY id_fabricant
					 	 ORDER BY id_fabricant;
```

Ens mostren respectivament:				

```sql
 id_fabricant | estoc				 id_fabricant | suma_estoc	
--------------+-------				--------------+------------
 aci          |    37					      | 
 aci          |   207					      |		
 aci          |   139					      |
 aci          |    25					      |
 aci          |   277					      |
 aci          |    28		 suma			      |
 aci          |   167		=====>		 aci          |        880
 
 bic          |     0					      |
 bic          |    78		 suma			      |
 bic          |     3		=====>		 bic          |         81       

 fea          |    15		 suma			      |         
 fea          |   115		=====>		 fea          |        130        

 imm          |    28            
 imm          |    24           
 imm          |   223           
 imm          |    32           
 imm          |     9  		 suma               
 imm          |     5   	=====>		 imm          |        321

 qsa          |    37
 qsa          |    38    	 suma
 qsa          |   203   	=====>		 qsa          |        278 

 rei          |    14
 rei          |    12
 rei          |    12    	 suma 
 rei          |   210   	=====>		 rei          |        248
(25 rows)
```

Si ara ens diuen que només volem els productes de preu superior a 54, les 2 consultes serien:


```sql
SELECT id_fabricant, estoc			SELECT id_fabricant, SUM(estoc) AS suma_estoc
  FROM productes				  FROM productes
 ORDER BY id_fabricant;				 WHERE preu > 54
						 GROUP BY id_fabricant
						 ORDER BY id_fabricant;
```

```sql
 id_fabricant | estoc |  preu                              id_fabricant | suma_estoc
--------------+-------+---------                          --------------+------------
 aci          | 🚫 37 |   25.00 <-                                      |
 aci          |   207 |  107.00                                         |
 aci          |   139 |  117.00                                         |
 aci          |    25 | 2750.00                                         |
 aci          |   277 |   55.00                                         |
 aci          |    28 | 2500.00            suma                         |
 aci          |   167 |   76.00           =====>           aci          |        843
                                
 bic          |     0 |  180.00                                         |
 bic          |    78 |  225.00            suma                         |
 bic          |     3 |  652.00           =====>           bic          |         81
                                
 fea          |    15 |  243.00            suma                         |
 fea          |   115 |  148.00           =====>           fea          |        130
                                
 imm          |    28 |  975.00                                         | 
 imm          |    24 |  250.00                                         | 
 imm          |🚫 223 |   54.00 <-                                      | 
 imm          |    32 |  475.00                                         | 
 imm          |     9 | 1875.00            suma                         | 
 imm          |     5 | 1425.00           =====>           imm          |         98
                                
 qsa          |    37 |  117.00                                         | 
 qsa          |    38 |  355.00            suma                         | 
 qsa          |   203 |  134.00           =====>           qsa          |        278
                                
 rei          |    14 |  350.00                                         | 	
 rei          |    12 | 4500.00                                         | 
 rei          |    12 | 4500.00            suma                         | 
 rei          |   210 |   79.00           =====>           rei          |        248
(25 rows)
```


Ens quedem amb la taula resultant: 


```sql
 id_fabricant | suma_estoc 
--------------+------------
 aci          |        843
 bic          |         81
 fea          |        130
 imm          |         98
 qsa          |        278
 rei          |        248
```


Si només volem aquelles que tinguin una suma d'estoc superior a 300 

```sql
SELECT id_fabricant, SUM(estoc) AS suma_estoc
  FROM productes
 WHERE preu > 54
 GROUP BY id_fabricant
HAVING SUM(estoc) > 300;
```

```sql
 id_fabricant | suma_estoc 
--------------+------------
 aci          |        843
(1 row)
```




## Exercici 31

Es desitja un llistat dels productes amb les seves descripcions, ordenat per la
suma total d'imports facturats (comandes) de cada producte de l'any 1989.

```sql
SELECT id_fabricant, id_producte, descripcio, SUM(import)
  FROM productes
       JOIN comandes
       ON id_fabricant = fabricant
         AND id_producte = producte
 WHERE date_part('year', data) = 1989
 GROUP BY id_fabricant, id_producte
 ORDER BY SUM(import);
```
```sql
 id_fabricant | id_producte |     descripcio     |   sum    
--------------+-------------+--------------------+----------
 aci          | 41002       | Article Tipus 2    |   760.00
 rei          | 2a45c       | V Stago Trinquet   |  1896.00
 rei          | 2a44g       | Passador Frontissa |  2100.00
 aci          | 41004       | Article Tipus 4    |  7956.00
 aci          | 4100z       | Muntador           | 15000.00
 aci          | 4100y       | Extractor          | 27500.00
 rei          | 2a44l       | Frontissa Esq.     | 31500.00
(7 rows)
```


## Exercici 32

Per a cada director (de personal, no d'oficina) excepte per al gerent (el venedor que no té director), vull saber el total de vendes dels seus subordinats. Mostreu codi i nom dels directors.


Podem primer mostrar tots els camps sense agrupar, amb el JOIN:

```sql
SELECT *                                         
  FROM rep_vendes AS venedors
       JOIN rep_vendes AS caps
       ON venedors.cap = caps.num_empl
 ORDER BY caps.num_empl;
```

Executeu la consulta anterior i fixem-nos en els camps en funció del director
del venedor.




Resolem la consulta sense fer l'excepció (la del gerent):

```sql
SELECT caps.num_empl, caps.nom, SUM(venedors.vendes)
  FROM rep_vendes AS venedors
       JOIN rep_vendes AS caps
       ON venedors.cap = caps.num_empl
 GROUP BY caps.num_empl
 ORDER BY caps.num_empl;
```


Finalment imposem que el cap dels venedors tingui al seu torn cap:

```sql
SELECT caps.num_empl, caps.nom, SUM(venedors.vendes)
  FROM rep_vendes AS venedors
       JOIN rep_vendes AS caps
       ON venedors.cap = caps.num_empl
 WHERE caps.cap IS NOT NULL
 GROUP BY caps.num_empl
 ORDER BY caps.num_empl;
```


## Exercici 33

Quins són els 5 productes que han estat venuts a més clients diferents? Mostreu
el número de clients per cada producte. A igualtat de nombre de clients es
volen ordenats per ordre decreixent d'estoc i, a igualtat d'estoc, per
descripció. Mostreu tots els camps pels quals s'ordena.

```sql
SELECT fab, producto, descripcion, existencias, COUNT(DISTINCT clie)
FROM pedidos
JOIN productos ON producto = id_producto AND fab = id_fab
GROUP BY id_fab, id_producto, fab, producto
ORDER BY COUNT(DISTINCT clie) DESC, existencias DESC, descripcion
LIMIT 5;
```

```sql
SELECT id_fabricant, id_producte, estoc, descripcio,  COUNT(DISTINCT clie) AS clients_p_producte
  FROM productes
       JOIN comandes
       ON productes.id_fabricant = fabricant
         AND id_producte = producte
 GROUP BY id_fabricant, id_producte
ORDER BY clients_p_producte DESC, estoc DESC, descripcio
FETCH FIRST 5 ROWS ONLY;
```

```sql
 id_fabricant | id_producte | estoc |    descripcio    | clients_p_producte 
--------------+-------------+-------+------------------+--------------------
 qsa          | xk47        |    38 | Reductor         |                  3
 rei          | 2a45c       |   210 | V Stago Trinquet |                  2
 aci          | 41002       |   167 | Article Tipus 2  |                  2
 aci          | 41004       |   139 | Article Tipus 4  |                  2
 aci          | 4100x       |    37 | Peu de rei       |                  2
(5 rows)
```

## Exercici 34

Es vol llistar el clients (codi i empresa) tals que no hagin comprat cap tipus
de Frontissa (figura a la descripció) i hagin comprat articles de més d'un
fabricant diferent


Una solució que utilitza una feature no estàndard (descobreix quina és)

```sql
SELECT num_clie, empresa 
  FROM comandes
       JOIN productes
       ON id_fabricant = fabricant
         AND id_producte = producte
       JOIN clients
       ON clie = num_clie
 WHERE descripcio NOT LIKE 'Frontissa%'
 GROUP BY num_clie
HAVING COUNT( DISTINCT (fabricant, producte)) > 1
ORDER BY num_clie;
```
o

```sql
SELECT num_clie, empresa
  FROM comandes
       JOIN productes
       ON id_fabricant = fabricant
         AND id_producte = producte
       JOIN clients
       ON clie = num_clie
 WHERE descripcio NOT LIKE 'Frontissa%'
 GROUP BY num_clie
HAVING COUNT( DISTINCT fabricant|| producte)) > 1
ORDER BY num_clie;
```



## Exercici 35

Llisteu les oficines per ordre descendent de nombre total de clients diferents
amb comandes realitzades pels venedors d'aquella oficina, i, a igualtat de
clients, ordenat per ordre ascendent del nom del director de l'oficina. Només
s'ha de mostrar el codi i la ciutat de l'oficina.



Llistem les oficines amb els seus venedors, comandes de les quals s'han
encarregat aquests venedors i clients que han fet aquestes comandes


```sql
SELECT oficina, ciutat, num_empl, nom, num_comanda, num_clie, empresa
  FROM oficines
       JOIN rep_vendes
       ON oficina = oficina_rep

       JOIN comandes
       ON num_empl = rep

       JOIN clients
       ON clie = num_clie
 ORDER BY ciutat;
```

```sql
 oficina |   ciutat    | num_empl |      nom      | num_comanda | num_clie |     empresa      
---------+-------------+----------+---------------+-------------+----------+------------------
      13 | Atlanta     |      105 | Bill Adams    |      112983 |     2103 | Acme Mfg.
      13 | Atlanta     |      105 | Bill Adams    |      112963 |     2103 | Acme Mfg.
      13 | Atlanta     |      105 | Bill Adams    |      112987 |     2103 | Acme Mfg.
      13 | Atlanta     |      105 | Bill Adams    |      113027 |     2103 | Acme Mfg.
      13 | Atlanta     |      105 | Bill Adams    |      113012 |     2111 | JCP Inc.
      12 | Chicago     |      101 | Dan Roberts   |      113042 |     2113 | Ian & Schmidt
      12 | Chicago     |      101 | Dan Roberts   |      112968 |     2102 | First Corp.
      12 | Chicago     |      103 | Paul Cruz     |      112975 |     2111 | JCP Inc.
      12 | Chicago     |      101 | Dan Roberts   |      113055 |     2108 | Holm & Landis
      12 | Chicago     |      103 | Paul Cruz     |      113057 |     2111 | JCP Inc.
      22 | Denver      |      107 | Nancy Angelli |      113069 |     2109 | Chen Associates
      22 | Denver      |      107 | Nancy Angelli |      113062 |     2124 | Peter Brothers
      22 | Denver      |      107 | Nancy Angelli |      112997 |     2124 | Peter Brothers
      21 | Los Angeles |      108 | Larry Fitch   |      113051 |     2118 | Midwest Systems
      21 | Los Angeles |      108 | Larry Fitch   |      113007 |     2112 | Zetacorp
      21 | Los Angeles |      108 | Larry Fitch   |      112992 |     2118 | Midwest Systems
      21 | Los Angeles |      108 | Larry Fitch   |      113045 |     2112 | Zetacorp
      21 | Los Angeles |      108 | Larry Fitch   |      113024 |     2114 | Orion Corp
      21 | Los Angeles |      102 | Sue Smith     |      112979 |     2114 | Orion Corp
      21 | Los Angeles |      102 | Sue Smith     |      112993 |     2106 | Fred Lewis Corp.
      21 | Los Angeles |      102 | Sue Smith     |      113065 |     2106 | Fred Lewis Corp.
      21 | Los Angeles |      108 | Larry Fitch   |      113049 |     2118 | Midwest Systems
      21 | Los Angeles |      108 | Larry Fitch   |      113013 |     2118 | Midwest Systems
      21 | Los Angeles |      102 | Sue Smith     |      113048 |     2120 | Rico Enterprises
      11 | New York    |      106 | Sam Clark     |      112961 |     2117 | J.P. Sinclair
      11 | New York    |      109 | Mary Jones    |      113003 |     2108 | Holm & Landis
      11 | New York    |      109 | Mary Jones    |      113058 |     2108 | Holm & Landis
      11 | New York    |      106 | Sam Clark     |      112989 |     2101 | Jones Mfg.
(28 rows)
```

Per a cada oficina comptem el nombre de clients diferents que els han fet comandes 

```sql
SELECT oficina, ciutat, COUNT(DISTINCT num_clie)
  FROM oficines
       JOIN rep_vendes
       ON oficina = oficina_rep

       JOIN comandes
       ON num_empl = rep

       JOIN clients
       ON clie = num_clie
 GROUP BY oficina;
```

```sql
 oficina |   ciutat    | count 
---------+-------------+-------
      11 | New York    |     3
      12 | Chicago     |     4
      13 | Atlanta     |     2
      21 | Los Angeles |     5
      22 | Denver      |     2
(5 rows)
```


Ordenem descendentment per aquest últim camp

```sql
SELECT oficina, ciutat, COUNT(DISTINCT num_clie)
  FROM oficines
       JOIN rep_vendes
       ON oficina = oficina_rep

       JOIN comandes
       ON num_empl = rep

       JOIN clients
       ON clie = num_clie
 GROUP BY oficina
 ORDER BY COUNT(DISTINCT num_clie) DESC;
```

```sql
 oficina |   ciutat    | count 
---------+-------------+-------
      21 | Los Angeles |     5
      12 | Chicago     |     4
      11 | New York    |     3
      13 | Atlanta     |     2
      22 | Denver      |     2
(5 rows)
```


Afegim el nom dels directors de les oficines, fent un JOIN extra de la taula repventas

```sql
SELECT oficina, ciutat, COUNT(DISTINCT num_clie), caps.nom
  FROM oficines
       JOIN rep_vendes
       ON oficina = oficina_rep

       JOIN comandes
       ON num_empl = rep

       JOIN clients
       ON clie = num_clie

       JOIN rep_vendes AS caps
       ON rep_vendes.cap = caps.num_empl

 GROUP BY oficina, caps.nom
 ORDER BY COUNT(DISTINCT num_clie) DESC;
```

```sql
 oficina |   ciutat    | count |     nom     
---------+-------------+-------+-------------
      12 | Chicago     |     4 | Bob Smith
      21 | Los Angeles |     3 | Larry Fitch
      21 | Los Angeles |     3 | Sam Clark
      13 | Atlanta     |     2 | Bob Smith
      22 | Denver      |     2 | Larry Fitch
      11 | New York    |     1 | Sam Clark
(6 rows)
```

Afegim a l'ordenació aquest últim camp (caps.nom)


```sql
SELECT oficina, ciutat, COUNT(DISTINCT num_clie), caps.nom
  FROM oficines
       JOIN rep_vendes
       ON oficina = oficina_rep

       JOIN comandes
       ON num_empl = rep

       JOIN clients
       ON clie = num_clie

       JOIN rep_vendes AS caps
       ON rep_vendes.cap = caps.num_empl

 GROUP BY oficina, caps.nom
 ORDER BY COUNT(DISTINCT num_clie) DESC, caps.nom;
```

```sql
 oficina |   ciutat    | count |     nom     
---------+-------------+-------+-------------
      12 | Chicago     |     4 | Bob Smith
      21 | Los Angeles |     3 | Larry Fitch
      21 | Los Angeles |     3 | Sam Clark
      13 | Atlanta     |     2 | Bob Smith
      22 | Denver      |     2 | Larry Fitch
      11 | New York    |     1 | Sam Clark
(6 rows)
```

Ja ho tindríem però per fer exactament el que diu l'enunciat, eliminem les
dades que no ens demanen:


```sql
SELECT oficina, ciutat
  FROM oficines
       JOIN rep_vendes
       ON oficina = oficina_rep

       JOIN comandes
       ON num_empl = rep

       JOIN clients
       ON clie = num_clie

       JOIN rep_vendes AS caps
       ON rep_vendes.cap = caps.num_empl

 GROUP BY oficina, caps.nom
 ORDER BY COUNT(DISTINCT num_clie) DESC, caps.nom;
```


```sql
 oficina |   ciutat    
---------+-------------
      12 | Chicago
      21 | Los Angeles
      21 | Los Angeles
      13 | Atlanta
      22 | Denver
      11 | New York
(6 rows)
```




## Nota¹:

Recordeu que havíem afegit a la taula comandes una comanda de vi amb un venedor
NULL per fer proves:

```sql
INSERT INTO comandes VALUES ( 88888, '2021-11-11', 2111, NULL, 'vi', 'Bages', 2600, 26000);
```



## LINK molt interessant:

[Do all columns in a SELECT list have to appear in a GROUP BY clause](https://stackoverflow.com/questions/5986127/do-all-columns-in-a-select-list-have-to-appear-in-a-group-by-clause#) 





---------------------------------------------------------------------------------

# Examen consultes multitaula i resum


## Exercici 1

Es vol llistar aquelles comandes que tinguin associat un representant de
vendes i també tinguin associat un producte on el preu pagat (import) sigui
inferior a 5000. Mostreu l'identificador i l'import de la comanda, el nom del
representant de vendes, la descripció del producte i el nom del client que ha
fet la comanda.



**Solució:**

La solució passa per no posar cap OUTER JOIN ja que diu clarament "que tinguin associat" :

```sql
SELECT num_comanda, import, nom, descripcio, empresa
  FROM comandes
       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte

       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes
       ON comandes.rep = rep_vendes.num_empl
 WHERE import < 5000;
```


```sql
 num_comanda | import  |      nom      |     descripcio     |      empresa      
-------------+---------+---------------+--------------------+-------------------
      113012 | 3745.00 | Bill Adams    | Article Tipus 3    | JCP Inc.
      112989 | 1458.00 | Sam Clark     | Bancada Motor      | Jones Mfg.
      112968 | 3978.00 | Dan Roberts   | Article Tipus 4    | First Corp.
      112963 | 3276.00 | Bill Adams    | Article Tipus 4    | Acme Mfg.
      113013 |  652.00 | Larry Fitch   | Manovella          | Midwest Systems
      113058 | 1480.00 | Mary Jones    | Coberta            | Holm & Landis
      112997 |  652.00 | Nancy Angelli | Manovella          | Peter Brothers
      112983 |  702.00 | Bill Adams    | Article Tipus 4    | Acme Mfg.
      113062 | 2430.00 | Nancy Angelli | Bancada Motor      | Peter Brothers
      113027 | 4104.00 | Bill Adams    | Article Tipus 2    | Acme Mfg.
      113007 | 2925.00 | Larry Fitch   | Riosta 1/2-Tm      | Zetacorp
      113034 |  632.00 | Tom Snyder    | V Stago Trinquet   | Ace International
      112992 |  760.00 | Larry Fitch   | Article Tipus 2    | Midwest Systems
      112975 | 2100.00 | Paul Cruz     | Passador Frontissa | JCP Inc.
      113055 |  150.00 | Dan Roberts   | Peu de rei         | Holm & Landis
      113048 | 3750.00 | Sue Smith     | Riosta 2-Tm        | Rico Enterprises
      112993 | 1896.00 | Sue Smith     | V Stago Trinquet   | Fred Lewis Corp.
      113065 | 2130.00 | Sue Smith     | Reductor           | Fred Lewis Corp.
      113049 |  776.00 | Larry Fitch   | Reductor           | Midwest Systems
      113057 |  600.00 | Paul Cruz     | Peu de rei         | JCP Inc.
(20 rows)
```

Si l'enunciat fos diferent i ens demanés comandes sense rep associat hauríem d'afegir un LEFT

```sql
SELECT num_comanda, import, nom, descripcio, empresa
  FROM comandes
       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte

       JOIN clients
       ON comandes.clie = clients.num_clie

       LEFT JOIN rep_vendes
       ON comandes.rep = rep_vendes.num_empl
 WHERE import < 5000;
```

## Exercici 2:

Llisteu tots els empleats que han estat contractats abans que els seus
directors. Mostrar el nom de l'empleat com a "empleat", la data del contracte del
l'empleat com a "contracte_empleat", el nom del seu cap com a "cap" i la data de
contracte del director com a "contracte_cap".

**Solució:**

```sql
SELECT venedors.nom AS empleat, venedors.data_contracte AS contracte_empleat,
       caps.nom AS cap, caps.data_contracte AS contracte_cap
  FROM rep_vendes AS venedors 
       JOIN rep_vendes AS caps
       ON venedors.cap = caps.num_empl
 WHERE venedors.data_contracte < caps.data_contracte;
```

```sql
    empleat    | contracte_empleat |     cap     | contracte_cap 
---------------+-------------------+-------------+---------------
 Sue Smith     | 1986-12-10        | Larry Fitch | 1989-10-12
 Bob Smith     | 1987-05-19        | Sam Clark   | 1988-06-14
 Dan Roberts   | 1986-10-20        | Bob Smith   | 1987-05-19
 Paul Cruz     | 1987-03-01        | Bob Smith   | 1987-05-19
 Nancy Angelli | 1988-11-14        | Larry Fitch | 1989-10-12
(5 rows)
```

   

## Exercici 3 


Llisteu les comandes dels clients els quals la segona lletra del nom de l'empresa sigui la lletra "c", sense tenir en compte majúscules i minúscules. Mostreu la data de la comanda i el nom de l'empresa.

**Solució:**

```sql
SELECT empresa, data
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie
 WHERE LOWER(empresa) LIKE '_c%';
```
```sql
      empresa      |    data    
-------------------+------------
 JCP Inc.          | 1990-01-11
 Ace International | 1990-01-30
 Acme Mfg.         | 1989-12-17
 Acme Mfg.         | 1989-12-27
 Acme Mfg.         | 1990-01-22
 Ace International | 1990-01-29
 JCP Inc.          | 1989-12-12
 Acme Mfg.         | 1989-12-31
 JCP Inc.          | 1990-02-18
 JCP Inc.          | 2021-11-11
(10 rows)
```

ILIKE és de PostgreSQL i no és estandard per tant no el fem servir si hi ha una
opció estàndard que accepta PostgreSQL.



## Exercici 4

Llisteu les comandes amb els clients que les han demanades. Si algun client no ha demanat cap comanda també ha d'aparèixer. S'ha de mostrar el codi de la comanda, el codi del client i el nom del client.

**Solució:**

```sql
SELECT num_comanda, num_clie, empresa
  FROM comandes
       RIGHT JOIN clients
       ON comandes.clie = clients.num_clie;
```

```
 num_comanda | num_clie |      empresa      
-------------+----------+-------------------
      112961 |     2117 | J.P. Sinclair
      113012 |     2111 | JCP Inc.
      112989 |     2101 | Jones Mfg.
      113051 |     2118 | Midwest Systems
      112968 |     2102 | First Corp.
      110036 |     2107 | Ace International
      113045 |     2112 | Zetacorp
      112963 |     2103 | Acme Mfg.
      113013 |     2118 | Midwest Systems
      113058 |     2108 | Holm & Landis
      112997 |     2124 | Peter Brothers
      112983 |     2103 | Acme Mfg.
      113024 |     2114 | Orion Corp
      113062 |     2124 | Peter Brothers
      112979 |     2114 | Orion Corp
      113027 |     2103 | Acme Mfg.
      113007 |     2112 | Zetacorp
      113069 |     2109 | Chen Associates
      113034 |     2107 | Ace International
      112992 |     2118 | Midwest Systems
      112975 |     2111 | JCP Inc.
      113055 |     2108 | Holm & Landis
      113048 |     2120 | Rico Enterprises
      112993 |     2106 | Fred Lewis Corp.
      113065 |     2106 | Fred Lewis Corp.
      113003 |     2108 | Holm & Landis
      113049 |     2118 | Midwest Systems
      112987 |     2103 | Acme Mfg.
      113057 |     2111 | JCP Inc.
      113042 |     2113 | Ian & Schmidt
        NULL |     2121 | QMA Assoc.
        NULL |     2115 | Smithson Corp.
        NULL |     2119 | Solomon Inc.
        NULL |     2122 | Three-Way Lines
        NULL |     2105 | AAA Investments
        NULL |     2123 | Carter & Sons
(36 rows)
```

## Exercici 5

Llisteu les comandes que continguin un producte amb la lletra _x_ al seu codi de
producte. S'ha de mostrar el codi de la comanda, el codi del fabricant i del
producte, el nom del venedor que ha servit la comanda com a empleat_comanda i
el nom del venedor associat al client que ha fet la comanda com a
empleat_client. Ordena-ho pel camp que tingui més sentit escollir.


**Solució:**

```sql
SELECT num_comanda, fabricant, producte, ven_comandes.nom AS empleat_comanda, ven_clients.nom AS empleat_client
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie

       JOIN rep_vendes AS ven_comandes
       ON comandes.rep = ven_comandes.num_empl

       JOIN rep_vendes AS ven_clients
       ON clients.rep_clie = ven_clients.num_empl
WHERE producte LIKE '%x%'
ORDER BY 2,3;
```

```sql
 num_comanda | fabricant | producte | empleat_comanda | empleat_client 
-------------+-----------+----------+-----------------+----------------
      113055 | aci       | 4100x    | Dan Roberts     | Mary Jones
      113057 | aci       | 4100x    | Paul Cruz       | Paul Cruz
      113024 | qsa       | xk47     | Larry Fitch     | Sue Smith
      113065 | qsa       | xk47     | Sue Smith       | Sue Smith
      113049 | qsa       | xk47     | Larry Fitch     | Larry Fitch
(5 rows)
```

## Exercici 6

Mostreu un camp anomenat "edat_m". El camp ha de contenir la mitjana de l'edat
dels treballadors amb només dos decimals.

**Solució:**

```sql
SELECT ROUND(AVG(edat),2) AS edat_m
  FROM rep_vendes;
```

```sql
 edat_m 
--------
  42.70
(1 row)
```



## Exercici 7
 
Mostreu l'identificador dels clients i un camp anomenat "comandes". El camp
"comandes" ha de mostrar quantes comandes ha fet cada client. S'ha d'ordenar
per identificador del client, de més petit a més gran.


**Solució:**
```sql
SELECT num_clie, COUNT(clie) AS comandes
  FROM comandes
       RIGHT JOIN clients
       ON comandes.clie = clients.num_clie
 GROUP BY num_clie
 ORDER BY num_clie;
```

```sql
 num_clie | comandes 
----------+----------
     2101 |        1
     2102 |        1
     2103 |        4
     2105 |        0
     2106 |        2
     2107 |        2
     2108 |        3
     2109 |        1
     2111 |        4
     2112 |        2
     2113 |        1
     2114 |        2
     2115 |        0
     2117 |        1
     2118 |        4
     2119 |        0
     2120 |        1
     2121 |        0
     2122 |        0
     2123 |        0
     2124 |        2
(21 rows)
```

## Exercici 8

Llisteu aquells clients pels quals la suma dels imports de les seves comandes
sigui menor al limit de crèdit. Mostreu l'identificador i el nom de l'empresa
dels clients.


**Solució:**

```sql
SELECT num_clie, empresa, limit_credit, SUM(import) AS total_imports
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie
 GROUP BY num_clie
HAVING limit_credit > SUM(import);
```

No cal posar _empresa_ ja que depèn funcionalment de *num_clie*, la columna
utilitzada com a criteri d'agrupació.


```sql
 num_clie |      empresa      | limit_credit | total_imports 
----------+-------------------+--------------+---------------
     2108 | Holm & Landis     |     55000.00 |       7255.00
     2124 | Peter Brothers    |     40000.00 |       3082.00
     2101 | Jones Mfg.        |     65000.00 |       1458.00
     2106 | Fred Lewis Corp.  |     65000.00 |       4026.00
     2118 | Midwest Systems   |     60000.00 |       3608.00
     2112 | Zetacorp          |     50000.00 |      47925.00
     2107 | Ace International |     35000.00 |      23132.00
     2102 | First Corp.       |     65000.00 |       3978.00
     2117 | J.P. Sinclair     |     35000.00 |      31500.00
     2103 | Acme Mfg.         |     50000.00 |      35582.00
     2120 | Rico Enterprises  |     50000.00 |       3750.00
     2111 | JCP Inc.          |     50000.00 |      15445.00
(12 rows)
```

El límit de crèdit podria ser NULL, però com a l'enunciat diu "que sigui menor ..."


## Exercici 9

Mostreu l'identificador del venedor i un camp anomenat "preu_top". El camp
"preu_top" ha de contenir el preu del producte més car que ha venut.

**Solució:**

```sql
SELECT rep, MAX(preu) AS preu_top
  FROM comandes
       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte
 GROUP BY rep
 ORDER BY rep;
```
```sql
 rep | preu_top 
-----+----------
 101 |  4500.00
 102 |  2500.00
 103 |   350.00
 105 |  2750.00
 106 |  4500.00
 107 |  1425.00
 108 |  4500.00
 109 |  1875.00
 110 |  2500.00
(9 rows)
```


Si l'enunciat de l'examen ens hagués demanat que també sortissin els venedors
que no han fet cap comanda i que per a aquests casos el seu preu top fos 0, la
consulta es podria resoldre de la següent manera.
 

```sql
SELECT num_empl, COALESCE(MAX(preu),0) AS preu_top
  FROM comandes
       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte
 
       RIGHT JOIN rep_vendes
       ON comandes.rep = rep_vendes.num_empl    
 GROUP BY num_empl
 ORDER BY num_empl;
```

```sql
 num_empl | preu_top 
----------+----------
      101 |  4500.00
      102 |  2500.00
      103 |   350.00
      104 |        0
      105 |  2750.00
      106 |  4500.00
      107 |  1425.00
      108 |  4500.00
      109 |  1875.00
      110 |  2500.00
(10 rows)
```



## Exercici 10

Mostreu l'identificador i la ciutat de les oficines i dos camps més, un
anomenat "crèdit1" i l'altre "crèdit2". Per a cada oficina, el camp "crèdit1"
ha de mostrar el límit de crèdit més petit dels clients que tenen assignat un
representant en aquesta oficina. El camp "crèdit2" ha de ser el mateix però pel
límit de crèdit més gran.

**Solució:**

```sql
SELECT oficina, ciutat, MIN(limit_credit) AS credit1, MAX(limit_credit) AS credit2
  FROM clients
       JOIN rep_vendes
       ON clients.rep_clie = rep_vendes.num_empl

       JOIN oficines
       ON rep_vendes.oficina_rep = oficines.oficina
 GROUP BY oficina        
 ORDER BY oficina, ciutat;
```

No cal posar _ciutat_ ja que depèn funcionalment de *oficina*, la columna
utilitzada com a criteri d'agrupació.
```
 oficina |   ciutat    | credit1  | credit2  
---------+-------------+----------+----------
      11 | New York    | 25000.00 | 65000.00
      12 | Chicago     | 20000.00 | 65000.00
      13 | Atlanta     | 30000.00 | 50000.00
      21 | Los Angeles | 20000.00 | 65000.00
      22 | Denver      | 40000.00 | 40000.00
(5 rows)
```





---------------------------------------------------------------------------------

# CHEATSHEET KESHI [05]

# Subconsultas 

* El uso de una subconsulta es para especificar.

* Es decir como ejemplo = "Qué empleados tienen una cuota superior a la cuota de Mary Jones?" 

  * Subconsulta = `¿Cuál es la cuota de Mary Jones?` = Se tiene que igualar con el input del SELECT.

```sql
SELECT camps separats per coma o expressions
FROM taula
WHERE camp operador (SELECT select_list
FROM taula);
```

* La subconsulta **s’executa una vegada** i **abans de la consulta principal**.

```sql
SELECT nom
FROM rep_vendes
WHERE quota >
  (SELECT quota
  FROM rep_vendes
  WHERE nom = 'Mary Jones');
```

```sql
nom
-------------
Bill Adams
Sue Smith
Larry Fitch
```

### Regles de les subconsultes

* Sempre tancada amb parèntesis.

* ➔ Ha d’aparèixer a la dreta de l’operador.

* ➔ No fer servir la clàusula ORDER BY a una subconsulta.

* ➔ Utilitzar operadors monoregistre quan la subconsulta retorni només una fila.

* ➔ Utilitzar operadors multiregistre quan la subconsulta retorni més d’una fila.


![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/tiposubcon.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/subconmono.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/subconmono0.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/subconmono1.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/subconmono2.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/subconmono3.png)

### Subconsulta con HAVING

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/having.png)

### El uso de IN / ANY / ALL

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/any.png)

*SE TIENE QUE USAR LOS OPERADORES DE ARRIBA*

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/in0.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/in1.png)

### IN

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ANY0.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ex1any.png)

### NOT IN

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ex2any.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ex2any0.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ex2any1.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ex2any2.png)

### ALL

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ex3any.png)

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ex3any0.png)

### ANY

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/ex4any.png)

#### EXERCICI5: 

* Mostreu els empleats que tenen **més vendes** que la **mitjana** de **vendes** de la seva oficina. 

* Llista el **nom**, **l’oficina**, les seves **vendes** i la **mitjana de la seva oficina**.

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/from.png)

#### EXERCICI4: 

* Mostreu els empleats que treballen a la **mateixa oficina** i que tenen el **mateix càrrec**.

* Pista: fes servir una subconsulta a la **clàusula FROM**

![hola](https://github.com/KeshiKiD03/m02/blob/main/Photos/final.png)

----------------------------------------------------------------------------------

# RESUM SUBCONSULTES

## Subconsultes monoregistre

Retornen un únic valor (una única fila i columna)

Operadors: =, >, >=, <, <=, <>

> Llista els venedors tals que la seva oficina sigui Chicago

Amb JOIN:
```sql
SELECT nom
FROM rep_vendes
JOIN oficines
ON oficina_rep = oficina
WHERE ciutat = 'Chicago';
```

Amb subconsulta:
```sql
SELECT nom
FROM rep_vendes
WHERE oficina_rep = 
   (SELECT oficina
	  FROM oficines 
	 WHERE ciutat = 'Chicago');
```
						   
> Llista tots els venedors tals que les seves vendes siguin superiors a les
vendes de Sam Clark

```sql
SELECT nom
FROM rep_vendes
WHERE vendes >
       (SELECT vendes
	      FROM rep_vendes
         WHERE nom = 'Sam Clark');
```                        

> Llista els clients que les seves compres hagin superat el seu límit de crèdit.

```sql
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

```sql
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

```sql
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

```sql
SELECT empresa
  FROM clients
 WHERE limit_credit > ALL
       (SELECT 0.1 * vendes
          FROM rep_vendes);
```

### EXISTS

_La subconsulta retorna algun resultat._
    
> Clients que han fet una comanda l'any 89.

```sql
SELECT empresa
  FROM clients
 WHERE EXISTS 
       (SELECT *
	      FROM comandes
         WHERE num_clie = clie
           AND DATE_PART( 'year', data) = 1989);
```

> Clients que no han fet cap comanda l'any 89.

```sql
SELECT empresa
  FROM clients
 WHERE NOT EXISTS
       (SELECT *
          FROM comandes
         WHERE num_clie = clie
           AND DATE_PART( 'year', data) = 1989);
```

---------------------------------------------------------------------------------

# Subconsultes EJERCICIO

## Exercici 0

Torna a fer l'exercici 4 de les diapositives de teoria de Subconsultes, però
ara fent servir GROUP BY i la funció de group STRING_AGG. Recordem que la
subconsulta era:

_Mostreu els empleats que treballen a la mateixa oficina i que tenen el mateix
càrrec._
  


```sql
SELECT STRING_AGG(nom, ',') AS noms, oficina_rep, carrec
  FROM rep_vendes
 GROUP BY oficina_rep, carrec
HAVING COUNT(num_empl) > 1 ;
```

```
         noms          | oficina_rep |       carrec
-----------------------+-------------+---------------------
 Dan Roberts,Paul Cruz |          12 | Representant Vendes
(1 row)
```



## Exercici 1

Llista els venedors que tinguin una quota igual o inferior a l'objectiu de
l'oficina de vendes d'Atlanta.

```sql
SELECT nom       
  FROM rep_vendes
 WHERE quota <=
       ( SELECT objectiu
           FROM oficines
          WHERE ciutat = 'Atlanta');
```
```
      nom      
---------------
 Bill Adams
 Mary Jones
 Sue Smith
 Sam Clark
 Bob Smith
 Dan Roberts
 Larry Fitch
 Paul Cruz
 Nancy Angelli
(9 rows)
```

## Exercici 2

Tots els clients, identificador i nom de l'empresa, que han estat atesos per
(que han fet comanda amb) Bill Adams.

```sql
SELECT DISTINCT num_clie, empresa 
  FROM clients
       JOIN comandes
       ON num_clie = clie
 WHERE rep =
       ( SELECT num_empl
           FROM rep_vendes
          WHERE nom = 'Bill Adams');
```

```sql
 num_clie |  empresa  
----------+-----------
     2103 | Acme Mfg.
     2111 | JCP Inc.
(2 rows)
```

Altres solucions:

```sql
SELECT DISTINCT num_clie, empresa
  FROM clients
       JOIN comandes
       ON clie = num_clie
       
       JOIN rep_vendes
       ON rep = num_empl
 WHERE nom = 'Bill Adams';
```
```sql
SELECT num_clie, empresa
FROM clients
WHERE num_clie IN
               (SELECT clie
                  FROM comandes
                 WHERE rep =
                       (SELECT num_empl
                          FROM rep_vendes
                         WHERE nom = 'Bill Adams'));
```

## Exercici 3

Venedors amb quotes que siguin iguals o superiors a l'objectiu de llur oficina
de vendes.


```sql
SELECT nom, quota, objectiu
  FROM rep_vendes
       JOIN oficines 
       ON oficina = oficina_rep
 WHERE quota >= objectiu;
```

```sql
      nom      |   quota   | objectiu  
---------------+-----------+-----------
 Bill Adams    | 350000.00 | 350000.00
 Nancy Angelli | 300000.00 | 300000.00
(2 rows)
```

Altres solucions:

```sql
SELECT nom, quota, objectiu
  FROM rep_vendes
       JOIN oficines 
       ON oficina = oficina_rep
 WHERE quota >= objectiu;
```

```sql
SELECT nom
  FROM rep_vendes
 WHERE quota >=
       (SELECT objectiu
          FROM oficines
         WHERE oficina = oficina_rep);
```

## Exercici 4

Mostrar l'identificador de l'oficina i la ciutat de les oficines on l'objectiu
de vendes de l'oficina excedeix la suma de quotes dels venedors d'aquella
oficina.

```sql
SELECT oficina, ciutat
  FROM oficines
 WHERE objectiu >
       (SELECT SUM(quota)
          FROM rep_vendes
         WHERE oficina_rep = oficina);
```

Fixem-nos que a la subcolsulta hi ha una referència externa (oficina)


```sql
 oficina |   ciutat    
---------+-------------
      12 | Chicago
      21 | Los Angeles
(2 rows)
```


## Exercici 5

Llista dels productes del fabricant amb identificador "aci" l'estoc dels quals
superen l'estoc del producte amb identificador de producte "41004" i
identificador de fabricant "aci".

```sql
SELECT id_producte, id_fabricant, descripcio
  FROM productes
 WHERE id_fabricant = 'aci'
   AND estoc >
       (SELECT estoc 
          FROM productes 
         WHERE (id_fabricant, id_producte) = ('aci','41004'));
```

```sql
 id_producte | id_fabricant |   descripcio    
-------------+--------------+-----------------
 41003       | aci          | Article Tipus 3
 41001       | aci          | Article Tipus 1
 41002       | aci          | Article Tipus 2
(3 rows)
```

## Exercici 6

Llistar els venedors que han acceptat una comanda que representa més del 10% de
la seva quota.

```sql
SELECT num_empl, nom
  FROM rep_vendes 
       JOIN comandes
       ON rep = num_empl
 WHERE import > 0.1 * quota;
```

```sql
 num_empl |      nom      
----------+---------------
      106 | Sam Clark
      108 | Larry Fitch
      107 | Nancy Angelli
(3 rows)
```

Altres maneres de fer el mateix

```sql
SELECT num_empl, nom
  FROM rep_vendes 
 WHERE quota * 0.1 < 
       ANY (SELECT import
              FROM comandes
             WHERE rep = num_empl);
```

I la _simètrica_:

```sql
SELECT DISTINCT rep
  FROM comandes
 WHERE import >
       (SELECT quota * 0.1
          FROM rep_vendes
         WHERE rep = num_empl);
```
(Sense els noms, només els identificadors)


## Exercici 7

Llistar el nom i l'edat de totes les persones de l'equip de vendes que no dirigeixen una oficina.

```sql
SELECT nom, edat
  FROM rep_vendes
WHERE num_empl NOT IN (SELECT director
                       FROM oficines);
```
Segur que està bé? No ho miris, pensa-ho, tens la solució a baix de tot.



## Exercici 8

Llistar aquelles oficines, i els seus objectius, els venedors de les quals
tenen unes vendes que superen el 50% de l'objectiu de l'oficina.

```sql
SELECT oficina, ciutat, objectiu
  FROM oficines
 WHERE 0.5 * objectiu < ALL
       (SELECT vendes
	      FROM rep_vendes
         WHERE oficina_rep= oficina);
```

```sql
 oficina |  ciutat  | objectiu  
---------+----------+-----------
      22 | Denver   | 300000.00
      11 | New York | 575000.00
      13 | Atlanta  | 350000.00
(3 rows)
```


## Exercici 9

Llistar aquells clients els representants de vendes dels quals estàn assignats
a oficines de la regió Est.

```sql
SELECT num_clie, empresa
  FROM clients                                   
       JOIN rep_vendes
       ON rep_clie = num_empl
       JOIN oficines 
	   ON oficina_rep = oficina
 WHERE regio = 'Est';
```

```sql
 num_clie |     empresa
----------+-----------------
     2111 | JCP Inc.
     2102 | First Corp.
     2103 | Acme Mfg.
     2115 | Smithson Corp.
     2101 | Jones Mfg.
     2121 | QMA Assoc.
     2108 | Holm & Landis
     2117 | J.P. Sinclair
     2122 | Three-Way Lines
     2119 | Solomon Inc.
     2113 | Ian & Schmidt
     2109 | Chen Associates
     2105 | AAA Investments
(13 rows)
```
```sql
SELECT num_clie, empresa
  FROM clients
 WHERE rep_clie IN
       (SELECT num_empl
          FROM rep_vendes
         WHERE oficina_rep IN
		       (SELECT oficina
			      FROM oficines
				 WHERE regio = 'Est'));
```

## Exercici 10

Llistar els venedors que treballen en oficines que superen el seu objectiu.

```sql
SELECT num_empl, nom 
  FROM rep_vendes
 WHERE oficina_rep IN 
       (SELECT oficina
	      FROM oficines
         WHERE vendes > objectiu);
```

```sql
 num_empl |     nom
----------+-------------
      105 | Bill Adams
      109 | Mary Jones
      102 | Sue Smith
      106 | Sam Clark
      108 | Larry Fitch
(5 rows)
```


## Exercici 11

Llistar els venedors que treballen en oficines que superen el seu objectiu.
Mostrar també les següents dades de l'oficina: ciutat i la diferència entre les
vendes i l'objectiu. Ordenar el resultat per aquest últim valor. Proposa dues
sentències SQL, una amb subconsultes i una sense.

```sql
SELECT num_empl, nom, ciutat, oficines.vendes - objectiu AS dif
  FROM rep_vendes 
       JOIN oficines
	   ON oficina_rep = oficina
 WHERE oficina_rep IN
       (SELECT oficina
	      FROM oficines
         WHERE vendes > objectiu)
 ORDER BY dif;
```
```sql
 num_empl |     nom     |   ciutat    |    dif
----------+-------------+-------------+-----------
      105 | Bill Adams  | Atlanta     |  17911.00
      102 | Sue Smith   | Los Angeles | 110915.00
      108 | Larry Fitch | Los Angeles | 110915.00
      109 | Mary Jones  | New York    | 117637.00
      106 | Sam Clark   | New York    | 117637.00
(5 rows)
```

```sql
SELECT num_empl, nom, ciutat, oficines.vendes - objectiu AS dif
  FROM rep_vendes 
       JOIN oficines
	   ON oficina_rep = oficina
 WHERE oficines.vendes > objectiu
 ORDER BY dif;
```

## Exercici 12

Llista els venedors que no treballen en oficines dirigides per Larry Fitch, o
que no treballen a cap oficina. Sense usar consultes multitaula.

```sql
SELECT num_empl, nom 
  FROM rep_vendes
 WHERE oficina_rep IS NULL
    OR oficina_rep NOT IN 
	   (SELECT oficina 
          FROM oficines 
         WHERE director =
		       (SELECT num_empl 
                  FROM rep_vendes 
                 WHERE nom = 'Larry Fitch'));
```

```sql
 num_empl |     nom
----------+-------------
      105 | Bill Adams
      109 | Mary Jones
      106 | Sam Clark
      104 | Bob Smith
      101 | Dan Roberts
      110 | Tom Snyder
      103 | Paul Cruz
(7 rows)
```

## Exercici 13

Llista els venedors que no treballen en oficines dirigides per Larry Fitch, o
que no treballen a cap oficina. Mostrant també la ciutat de l'oficina on
treballa l'empleat i l'identificador del director de la oficina. Proposa dues
sentències SQL, una amb subconsultes i una sense.

```sql
SELECT num_empl, nom, ciutat 
  FROM rep_vendes 
       JOIN oficines
	   ON oficina_rep = oficina
 WHERE oficina_rep IS NULL
    OR oficina_rep NOT IN
	   (SELECT oficina 
          FROM oficines 
         WHERE director =
		       (SELECT num_empl
			      FROM rep_vendes 
                 WHERE nom = 'Larry Fitch'));
```

```sql
 num_empl |     nom     |  ciutat
----------+-------------+----------
      105 | Bill Adams  | Atlanta
      109 | Mary Jones  | New York
      106 | Sam Clark   | New York
      104 | Bob Smith   | Chicago
      101 | Dan Roberts | Chicago
      103 | Paul Cruz   | Chicago
(6 rows)
```

```sql
SELECT e.num_empl, e.nom, ciutat 
  FROM rep_vendes e 
       JOIN oficines
	   ON oficina_rep = oficina 

       JOIN rep_vendes d
	   ON director = d.num_empl
 WHERE e.oficina_rep IS NULL
    OR d.nom <> 'Larry Fitch';
```

## Exercici 14

Llista tots els clients que han realitzat comandes del productes de la família
ACI Widgets entre gener i juny del 1990. Els productes de la famíla ACI Widgets
són aquells que tenen identificador de fabricant "aci" i que l'identificador
del producte comença per "4100".

```sql
SELECT empresa
  FROM clients
 WHERE num_clie IN
       (SELECT DISTINCT clie
          FROM comandes
         WHERE fabricant = 'aci'
           AND producte LIKE '4100%'
           AND data BETWEEN '1990-01-01' AND '1990-06-30');
```
```sql
      empresa      
-------------------
 Acme Mfg.
 Ace International
 Holm & Landis
 JCP Inc.
(4 rows)
```

```sql
SELECT DISTINCT empresa
  FROM comandes 
       JOIN clients
	   ON num_clie = clie
 WHERE fabricant = 'aci'
   AND producte LIKE '4100%' 
   AND data BETWEEN '1990-01-01' AND '1990-06-30';
```

## Exercici 15

Llista els clients que no tenen cap comanda.

```sql
SELECT empresa
  FROM clients
 WHERE num_clie NOT IN
       (SELECT clie
	      FROM comandes);
```

```sql
     empresa
-----------------
 Carter & Sons
 Smithson Corp.
 QMA Assoc.
 Three-Way Lines
 Solomon Inc.
 AAA Investments
(6 rows)
```


## Exercici 16

Llista els clients que tenen assignat el venedor que porta més temps
contractat.

```sql
SELECT empresa
  FROM clients
 WHERE rep_clie =
       (SELECT num_empl
	      FROM rep_vendes 
         WHERE data_contracte =
		       (SELECT MIN(data_contracte)
			      FROM rep_vendes));
```
```sql
     empresa     
-----------------
 First Corp.
 Smithson Corp.
 AAA Investments
(3 rows)
```


## Exercici 17

Llista els clients assignats a Sue Smith que no han fet cap comanda amb un
import superior a 30000. Proposa una sentència SQL sense usar multitaula i una
altre en que s'usi multitaula i subconsultes.



```sql
SELECT empresa
  FROM clients 
 WHERE rep_clie =
       (SELECT num_empl 
          FROM rep_vendes
         WHERE nom = 'Sue Smith') 
       
   AND NOT EXISTS
	   (SELECT num_comanda 
          FROM comandes
         WHERE clie = num_clie
           AND import > 30000);
```
```sql
     empresa      
------------------
 Carter & Sons
 Orion Corp
 Rico Enterprises
 Fred Lewis Corp.
(4 rows)
```


```sql
SELECT empresa
  FROM clients 
       JOIN rep_vendes
	   ON rep_clie = num_empl 
 WHERE nom = 'Sue Smith' 
   AND NOT EXISTS
	   (SELECT num_comanda 
          FROM comandes
         WHERE clie = num_clie
           AND import > 30000);
```

## Exercici 18

Llista l'identificador i el nom dels directors d'empleats que tenen més de 40
anys i que dirigeixen un venedor que té unes vendes superiors a la seva pròpia
quota.

```sql
SELECT nom 
  FROM rep_vendes 
 WHERE edat > 40
   AND num_empl IN
	   (SELECT cap 
          FROM rep_vendes 
         WHERE vendes > quota);
```
```sql
     nom
-------------
 Sam Clark
 Larry Fitch
(2 rows)
```

## Exercici 19

Llista d'oficines on hi hagi algun venedor tal que la seva quota representi més
del 50% de l'objectiu de l'oficina

```sql
SELECT ciutat 
  FROM oficines
WHERE objectiu * 0.5 < ANY
      (SELECT quota
	     FROM rep_vendes 
        WHERE oficina_rep = oficina);
```
```sql
  ciutat
----------
 Denver
 New York
 Atlanta
(3 rows)
```


## Exercici 20

Llista d'oficines on tots els venedors tinguin la seva quota superior al 55% de
l'objectiu de l'oficina.

```sql
SELECT ciutat 
  FROM oficines
 WHERE objectiu * 0.55 < ALL
       (SELECT quota
	      FROM rep_vendes 
         WHERE oficina_rep = oficina);
```
```sql
 ciutat
---------
 Denver
 Atlanta
(2 rows)
```

## Exercici 21

Transforma el següent JOIN a una comanda amb subconsultes:

```sql
SELECT num_comanda, import, clie, num_clie, limit_credit
  FROM comandes
       JOIN clients
       ON clie = num_clie;
```

```sql
 num_comanda |  import  | clie | num_clie | limit_credit
-------------+----------+------+----------+--------------
      112961 | 31500.00 | 2117 |     2117 |     35000.00
      113012 |  3745.00 | 2111 |     2111 |     50000.00
...
      112987 | 27500.00 | 2103 |     2103 |     50000.00
      113057 |   600.00 | 2111 |     2111 |     50000.00
      113042 | 22500.00 | 2113 |     2113 |     20000.00
(30 rows)
```





```sql
SELECT num_comanda, import, clie, 
       (SELECT num_clie
          FROM clients
         WHERE clie = num_clie), 
       (SELECT limit_credit
          FROM clients
         WHERE clie = num_clie) 
FROM comandes;
```

## Exercici 22

Transforma el següent JOIN a una comanda amb subconsultes:

```sql
SELECT empl.nom, empl.quota, cap.nom, cap.quota
  FROM rep_vendes AS empl
       JOIN rep_vendes AS cap
       ON empl.cap = cap.num_empl
 WHERE empl.quota > cap.quota;
```

```sql
     nom     |   quota   |    nom    |   quota   
-------------+-----------+-----------+-----------
 Bill Adams  | 350000.00 | Bob Smith | 200000.00
 Mary Jones  | 300000.00 | Sam Clark | 275000.00
 Dan Roberts | 300000.00 | Bob Smith | 200000.00
 Larry Fitch | 350000.00 | Sam Clark | 275000.00
 Paul Cruz   | 275000.00 | Bob Smith | 200000.00
(5 rows)
```

```sql
SELECT empl.nom, empl.quota, 
       (SELECT dir.nom 
          FROM rep_vendes dir
         WHERE empl.cap = dir.num_empl), 
       (SELECT dir.quota
          FROM rep_vendes dir
         WHERE empl.cap = dir.num_empl)
  FROM rep_vendes empl
 WHERE empl.quota >
       (SELECT dir.quota
          FROM rep_vendes dir
         WHERE empl.cap = dir.num_empl);
```

## Exercici 23

Transforma la següent consulta amb un ANY a una consulta amb un EXISTS i també
en una altre consulta amb un ALL:

```sql
SELECT oficina
  FROM oficines
 WHERE vendes * 0.8 < ANY 
       (SELECT vendes
          FROM rep_vendes
         WHERE oficina_rep = oficina);
```

```sql
 oficina 
---------
      22
      13
(2 rows)
```


```sql
SELECT oficina
  FROM oficines 
 WHERE EXISTS
       (SELECT *
          FROM rep_vendes
         WHERE oficina_rep = oficina
           AND oficines.vendes * 0.8 < rep_vendes.vendes);
```
   
```sql
SELECT oficina
  FROM oficines
 WHERE NOT vendes * 0.8 >= ALL
       (SELECT vendes
          FROM rep_vendes
         WHERE oficina_rep = oficina);
```
   
## Exercici 24

Transforma la següent consulta amb un ALL a una consulta amb un EXISTS i també
en una altre consulta amb un ANY:

```sql
SELECT num_clie
  FROM clients
 WHERE limit_credit < ALL
       (SELECT import
          FROM comandes
         WHERE num_clie = clie);
```

```sql
 num_clie 
----------
     2123
     2115
     2121
     2122
     2119
     2113
     2109
     2105
(8 rows)
```

```sql
SELECT num_clie
  FROM clients
 WHERE NOT limit_credit >= ANY
       (SELECT import
          FROM comandes
         WHERE num_clie = clie);
```
```sql
SELECT num_clie
  FROM clients
 WHERE NOT EXISTS 
       (SELECT *
          FROM comandes
         WHERE num_clie = clie
           AND import <= limit_credit);
```

## Exercici 25

Transforma la següent consulta amb un EXISTS a una consulta amb un ALL i també
a una altre consulta amb un ANY:

```sql
SELECT num_clie, empresa
  FROM clients
 WHERE EXISTS
       (SELECT *
          FROM rep_vendes
         WHERE rep_clie = num_empl
           AND edat BETWEEN 40 AND 50);
```

```sql
 num_clie |      empresa      
----------+-------------------
     2102 | First Corp.
     2123 | Carter & Sons
     2107 | Ace International
     2115 | Smithson Corp.
     2114 | Orion Corp
     2124 | Peter Brothers
     2120 | Rico Enterprises
     2106 | Fred Lewis Corp.
     2105 | AAA Investments
(9 rows)
```
```sql
SELECT num_clie, empresa
  FROM clients
 WHERE rep_clie = ANY
       (SELECT num_empl
          FROM rep_vendes
         WHERE edat BETWEEN 40 AND 50);
```

```sql
SELECT num_clie, empresa
  FROM clients
 WHERE NOT rep_clie <> ALL
       (SELECT num_empl
          FROM rep_vendes
         WHERE edat BETWEEN 40 AND 50);
```

## Exercici 26

Transforma la següent consulta amb subconsultes a una consulta sense
subconsultes.

```sql
SELECT *
  FROM productes
 WHERE id_fabricant IN 
       (SELECT fabricant
          FROM comandes
         WHERE quantitat > 30)
   AND id_producte IN 
       (SELECT producte
          FROM comandes
         WHERE quantitat > 30);
```

```sql
 id_fabricant | id_producte |   descripcio    |  preu  | estoc 
--------------+-------------+-----------------+--------+-------
 aci          | 41003       | Article Tipus 3 | 107.00 |   207
 aci          | 41004       | Article Tipus 4 | 117.00 |   139
 aci          | 41002       | Article Tipus 2 |  76.00 |   167
(3 rows)
```
```sql
SELECT productes.*
  FROM productes
       JOIN comandes
       ON productes.id_fabricant = comandes.fabricant
           AND productes.id_producte = comandes.producte
 WHERE quantitat > 30;
```

## Exercici 27

Transforma la següent consulta amb subconsultes a una consulta sense
subconsultes.

```sql
SELECT num_empl, nom
  FROM rep_vendes
 WHERE num_empl = ANY 
       (SELECT rep_clie
          FROM clients
         WHERE empresa LIKE '%Inc.');
```
```sql
 num_empl |    nom     
----------+------------
      109 | Mary Jones
      103 | Paul Cruz
(2 rows)
```



```sql
SELECT num_empl, nom
  FROM rep_vendes
       JOIN clients
       ON rep_vendes.num_empl = clients.rep_clie
 WHERE empresa LIKE '%Inc.';
```

## Exercici 28

Transforma la següent consulta amb un IN a una consulta amb un EXISTS i també a
una altre consulta amb un ALL.

```sql
SELECT num_empl, nom
  FROM rep_vendes
 WHERE num_empl IN
       (SELECT cap
          FROM rep_vendes);
```

```sql
 num_empl |     nom     
----------+-------------
      106 | Sam Clark
      104 | Bob Smith
      101 | Dan Roberts
      108 | Larry Fitch
(4 rows)
```

```sql
SELECT num_empl, nom
  FROM rep_vendes empl
 WHERE EXISTS
       (SELECT *
          FROM rep_vendes
         WHERE cap = empl.num_empl);
```


```sql
SELECT num_empl, nom
  FROM rep_vendes
 WHERE NOT num_empl <> ALL 
       (SELECT cap
          FROM rep_vendes);
```

## Exercici 29

Modifica la següent consulta perquè mostri la ciutat de l'oficina, proposa una
consulta simplificada.

```sql
SELECT num_comanda
  FROM comandes
 WHERE rep IN
       (SELECT num_empl
          FROM rep_vendes
         WHERE vendes >
               (SELECT AVG(vendes)
                  FROM rep_vendes)
           AND oficina_rep IN
               (SELECT oficina
                  FROM oficines
                 WHERE LOWER(regio) LIKE 'est') );
```

```sql
 num_comanda 
-------------
      112961
      113012
      112989
      112968
      112963
      113058
      112983
      113027
      113055
      113003
      112987
      113042
(12 rows)
```

Comandes fetes per venedors que les seves vendes siguin superiors a la mitja de
totes les vendes i que treballin a oficines de la regió Est.

```sql
SELECT num_comanda, ciutat
  FROM comandes
       JOIN rep_vendes
       ON rep = num_empl

       JOIN oficines
       ON oficina_rep = oficina
 WHERE rep_vendes.vendes >
       (SELECT AVG(vendes)
          FROM rep_vendes)
   AND LOWER(regio) LIKE 'est';
```
```sql
 num_comanda |  ciutat  
-------------+----------
      112961 | New York
      113012 | Atlanta
      112989 | New York
      112968 | Chicago
      112963 | Atlanta
      113058 | New York
      112983 | Atlanta
      113027 | Atlanta
      113055 | Chicago
      113003 | New York
      112987 | Atlanta
      113042 | Chicago
(12 rows)
```
## Exercici 30

Transforma la següent consulta amb subconsultes a una consulta amb les mínimes
subconsultes possibles.

```sql
SELECT num_clie, empresa,
       (SELECT nom
          FROM rep_vendes
         WHERE rep_clie = num_empl) AS rep_nom
  FROM clients
 WHERE rep_clie = ANY
       (SELECT num_empl
          FROM rep_vendes
         WHERE vendes >
               (SELECT MAX(quota)
                  FROM rep_vendes));
```

```sql
 num_clie |     empresa      |     nom     
----------+------------------+-------------
     2103 | Acme Mfg.        | Bill Adams
     2123 | Carter & Sons    | Sue Smith
     2112 | Zetacorp         | Larry Fitch
     2114 | Orion Corp       | Sue Smith
     2108 | Holm & Landis    | Mary Jones
     2122 | Three-Way Lines  | Bill Adams
     2120 | Rico Enterprises | Sue Smith
     2106 | Fred Lewis Corp. | Sue Smith
     2119 | Solomon Inc.     | Mary Jones
     2118 | Midwest Systems  | Larry Fitch
(10 rows)
```

```sql
SELECT num_clie, empresa, nom
  FROM clients
       JOIN rep_vendes
       ON rep_clie = num_empl
 WHERE vendes >
       (SELECT MAX(quota)
          FROM rep_vendes);
```

## Extres

+ Exercici 7:
```sql
SELECT num_empl, nom, edat
  FROM rep_vendes
 WHERE num_empl NOT IN
       (SELECT director
          FROM oficines
         WHERE director IS NOT NULL);
```

Si no imposo aquesta condició no surt cap empleat, ja que falla una de les
condicions, la de l'oficina sense director, en una expressió composta per AND's
( `num_empl != NULL`)

```sql
 num_empl |      nom      | edat 
----------+---------------+------
      109 | Mary Jones    |   31
      102 | Sue Smith     |   48
      101 | Dan Roberts   |   45
      110 | Tom Snyder    |   41
      103 | Paul Cruz     |   29
      107 | Nancy Angelli |   49
(6 rows)
```

---------------------------------------------------------------------------------

# UF3 - Assegurament de la informació.


---------------------------------------------------------------------------------



---------------------------------------------------------------------------------



---------------------------------------------------------------------------------



---------------------------------------------------------------------------------



---------------------------------------------------------------------------------



---------------------------------------------------------------------------------



---------------------------------------------------------------------------------



---------------------------------------------------------------------------------



---------------------------------------------------------------------------------



---------------------------------------------------------------------------------




---------------------------------------------------------------------------------



---------------------------------------------------------------------------------



---------------------------------------------------------------------------------



---------------------------------------------------------------------------------



---------------------------------------------------------------------------------



