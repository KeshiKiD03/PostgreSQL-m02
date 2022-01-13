#include <stdio.h>
#include <stdlib.h>


void main()
{
	/*3. Pide al usuario un valor y cuantas veces lo quiere sumar y muestre el resultado de todas las 
	sumas hasta llegar a las veces pedidas.*/
	
	//Definir variables
	int a, b;
	int i=1;
	int prod=0;
	
	//printf
	printf("ime un valor: ");
	fflush(stdin);
	scanf("%d", &a);
	
	printf("dime cuantas sumas: ");
	fflush(stdin);
	scanf("%d", &b);
	
	while(i<=b)
		{
		prod=prod+a;
		i++;
		}	
	printf("prod: %d", prod);


}
