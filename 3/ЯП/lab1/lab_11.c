    #include <stdio.h>

    void main()
{
    int mas[6][6] = {{2,2,2,6,5,2},{2,2,2,2,2,2},{2,2,2,2,2,2},{2,2,2,2,2,2},{2,2,2,2,2,2},{2,2,2,2,2,2}};

    for (int d = 0;  d <= 5; d++)
    {
        for (int k = 0; k <= 5; k++)
            printf("%d ", mas[d][k]);
        printf("\n");
    };
    printf("\n");

    short flag = 0;
    for (int d = 0;  d <= 5; d++)
        for (int k = 0; k <= 5; k++)
        {
            for (int i = 0; i <= 5; i++)
            {
                for (int j = 0; j <= 5; j++)
                {
                    if (((mas[i][j] == mas[d][k]) && (mas[d][k] != 1) && (mas[d][k] != 0))
                          && ((k != j) || (i != d)))
                    {
                        mas[i][j] = 1;
                        flag++;
                    };
                };
            };

            if (flag != 0)  
            {
                mas[d][k] = 1;
                flag = 0;
            }
            else
                if ((mas[d][k] != 1) && (mas[d][k] != 0))
                    mas[d][k] = 0;            
        };
        
    for (int d = 0;  d <= 5; d++)
    {
        for (int k = 0; k <= 5; k++)
            printf("%d ", mas[d][k]);
        printf("\n");
    };

    printf("\n");
    int zero = 0, one = 0; 
    for (int d = 0;  d <= 5; d++)
    {
        for (int k = 0; k <= 5; k++)
        {
            if (mas[d][k] == 0)
                zero++;

            if (mas[d][k] == 1)
                one++;
        };
    };
    printf("0: %d, 1: %d", zero, one);
}