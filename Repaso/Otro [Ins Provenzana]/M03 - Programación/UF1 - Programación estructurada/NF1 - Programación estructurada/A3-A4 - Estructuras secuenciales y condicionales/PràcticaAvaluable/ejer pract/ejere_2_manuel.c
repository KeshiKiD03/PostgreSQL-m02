#include <stdio.h>
#include <stdlib.h>

int main(){
	/*Determina si u numero es impar y multiplo de 5*/
	/*variable float*/
	int a;
	/*preguntamos un valor para depues decir si es par y multiplo de cinco*/
	printf("********************\n");
	printf("Dame un valor y yo te dire si es impar y multiplo de cinco\n");
	fflush(stdin);
	scanf("%d",&a);
	printf("********************\n");
	/* cuatro if co cada una de las condiciones*/
	if(a%5==0 && a%2==0){
		printf("es par y multiplo");
	}
	else if(a%5==0 && a%2!=0){
		printf("es inpar y multiplo de cinco");
	}
	else if(a%5!=0 && a%2==0){
		printf("es par y no es multiplo de cinco");
	}
	else{
		printf("no es par ni multiplo de cinco");
	}
	getch();
	return 0;
}
