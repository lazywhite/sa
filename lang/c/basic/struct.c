#include <stdio.h>
int main()
{
    struct point
    {
        int x;
        int y;
    };
    struct rect 
    {
        struct point p1;
        struct point p2;
    };
    struct rect screen;
    struct point p1 = {10, 20};
    struct point p2 = {20, 30};

    screen.p1 = p1;
    screen.p2 = p2;
        
//    printf("%d, %d\n", pp.x, pp.y);
}

