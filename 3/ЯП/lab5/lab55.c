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
    int i = 0;
    while(fscanf(Input, "%d %s %d %d %d %d %d", &Student[i].Num, &Student[i].Name[0], &Student[i].Mark1,
                     &Student[i].Mark2, &Student[i].Mark3, &Student[i].Mark4, &Student[i].Mark5) != EOF)
    {
        if ((double)(Student[i].Mark1 + Student[i].Mark2 + Student[i].Mark3 + 
                        Student[i].Mark4 + Student[i].Mark5)/5 > 8) 
            fprintf(Ouput, "%d %s %d %d %d %d %d\n", Student[i].Num, &Student[i].Name[0], Student[i].Mark1, 
                                    Student[i].Mark2, Student[i].Mark3, Student[i].Mark4, Student[i].Mark5);
        i++;
    };
    fclose(Input);
    fclose(Ouput);
}