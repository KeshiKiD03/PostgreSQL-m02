/*

4p) Diseña un programa que calcule el impuesto de sucesiones que se debe abonar al recibir una herencia. 
Si la herencia esta tasada entre 0,01 € y 10.000 euros se pagará un 5% 
Si la herencia esta tasada entre 10.000,01 y 100.000 euros se pagará un 10% 
Si la herencia esta tasada entre 100.000,01 y 250.000 euros se pagará un 20% 
Si es mayor que 250.000€ se pagará un 25%. 

Adicionalmente se contemplan las siguientes bonificaciones: 
Si el heredero es menor de 18 no tributa impuesto de sucesiones. 
Si el heredero es familiar directo en primer grado (padre o hijos) el tipo se reducirá un 90% 
Si el heredero es familiar en segundo grado (tios o sobrino) el tipo se reducirá un 50% 

Codigo estructurado, claro y comentado (0,5ptos) 
Recogidos y codificados todos los datos necesarios (0,5 ptos) 
Calculo del impuesto sin reducciones (1,5 ptos si compila y cumple todos los casos) 
Calculo de las bonificaciones (1,5 ptos si compila y cumple todos los casos) 

*/

#include <stdio.h>
#include <stdlib.h>


void main()
{
	// Definimos variables
	
	int heredero,tipo;
	float herencia,impuesto;
	
	// Pedimos datos
	
	printf("Impuesto de sucesion que deberas abonar para decibir la herencia\n");
	printf("****************************************************************\n");
	printf("Introduce ciertos datos y te diremos cuanto te pagaremos \n");
	printf("Que edad tienes?: ");
	fflush(stdin);
	scanf("%i", &heredero);
	printf("De cuanto esta tasada tu herencia?: ");
	fflush(stdin);
	scanf("%f", &herencia);
	printf("Es familiar de primer grado (1), o de segundo grado (2), no es familiar (3):\n");
	printf("Grado: ");
	fflush(stdin);
	scanf("%i",&tipo);
	printf("**************\n");
	
	if (heredero<18) {
		printf("No tributas en el impuesto de sucesion");
	}
	else 
	{
		if (heredero>=18) 
		{
			if (herencia>=0.01 && herencia<=10000)
			{
				impuesto=herencia*0.05;
			} 
			else if (herencia>=10000.01 && herencia<=100000) 
			{
				impuesto=herencia*0.10;	
			}
			else if (herencia>=100000.01 && herencia<=250000) 
			{
				impuesto=herencia*0.20;
			}
			else if (herencia>250000.01) 
			{
				impuesto=herencia*0.25;	
			}
			else printf("Error");
			
			// Descuento bonificado
			
			if(tipo==1){
				impuesto=impuesto-impuesto*0.9;
			}
			else if(tipo==2){
				impuesto=impuesto-impuesto*0.5;
			}
			printf ("El valor de tu impuesto es: %.3f", impuesto);
			
		}
			else printf("Error");	
	}

	getch();
	
}
