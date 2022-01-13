#include <stdio.h>
#include <stdlib.h>

int main()
{

// Definir variables

	float far,c;

// Introducir los datos que queremos convertir

	printf("Ingresar cantidad en grados Fahrenheit: ");
	scanf("%f", &far);
	
// Cálculo de los datos de la ecuación
	
	c= (far-32)/1.8;
	
// Immprimir por pantalla el resultado

	printf("%.2f grados Fahrenheit corresponden a %.f grados en Celsius \n", far,c);
	system("PAUSE");
	return 0;
}
