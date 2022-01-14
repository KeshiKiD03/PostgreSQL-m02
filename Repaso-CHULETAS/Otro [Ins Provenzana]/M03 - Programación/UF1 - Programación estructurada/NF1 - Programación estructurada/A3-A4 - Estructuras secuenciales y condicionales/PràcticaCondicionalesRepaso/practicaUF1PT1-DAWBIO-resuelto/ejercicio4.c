#include<stdio.h>
#include<stdlib.h>

void main()
{

	//Variables
	
	char c1, c2, opcion;

	/*Lectura datos*/


	printf("Introduzca dos caracteres: ");
	fflush(stdin);
	scanf("%c %c", &c1, &c2);


	if(c1<'a' || c1> 'z' || c2<'a' || c2>'z')
		{
		printf("Error a les dades\n");
		printf("Adeu!!\n");
		}

	else
		{
		//Imprimir menu			
		printf("MENU DE OPCIONES\n\n");			
		printf("\t1. Mostrar direccion y  tamano\n"); 
		printf("\t2. Mostrar letras codificadas\n");
		printf("\t   Pulse una opcion: _\n");
			
		opcion=getch();
		//Opcion
		
		switch(opcion)
			{
				case '1':printf("\n\ndireccion c1: %i\n", &c1);
						 printf("direccion c2: %i\n", &c2);
						 printf("\n\ntam en bytes c1: %i\n", sizeof c1);
						 printf("tam en bytes c2: %i\n", sizeof c2);
  						 break;
  						 
				case '2':printf("\n\nCodificacio\n");
						 if(c1-3<'a')						 		
						    printf("%c -> %c\n", c1, c1-3+'z'-'a');
						 else 
						    printf("%c -> %c\n", c1, (c1-3));

						 if(c2-3<'a')						 		
						    printf("%c -> %c\n", c2, c2-3+'z'-'a');
						 else 
						    printf("%c -> %c\n", c2, (c2-3));

   						 break;
				default:printf("Opcio incorrecta");
			}
		
		}
}
