#include <stdio.h>
#include <stdio.h>
/* */
void main()
{
	int rep,i;
	i=0;
	printf("introduce el numero de asteriscos:");
	fflush(stdin);
	scanf("%i",&rep);
	for (i=0;i<rep;i++)
	{
		printf("*");
	}
}
