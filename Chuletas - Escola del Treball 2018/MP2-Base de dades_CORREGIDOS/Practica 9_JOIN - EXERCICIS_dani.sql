-- 21.- Es desitja un llistat d'identificadors de fabricants de productes. 
--		Només volem tenir en compte els productes de preu superior a 54. 
--		Només volem que apareguin els fabricants amb un nombre total d'unitats superior a 300.

training=# SELECT id_fab,sum(existencias) FROM productos WHERE precio>54 GROUP BY id_fab having sum(existencias)>300;
 id_fab | sum 
--------+-----
 aci    | 843
(1 row)



--22.Es desitja un llistat dels productes amb les seves descripcions, 
--	  ordenat per la suma total d'imports facturats (pedidos) de cada producte de l'any 1989.

training=# SELECT id_fab,descripcion,count(importe) FROM productos JOIN pedidos on fecha_pedido>'1989-01-01' and fecha_pedido>'1989-12-30' GROUP BY id_fab,descripcion ORDER BY count(importe) desc;
 id_fab |    descripcion    | count 
--------+-------------------+-------
 qsa    | Reductor          |    66
 bic    | Plate             |    22
 bic    | Retn              |    22
 rei    | Bisagra Izqda.    |    22
 fea    | Cubierta          |    22
 imm    | Riostra 1-Tm      |    22
 imm    | Soporte Riostra   |    22
 rei    | Bisagra Dcha.     |    22
 imm    | Retenedor Riostra |    22
 rei    | V Stago Trinquete |    22
 rei    | Pasador Bisagra   |    22
 imm    | Perno Riostra     |    22
 aci    | Extractor         |    22
 aci    | Articulo Tipo 2   |    22
 aci    | Articulo Tipo 3   |    22
 fea    | Bancada Motor     |    22
 imm    | Riostra 2-Tm      |    22
 bic    | Manivela          |    22
 aci    | Ajustador         |    22
 aci    | Articulo Tipo 1   |    22
 aci    | Montador          |    22
 aci    | Articulo Tipo 4   |    22
 imm    | Riostra 1/2-Tm    |    22
(23 rows)


-- 23. Per a cada director (de personal, no d'oficina) excepte per al gerent (el venedor que no té director), 
--	   vull saber el total de vendes dels seus subordinats. Mostreu codi i nom dels directors.



-- 24.	Quins són els 5 productes que han estat venuts a més clients diferents? 
--		Mostreu el número de clients per cada producte. 
--		A igualtat de nombre de clients es volen ordenats per ordre decreixent d'existències i, a igualtat d'existències, 
--		per descripció. Mostreu tots els camps pels quals s'ordena.

training=# SELECT id_fab,id_producto,descripcion,clie,existencias,count(*) FROM pedidos JOIN productos ON id_fab=fab and id_producto=producto GROUP BY id_fab,id_producto,clie,descripcion,existencias ORDER BY count(*) desc,existencias desc,descripcion LIMIT 5;
 id_fab | id_producto |    descripcion    | clie | existencias | count 
--------+-------------+-------------------+------+-------------+-------
 aci    | 41004       | Articulo Tipo 4   | 2103 |         139 |     2
 rei    | 2a45c       | V Stago Trinquete | 2107 |         210 |     1
 rei    | 2a45c       | V Stago Trinquete | 2106 |         210 |     1
 aci    | 41003       | Articulo Tipo 3   | 2111 |         207 |     1
 aci    | 41002       | Articulo Tipo 2   | 2118 |         167 |     1
(5 rows)

training=# 

-- 25.	Es vol llistar el clients (codi i empresa) tals que no hagin comprat cap tipus de frontissa 
--		("bisagra" en castellà, figura a la descripció) i hagin comprat articles de més d'un fabricant diferent.

training=# SELECT empresa,rep_clie,count(fab) FROM clientes JOIN pedidos ON (rep_clie=rep) JOIN productos ON id_fab=fab and id_producto=producto WHERE descripcion NOT like 'bisagra' GROUP BY empresa,rep_clie HAVING count(fab)>1;
      empresa      | rep_clie | count 
-------------------+----------+-------
 Three-Way Lines   |      105 |     5
 Jones Mfg.        |      106 |     2
 Ace International |      110 |     2
 Carter & Sons     |      102 |     4
 Holm & Landis     |      109 |     2
 JCP Inc.          |      103 |     2
 Zetacorp          |      108 |     6
 Rico Enterprises  |      102 |     4
 Peter Brothers    |      107 |     3
 Orion Corp        |      102 |     4
 Smithson Corp.    |      101 |     3
 Solomon Inc.      |      109 |     2
 AAA Investments   |      101 |     3
 Acme Mfg.         |      105 |     5
 Chen Associates   |      103 |     2
 Fred Lewis Corp.  |      102 |     4
 First Corp.       |      101 |     3
 QMA Assoc.        |      103 |     2
 J.P. Sinclair     |      106 |     2
 Midwest Systems   |      108 |     6
(20 rows)



-- 26.	Llisteu les oficines per ordre descendent de nombre total de clients diferents amb comandes (pedidos) 
--		realizades pels venedors d'aquella oficina, i, a igualtat de clients, 
--		ordenat per ordre ascendent del nom del director de l'oficina. Només s'ha de mostrar el codi i la ciutat de l'oficina.
	




-- 27.Llista totes les comandes mostrant el seu número, import, nom de client i límit de crèdit. 


  training=# SELECT num_pedido,importe,clie,empresa,limite_credito FROM pedidos JOIN clientes ON (num_clie=clie);
 num_pedido | importe  | clie |      empresa      | limite_credito 
------------+----------+------+-------------------+----------------
     112961 | 31500.00 | 2117 | J.P. Sinclair     |       35000.00
     113012 |  3745.00 | 2111 | JCP Inc.          |       50000.00
     112989 |  1458.00 | 2101 | Jones Mfg.        |       65000.00
     113051 |  1420.00 | 2118 | Midwest Systems   |       60000.00
     112968 |  3978.00 | 2102 | First Corp.       |       65000.00
     110036 | 22500.00 | 2107 | Ace International |       35000.00
     113045 | 45000.00 | 2112 | Zetacorp          |       50000.00
     112963 |  3276.00 | 2103 | Acme Mfg.         |       50000.00
     113013 |   652.00 | 2118 | Midwest Systems   |       60000.00
     113058 |  1480.00 | 2108 | Holm & Landis     |       55000.00
     112997 |   652.00 | 2124 | Peter Brothers    |       40000.00
     112983 |   702.00 | 2103 | Acme Mfg.         |       50000.00
     113024 |  7100.00 | 2114 | Orion Corp        |       20000.00
     113062 |  2430.00 | 2124 | Peter Brothers    |       40000.00
     112979 | 15000.00 | 2114 | Orion Corp        |       20000.00
     113027 |  4104.00 | 2103 | Acme Mfg.         |       50000.00
     113007 |  2925.00 | 2112 | Zetacorp          |       50000.00
     113069 | 31350.00 | 2109 | Chen Associates   |       25000.00
     113034 |   632.00 | 2107 | Ace International |       35000.00
     112992 |   760.00 | 2118 | Midwest Systems   |       60000.00
     112975 |  2100.00 | 2111 | JCP Inc.          |       50000.00
     113055 |   150.00 | 2108 | Holm & Landis     |       55000.00
     113048 |  3750.00 | 2120 | Rico Enterprises  |       50000.00
     112993 |  1896.00 | 2106 | Fred Lewis Corp.  |       65000.00
     113065 |  2130.00 | 2106 | Fred Lewis Corp.  |       65000.00
     113003 |  5625.00 | 2108 | Holm & Landis     |       55000.00
     113049 |   776.00 | 2118 | Midwest Systems   |       60000.00
     112987 | 27500.00 | 2103 | Acme Mfg.         |       50000.00
     113057 |   600.00 | 2111 | JCP Inc.          |       50000.00
     113042 | 22500.00 | 2113 | Ian & Schmidt     |       20000.00
(30 rows)

-- 28.Llista cada un dels venedors i la ciutat i regió on treballen 

training=# SELECT num_empl,nombre,oficina_rep,ciudad,region FROM repventas JOIN oficinas on oficina_rep=oficina;
 num_empl |    nombre     | oficina_rep |   ciudad    | region 
----------+---------------+-------------+-------------+--------
      105 | Bill Adams    |          13 | Atlanta     | Este
      109 | Mary Jones    |          11 | New York    | Este
      102 | Sue Smith     |          21 | Los Angeles | Oeste
      106 | Sam Clark     |          11 | New York    | Este
      104 | Bob Smith     |          12 | Chicago     | Este
      101 | Dan Roberts   |          12 | Chicago     | Este
      108 | Larry Fitch   |          21 | Los Angeles | Oeste
      103 | Paul Cruz     |          12 | Chicago     | Este
      107 | Nancy Angelli |          22 | Denver      | Oeste
(9 rows)


-- 29.Llista les oficines, i els noms i títols dels directors. 

training=# SELECT oficina,dir,nombre,titulo FROM oficinas JOIN repventas ON dir=director;
 oficina | dir |    nombre     |   titulo   
---------+-----+---------------+------------
      22 | 108 | Nancy Angelli | Rep Ventas
      22 | 108 | Sue Smith     | Rep Ventas
      11 | 106 | Larry Fitch   | Dir Ventas
      11 | 106 | Bob Smith     | Dir Ventas
      11 | 106 | Mary Jones    | Rep Ventas
      12 | 104 | Paul Cruz     | Rep Ventas
      12 | 104 | Dan Roberts   | Rep Ventas
      12 | 104 | Bill Adams    | Rep Ventas
      21 | 108 | Nancy Angelli | Rep Ventas
      21 | 108 | Sue Smith     | Rep Ventas
(10 rows)


-- 30.Llista les oficines, noms i titols del seus directors amb un objectiu superior a 600.000. 

training=# SELECT oficina,dir,nombre,titulo FROM oficinas JOIN repventas ON (dir=director) WHERE objetivo>600000;
 oficina | dir |    nombre     |   titulo   
---------+-----+---------------+------------
      12 | 104 | Bill Adams    | Rep Ventas
      21 | 108 | Sue Smith     | Rep Ventas
      12 | 104 | Dan Roberts   | Rep Ventas
      12 | 104 | Paul Cruz     | Rep Ventas
      21 | 108 | Nancy Angelli | Rep Ventas
(5 rows)


