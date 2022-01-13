#include <stdio.h>
#include <stdlib.h>
#define FIRST 1
#define LAST 100


// 8. Muestra en orden decreciente los 100 primeros números naturales un número en cada línea. 

int main()
{
	//Definimos variables
	int i;

	printf("Numeros del 100 al 1: \n");

	
	// Bucle for que nos pida la tabla ASCII
/*for(i=LAST;i>=FIRST;i--)
{
	printf(" %i\n",i);
}
*/
	i=LAST;
	while (i>=FIRST)
	{
		printf("%i\n", i);
		i--;
	}
	
	return 0;
}
