#include <stdio.h>
#include <stdlib.h>
int main(){
	/*
	11.Considerem un ascensor d'un edifici amb planta baixa i 
	dos pisos que tingui els següents 
	botons: 'pujar 1', 'pujar 2', 'baixar 1' i 'baixar 2'. 
	L'ascensor es comporta, a partir dels botons esmentats,
	segons el següent diagrama de transició d'estats:
	*/
	
	// Definimos las variables
	int piso,move;
	
	// Pedimos el menu
	printf("Te encuentras en un ascensor\nEn que planta te encuentras ahora mismo?\n");
	printf("-------------------------\n");
	printf("Accion\tPiso\n");
	printf("0\tplanta 0\n");
	printf("1\tplanta 1\n");
	printf("2\tplanta 2\n");
	printf("-------------------------\n");
	
	// Pedimos en que planta esta 
	printf("Dime la planta en que estas: ");
	fflush(stdin);
	scanf("%i",&piso);
	
	if (piso>=0) 
	{
		if (piso<=2)
		{
			printf ("Te encuentras en la planta %i\n", piso);
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
			scanf("%i",&move);
			piso=piso+move;
			if (piso<=2) 
			{
				if (piso>=0)
				{
					printf("Estas en la planta: %i", piso);
				}
				else
				{
					printf ("Esa planta no existe");
				}
			}
			else 
			{
				printf ("Esa planta no existe");
			}
		}
		else
		{
			printf ("Has puesto una planta erronea");
		}
	}
	else
	{
		printf ("Has puesto una planta erronea");
	}
	
	*/
		
	getch();
	
	return 0;
}
