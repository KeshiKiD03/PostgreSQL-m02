#include <stdio.h>
#include <stdlib.h>

void main()
{
	//2. (1p)Obtener la edad de una persona en meses, si se introduce su edad en años y meses. Ejemplo: Introducimos 3 años 4 meses debe mostrar: 40 meses.
	
	// Definimos variables
	
	float anyo,anyomes,meses;
	
	// Leemos los datos introducidos y se lo aplicamos a la variable flotante %f
	printf("Dime los anyos y meses que tienes y te dire el total de meses que tienes\n");
	printf("Dime los anyos: ");
	fflush(stdin);
	scanf("%f", &anyo);
	printf("Dime los meses: ");
	fflush(stdin);
	scanf("%f", &meses);
	
	// Realizamos la conversion de años a meses
	
	anyomes=anyo*12;

	
	// Imprimimos por pantalla el resultado de la conversion
	
	printf("Los meses que tienes en total son: %.f", anyomes+meses);
	fflush(stdin);
	
	getch();
	
}
