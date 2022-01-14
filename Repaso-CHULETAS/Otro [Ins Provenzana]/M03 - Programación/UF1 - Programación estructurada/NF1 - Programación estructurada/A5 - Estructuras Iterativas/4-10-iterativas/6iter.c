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
	//Inicializas 
	
	
	printf("pulse caracter: ");
	fflush(stdin);
	tecla=getch();
			
	if(tecla>='a' && tecla <='z')
		{
        // letra es minuscula
        printf("letra es minuscula\n");
        
        for(i=tecla; i<='z'; i++)
			{
			printf("%c ", i);
			}       
			
		}
	else if(tecla>='A' && tecla <='Z')
		{
		// Letra es mayuscula
        printf("letra es mayuscula");

        for(i=tecla; i<='Z'; i++)
			{
			printf("%c ", i);
			}       

		}
	else 
		{
		// No es una letra o no es valida
        printf("letra no valida");

		}

/*
	for(i=tecla; i<=Z; i++)
		{
		printf("%c ", i);
		}

*/	



	
		
	
	return 0;
}
