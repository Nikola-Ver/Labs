#include <stdio.h>
#include <string.h>

void main()
{
    struct TPrice
    {
        char Name[8];
        float Cost;
        int Count;
    };

    struct TPrice temp;
    struct TPrice Price[5];

    strcpy(Price[0].Name, "Limon");
    strcpy(Price[1].Name,  "Loaf");
    strcpy(Price[2].Name,  "Youghurt");
    strcpy(Price[3].Name,  "Tin");
    strcpy(Price[4].Name,  "Apple");
    
    Price[0].Cost = 123;
    Price[1].Cost = 312;
    Price[2].Cost = 231;
    Price[3].Cost = 74;
    Price[4].Cost = 21;

    Price[0].Count = 23;
    Price[1].Count = 12;
    Price[2].Count = 31;
    Price[3].Count = 4;
    Price[4].Count = 1;

    temp.Cost = Price[0].Cost;
    int i = 1;
    for (; i < 5; i++)
        if (temp.Cost < Price[i].Cost) temp = Price[i];

    printf("Cost: %5.1f, Name is: %10s", temp.Cost, temp.Name);
};