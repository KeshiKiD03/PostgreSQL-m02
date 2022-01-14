#include <stdlib.h>
#include <stdio.h>
#define NUM 6

// Procedimiento
void imprimir_menu();

// Funcion sin parametros

int es_primo1();

// Funcion parametros por valor

int es_primo2(int num);

// Funcion parametros por referencia

void intro_nota(int *nota);

int main()
{
	int nota;
	
	
	printf("Nota valida: %i", nota);
	
	getchar();
	return 0;
}


int main()
{
//
int numprimos, num=1, cont=0;
printf("Introduzca numero de primos: ");
fflush(stdin);
scanf("%i", &numprimos);

while(cont<numprimos)
{
	if(es_primo2(num))
		{
			cont++;
			printf("%i: %i\n", cont, num);
		}
	num++;
}

}

void intro_nota(int *nota)
{
	int num;
	
	do
	{
		printf("Nota: ")
		fflush(stdin);
		scanf("%i", &num);
	} while (nota<0 || nota>10)
	*nota=num;
}
