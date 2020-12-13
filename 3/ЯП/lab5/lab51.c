#include <stdio.h>
#include <string.h>

void main()
{
    FILE *Input;
    FILE *Ouput;
    Input = fopen("D:\\C\\lab5\\F1.txt", "r");
    Ouput = fopen("D:\\C\\lab5\\F2.txt", "w");
    int Num;
    while (fscanf(Input, "%d", &Num) != EOF) 
        if (Num % 2 == 1) fprintf(Ouput, "%d ", Num);
    fclose(Input);
    fclose(Ouput);
}