#include <stdio.h>
#include <stdlib.h>

void main()
{
//Definimos variables
char letra;
int suma;

// Pedimos los datos del car�cter
printf("Introduzca una letra:\n");
scanf("%c",&letra);

// Definimos una condicional (PARA MAY�SCULAS)
if (letra>64&&letra<90)
{
// Bucle for rango de letras may�sculas de la tabla ASCII
	for(letra;letra<90&&letra>64;letra++)
	{
		suma=letra+1;
		printf("Las letras siguiente es: %c\n", suma);
	}

// Para min�sculas
}
else if(letra>96&&letra<123)
{
// Bucle for rango de letras min�sculas de la tabla ASCII
	for(letra;letra<122&&letra>96;letra++)
	{
		suma=letra+1;
		printf("Las letras siguiente es: %c\n", suma);
	}
}

// Error
else
{
	printf("Error");
}
}




