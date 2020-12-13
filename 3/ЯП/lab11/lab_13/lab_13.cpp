//#include <iostream>
#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<string.h>

const int n = 10;

struct tree_element
{
	tree_element* addr_child_left;
	tree_element* addr_child_right;
	tree_element* addr_parent;
	char symbol;
};

struct stack
{
	char data;
	stack* AddressNext;
};

struct stroka
{
	char str[100] ;
};

void push(stack** head,char symbol) 
{
	stack* temp;
	temp = new stack;
	temp->data = symbol;
	temp->AddressNext = *head;
	*head = temp;
}

char pop(stack** head) 
{
	stack* temp;
	char data;
	if (head != NULL)
	{
		data = (*head)->data;
		temp = (*head)->AddressNext;
		delete *head;
		*head = temp;
		return data;
	}
	else
	{
		return '~';
	}
}

int get_priority_relatively(char symbol) 
{
	switch (symbol)
	{
	case '+':
		return 1;
		break;
	case '-':
		return 1;
		break;
	case '*':
		return 3;
		break;
	case '/':
		return 3;
		break;
	case '^':
		return 6;
		break;
	case '(':
		return 9;
		break;
	case ')':
		return 0;
		break;
	default:
		return 7;
		break;
	}
} 

int get_priority_stack(char symbol)
{
	switch (symbol)
	{
	case '+':
		return 2;
		break;
	case '-':
		return 2;
		break;
	case '*':
		return 4;
		break;
	case '/':
		return 4;
		break;
	case '^':
		return 5;
		break;
	case '(':
		return 0;
		break;
	case ')':
		return -1;
		break;
	default:
		return 8;
		break;
	}
}

stroka get_polish_notation(char* RPN) 
{
	stack* stack_head;
	//char* RPN_temp =;
	stroka strok;

	int i = 0;
	char symbol;
	char temp[2] = "";

	stack_head = NULL;

	//temp[1] = 0;

	push(&stack_head,'|');
	while (i<strlen(RPN))
	{
		symbol = RPN[i];
		if (stack_head->data != '|') 
		{
			if (get_priority_relatively(symbol) > get_priority_stack(stack_head->data))
			{
				push(&stack_head, symbol);
			}
			else
			{
				while ((stack_head->data != '|') && (get_priority_relatively(symbol) <= get_priority_stack(stack_head->data)))
				{
					if (symbol == ')' && stack_head->data == '(') 
					{
						pop(&stack_head);
						break;
					}
					else
					{
						if (stack_head->data != '(' && stack_head->data != ')')
						{
							temp[0] = pop(&stack_head);
							strcat_s(strok.str, temp);
						}
						else
						{
							pop(&stack_head);
						}
					}
				}
				push(&stack_head,symbol);
				if (stack_head->data == ')') { pop(&stack_head); }
			}
		}
		else
		{
			push(&stack_head,symbol);
		}
		i++;
	}
	while (stack_head->data != '|')
	{
		if (stack_head->data != '(' && stack_head->data != ')')
		{
			temp[0] = pop(&stack_head);
			strcat_s(strok.str, temp);
		}
		else
		{
			pop(&stack_head);
		}
	}
	return strok;
}

void show_tree(tree_element* head)
{
	printf("%c", head->symbol);
	if (head->addr_child_left != NULL)
	{
		printf("(");
		show_tree(head->addr_child_left);
		printf(")");
	}
	if (head->addr_child_right != NULL)
	{
		if (head->addr_child_left != NULL) { printf(","); }
		else { printf("("); }
		show_tree(head->addr_child_right);
		if (head->addr_child_left != NULL) { printf(")"); }
	}
}

void show_tree_2(tree_element* head, int deep)
{
	if (head == NULL)
		return;
	for (int i = 0; i < deep * 2; i += 2)
		printf("    |");
	printf("%c   |\n", head->symbol);
	show_tree_2(head->addr_child_left, deep + 1);
	show_tree_2(head->addr_child_right, deep + 1);
}


void build_tree(tree_element* head, char* formula,int* position,int length)
{
	tree_element* temp;
	char symbol;
	temp = new tree_element;
	symbol = formula[*position];
	(*position)++;

	temp->addr_parent = head;
	temp->symbol = symbol;
	temp->addr_child_left = NULL;
	temp->addr_child_right = NULL;
	if (*position <= length)
	{
		if ((symbol >= 'A' && symbol <= 'Z') || (symbol >= 'a' && symbol <= 'z') || (symbol >= '0' && symbol <= '9'))
		{
			if (head->addr_child_right == NULL)
			{
				head->addr_child_right = temp;
				build_tree(head, formula, position,length);
				exit;
			}
			else
			{
				if (head->addr_child_left == NULL)
				{
				head->addr_child_left = temp;
				build_tree(head->addr_parent, formula, position,length);
				exit;
				}
				else
				{
					delete temp;
					(*position)--;
					build_tree(head->addr_parent,formula,position,length);
					exit;
				}
			}
		}
		else
		{
			if (head->addr_child_right == NULL)
			{
				head->addr_child_right = temp;
				build_tree(temp, formula, position,length);
				exit;
			}
			else
			{
				head->addr_child_left = temp;
				build_tree(temp, formula, position,length);
				exit;
			}
		}
	}
	
}

void bypass_ABR(tree_element* head)
{
	if (head->addr_child_left != NULL)
	{
		bypass_ABR(head->addr_child_left);
	}
	if (head->addr_child_right != NULL) 
	{
		bypass_ABR(head->addr_child_right);
	}
	printf("%c",head->symbol);
}

void bypass_ARB(tree_element* head)
{
	if (head->addr_child_left != NULL)
	{
		bypass_ARB(head->addr_child_left);
	}
	printf("%c", head->symbol);
	if (head->addr_child_right != NULL)
	{
		bypass_ARB(head->addr_child_right);
	}
}

void bypass_RAB(tree_element* head)
{
	printf("%c", head->symbol);
	if (head->addr_child_left != NULL)
	{
		bypass_RAB(head->addr_child_left);
	}
	if (head->addr_child_right != NULL)
	{
		bypass_RAB(head->addr_child_right);
	}
}

int main()
{
	tree_element* temp;
	tree_element* head;
	head = new tree_element;
//	char formula[] = { "abcdy*42-/^^ghy2^/+/+" };
	//char formula[] = { "+/+/^2yhg^^/-24*ydcba" };
	int position = 1;
	int j = 0;
	char temp1[100];
	char temp3[100]= "";
	stroka temp2;
	stack* stack_head;

	printf_s("Enter formula: ");
	scanf("%s",temp1);
	temp2 = get_polish_notation(temp1);
	for (int i = strlen(temp2.str)-1; i >=0 ; i--)
	{
		temp3[j] = temp2.str[i];
		j++;
	}
	temp3[j] = 0;
	//puts(temp3);

	printf("\n");

	head->addr_parent = NULL;
	head->addr_child_left = NULL;
	head->addr_child_right = NULL;
	head->symbol = temp3[0];

	temp = head;
	build_tree(temp,temp3,&position, strlen(temp3));

	show_tree(head);			
	printf("\n");

	printf("\n");
	show_tree_2(head,0);

	printf("\nRAB: ");
	bypass_RAB(head);
	printf("\n");
	printf("\nARB: ");
	bypass_ARB(head);
	printf("\n");
	printf("\nABR: ");
	bypass_ABR(head);
	printf("\n");
	printf("\n");

	system("Pause");
//    std::cout << "Hello World!\n";
}

