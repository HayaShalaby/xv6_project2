#include "types.h"
#include "stat.h"
#include "fcntl.h"
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    ;
  return os;
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
}

uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    ;
  return n;
}

void*
memset(void *dst, int c, uint n)
{
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
}

char*
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}

int
stat(const char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
  close(fd);
  return r;
}

int
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
  return n;
}

float
atof(const char *s)
{
    float n;

    n = 0.0;

    while('0' <= *s && *s <= '9'){
    n = n*10.0 + *s++ - '0';
    }


    // fractional part
    if (*s == '.') {
        s++;
        float place = 0.1;
        while ('0' <= *s && *s <= '9') {
            n += (*s - '0') * place;
            place *= 0.1;
            s++;
        }
    }

    return n;
}

void*
memmove(void *vdst, const void *vsrc, int n)
{
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
  return vdst;
}

float 
avg(float array[], int count){
    // A function to calculate the average of a given float array of numbers 
    float sum, avg; 
    sum = 0;

    for(int i = 0; i < count; i = i + 1){
        sum = sum + array[i];
    }


    avg = sum / count;

    return avg;
}

float 
min(float array[], int count){
    sort(array, count);

    return array[0];
}

float 
max(float array[], int count){
    sort(array, count);

    return array[count - 1];
}

void
sort(float array[], int count){printf(1, "Sort");}
