#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void main()
{
	/* Aera del triangulo rect�ngulo */
	
	/* Definimos variables */
	
	float x;
	float y;
	float hipotenusa;
	
	/* Introduzca el lado */
	
	printf("Introduzca el lado X: ");
	fflush (stdin);
	scanf("%f",&x);
	printf("Introduzca el lado Y: ");
	fflush (stdin);
	scanf("%f",&y);
	
	/* C�lculo de la hipotenusa */
	
	hipotenusa= sqrt (x*x+y*y);
	
	/* Imprime el valor del �era */
	
	printf("El valor de la hipotenusa es %.3f", hipotenusa);
	getch();
}
 


