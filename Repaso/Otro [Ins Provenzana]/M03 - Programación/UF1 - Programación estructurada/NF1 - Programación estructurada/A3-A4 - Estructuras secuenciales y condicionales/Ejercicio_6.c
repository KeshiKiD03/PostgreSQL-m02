#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define PTSEURO 166.386

void main()
{
	/* Conversor de EUROS a PESETAS */
	
	/* Definimos las variables */
	
	float valoreuros;
	float resultado;
	
	/* Introduzca el valor del EUROS */
	
	printf("Introduzca el valor en EUROS que desea convertir: ");
	fflush (stdin);
	scanf("%f",&valoreuros);

	/* Cálculo del conversor */
	
	resultado= valoreuros*PTSEURO;

	/* Imprime el resultado por pantalla */
	
	printf("El resultado de la conversion de EUROS a PESETAS es %.2f\n", resultado);

	getch();
}
 
 


