### Consultes simples extres.
#### Trobeu la consulta SQL, amb la seva sortida, que resol cada una de les peticions de la següent llista

**Exercici 1:**
Fabricant, número i import de les comandes, l'import de les quals oscil·li entre 10000 i 39999, i ordenades pel número de forma ascendent i pel fabricant descendent.
training=> SELECT fabricant, num_comanda, import FROM comandes WHERE import BETWEEN 10000 AND 39999 ORDER BY num_comanda ASC, fabricant DESC;
 fabricant | num_comanda |  import
-----------+-------------+----------
 aci       |      110036 | 22500.00
 rei       |      112961 | 31500.00
 aci       |      112979 | 15000.00
 aci       |      112987 | 27500.00
 rei       |      113042 | 22500.00
 imm       |      113069 | 31350.00
(6 rows)

**Exercici 2:**
Fabricant, producte i preu dels productes on el seu identificador comenci per 4 acabi per 3 i contingui tres caracters entre mig.
training=> SELECT id_fabricant, id_producte, preu FROM productes WHERE id_producte LIKE '4___3';
 id_fabricant | id_producte |  preu
--------------+-------------+--------
 aci          | 41003       | 107.00
 bic          | 41003       | 652.00
(2 rows)

**Exercici 3:**
Nom i data de contracte dels empleats, les vendes dels quals, siguin superiors a 200000 i ordenats per contracte de més nou a més vell.
training=> SELECT nom, data_contracte, vendes FROM rep_vendes WHERE vendes > 200000 ORDER BY data_contracte DESC;
     nom     | data_contracte |  vendes
-------------+----------------+-----------
 Larry Fitch | 1989-10-12     | 361865.00
 Mary Jones  | 1989-10-12     | 392725.00
 Sam Clark   | 1988-06-14     | 299912.00
 Bill Adams  | 1988-02-12     | 367911.00
 Paul Cruz   | 1987-03-01     | 286775.00
 Sue Smith   | 1986-12-10     | 474050.00
 Dan Roberts | 1986-10-20     | 305673.00
(7 rows)

**Exercici 4:**
Número de comanda, data comanda, codi fabricant, codi producte i import de les comandes realitzades entre els dies '1989-09-1' i '1989-12-31'.
training=> SELECT num_comanda, data, fabricant, producte, import FROM comandes WHERE data BETWEEN '1989-09-01' AND '1989-12-31';
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

**Exercici 5:**
Identificador dels clients, el nom dels quals no conté la cadena " Mfg." o " Inc." o " Corp." i que tingui crèdit major a 30000.
training=> SELECT num_clie, empresa FROM clients WHERE (empresa NOT LIKE '%Mfg.%' AND empresa NOT LIKE '%Inc.%' AND empresa NOT LIKE '%Corp.%') AND limit_credit > 30000;
 num_clie |      empresa
----------+-------------------
 2123 | Carter & Sons
 2107 | Ace International
 2112 | Zetacorp
 2121 | QMA Assoc.
 2124 | Peter Brothers
 2108 | Holm & Landis
 2117 | J.P. Sinclair
 2120 | Rico Enterprises
 2118 | Midwest Systems
 2105 | AAA Investments
(10 rows)

**Exercici 6:**
Identificador del fabricant, identificació i descripció dels productes amb identificador de fabricant aci i els que tinguin preu menor a 500.
training=# SELECT id_fabricant, id_producte, descripcio FROM productes WHERE id_fabricant = 'aci' OR preu < 500;
 id_fabricant | id_producte |     descripcio
--------------+-------------+--------------------
 rei          | 2a45c       | V Stago Trinquet
 aci          | 4100y       | Extractor
 qsa          | xk47        | Reductor
 bic          | 41672       | Plate
 aci          | 41003       | Article Tipus 3
 aci          | 41004       | Article Tipus 4
 imm          | 887p        | Pern Riosta
 qsa          | xk48        | Reductor
 fea          | 112         | Coberta
 imm          | 887h        | Suport Riosta
 bic          | 41089       | Retn
 aci          | 41001       | Article Tipus 1
 aci          | 4100z       | Muntador
 qsa          | xk48a       | Reductor
 aci          | 41002       | Article Tipus 2
 aci          | 4100x       | Peu de rei
 fea          | 114         | Bancada Motor
 imm          | 887x        | Retenidor Riosta
 rei          | 2a44g       | Passador Frontissa
(19 rows)

**Exercici 7:**
Identificador de fabricant i producte i descripció dels productes del fabricant amb identificador aci amb preu superior a 1000 i els productes amb existències que siguin superiors a 20.
training=# SELECT id_fabricant, id_producte, descripcio FROM productes WHERE id_fabricant = 'aci' AND preu > 1000 OR estoc > 20;
 id_fabricant | id_producte |    descripcio    
--------------+-------------+------------------
 rei          | 2a45c       | V Stago Trinquet
 aci          | 4100y       | Extractor
 qsa          | xk47        | Reductor
 aci          | 41003       | Article Tipus 3
 aci          | 41004       | Article Tipus 4
 imm          | 887p        | Pern Riosta
 qsa          | xk48        | Reductor
 fea          | 112         | Coberta
 imm          | 887h        | Suport Riosta
 bic          | 41089       | Retn
 aci          | 41001       | Article Tipus 1
 aci          | 4100z       | Muntador
 qsa          | xk48a       | Reductor
 aci          | 41002       | Article Tipus 2
 imm          | 773c        | Riosta 1/2-Tm
 aci          | 4100x       | Peu de rei
 imm          | 887x        | Retenidor Riosta
(17 rows)

**Exercici 8:**
Fabricant, producte i preu dels productes amb un preu superior a 100 i unes existèncias menors a 10 ordenat per l'identificador de producte (alfabèticament invers) i després ordenat alfabèticament per l'identificador de fabricant.
training=> SELECT id_fabricant, id_producte, preu FROM productes WHERE preu > 1000 AND estoc < 10 ORDER BY 2 DESC, 1 ASC;
 id_fabricant | id_producte |  preu
--------------+-------------+---------
 imm          | 779c        | 1875.00
 imm          | 775c        | 1425.00
(2 rows)
