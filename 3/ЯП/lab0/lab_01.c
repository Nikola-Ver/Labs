#include <stdio.h>
#include <Windows.h>

void main()
{
    system("color a");
    int n, k = 1;
    double sum = 0;
    printf("Enter n: ");
    scanf("%d", &n);
    
    while(k <= n) 
    {
        sum += 1/(float)k;
        k++;
    };
    
    printf("Answer 1 = %f", sum);

    k = 1;
    sum = 0;    
    while(k <= n)
    {
        sum += 1/((2*(double)k+1) * (2*(double)k+1));
        k++; 
    };

    printf("\nAnswer 2 = %f", sum);

    getchar();
    getchar();
}