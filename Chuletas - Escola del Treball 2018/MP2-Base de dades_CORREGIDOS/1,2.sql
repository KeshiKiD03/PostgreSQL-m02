
 -- Mostrar les dades dels productes que son dalguna de les fabriques seguents: 
 -- REI ACI IMM i tenen un preu superior a 50 i inferior a 100.
 
select * from productos where (id_fab='rei' or id_fab='aci' or id_fab='imm') and precio>50 and precio<100;

-- Mostrar totes les dades dels productes que tenen una descripcio  
-- que conte ‘el’ o ‘ma’ o ‘ce’ i a mes a mes, un preu superior a 1000 o inferior a 100.


select * from productos where (descripcion like '%el%' or descripcion like '%ma%' or descripcion like '%ce%') 
and (precio>1000 or precio<100);


