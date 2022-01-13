#include <stdio.h>
#include <stdlib.h>

// Desenvolupeu un programa que demani a l'usuari que introdueixi un preu en € i la quantitat de € que paga. 
// El programa compararà les dues quantitats i escriurà els € que li falten per pagar o bé els que li han de tornar. 
// Ex. Si l'usuari introdueix preu=102€ i paga=150€, el programa li dirà "Sobren 48€". 
// Si l'usuari introdueix preu=102€ i paga=100€, el programa li dirà "Falten 2€".

void main ()
{
	// Definimos variables
	char opcion;
	printf("\n\n*************\n\n");
	printf("1\tVerde\n2\tAmbar\n3\tRojo\ns/S\tSalir\n");
	printf("\n\n*************\n\n");
//	fflush(stdin);
//	scanf("%c", &opcion);
	
opcion=getch();

	switch (opcion)
	{
		case '1': printf("Puedes pasar"); break;
		case '2': printf("Corre que se pondra rojo"); break;
		case '3': printf("Para no puedes pasar"); break;
		default: printf("Error");
	}
}
