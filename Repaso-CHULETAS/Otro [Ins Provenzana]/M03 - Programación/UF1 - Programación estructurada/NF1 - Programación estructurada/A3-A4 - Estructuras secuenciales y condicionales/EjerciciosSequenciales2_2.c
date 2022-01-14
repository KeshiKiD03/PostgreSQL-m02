#include <stdio.h>
#include <stdlib.h>

// Desenvolupeu un programa que demani un mes i un any, i escrigui el mes anterior i el mes següent. 
// Ex. Si l’usuari introdueix mes:10 i any 2003, el resultat serà anterior:9/2003 i posterior 11/2003

void main()
{
	
// Definir variables

float notas;

// Pedimos la nota

printf ("Dime la nota: ");
fflush (stdin);
scanf ("%f", notas);
// Descartamos notas negativas < 0

// Comprobamos insuficientes notas < 5

// Comprobamos suficientes		5 =< notas < 6

// Comprobamos bienes			6 =< notas < 7

// Comprobamos notables			7 =< notas < 9

// Comprobamos sobresalientes	9 =< notas < 10

// Comprobamos matrícula		notas = 10

// Error notas mayores de 10	else
if (notas<0) printf ("Error.\n");
else if (notas<5) printf("Insuficiente");
else if (notas<6) printf("Suficiente");
else if (notas<7) printf("Bien");
else if (notas<9) printf("Notable");
else if (notas<10) printf("Sobresaliente");
else if (notas==10) printf("Matricula");
else printf("Error");

}
