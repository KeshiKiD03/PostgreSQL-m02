#include <stdio.h>
#include <stdlib.h>
#define TAM 10

void main()
{
// 2. Pide al usuario un entero y muestra por pantalla la suma de todos los valores hasta llegar a 1.
	
	// Definimos variables
	int i,num,sum;
	sum=0;
	// Pedimos el numero
	printf("Escribe un numero: \n");
	fflush(stdin);
	scanf("%i",&num);
	
	// Con for...
/*	for(i=1;i<=num;i++)
		{
			sum = sum+i;
			printf("i: %i, sum: %i\n", i, sum);
			getch();
		}
*/
	// Con while
	
	i=1;
	
	while(i<=num)
		{
			sum=sum+i;
			printf("i: %i, sum: %i\n", i, sum);
			getch();
			i++;
		}
}
