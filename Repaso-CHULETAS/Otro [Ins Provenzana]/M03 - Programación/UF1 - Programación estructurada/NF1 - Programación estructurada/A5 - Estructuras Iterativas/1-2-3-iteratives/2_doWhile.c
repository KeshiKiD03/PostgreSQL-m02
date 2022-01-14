#include <stdio.h>
#include <stdlib.h>


void main()
{
	/*2. Pide al usuario un entero y muestra por pantalla la suma de todos los valores hasta llegar a 1.*/
	
	//Definir variables
	int num,suma;
	suma = 0;
	do
		{
		printf("Escriu un numero: ");
		fflush(stdin);
		scanf("%d",&num);
		if(num != 1)
		{
			suma = suma+num;
			printf("\n%d\n" ,suma);
		}		
		
	
		}while(num!=1);
	

}
