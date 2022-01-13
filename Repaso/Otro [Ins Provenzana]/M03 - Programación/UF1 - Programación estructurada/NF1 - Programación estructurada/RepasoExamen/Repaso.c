#include <stdio.h>
#include <stdlib.h>

// Considerem un ascensor d'un edifici amb planta baixa i dos pisos que tingui els següents botons: 'pujar 1', 'pujar 2', 'baixar 1' i 'baixar 2'. 
// L'ascensor es comporta, a partir dels botons esmentats, segons el següent diagrama de transició d'estats:

void main()
{
	// Definimos variables
	int piso,movimiento;
	printf("Hola te encuentras en un ascensor\n");
	printf("0\t Planta 0\n");
	printf("1\t Planta 1\n");
	printf("2\t Planta 2\n");
	printf("Dime tu planta: ");
	fflush(stdin);
	scanf("%i", &piso);
	
	if (piso>=0 && piso<=2)
	{
		printf("Te encuentras en la planta %i\n", piso);
		printf ("Que boton quieres pulsar?\n");
		printf("-------------------------\n");
		printf("Accion\tComando\n");
		printf("1\tSubir 1\n");
		printf("2\tSubir 2\n");
		printf("-1\tBajar -1\n");
		printf("-2\tBajar -2\n");
		printf("-------------------------\n");
		printf("Comando: ");
		fflush(stdin);
		scanf("%i",&movimiento);
		if ((piso+movimiento)>=0 && (piso+movimiento)<3)
		{
			printf("Has pulsado el comando %i Ahora te encuentras en la planta %i",movimiento, piso+movimiento);
		}
		else printf("El comando que has pulsado es erroneo");
	}
	else printf("Esa planta no existe");

	
}
