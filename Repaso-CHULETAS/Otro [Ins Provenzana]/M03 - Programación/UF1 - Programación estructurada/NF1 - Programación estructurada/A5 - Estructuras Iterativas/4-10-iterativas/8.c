#include <stdio.h>
#include <stdlib.h>
#define FIRST 33
#define LAST 126


int main()
{
	/*
	8. Muestra en orden decreciente los 100 primeros números naturales un número en cada línea. 
	9. Muestra en orden decreciente los 100 primeros números pares.
	10. Pide al usuario una letra y el número de veces que la tiene que mostrar. 		
	*/
	
	// definimos variables
	int i;
	
	printf("Numeros del 100 al 1: ");
	
	for (i=100;i>0;i--)
	{
		printf("%i\n", i);
	}	

	
	return 0;
}
