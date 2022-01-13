#include <stdio.h>
#include <stdlib.h>

int main(){
	/*ponemos 3 variables*/
	/*variables*/
	int op;
	float a,b,c;
	printf("********************\n");
	printf("Introduce tres valores enteros:\n");
	printf("valor a: ");
	fflush(stdin);
	scanf("%f",&a);
	printf("valor b: ");
	fflush(stdin);
	scanf("%f",&b);
	printf("valor c: ");
	fflush(stdin);
	scanf("%f",&c);
	printf("********************\n");
	printf("Eligue las opciones siguientes:\n1\tcalcula maximo\n2\tcalcula minimo\n3\tcalculo media\n");
	op=getch();
	printf("********************\n");
	/*cada una de las opciones*/
	switch(op){
		 case '1':
		 	if(a>b && a>c){
		 		printf("El numero maximo es: %.2f",a);
			}
			else if(b>c && b>a){
				printf("El numero maximo es: %.2f",b);
			}
			else{
				printf("El numero maximo es: %.2f",c);
			}
			break;
		 case '2':
		 	if(a<b && a<c){
		 		printf("El numero minimo es: %.2f",a);
			}
			else if(b<c && b<a){
				printf("El numero minimo es: %.2f",b);
			}
			else{
				printf("El numero minimo es: %.2f",c);;
			}
			break;
		 	
		 case '3':
		 	printf("La media de los tres valores es %.2f",a/3+b/3+c/3);break;
		 	
	}
	
	getch();
	
	return 0;
}
