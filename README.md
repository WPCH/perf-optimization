# perf-optimization

optimization of the function below with asm for ARM

```
void *drtp(unsigned short *dest, unsigned short *src, int n)
{
	int i;
	for (i=0; i<n; i++)
	{
		unsigned int srcword = *src;
		if ( src )
		{
			*dest = srcword;
		}
		src ++;
		dest ++;
	}
}
```
