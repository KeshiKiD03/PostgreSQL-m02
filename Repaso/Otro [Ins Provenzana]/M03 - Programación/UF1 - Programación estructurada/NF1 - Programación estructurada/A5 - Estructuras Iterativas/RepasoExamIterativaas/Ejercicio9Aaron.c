#include <stdio.h>
#include <stdlib.h>

int main()
{
	// Definimos variabless
	int i,j,k; // i = indice | j = donde guaarddmosss la variable | k = contador
	k=0; // Contaor empieza en 0
	// Estructura FOR (PrincipioBucle;CondicionPermanecerBucle;Incremento-Decremento-Operacion) | J es la variable ddonddde guarddamos
	printf("Introduce numero y te muestro los 100 numeros pares\n");
	fflush(stdin);
	scanf("%i",&j); // Guaramos en la variable J
	for (i=j;(i>=0||i<=0)&&k<100;i--)
	{
		if (i%2==0)
		{
			printf("\n%i\n", i);
			k++;
		}
	}
	getch();
	
	return 0;
}
