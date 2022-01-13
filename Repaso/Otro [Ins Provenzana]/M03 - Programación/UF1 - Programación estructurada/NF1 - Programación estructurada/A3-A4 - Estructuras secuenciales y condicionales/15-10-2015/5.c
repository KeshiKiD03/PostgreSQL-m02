#include <stdio.h>
#include <stdlib.h>

void main () {

// Desenvolupeu un programa que demani una hora expressada en hores, 
// minuts i segons i mostri la hora, minuts i segons que serà 
// transcorregut un segon.

	int hora, min, seg;
	fflush (stdin);
	printf ("Digame la hora en formato hora:min:seg\n");
	//Introducimos 3 numeros

	scanf ("%d:%d:%d", &hora, &min, &seg);

// Compruebo que la hora sea correcta

if (hora>=0 && hora<24 && min>=0 && min<60 && seg>=0 && seg<60)
	{	
		// Siguiente hora
		//Incremento segundos
		seg= seg+1;
		//Compruebo segundos
		if(seg==60)
			{
			//Pongo a 0 segundos e incremento minutos
			seg=0;
			min=min+1;
			}
			
		//Compruebo minutos 
		if(min==60)
		{
			// Pongo a 0 los minutos e incremento las horas
			min=0;
			hora=hora+1;
		}
			
		//Compruebo horas
		if(hora==24)
		{
			// Pongo horas a 0
			hora=0;
		}
			
			
		//Imprimir hora
		printf("%i%i:%i%i:%i%i", hora/10, hora%10 , min/10, min%10, seg/10, seg%10);
	}


else
	{
		printf("Errores de datos");
		
	}

// sino

	// Error en los datos del programa




//	printf ("%d %d %d\n", hora, min, seg);
	

}
