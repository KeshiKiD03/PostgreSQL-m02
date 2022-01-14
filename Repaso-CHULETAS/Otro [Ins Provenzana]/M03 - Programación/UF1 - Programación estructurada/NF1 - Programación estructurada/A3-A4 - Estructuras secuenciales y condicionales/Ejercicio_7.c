#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define EURODOLAR 1.1295

void main()
{
	/* Conversor de EUROS a DÓLARES */
	
	/* Definimos las variables */
	
	float valoreuros;
	float resultado;
	
	/* Introduzca el valor del EUROS */
	
	printf("Introduzca el valor en EUROS que desea convertir: ");
	fflush (stdin);
	scanf("%f",&valoreuros);

	/* Cálculo del conversor */
	
	resultado= valoreuros*EURODOLAR;

	/* Imprime el resultado por pantalla */
	
	printf("El resultado de la conversion de EUROS a DOLARES es %.2f\n", resultado);

	getch();
}
 
 


