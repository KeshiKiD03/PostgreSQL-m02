-- --------------------------------------------
--    CASE WHEN ELSE END
-- --------------------------------------------

-- 1.- Llistar l'identificador i el nom dels representants de vendes. Mostrar un camp anomenat "result" que mostri 0 si la quota és inferior a les vendes, en cas contrari ha de mostrar 1 a no ser que sigui director d'oficina, en aquest cas ha de mostrar 2.
select num_empl,nombre,
case
    when cuota > ventas and num_empl in (select dir from oficinas) then 2
    when cuota > ventas and not (num_empl in (select dir from oficinas)) then 1
    else 0
end as result  
from repventas;
 num_empl |    nombre     | result 
----------+---------------+--------
      105 | Bill Adams    |      0
      109 | Mary Jones    |      0
      102 | Sue Smith     |      0
      106 | Sam Clark     |      0
      104 | Bob Smith     |      2
      101 | Dan Roberts   |      0
      110 | Tom Snyder    |      0
      108 | Larry Fitch   |      0
      103 | Paul Cruz     |      0
      107 | Nancy Angelli |      1
(10 rows)


-- 2.- Llistar tots els productes amb totes les seves dades afegint un nou camp anomenat "div". El camp div ha de contenir el resultat de la divisió entre el preu i les existències. En cas de divisió per zero, es canviarà el resultat a 0.
select id_fab,id_producto,
case
    when existencias = 0 then  0
    else precio / existencias
end as div
from productos;
 id_fab | id_producto |          div           
--------+-------------+------------------------
 rei    | 2a45c       | 0.37619047619047619048
 aci    | 4100y       |   110.0000000000000000
 qsa    | xk47        |     9.3421052631578947
 bic    | 41672       |                      0
 imm    | 779c        |   208.3333333333333333
 aci    | 41003       | 0.51690821256038647343
 aci    | 41004       | 0.84172661870503597122
 bic    | 41003       |   217.3333333333333333
 imm    | 887p        |    10.4166666666666667
 qsa    | xk48        | 0.66009852216748768473
 rei    | 2a44l       |   375.0000000000000000
 fea    | 112         |     1.2869565217391304
 imm    | 887h        | 0.24215246636771300448
 bic    | 41089       |     2.8846153846153846
 aci    | 41001       | 0.19855595667870036101
 imm    | 775c        |   285.0000000000000000
 aci    | 4100z       |    89.2857142857142857
 qsa    | xk48a       |     3.1621621621621622
 aci    | 41002       | 0.45508982035928143713
 rei    | 2a44r       |   375.0000000000000000
 imm    | 773c        |    34.8214285714285714
 aci    | 4100x       | 0.67567567567567567568
 fea    | 114         |    16.2000000000000000
 imm    | 887x        |    14.8437500000000000
 rei    | 2a44g       |    25.0000000000000000
(25 rows)

-- 3.- Afegir una condició a la sentència de l'exercici anterior per tal de nomès mostrar aquells productes que el valor del camp div és menor a 1.
select id_fab,id_producto,
case
    when existencias != 0 then precio / existencias
    else 0
end as div
from productos
where case
    when existencias = 0 then 0
    else precio / existencias
end < 1;
 id_fab | id_producto |          div           
--------+-------------+------------------------
 rei    | 2a45c       | 0.37619047619047619048
 bic    | 41672       |                      0
 aci    | 41003       | 0.51690821256038647343
 aci    | 41004       | 0.84172661870503597122
 qsa    | xk48        | 0.66009852216748768473
 imm    | 887h        | 0.24215246636771300448
 aci    | 41001       | 0.19855595667870036101
 aci    | 41002       | 0.45508982035928143713
 aci    | 4100x       | 0.67567567567567567568
(9 rows)

-- 4.- Mostrar per a cada empleat el seu nom i al costat un columna anomenada "dirigeix?" que digui si és director d'algú ("dirigent") o no ("no dirigeix")
select nombre,
case
	when num_empl in (select director from repventas) then 'dirigent'
	else 'no dirigent'
end
from repventas;
    nombre     |    case     
---------------+-------------
 Bill Adams    | no dirigent
 Mary Jones    | no dirigent
 Sue Smith     | no dirigent
 Sam Clark     | dirigent
 Bob Smith     | dirigent
 Dan Roberts   | dirigent
 Tom Snyder    | no dirigent
 Larry Fitch   | dirigent
 Paul Cruz     | no dirigent
 Nancy Angelli | no dirigent
(10 rows)

-- 5.- Mostrar per a cada producte totes les sevs dades, i a la dreta un camp titulat "Alerta existències" on, si la suma de les quantitats de dues últimes comandes (en direm N) supera les existències actuals, hi surti el missatge "ALERTA: últimes comandes sumen N")(on N és el número que hem anomenat abans). Si no, que no hi surti res a la columna

-- Per exemple:

 id_fab | id_producto |    descripcion    | precio  | existencias |         Alerta existències          
--------+-------------+-------------------+---------+-------------+-------------------------------------
...
 aci    | 41001       | Articulo Tipo 1   |   55.00 |         277 | 
 imm    | 775c        | Riostra 1-Tm      | 1425.00 |           5 | ALERTA: últimes 2 comandes sumen 22
 aci    | 4100z       | Montador          | 2500.00 |          28 | 
...

	-- aquest últim exercici és força complex. Si no te'n surts (però intenta-ho, els elements per fer-lo us els he donat encara que algun sigui de 'resquilón'), no et preocupis.






