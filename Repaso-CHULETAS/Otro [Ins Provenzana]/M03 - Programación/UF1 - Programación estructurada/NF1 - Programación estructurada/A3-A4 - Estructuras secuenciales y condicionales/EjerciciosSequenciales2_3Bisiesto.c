#include <stdio.h>
#include <stdlib.h>
#include "conio.h"

void main()
{

	char nombre [ 40];
	int an;
	printf ("Nombre:	");
	gets ( nombre);
	printf ("En que año naciste:	");
	scanf ("%i", &an);
	if ((an%4==0)&&((an%100!=0)||(an%400==0)))
	printf ("El año %i es bisiesto", an);
	else
	printf ("El año %i no es bisiesto", an);
	getch ();
}

