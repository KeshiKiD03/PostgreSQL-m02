#include <stdio.h>
#include <stdio.h>
/*Ordenar 3 numeros de mayor a menor */
void main()
{
//Definimos variables
int n1,n2,n3;
printf("Escribe 3 numeros para ordenalos de mayor a menor.\n");
printf("Escribe el primer numero:\n");
fflush(stdin);
scanf("%i",&n1);
printf("Escribe el segundo numero:\n");
fflush(stdin);
scanf("%i",&n2);
printf("Escribe el tercer numero:\n");
fflush(stdin);
scanf("%i",&n3);
//si n1 es el mas grande
if(n1>n2&&n1>n3)
	{
		if (n2>n3)
		{
		printf("%i %i %i",n1,n2,n3);	
		}
		else
		{
		printf("%i %i %i",n1,n3,n2);	
		}	
	}
	//n2 es mayor
else if(n2>n1&&n2>n3)
	{
		if (n1>n3)
		{
		printf("%i %i %i",n2,n1,n3);	
		}
		else
		{
		printf("%i %i %i",n2,n3,n1);	
		}	
	}
	//si n3 es mayor
else if(n3>n1&&n3>n2)
	{
		if (n2>n1)
		{
		printf("%i %i %i",n3,n2,n1);	
		}
		else
		{
		printf("%i %i %i",n3,n1,n2);	
		}	
	}
else
{
	printf("Error");
}
}
