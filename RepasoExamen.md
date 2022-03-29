# Subconsultas

IN = a alguno de los valores que hay alguna lista. True si es igual.

El operador **IN** es equivalente a **= ANY**

ANY --> Compara los valores y si alguno es true, la comparación es true.

ALL

### Empleats que son cap


```sql
select nom
	from rep_vendes rv 
	where num_empl in 
		(select cap from rep_vendes rv2);
```


### Empleats que NO son cap


```sql
select nom
	from rep_vendes rv 
	where num_empl not in 
		(select cap from rep_vendes rv2);
```


# Consultas simples

# Alias AS o "alias"

# Concatenación con || || ||


```sql
SQL> SELECT ename ||' '||'is a'||' '||job
AS “Detall d’empleats"
FROM emp;
```

# EXTRACT


```sql
SELECT nom, data_contracte
FROM rep_vendes
WHERE extract(year from data_contracte) < 1988;
```


# DATE PART


```sql
SELECT nom, data_contracte 
FROM rep_vendes 
WHERE date_part('year', data_contracte) < 1988;
```


# LIKE

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


* Identificador dels clients, el nom dels quals no conté la cadena " Mfg." o " Inc." o " Corp." i que tingui crèdit major a 30000.


```sql
SELECT num_clie,empresa FROM clientes 
WHERE (empresa NOT LIKE '%Corp.%' AND empresa NOT LIKE '%Inc.%' AND empresa NOT LIKE '%Mfg.%') AND limite_credito > 30000;
```


# IN

* Identificador i nom dels venedors que treballen a les oficines 11 o 13.


```sql
SELECT num_empl, nom
FROM rep_vendes
WHERE oficina_rep IN(11,13);
```


o


```sql
SELECT num_empl, nom
FROM rep_vendes
WHERE oficina_rep = 11 OR oficina_rep = 13;
```


# Operadores lógicos

* Identificadors i noms dels venedors amb vendes entre el 80% i el 120% de llur quota.


```sql
SELECT num_empl,nom
FROM rep_vendes
WHERE vendes > 80 * quota / 100 AND vendes < 120 * quota / 100;
```


# FETCH ES COMO LIMIT


* Codi i nom dels tres venedors que tinguin unes vendes superiors.

```sql
SELECT num_empl,nom
FROM rep_vendes
ORDER BY vendes DESC
FETCH FIRST 3 ROWS ONLY;
```

```sql
SELECT num_empl,nom
FROM rep_vendes
ORDER BY vendes DESC
LIMIT 3;
```

# Between

* Excloent els extrems no podem fer servir BETWEEN:

```sql
SELECT num_comanda, data, fabricant,producte, import
FROM comandes
WHERE data BETWEEN '1989-09-01' AND '1989-12-31';

```

```sql
SELECT num_comanda, data, fabricant,producte, import
FROM comandes
WHERE data > '1989-09-01' AND  data < '1989-12-31';
```


# Ejercicios varios

* Identificador i descripció dels productes del fabricant identificat per imm dels quals hi hagi estoc superior o igual a 200, també del fabricant bic amb estoc superior o igual a 50.


```sql
SELECT id_fabricant, id_producte, descripcio, estoc FROM productes WHERE id_fabricant = 'imm' AND estoc >= 200 OR id_fabricant = 'bic' AND estoc >= 50;
```


* Identificador i nom dels venedors que treballen a les oficines 11, 12 o 22 i compleixen algun dels següents supòsits:

    han estat contractats a partir de juny del 1988 i no tenen cap

    estan per sobre la quota però tenen vendes de 600000 o menors.


```sql
SELECT num_empl, nom, oficina_rep, data_contracte, cap, quota, vendes
FROM rep_vendes
WHERE oficina_rep IN(22,11,12)
AND ( data_contracte >= '1988-6-1' AND cap IS NULL 
OR
vendes > quota AND vendes <= 600000);
```






# UNON

* Elimina las filas duplicadas

* Puede servir para 2 o más consultas.

* Tienen que tener el mismo numero de columnas en la consulta.

* Los datos introducidos en cada UNION tienen que ser la **MISMA**.

```sql
SELECT id_fabricant, id_producte
FROM productes
WHERE preu < 70
UNION
SELECT  DISTINCT fabricant, producte
FROM comandes
WHERE import > 20000 order by 1 DESC, 2 ;
```



* Feu una consulta que mostri les oficines que tinguin un treballador que sigui director de vendes i les oficines que siguin de la regió Est i ordenat.

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

# UNION ALL

* No elimina las filas duplicadas



# Examen consultas simples

* Llisteu la descripció i l'estoc dels productes amb un preu superior a 100 i que compleixin tots els següents supòsits:

    L'identificador del fabricant comenci per la lletra q o bé l'estoc sigui inferior o igual a 100.

    L'estoc sigui superior a 100 o bé la descripció del producte acabi amb les lletres Tm.


```sql
	SELECT descripcio, estoc
	  FROM productes
	 WHERE preu > 100
	   AND ( id_fabricant LIKE 'q%' OR estoc <= 100)
	   AND ( estoc > 100 OR descripcio LIKE '%Tm');
```


* Llisteu l'identificador, la data i l'import de les comandes anteriors a l'11 de gener de 1990 i que compleixin algun dels següents supòsits:

    La quantitat de la comanda sigui superior o igual a 20 i l'identificador del fabricant sigui aci.

    L'import de la comanda sigui superior a 10000 i sigui del client número 2114.


```sql
	SELECT num_comanda, data, import
	  FROM comandes
	 WHERE data < '1990-01-11'
	   AND ( quantitat >= 20 AND fabricant = 'aci' OR import > 10000 AND clie = 2114 ); 
```



* Llisteu l'identificador i el nom dels representants de vendes que no tinguin un director assignat o que no tinguin una quota assignada. 

* També s'han de llistar aquells que les seves vendes no hagin superat la seva quota.

```sql
SELECT num_empl, nom
  FROM rep_vendes
 WHERE cap IS NULL
    OR quota IS NULL
    OR vendes <= quota;
```


# JOIN

* 

    Utilitzem la clàusula JOIN per a consultar dades que es troben en més d’una taula.

    És una reunió o composició de les files d’una taula amb les d’una altra.


```sql
SELECT taula1.columna1, taula2.columna2
FROM taula1 [INNER] JOIN taula2
ON taula1.clau_forana = taula2.clau_primaria;
```

# CROSS JOIN 

* CROSS JOIN

    Producto cartesiano - Forma explícita o implícita

    Se unen campos de dos tablas o más tablas.


```sql

```

# INNER JOIN O WHERE

* INNER JOIN O WHERE

    JOIN sólo se produce cuando las filas cumplen con la clausula ON

FORMA EXPLÍCITA

```sql
SELECT * FROM propietaris INNER JOIN gats 
ON gats.propietari = propietaris.id;
```

FORMA EMPLÍCITA

```sql
SELECT * FROM propietaris, gats WHERE gats.propietari = propietaris.id;
```

# ALIAS

    Ayudan a simplificar


```sql
SELECT e.empno, e.ename, e.deptno,
d.deptno, d.loc
FROM emp e JOIN dept d
ON e.deptno = d.deptno;
```


# OUTER JOIN

* S’utilitza per afegir, al resultat, les files de la taula que vulguem (left, right o les dues) que NO acompleixen la condició del JOIN. ● Left join ● Rigth join* ● Full join



```sql
SELECT taula1.columna1, taula2.columna2
FROM taula1 LEFT [OUTER] JOIN taula2
ON taula1.clau_forana = taula2.clau_primaria;
```

* ON taula1.clau_forana = taula2.clau_primaria;

    Un RIGHT JOIN sempre es pot expressar com un LEFT JOIN,

    És suficient canviar l’ordre de les taules, però quan hi ha més de dues taules podria resultar + còmode no canviar-ho.



* Llista la ciutat de les oficines, i el nom i càrrec dels directors de cada oficina.

```sql
SELECT ciutat, nom, carrec
  FROM oficines
       JOIN rep_vendes
       ON oficines.director = rep_vendes.num_empl;
```


* Llista les comandes superiors a 25000, incloent el nom del venedor que va servir la comanda i el nom del client que el va sol·licitar.

```sql
SELECT nom, empresa, import
  FROM comandes
       JOIN rep_vendes
       ON comandes.rep = rep_vendes.num_empl

       JOIN clients
       ON comandes.clie = clients.num_clie
 WHERE import > 25000;  
```




* Llista els venedors amb una quota superior a la dels seus caps.

```sql
SELECT venedors.nom, venedors.quota, caps.nom AS CAPS, caps.quota AS CAP_QUOTA
  FROM rep_vendes AS venedors
       JOIN rep_vendes AS caps
       ON venedors.cap  = caps.num_empl
 WHERE venedors.quota > caps.quota;
```


* Llistar el nom de l'empresa i totes les comandes fetes pel client 2103.

```sql
SELECT empresa, num_comanda
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie
 WHERE clients.num_clie = 2103;
```


* Llista les comandes amb un import superior a 5000 i també aquelles comandes realitzades per un client amb un crèdit inferior a 30000. 

* Mostrar l'identificador de la comanda, el nom del client i el nom del representant de vendes que va prendre la comanda.


```sql
SELECT num_comanda, empresa, rep_vendes.nom 
  FROM comandes 
       JOIN clients
       ON comandes.clie = clients.num_clie 

       JOIN rep_vendes
       ON rep_vendes.num_empl = clients.rep_clie 

 WHERE comandes.import > 5000
       OR clients.limit_credit < 30000; 
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



# Funciones de grupo

```sql
SELECT AVG(sal), MAX(sal), MIN(sal), SUM(sal) FROM emp WHERE Lower(job) = 'salesman';
```

# COUNT

```sql
SELECT COUNT(*) FROM emp;
```


# COALESCE  = Transforma los valores nulos - Falsea los datos.


```sql
SELECT AVG(coalesce(comm,0)) FROM emp;
```


# Creación de Grupos de Datos GROUP BY

```sql
SELECT camp/s, funció_grup
FROM taula/es
[WHERE condició/ons]
[GROUP BY camp/s_d’agrupació]
[ORDER BY camp/s];
```


```sql
SELECT deptno, AVG(sal)
FROM emp
GROUP BY deptno;
```


```sql
SELECT deptno, job, sum(sal)
FROM emp
GROUP BY deptno, job;
```

# Having


```sql
SELECT deptno, avg(sal)
FROM emp
GROUP BY deptno
HAVING avg(sal) > 2900;
```

* Muestra Job, Suma el Salario, donde Job no empiece por SALES y la suma de salario sea mayor que 5000.*

```sql
SELECT job, SUM(sal) AS "Suma de salaris"
FROM emp
WHERE job NOT LIKE 'SALES%'
GROUP BY job
HAVING SUM(sal) > 5000
ORDER BY SUM(sal);
```


# ROUND

* Quina és la quota promig mostrada com a "prom_quota" i la venda promig mostrades com a "prom_vendes" dels venedors?

```sql
SELECT ROUND(AVG(quota),2) AS prom_vendes, AVG(vendes) AS prom_vendes
FROM rep_vendes;
 prom_vendes |     prom_vendes     
-------------+---------------------
   300000.00 | 289353.200000000000
(1 row)

```

# CAST

* Quin és el promig del rendiment dels venedors (promig del percentatge de les vendes respecte la quota)?

```sql
SELECT CAST( 100 * AVG( vendes / quota ) AS NUMERIC(5,2) )
  FROM rep_vendes;
```

* Exercici

    Trobar l'import mitjà de les comandes, 
    
    l'import total de les comandes, 
    
    la mitjana del percentatge de l'import mitjà de les comandes respecte del límit de crèdit del client i 
    
    la mitjana del percentatge de l'import mitjà de comandes respecte a la quota del venedor.

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

# DISTINCT GROUP

* Quants tipus de càrrecs hi ha de venedors?

```sql
SELECT COUNT(DISTINCT carrec)
FROM repventas;
```

* Quantes oficines de vendes tenen venedors que superen les seves quotes?

```sql
SELECT COUNT(DISTINCT oficina_rep) AS "oficines amb grans venedors"
  FROM rep_vendes
 WHERE vendes > quota;
```



# GROUP BY

* Quina és l'import promig de les comandes de cada venedor?

```sql
  SELECT rep, ROUND(AVG(import),2) AS promig_comandes
    FROM comandes
GROUP BY rep
ORDER BY rep;
```


* Calcula el total dels imports de les comandes fetes per cada client a cada vendedor.

```sql
SELECT clie, rep, SUM(import) AS total_import
  FROM comandes
 GROUP BY clie, rep;
```

* El mateix que a la qüestió anterior, però ordenat per client i dintre de client per venedor.


```sql
SELECT clie, rep, SUM(import) AS total_import
  FROM comandes
 GROUP BY clie, rep
 ORDER BY clie, rep;
```


* Calcula les comandes totals per a cada venedor.

Si el que ens estan preguntant és el número total de comandes que ha fet cada venedor:


```sql
  SELECT rep, COUNT(*)
    FROM comandes
   WHERE rep IS NOT NULL
GROUP BY rep;
```



# Examen Multitaules i resum


* Es vol llistar aquelles comandes que tinguin associat un representant de vendes i també tinguin associat un producte on el preu pagat (import) sigui inferior a 5000. Mostreu l'identificador i l'import de la comanda, el nom del representant de vendes, la descripció del producte i el nom del client que ha fet la comanda.



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

* Llisteu les comandes que continguin un producte amb la lletra x al seu codi de producte. S'ha de mostrar el codi de la comanda, el codi del fabricant i del producte, el nom del venedor que ha servit la comanda com a empleat_comanda i el nom del venedor associat al client que ha fet la comanda com a empleat_client. Ordena-ho pel camp que tingui més sentit escollir.

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

* Mostreu un camp anomenat "edat_m". 

* El camp ha de contenir la mitjana de l'edat dels treballadors amb només dos decimals.



```sql
SELECT ROUND(AVG(edat),2) AS edat_m
  FROM rep_vendes;
```



* Mostreu l'identificador dels clients i un camp anomenat "comandes". 

* El camp "comandes" ha de mostrar quantes comandes ha fet cada client. S'ha d'ordenar per identificador del client, de més petit a més gran.

```sql
SELECT num_clie, COUNT(clie) AS comandes
  FROM comandes
       RIGHT JOIN clients
       ON comandes.clie = clients.num_clie
 GROUP BY num_clie
 ORDER BY num_clie;
```



* Llisteu aquells clients pels quals la suma dels imports de les seves comandes sigui menor al limit de crèdit. 

* Mostreu l'identificador i el nom de l'empresa dels clients.


```sql
SELECT num_clie, empresa, limit_credit, SUM(import) AS total_imports
  FROM comandes
       JOIN clients
       ON comandes.clie = clients.num_clie
 GROUP BY num_clie
HAVING limit_credit > SUM(import);
```


* Mostreu l'identificador del venedor i un camp anomenat "preu_top". El camp "preu_top" ha de contenir el preu del producte més car que ha venut.

```sql
SELECT rep, MAX(preu) AS preu_top
  FROM comandes
       JOIN productes
       ON comandes.fabricant = productes.id_fabricant
         AND comandes.producte = productes.id_producte
 GROUP BY rep
 ORDER BY rep;
```


    * Si l'enunciat de l'examen ens hagués demanat que també sortissin els venedors que no han fet cap comanda i que per a aquests casos el seu preu top fos 0, la consulta es podria resoldre de la següent manera.

* Con COALESCE

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



* Mostreu l'identificador i la ciutat de les oficines i dos camps més, un anomenat "crèdit1" i l'altre "crèdit2". 

* Per a cada oficina, el camp "crèdit1" ha de mostrar el límit de crèdit més petit dels clients que tenen assignat un representant en aquesta oficina. 

* El camp "crèdit2" ha de ser el mateix però pel límit de crèdit més gran.



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



# SUBCONSULTAS


> Llista els venedors tals que la seva oficina sigui Chicago

* Con Join




```sql
SELECT rep_vendes.nom
FROM rep_vendes
JOIN oficines
ON rep_vendes.oficina_rep = oficines.oficina
WHERE oficines.ciutat = 'Chicago';
```


* Con Subconsultas

```sql
SELECT nom
FROM rep_vendes
WHERE oficina_rep IN
   (SELECT oficina
	  FROM oficines 
	 WHERE ciutat = 'Chicago');
```





```sql
SELECT nom
FROM rep_vendes
WHERE oficina_rep =
   (SELECT oficina
	  FROM oficines 
	 WHERE ciutat = 'Chicago');
```




# IN

* Alguna fila de la subconsulta coincideix amb el camp avaluat.

> Mostra els clients, el representant de vendes dels quals ha fet una comanda superior a 10000.

```sql
SELECT empresa
  FROM clients
 WHERE rep_clie IN 
       (SELECT rep
          FROM comandes
         WHERE import > 10000);
```

es = a = ANY

# ANY 

* Alguna fila de la subconsulta compleix la condició.

> Mostra els clients que el seu límit de crèdit és superior al 30% de la quota d'algun representant de vendes.

```sql
SELECT empresa
  FROM clients
 WHERE limit_credit > ANY
       (SELECT 0.3 * quota
	     FROM rep_vendes);
```


# ALL

* Totes les files de la subconsulta compleixen la condició.

> Mostra els clients el límit de crèdit dels quals és superior al 10% de les vendes de tots els representant de vendes.



```sql
SELECT empresa
  FROM clients
 WHERE limit_credit > ALL
       (SELECT 0.1 * vendes
          FROM rep_vendes);
```

# EXISTS

* La subconsulta retorna algun resultat.

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

# NOT EXISTS

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



# Exercicis

* Tots els clients, identificador i nom de l'empresa, que han estat atesos per (que han fet comanda amb) Bill Adams.

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

* Llista d'oficines on hi hagi algun venedor tal que la seva quota representi més del 50% de l'objectiu de l'oficina

```sql
SELECT ciutat 
  FROM oficines
WHERE objectiu * 0.5 < ANY
      (SELECT quota
	     FROM rep_vendes 
        WHERE oficina_rep = oficina);
```


*  Transforma el següent JOIN a una comanda amb subconsultes:

```sql
SELECT num_comanda, import, clie, num_clie, limit_credit
  FROM comandes
       JOIN clients
       ON clie = num_clie;
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



# DML

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


