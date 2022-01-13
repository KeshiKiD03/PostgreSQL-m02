#include <stdio.h>
#include <stdlib.h>
#define ESC 27

int main()
{
	/*
	4. Suma números que introduce el usuario siempre y cuando el número sea mayor que 1.
    5. Pide y muestra caracteres y escapa cuando pulsas "escape". 
    6. Pide letra y muestra el abecedario desde esa letra hasta la Z. 
    7. Muestra el código ASCII de los caracteres. 
		
	*/
	
	// definimos variables
	
	char tecla;
	
	//Inicializas 
	
	
	printf("pulse caracter: ");
	fflush(stdin);
	tecla=getch();
			
	while(tecla!=ESC)
		{
			
		// Imprimo tecla
		printf("tecla: %c, ASCII: %i\n", tecla, tecla);
		
		//pido la siguiente tecla
		printf("pulse caracter: ");
		fflush(stdin);
		tecla=getch();
		}



	
		
	
	return 0;
}
