#include <stdio.h>
#include <stdlib.h>

void main()
{
	// Definimos variables
	int num1,res;

	// Pedimos datos
	
	printf("Dime el valor que desea verificar: ");
	fflush(stdin);
	scanf("%i", &num1);
	
	// Hacemos las condicionales para verificar si es par o impar y tambien si es multiplo de 5
	
	if(num1%2==0 && num1%5==0) printf("El numero es par y multiplo de 5\n");
	else if (num1%2!=0 && num1%5==0) printf ("El numero es impar y multiplo de 5\n");
	else if (num1%2==0 && num1%5!=0) printf ("El numero es par y no es multiplo de 5\n");
	else printf("El numero es impar y no es multiplo de 5");
	

	
	getch();
}
