#include <stdio.h>
#include <stdlib.h>

int main()
{
	/*
	4. Suma números que introduce el usuario siempre y cuando el número sea mayor que 1.
    5. Pide y muestra caracteres y escapa cuando pulsas "escape". 
    6. Pide letra y muestra el abecedario desde esa letra hasta la Z. 
    7. Muestra el código ASCII de los caracteres. 
		
	*/
	
	// definimos variables
	
	int num, suma;
	
	//Inicializas 
	
	suma=0;
	
	printf("Num: ");
	fflush(stdin);
	scanf("%d", &num);
	
	while(num>1)
		{
		suma=num+suma;
		printf("suma: %d\n", suma);
		printf("Num: ");
		fflush(stdin);
		scanf("%d", &num);
		
		}

	printf("Valor final de suma: %d\n", suma);

	
		
	
	return 0;
}
