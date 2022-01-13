#include <stdio.h>
#include <stdlib.h>

void main()
{
	
	// Definir variables
	
	printf ("De que color es el semaforo?");
	
	char opcion;
	
	printf("\n\n***************************************\n\n");
	printf("v\tVerde\na\tAmarillo\nr\tRojo\ns/S\tSalir\n");
	printf("\n\n***************************************\n\n");
	opcion=getch();
	
	switch(opcion)
		{
			case 'v': printf("\n\nPuedes pasar\n"); break;
			case 'a': printf("\n\nCorre que se pone\n"); break;
			case 'r': printf("\n\nNi se te ocurra pasar\n"); break;
			default: printf("\n\nIncorrecto ...\n"); break;
		}
}
