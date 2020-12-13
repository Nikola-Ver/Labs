#include <stdio.h>

void main()
{
    char mas[7] = {'p','r','o','g','r','a','m'};
    char d = 0;

    for (int i = 0; i < 6; i += 2)
    {
        char temp = mas[i];
        mas[i] = mas[i + 1];
        mas[i + 1] = temp;
    }

    for (int d = 0; d < 7; d++)
        printf("%c", mas[d]);
}