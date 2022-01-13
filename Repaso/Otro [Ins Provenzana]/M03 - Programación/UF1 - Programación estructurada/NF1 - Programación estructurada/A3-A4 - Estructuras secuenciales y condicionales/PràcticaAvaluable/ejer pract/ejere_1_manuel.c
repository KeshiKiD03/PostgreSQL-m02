#include <stdio.h>
#include <stdlib.h>
#define UNBAR 14.5038
int main(){
	/*
	1.-programa que realice la combercion de bares a psi
	
	*/
	/*variables en este caso es u float*/
	float psi;
	/*pediamos al usuario que introdusca un valor psi para pasarlo a bares*/
	printf("********************\n");
	printf("Dime un valor en psi y yo te lo pasare a bares\n");
	printf("psi: ");
	fflush(stdin);
	scanf("%f",&psi);
	printf("********************\n");
	printf("La conversion queda: %.3f psi=%.3f bares",psi,psi/UNBAR);	
	getch();
	return 0;
	
}
