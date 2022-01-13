#include <stdio.h>
#include <stdlib.h>


// 7. Muestra el código ASCII de los caracteres. Del 0 al 127

void main()
{
	//Definimos variables
	int ascii;

	printf("Codigo ASCII de los caracteres desde 0 a 127.\n ");
	// Bucle for que nos pida la tabla ASCII
for(ascii=127;ascii>=0;ascii--)
{
	printf("El valor ASCII de %c es %i\n",ascii,ascii);
	}	
}
