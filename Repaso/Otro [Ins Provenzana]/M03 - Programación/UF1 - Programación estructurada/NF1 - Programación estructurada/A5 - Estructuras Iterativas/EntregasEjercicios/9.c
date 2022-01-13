#include <stdio.h>
#include <stdlib.h>
#define FIRST 2
#define LAST 200


// 9. Muestra en orden decreciente los 100 primeros números pares.

int main()
{
	//Definimos variables
	int i;

	printf("Muestra los 100 primeros numeros pares: \n");
	
/*	Primer método

	for(i=LAST;i>=FIRST; i=i-FIRST)
	{
		printf("%i ", i);
	}
*/

/* Segundo método

	for(i=100;i>=1;i--) printf("%d ", i*2);
	return 0;

}
