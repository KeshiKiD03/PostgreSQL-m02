


--10. Mostrar, per cada comanda, les següents dades ordenades per client:
-- Nom de producte
-- Codi i nom del venedor que va vendre la comanda
-- Ciutat de l'oficina del venedor que va vendre la comanda
-- Codi i nom del cap del venedor que va vendre la comanda
-- Codi i nom del client que va comprar la comanda
-- Codi i nom del venedor assignat al client
-- Ciutat de l'oficina del venedor assignat al client
-- Codi i nom del cap del venedor assignat al client
-- Import de la comanda

SELECT pe.num_pedido, pr.descripcion, re.num_empl, re.nombre, o.ciudad, dir.num_empl, dir.nombre, cl.num_clie, cl.empresa, clven.num_empl, clven.nombre, clvenofi.ciudad, clvendir.num_empl, clvendir.nombre, pe.importe
FROM pedidos pe
LEFT JOIN productos pr 
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN repventas re -- Codi i nom del venedor que va vendre la comanda
ON re.num_empl = pe.rep
LEFT JOIN oficinas o -- Ciutat de l'oficina del venedor que va vendre la comanda
ON o.oficina = re.oficina_rep
LEFT JOIN repventas dir -- Codi i nom del cap del venedor que va vendre la comanda
ON dir.num_empl = re.director
LEFT JOIN clientes cl -- Codi i nom del client que va comprar la comanda
ON cl.num_clie = pe.clie
JOIN repventas clven -- Codi i nom del venedor assignat al client
ON clven.num_empl = cl.rep_clie
LEFT JOIN oficinas clvenofi -- Ciutat de l'oficina del venedor assignat al client
ON clvenofi.oficina = clven.oficina_rep
LEFT JOIN repventas clvendir -- Codi i nom del cap del venedor assignat al client
ON clvendir.num_empl = clven.director
ORDER BY cl.num_clie;


training=# SELECT pe.num_pedido, pr.descripcion
training-# FROM pedidos pe
training-# LEFT JOIN productos pr 
training-# ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab;


num_pedido |    descripcion    
------------+-------------------
     113058 | Cubierta
     112989 | Bancada Motor
     113062 | Bancada Motor
     112975 | Pasador Bisagra
     112961 | Bisagra Izqda.
     113042 | Bisagra Dcha.
     113045 | Bisagra Dcha.
     112993 | V Stago Trinquete
     113034 | V Stago Trinquete
     113027 | Articulo Tipo 2
     112992 | Articulo Tipo 2
     113012 | Articulo Tipo 3
     112997 | Manivela
     113013 | Manivela
     112968 | Articulo Tipo 4
     112963 | Articulo Tipo 4
     112983 | Articulo Tipo 4
     113055 | Ajustador
     113057 | Ajustador
     112987 | Extractor
     110036 | Montador
     112979 | Montador
     113007 | Riostra 1/2-Tm
     113069 | Riostra 1-Tm
     113003 | Riostra 2-Tm
     113048 | Riostra 2-Tm
     113051 | 
     113065 | Reductor
     113049 | Reductor
     113024 | Reductor
(30 rows)



-- FUNCIONA ESTO 1

SELECT pe.num_pedido, pr.descripcion, re.num_empl, re.nombre, o.ciudad -- nombre del producto, Codigo y nombre del vndedor y oficina del vendedor
FROM pedidos pe
LEFT JOIN productos pr
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN repventas re
ON pe.rep = re.num_empl 
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina;

 num_pedido |    descripcion    | num_empl |    nombre     |   ciudad    
------------+-------------------+----------+---------------+-------------
     113058 | Cubierta          |      109 | Mary Jones    | New York
     112989 | Bancada Motor     |      106 | Sam Clark     | New York
     113062 | Bancada Motor     |      107 | Nancy Angelli | Denver
     112975 | Pasador Bisagra   |      103 | Paul Cruz     | Chicago
     112961 | Bisagra Izqda.    |      106 | Sam Clark     | New York
     113042 | Bisagra Dcha.     |      101 | Dan Roberts   | Chicago
     113045 | Bisagra Dcha.     |      108 | Larry Fitch   | Los Angeles
     112993 | V Stago Trinquete |      102 | Sue Smith     | Los Angeles
     113034 | V Stago Trinquete |      110 | Tom Snyder    | 
     113027 | Articulo Tipo 2   |      105 | Bill Adams    | Atlanta
     112992 | Articulo Tipo 2   |      108 | Larry Fitch   | Los Angeles
     113012 | Articulo Tipo 3   |      105 | Bill Adams    | Atlanta
     112997 | Manivela          |      107 | Nancy Angelli | Denver
     113013 | Manivela          |      108 | Larry Fitch   | Los Angeles
     112968 | Articulo Tipo 4   |      101 | Dan Roberts   | Chicago
     112963 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta
     112983 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta
     113055 | Ajustador         |      101 | Dan Roberts   | Chicago
     113057 | Ajustador         |      103 | Paul Cruz     | Chicago
     112987 | Extractor         |      105 | Bill Adams    | Atlanta
     110036 | Montador          |      110 | Tom Snyder    | 
     112979 | Montador          |      102 | Sue Smith     | Los Angeles
     113007 | Riostra 1/2-Tm    |      108 | Larry Fitch   | Los Angeles
     113069 | Riostra 1-Tm      |      107 | Nancy Angelli | Denver
     113003 | Riostra 2-Tm      |      109 | Mary Jones    | New York
     113048 | Riostra 2-Tm      |      102 | Sue Smith     | Los Angeles
     113051 |                   |      108 | Larry Fitch   | Los Angeles
     113065 | Reductor          |      102 | Sue Smith     | Los Angeles
     113049 | Reductor          |      108 | Larry Fitch   | Los Angeles
     113024 | Reductor          |      108 | Larry Fitch   | Los Angeles
(30 rows)



-- FUNCIONA ESTO 2

SELECT pe.num_pedido, pr.descripcion, re.num_empl, re.nombre, o.ciudad, dir.num_empl, dir.nombre -- director del vendedor
FROM pedidos pe
LEFT JOIN productos pr
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN repventas re
ON re.num_empl = pe.rep
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina
LEFT JOIN repventas dir
ON re.oficina_rep = dir.num_empl ; -- SE PUEDE PONER AL REVES ON dir.num_empl = re.director;

 num_pedido |    descripcion    | num_empl |    nombre     |   ciudad    | num_empl |   nombre    
------------+-------------------+----------+---------------+-------------+----------+-------------
     113058 | Cubierta          |      109 | Mary Jones    | New York    |      106 | Sam Clark
     112989 | Bancada Motor     |      106 | Sam Clark     | New York    |          | 
     113062 | Bancada Motor     |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch
     112975 | Pasador Bisagra   |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith
     112961 | Bisagra Izqda.    |      106 | Sam Clark     | New York    |          | 
     113042 | Bisagra Dcha.     |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith
     113045 | Bisagra Dcha.     |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     112993 | V Stago Trinquete |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     113034 | V Stago Trinquete |      110 | Tom Snyder    |             |      101 | Dan Roberts
     113027 | Articulo Tipo 2   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     112992 | Articulo Tipo 2   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113012 | Articulo Tipo 3   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     112997 | Manivela          |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch
     113013 | Manivela          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     112968 | Articulo Tipo 4   |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith
     112963 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     112983 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     113055 | Ajustador         |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith
     113057 | Ajustador         |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith
     112987 | Extractor         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     110036 | Montador          |      110 | Tom Snyder    |             |      101 | Dan Roberts
     112979 | Montador          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     113007 | Riostra 1/2-Tm    |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113069 | Riostra 1-Tm      |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch
     113003 | Riostra 2-Tm      |      109 | Mary Jones    | New York    |      106 | Sam Clark
     113048 | Riostra 2-Tm      |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     113051 |                   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113065 | Reductor          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     113049 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113024 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
(30 rows)





-- FUNCIONA ESTO 3

SELECT pe.num_pedido, pr.descripcion, re.num_empl, re.nombre, o.ciudad, dir.num_empl, dir.nombre, cl.num_clie, cl.empresa -- Cliente que compró la comanda
FROM pedidos pe
LEFT JOIN productos pr
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN repventas re
ON pe.rep = re.num_empl 
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina
LEFT JOIN repventas dir
ON re.director = dir.num_empl 
LEFT JOIN clientes cl
ON pe.clie = cl.num_clie;

 num_pedido |    descripcion    | num_empl |    nombre     |   ciudad    | num_empl |   nombre    | num_clie |      empresa      
------------+-------------------+----------+---------------+-------------+----------+-------------+----------+-------------------
     113058 | Cubierta          |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis
     112989 | Bancada Motor     |      106 | Sam Clark     | New York    |          |             |     2101 | Jones Mfg.
     113062 | Bancada Motor     |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers
     112975 | Pasador Bisagra   |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.
     112961 | Bisagra Izqda.    |      106 | Sam Clark     | New York    |          |             |     2117 | J.P. Sinclair
     113042 | Bisagra Dcha.     |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2113 | Ian & Schmidt
     113045 | Bisagra Dcha.     |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp
     112993 | V Stago Trinquete |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.
     113034 | V Stago Trinquete |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International
     113027 | Articulo Tipo 2   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.
     112992 | Articulo Tipo 2   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems
     113012 | Articulo Tipo 3   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2111 | JCP Inc.
     112997 | Manivela          |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers
     113013 | Manivela          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems
     112968 | Articulo Tipo 4   |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2102 | First Corp.
     112963 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.
     112983 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.
     113055 | Ajustador         |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2108 | Holm & Landis
     113057 | Ajustador         |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.
     112987 | Extractor         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.
     110036 | Montador          |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International
     112979 | Montador          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2114 | Orion Corp
     113007 | Riostra 1/2-Tm    |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp
     113069 | Riostra 1-Tm      |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2109 | Chen Associates
     113003 | Riostra 2-Tm      |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis
     113048 | Riostra 2-Tm      |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2120 | Rico Enterprises
     113051 |                   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems
     113065 | Reductor          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.
     113049 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems
     113024 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2114 | Orion Corp
(30 rows)
 
 
 
 -- FUNCIONA ESTO 4

SELECT pe.num_pedido, pr.descripcion, re.num_empl, re.nombre, o.ciudad, dir.num_empl, dir.nombre, cl.num_clie, cl.empresa, clven.num_empl, clven.nombre -- Codi i nom del venedor assignat al client 
FROM pedidos pe
LEFT JOIN productos pr 
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN repventas re
ON pe.rep = re.num_empl
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina 
LEFT JOIN repventas dir
ON re.director = dir.num_empl
LEFT JOIN clientes cl
ON pe.clie = cl.num_clie
JOIN repventas clven
ON cl.rep_clie = clven.num_empl
ORDER BY cl.num_clie;


 num_pedido |    descripcion    | num_empl |    nombre     |   ciudad    | num_empl |   nombre    | num_clie |      empresa      | num_empl |    nombre     
------------+-------------------+----------+---------------+-------------+----------+-------------+----------+-------------------+----------+---------------
     113058 | Cubierta          |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis     |      109 | Mary Jones
     112989 | Bancada Motor     |      106 | Sam Clark     | New York    |          |             |     2101 | Jones Mfg.        |      106 | Sam Clark
     113062 | Bancada Motor     |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers    |      107 | Nancy Angelli
     112975 | Pasador Bisagra   |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz
     112961 | Bisagra Izqda.    |      106 | Sam Clark     | New York    |          |             |     2117 | J.P. Sinclair     |      106 | Sam Clark
     113042 | Bisagra Dcha.     |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2113 | Ian & Schmidt     |      104 | Bob Smith
     113045 | Bisagra Dcha.     |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp          |      108 | Larry Fitch
     112993 | V Stago Trinquete |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.  |      102 | Sue Smith
     113034 | V Stago Trinquete |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International |      110 | Tom Snyder
     113027 | Articulo Tipo 2   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams
     112992 | Articulo Tipo 2   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch
     113012 | Articulo Tipo 3   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz
     112997 | Manivela          |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers    |      107 | Nancy Angelli
     113013 | Manivela          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch
     112968 | Articulo Tipo 4   |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2102 | First Corp.       |      101 | Dan Roberts
     112963 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams
     112983 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams
     113055 | Ajustador         |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2108 | Holm & Landis     |      109 | Mary Jones
     113057 | Ajustador         |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz
     112987 | Extractor         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams
     110036 | Montador          |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International |      110 | Tom Snyder
     112979 | Montador          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2114 | Orion Corp        |      102 | Sue Smith
     113007 | Riostra 1/2-Tm    |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp          |      108 | Larry Fitch
     113069 | Riostra 1-Tm      |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2109 | Chen Associates   |      103 | Paul Cruz
     113003 | Riostra 2-Tm      |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis     |      109 | Mary Jones
     113048 | Riostra 2-Tm      |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2120 | Rico Enterprises  |      102 | Sue Smith
     113051 |                   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch
     113065 | Reductor          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.  |      102 | Sue Smith
     113049 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch
     113024 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2114 | Orion Corp        |      102 | Sue Smith
(30 rows)


 -- FUNCIONA ESTO 5

SELECT pe.num_pedido, pr.descripcion, re.num_empl, re.nombre, o.ciudad, dir.num_empl, dir.nombre, cl.num_clie, cl.empresa, clven.num_empl, clven.nombre, clvenofi.ciudad -- Ciutat de l'oficina del venedor assignat al client 
FROM pedidos pe
LEFT JOIN productos pr 
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN repventas re
ON pe.rep = re.num_empl
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina 
LEFT JOIN repventas dir
ON re.director = dir.num_empl
LEFT JOIN clientes cl
ON pe.clie = cl.num_clie 
JOIN repventas clven
ON cl.rep_clie = clven.num_empl 
LEFT JOIN oficinas clvenofi
ON clven.oficina_rep = clvenofi.oficina
ORDER BY cl.num_clie;

 num_pedido |    descripcion    | num_empl |    nombre     |   ciudad    | num_empl |   nombre    | num_clie |      empresa      | num_empl |    nombre     |   ciudad    
------------+-------------------+----------+---------------+-------------+----------+-------------+----------+-------------------+----------+---------------+-------------
     112989 | Bancada Motor     |      106 | Sam Clark     | New York    |          |             |     2101 | Jones Mfg.        |      106 | Sam Clark     | New York
     112968 | Articulo Tipo 4   |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2102 | First Corp.       |      101 | Dan Roberts   | Chicago
     113027 | Articulo Tipo 2   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta
     112987 | Extractor         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta
     112983 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta
     112963 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta
     113065 | Reductor          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.  |      102 | Sue Smith     | Los Angeles
     112993 | V Stago Trinquete |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.  |      102 | Sue Smith     | Los Angeles
     110036 | Montador          |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International |      110 | Tom Snyder    | 
     113034 | V Stago Trinquete |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International |      110 | Tom Snyder    | 
     113058 | Cubierta          |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York
     113055 | Ajustador         |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York
     113003 | Riostra 2-Tm      |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York
     113069 | Riostra 1-Tm      |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2109 | Chen Associates   |      103 | Paul Cruz     | Chicago
     113012 | Articulo Tipo 3   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago
     113057 | Ajustador         |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago
     112975 | Pasador Bisagra   |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago
     113045 | Bisagra Dcha.     |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp          |      108 | Larry Fitch   | Los Angeles
     113007 | Riostra 1/2-Tm    |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp          |      108 | Larry Fitch   | Los Angeles
     113042 | Bisagra Dcha.     |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2113 | Ian & Schmidt     |      104 | Bob Smith     | Chicago
     113024 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2114 | Orion Corp        |      102 | Sue Smith     | Los Angeles
     112979 | Montador          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2114 | Orion Corp        |      102 | Sue Smith     | Los Angeles
     112961 | Bisagra Izqda.    |      106 | Sam Clark     | New York    |          |             |     2117 | J.P. Sinclair     |      106 | Sam Clark     | New York
     113013 | Manivela          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles
     112992 | Articulo Tipo 2   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles
     113049 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles
     113051 |                   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles
     113048 | Riostra 2-Tm      |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2120 | Rico Enterprises  |      102 | Sue Smith     | Los Angeles
     113062 | Bancada Motor     |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers    |      107 | Nancy Angelli | Denver
     112997 | Manivela          |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers    |      107 | Nancy Angelli | Denver
(30 rows)



 -- FUNCIONA ESTO 6

SELECT pe.num_pedido, pr.descripcion, re.num_empl, re.nombre, o.ciudad, dir.num_empl, dir.nombre, cl.num_clie, cl.empresa, clven.num_empl, clven.nombre, clvenofi.ciudad, clvendir.num_empl, clvendir.nombre -- Codi i nom del cap del venedor assignat al client 
FROM pedidos pe
LEFT JOIN productos pr 
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN repventas re
ON pe.rep = re.num_empl
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina
LEFT JOIN repventas dir
ON re.director = dir.num_empl
LEFT JOIN clientes cl
ON pe.clie = cl.num_clie 
JOIN repventas clven
ON cl.rep_clie = clven.num_empl
LEFT JOIN oficinas clvenofi
ON clven.oficina_rep = clvenofi.oficina
LEFT JOIN repventas clvendir
ON clven.director = clvendir.num_empl
ORDER BY cl.num_clie;



 num_pedido |    descripcion    | num_empl |    nombre     |   ciudad    | num_empl |   nombre    | num_clie |      empresa      | num_empl |    nombre     |   ciudad    | num_empl |   nombre    
------------+-------------------+----------+---------------+-------------+----------+-------------+----------+-------------------+----------+---------------+-------------+----------+-------------
     112989 | Bancada Motor     |      106 | Sam Clark     | New York    |          |             |     2101 | Jones Mfg.        |      106 | Sam Clark     | New York    |          | 
     112968 | Articulo Tipo 4   |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2102 | First Corp.       |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith
     113027 | Articulo Tipo 2   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     112987 | Extractor         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     112983 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     112963 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith
     113065 | Reductor          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.  |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     112993 | V Stago Trinquete |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.  |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     110036 | Montador          |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International |      110 | Tom Snyder    |             |      101 | Dan Roberts
     113034 | V Stago Trinquete |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International |      110 | Tom Snyder    |             |      101 | Dan Roberts
     113058 | Cubierta          |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York    |      106 | Sam Clark
     113055 | Ajustador         |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York    |      106 | Sam Clark
     113003 | Riostra 2-Tm      |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York    |      106 | Sam Clark
     113069 | Riostra 1-Tm      |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2109 | Chen Associates   |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith
     113012 | Articulo Tipo 3   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith
     113057 | Ajustador         |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith
     112975 | Pasador Bisagra   |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith
     113045 | Bisagra Dcha.     |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113007 | Riostra 1/2-Tm    |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113042 | Bisagra Dcha.     |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2113 | Ian & Schmidt     |      104 | Bob Smith     | Chicago     |      106 | Sam Clark
     113024 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2114 | Orion Corp        |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     112979 | Montador          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2114 | Orion Corp        |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     112961 | Bisagra Izqda.    |      106 | Sam Clark     | New York    |          |             |     2117 | J.P. Sinclair     |      106 | Sam Clark     | New York    |          | 
     113013 | Manivela          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     112992 | Articulo Tipo 2   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113049 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113051 |                   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark
     113048 | Riostra 2-Tm      |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2120 | Rico Enterprises  |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch
     113062 | Bancada Motor     |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers    |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch
     112997 | Manivela          |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers    |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch
(30 rows)





 -- FUNCIONA ESTO 7 FINAAAL

SELECT pe.num_pedido, pr.descripcion, re.num_empl, re.nombre, o.ciudad, dir.num_empl, dir.nombre, cl.num_clie, cl.empresa, clven.num_empl, clven.nombre, clvenofi.ciudad, clvendir.num_empl, clvendir.nombre, pe.importe -- Codi i nom del cap del venedor assignat al client 
FROM pedidos pe
LEFT JOIN productos pr 
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN repventas re
ON pe.rep = re.num_empl
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina 
LEFT JOIN repventas dir
ON re.director = dir.num_empl
LEFT JOIN clientes cl
ON pe.clie = cl.num_clie 
JOIN repventas clven
ON cl.rep_clie = clven.num_empl
LEFT JOIN oficinas clvenofi
ON clven.oficina_rep = clvenofi.oficina
LEFT JOIN repventas clvendir
ON clven.director = clvendir.num_empl
ORDER BY cl.num_clie;


 num_pedido |    descripcion    | num_empl |    nombre     |   ciudad    | num_empl |   nombre    | num_clie |      empresa      | num_empl |    nombre     |   ciudad    | num_empl |   nombre    | importe  
------------+-------------------+----------+---------------+-------------+----------+-------------+----------+-------------------+----------+---------------+-------------+----------+-------------+----------
     112989 | Bancada Motor     |      106 | Sam Clark     | New York    |          |             |     2101 | Jones Mfg.        |      106 | Sam Clark     | New York    |          |             |  1458.00
     112968 | Articulo Tipo 4   |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2102 | First Corp.       |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |  3978.00
     113027 | Articulo Tipo 2   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |  4104.00
     112987 | Extractor         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   | 27500.00
     112983 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |   702.00
     112963 | Articulo Tipo 4   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2103 | Acme Mfg.         |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |  3276.00
     113065 | Reductor          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.  |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |  2130.00
     112993 | V Stago Trinquete |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2106 | Fred Lewis Corp.  |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |  1896.00
     110036 | Montador          |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International |      110 | Tom Snyder    |             |      101 | Dan Roberts | 22500.00
     113034 | V Stago Trinquete |      110 | Tom Snyder    |             |      101 | Dan Roberts |     2107 | Ace International |      110 | Tom Snyder    |             |      101 | Dan Roberts |   632.00
     113058 | Cubierta          |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York    |      106 | Sam Clark   |  1480.00
     113055 | Ajustador         |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York    |      106 | Sam Clark   |   150.00
     113003 | Riostra 2-Tm      |      109 | Mary Jones    | New York    |      106 | Sam Clark   |     2108 | Holm & Landis     |      109 | Mary Jones    | New York    |      106 | Sam Clark   |  5625.00
     113069 | Riostra 1-Tm      |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2109 | Chen Associates   |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   | 31350.00
     113012 | Articulo Tipo 3   |      105 | Bill Adams    | Atlanta     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |  3745.00
     113057 | Ajustador         |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |   600.00
     112975 | Pasador Bisagra   |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |     2111 | JCP Inc.          |      103 | Paul Cruz     | Chicago     |      104 | Bob Smith   |  2100.00
     113045 | Bisagra Dcha.     |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   | 45000.00
     113007 | Riostra 1/2-Tm    |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2112 | Zetacorp          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |  2925.00
     113042 | Bisagra Dcha.     |      101 | Dan Roberts   | Chicago     |      104 | Bob Smith   |     2113 | Ian & Schmidt     |      104 | Bob Smith     | Chicago     |      106 | Sam Clark   | 22500.00
     113024 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2114 | Orion Corp        |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |  7100.00
     112979 | Montador          |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2114 | Orion Corp        |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch | 15000.00
     112961 | Bisagra Izqda.    |      106 | Sam Clark     | New York    |          |             |     2117 | J.P. Sinclair     |      106 | Sam Clark     | New York    |          |             | 31500.00
     113013 | Manivela          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |   652.00
     112992 | Articulo Tipo 2   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |   760.00
     113049 | Reductor          |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |   776.00
     113051 |                   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |     2118 | Midwest Systems   |      108 | Larry Fitch   | Los Angeles |      106 | Sam Clark   |  1420.00
     113048 | Riostra 2-Tm      |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |     2120 | Rico Enterprises  |      102 | Sue Smith     | Los Angeles |      108 | Larry Fitch |  3750.00
     113062 | Bancada Motor     |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers    |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |  2430.00
     112997 | Manivela          |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |     2124 | Peter Brothers    |      107 | Nancy Angelli | Denver      |      108 | Larry Fitch |   652.00
(30 rows)
