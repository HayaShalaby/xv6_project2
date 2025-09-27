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
    mergeSort(array, count);

    return array[0];
}

float 
max(float array[], int count){
    mergeSort(array, count);

    return array[count - 1];
}

void merge(int arr[], int left, int mid, int right) 
{
    // calculate sizes of the two halves
    int n1 = mid - left + 1;
    int n2 = right - mid;
    
    // temporary arrays for left and right halves
    int L[n1], R[n2];
    
    // copy data to temporary arrays L[] and R[]
    for (int i = 0; i < n1; i++)
    {
        L[i] = arr[left + i];
    }
    
    for (int j = 0; j < n2; j++)
    {
        R[j] = arr[mid + 1 + j];
    }
    
    int i = 0, j = 0, k = left;

    // merge the temporary arrays back into arr
    while (i < n1 && j < n2) 
    {
        if (L[i] <= R[j]) // pick from left array if smaller
        {
            arr[k] = L[i];
            i++;
        } 
        else // pick from right array if smaller
        {
            arr[k] = R[j];
            j++;
        }
        k++;
    }
    
    // copy remaining elements of L[] (if any still remain)
    while (i < n1) 
    {
        arr[k] = L[i];
        i++;
        k++;
    }
    
    // copy remaining elements of R[] (if any still remain)
    while (j < n2) 
    {
        arr[k] = R[j];
        j++;
        k++;
    }
}

// recursive merge sort function
void mergeSort(int arr[], int left, int right) 
{
    if (left < right) 
    {
        // find the midpoint
        int mid = left + (right - left) / 2;

        // sort the first half
        mergeSort(arr, left, mid);

        // sort the second half
        mergeSort(arr, mid + 1, right);

        // merge the two sorted halves
        merge(arr, left, mid, right);
    }
}
