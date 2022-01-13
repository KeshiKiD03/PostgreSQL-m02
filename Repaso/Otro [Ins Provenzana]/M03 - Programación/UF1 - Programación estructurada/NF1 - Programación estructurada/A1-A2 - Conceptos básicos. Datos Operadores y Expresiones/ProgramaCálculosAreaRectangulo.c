#include <stdio.h>
#include <stdlib.h>

void main()
{
	/* Aera del rectángulo */
	
	/* Definimos variables */
	
	float lado1;
	float lado2;
	float area;
	
	/* Introduzca el lado */
	
	printf("Introduzca la base: ");
	fflush (stdin);
	scanf("%f",&lado1);
	printf("Introduzca la altura: ");
	fflush (stdin);
	scanf("%f",&lado2);
	
	/* Cálculo del area */
	area=lado1*lado2;
	
	/* Imprime el valor del áera */
	
	printf
	("El valor del area es %.3f", area);
	getch();
}
 


