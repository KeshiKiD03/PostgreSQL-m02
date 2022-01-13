#include <stdio.h>
#include <stdlib.h>

void main()
{
	int num1,num2;
	
	printf("Dime 2 numeros: ");
	fflush(stdin);
	scanf("%i %i", &num1, &num2);
//	printf("%i %i", num1, num2);
	
	if(num1<num2)
		printf ("El orden de los 2 numeros es %i %i \n", num1,num2);
	else 
		printf ("El orden de los 2 numeros es %i %i %i \n", num2,num1);	
}
