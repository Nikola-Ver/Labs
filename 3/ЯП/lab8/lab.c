#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <windows.h>
#include <math.h>

struct TTree 
{
    int Num;
    struct TTree *Left;
    struct TTree *Right;
};

struct TPrev 
{
    struct TTree *Current;
    struct TPrev *Next;
    struct TPrev *Prev;
};

int _print_t(struct TTree *tree, int is_left, int offset, int depth, char s[20][255])
{
    int i = 0;
    char b[20];
    int width = 5;

    if (!tree) return 0;

    sprintf(b, "(%03d)", tree->Num);

    int left  = _print_t(tree->Left,  1, offset,                depth + 1, s);
    int right = _print_t(tree->Right, 0, offset + left + width, depth + 1, s);

#ifdef COMPACT
    for (i = 0; i < width; i++)
        s[depth][offset + left + i] = b[i];

    if (depth && is_left) {

        for (i = 0; i < width + right; i++)
            s[depth - 1][offset + left + width/2 + i] = '-';

        s[depth - 1][offset + left + width/2] = '.';

    } else if (depth && !is_left) {

        for (i = 0; i < left + width; i++)
            s[depth - 1][offset - width/2 + i] = '-';

        s[depth - 1][offset + left + width/2] = '.';
    }
#else
    i = 0;
    for (; i < width; i++)
        s[2 * depth][offset + left + i] = b[i];

    if (depth && is_left) {

        i = 0;
        for (; i < width + right; i++)
            s[2 * depth - 1][offset + left + width/2 + i] = '-';

        s[2 * depth - 1][offset + left + width/2] = '+';
        s[2 * depth - 1][offset + left + width + right + width/2] = '+';

    } else if (depth && !is_left) {

        i = 0;
        for (; i < left + width; i++)
            s[2 * depth - 1][offset - width/2 + i] = '-';

        s[2 * depth - 1][offset + left + width/2] = '+';
        s[2 * depth - 1][offset - width/2 - 1] = '+';
    }
#endif

    return left + width + right;
}

void print_t(struct TTree *tree)
{
    char s[20][255];
    int i = 0;
    for (; i < 20; i++)
        sprintf(s[i], "%80s", " ");

    _print_t(tree, 0, 0, 0, s);

    i = 0;
    for (; i < 20; i++)
        printf("%s\n", s[i]);
}

void NewLeftBranche (struct TTree *Tree)
{
    Tree->Left = (struct TTree*)malloc(sizeof(struct TTree));
    Tree->Left->Left = NULL;
    Tree->Left->Right = NULL;
}

void NewRightBranche (struct TTree *Tree)
{
    Tree->Right = (struct TTree*)malloc(sizeof(struct TTree));
    Tree->Right->Left = NULL;
    Tree->Right->Right = NULL;
}

void DeleteTree(struct TTree *Tree)
{
    if (Tree->Left) DeleteTree(Tree->Left);
    if (Tree->Right) DeleteTree(Tree->Right);
    free(Tree);
}

void CreateQueue(struct TPrev *Queue, struct TTree *Tree)
{
    Queue->Next = malloc(sizeof(struct TPrev*));
    Queue->Next->Prev = Queue;
    Queue = Queue->Next;
    Queue->Next = NULL;
    Queue->Current = Tree;
}

void DeleteQueue(struct TPrev *Queue)
{
    if (Queue->Next) DeleteQueue(Queue->Next);
    free(Queue);
}

void MakeTree(struct TTree *Tree, char *str, int len, int *depth)
{
    struct TTree *Head;
    struct TPrev *Queue;
    Head = Tree;
    Queue = malloc(sizeof(struct TPrev*));
    Queue->Current = Tree;
    Queue->Prev = NULL;
    Queue->Next = NULL;
    char val[256];
    int pos = 0;
    int currDepth = 0;
    for (; pos < len; pos++)
    {
        int posVal = 0;
        while ((pos < len) && (str[pos] <= '9') && (str[pos] >= '0'))
        {
            val[posVal] = str[pos];
            posVal++; pos++;
        };
        val[posVal] = '\0';
        if (posVal) Tree->Num = atoi(val);

        if (str[pos] == '(')
        {
            currDepth++;
            if (currDepth > (*depth)) (*depth) = currDepth;
            CreateQueue(Queue, Tree);
            Queue = Queue->Next;
            NewLeftBranche(Tree);
            Tree = Tree->Left;
        };

        if (str[pos] == ')')
        {
            currDepth--;
            Tree = Queue->Current;
            if (Queue->Prev) Queue = Queue->Prev;
        };

        if (str[pos] == ',')
        {
            Tree = Queue->Current;
            NewRightBranche(Tree);
            Tree = Tree->Right;
        };
    };
    DeleteQueue(Queue);
}

void main() 
{
    struct TTree *Tree;

    Tree = (struct TTree*)malloc(sizeof(struct TTree));

    system("color f");
    printf("Enter new tree: ");

    char str[256];
    scanf("%s", str);
    while (getchar() != '\n');

    int depth = 0;
    int len = strlen(str);
    // constTree = Tree;
    MakeTree(Tree, str, len, &depth);
    printf("\nDepth of tree is %d", depth);
    printf("\n\n\n");
    print_t(Tree);
    DeleteTree(Tree);
    system("pause");
}