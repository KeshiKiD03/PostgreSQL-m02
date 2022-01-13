#include <stdio.h>
#include <stdlib.h>

void main()
{
 
// Muestra en orden decreciente los 100 primeros números pares.
int i,j,k;
k=0;
printf("Los 100 primeros numeros pares:\n");
fflush(stdin);
scanf("%i",&j);

for(i=j;(i>=0||i<=0)&&k<100;i--)//i=j:El indice introducido por variable--(i>=0||i<=0)&&k<100:Saldra del bucle cuando i>0 O i<0(Pero esto hace un matrix) Y cuando K sea menor 100 saldra del bucle pero para conseguir esta limitacion 
        //Introducimos un contador en el bucle--i--:Decreciente de -1 a -1
