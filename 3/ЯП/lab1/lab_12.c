#include <stdio.h>

void main()
{
    int mas[6][6] = {{2,2,2,6,5,2},{1,2,2,2,2,2},{1,2,2,2,2,2},{2,2,2,2,2,2},{2,2,6,2,2,2},{2,2,2,10,2,2}};
    int curSum = 0;
    int Sum = 0;
    short flag = 1; 

    for (int i = 0; i <= 5; i += 2)
    {
        for (int j = 0; j <= 5; j++)
        {
            curSum += mas[i][j];
        };

        if ((flag == 1) || (curSum < Sum))
        {
            flag = 0;
            Sum = curSum;
        };
        curSum = 0;  
    };

    printf("Answer odd: %d \n", Sum);
    Sum = 0;

    for (int i = 1; i <= 5; i += 2)
    {
        for (int j = 0; j <= 5; j++)
        {
            curSum += mas[i][j];
        };

        if ((flag == 1) || (curSum > Sum))
        {
            flag = 0;
            Sum = curSum;
        };
        curSum = 0;  
    };
    printf("Answer even: %d", Sum);
}