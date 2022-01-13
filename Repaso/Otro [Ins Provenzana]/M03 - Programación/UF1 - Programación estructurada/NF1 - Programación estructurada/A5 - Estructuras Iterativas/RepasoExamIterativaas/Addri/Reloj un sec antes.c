#include <stdio.h>
#include <stdio.h>
/*Desenvolupeu un programa que pida una hora expresada en horas, minutos y segundos y muestre la hora, minutos y segundos que será transcurrido un segundo. */
void main()
{
	//Definimos variables
	int hour,min,sec;
	//Pedimos los valores
	printf("Introduce la hora:\n");
	fflush(stdin);
	scanf("%i",&hour);
		printf("Introduce el minuto:\n");
	fflush(stdin);
	scanf("%i",&min);
		printf("Introduce el segundo:\n");
	fflush(stdin);
	scanf("%i",&sec);
	if(hour<24&&min<60&&sec<60)
		{		
			 if(sec==0&&min>0)
			{
			printf("%i:%i:59",hour,min-1);
			}
			else if(sec==0&&min==0&&hour>0)
			{
			printf("%i:59:59",hour-1);
			}
			else if(sec==0&&min==0&&hour==0)
			{
			printf("23:59:59");
			}
			else
			{
			printf("%i:%i:%i",hour,min,sec-1);
			}
		}
	else
	{
		printf("Error");
	}
			
		}

	
	//printf("%i %i %i",hour,min,sec); (hour>=0,min>=0,sec>=0)

