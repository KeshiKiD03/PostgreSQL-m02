#include <stdio.h>
#include <stdlib.h>
int main(){
	/*
	11.Considerem un ascensor d'un edifici amb planta baixa i 
	dos pisos que tingui els següents 
	botons: 'pujar 1', 'pujar 2', 'baixar 1' i 'baixar 2'. 
	L'ascensor es comporta, a partir dels botons esmentats,
	 segons el següent diagrama de transició d'estats:
	*/
	int a,b;
	printf("Estas en un ascensor En que planta estas?\n");
	printf("****************\n");
	printf("0\tPlanta\n1\tPlanta\n2\tPlanta\n");
	printf("****************\n");
	fflush(stdin);
	scanf("%d",&a);
	if(a>=0 && a<3){
		printf("Estas en el piso: %d\n",a);
		printf("Que deseas hacer?\n");
		printf("****************\n");
		printf("Accion\tdescripcion\n1\tsubir 1\n2\tsubir 2\n-1\tbajar 1\n-2\tbajar 2\n");
		printf("****************\n");
		printf("pulsa: ");
		fflush(stdin);
		scanf("%d",&b);
		if((a+b)>=0 && (a+b)<3){
			printf("Ahora estas en la planta %d\n",a+b);
		}
		else{
			printf("pip pip pip: No se puede realizar esa accion\n");
		}
	}
	else{
	printf("Esa planta no existe\n");
	}
	getch();
	
	return 0;
}
