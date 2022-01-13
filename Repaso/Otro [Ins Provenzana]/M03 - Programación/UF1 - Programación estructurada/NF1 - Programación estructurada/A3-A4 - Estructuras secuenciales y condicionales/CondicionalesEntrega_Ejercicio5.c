#include <stdio.h>
#include <stdlib.h>
int main(){
	/*Desenvolupeu un programa que demani una hora expressada en hores, minuts i segons i mostri la hora, minuts i segons que ser� transcorregut un segon.*/
	
	// Definir variables
	
	int hora,min,seg;
	printf("Dime la hora en hora minutos y segundos:\n");
	printf("Hora: ");
    fflush(stdin);
    scanf("%i",&hora);
	printf("Minuto: ");
    fflush(stdin);
    scanf("%i",&min);
	printf("Segundo: ");
    fflush(stdin);
    scanf("%i",&seg);
    // Un dia entero tiene 24 horas, 1 hora tiene 60 minutos y 1 minuto son 60 segundos
    if(hora<24 && min<60 && seg<60){
    // Si la hora llega a las 23:59 = 11:59PM pasar� a 00:00 = 12:00AM
    	if(seg==59 && min==59 && hora==23){
    		seg=0;
    		min=0;
    		hora=0;
    	}
    // Si los minutos y segundos llegan a 59 se a�ade +1 hora
    	else if(seg==59 && min==59){
    		seg=0;
    		min=0;
    		hora++;
    	}
	// Si los segundos llega a 59 entonces volver� al valor 0 y los minutos se sumar�  	
    	else if(seg==59){
    		seg=0;
    		min++;
    	}
	// Por otro lado si no se cumple ninguna de esas condiciones se suma 1 segundo
    	else{
    		seg++;
    	}
    // Imprimir por pantalla el resultado
    	printf("La hora despues de un segundo es: 0%i:0%i:0%i",hora,min,seg);
    }
    // Por otro lado imprime por pantalla si lo has escrito mal
    else{
    	printf("Has escrito mal la hora");
    }
	 
	return 0;
}
