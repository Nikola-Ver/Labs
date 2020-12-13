#include <stdio.h>
#include <string.h>

void main()
{
    char str[25] = "POLILI_LILIY";
    char poisk[] = "LI";
    char zamena[] = "ST";
    char *istr;
    int pos;
    char i = 1;
    int flag = 1;

    int len = strlen(zamena);
    while (flag)
    {
        int shift = 0;
        istr = strstr(str,poisk);

        if ((istr != NULL) && (i < 10))
        {
            pos = istr - str;
            for (int d = pos; d <= pos + len; d++) 
            {
                if (strlen(poisk) + shift <= len)
                {
                    for (int j = 24; j > d; j--) str[j] = str[j-1];
                    shift++;
                };

                if (strlen(poisk) + shift - 1 > len)
                {
                    for (int j = d + strlen(poisk) + shift - len; j < strlen(str); j++) str[j] = str[j+1];
                    shift--;
                };

                if (d < pos + len)
                    str[d] = zamena[d-pos];
                else
                    str[d] = i + 48;
            };
        }
        else flag = 0;
        i++;
    };
    printf("%s", str);
}