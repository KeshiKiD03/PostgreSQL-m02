#include <stdio.h>
#include <stdlib.h>

int main ()
{
int i,j,k;
k=0;
printf("Los 100 primeros numeros pares:\n");
	fflush(stdin);
	scanf("%i",&j);

while(k<100)
{


	
	if(j%2==0)
	{
	printf("\n%i\n",j);
	k++;
	}
	j--;
}


/*for(i=j;(i>=0||i<=0)&&k<100;i--)//i=j:El indice introducido por variable--(i>=0||i<=0)&&k<100:Saldra del bucle cuando i>0 O i<0(Pero esto hace un matrix) Y cuando K sea menor 100 saldra del bucle pero para conseguir esta limitacion 
								//Introducimos un contador en el bucle--i--:Decreciente de -1 a -1
{
	k++;						//En cuanto entra al bucle K suma 1, asi cada vez que entra en el bucle entonces en la condicion del for cuando k llega a 100 saldria del bucle
	if(i%2==0)					//Si i%2 da resto 0 imprime i.
	{
	printf("\n%i\n",i);
	}
}
*/	
return 0;
}
