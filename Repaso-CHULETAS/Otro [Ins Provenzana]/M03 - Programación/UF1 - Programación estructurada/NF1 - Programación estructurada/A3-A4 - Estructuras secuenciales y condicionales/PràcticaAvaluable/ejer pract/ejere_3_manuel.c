#include <stdio.h>
#include <stdlib.h>

int main(){
	/* Dcalcula impuestos de sucesiones que se deben abonar a una herencia*/
	/*
	3. (4p) Diseña un programa que calcule el impuesto de sucesiones que se debe abonar al recibir una herencia.
"	Si la herencia esta tasada entre 0,01 € y 10.000 euros se pagará un 5%
"	Si la herencia esta tasada entre 10.000,01 y 100.000 euros se pagará un 10%
"	Si la herencia esta tasada entre 100.000,01 y 250.000 euros se pagará un 20%
"	Si es mayor que 250.000€ se pagará un 25%.

Adicionalmente se contemplan las siguientes bonificaciones:
"	Si el heredero es menor de 18 no tributa impuesto de sucesiones.
"	Si el heredero es familiar directo en primer grado (padre o hijos) el tipo se reducirá un 90%
"	Si el heredero es familiar en segundo grado (tios o sobrino) el tipo se reducirá un 50%

	
	
	*/
	float dinero,impuesto;
	int edad,typo;
	printf("**************\n");
	printf("Soy el notario y vengo adecir de cuanto sera el impuesto de sucession que deben abonar\n");
	printf("**************\n");
	printf("De cuanto es la herencia:\n");
	fflush(stdin);
	scanf("%f",&dinero);
	printf("Que edad tiene:\n");
	fflush(stdin);
	scanf("%i",&edad);
	printf("Es familiar de primero o de segundo grado(1 o 2):\n");
	printf("grado:");
	fflush(stdin);
	scanf("%i",&typo);
	printf("**************\n");
	/*primero que si es menor*/
	if(edad>=18){
		/*de cuanto sera el impuesto*/
		if(dinero>0){
			if(0.01<=dinero && dinero<=10000){
				impuesto=dinero*0.05;
			}
			else if(10000.01<=dinero && dinero<=100000){
				impuesto=dinero*0.1;
			}
			else if(100000.01<=dinero && dinero<250000){
				impuesto=dinero*0.2;
			}
			else{
				impuesto=dinero*0.25;
			}
			/*el posible descuento*/
			if(typo==1){
				impuesto=impuesto-impuesto*0.9;
			}
			else if(typo==2){
				impuesto=impuesto-impuesto*0.5;
			}
			
			printf("tienes que pagar %.3f de impuestos",impuesto);
						
		}
		else{
			printf("error");
			
		}
	}
	else if(edad<18 && edad>0){
		printf("Tienes toda la herencia sin impuestos");
	}
	else{
		printf("error");
	}
	getch();
	return 0;
}
