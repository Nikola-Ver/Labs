#include <stdio.h>
#include <stdlib.h>
#define NMAX 100

struct TStack 
{
  int elem[NMAX];
  int top;
};

void init(struct TStack *stk) 
{
  stk->top = 0;
};

void push(struct TStack *stk, int f) {
  if(stk->top < NMAX) {
    stk->elem[stk->top] = f;
    stk->top++;
  } else
    printf("Стек полон, количество элементов: %d !\n", stk->top);
};

int pop(struct TStack *stk) {
  int elem;
  if((stk->top) > 0) {
    stk->top--;
    elem = stk->elem[stk->top];
    return(elem);
  } else {
    printf("Стек пуст!\n");
    return(0);
  }
}

void main()
{
    srand(0);
    struct TStack *stack1;
    struct TStack *stack2;
    stack1 = malloc(sizeof(struct TStack));
    stack2 = (struct TStack*)malloc(sizeof(struct TStack));
    init(stack1);
    init(stack2);
    int len = 0;
    printf("Stack1\n");
    for (; len < 4; len++) 
    {
        push(stack1, rand());
        printf("%d\n", stack1->elem[len]);
    };
    printf("\nStack2\n");
    len = 0;
    for (; len < 4; len++) 
    {
        push(stack2, rand());
        printf("%d\n", stack2->elem[len]);
    };
    printf("\n\nStack1\n");
    int step = 0;    
    for (; step < len; step++)
    {
      pop(stack2);
      push(stack1, stack2->elem[stack2->top]);
    };

    step = 0;
    int temp;
    for (; step < len * 2; step++)
    {
        temp = stack1->elem[step];
        int j = step;
        int i = step + 1;
        for (; i < len * 2; i++) 
        {
            if (stack1->elem[i] > temp) 
            {
                temp = stack1->elem[i];
                j = i;
            };
        };
        stack1->elem[j] = stack1->elem[step];
        stack1->elem[step] = temp;
    };
    for (step = 0; step < 2 * len; step++)
    {
      pop(stack1);
      printf("%d\n",stack1->elem[stack1->top]);
    }
}