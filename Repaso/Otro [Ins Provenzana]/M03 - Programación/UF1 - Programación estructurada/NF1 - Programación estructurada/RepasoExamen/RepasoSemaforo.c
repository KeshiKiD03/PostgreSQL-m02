#include <stdio.h>
#include <stdlib.h>

// Desenvolupeu un programa que demani a l'usuari que introdueixi un preu en � i la quantitat de � que paga. 
// El programa comparar� les dues quantitats i escriur� els � que li falten per pagar o b� els que li han de tornar. 
// Ex. Si l'usuari introdueix preu=102� i paga=150�, el programa li dir� "Sobren 48�". 
// Si l'usuari introdueix preu=102� i paga=100�, el programa li dir� "Falten 2�".

void main ()
{
	// Definimos variables
	int a,b;
	
	printf("Dime el precio: ");
	fflush(stdin);
	scanf("%i", &a);
	printf("Dime el precio que has pagado: ");
	fflush(stdin);
	scanf("%i", &b);
	
	if (a>b) printf("Te faltan %i euros", a-b);
	else if (a<b) printf("Te sobran %i euros", b-a);
	else if (a=b) printf("No tienes cambio has pagado perfectamente", a=b);
	else printf("Error");
}
