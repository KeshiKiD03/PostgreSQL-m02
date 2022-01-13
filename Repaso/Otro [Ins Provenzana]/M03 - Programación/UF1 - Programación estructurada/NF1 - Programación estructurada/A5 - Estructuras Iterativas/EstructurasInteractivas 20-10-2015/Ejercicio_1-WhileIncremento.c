#include <stdio.h>
#include <stdlib.h>

void main ()
{
	
// Definimos variables

int notas=-1;

// Mientras notas incorrectas

while (notas<0 || notas>10)
	{
		// Leemos nota
		printf("Introduzca nota: ");
		fflush(stdin);
		scanf("%i", &notas);
	}
	
printf ("Nota correcta: %i", notas);

// Leemos notas
	
	
}
