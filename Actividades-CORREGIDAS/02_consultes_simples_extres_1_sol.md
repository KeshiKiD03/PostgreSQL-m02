# Consultes simples extres SOLUCIONS

> Trobeu la consulta SQL, amb la seva sortida, que resol cada una de les
> peticions de la següent llista


## Exercici 1:

Fabricant, número i import de les comandes, l'import de les quals oscil·li
entre 10000 i 39999, i ordenades pel número de forma ascendent i pel fabricant
descendent.

```
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

## Exercici 2:

Fabricant, producte i preu dels productes on el seu identificador comenci per 4
acabi per 3 i contingui tres caracters entre mig.

```
SELECT id_fabricant, id_producte, preu
FROM productes 
WHERE id_producte like '4___3';
```

```
 id_fabricant | id_producte |  preu  
--------------+-------------+--------
 aci          | 41003       | 107.00
 bic          | 41003       | 652.00
(2 rows)
```

Si en comptes de 3 guions baixos possem '%' penseu que seria correcte la
consulta?

## Exercici 3:

Nom i data de contracte dels empleats, les vendes dels quals, siguin superiors
a 200000 i ordenats per contracte de més nou a més vell.

```
SELECT nom, data_contracte
FROM rep_vendes
WHERE vendes > 200000 ORDER BY data_contracte DESC;
```

```
     nom     | data_contracte 
-------------+----------------
 Larry Fitch | 1989-10-12
 Mary Jones  | 1989-10-12
 Sam Clark   | 1988-06-14
 Bill Adams  | 1988-02-12
 Paul Cruz   | 1987-03-01
 Sue Smith   | 1986-12-10
 Dan Roberts | 1986-10-20
(7 rows)
```

## Exercici 4:

Número de comanda, data comanda, codi fabricant, codi producte i import de les
comandes realitzades entre els dies '1989-09-1' i '1989-12-31'.

Mateixa consulta però sense inlcoure les dates dels extrems.

```
SELECT num_comanda, data, fabricant,producte, import
FROM comandes
WHERE data >= '1989-09-01' AND  data <= '1989-12-31';
```

O també podríem fer:

```
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

Excloent els extrems no podem fer servir BETWEEN:

```
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


## Exercici 5:

Identificador dels clients, el nom dels quals no conté la cadena " Mfg." o "
Inc." o " Corp." i que tingui crèdit major a 30000.

```
SELECT num_clie,empresa FROM clientes 
WHERE (empresa NOT LIKE '%Corp.%' AND empresa NOT LIKE '%Inc.%' AND empresa NOT LIKE '%Mfg.%') AND limite_credito > 30000;
```
## Exercici 6:

Identificador del fabricant, identificació i descripció dels productes amb
identificador de fabricant _aci_ i els que tinguin preu menor a 500.

```
SELECT id_fabricant, id_producte, descripcio
FROM productes
WHERE id_fabricant = 'rei' OR preu < 500;
```

```
 id_fabricant | id_producte |     descripcio     
--------------+-------------+--------------------
 rei          | 2a45c       | V Stago Trinquet
 qsa          | xk47        | Reductor
 bic          | 41672       | Plate
 aci          | 41003       | Article Tipus 3
 aci          | 41004       | Article Tipus 4
 imm          | 887p        | Pern Riosta
 qsa          | xk48        | Reductor
 rei          | 2a44l       | Frontissa Esq.
 fea          | 112         | Coberta
 imm          | 887h        | Suport Riosta
 bic          | 41089       | Retn
 aci          | 41001       | Article Tipus 1
 qsa          | xk48a       | Reductor
 aci          | 41002       | Article Tipus 2
 rei          | 2a44r       | Frontissa Dta.
 aci          | 4100x       | Peu de rei
 fea          | 114         | Bancada Motor
 imm          | 887x        | Retenidor Riosta
 rei          | 2a44g       | Passador Frontissa
(19 rows)
```

Alerta el pronom _els_ a la frase substitueix els productes per tant volem
productes que o be compleixin una condició o bé compleixin l'altra.

## Exercici 7:

Identificador de fabricant i producte i descripció dels productes del fabricant
amb identificador _aci_ amb preu superior a 1000 i els productes amb
existències que siguin superiors a 20.

```
SELECT id_fabricant, id_producte, descripcio, estoc
FROM productes
WHERE preu > 1000 AND id_fabricant = 'aci' OR estoc  > 20;
```

```
 id_fabricant | id_producte |    descripcio    | estoc 
--------------+-------------+------------------+-------
 rei          | 2a45c       | V Stago Trinquet |   210
 aci          | 4100y       | Extractor        |    25
 qsa          | xk47        | Reductor         |    38
 aci          | 41003       | Article Tipus 3  |   207
 aci          | 41004       | Article Tipus 4  |   139
 imm          | 887p        | Pern Riosta      |    24
 qsa          | xk48        | Reductor         |   203
 fea          | 112         | Coberta          |   115
 imm          | 887h        | Suport Riosta    |   223
 bic          | 41089       | Retn             |    78
 aci          | 41001       | Article Tipus 1  |   277
 aci          | 4100z       | Muntador         |    28
 qsa          | xk48a       | Reductor         |    37
 aci          | 41002       | Article Tipus 2  |   167
 imm          | 773c        | Riosta 1/2-Tm    |    28
 aci          | 4100x       | Peu de rei       |    37
 imm          | 887x        | Retenidor Riosta |    32
(17 rows)
```

## Exercici 8:

Fabricant, producte i preu dels productes amb un preu superior a 100 i unes
existèncias menors a 10 ordenat per l'identificador de producte (alfabèticament
invers) i després ordenat alfabèticament per l'identificador de fabricant.

```
SELECT id_fabricant, id_producte, preu FROM productes
WHERE preu > 100 AND estoc  < 10 ORDER BY id_fabricant DESC, id_producte ASC;
```
```
 id_fabricant | id_producte |  preu   
--------------+-------------+---------
 imm          | 775c        | 1425.00
 imm          | 779c        | 1875.00
 bic          | 41003       |  652.00
 bic          | 41672       |  180.00
(4 rows)
```
