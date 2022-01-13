#include <stdio.h>
#include <stdlib.h>

void main()
{
	//1. (1p)Elaborar un programa que realice la conversión de cm. a pulgadas. Donde 1cm = 0.39737 pulgadas.
	
	// Definimos variables
	
	float cm,res;
	
	// Leemos los datos introducidos y se lo aplicamos a la variable flotante %f
	
	printf("Escribe en CM lo que quieras convertir a PULGADAS: ");
	fflush(stdin);
	scanf("%f", &cm);
	
	// Realizamos la conversion
	
	res=cm*0.39737;
	
	// Imprimimos por pantalla el resultado de la conversion
	
	printf("El resultado de la conversion a PULGADAS es: %.3f", res);
	fflush(stdin);
	
	getch();
	
}
