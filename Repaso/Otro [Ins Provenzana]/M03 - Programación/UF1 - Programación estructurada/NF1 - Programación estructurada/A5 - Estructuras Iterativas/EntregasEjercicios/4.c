// 4. Suma números que introduce el usuario siempre y cuando el número sea mayor que 1.

#include <stdio.h>
#include <stdlib.h>

void main ()
{
	// Definimos variables
	
	int num1;
	// Le damos el valor 0 a esta variable para que la suma empiece a contar desde 0
	int sum=0;
	
	// Pedimos datos
	
	printf("Dime que numero quieres sumar: \n");
	fflush(stdin);
	scanf("%i", &num1);
	
	while (num1>1)
	{
		// Contador
		sum=sum+num1;
		// Imprimir
		printf("La suma es: %i \n", sum);
			
		printf("Dime que numero quieres sumar: \n");
		fflush(stdin);
		scanf("%i", &num1);
	}
}
