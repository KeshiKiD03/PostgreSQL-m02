/*
	3. (4 puntos)Programa que pide un numero y nos muestra por pantalla tantos números primos como le pedimos. 
*/


#include <stdio.h>  
#include <stdlib.h>  

int main()
{ 
	// Definimos variables
    int num,i,n=4,cont=2,j=0;  
    int cad[1000];  
    printf("Dime un numero y te mostrare todos los numeros primos que hay en ese margen\n"); 
    // Pedimos datos y lo guardamos en la variable num en formato entero
    printf("Dime el valor: ");
    scanf("%d",&num);  
    // Hacemos la condicional
    if(num>2)
	{  
        printf("2 3");  
        while(cont<num) // Si el contador es menor que el numero introducido
		{  
            i=2;  
            while(i<=n) // Si el indice es menor o igual que el n=4
			{  
                if(i==n) // Indice igual a 4
				{  
                    cad[j]=n;  
                    printf(" %d \n",cad[j]);  
                    j++;  
                    cont=cont+1;  // Contador
                }
				else
				{  
                	if(n%i==0)
					{  
                		i=n;  
                	}  
                }  
                i=i+1;  
            }  
            n=n+1;  
        }  
    }
	else
	{  
    	if(num>0)
		{  
        	if(num==1)
			{  
            	printf("es primo 2\n");  
        	}
			else
			{  
            	printf("es primo 2, 3\n");  
        	}  
    	}
		else
		{  
        	printf("Ingrese numeros positivos por favor");  
    	}  
    } 
	system ("PAUSE"); 
   return 0;  
}  
