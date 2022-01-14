#include <stdio.h>
#include <stdlib.h>
#define FIRST 33
#define LAST 126


int main()
{
	/*
    6. Pide letra y muestra el abecedario desde esa letra hasta la Z. 
    7. Muestra el código ASCII de los caracteres. 
		
	*/
	
	// definimos variables
	
	int i;
	
	//condicion del while: mientras que no llegas a la z mayuscula			

	for(i=FIRST; i<=LAST ; i++);
		{
		printf("%c %i", i, i);
		if(i%5==0)
		   printf("\n");
		else
		   printf("\t");
		}
		
	
	return 0;
}
