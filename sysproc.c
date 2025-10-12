#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;

};
static long time_offset_seconds = 0;
uint
sys_gettimeofday(void)
{
  struct rtcdate r;
  cmostime(&r);

  // Print current time
  cprintf("Date: %d/%d/%d Time: %d:%d:%d\n",
          r.day, r.month, r.year, r.hour, r.minute, r.second);
  return 0;
}

int
sys_truncate(void)
{
	char path[MAXPATH];
    int length;
    struct inode *ip;

    // Get arguments from user
    if (argstr(0, path, MAXPATH) < 0 || argint(1, &length) < 0)
        return -1;

    begin_op();                      // start filesystem transaction
    if ((ip = namei(path)) == 0) {   // find inode by path
        end_op();
        return -1;                   // file not found
    }

    ilock(ip);

    // Only truncate regular files (e.g. not directories)
    if (ip->type != T_FILE) {
        iunlockput(ip);
        end_op();
        return -1;
    }

    // If length is less than current size, shrink
    if (length < ip->size) {
        itrunc(ip, length);
    }

    iunlockput(ip);
    end_op();

    return 0;
}
