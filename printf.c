#include "types.h"
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
}


static void
printint(int fd, int xx, int base, int sgn)
{
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    putc(fd, buf[i]);
}

static void
printfloat(int fd, float xx)
{
  if (xx < 0) {
    putc(fd, '-');
    xx = -xx;
  }

  // integer part
  int intpart = (int)xx;
  printint(fd, intpart, 10, 1);

  // decimal point
  putc(fd, '.');

  // fractional part (fixed 6 digits)
  float frac = xx - intpart;
  for (int i = 0; i < 6; i++) {
    frac *= 10;
    int digit = (int)frac;
    putc(fd, '0' + digit); //to pass digit as a char
    frac -= digit;
  }
}

// Print to the given fd. Only understands %d, %x, %p, %s. // added %f
void
printf(int fd, const char *fmt, ...)
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      }else if(c == 'f'){ //add a case for float
        double f = *(double*)ap;       // printf makes floats doubles 
        printfloat(fd, float(f));
        ap += sizeof(double)/sizeof(uint); // move argument pointer forward, not normal increment due to double size 
      }else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    }
  }
}
