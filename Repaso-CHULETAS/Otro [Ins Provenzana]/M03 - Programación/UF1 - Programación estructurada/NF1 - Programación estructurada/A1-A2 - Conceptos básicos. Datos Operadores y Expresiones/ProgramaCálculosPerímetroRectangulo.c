#include <stdio.h>
#include <stdlib.h>

void main()
{
	/* Per�metro del rect�ngulo */
	
	/* Definimos variables */
	
	float lado1;
	float lado2;
	float perimetro;
	
	/* Introduzca el lado */
	
	printf("INTRODUZCA EL LADO1: ");
	fflush (stdin);
	scanf("%f",&lado1);
	printf("INTRODUZCA EL LADO2: ");
	fflush (stdin);
	scanf("%f",&lado2);
	
	/* C�lculo del perimetro */
	perimetro=2*lado1+2*lado2;
	
	/* Imprime el valor del per�metro */
	
	printf
	("El valor del per�metro es %.3f", perimetro);
	getch();
}
 


