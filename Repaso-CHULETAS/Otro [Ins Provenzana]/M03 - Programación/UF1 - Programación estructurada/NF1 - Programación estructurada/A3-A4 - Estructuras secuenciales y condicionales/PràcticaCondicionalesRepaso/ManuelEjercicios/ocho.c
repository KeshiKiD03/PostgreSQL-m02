/*
8.Desenvolupeu un programa que demani a l'usuari que introdueixi un preu en € i la quantitat de € que paga. 
El programa compararà les dues quantitats i escriurà els € que li falten per pagar o bé els que li han de tornar.
 Ex. Si l'usuari introdueix preu=102€ i paga=150€,
 el programa li dirà "Sobren 48€". Si l'usuari introdueix preu=102€ i paga=100€, el programa li dirà "Falten 2€"
*/
#include <stdio.h>
#include <stdlib.h>
int main(){
	float a,b;
	printf("Dime lo que pagas y lo que cuesta el producto y yo te dire la diferencia:\n");
	printf("Cuanto pagas: ");
	fflush(stdin);	
	scanf("%f",&a);
	printf("Cuanto cuesta: ");
	fflush(stdin);
	scanf("%f",&b);
	if((a-b)>0)
		printf("Te devuelven: %.2f\n",a-b);
	else
		printf("Te falta: %.2f\n",-(a-b));
	getch();
	return 0;
}
