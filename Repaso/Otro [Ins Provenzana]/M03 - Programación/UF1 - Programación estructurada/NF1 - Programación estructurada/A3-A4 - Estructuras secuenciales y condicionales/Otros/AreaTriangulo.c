

/*			
	
	EXEMPLE DE CONVERSI� DE PSEUDOCODI A LLENGUATGE C
	=================================================
*/	


// ***** PSEUDOCODI A CONVERTIR A C ********************************************************************************************************


/* 	

PROGRAMA: Area_del_tri�ngulo
var
	area, base, altura: real
inicio
	leer(base, altura)
	area <- (base * altura) / 2
	escribir(area)
fin

*/


// ***** COMENTARIS AL INICI D'UN PROGRAMA C ********************************************************************************************************


/*

		Al principi del programa posarem un text que ens doni informaci� sobre el programa com:
		
		Nom del programa: 		AreaTriangulo
										Nota:
											Al pseudocodi ten�em:    PROGRAMA: Area_del_tri�ngulo 
											Recordeu que als noms no es poden posar car�c.espec.(accents, $, /...).
											�s una pr�ctica m�s habitual posar en Maj�scula la primera lletra de cada paraula
											enlloc de separar-les per un _ i sense utilitzar nexes com "del", "la"...
		Descripci�: 			Programa que llegeix pel teclat els valors de la base i altura d'un triangle
								i retorna per pantalla la seva �rea
		Autor: 					Professorat del IES Proven�ana
		Data creaci�: 			23/10/2014
		Versi� del programa: 	V1.00
		

*/


// ***** DECLARACIONS DE LES LLIBRERIES DE FUNCIONS ****************************************************************************

#include <stdio.h> // aquest include l'hem de posar com a primera l�nia de codi de tots els programes C

// ***** INICI DE LA FUNCI� PRAL "main" ****************************************************************************************
//           Tots els programes C han de tenir almenys una funci� main

int main (void)
{

// CAL POSAR LA CLAU DE TANCAMENT ("}") AL FINAL DE LA FUNCI� main

// ***** DECLARACIONS DE LES VARIABLES ********************************************************************************************************

/*
var  --> no cal que escrivim "var" abans de la declaraci� de variables
        area, base, altura: real  --> 	hem de canviar el tipus de variable "real" per "float" i posar el tipus de variable 
										abans que les variables
										Al final de cada sentencia C hem de posar un ";"
*/

float area,base,altura;

// ***** INICI DEL COS DE L'ALGORISME ********************************************************************************************************



// ***** SENTENCIA  leer --> scanf ********************************************************************************************************

/*
inicio  -->	No cal posar exactament les etiquetes del pseudocodi, per� s� posar comentaris, abans de les sent�ncies
			que creiem convenients, per poder entendre millor que fa cada part del programa

	leer(base, altura)  --> la sent�ncia:
								"leer" d'un teclat, 
							l'hem de traduir per:
								scanf("%x%y%z", &variable_x, &variable_y, &variable_z) 
									on: 
									
										%x --> tindr� un valor o un altre en funci� del tipus de variable que anem a llegir. 

											per exemple:
												%s	--> per un camp de tipus string
												%d	--> per un camp de tipus enter
												%f	--> per un camp de tipus float
												etc... (mirar als manuals de C)

										&variable_x, 
										&variable_y, 
										&variable_z 
											--> tindran el nom de cada variable
										\n  enimg -->
											

*/
	printf("%s","Introdueix la base i l'al�ada del triangle...\n");	// --> aix� no estava al pseudocodi per� ho afegim
																	//  \n    --> provoca un salt de linia 
	
	scanf("%f%f",&base, &altura);

/*
	el pseudocodi:
		area <- (base * altura) / 2

*/

	area = (base * altura) / 2;


// ***** SENTENCIA  escribir --> scanf ********************************************************************************************************

	//escribir(area)
	  	printf("%s%f", "\narea val = ", area);
//fin

	return 0;

}
