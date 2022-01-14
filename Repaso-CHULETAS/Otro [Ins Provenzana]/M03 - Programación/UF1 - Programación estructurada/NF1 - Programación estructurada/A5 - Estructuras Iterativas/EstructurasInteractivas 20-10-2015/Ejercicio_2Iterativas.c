#include <stdio.h>
#include <stdlib.h>
#define TAM 10

void main()
{
	int i;
	
	for(i=0; i<TAM; i++)
	{
		printf("%i ", i);
	}
	printf("\n\n");
	
	for(i=TAM; i>=0; i--)
	{
		printf("%i ", i);
	}
}
