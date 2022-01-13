#include <stdio.h>
#include <stdlib.h>
#include <math.h>
// #define IVA 21.0

void main()
{
	/* Cálculo de la suma de 3 numeros enteros */
	
	/* Definimos las variables */
	
	float valor1;
	float valor2;
	float valor3;
	float resultado;
	
	/* Introduzca los valores de los numeros */
	
	printf("Introduzca el valor del numero 1: ");
	fflush (stdin);
	scanf("%f",&valor1);
	printf("Introduzca el valor del numero 2: ");
	fflush (stdin);
	scanf("%f",&valor2);
	printf("Introduzca el valor del numero 3: ");
	fflush (stdin);
	scanf("%f",&valor3);
	
	/* Cálculo de la suma de los 3 valores */
	resultado= valor1+valor2+valor3;

	/* Imprime el resultado por pantalla */
	
	printf("El resultado de la suma es %.f\n", resultado);
	getch();
}
 
 


