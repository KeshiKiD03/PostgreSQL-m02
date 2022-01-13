#include <stdio.h>
#include <stdlib.h>
#define Z 122

int main()
{
	/*
    6. Pide letra y muestra el abecedario desde esa letra hasta la Z. 
    7. Muestra el código ASCII de los caracteres. 
		
	*/
	
	// definimos variables
	
	char tecla;
	int i;
	
	// Lees la letra
	
	tecla=getch();

	i=tecla;
	
	//condicion del while: mientras que no llegas a la z mayuscula			

	while(i<='z')
		{
		printf("%c ", i);
		
		i++;
		}

	
		
	
	return 0;
}
