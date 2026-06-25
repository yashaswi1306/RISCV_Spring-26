#include <stdio.h>
long long int bits(long long int *arr,long long int n);
int main()
{
long long int n;
scanf("%lld",&n);
long long int arr[n];
for(int i=0;i<n;i++)
scanf("%lld",&arr[i]);
printf("%lld\n",bits(arr,n));
}
