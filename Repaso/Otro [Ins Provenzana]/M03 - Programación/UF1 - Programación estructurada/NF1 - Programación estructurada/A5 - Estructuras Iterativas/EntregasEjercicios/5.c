#include <stdio.h>
#include <stdlib.h>

// 5. Pide y muestra caracteres y escapa cuando pulsas "escape". 


void main()
{

	//Definir variables
	char c;

	//Pedimos el numero
	printf("Escribe una letra o esc para salir:\n");
	fflush(stdin);
c=getch();//Recoge cualquier ti

while (c!=27)
{
	
	printf("El caracter es : %c\n",c);
	printf("Escribe una letra o esc para salir:\n");
	fflush(stdin);
	c=getch();
	}

	
}


