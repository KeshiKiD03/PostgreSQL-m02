/*

4p)Los alumnos  de 1º de DAWBIO realizaran un viaje a Port Aventura  a final de curso, 
el precio de la entrada general es de 45€. 
Al grupo se le aplicará un descuento dependiendo del número de alumnos :
Si alumnos > 50 ?				30%
Si alumnos entre 20  y 50 ? 	           20%
Si alumnos entre 10 y 20 € ?	           10%
Si alumnos es <  10 € ?			  0%
Profesor de programación 	        entrada libre.

Se realizará un descuento adicional del 15% a los alumnos menores de 18 años 
la cantidad de alumnos menores del grupo se ha de indicar para obtener 
el precio final.

El programa mostrará el importe total a pagar para los mayores de edad y 
el importe a pagar para los menores de edad y el importe total del grupo.

*/

#include <stdio.h>
#include <stdlib.h>
#define ENTRADA 45.00

void main()
{
	// Definimos variables
	
	int alumnes,menors,des;
	float preu,preumenor;
	
	// Pedimos datos
	
	printf("Bienvenidos a Port Aventura\n");
	printf("****************************\n");
	printf("El precio general de entrada es de 45 euros \n");
	printf("Cuantos alumnos desean comprar entrada?: ");
	fflush(stdin);
	scanf("%i", &alumnes);
	
	// Menores de edad
	
	printf("Cuantos de ellos son menores de edad?: ");
	fflush(stdin);
	scanf("%i", &menors);
	
	// Hacemos las condicionales

//	if(alumnes<=0 || menors<0 || menors>alumnes)
//	{
		/*Dades incorrectes*/
/*		printf("Dades incorrectes\n");
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
*/

/* ------------------------------------------------------------------------------ */
/* Opcion 2 Aaron Optimizado */
	
	if (alumnes<=0 || menors<0 || menors>alumnes) printf("Error");
	else if (alumnes>50) printf("El precio de vuestra entrada son %.2f\n", preu=ENTRADA*0.7), preumenor=preu*0.85, printf("Precio menores: %.2f\n", preumenor);
	else if (alumnes>=20 && alumnes<=50) printf("El precio de vuestra entrada son %.2f euros\n", preu=ENTRADA*0.8), preumenor=preu*0.85, printf("Precio menores: %.2f\n", preumenor);
	else if (alumnes>=10 && alumnes<20) printf("El precio de vuestra entrada son %.2f euros\n", preu=ENTRADA*0.9), preumenor=preu*0.85, printf("Precio menores: %.2f\n", preumenor);
	else if	(alumnes>0 && alumnes<10) printf("El precio de entrada para adultos no tiene descuento y por lo tanto seran %.2f euros\n", preu=ENTRADA), preumenor=preu*0.85, printf("Precio menores: %.2f\n", preumenor);
	else printf ("Error");

//	preumenor=preu*0.85;
//	printf("Preu menors: %.2f\n", preumenor);


/* ------------------------------------------------------------------------------------- */


/* Opcion 3 Pruebas incompleta
	
	if (alumnes>50) {
		des = preu * 0.30;
		preu = preu - des;
		printf("El descuento es de: %.2f euros\n", des);
		printf("El precio final de la entrada es: %.2f euros", preu);
	}
	else {
		printf("Error")
	}
	if (alumnes>=20 && alumnes<=50) {
		des = preu * 0.20;
		preu = preu - des;
		printf("El descuento es de: %.2f euros\n", des);
		printf("El precio final de la entrada es: %.2f euros", preu);
	}
	else {
		printf("Error")
	}
	if (alumnes>=10 && alumnes<20) {
		des = preu * 0.10;
		preu = preu - des;
		printf("El descuento es de: %.2f euros\n", des);
		printf("El precio final de la entrada es: %.2f euros", preu);
	}
	else {
		printf("Error")
	}
	
*/	
	getch();
	
}
