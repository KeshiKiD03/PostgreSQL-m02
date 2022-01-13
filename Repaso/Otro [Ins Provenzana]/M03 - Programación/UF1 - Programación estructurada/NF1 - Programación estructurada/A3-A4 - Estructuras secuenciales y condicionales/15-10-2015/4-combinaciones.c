#include <stdio.h>
#include <stdlib.h>

void main () {
	int n1, n2, n3;
	fflush (stdin);
	printf ("Digame 3 numeros\n");
	//Introducimos 3 numeros
	int aux;
	scanf ("%d %d %d", &n1, &n2, &n3);

// es n1 el más pequeño
if (n1<n2 && n1<n3)
	{
	if(n2<n3)
		printf("%i %i %i", n1, n2, n3);
	else
		printf("%i %i %i", n1, n3, n2);
	
	}
// es n2 el más pequeño
else if(n2<n1 && n2<n3)
	{
	if(n1<n3)
		printf("%i %i %i", n2, n1, n3);
	else
		printf("%i %i %i", n2, n3, n1);
		
	}
// es n3 el más pequeño
else
	{
	if(n1<n2)
		printf("%i %i %i", n3, n1, n2);
	else
		printf("%i %i %i", n3, n2, n1);
	}	 


	//Digitos ordenados
//	printf ("Los numeros ordenados de forma creciente son:\n");
//	printf ("%d %d %d\n", n1, n2, n3);
	

}
