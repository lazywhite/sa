#include <stdio.h>
main(){
char c;
int nc = 0 ;
while ((c = getchar()) != EOF ) {
    putchar(c);
    ++nc;
}    
printf("%.0f\n", nc);
}

