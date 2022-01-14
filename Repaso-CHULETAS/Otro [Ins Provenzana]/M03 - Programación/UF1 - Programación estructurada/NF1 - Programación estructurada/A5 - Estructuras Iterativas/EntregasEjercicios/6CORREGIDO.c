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
	int i;
	
	// Lees la letra introducida
	
	printf("Pulsa un caracter: \n");
	fflush(stdin);
	tecla=getch();

	if(tecla>=97 && tecla<=122)
	{
		// Letra es minuscula
		printf("La letra es minuscula\n");
		printf("Valor de la tecla introducida: %c\n", tecla);
		for (tecla;tecla<122;tecla++)
		{
			i=tecla+1;
			printf("La secuencia de caracteres en minuscula: %c\n", i);
		}
	}
	else if(tecla>=65 && tecla<=90)
	{
		// Letras es mayúscula
		printf("Letra es mayuscula\n");
		printf("Valor de la tecla introducida: %c\n", tecla);
		for (tecla;tecla<90;tecla++)
		{
			i=tecla+1;
			printf("La secuencia de caracteres en mayuscula: %c\n", i);
		}
	}
	else
	{
		// No es una letra valida
		printf("Error .|.");
	}
	
	/* Condición While */
	
	// Lees la letra
/*	
	i=tecla;
	
	while(i<='z')
	{
		printf("El valor de la variable: %c\n", i);
		i++;
	}
*/
	return 0;
}
