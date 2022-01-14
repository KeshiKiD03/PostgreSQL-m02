#include <stdio.h>
#include <stdlib.h>
#define IVA 0.21

void hola_mundo();
void pide_suma();
void suma(int a, int b);
void multiplica(int a, int b);
void bisiesto(int a);
void calcula_iva(float a);

int main ()
{
	// Insertar el codigo para probar las funciones
	
	// Prueba el modulo hola_mundo()
	
	hola_mundo();
	pide_suma();
	suma(2,3);
	multiplica(2,3);
//	bisiesto(2015);
	bisiesto(2012);
	calcula_iva(999.95);
	
	getchar();
	return 0;
}

void hola_mundo ()
{
	printf("Hola mundo\n");

}

void pide_suma()
{
	int a;
	int b;
	int suma;
	printf("Dime 2 valores y te dire la suma\n");
	printf("Dime el primer valor: ");
	fflush(stdin);
	scanf("%i", &a);
	
	printf("Dime el segundo valor: ");
	fflush(stdin);
	scanf("%i", &b);
	
	suma=a+b;
	
	printf("La suma de los 2 son: %i\n", suma);

}

void suma(int a, int b)
{

	int suma;
	
	suma=a+b;

	printf("La suma de los 3 + 2 son: %i\n", suma);

}

void multiplica(int a, int b)
{
	
	//Definir variables
	int i;
	int prod=0;
	
/*	//printf
	printf("Dime un valor: ");
	fflush(stdin);
	scanf("%d", &a);
	
	printf("Dime cuantas sumas: ");
	fflush(stdin);
	scanf("%d", &b); */
	
	/* Con el FOR */
	
	for (i=1;i<=b;i++)
	{
		prod=prod+a;
	}
	
	/* Con el While */
	
//	while(i<=b)
//		{
//		prod=prod+a;
//		i++;
//		}	

	printf("El resultado de la multiplicacion es: %d\n", prod);



}

void bisiesto(int a)
{
	char nombre [ 40];

	if ((a%4==0)&&((a%100!=0)||(a%400==0)))
	printf ("El a\xA4o %i es bisiesto\n", a);
	else
	printf ("El a\xA4o %i no es bisiesto\n", a);

}

void calcula_iva(float a)
{
	/* Cálculo de un producto 21% */
	
	/* Definimos variables */
	
	float valorprod;
	float iva;

	
	/* Introduzca el valor del producto */
	
	// Valor producto 999.5
	
	/* Cálculo del valor del producto + 21% IVA */
	valorprod=a*IVA+a;
	iva=a*IVA;
	
	/* Imprime el valor del producto con IVA */
	
	printf("El valor de con IVA es %.2f\n", valorprod);
	printf("El aumento de valor 'IVA' del producto fue de %.2f\n", iva);

}
