#include <stdio.h>
#include <stdlib.h>


void main()
{
	/*2. Pide al usuario un entero y muestra por pantalla la suma de todos los valores hasta llegar a 1.*/
	
	//Definir variables
	int num,suma;
	suma = 0;
	// Demanem el n�mero
	printf("Escriu un numero: ");
	fflush(stdin);
	scanf("%d",&num);
	// Comencem el bucle funcionara mentres num no sigui igual a 1
	while (num!=1)
		{
			// Incremento acumulador
			suma = num + suma; 
			// Mostro contador
			printf("%d \n",suma);
			// Tornem a demanar n�mero si no �s 1
			printf("Escriu un n�mero: ");
			fflush(stdin);
			scanf("%d",&num);	
		}
	
	

}
