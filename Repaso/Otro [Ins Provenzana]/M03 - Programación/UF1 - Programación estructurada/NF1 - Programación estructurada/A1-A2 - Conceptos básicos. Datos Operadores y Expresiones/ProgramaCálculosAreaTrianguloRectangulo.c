#include <stdio.h>
#include <stdlib.h>

void main()
{
	/* Aera del triangulo rectángulo */
	
	/* Definimos variables */
	
	float x;
	float y;
	float area;
	
	/* Introduzca el lado */
	
	printf("Introduzca el lado X: ");
	fflush (stdin);
	scanf("%f",&x);
	printf("Introduzca el lado Y: ");
	fflush (stdin);
	scanf("%f",&y);
	
	/* Cálculo del area */
	area=(x*y)/2;
	
	/* Imprime el valor del áera */
	
	printf
	("El valor del area es %.3f", area);
	getch();
}
 


