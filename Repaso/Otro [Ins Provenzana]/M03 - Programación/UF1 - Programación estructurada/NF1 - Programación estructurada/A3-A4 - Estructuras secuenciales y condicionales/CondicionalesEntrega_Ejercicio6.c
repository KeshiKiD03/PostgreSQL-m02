#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define PTSEURO 166.386

void main()
{
	/* C�lculos aritm�ticos de 2 n�meros enteros */
	
	/* Definimos las variables */
	
	float num1;
	float num2;
	char operacion;
	
	/* Introduzca los valores de los n�meros */
	
	printf("Calculadora: ");
	fflush (stdin);
	scanf("%f%c%f",&num1,&operacion,&num2);
	printf("%.f%c%.f", num1, operacion, num2);
	fflush (stdin);

	/* C�lculos aritm�ticos */
	
	switch (operacion)
		{
			case '+': printf("=%.f", num1+num2);break;
			case '-': printf("=%.f", num1-num2);break;
			case '*': printf("=%.f", num1*num2);break;
			case '/': printf("=%.f", num1/num2);break;
			default: printf("\nError Error Error");break;
		}
		
	getch();
}
 
 


