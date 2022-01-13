#include <stdio.h>
#include <stdlib.h>

void main()
{
	
/*	Desenvolupeu un programa que demani a l’usuari que introdueixi un preu en € i la quantitat de € que paga. 
El programa compararà les dues quantitats i escriurà els € que li falten per pagar o bé els que li han de tornar. 
Ex. Si l’usuari introdueix preu=102€ i paga=150€, el programa li dirà “Sobren 48€”. 
Si l’usuari introdueix preu=102€ i paga=100€, el programa li dirà “Falten 2€” */

	// Definimos variables
	float precio;
	float preciopagado;
	 
	//Leer precio
	printf ("Introduce el precio: ");
	fflush(stdin);
	scanf("%f", &precio);
	printf ("Introduce el precio que has pagado: ");
	fflush(stdin);
	scanf("%f", &preciopagado);		 
		

	// Si has pagado y te dan el cambio
	if (precio<preciopagado) 
		printf("Te sobran %.2f euros", preciopagado-precio);
	// Si te faltan monedas para pagar
	else if (precio>preciopagado)
		printf("Te faltan %.2f euros", precio-preciopagado);
	// El precio pagado es igual al precio devuelve un impreso por pantalla que la transacción de la compra se ha hecho correctamente.
	else if (precio=preciopagado)
		printf("Has pagado correctamente sin ningun cambio",precio=preciopagado);
	
	getch();
		
			
	
	
			
			
			
}
