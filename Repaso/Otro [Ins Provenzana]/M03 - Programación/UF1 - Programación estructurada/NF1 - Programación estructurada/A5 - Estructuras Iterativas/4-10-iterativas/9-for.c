#include <stdio.h>
#include <stdlib.h>
#define FIRST 33
#define LAST 126


int main()
{
	/*
	9. Muestra en orden decreciente los 100 primeros n�meros pares.
	10. Pide al usuario una letra y el n�mero de veces que la tiene que mostrar. 		
	*/
	
	// definimos variables
	int i;

	/*for(i=200; i>=2; i=i-2)
		{
			printf("%i ", i);
		}	
	*/
	for(i=100; i>=1; i--) printf("%d ", i*2);
	return 0;
	getch();
}


