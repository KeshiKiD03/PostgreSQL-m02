/*

1. (2 puntos) Escribir un programa dados dos valores los ordena de mayor a menor y luego los printa, a continuación muestra, 
la suma,resta,multiplicación y la media de estos valores

*/
#include <stdio.h>
#include <stdlib.h>

int main()
{
	// Definimos variables
	
	int num1;
	int num2;
	
	
	/* Introduzca los valores de los numeros */
	printf("Introduce 2 valores y te dire el orden de mayor a menor\n");
	printf("Introduzca el valor del numero 1: ");
	fflush (stdin);
	scanf("%i",&num1);
	printf("Introduzca el valor del numero 2: ");
	fflush (stdin);
	scanf("%i",&num2);
	
	/* Hacemos las condicionales */
	
	// Si el numero introducido num1 es mayor que num2 --> Ordename primero num1 y luego num2 y muestrame sus operaciones (sumar, multiplicar y restar)
	if (num1>num2)
	{
		printf ("El orden de mayor a menor es: %i %i\n\n", num1,num2);
		printf ("La suma de los valores es %i\n",(num1+num2));
		printf ("La resta de los valores es %i\n",(num1-num2));
		printf ("La multiplicacion de los valores es %i\n",(num1*num2));
		printf("La media de estos valores es %i\n",(num1+num2)/2);
	}
	// De lo contrarrio si num2 fuera mayor que num2 --> Ordename primero num2 y luego num1 y muestrame sus operaciones (sumar, multiplicar y restar)
	else if (num2>num1) 
	{
		printf("El orden de mayor a menor es: %i %i\n\n", num2,num1);
		printf ("La suma de los valores es %i\n",(num2+num1));
		printf ("La resta de los valores es %i\n",(num2-num1));
		printf ("La multiplicacion de los valores es %i\n",(num2*num1));
		printf("La media de estos valores es %i\n",(num2+num1)/2);
	}
	// Si ambos numeros fueran iguales no se ordena y muetra por pantalla que son numeros iguales pero que le muestre las operaciones	
	else if (num2=num1) // Es indiferente introducir num2=num1 o num1=num2 ya que ambos valores son iguales
	{
		printf("Los dos numeros son iguales, ninguno de los valores es mayor que otro\n\n");
		printf ("La suma de los valores es %i\n",(num2+num1));
		printf ("La resta de los valores es %i\n",(num2-num1));
		printf ("La multiplicacion de los valores es %i\n",(num2*num1));
		printf("La media de estos valores es %i\n",(num2+num1)/2);
	}	
	else printf("Error");

	getch();
	return 0;
}
 
 


