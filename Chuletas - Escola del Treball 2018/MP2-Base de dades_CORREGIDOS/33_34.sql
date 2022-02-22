
-- 2.33- Identificador i descripció dels productes del fabricant identificat 
-- per imm dels quals hi hagin existències superiors o iguals 200, 
-- també del fabricant bic amb existències superiors o iguals a 50.

select id_fab,id_producto,descripcion,existencias from productos where (id_fab='imm' and existencias>=200) or (id_fab='bic' and existencias>=50);

-- 2.34- Identificador i nom dels venedors que treballen a les oficines 11, 12 o 22 i compleixen algun dels següents supòsits:
-- a) han estat contractats a partir de juny del 1988 i no tenen director
-- b) estan per sobre la quota però tenen vendes de 600000 o menors.

select num_empl,nombre,oficina_rep from repventas where (oficina_rep=11 or oficina_rep=12 or oficina_rep=22) 
and ((contrato>='1988-06-01' and director is NULL) or (ventas>cuota and ventas<=600000));
