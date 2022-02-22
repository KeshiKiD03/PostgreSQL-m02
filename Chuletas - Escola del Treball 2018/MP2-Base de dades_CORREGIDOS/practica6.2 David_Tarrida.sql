#1 ¿Quina es la quota mitjana y las vendes mitjanas de tots els empleats?
SELECT avg(cuota), avg(ventas) FROM repventas;

         avg         |         avg         
---------------------+---------------------
 300000.000000000000 | 289353.200000000000



#2 Trobar l'import mitjà de comandes,l'import total de comandes i el preu mig de venda.

SELECT avg(importe), sum(importe), avg(importe/cant) FROM pedidos;

          avg          |    sum    |          avg          
-----------------------+-----------+-----------------------
 8256.3666666666666667 | 247691.00 | 1056.9666666666666667


#3 Trobar el preu mitjà dels productes del fabricant aci.

SELECT avg(importe/cant) FROM pedidos WHERE fab = 'aci';

         avg          
----------------------
 741.8181818181818182


#4 Quin es l'import total de les comandes realizades per l'empleat amb identificador 105?

SELECT sum (importe) FROM pedidos WHERE rep = 105;

   sum    
----------
 39327.00

#5 Trobar la data en que es va realitzar la primera comanda.

SELECT fecha_pedido FROM pedidos ORDER BY fecha_pedido;

 fecha_pedido 
--------------
 1989-01-04


#6 Trobar quantes comandes hi ha de més 25000.
SELECT sum(cant) as "cuantitat_de_comandes" FROM pedidos WHERE importe >= 25000;

cuantitat_de_comandes 
-----------------------
                    50



#7 Llistar quants empleats estan assignats a cada oficina, indicar el identificador de la oficina, i quants té assignats.



#8 Per a cada empleat, identificador, import venut a cada client, identificador de client.

#9 Per a cada empleat on les comandes sumin més de 30000, trobar l import mitjà de cada comanda.

training=# SELECT rep,avg(importe) from pedidos group by rep having sum (importe) > 30000;
 rep |          avg           
-----+------------------------
 106 |     16479.000000000000
 105 |  7865.4000000000000000
 107 | 11477.3333333333333333
 108 |  8376.1428571428571429



#10 Quina quantitat d oficines tenen empleats amb vendes superiors a la seva quota.


training=# SELECT count (distinct oficina_rep)from repventas where ventas > cuota;
 count 
-------
     4
(1 row)
