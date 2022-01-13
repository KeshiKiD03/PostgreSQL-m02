#include <stdio.h>
#include <stdlib.h>
#define BAR 14.5038

void main()
{
	// (1p)Elaborar un programa que realice la conversión de psi a bares (unidades de presión). Donde 1bar = 14,5038 psi pulgadas.
	
	// Definimos variables
	
	float psi,bar;
	
	// Leemos los datos introducidos y se lo aplicamos a la variable flotante %f
	
	printf("Escribe en PSI lo que quieras convertir a BARES: ");
	fflush(stdin);
	scanf("%f", &psi);
	
	// Realizamos la conversion
	
	bar=psi*BAR;
	
	// Imprimimos por pantalla el resultado de la conversion
	
	printf("El resultado de la conversion a BARES es: %.3f", bar);
	fflush(stdin);
	
	getch();
	
}
