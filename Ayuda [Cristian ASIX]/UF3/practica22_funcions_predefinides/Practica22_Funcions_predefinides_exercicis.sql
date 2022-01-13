--1. Donar data i hora actual del sistema en format dd/MM/aaaa-hh:mm:ss
select to_char(current_timestamp, 'DD/MM/YYYY-HH24:MI:SS');
       to_char       
---------------------
 29/04/2021-12:04:50
(1 row)

--2. Donar hora actual en format hh:mm:ss
select to_char(current_timestamp, 'HH24:MI:SS');
 to_char  
----------
 12:04:10
(1 row)

--3. Determinar la durada de cada contracte fins avui en dies. S'ha de mostrar el nom del treballador, la data del contracte i la durada.
select nombre,contrato,(current_date - contrato) as durada from repventas;
    nombre     |  contrato  | durada 
---------------+------------+--------
 Bill Adams    | 1988-02-12 |  12130
 Mary Jones    | 1989-10-12 |  11522
 Sue Smith     | 1986-12-10 |  12559
 Sam Clark     | 1988-06-14 |  12007
 Bob Smith     | 1987-05-19 |  12399
 Dan Roberts   | 1986-10-20 |  12610
 Tom Snyder    | 1990-01-13 |  11429
 Larry Fitch   | 1989-10-12 |  11522
 Paul Cruz     | 1987-03-01 |  12478
 Nancy Angelli | 1988-11-14 |  11854
(10 rows)

--4. Determinar la suma total de les durades de tots els contractes dels treballadors en dies fins avui.
select sum(extract())

--5. Determinar la diferència de temps treballat entre cadascun dels treballadors amb el treballador més antic. S'ha de mostrar el nom del treballador, la data del contracte i la diferència.
select nombre,age(contrato,(select min(contrato) from repventas)) as diferencia from repventas;
    nombre     |       diferencia        
---------------+-------------------------
 Bill Adams    | 1 year 3 mons 23 days
 Mary Jones    | 2 years 11 mons 23 days
 Sue Smith     | 1 mon 21 days
 Sam Clark     | 1 year 7 mons 25 days
 Bob Smith     | 6 mons 30 days
 Dan Roberts   | 00:00:00
 Tom Snyder    | 3 years 2 mons 24 days
 Larry Fitch   | 2 years 11 mons 23 days
 Paul Cruz     | 4 mons 12 days
 Nancy Angelli | 2 years 25 days
(10 rows)

-- Diferencia en dias
select nombre,contrato,(contrato - (select min(contrato) from repventas)) as diferencia from repventas;
    nombre     |  contrato  | diferencia 
---------------+------------+------------
 Bill Adams    | 1988-02-12 |        480
 Mary Jones    | 1989-10-12 |       1088
 Sue Smith     | 1986-12-10 |         51
 Sam Clark     | 1988-06-14 |        603
 Bob Smith     | 1987-05-19 |        211
 Dan Roberts   | 1986-10-20 |          0
 Tom Snyder    | 1990-01-13 |       1181
 Larry Fitch   | 1989-10-12 |       1088
 Paul Cruz     | 1987-03-01 |        132
 Nancy Angelli | 1988-11-14 |        756
(10 rows)

--6. Calcular el nombre de comandes fetes el desembre pels representants de vendes contractats el mes de febrer.
select count(*) from pedidos
    join repventas on rep=num_empl
where extract('month' from contrato) = 2


select count(*) from pedidos
where rep in (select num_empl from repventas
              where extract('month' from contrato) = 2)
and extract('month' from fecha_pedido) = 12;
 count 
-------
     3
(1 row)

--7. Llistar el número de treballadors que s'han contractat per a cada mes de l'any. El llistat ha d'estar ordenat pel mes. Ha de tenir el següent format:

 mes_de_contractació | numero_contractes 
---------------------+------------------
                   1 |                1
                   2 |                1
                   3 |                1
...
select extract('month' from contrato) as mes_de_contractació,count(*) as numero_contractes from repventas
group by extract('month' from contrato)
order by 1;
 mes_de_contractació | numero_contractes 
---------------------+-------------------
                   1 |                 1
                   2 |                 1
                   3 |                 1
                   5 |                 1
                   6 |                 1
                  10 |                 3
                  11 |                 1
                  12 |                 1
(8 rows)

-- 9.- LListar el nom dels treballadors i la data del seu contracte mostrant-la amb el següent format:

    Bill Adams, contractat el divendres 12 de febrer del 1988
    
	--Nota: l'idioma ha de ser el de la localització del servidor postgres. Si és en català, els mesos que comencen amb vocal surten amb d' (per exemple "25 d'abril")ç
select nombre || ', contrado ' || to_char(contrato, 'el day DD "de" month "del" yyyy') from repventas;
                           ?column?                            
---------------------------------------------------------------
 Bill Adams, contrado el friday    12 de february  del 1988
 Mary Jones, contrado el thursday  12 de october   del 1989
 Sue Smith, contrado el wednesday 10 de december  del 1986
 Sam Clark, contrado el tuesday   14 de june      del 1988
 Bob Smith, contrado el tuesday   19 de may       del 1987
 Dan Roberts, contrado el monday    20 de october   del 1986
 Tom Snyder, contrado el saturday  13 de january   del 1990
 Larry Fitch, contrado el thursday  12 de october   del 1989
 Paul Cruz, contrado el sunday    01 de march     del 1987
 Nancy Angelli, contrado el monday    14 de november  del 1988
(10 rows)

select nombre || ', contratado el ' || to_char(contrato,'TMDay DD TMMonth') || ' del ' || to_char(contrato,'yyyy') as fecha_contrato
from repventas;
                      fecha_contrato                      
----------------------------------------------------------
 Bill Adams, contratado el Friday 12 February del 1988
 Mary Jones, contratado el Thursday 12 October del 1989
 Sue Smith, contratado el Wednesday 10 December del 1986
 Sam Clark, contratado el Tuesday 14 June del 1988
 Bob Smith, contratado el Tuesday 19 May del 1987
 Dan Roberts, contratado el Monday 20 October del 1986
 Tom Snyder, contratado el Saturday 13 January del 1990
 Larry Fitch, contratado el Thursday 12 October del 1989
 Paul Cruz, contratado el Sunday 01 March del 1987
 Nancy Angelli, contratado el Monday 14 November del 1988
(10 rows)
