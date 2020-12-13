#include <stdio.h>

void main()
{
    int n;
    scanf("%d", &n);
    int mas[n][n];
    n--;

    for (int i = 0; i <= n; i++)
        for (int j = 0; j <= n; j++)
        {
            scanf("%5d",&(mas[i][j]));
        };

    printf("\n");
    for (int i = 0; i <= n; i++)
    {
        for (int j = 0; j <= n; j++)
        {
            printf("%5d ",mas[i][j]);
        };    
        printf("\n");
    };

    int d = 0;
    int temp = mas[0][0];
    
    for (int i = 0; i <= n / 2; i++)
    {
        for (int j = d; j <= n - d; j++)
        {
            if (temp > mas[i][j])
                temp = mas[i][j];
        }; 
        d++;
    };
    d = d - 2;

    for (int i = n / 2 + 1; i <= n; i++)
    {
        for (int j = d; j <= n - d; j++)
        {
            if (temp > mas[i][j])
                temp = mas[i][j];
        };
            d--; 
    };

    printf("\nSmalst value 1: %d\n ", temp);
    temp = mas[0][0];
    d = 0;
    for (int j = 0; j <= n / 2; j++)
    {
        for (int i = d; i <= n - d; i++)
        {
            if (temp > mas[i][j])
                temp = mas[i][j];
        }; 
        d++;
    };

    printf("\nSmalst value 2: %d\n ", temp);
}