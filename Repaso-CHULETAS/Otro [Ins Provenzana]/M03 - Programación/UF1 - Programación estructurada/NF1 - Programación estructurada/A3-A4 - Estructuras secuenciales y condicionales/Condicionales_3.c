#include <stdio.h>
#include <stdlib.h>

void main()
{
/* Menu */

	/*
		1	Hacer factura
		2	Revisar facturas
		3	Hacer caja
		s/S	Salir
	*/
	
	//definir variables
	
	char opcion;
	
	printf("\n\n***************************************\n\n");
	printf("1\tHacer factura\n2\tRevisar facturas\n3\tHacer caja\ns/S\tSalir\n");
	printf("\n\n***************************************\n\n");
	opcion=getch();
	
	switch(opcion)
		{
			case '1': printf("\n\nHaciendo factura ...\n"); break;
			case '2': printf("\n\nRevisando factura ...\n"); break;
			case '3': printf("\n\nHaciendo caja ...\n"); break;
			default: printf("\n\nIncorrecto ...\n"); break;
		}
}

	
