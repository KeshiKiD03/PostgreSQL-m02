#include <stdio.h>
#include <stdlib.h>
#define FIRST 33
#define LAST 126


// 7. Muestra el código ASCII de los caracteres. Del 33 al 126

void main()
{
	//Definimos variables
	int i;

	printf("Codigo ASCII de los caracteres desde 0 a 127. \n");
	// Bucle for que nos pida la tabla ASCII
for(i=FIRST;i<=LAST;i++)
{
	printf(" %c %i",i,i);
	if(i%5==0) printf("\n");
	else printf("\t");
	}	
}
