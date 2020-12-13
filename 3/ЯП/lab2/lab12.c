#include <stdio.h>

void main()
{
    char mas[5][8] = {{'w','o','r','d',0}, {'e','a','r','t','h',0}, {'r','e','a','d',0}, {'w','r','i','t','e',0}, {'p','r','o','g','r','a','m',0}};
    char d = 0, cuurent = 0, max = 0;

    for (int i = 0; i < 5;  i++)
    {
        for (int j = 0; j < 8; j++)
            if (mas[i][j] != 0) cuurent++;
        if (cuurent > max) d = i;
        cuurent = 0;
    }

    for (int k = 0; k < 8; k++)
        printf("%c", mas[d][k]);
}