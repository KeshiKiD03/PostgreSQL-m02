#include <stdio.h>
#include <stdlib.h>
/*4Desenvolupeu un programa que demani tres números i escrigui els tres números ordenats creixentment (de menor a major). Ex. si els números són 3, 4 i 2, el resultat serà 2 3 4.
5Desenvolupeu un programa que demani una hora expressada en hores, minuts i segons i mostri la hora, minuts i segons que serà transcorregut un segon.*/

int main(){
    int a,b,c;
    printf("Dame 3 numeros:\n");

    printf("uno");
    fflush(stdin);
    scanf("%i",&a);
    printf("dos");
    fflush(stdin);
    scanf("%i",&b);
    fflush(stdin);
    printf("tres");
    scanf("%i",&c);    


    if(a>b && a>c)
    {
           if(b>c){
                   printf("los numeros son:%i,%i,%i",c,b,a);
           
           }       
           else{
                printf("los numeros son:%i,%i,%i",b,c,a);   
           
           }
    }
    
    else if(b>a && b>c)
    {
           if(a>c){
                   printf("los numeros son:%i,%i,%i",c,a,b);
           
           }       
           else{
                printf("los numeros son:%i,%i,%i",a,c,b);    
           
           }
    }


    else if(c>a && c>a)
    {
           if(a>b){           
                              printf("los numeros son:%i,%i,%i",b,a,c);
           }       
           else{   
                   printf("los numeros son:%i,%i,%i",a,b,c);
           }
    }

    
    return 0;
}
