/*

 (4p) El programa pide tres n�meros enteros. A continuaci�n ofrece en un men� las siguientes opciones 

a) Calcula m�ximo 
b) Calcula m�nimo 
c) Calcula media 

La resoluci�n del men� se debe hacer con un switch obligatoriamente. 

C�digo estructurado, claro y comentado (0.5pto). 
Men� bien dise�ado y operativo (0.75 ptos si compila y cumple todos los casos). 
C�lculo m�ximo (1 ptos si compila y es operativo). 
C�lculo m�nimo (1 ptos si compila y es operativo). 
C�lculo media (0,75 ptos si compila y es operativo).

*/
#include <stdio.h>
#include <stdlib.h>

void main()
{
	// Definimos variables
	
	int num1;
	int num2;
	int num3;
	char opcion;
	
	
	/* Introduzca los valores de los numeros */
	
	printf("Introduzca el valor del numero 1: ");
	fflush (stdin);
	scanf("%i",&num1);
	printf("Introduzca el valor del numero 2: ");
	fflush (stdin);
	scanf("%i",&num2);
	printf("Introduzca el valor del numero 3: ");
	fflush (stdin);
	scanf("%i",&num3);
	
	/* Menu */
	
	printf("Que desea hacer?");
	printf("\n\n***************************************\n\n");
	printf("1\tMaximo\n2\tMinimo\n3\tMedia\ns/S\tSalir\n");
	printf("\n\n***************************************\n\n");
	printf("Escoge un numero: ");
	fflush (stdin);
	scanf("%c",&opcion);
	
	
	/* Hacemos el Switch */

	
	switch (opcion)
	{
		case '1': 
			if (num1>num2 && num1>num3) printf("El numero mayor es %i\n", num1); 
			else if (num2>num1 && num2>num3) printf ("El numero mayor es %i\n", num2); 
			else if (num3>num1 && num3>num2) printf ("El numero mayor es %i\n", num3); 
			else printf("Error de datos\n"); break;
		case '2':
			if (num1<num2 && num1<num3) printf("El numero minimo es %i\n", num1);
			else if (num2<num1 && num2<num3) printf ("El numero minimo es %i\n", num2); 
			else if (num3<num1 && num3<num2) printf ("El numero minimo es %i\n", num3);
			else printf("Error de datos\n"); break;
		case '3': printf("La media de los 3 es %i\n", (num1+num2+num3)/3); break;
		default: printf("Error en los datos introducidos");
	}
	
	getch();
}
 
 


