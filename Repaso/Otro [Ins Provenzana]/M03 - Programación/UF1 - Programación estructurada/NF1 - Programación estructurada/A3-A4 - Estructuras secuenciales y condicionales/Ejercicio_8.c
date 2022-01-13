#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{

// Definir variables

	float far,c;

// Introducir los datos que queremos convertir

	printf("Ingresar cantidad en grados Celsius: ");
	scanf("%f", &c);
	
// Cálculo de los datos de la ecuaciób
	far=1.8*c+32;
	
// Immprimir por pantalla el resultado

	printf("%.2f grados Celsius corresponden a %.f grados en Fahrenheit \n", c,far);
	system("PAUSE");
	return 0;
}
