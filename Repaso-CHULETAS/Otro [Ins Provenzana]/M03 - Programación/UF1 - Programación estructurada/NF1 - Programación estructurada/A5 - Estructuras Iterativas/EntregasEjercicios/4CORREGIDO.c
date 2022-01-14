#include <stdio.h>
#include <stdlib.h>

int main ()
{
	/* 
	
	4. Suma números que introduce el usuario siempre y cuando el número sea mayor que 1. 
	5. Pide y muestra caracteres y escapa cuando pulsas "escape". 
	6. Pide letra y muestra el abecedario desde esa letra hasta la Z. 
	7. Muestra el código ASCII de los caracteres.
	
	*/
	
	// Definimos variables
	
	int num, suma;
	
	// Inicializas
	
	suma=0;
	
	printf("Num: ");
	fflush(stdin);
	scanf("%d", &num);
	
	while (num>1) // Condición si num es mayor que uno la condición es falsa entonces NO sale del bucle y si fuera menor que entonces SI que sale 
	{
		// Actualizar el contador
		suma=num+suma;
		printf("Suma: %d\n", suma);
		// Volver a pedir los datos
		printf("Num: ");
		fflush(stdin);
		scanf("%d", &num);
	} 
	
	return 0;
}
