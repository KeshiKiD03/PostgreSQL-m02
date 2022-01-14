
/* 

2. (4 puntos) Se quiere jugar al juego “adivina el número”, en el programa se define una constante de dos dígitos, 
el usuario tendrá cinco oportunidades para adivinarlo e 
informará al usuario de las oportunidades que le quedan indicando si el valor a buscar es mayor o menor que el introducido. 
Si el usuario lo adivina le pondrá nota dependiendo de la cantidad de veces que ha jugado finalizando el programa sin consumir
los intentos restantes e indicando el numero de intentos que se han utilizado. (Cada jugada vale 2 puntos)

Frases clave:
	- Adivinar el juego en 5 oportunidades.
	- Informar al usuario de las oportunidades que le quedan.
	- El numero estará entre 1 - 100
	- Si el usuario introduce un valor, el programa le devolverá un mensaje diciendo si es mayor o menor.
	- Si el usuario lo acierta, el programa le devolverá un mensaje de "

*/
#include <stdlib.h>
#include <stdio.h>
#include <time.h>  //para el aleatorio real


int main()
{ 
 
 	//Definimos variables para que nos muestre un valor al azar
 	
	int num,num1,contadornum=1;
 	int caractmayor=100, caractmenor=0;

 	num  = 1 + rand() % 100; // Generamos el numero random
 	
	 // Mensaje de Bienvenida al juego
	 printf("\t\t ------------- Bienvenido al juego del azar ------------ \n\n");

    
 	//Vamos pidiendo números
 	printf("NOTA: Dispondr\xA0s solo de 5 oportunidades\n");
	printf("\nIntroduce numero y te dir\x82 si has acertado: ");
 	scanf("%d",&num1);
 	//Ciclo de carga y análisis | Tendremos solo 5 intentos
 	for(contadornum=1;contadornum<=4 && num1!=num;contadornum++) // Definimos el FOR | Empezamos desde 1, entonces si contadornum es menor o igual que 4 intentos ya que el primer intento es el 5
 																// Y que num1 es diferente del numero random. Si es verdadero permanece en el bucle, sino se va y el contadornum se incrementa.
 	{
		
		if(num1>num) // Si el valor introducido es mayor que el numero random
	 	{
	 		printf("\nEl numero es mayor que el secreto numero random");  // Imprime que el numero introducido es mayor que el numero random
	  		if (caractmayor!=100 && caractmayor>num1) // Si el numero mayor es diferente de 100 Y es mayor que el numero introducido
	  		{
				caractmayor = num1;
	 		}
			else if (caractmayor==100) // De lo contrario si el numero mayor es igual a 100
			{
				caractmayor = num1;
			}
	 	}	
		
		else
	 	{
			printf("\nEl numero es menor que el secreto numero random" ); // Imprime que el numero introducido es menor que el numero random
	  		if (caractmenor!=0 && caractmenor<num1) // Si el numero menor es diferente de 0 Y menor que el valor introducido
	  		{
	   			caractmenor = num1;
	  		}
	  		else  if (caractmenor==0) // De lo contrario el numero menor es igual a 0
	  		{
				caractmenor = num1;
	  		}
	 	}
	 	
		printf("\nEl numero esta entre: %i y %i", caractmenor, caractmayor); // Nos indica una pista de dónde puede estar el numero random cada vez se irá acercando al numero secreto.
		printf("\n\nTe quedan '%d' intentos\n\tNOTA:'RECUERDA que s\xA2lo tienes 5 intentos'", 5-contadornum); // Le dice al usuario cuantos intentos le quedan y le recuerda que solo tiene 5
	 	printf("\n\nIntroduce un nuevo numero para ver si aciertas: "); // Vuelve a pedir numero y vuelve a empezar el bucle hasta agotarse los 5 intentos, es decir si la condicion pasa a ser FALSE sale del bucle.
	 	scanf("%d",&num1);
	}
	
	if(num1==num)
	{
		printf("\n FELICIDADES CAMPEON! El numero random es %d y lo has logrado en %d intentos\n",num1,contadornum); // Si la condicion del numero establecido es igual al numero random entonces da un mensaje
		printf("\n Puntuacion 2 puntos");																											// Diciendo que es correcto y el numero de intentos logrados
	}
	else
	{
		printf("Lo siento mucho... \n\t No has adivinado el numero en los %d intentos\n", contadornum );  // Si es falso mensaje de no adivinado y los intentos
		printf("\n\n\nGracias por jugar :D");
	}
	
	
	fflush(stdin);
	getch();
	return 0;
	
	// Si se desea acertar el numero es recomendable subirle a más intentos y modificarle el numero de intentos restantes segun el valor que le hayas introducid.
} 
