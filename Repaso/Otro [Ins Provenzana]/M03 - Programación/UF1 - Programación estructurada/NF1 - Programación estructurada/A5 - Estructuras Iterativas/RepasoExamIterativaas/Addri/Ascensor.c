#include <stdio.h>
#include <stdio.h>
/*Considerem un ascensor de un edificio con planta baja y dos pisos que tenga los siguientes botones: 
'subir 1', 'subir 2', 'bajar 1' y 'bajar 2'. El ascensor se comporta, a partir de los botones mencionados, según el siguiente diagrama de transición de estados: */
void main()
{
	//Definimos varibles
	int piso;
		printf("En que piso estas:");
		scanf("%i", &piso);
	if(piso>=0&&piso<3)
	{
		printf("OK");
	}
	else
	{
		printf("Error");
	}
	
}
