#include <stdio.h>
#include <stdlib.h>
#define ESC 27

int main ()
{
	/* 
	
	4. Suma números que introduce el usuario siempre y cuando el número sea mayor que 1. 
	5. Pide y muestra caracteres y escapa cuando pulsas "escape". 
	6. Pide letra y muestra el abecedario desde esa letra hasta la Z. 
	7. Muestra el código ASCII de los caracteres.
	
	*/
	
	// Definimos variables
	
	char tecla;
	
	// Inicializas
	
	printf("Pulsa un caracter: \n");
	fflush(stdin);
	tecla=getch();
	
	while (tecla!=ESC)
	{
		printf("Tecla %c, ASCII: %i\n", tecla, tecla);
		tecla=getch();
	} 
	
	return 0;
}
