#include <stdio.h>
#include <stdlib.h>

void main()
{
	
/*	En un determinat comerç es realitza un descompte depenent del preu de cada producte. 
	Si el preu es inferior a 10 € no es fa descompte
	si és major o igual a 10 € i menor que 100 € es fa un 5 per 100 de descompte
	 i si és major o igual a 100 € es fa un 10 per 100 de descompte
	 Realitzar el programa que llegeix el preu d’un producte i ens calcula i escriu el preu final*/
	 //variables
	 float precio;
	 
	 //Leer precio
	 printf ("Introduce el precio: ");
	 fflush(stdin);
	 scanf("%f", &precio);
	 
			 
	 //Miramos intervalos
	 
	 
	 		// Mirar precio menor que 0
	if      (precio<0)	
		printf("Precio negativo");
		//Menor que 10 euros
	else if (precio<10)
		printf("Precio: %.2f",precio);
		//Mayor o igual que 10 y menos que 100
	else if (precio<100)
		printf("Precio: %.2f",precio*0.95);
		//Mayor o igual que 100
	else 
		printf("Precio: %.2f", precio*0.90);
		
	
	
	getch();
		
			
	
	
			
			
			
}
