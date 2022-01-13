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


// En el mes de Diciembre se le aplica +1 pero al aplicar +1 cambia de año

	if (mes==12)
 	{
 		printf ("Anterior: %i %i\n", mes-1, anyo);
 		printf ("Posterior: %i %i\n", 1, anyo+1);
 	}
 	else
 	{
 		if (mes==1)
 		{
 			printf ("Anterior: %i %i\n", 12, anyo-1);
 			printf ("Posterior: %i %i\n", mes+1, anyo);
 		}
 		else
 		{
 			printf ("Anterior: %i %i\n", mes-1, anyo);
 			printf ("Posterior: %i %i\n", mes+1, anyo);
 		}
 	}
	
	

// En el mes de Enero se le aplica +1 pero al aplicar -1 cambia de año

// En los otros meses se le aplica +1 y -1


	
}
