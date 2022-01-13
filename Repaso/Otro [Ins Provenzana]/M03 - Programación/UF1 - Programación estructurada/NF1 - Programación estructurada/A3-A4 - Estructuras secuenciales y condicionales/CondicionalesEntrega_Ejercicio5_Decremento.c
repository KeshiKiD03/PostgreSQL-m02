#include <stdio.h>
#include <stdlib.h>
int main(){
	/*Desenvolupeu un programa que demani una hora expressada en hores, minuts i segons i mostri la hora, minuts i segons que serà  transcorregut un segon.*/
	
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
    // Si la hora llega a las 23:59:59 = 11:59:59 PM pasará a 23:59:58 = 11:59:58 PM
    	if(seg==0 && min==0 && hora==0){
    		seg=59;
    		min=59;
    		hora=23;
    	}
    // Si los minutos y segundos llegan a 0 se añade -1 hora
    	else if(seg==0 && min==0){
    		seg=59;
    		min=59;
    		hora--;
    	}
	// Si los segundos llega a 00 entonces volverá al valor 59 y se restará 1 minuto
    	else if(seg==0){
    		seg=59;
    		min--;
    	}
	// Por otro lado si no se cumple ninguna de esas condiciones se resta 1 segundo
    	else{
    		seg--;
    	}
    // Imprimir por pantalla el resultado
    	printf("La hora despues de un segundo es: %i:%i:%i",hora,min,seg);
    }
    // Por otro lado imprime por pantalla si lo has escrito mal
    else{
    	printf("Has escrito mal la hora");
    }
	 
	return 0;
}
