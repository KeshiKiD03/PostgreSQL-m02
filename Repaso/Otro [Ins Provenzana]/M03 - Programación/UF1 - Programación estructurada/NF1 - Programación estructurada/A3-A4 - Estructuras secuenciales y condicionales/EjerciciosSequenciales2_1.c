#include <stdio.h>
#include <stdlib.h>

// Desenvolupeu un programa que demani un mes i un any, i escrigui el mes anterior i el mes següent. 
// Ex. Si l’usuari introdueix mes:10 i any 2003, el resultat serà anterior:9/2003 i posterior 11/2003

void main()
{
	
// Definir variables

	int mes, anyo;

// Introducir valores de los variables de entrada

	printf ("Introduce el mes: ");
	fflush (stdin);
	scanf ("%i", &mes);
	printf ("Introduce el anyo: ");
	fflush (stdin);
	scanf ("%i", &anyo);

	
// En el mes de Enero se le aplica +1 pero al aplicar -1 cambia de año

// En los otros meses se le aplica +1 y -1

	switch(mes)
		{
// En el mes de Diciembre se le aplica +1 pero al aplicar +1 cambia de año
		case 12: printf("anterior: %i %i, posterior %i %i", 11 , anyo, 1, anyo+1); break;
// En el mes de Enero se le aplica +1 pero al aplicar -1 cambia de año
		case 1: printf("anterior: %i %i, posterior %i %i", 12 , anyo-1, 2, anyo); break;
// En los otros meses se le aplica +1 y -1
		default: printf("anterior: %i %i, posterior %i %i", mes-1 , anyo, mes+1, anyo); 
		}

	
}
