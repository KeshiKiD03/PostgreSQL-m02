#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define PI 3.14159

void main()
{
	/* Aera y Longitud del círuclo */
	
	/* Definimos variables */
	
	float radio;
	float area;
	float longitud;
	float diametro;
	
	/* Introduzca el radio */
	
	printf("Introduzca el valor de la radio: ");
	fflush (stdin);
	scanf("%f",&radio);
	
	/* Cálculo de la circulo */
	diametro= 2*radio;
	longitud= 2*PI*radio;
	area= PI*(radio*radio);
	
	/* Imprime los valores del círculo */
	
	printf("El valor de la diametro es %.3f\n", diametro);
	printf("El valor de la longitud es %.3f\n", longitud);
	printf("El valor de la area es %.3f\n", area);
	getch();
}
 


