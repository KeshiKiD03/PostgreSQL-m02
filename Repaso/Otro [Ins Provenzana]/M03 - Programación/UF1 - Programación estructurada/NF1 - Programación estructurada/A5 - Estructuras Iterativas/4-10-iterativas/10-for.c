#include <stdio.h>
#include <stdlib.h>
#define FIRST 33
#define LAST 126


int main()
{
	/*
	10. Pide al usuario una letra y el número de veces que la tiene que mostrar. 		
	*/
	
	// definimos variables
	int i,j ,primo=1;
	int num;



	for(i=0; i<100; i++)
		{		
		primo=1;
		for(j=2;j<i;j++)
			{
			if(i%j==0) primo=0;
			}
		
		if(primo==1) printf("%d es primo\n", i);
		else printf("%d no es primo\n", i);
		}



	return 0;
	

}


