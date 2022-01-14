#include <stdio.h>
#include <stdio.h>
/* 3.Desenvolupeu un programa que pida un año y escriba si es bisiesto o no. 
Sabemos que son bisiestos todos los años múltiplos de 4,excepto los que sean múltiplos de 100 sin que sean múltiplos de 400.1700, 1800, 1900, 2100, 2200, 2300, 2500, 2600*/
void main()
{
	//Definimos varibles
	int year;
	//Pedimos el año
	printf("Escribe un año:\n");
	scanf("%i",&year);
	if (year%4==0&&year%100==0&&year%400==0)
		{
		printf("El año es bisiesto");
	 	} 
	else
	{
		printf("El año no es bisiesto.");
	}
}
