-- PRÀCTICA 13. WHERE + GROUP BY + JOIN + UNION

-- 1. Visualitzar tota la informació de cada client demanat,la quantitat de comanes que ha fet, la informació de les compres realitzades 
-- per cada client i el total d''import comprat per cada client. Si un client no ha comprat mai no s''han de mostrar els seus totals. 
-- La informació ha de sortir ordenada per codi de client. Els clients que es demanen són :

-- Clients amb un nom acabat amb 'International' o amb un nom acabat amb 'Corp.' o amb un nom
-- que no comenci ni en 'A' ni en 'B' ni en 'C' ni en 'D' ni en 'O' ni en 'P' ni en 'J'.

select 'Cliente:',num_clie,empresa,count(pedidos.*),null as num_pedido,null as producto,'TOTAL:' as fab,sum(importe) as importe from clientes
    left join pedidos on num_clie=clie
where (empresa like '%International' or empresa like '%Corp.') or not (empresa like 'A%' or empresa like 'B%' or empresa like 'C%' or empresa like 'D%' or empresa like 'O%' or empresa like 'P%' or empresa like 'J%')
group by num_clie

union

select 'Pedidos:',num_clie,empresa,null,num_pedido,producto,fab,importe from clientes
    left join pedidos on num_clie=clie
where (empresa like '%International' or empresa like '%Corp.') or not (empresa like 'A%' or empresa like 'B%' or empresa like 'C%' or empresa like 'D%' or empresa like 'O%' or empresa like 'P%' or empresa like 'J%')
group by num_clie,num_pedido,producto,fab

order by num_clie,1;

 ?column? | num_clie |      empresa      | count | num_pedido | producto |  fab   | importe  
----------+----------+-------------------+-------+------------+----------+--------+----------
 Cliente: |     2102 | First Corp.       |     1 |            |          | TOTAL: |  3978.00
 Pedidos: |     2102 | First Corp.       |       |     112968 | 41004    | aci    |  3978.00
 Cliente: |     2106 | Fred Lewis Corp.  |     2 |            |          | TOTAL: |  4026.00
 Pedidos: |     2106 | Fred Lewis Corp.  |       |     112993 | 2a45c    | rei    |  1896.00
 Pedidos: |     2106 | Fred Lewis Corp.  |       |     113065 | xk47     | qsa    |  2130.00
 Cliente: |     2107 | Ace International |     2 |            |          | TOTAL: | 23132.00
 Pedidos: |     2107 | Ace International |       |     110036 | 4100z    | aci    | 22500.00
 Pedidos: |     2107 | Ace International |       |     113034 | 2a45c    | rei    |   632.00
 Cliente: |     2108 | Holm & Landis     |     3 |            |          | TOTAL: |  7255.00
 Pedidos: |     2108 | Holm & Landis     |       |     113058 | 112      | fea    |  1480.00
 Pedidos: |     2108 | Holm & Landis     |       |     113003 | 779c     | imm    |  5625.00
 Pedidos: |     2108 | Holm & Landis     |       |     113055 | 4100x    | aci    |   150.00
 Cliente: |     2112 | Zetacorp          |     2 |            |          | TOTAL: | 47925.00
 Pedidos: |     2112 | Zetacorp          |       |     113007 | 773c     | imm    |  2925.00
 Pedidos: |     2112 | Zetacorp          |       |     113045 | 2a44r    | rei    | 45000.00
 Cliente: |     2113 | Ian & Schmidt     |     1 |            |          | TOTAL: | 22500.00
 Pedidos: |     2113 | Ian & Schmidt     |       |     113042 | 2a44r    | rei    | 22500.00
 Cliente: |     2115 | Smithson Corp.    |     0 |            |          | TOTAL: |         
 Pedidos: |     2115 | Smithson Corp.    |       |            |          |        |         
 Cliente: |     2118 | Midwest Systems   |     4 |            |          | TOTAL: |  3608.00
 Pedidos: |     2118 | Midwest Systems   |       |     113049 | xk47     | qsa    |   776.00
 Pedidos: |     2118 | Midwest Systems   |       |     113051 | k47      | qsa    |  1420.00
 Pedidos: |     2118 | Midwest Systems   |       |     113013 | 41003    | bic    |   652.00
 Pedidos: |     2118 | Midwest Systems   |       |     112992 | 41002    | aci    |   760.00
 Cliente: |     2119 | Solomon Inc.      |     0 |            |          | TOTAL: |         
 Pedidos: |     2119 | Solomon Inc.      |       |            |          |        |         
 Cliente: |     2120 | Rico Enterprises  |     1 |            |          | TOTAL: |  3750.00
 Pedidos: |     2120 | Rico Enterprises  |       |     113048 | 779c     | imm    |  3750.00
 Cliente: |     2121 | QMA Assoc.        |     0 |            |          | TOTAL: |         
 Pedidos: |     2121 | QMA Assoc.        |       |            |          |        |         
 Cliente: |     2122 | Three-Way Lines   |     0 |            |          | TOTAL: |         
 Pedidos: |     2122 | Three-Way Lines   |       |            |          |        |         
(32 rows)

-- 2. Visualitzar tota la informació de cada producte demanat i la quantitat de comandes fetes per aquell producte, la informació de les ventes 
-- fetes de cada producte i el total de l''import venut de cada producte. Si un producte no s'ha venut també ha de sortir. La informació 
-- ha d'estar ordenada per codi de fàbrica i codi de producte. Els productes que es demanen són : 
-- Productes de les fàbriques rei, aci i qsa amb preus entre 75 i 200.
select ,,,,, from clientes
    join pedidos on id_fab=fab and id_producto=producto
where (id_fab='rei' or id_fab='aci' or id_fab='qsa') and precio between 75 and 200
group by id_fab,id_producto;

-- 3. Visualitzar tota la informació de cada venedor demanat i la quantitat de comanes que ha fet; la informació de totes les ventes realitzades
-- per cada venedor i el total d'import venut per cada venedor. Si un venedor no ha venut res també s'ha de mostrar. La informació ha de sortir
-- ordenada per codi de venedor. Els venedors que es demanen són :
-- Venedors majors de 32 anys, amb un nom començat per 'S' or per 'B' o per 'N' 


-- 4. Visualitzar tota la informació de cada oficina demanada i el número de venedors que té; la informació de tots els venedors assignats a la oficina
-- i el número de cliens assignat a cada venedor i la informació de tots els clients assignats a cada venedor. 
-- Si una oficina no té venedors també ha de sortir. 
-- Si un venedor no té clients assignats ha de sortir igualment. 
-- La informació ha de sortir ordenada per codi d'oficina i codi de venedor. 
-- Les oficines que es demanen són:
-- Oficines de ciutats que continguin alguna 'a' o alguna 'e' i amb un objectiu més gran de 300.000 


