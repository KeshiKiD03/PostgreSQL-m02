#include <stdio.h>
#include <stdlib.h>

void main()
{
	
	// Definimos variables
	
	int num1,num2,num3;
	
	// Introducimos los par�metros de entrada para los 3 n�meros
	
	printf("Dime tres numeros: \n");
	fflush(stdin);
	scanf("%i %i %i", &num1, &num2, &num3);
	
	// Empezamos a escribir las condicionales para que los 3 n�meros est�n ordenados de orden creciente
	
	if(num1<num2 && num1<num3)
	{
		if(num2<num3)
		{
			printf("El orden es %i %i %i", num1, num2, num3);
		}
		else
		{
			printf("El orden es %i %i %i", num1, num3, num2);
		}
	}
	
	// Cambiamos los valores para realizar todas las posibles combinaciones
	
	if(num2<num1 && num2<num3)
	{
		if(num1<num3) 
		{
			printf("El orden es %i %i %i", num2, num1, num3);
		}
		else
		{
			printf("El orden es %i %i %i", num2, num3, num1);
		}
	}
	
	// La �ltima possible combinaci�n
	
	if(num3<num1 && num3<num2)
	{
		if(num1<num2)
		{
			printf("El orden es %i %i %i", num3, num1, num2);
		}
		else // num3 es el m�s peque�o
		{
			printf("El orden es %i %i %i", num3, num2, num1);
		}
	}

	getch();	
}

// Los valores van a ordenarse de menor a mayor. Guardamos y ejecutamos el programa
