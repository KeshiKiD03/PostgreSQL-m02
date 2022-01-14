#include <stdio.h>
#include <stdlib.h>
#define FIRST 2
#define LAST 200


// 10. Pide al usuario una letra y el número de veces que la tiene que mostrar. 

int main()
{
	//Definimos variables
	
	char tecla;
	int i,veces;

	printf("Dime una letra: ");
	fflush(stdin);
	scanf("%c", &tecla);
	printf("Introduce el numero de veces: ");
	fflush(stdin);
	scanf("%i", &veces);
	
	for(i=1;i<=veces;i++)
	{
		printf("%c ", tecla);
	}
}
