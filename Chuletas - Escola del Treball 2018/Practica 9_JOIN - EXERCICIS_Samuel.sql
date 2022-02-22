-- 21.- Es desitja un llistat d'identificadors de fabricants de productes. 
--		Només volem tenir en compte els productes de preu superior a 54. 
--		Només volem que apareguin els fabricants amb un nombre total d'unitats superior a 300.
	training=# SELECT productos.id_fab, sum(existencias) 
	FROM productos WHERE precio > 54 GROUP BY productos.id_fab HAVING sum(existencias) > 300;  
 id_fab | sum 
--------+-----
 aci    | 843
(1 row)



-- 22.Es desitja un llistat dels productes amb les seves descripcions, 
--	  ordenat per la suma total d'imports facturats (pedidos) de cada producte de l'any 1989.
	training=# SELECT productos.id_fab , productos.id_producto , productos.descripcion, sum(pedidos.importe) 
	FROM productos JOIN pedidos ON id_fab = fab and id_producto = producto 
	WHERE fecha_pedido >= '1989-01-01' and fecha_pedido < '1990-01-01' 
	GROUP BY id_fab , id_producto , descripcion 
	ORDER BY sum(importe) DESC;
 id_fab | id_producto |    descripcion    |   sum    
--------+-------------+-------------------+----------
 rei    | 2a44l       | Bisagra Izqda.    | 31500.00
 aci    | 4100y       | Extractor         | 27500.00
 aci    | 4100z       | Montador          | 15000.00
 aci    | 41004       | Articulo Tipo 4   |  7956.00
 rei    | 2a44g       | Pasador Bisagra   |  2100.00
 rei    | 2a45c       | V Stago Trinquete |  1896.00
 aci    | 41002       | Articulo Tipo 2   |   760.00
(7 rows)



-- 23. Per a cada director (de personal, no d'oficina) excepte per al gerent (el venedor que no té director), 
--	   vull saber el total de vendes dels seus subordinats. Mostreu codi i nom dels directors.
	training=# SELECT boss.num_empl , boss.nombre , sum(importe) 
	FROM repventas boss 
	JOIN repventas treb ON boss.num_empl = treb.director  
	JOIN pedidos ON treb.num_empl=rep 
	GROUP BY boss.num_empl;
 num_empl |   nombre    |   sum    
----------+-------------+----------
      106 | Sam Clark   | 65738.00
      101 | Dan Roberts | 23132.00
      104 | Bob Smith   | 68655.00
      108 | Larry Fitch | 57208.00
(4 rows)



-- 24.	Quins són els 5 productes que han estat venuts a més clients diferents? 
--		Mostreu el número de clients per cada producte. 
--		A igualtat de nombre de clients es volen ordenats per ordre decreixent d'existències i, a igualtat d'existències, 
--		per descripció. Mostreu tots els camps pels quals s'ordena.
	training=# SELECT pe.rep , pe.fab , count(*) , pr.existencias , pr.descripcion 
	FROM pedidos pe JOIN productos pr ON pe.fab = pr.id_fab and pe.producto = pr.id_producto 
	GROUP BY pe.rep , pe.fab , pr.existencias , pr.descripcion 
	ORDER BY count(*) DESC , pr.existencias DESC , pr.descripcion LIMIT 5;
 rep | fab | count | existencias |    descripcion    
-----+-----+-------+-------------+-------------------
 105 | aci |     2 |         139 | Articulo Tipo 4
 108 | qsa |     2 |          38 | Reductor
 110 | rei |     1 |         210 | V Stago Trinquete
 102 | rei |     1 |         210 | V Stago Trinquete
 105 | aci |     1 |         207 | Articulo Tipo 3
(5 rows)



-- 25.	Es vol llistar el clients (codi i empresa) tals que no hagin comprat cap tipus de frontissa 
--		("bisagra" en castellà, figura a la descripció) i hagin comprat articles de més d'un fabricant diferent.
	training=# SELECT cl.num_clie , cl.empresa , count(DISTINCT pe.fab) 
	FROM clientes cl JOIN pedidos pe ON cl.num_clie = pe.clie 
	JOIN productos pr ON pe.fab = pr.id_fab and pe.producto = pr.id_producto 
	WHERE pr.descripcion NOT ILIKE '%bisagra%' 
	GROUP BY cl.num_clie , cl.empresa 
	HAVING count(DISTINCT pe.fab) > 1;
 num_clie |      empresa      | count 
----------+-------------------+-------
     2106 | Fred Lewis Corp.  |     2
     2107 | Ace International |     2
     2108 | Holm & Landis     |     3
     2114 | Orion Corp        |     2
     2118 | Midwest Systems   |     3
     2124 | Peter Brothers    |     2
(6 rows)



-- 26.	Llisteu les oficines per ordre descendent de nombre total de clients diferents amb comandes (pedidos) 
--		realizades pels venedors d'aquella oficina, i, a igualtat de clients, 
--		ordenat per ordre ascendent del nom del director de l'oficina. Només s'ha de mostrar el codi i la ciutat de l'oficina.
	




-- 27.Llista totes les comandes mostrant el seu número, import, nom de client i límit de crèdit. 
	training=# SELECT pe.num_pedido , pe.importe , cl.empresa , cl.limite_credito FROM pedidos pe JOIN clientes cl ON pe.clie = cl.num_clie;
 num_pedido | importe  |      empresa      | limite_credito 
------------+----------+-------------------+----------------
     112961 | 31500.00 | J.P. Sinclair     |       35000.00
     112989 |  1458.00 | Jones Mfg.        |       65000.00
     113051 |  1420.00 | Midwest Systems   |       60000.00
     112968 |  3978.00 | First Corp.       |       65000.00
     110036 | 22500.00 | Ace International |       35000.00
     113045 | 45000.00 | Zetacorp          |       50000.00
     112963 |  3276.00 | Acme Mfg.         |       50000.00
     113013 |   652.00 | Midwest Systems   |       60000.00
     113058 |  1480.00 | Holm & Landis     |       55000.00
     112997 |   652.00 | Peter Brothers    |       40000.00
     112983 |   702.00 | Acme Mfg.         |       50000.00
     113024 |  7100.00 | Orion Corp        |       20000.00
     113062 |  2430.00 | Peter Brothers    |       40000.00
     112979 | 15000.00 | Orion Corp        |       20000.00
     113027 |  4104.00 | Acme Mfg.         |       50000.00
     113007 |  2925.00 | Zetacorp          |       50000.00
     113069 | 31350.00 | Chen Associates   |       25000.00
     113034 |   632.00 | Ace International |       35000.00
     112992 |   760.00 | Midwest Systems   |       60000.00
     113055 |   150.00 | Holm & Landis     |       55000.00
     113048 |  3750.00 | Rico Enterprises  |       50000.00
     112993 |  1896.00 | Fred Lewis Corp.  |       65000.00
     113065 |  2130.00 | Fred Lewis Corp.  |       65000.00
     113003 |  5625.00 | Holm & Landis     |       55000.00
     113049 |   776.00 | Midwest Systems   |       60000.00
     112987 | 27500.00 | Acme Mfg.         |       50000.00
     113042 | 22500.00 | Ian & Schmidt     |       20000.00
(27 rows)

  
-- 28.Llista cada un dels venedors i la ciutat i regió on treballen 
	training=# SELECT re.num_empl , re.nombre , of.ciudad , of.region 
	FROM repventas re JOIN oficinas of ON re.oficina_rep = of.oficina;
 num_empl |    nombre     |   ciudad    | region 
----------+---------------+-------------+--------
      105 | Bill Adams    | Atlanta     | Este
      109 | Mary Jones    | New York    | Este
      102 | Sue Smith     | Los Angeles | Oeste
      106 | Sam Clark     | New York    | Este
      104 | Bob Smith     | Chicago     | Este
      101 | Dan Roberts   | Chicago     | Este
      108 | Larry Fitch   | Los Angeles | Oeste
      103 | Paul Cruz     | Chicago     | Este
      107 | Nancy Angelli | Denver      | Oeste
(9 rows)
-- 29.Llista les oficines, i els noms i títols dels directors. 
	training=# SELECT of.oficina , of.ciudad, of.dir , re.nombre FROM oficinas of JOIN repventas re ON of.dir = re.num_empl;
 oficina |   ciudad    | dir |   nombre    
---------+-------------+-----+-------------
      22 | Denver      | 108 | Larry Fitch
      11 | New York    | 106 | Sam Clark
      12 | Chicago     | 104 | Bob Smith
      13 | Atlanta     | 105 | Bill Adams
      21 | Los Angeles | 108 | Larry Fitch
(5 rows)


-- 30.Llista les oficines, noms i titols del seus directors amb un objectiu superior a 600.000. 
	training=# SELECT of.oficina , of.ciudad, of.dir , re.nombre  FROM oficinas of JOIN repventas re ON of.dir = re.num_empl WHERE of.objetivo > 600000;
 oficina |   ciudad    | dir |   nombre    
---------+-------------+-----+-------------
      12 | Chicago     | 104 | Bob Smith
      21 | Los Angeles | 108 | Larry Fitch
(2 rows)

