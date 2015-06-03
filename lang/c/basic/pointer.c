#include <stdio.h>
int main()
{
//    int var1 ;
//    char var2[10];
//    printf("address of var1: %x\n", &var1);
//    printf("address of var2: %x\n", &var2);
//    return 0;
    int var1 = 10;
    int *p = &var1;
    printf("address of var1, %d\n", p);
}
