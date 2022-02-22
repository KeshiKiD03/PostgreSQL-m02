/*21.- Es desitja un llistat d'identificadors de fabricants de productes. Només volem tenir en     compte els productes de preu superior a 54. Només volem que apareguin els fabricants amb un nombre total d'unitats superior a 300.*/

SELECT id_fab, sum(existencias) AS"existencias" 
FROM productos 
WHERE precio > 54 
GROUP BY id_fab 
HAVING SUM(existencias) > 300;

 id_fab | existencias 
--------+-------------
 aci    |         843
(1 row)


/*22.Es desitja un llistat dels productes amb les seves descripcions, ordenat per la suma total d'imports facturats (pedidos) de cada producte de l'any 1989.*/

SELECT descripcion, sum(importe) 
FROM productos pr JOIN pedidos pe 
ON pr.id_producto=pe.producto AND pr.id_fab=pe.fab 
WHERE fecha_pedido>='1989-01-01' and fecha_pedido<='1989-12-31' 
GROUP BY pr.id_fab, pr.id_producto 
ORDER BY 2 DESC;


    descripcion    |   sum    
-------------------+----------
 Bisagra Izqda.    | 31500.00
 Extractor         | 27500.00
 Montador          | 15000.00
 Articulo Tipo 4   |  7956.00
 Pasador Bisagra   |  2100.00
 V Stago Trinquete |  1896.00
 Articulo Tipo 2   |   760.00
(7 rows)


/*23. Per a cada director (de personal, no d'oficina) excepte per al gerent (el venedor que no té director), vull saber el total de vendes dels seus subordinats. Mostreu codi i nom dels directors.*/

SELECT jefe.num_empl, jefe.nombre, sum(importe) 
FROM repventas jefe JOIN repventas venedors 
ON venedors.director=jefe.num_empl JOIN pedidos 
ON venedors.num_empl=rep 
GROUP BY jefe.num_empl;

 num_empl |   nombre    |   sum    
----------+-------------+----------
      106 | Sam Clark   | 65738.00
      101 | Dan Roberts | 23132.00
      104 | Bob Smith   | 68655.00
      108 | Larry Fitch | 57208.00
(4 rows)


/*24. Quins són els 5 productes que han estat venuts a més clients diferents? Mostreu el número de clients per cada producte. A igualtat de nombre de clients es volen ordenats per ordre decreixent d'existències i, a igualtat d'existències, per descripció. Mostreu tots els camps pels quals s'ordena.*/

SELECT pe.rep , pe.fab , count(*) , pr.existencias , pr.descripcion 
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

/*25. Es vol llistar el clients (codi i empresa) tals que no hagin comprat cap tipus de frontissa ("bisagra" en castellà, figura a la descripció) i hagin comprat articles de més d'un fabricant diferent.*/

SELECT cl.num_clie , cl.empresa , count(DISTINCT pe.fab) 
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

/*26. Llisteu les oficines per ordre descendent de nombre total de clients diferents amb comandes (pedidos) realizades pels venedors d'aquella oficina, i, a igualtat de clients, ordenat per ordre ascendent del nom del director de l'oficina. Només s'ha de mostrar el codi i la ciutat de l'oficina.*/

SELECT ciudad,dir.nombre,count(distinct clie) 
FROM oficinas join repventas on oficina=oficina_rep 
join pedidos on num_empl=rep join repventas dir on oficinas.dir=dir.num_empl 
GROUP BY oficina, dir.nombre 
ORDER BY 3 desc, 2;



   ciudad    |   nombre    | count 
-------------+-------------+-------
 Los Angeles | Larry Fitch |     5
 Chicago     | Bob Smith   |     4
 New York    | Sam Clark   |     3
 Atlanta     | Bill Adams  |     2
 Denver      | Larry Fitch |     2
(5 rows)


/*27.Llista totes les comandes mostrant el seu número, import, nom de client i límit de crèdit. */
  
SELECT pe.num_pedido , pe.importe , cl.empresa , cl.limite_credito 
FROM pedidos pe JOIN clientes cl ON pe.clie = cl.num_clie;

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

/*28.Llista cada un dels venedors i la ciutat i regió on treballen */

SELECT re.num_empl , re.nombre , of.ciudad , of.region 
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

/*29.Llista les oficines, i els noms i títols dels directors. */

SELECT of.oficina , of.ciudad, of.dir , re.nombre
FROM oficinas of JOIN repventas re ON of.dir = re.num_empl;

 oficina |   ciudad    | dir |   nombre    
---------+-------------+-----+-------------
      22 | Denver      | 108 | Larry Fitch
      11 | New York    | 106 | Sam Clark
      12 | Chicago     | 104 | Bob Smith
      13 | Atlanta     | 105 | Bill Adams
      21 | Los Angeles | 108 | Larry Fitch
(5 rows)

/*30.Llista les oficines, noms i titols del seus directors amb un objectiu superior a 600.000. */

SELECT of.oficina , of.ciudad, of.dir , re.nombre  
FROM oficinas of JOIN repventas re ON of.dir = re.num_empl 
WHERE of.objetivo > 600000;

 oficina |   ciudad    | dir |   nombre    
---------+-------------+-----+-------------
      12 | Chicago     | 104 | Bob Smith
      21 | Los Angeles | 108 | Larry Fitch
(2 rows)


/*31.Llista els venedors de les oficines de la regió est. */



/*32.Llista totes les comandes, mostrant els imports i les descripcions del producte. */



/*33.Llista les comandes superiors a 25.000, incloent el nom del venedor que va servir la comanda i el nom del client que el va sol·licitar. */



/*34.Llista les comandes superiors a 25000, mostrant el client que va demanar la comanda i el nom del venedor que té assignat el client. */



/*35.Llista les comandes superiors a 25000, mostrant el nom del client que el va 
ordenar, el venedor associat al client, i l'oficina on el venedor treballa. */



/*35bis.- Llista les comandes superiors a 25000, mostrant el nom del client que el 
va ordenar, el venedor associat al client, i l'oficina on el venedor treballa. També cal que mostris la descripció del producte. */




/**36.Trobar totes les comandes rebudes en els dies en que un nou venedor va ser contractat. */



/**37.Llista totes les combinacions de venedors i oficines on la quota del venedor és superior a l'objectiu de l'oficina. */



/**38.Mostra el nom, les vendes i l'oficina de cada venedor. */



/*39.Informa sobre tots els venedors i les oficines en les que treballen. */



/**40.Informa sobre tots els venedors (tota la informació de repventas) més la ciutat i regió on treballen. */



/*(*)41.Llista el nom dels venedors i el del seu director. */



/*42.Llista els venedors amb una quota superior a la dels seus directors. */



/*43.Llista totes les combinacions possibles de venedors i ciutats. */



/*44.Llistar el nom de l'empresa i totes les comandes fetes pel client 2.103. */



/*45.Llista els venedors i les oficines en què treballen. */



/*46.Llista els venedors i les ciutats en què treballen. */



/*47.Fes que la consulta anterior mostri les dades dels deu venedors. */


