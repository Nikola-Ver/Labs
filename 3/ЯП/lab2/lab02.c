#include <stdio.h>

void main()
{
    char mas[5][8] = {{'w','o','r','d'}, {'e','a','r','t','h'}, {'r','e','a','d'}, {'w','r','i','t','e','l','n'}, {'p','r','o','g','r','a','m'}};
    char temp[8];
    int i = 4;

    for (int j = 0; j <= i / 2; j++)
    {
        for (int n = 0; n < 8; n++)
        {
            temp[n] = mas[j][n];
            mas[j][n] = mas[i - j][n];
            mas[i - j][n] = temp[n];
        };
    };

    for (int d = 0; d <= i; d++)
        for (int k = 0; k < 8; k++)
            printf("%c", mas[d][k]);
};