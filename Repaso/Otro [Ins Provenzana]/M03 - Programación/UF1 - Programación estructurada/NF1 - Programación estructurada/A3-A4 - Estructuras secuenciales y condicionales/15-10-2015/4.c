#include <stdio.h>
#include <stdlib.h>

void main () {
	int n1, n2, n3;
	fflush (stdin);
	printf ("Digame 3 numeros\n");
	//Introducimos 3 numeros
	int aux;
	scanf ("%d %d %d", &n1, &n2, &n3);

// miro los valores de uno en uno

// Si n1 y n2 no estan ordenados
	if (n1 > n2) {
		aux=n1;
		n1=n2;
		n2=aux;
	}

// Si n2 y n3 no estan ordenados

	if (n2 > n3) {
		aux=n3;
		n3=n2;
		n2=aux;
	}

// segunda pasada al algoritmo
	
// Si n1 y n2 no estan ordenados
	if (n1 > n2) {
		aux=n1;
		n1=n2;
		n2=aux;
	}

// Si n2 y n3 no estan ordenados

	if (n2 > n3) {
		aux=n3;
		n3=n2;
		n2=aux;
	}

	//Digitos ordenados
	printf ("Los numeros ordenados de forma creciente son:\n");
	printf ("%d %d %d\n", n1, n2, n3);
	

}
