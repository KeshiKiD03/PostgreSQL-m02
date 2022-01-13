#include<stdio.h>
#include<stdlib.h>
#define ENTRADA 45.00

void main()
{
/* 3. (4p)Los alumnos  de 1º de DAWBIO realizaran un viaje a Port Aventura  a final de curso,
 el precio de la entrada general es de 45€. Al grupo se le aplicará un descuento dependiendo 
 del número de alumnos :
Si alumnos > 50 ?				30%
Si alumnos entre 20  y 50 ? 	           20%
Si alumnos entre 10 y 20 € ?	           10%
Si alumnos es <  10 € ?			  0%
Profesor de programación 	        entrada libre.

Se realizará un descuento adicional del 15% a los alumnos menores de 18 años la cantidad de alumnos
 menores del grupo se ha de indicar para obtener el precio final.

El programa mostrará el importe total a pagar para los mayores de edad y el importe a pagar para 
los menores de edad y el importe total del grupo.. */

	//variables
	
	int alumnes;
	int menors;
	int desc;
	float preu, preumenor;
		
	// lectura alumnes

	printf("Total alumnes: ");
	fflush(stdin);
	scanf("%i", &alumnes);

	// lectura menors edat

	printf("Menors edat: ");
	fflush(stdin);
	scanf("%i", &menors);

	//Calcul descompte
	
	if(alumnes<=0 || menors<0 || menors>alumnes)
	   {
	   	/*Dades incorrectes*/
	   	printf("Dades incorrectes\n");
	   }
	else
		{
		if(alumnes<10) preu=ENTRADA;
		else if(alumnes<20) preu=ENTRADA*0.9;
		else if(alumnes<50) preu=ENTRADA*0.8;
		else preu=ENTRADA*0.7;
		
		preumenor=preu*0.85;

		
		printf("Preu majors: %.2f\n", preu);
		printf("Preu menors: %.2f\n", preumenor);
		printf("Total: %.2f\n", preumenor*menors+preu*(alumnes-menors));

		
		}

}
