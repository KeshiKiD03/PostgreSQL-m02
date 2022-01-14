#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define IVA 1.21

void main()
{
	/* Cálculo de un producto 21% */
	
	/* Definimos variables */
	
	float prod;
	float valorprod;
	float iva;
	
	/* Introduzca el valor del producto */
	
	printf("Introduzca el valor de la entrada de obra de teatro: ");
	fflush (stdin);
	scanf("%f",&prod);
	
	/* Cálculo del valor del producto + 21% IVA */
	valorprod= prod*IVA;
	iva= prod*IVA;
	
	/* Imprime el valor del producto con IVA */
	
	printf("El valor de la entrada de obra de teatro con IVA es %.2f\n", valorprod);
	printf("El aumento de valor 'IVA' del producto fue de %.2f\n", iva);
	getch();
}
 
 


