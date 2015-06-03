#include <stdio.h>
int power(int base, int n)
{
    int i , p;
    p = 1;
    for (i = 1; i <= n; i++)
        p = p*base;
    return p;
}


