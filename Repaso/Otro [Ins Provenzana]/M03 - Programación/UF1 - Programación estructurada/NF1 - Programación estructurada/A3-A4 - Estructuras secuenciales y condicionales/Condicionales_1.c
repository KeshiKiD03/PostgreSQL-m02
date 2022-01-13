#include <stdio.h>
#include <stdlib.h>

void main()
{
	// edad >=18 Mayor de edad
	// edad < 18 Menor de edad
	
	// definimos variables
	
	int edad;
	
	// Pedimos edad
	
	printf("Edad: ");
	fflush(stdin);
	scanf("%i", &edad);
	
	// Evaluamos si es menor de edad
	
	if(edad<18)
		{
			printf("Usted es menor de edad\n");
		}
	else
		{
			printf("Eres mayor de edad\n");
		}
}
