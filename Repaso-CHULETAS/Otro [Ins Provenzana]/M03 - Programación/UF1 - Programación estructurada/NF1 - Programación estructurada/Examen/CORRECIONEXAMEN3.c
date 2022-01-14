#include <stdio.h>
#include <stdlib.h>
#define NUM 5

int main()
{
	// Numeros primos=3 --> 1, 2, 3 numeros primos=6 --> 1, 2, 3, 5, 7, 11
	
	//Def variables
	int numprimos;
	int cont=0;
	int num=1;
	int i,primo;
	
	// Leer cantidad de primos
	
	printf("Cantidad de primos: ");
	fflush(stdin);
	scanf("%i", &numprimos);
	
	while (numprimos>cont)
	{
		// Verificamos que el número evaluado es primo o no
		
		primo=1;
		
		// Num es numero a verificar
		
		for (i=2; i<num && primo==1; i++)
		{
			if(num%i==0)primo;
		}
		if(primo==1)
		{
			cont++;
			printf("%i; %i \n", cont, num);
		}
		
		// Incrementamos el numero evaluado
		num++;
	}
	getchar();
	return 0;
}
