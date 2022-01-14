#include <stdio.h>
#include <stdlib.h>

int suma2(int a, int b); // Se le pasa el valor de dos números y devuelve su valor.
int multiplica2(int a, int b); // Se le pasa el valor de dos números y devuelve su multiplicación al programa principal. No se puede utilizar el operador “*” (multiplicación)
int es_bisiesto(int a); // Se le pasa un valor númerico y determina si el año es bisiesto. 0 no bisiesto, 1 bisiesto.
float calcula_iva2(float precio, float valor); // Se le pasa el valor del producto y el valor del IVA. Devuelve al programa principal los el precion con iva.

int main()
{
	printf("5+2 = %i\n", suma2(5,2));
	printf("5*2 = %i\n", multiplica2(5,2));
	
	if(es_bisiesto(1996))
		printf("1996 es bisiesto\n");
	else
		printf("1996 no es bisiesto\n");
	
	printf("El precio sin IVA es %.2f\n", 100.0);
	printf("El IVA es %.2f \% \n", 21.0);
	printf("El precio con IVA es %.2f\n", calcula_iva2(100, 21));
	
	getchar();
	return 0;
}

int suma2(int a, int b)
{
	return a+b;
}

int multiplica2(int a, int b)
{
	int i;
	int mult=0;
	for (i=0;i<=a;i++)
	{
		mult=mult+a;
	}
	return mult;
}

int es_bisiesto(int a)
{

	if ((a%4==0)&&((a%100!=0)||(a%400==0)))
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

float calcula_iva2(float precio, float valor)
{
	precio=precio+((valor/100.0)*precio);
	return precio;
}


