#include <stdio.h>
#include <stdio.h>
/* 3.Desenvolupeu un programa que pida un a�o y escriba si es bisiesto o no. 
Sabemos que son bisiestos todos los a�os m�ltiplos de 4,excepto los que sean m�ltiplos de 100 sin que sean m�ltiplos de 400.1700, 1800, 1900, 2100, 2200, 2300, 2500, 2600*/
void main()
{
	//Definimos varibles
	int year;
	//Pedimos el a�o
	printf("Escribe un a�o:\n");
	scanf("%i",&year);
	if (year%4==0&&year%100==0&&year%400==0)
		{
		printf("El a�o es bisiesto");
	 	} 
	else
	{
		printf("El a�o no es bisiesto.");
	}
}
