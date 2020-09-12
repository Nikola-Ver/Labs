#include <windows.h>

int main(int argc, char *argv[])
{
   int time = atoi(argv[1]) * 1000;
   Sleep(time);
   char winLocationComand[] = "C:\\WINDOWS\\System32\\shutdown -s -t 0";
   system(winLocationComand);

   return 0;
}