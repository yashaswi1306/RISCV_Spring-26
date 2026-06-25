#include <stdio.h>

extern char* str(char*);

int main()
{
char string[1000007];
scanf("%s",string);

char * res=str(string);
if(res!=(char*)(-1))
{
printf("%s\n",res);
}
else
{
printf("-1\n");
}
}
