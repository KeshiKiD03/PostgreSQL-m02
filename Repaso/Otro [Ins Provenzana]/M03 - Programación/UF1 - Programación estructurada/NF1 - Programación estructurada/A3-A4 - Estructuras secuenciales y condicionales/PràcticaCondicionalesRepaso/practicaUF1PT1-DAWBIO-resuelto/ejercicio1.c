#include<stdio.h>
#include<stdlib.h>
#define CONV 0.39737
void main()
{
/* Obtener la edad de una persona en meses, si se introduce 
su edad en a�os y meses. Ejemplo: Introducimos 3 a�os 4 meses
 debe mostrar: 40 meses. */

	//variables
	
	float cm;
	
	// lectura cm

	printf("Conversor cm -> pulgadas\n\n");
	fflush(stdin);
	scanf("%f", &cm);

	//Conversion
	printf("%f cm -> %f pulgadas", cm, cm*CONV);
}
