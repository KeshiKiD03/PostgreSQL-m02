#include <stdlib.h>
#include <stdio.h>
/* */

void main()
{
/*9.Desenvolupeu un médico virtual "especialista" en resfriados. Nuestro médico, sólo sabe que:
a.si el enfermo presenta estornudos y dolor de cabeza entonces, si tiene problemas de estómago le recomendará tomar paracetamol y 
si no tiene le propondrá tomar ácido acetil salicílico (AAS).
b.si el enfermo nos dice que tiene tos entonces, si es demasiado joven (menor de 12 años) le recomendará un caramelo de miel y 
de otro modo le propondrá un caramelo de eucalipto
c.si no presenta ninguno de los anteriores síntomas, el médico propondrá al paciente que venga a su consulta presencial para poder examinarlo*/
//Definimos variables
//Definimos variables
int op,op1,op2;

printf("\t\t\t\tMedico Virtual\n");

printf("Selecciona entre las siguientes opciones tus sintomas:\n");
printf("1-Estornudos y dolor de cabeza.\n");
printf("2-Tos.\n");
printf("Si no presentas ninguno de estos sintomas presiona cualqueir otro numero.\n");
fflush(stdin);
scanf("%i", &op);

if (op==1)
{	
	printf("Pulsa 1 si tienes problemas de estomago... Sino pulsa otro boton\n");
	fflush(stdin);
	scanf("%i", &op1);
	if (op1==1) printf("Toma paracetamol\n");
	else printf("Toma AAS\n");
}

else if (op==2)
{	
	// Preguntar la edad del chaval si es menor de 12 entonces le recomienda uno de eucalipto
	printf("Que edad tienes?\n");
	fflush(stdin);
	scanf("%i", &op2);
	if (op2<12)
	{
		printf("Toma un caramelo de miel\n");
	}
	else printf("Toma un caramelo de eucalipto");
}
else printf("Vete al medico mejor");	
getch();
}
