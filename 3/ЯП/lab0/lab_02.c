#include <stdio.h>
#include <Windows.h>

void main()
{
    system("color a");
    int n;
    printf("Enter n: ");
    scanf("%d", &n);
    printf("Natural number divisors: ");

    if (n != 0)
    {
        printf("1");
        for (int k = 2; k <= n; k++) 
        {
            if ((n % k) == 0)
                printf(", %d", k); 
        };
    }
    else
        printf("Error");    

    getchar();
    getchar();
}