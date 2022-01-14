#include <stdio.h>
#include <stdlib.h>
#define NUM 5

// Procedimiento

void imprimir_menu();

int main()
{

	imprimir_menu();

	getchar();
	return 0;
}

void imprimir_menu()
{
	printf("Esto es un menu:\n\n");
	printf("Oaella\n");
	printf("Calamares\n");
	printf("Melocoton de calanda\n");	
}


int es_primo2()
{
//def variables
int i, primo;
primo=1;

printf("Introduzca numero a verificar: ");
fflush(stdin);
scanf("%i", &num);
for(i=2; i<num && primo==1; i++)
{
	if(num%i==0) primo=0;
}
return primo;
}

