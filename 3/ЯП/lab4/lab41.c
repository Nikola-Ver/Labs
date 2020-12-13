#include <stdio.h>
#include <string.h>

void main()
{
    struct TStudent
    {
        char Name[8];
        int Mark;
    };

    struct TStudent temp;
    struct TStudent Student[5];

    strcpy(Student[0].Name, "denis");
    strcpy(Student[1].Name, "eogan");
    strcpy(Student[2].Name, "cuper");
    strcpy(Student[3].Name, "bonik");
    strcpy(Student[4].Name, "andrey");

    Student[0].Mark = 6;
    Student[1].Mark = 6;
    Student[2].Mark = 6;
    Student[3].Mark = 6;
    Student[4].Mark = 6;

    int step = 0;
    int z = 5;

    for (; step < z; step++)
    {
        temp = Student[step];
        int j = step;
        int i = step + 1;
        for (; i < z; i++) 
        {
            if (Student[i].Name[0] < temp.Name[0]) 
            {
                temp = Student[i];
                j = i;
            };
        };
        Student[j] = Student[step];
        Student[step] = temp;
    };

    float SMark = Student[0].Mark;
    for (step = 1; step < z; step++)
    {
        SMark += Student[step].Mark;;
    };
    SMark = SMark / z;
    printf("Medium mark is: %f\n\n", SMark); 

    for (step = 0; step < z; step++)
    {
        if (Student[step].Mark >= SMark) printf("%s, Mark is: %d\n", Student[step].Name, Student[step].Mark); 
    };    
};