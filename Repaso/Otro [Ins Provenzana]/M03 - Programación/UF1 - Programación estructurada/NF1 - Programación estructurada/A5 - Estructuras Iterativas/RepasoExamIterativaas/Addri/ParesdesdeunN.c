#include <stdio.h>
#include <stdio.h>
/*Introducir un n�mero por pantalla y escribe en orden decreciente los 100 primeros n�meros pares.
Por ejemplo: N�mero 50:  50 48 46 44  .... -148 */
void main()
{
//Definimos variables
int i,j,op;
printf("Escribe un numero:\n");
scanf("%i", &j);
op=(j*2);
for(i=j;i<=op;i++)
{
	if(i%2==0)
	printf("%i\n",i);
}
}

