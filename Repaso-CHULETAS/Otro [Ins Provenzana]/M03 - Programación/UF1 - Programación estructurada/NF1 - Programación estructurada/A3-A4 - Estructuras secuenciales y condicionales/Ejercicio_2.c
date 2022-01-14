#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define PTSEURO 166.386

void main()
{
	/* Cálculos aritméticos de 2 números enteros */
	
	/* Definimos las variables */
	
	float valor1;
	float valor2;
	float suma;
	float resta;
	float multi;
	float div;
	
	/* Introduzca los valores de los números */
	
	printf("Introduzca el valor del numero 1: ");
	fflush (stdin);
	scanf("%f",&valor1);
	printf("Introduzca el valor del numero 2: ");
	fflush (stdin);
	scanf("%f",&valor2);

	/* Cálculos aritméticos */
	
	suma= valor1+valor2;
	resta= valor1-valor2;
	multi= valor1*valor2;
	div= valor1/valor2;

	/* Imprime el resultado por pantalla */
	
	printf("El resultado de la suma es %.2f\n", suma);
	printf("El resultado de la resta es %.2f\n", resta);
	printf("El resultado de la multiplicacion es %.2f\n", multi);
	printf("El resultado de la division es %.2f\n", div);

	getch();
}
 
 


