#include <stdio.h>
#include <string.h>

int main()
{
    char str1[12] = "hello";
    char str2[12] = "world";
    char str3[12] = "";
    int len;

    strcpy(str3, str1);
    printf("str3: %s\n", str3);

    strcat(str1, str2);
    printf("strcat(str1, str2): %s\n", str1);

    len = strlen(str1);
    printf("strlen of str1 %d\n", len);
    return 0;
}
        

