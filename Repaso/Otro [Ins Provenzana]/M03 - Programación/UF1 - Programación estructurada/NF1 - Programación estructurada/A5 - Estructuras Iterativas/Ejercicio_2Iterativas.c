#include <stdio.h>
#include <stdlib.h>
#define TAM 10

void main()
{
	int i,j,k;
	
	for(i=0; i<TAM; i++)
	{
		printf("%i ", i);
	}
	printf("\n\n");
	
	for(i=TAM; i>=0; i--)
	{
		printf("%i ", i);
	}
	
	printf("\n");
	for(i=0; i<TAM; i++)
	{
		for(j=0; j<TAM; j++)
		{
			printf("i=%i j=%i", i, j);
			getch();
			printf("\n");
		}
	printf("\n");
	getch();
	}
}
