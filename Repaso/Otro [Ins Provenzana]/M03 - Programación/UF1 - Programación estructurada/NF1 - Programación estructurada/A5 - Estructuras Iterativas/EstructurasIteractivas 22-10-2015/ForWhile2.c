#include <stdio.h>
#include <stdlib.h>

void main()
{
	// Pide al usuario un numero enter y muestra por pantalla la suma de todos los valores hasta llegar a 1.
	
	// Definir variables
	
	int num,suma;
	suma= 0;
	
	// Demanem el número
/*	
	printf("Escriu un numero: ");
	fflush(stdin);
	scanf("%d",&num);
*/	
	// Començem el bucle que funcionara mentras num no sigui igual a 1
/*	while (num!=1)
	{
		// Incremento acumulador
		suma=num+suma;
		// Mostra contador
		printf("%d \n", suma);
		// Tornem a demanar numero si no és 1
		printf("Escriu un numero: \n");
		fflush(stdin);
		scanf("%d",&num);
		
	}
*/
	do 
	{
		printf("Escriu un numero: ");
		fflush(stdin);
		scanf("%d",&num);
		if(num != 1){
			suma = suma+num;
			printf("");
		}
	}	
}
