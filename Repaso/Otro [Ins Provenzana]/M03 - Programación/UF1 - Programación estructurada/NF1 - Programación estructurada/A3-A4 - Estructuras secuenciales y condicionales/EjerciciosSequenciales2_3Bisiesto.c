#include <stdio.h>
#include <stdlib.h>
#include "conio.h"

void main()
{

	char nombre [ 40];
	int an;
	printf ("Nombre:	");
	gets ( nombre);
	printf ("En que a�o naciste:	");
	scanf ("%i", &an);
	if ((an%4==0)&&((an%100!=0)||(an%400==0)))
	printf ("El a�o %i es bisiesto", an);
	else
	printf ("El a�o %i no es bisiesto", an);
	getch ();
}

