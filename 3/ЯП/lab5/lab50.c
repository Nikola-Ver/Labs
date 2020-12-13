#include <stdio.h>
#include <string.h>

struct TStudent
{   
    int Num, Mark1, Mark2, Mark3, Mark4, Mark5;
    char Name[40];
};

void main()
{
    TStudent Student[5]; 
    FILE *Input;
    FILE *Ouput;
    Input = fopen("D:\\C\\lab5\\Student.txt", "r");
    Ouput = fopen("D:\\C\\lab5\\OutputStundent.txt", "w");
    int Num, Mark1, Mark2, Mark3, Mark4, Mark5;
    char Name[40];
    int i = 0;
    while(fscanf(Input, "%d %s %d %d %d %d %d", &Num, &Name[0], &Mark1, &Mark2, &Mark3, &Mark4, &Mark5) != EOF)
    {
        if ((double)(Mark1 + Mark2 + Mark3 + Mark4 + Mark5)/5 > 8) 
            fprintf(Ouput, "%d %s %d %d %d %d %d\n", Num, &Name[0], Mark1, Mark2, Mark3, Mark4, Mark5);
        i++;
    };
    fclose(Input);
    fclose(Ouput);
}