#include <stdio.h>
#include <stdio.h>
/* */
void main()
{
/*9.Desenvolupeu un m�dico virtual "especialista" en resfriados. Nuestro m�dico, s�lo sabe que:

a.si el enfermo presenta estornudos y dolor de cabeza entonces, si tiene problemas de est�mago le recomendar� tomar paracetamol y 
si no tiene le propondr� tomar �cido acetil salic�lico (AAS).

b.si el enfermo nos dice que tiene tos entonces, si es demasiado joven (menor de 12 a�os) le recomendar� un caramelo de miel y 
de otro modo le propondr� un caramelo de eucalipto

c.si no presenta ninguno de los anteriores s�ntomas, el m�dico propondr� al paciente que venga a su consulta presencial para poder examinarlo*/
//Definimos variables

//Definimos variables
int opc,opc11,opc12,opc13;
printf("\t\t\t\tMedico virtual\n");

printf("Selecciona entre las siguientes opciones tus sintomas:\n");
printf("1-Estornudos y dolor de cabeza.\n");
printf("2-Tos.\n");
printf("Si no presentas ninguno de estos sintomas presiona cualqueir otro numero.\n");
fflush(stdin);
scanf("%i",&opc);

if (opc==1)
{

	printf("Presiona 1 si tienes problemas de estomago, si no cualquier otro numero\n");
	fflush(stdin);
	scanf("%i",&opc11);
		if (opc11==1)
		{
		printf("Toma paracetamol\n");	
		}
		else
		{
		printf("TOMA AAS\n");
		}

}
else if(opc==2)
{

	printf("Presiona 1 si eres menor de 12 anyos, si no cualquier otro numero\n");
	fflush(stdin);
	scanf("%i",&opc12);
		if (opc12==1)
		{
		printf("Toma miel\n");	
		}
		else
		{
		printf("TOMA eucalipto\n");
		}	

}
else
{
	printf("Ve al medico inutil.");
}
	
		
	
		


}
