#include <stdio.h>
#include <stdio.h>
//Desarrollar un programa que pida un mes y un año, y escriba el mes anterior y el mes siguiente. 
//Ej. Si el usuario introduce mes: 10 y en 2003, el resultado será anterior: 9/2003 y posterior 11/2003
//
void main()
{
//definimos variables
int year,month;

printf("Introduce anyo:");
fflush(stdin);
scanf("%i",&year);
printf("Introduce mes:");
fflush(stdin);
scanf("%i",&month);
if (month==1)
	{
	printf("El mes anterior es 12 de %i\n",year-1);
	printf("El mes siguiente es 2 de %i",year);
	}
else if(month==12)
	{
	printf("El mes anterior es %i de %i\n",month-1,year);
	printf("El mes siguiente es 1 de %i",year+1);
	}
else if(month!=12&&month!=1)
	{
	printf("El mes anterior es %i de %i\n",month-1,year);
	printf("El mes siguiente es %i de %i",month+1,year);
	}
else
	{
	printf("Error");
	}

}
