#include <stdio.h>
#include <stdlib.h>

void main()
{
	// Variable
	float num1; 
	float num2;
	char operacion;
	
	// Pedimos numero
	printf("CALCULADORA: ");
	fflush(stdin);
	scanf("%f%c%f",&num1,&operacion,&num2);
		
	switch (operacion)
		{
		case '+': printf("=%f", num1+num2) ;break;
		case '-': printf("=%f", num1-num2) ;break;
		case '*': printf("=%f", num1*num2) ;break;
		case '/': printf("=%f", num1/num2) ;break;
		default: printf("ERROR ERROR ERROR ERROR ");
		}

	
	
	
	
	
	
	
}
