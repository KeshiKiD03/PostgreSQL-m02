#include<stdio.h>
#include<stdlib.h>
#define CONV 0.39737
void main()
{
/* Obtener la edad de una persona en meses, si se introduce 
su edad en años y meses. Ejemplo: Introducimos 3 años 4 meses
 debe mostrar: 40 meses. */

	//variables
	
	int any, mes;
	
	// lectura any mes

	printf("Conversor a mesos.\nQuants anys i mesos tens?\n");
	fflush(stdin);
	scanf("%i %i", &any, &mes);

	//Conversion
	printf("%i any i %i mesos son %i mesos", any, mes, any*12+mes);
}
