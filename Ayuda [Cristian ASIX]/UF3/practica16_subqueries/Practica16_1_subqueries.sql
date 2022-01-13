-- 1-1 Quins són els productes amb un preu inferior al 10% del preu del 
--- producte més car? 

SELECT id_producto
FROM productos
WHERE precio < (SELECT MAX(precio) FROM productos)* 0.1;


-- 1-2 I els d'un preu inferior al 5% del producte més car?
SELECT id_producto
FROM productos
WHERE precio < (SELECT MAX(precio) FROM productos)* 0.05;


-- 2- Quin és el 2n client que compra més (en import)?

SELECT empresa, (SELECT SUM(importe) FROM pedidos WHERE num_clie = clie)
FROM clientes
WHERE num_clie IN (SELECT clie FROM pedidos)
ORDER BY 2 DESC
LIMIT 1
OFFSET 1;



-- 3- Quin és el 3r client que compra menys (en import)?

SELECT empresa, (SELECT SUM(importe) FROM pedidos WHERE num_clie = clie)
FROM clientes
WHERE num_clie IN (SELECT clie FROM pedidos)
ORDER BY 2
LIMIT 1
OFFSET 2;


-- 4- Dels 10 productes més venuts, quin és el més car?

SELECT producto, SUM(cant), (SELECT precio FROM productos WHERE id_producto = producto and id_fab = fab) 
FROM pedidos
GROUP BY 1,3
ORDER BY SUM(cant) DESC
LIMIT 10;



-- 5- Llista els  clients que tenen un total d'import gastat amb una diferència màxima del 40% de l'import que ha gastat el millor client.

