1. Visualitzar tota la informació de cada client demanat i la quantitat de comanes que ha fet; la informació de les compres realitzades per cada client i el total d'import comprat per cada client. Si un client no ha comprat mai no s'han de mostrar els seus totals. La informació ha de sortir ordenada per codi de client. Els clients que es demanen són :

Clients amb un nom acabat amb 'International' o amb un nom acabat amb 'Corp.' o amb un nom que no comenci ni en 'A' ni en 'B' ni en 'C' ni en 'D' ni en 'O' ni en 'P' ni en 'J'.

   tip    | num_clie |      empresa      | rep_clie | limite_credito | comandes |  import  
----------+----------+-------------------+----------+----------------+----------+----------
 Client:  |     2102 | First Corp.       |      101 |       65000.00 |        1 |         
 Compra:  |     2102 |                   |          |                |          |  3978.00
 ...Total |     2102 |                   |          |                |          |  3978.00
 Client:  |     2106 | Fred Lewis Corp.  |      102 |       65000.00 |        2 |         
 Compra:  |     2106 |                   |          |                |          |  1896.00
 Compra:  |     2106 |                   |          |                |          |  2130.00
 ...Total |     2106 |                   |          |                |          |  4026.00
 Client:  |     2107 | Ace International |      110 |       35000.00 |        2 |         
 Compra:  |     2107 |                   |          |                |          |   632.00
 Compra:  |     2107 |                   |          |                |          | 22500.00
 ...Total |     2107 |                   |          |                |          | 23132.00
 Client:  |     2108 | Holm & Landis     |      109 |       55000.00 |        3 |         
 Compra:  |     2108 |                   |          |                |          |   150.00
 Compra:  |     2108 |                   |          |                |          |  5625.00
 Compra:  |     2108 |                   |          |                |          |  1480.00
 ...Total |     2108 |                   |          |                |          |  7255.00

SELECT 'Client:' as tip, clientes.*, count(*) as comandes, null as Import FROM clientes JOIN pedidos ON num_clie=clie WHERE (empresa NOT ILIKE 'a%' AND empresa NOT ILIKE 'b%' AND empresa NOT ILIKE 'c%' AND empresa NOT ILIKE 'd%' AND empresa NOT ILIKE 'o%' AND empresa NOT ILIKE 'p%' AND empresa NOT ILIKE 'j%') OR empresa ILIKE '%Corp.' OR empresa ILIKE '%International' GROUP by num_clie 
UNION 
SELECT 'Compra:', clie, null, null, null, null, importe FROM clientes JOIN pedidos ON num_clie=clie WHERE (empresa NOT ILIKE 'a%' AND empresa NOT ILIKE 'b%' AND empresa NOT ILIKE 'c%' AND empresa NOT ILIKE 'd%' AND empresa NOT ILIKE 'o%' AND empresa NOT ILIKE 'p%' AND empresa NOT ILIKE 'j%') OR empresa ILIKE '%Corp.' OR empresa ILIKE '%International' 
UNION 
SELECT 'XXXTotal', clie, null, null, null, null,sum(importe) FROM clientes JOIN pedidos ON num_clie=clie WHERE (empresa NOT ILIKE 'a%' AND empresa NOT ILIKE 'b%' AND empresa NOT ILIKE 'c%' AND empresa NOT ILIKE 'd%' AND empresa NOT ILIKE 'o%' AND empresa NOT ILIKE 'p%' AND empresa NOT ILIKE 'j%') OR empresa ILIKE '%Corp.' OR empresa ILIKE '%International' GROUP by clie 
ORDER BY 2,1;

2. Visualitzar tota la informació de cada producte demanat i la quantitat de comandes fetes per aquell producte, la informació de les ventes fetes de cada producte i el total de l'import venut de cada producte. Si un producte no s'ha venut també ha de sortir. La informació ha d'estar ordenada per codi de fàbrica i codi de producte. Els productes que es demanen són : 

Productes de les fàbriques rei, aci i qsa amb preus entre 75 i 200.

    tip    | id_fab | id_producto |    descripcion    | precio | existencias | comandes | venedor | quantitat | import  
-----------+--------+-------------+-------------------+--------+-------------+----------+---------+-----------+---------
 Producte: | aci    | 41002       | Articulo Tipo 2   |  76.00 |         167 |        2 |         |           |        
 comanda:  | aci    | 41002       |                   |        |             |     2103 |     105 |        54 | 4104.00
 comanda:  | aci    | 41002       |                   |        |             |     2118 |     108 |        10 |  760.00
 ...Total  | aci    | 41002       |                   |        |             |          |         |           | 4864.00
 Producte: | aci    | 41003       | Articulo Tipo 3   | 107.00 |         207 |        1 |         |           |        
 comanda:  | aci    | 41003       |                   |        |             |     2111 |     105 |        35 | 3745.00
 ...Total  | aci    | 41003       |                   |        |             |          |         |           | 3745.00

SELECT 'Producte:' as tip, productos.*, count(fab) as comandes, null as Venedor, null as Quantitat, null as Import FROM productos  LEFT JOIN pedidos ON id_fab=fab AND id_producto=producto WHERE (id_fab='rei' OR id_fab='aci' OR id_fab='qsa') AND (precio >=75 AND precio <=200) GROUP BY id_fab, id_producto 
UNION 
SELECT 'Venta:', id_fab, id_producto, null, null, null, clie, rep, cant, importe  FROM productos JOIN pedidos ON id_fab=fab AND id_producto=producto WHERE (id_fab='rei' OR id_fab='aci' OR id_fab='qsa') AND (precio >=75 AND precio <=200) 
UNION 
select 'XXXTotal', id_fab, id_producto,null, null, null, null, null, null, sum(importe)  FROM productos JOIN pedidos ON id_fab=fab AND id_producto=producto WHERE (id_fab='rei' OR id_fab='aci' OR id_fab='qsa') AND (precio >=75 AND precio <=200) GROUP by id_fab, id_producto 
ORDER by id_fab, id_producto, tip;

3. Visualitzar tota la informació de cada venedor demanat i la quantitat de comanes que ha fet; la informació de totes les ventes realitzades per cada venedor i el total d'import venut per cada venedor. Si un venedor no ha venut res també s'ha de mostrar. La informació ha de sortir ordenada per codi de venedor. Els venedors que es demanen són :

Venedors majors de 32 anys, amb un nom començat per 'S' or per 'B' o per 'N' 


    tip    | num_empl |    nombre     | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   | ventas    | comandes | client |  import  
-----------+----------+---------------+------+-------------+------------+------------+----------+-----------+-----------+----------+--------+----------
 Venedor:  |      102 | Sue Smith     |   48 |          21 | Rep vendas | 1986-12-10 |      108 | 350000.00 | 474050.00 |        4 |        |         
 comanda:  |      102 |               |      |             |            |            |          |           |           |          |   2120 |  3750.00
 comanda:  |      102 |               |      |             |            |            |          |           |           |          |   2106 |  2130.00
 comanda:  |      102 |               |      |             |            |            |          |           |           |          |   2106 |  1896.00
 comanda:  |      102 |               |      |             |            |            |          |           |           |          |   2114 | 15000.00
 ...Total: |      102 |               |      |             |            |            |          |           |           |          |        | 22776.00

select 'Venedor:' as tip, repventas.*, count(rep) as comandes, null as client, null as import from repventas LEFT JOIN pedidos on rep=num_empl where (nombre ilike 's%' or nombre ilike 'n%' or nombre ilike 'b%') and edad >32 GROUP by num_empl 
UNION 
SELECT 'Venta:' as tip, rep, null, null, null, null, null, null,  null, null, null, clie, importe from pedidos RIGTH JOIN repventas on rep=num_empl where (nombre ilike 's%' or nombre ilike 'n%' or nombre ilike 'b%') and edad >32 
UNION 
SELECT 'XXXTotal:' as tip, rep, null, null, null, null, null, null,  null, null, null, null, sum(importe) from pedidos RIGTH JOIN repventas on rep=num_empl where (nombre ilike 's%' or nombre ilike 'n%' or nombre ilike 'b%') and edad >32 GROUP by rep 
ORDER by 2, 1; 

4. Visualitzar tota la informació de cada oficina demanada i el número de venedors que té; la informació de tots els venedors assignats a la oficina i el número de cliens assignat a cada venedor; i la informació de tots els clients assignats a cada venedor. Si una oficina no té venedors també ha de sortir. Si un venedor no té clients assignats ha de sortir igualment. La informació ha de sortir ordenada per codi d'oficina i codi de venedor. Les oficines que es demanen són:

Oficines de ciutats que continguin alguna 'a' o alguna 'e' i amb un objectiu més gran de 300.000 


       tip       | oficina |   ciudad    | region | dir | objetivo  |  ventas   | venedors | venedor | nomvenedor  | numclients | codclient |    nomclient     
-----------------+---------+-------------+--------+-----+-----------+-----------+----------+---------+-------------+------------+-----------+------------------
 Oficina:        |      11 | New York    | Este   | 106 | 575000.00 | 692637.00 |        2 |       0 |             |            |         0 | 
 ...Treballador: |      11 |             |        |     |           |           |          |     106 | Sam Clark   |          2 |           | 
 ......Client:   |      11 |             |        |     |           |           |          |     106 |             |            |      2117 | J.P. Sinclair
 ......Client:   |      11 |             |        |     |           |           |          |     106 |             |            |      2101 | Jones Mfg.
 ...Treballador: |      11 |             |        |     |           |           |          |     109 | Mary Jones  |          2 |           | 
 ......Client:   |      11 |             |        |     |           |           |          |     109 |             |            |      2119 | Solomon Inc.
 ......Client:   |      11 |             |        |     |           |           |          |     109 |             |            |      2108 | Holm & Landis
 
SELECT 'Oficina:' as tip, oficinas.*,  count(*) as venedors,0 as venedor, null as nomvenedor, null as numclient, 0 as codclient, null as nomclient FROM oficinas LEFT JOIN repventas ON oficina=oficina_rep WHERE (ciudad ILIKE '%a%' OR ciudad ILIKE '%e%') and objetivo > 300000 GROUP BY oficina 
UNION 
SELECT 'XXXTreballador:', oficina, null, null, null, null, null, null, num_empl, nombre, count(*), null, null FROM oficinas LEFT JOIN repventas ON oficina=oficina_rep LEFT JOIN clientes on num_empl= rep_clie WHERE (ciudad ILIKE '%a%' OR ciudad ILIKE '%e%') and objetivo > 300000 GROUP by oficina, num_empl 
UNION 
SELECT 'XXXXXXClient:', oficina , null, null, null, null, null, null, num_empl, null, null, num_clie, empresa FROM oficinas LEFT JOIN repventas ON oficina=oficina_rep LEFT JOIN clientes on num_empl= rep_clie WHERE (ciudad ILIKE '%a%' OR ciudad ILIKE '%e%') and objetivo > 300000 
ORDER by 2,9, 1; 