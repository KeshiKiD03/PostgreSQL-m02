#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define PTSEURO 166.386

void main()
{
	/* Conversor de PESETAS a EUROS */
	
	/* Definimos las variables */
	
	float valorpesetas;
	float resultado;
	
	/* Introduzca el valor del PESETAS */
	
	printf("Introduzca el valor en PESETAS que desea convertir: ");
	fflush (stdin);
	scanf("%f",&valorpesetas);

	/* Cálculo del conversor */
	
	resultado= valorpesetas/PTSEURO;

	/* Imprime el resultado por pantalla */
	
	printf("El resultado de la conversion de PESETAS a EUROS es %.2f\n", resultado);

	getch();
}
 
 


