#include <stdio.h>
#include <stdlib.h>
int main(){
	/*
	10.Desenvolupem un ajudant infantil per decidir que fer davant
	 un semàfor. El programa demanarà de quin color està el semàfor
	  i segons la resposta recomanarà passar, esperar, o córrer
	*/
	char opcion;
	printf("De quin color es el semafor:\n");
	printf("****************\n");
	printf("Opcion\tcolor\nR/r\trojo\nA/a\tamarillo\nV/v\tverde\n");
	printf("****************\n");
	fflush(stdin);
	opcion=getch();
	switch(opcion){
		case 'a':printf("Amarillo\n");break;
		case 'A':printf("Amarillo\n");break;
		case 'r':printf("Rojo\n");break;
		case 'R':printf("Rojo\n");break;
		case 'v':printf("Verde\n");break;
		case 'V':printf("Verde\n");break;
		default:printf("Error\n");break;
	}
	getch();
	return 0;
}
