#include <stdio.h>
#include <conio.h>
#include <string.h>

#define lenMas 256 

typedef struct {
            char Name[256];
            int Mark[5];
        } TGroup;
    
typedef struct TGroups {
            int Num;
            TGroup Group;
        } TGroupsRef;  

void Sort(TGroupsRef *ProcGroups, int lenArr)
{
    int step = lenArr / 2;
    struct TGroups temp;
    while (step > 0)
    {
        int i = step;
        for (; i < lenArr; i++)
        {
            int j = i;
            temp = ProcGroups[i];
            while ((j >= step) && (temp.Num < ProcGroups[j - step].Num))
            {
                ProcGroups[j] = ProcGroups[j - step];
                j = j - step;
            };
            ProcGroups[j] = temp;
        };
        step = step / 2;
    };

    int start = 0;
    int konec = 0;
    int flag;
    for(; start < lenArr - 1; start++)
    {
        flag = 0;
        int i = start;
        while ((i < lenArr- 1) && (ProcGroups[i].Num == ProcGroups[start].Num)) 
        {
            flag = 1;
            i++;
        };
        konec = i;
        int step = start;
        for (; step < konec; step++)
        {
            temp = ProcGroups[step];
            int j = step;
            int i = step + 1;
            for (; i < konec; i++) 
            {
                if (strcmp(ProcGroups[i].Group.Name, temp.Group.Name) < 0) 
                {
                    temp = ProcGroups[i];
                    j = i;
                };
            };
            ProcGroups[j] = ProcGroups[step];
            ProcGroups[step] = temp;
        };
        start = konec - 1;
    };
}

void Show(TGroupsRef *ProcGroups, int lenArr)
{
    printf("Number of group     Full Name      Math     English     Physics     History    Astronomy\n");
    int i = 0;
    for (; i < lenArr; i++)
        printf("%15d%14s%9d%10d%12d%12d%12d\n", ProcGroups[i].Num, ProcGroups[i].Group.Name, ProcGroups[i].Group.Mark[0], 
               ProcGroups[i].Group.Mark[1], ProcGroups[i].Group.Mark[2], ProcGroups[i].Group.Mark[3], ProcGroups[i].Group.Mark[4]);
}  

void ShowGroup(TGroupsRef *ProcGroups, int lenArr, int ProcNum)
{
    int i = 0;
    while ((i < lenArr) && (ProcNum != ProcGroups[i].Num)) i++;
    if (i < lenArr)
    {
        printf("Number of group     Full Name      Math     English     Physics     History    Astronomy\n");
        for (;  (i < lenArr) && (ProcNum == ProcGroups[i].Num); i++)
            printf("%15d%14s%9d%10d%12d%12d%12d\n", ProcGroups[i].Num, ProcGroups[i].Group.Name, ProcGroups[i].Group.Mark[0], 
                ProcGroups[i].Group.Mark[1], ProcGroups[i].Group.Mark[2], ProcGroups[i].Group.Mark[3], ProcGroups[i].Group.Mark[4]); 
    }
    else printf("\n>> The group was not found . . .\n");
}

void ShowCommands()
{
    printf(">> Commands list:\n");
    printf(" --save - to save changes\n");
    printf(" --add - to add new student\n");
    printf(" --delete - to remove student\n");
    printf(" --change - to change some information of student\n");
    printf(" --show - to show all groups\n");
    printf(" --showgroup - to show specific group\n");
    printf(" --stop - to exit\n\n");
}

void Save(TGroupsRef *ProcGroups, int lenArr)
{
    FILE *f;
    f = fopen("D:\\C\\lab6\\List.txt","w");
    int i = 0;
    while (i < lenArr)
    {
        fprintf(f, "%d %d %d %d %d %d %s\n", ProcGroups[i].Num, ProcGroups[i].Group.Mark[0], 
                  ProcGroups[i].Group.Mark[1], ProcGroups[i].Group.Mark[2], ProcGroups[i].Group.Mark[3],
                  ProcGroups[i].Group.Mark[4], ProcGroups[i].Group.Name);
        i++;
    };
    fclose(f);  
}

void DeleteStudent(TGroupsRef *ProcGroups, int *lenArr)
{
    char ProcName[256];
    printf(">> Enter full name of student to remove his: ");
    scanf("%s", ProcName);
    int i = 0;
    while ((i < (*lenArr)) && (strcmp(ProcName,ProcGroups[i].Group.Name) != 0)) i++;
    if (i < (*lenArr))
    {
        printf(">> Student remove\n\n");
        (*lenArr)--;
        for (; i < (*lenArr); i++) ProcGroups[i] = ProcGroups[i + 1];
    }
    else printf(">> Student not found . . .\n\n");
}

void AddStudent(TGroupsRef *ProcGroups, int *lenArr)
{
    int tempNum;
    char tempName[256];
    printf(">> Enter full name of student: ");
    scanf("%s", tempName);
    strcpy(ProcGroups[(*lenArr)].Group.Name, tempName);
    while (getchar() != '\n');
    printf(">> Enter group of student: ");
    scanf("%d", &ProcGroups[(*lenArr)].Num);
    while (getchar() != '\n');
    printf(">> Enter mark of math: ");
    scanf("%d", &tempNum);
    ProcGroups[(*lenArr)].Group.Mark[0] = tempNum; 
    while (getchar() != '\n');
    printf(">> Enter mark of english: ");
    scanf("%d", &tempNum);
    ProcGroups[(*lenArr)].Group.Mark[1] = tempNum;
    while (getchar() != '\n');
    printf(">> Enter mark of physics: ");
    scanf("%d", &tempNum);
    ProcGroups[(*lenArr)].Group.Mark[2] = tempNum;
    while (getchar() != '\n');
    printf(">> Enter mark of history: ");
    scanf("%d", &tempNum);
    ProcGroups[(*lenArr)].Group.Mark[3] = tempNum;
    while (getchar() != '\n');
    printf(">> Enter mark of astronomy: ");
    scanf("%d", &tempNum);
    ProcGroups[(*lenArr)].Group.Mark[4] = tempNum;
    while (getchar() != '\n');
    (*lenArr)++;
}

void ListInitializtion(TGroupsRef *ProcGroups, int *lenArr)
{
    FILE *f;
    f = fopen("D:\\C\\lab6\\List.txt","r");
    int i = 0;
    while (fscanf(f, "%d %d %d %d %d %d %s", &ProcGroups[i].Num, &ProcGroups[i].Group.Mark[0], 
                  &ProcGroups[i].Group.Mark[1], &ProcGroups[i].Group.Mark[2], &ProcGroups[i].Group.Mark[3],
                  &ProcGroups[i].Group.Mark[4], ProcGroups[i].Group.Name) != EOF)
    {
        i++;
        (*lenArr)++;
    };
    fclose(f);
}

void ChangeStudent(TGroupsRef *ProcGroups, int lenArr)
{
    int i = 0;
    int d = 0;
    char tempName[256];
    printf(">> Enter full name of student: ");
    scanf("%s", tempName);
    while (getchar() != '\n');
    while ((i < lenArr) && (strcmp(ProcGroups[i].Group.Name, tempName) != 0)) i++;
    if (i < lenArr)
    {
        printf(">> Enter the attribute you want to change ((group, name, math, english, physics, history, astronomy) or (all)): ");
        scanf("%s", tempName);
        while (getchar() != '\n');
        if (strcmp(tempName, "all") == 0)
        {
            printf(">> Enter new group: ");
            scanf("%d", &d);
            while (getchar() != '\n');
            ProcGroups[i].Num = d;
            printf(">> Enter new name: ");
            scanf("%s", &tempName);
            while (getchar() != '\n');
            strcpy(ProcGroups[i].Group.Name, tempName);
            printf(">> Enter new math: ");
            scanf("%d", &d);
            while (getchar() != '\n');
            ProcGroups[i].Group.Mark[0] = d;
            printf(">> Enter new english: ");
            scanf("%d", &d);
            while (getchar() != '\n');
            ProcGroups[i].Group.Mark[1] = d;
            printf(">> Enter new physics: ");
            scanf("%d", &d);
            while (getchar() != '\n');
            ProcGroups[i].Group.Mark[2] = d;
            printf(">> Enter new history: ");
            scanf("%d", &d);
            while (getchar() != '\n');
            ProcGroups[i].Group.Mark[3] = d;
            printf(">> Enter new astronomy: ");
            scanf("%d", &d);
            while (getchar() != '\n');
            ProcGroups[i].Group.Mark[4] = d;
        };
        if (strcmp(tempName, "group") == 0)
        {
            printf(">> Enter new group: ");
            scanf("%d", &d);
            while (getchar() != '\n');
            ProcGroups[i].Num = d;   
        };
        if (strcmp(tempName, "name") == 0)
        {
            printf(">> Enter new name: ");
            scanf("%s", &tempName);
            while (getchar() != '\n');
            strcpy(ProcGroups[i].Group.Name, tempName);
        };
        if (strcmp(tempName, "math") == 0)
        {
            printf(">> Enter new math: ");
            scanf("%d", &d);
            while (getchar() != '\n');
            ProcGroups[i].Group.Mark[0] = d;
        };
        if (strcmp(tempName, "english") == 0)
        {
            printf(">> Enter new english: ");
            scanf("%d", &d);
            while (getchar() != '\n');
            ProcGroups[i].Group.Mark[1] = d;
        };
        if (strcmp(tempName, "physics") == 0)
        {
            printf(">> Enter new physics: ");
            scanf("%d", &d);
            while (getchar() != '\n');
            ProcGroups[i].Group.Mark[2] = d;
        };
        if (strcmp(tempName, "history") == 0)
        {
            printf(">> Enter new history: ");
            scanf("%d", &d);
            while (getchar() != '\n');
            ProcGroups[i].Group.Mark[3] = d;
        };
        if (strcmp(tempName, "astronomy") == 0)
        {
            printf(">> Enter new astronomy: ");
            scanf("%d", &d);
            while (getchar() != '\n');
            ProcGroups[i].Group.Mark[4] = d;
        };
    }
    else printf(">> Student not found . . .\n");
}

void main()
{
    system("cls");
    char temp[256] = {0};
    struct TGroups Groups[lenMas];
    int len = 0;
    int groupnum = 0;
    ListInitializtion(Groups, &len);   
    ShowCommands();
    printf(">> Write help to see a list of commands\n\n");
    printf(">> ");
    scanf("%s", temp);
    printf("\n");
    while (getchar() != '\n');
    system("cls");
    while (strcmp(temp, "stop") != 0)
    {
        if (strcmp(temp, "save") == 0) Save(Groups, len);   
        if (strcmp(temp, "add") == 0)
        {
            printf(">> stop - to stop adding students\n\n");
            while (strcmp(temp, "stop") != 0)
            { 
                AddStudent(Groups, &len);
                printf("\n>> ");
                scanf("%s", temp);
                printf("\n");
                while (getchar() != '\n');
            };
        };
        if (strcmp(temp, "change") == 0)
        {
            printf(">> stop - to stop changing students\n\n");
            while (strcmp(temp, "stop") != 0)
            { 
                ChangeStudent(Groups, len);
                printf("\n>> ");
                scanf("%s", temp);
                printf("\n");
                while (getchar() != '\n');
            };
        };
        if (strcmp(temp, "delete") == 0)
        {
            printf(">> stop - to stop removing students\n\n");
            while (strcmp(temp, "stop") != 0)
            { 
                DeleteStudent(Groups, &len);
                printf(">> ");
                scanf("%s", temp);
                printf("\n");
                while (getchar() != '\n');
            };
        };
        system("cls");
        if (strcmp(temp, "show") == 0)
        {
            Sort(Groups, len);
            Show(Groups, len);
        };
        if (strcmp(temp, "showgroup") == 0)
        {
            Sort(Groups, len);
            printf(">> Enter group: ");
            scanf("%d", &groupnum);
            printf("\n");
            while (getchar() != '\n');
            ShowGroup(Groups, len, groupnum);
        };
        if (strcmp(temp, "help") == 0) ShowCommands();
        printf(">> ");
        scanf("%s", temp);
        printf("\n");
        while (getchar() != '\n');
        system("cls");
    }
}