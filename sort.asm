
user/_sort:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <merge>:
        each level takes O(n) work to merge)
    space complexity: O(n) -> for extra temp arrays used during merging
*/
// function to merge two sorted halves
void merge(int arr[], int left, int mid, int right) 
{
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
   6:	88aa                	mv	a7,a0
    // calculate sizes of the two halves
    int n1 = mid - left + 1;
   8:	40b60f3b          	subw	t5,a2,a1
   c:	001f0f9b          	addiw	t6,t5,1
    int n2 = right - mid;
  10:	9e91                	subw	a3,a3,a2
  12:	00068e9b          	sext.w	t4,a3
    
    // temporary arrays for left and right halves
    int L[n1], R[n2];
  16:	002f9793          	slli	a5,t6,0x2
  1a:	07bd                	addi	a5,a5,15
  1c:	9bc1                	andi	a5,a5,-16
  1e:	40f10133          	sub	sp,sp,a5
  22:	8e0a                	mv	t3,sp
  24:	002e9293          	slli	t0,t4,0x2
  28:	00f28793          	addi	a5,t0,15
  2c:	9bc1                	andi	a5,a5,-16
  2e:	40f10133          	sub	sp,sp,a5
  32:	830a                	mv	t1,sp
    
    // copy data to temporary arrays L[] and R[]
    for (int i = 0; i < n1; i++)
  34:	03f05363          	blez	t6,5a <merge+0x5a>
  38:	00259713          	slli	a4,a1,0x2
  3c:	972a                	add	a4,a4,a0
  3e:	87f2                	mv	a5,t3
  40:	001f081b          	addiw	a6,t5,1
  44:	02081513          	slli	a0,a6,0x20
  48:	01e55813          	srli	a6,a0,0x1e
  4c:	9872                	add	a6,a6,t3
    {
        L[i] = arr[left + i];
  4e:	4308                	lw	a0,0(a4)
  50:	c388                	sw	a0,0(a5)
    for (int i = 0; i < n1; i++)
  52:	0711                	addi	a4,a4,4
  54:	0791                	addi	a5,a5,4
  56:	ff079ce3          	bne	a5,a6,4e <merge+0x4e>
    }
    
    for (int j = 0; j < n2; j++)
  5a:	07d05063          	blez	t4,ba <merge+0xba>
  5e:	00160793          	addi	a5,a2,1
  62:	078a                	slli	a5,a5,0x2
  64:	97c6                	add	a5,a5,a7
  66:	871a                	mv	a4,t1
  68:	00628533          	add	a0,t0,t1
    {
        R[j] = arr[mid + 1 + j];
  6c:	4390                	lw	a2,0(a5)
  6e:	c310                	sw	a2,0(a4)
    for (int j = 0; j < n2; j++)
  70:	0791                	addi	a5,a5,4
  72:	0711                	addi	a4,a4,4
  74:	fea71ce3          	bne	a4,a0,6c <merge+0x6c>
    }
    
    int i = 0, j = 0, k = left;

    // merge the temporary arrays back into arr
    while (i < n1 && j < n2) 
  78:	03f05f63          	blez	t6,b6 <merge+0xb6>
  7c:	00259513          	slli	a0,a1,0x2
  80:	9546                	add	a0,a0,a7
    int i = 0, j = 0, k = left;
  82:	4601                	li	a2,0
  84:	4701                	li	a4,0
  86:	a809                	j	98 <merge+0x98>
            arr[k] = L[i];
            i++;
        } 
        else // pick from right array if smaller
        {
            arr[k] = R[j];
  88:	c11c                	sw	a5,0(a0)
            j++;
  8a:	2605                	addiw	a2,a2,1
        }
        k++;
  8c:	2585                	addiw	a1,a1,1
    while (i < n1 && j < n2) 
  8e:	07f75663          	bge	a4,t6,fa <merge+0xfa>
  92:	0511                	addi	a0,a0,4
  94:	03d65763          	bge	a2,t4,c2 <merge+0xc2>
        if (L[i] <= R[j]) // pick from left array if smaller
  98:	00271793          	slli	a5,a4,0x2
  9c:	97f2                	add	a5,a5,t3
  9e:	0007a803          	lw	a6,0(a5)
  a2:	00261793          	slli	a5,a2,0x2
  a6:	979a                	add	a5,a5,t1
  a8:	439c                	lw	a5,0(a5)
  aa:	fd07cfe3          	blt	a5,a6,88 <merge+0x88>
            arr[k] = L[i];
  ae:	01052023          	sw	a6,0(a0)
            i++;
  b2:	2705                	addiw	a4,a4,1
  b4:	bfe1                	j	8c <merge+0x8c>
    while (i < n1 && j < n2) 
  b6:	4601                	li	a2,0
  b8:	a099                	j	fe <merge+0xfe>
  ba:	07f05463          	blez	t6,122 <merge+0x122>
    int i = 0, j = 0, k = left;
  be:	4601                	li	a2,0
  c0:	4701                	li	a4,0
    }
    
    // copy remaining elements of L[] (if any still remain)
    while (i < n1) 
  c2:	00271793          	slli	a5,a4,0x2
  c6:	97f2                	add	a5,a5,t3
  c8:	00259813          	slli	a6,a1,0x2
  cc:	9846                	add	a6,a6,a7
  ce:	00070f9b          	sext.w	t6,a4
  d2:	40ef053b          	subw	a0,t5,a4
  d6:	1502                	slli	a0,a0,0x20
  d8:	9101                	srli	a0,a0,0x20
  da:	953a                	add	a0,a0,a4
  dc:	050a                	slli	a0,a0,0x2
  de:	0e11                	addi	t3,t3,4
  e0:	9572                	add	a0,a0,t3
    {
        arr[k] = L[i];
  e2:	4398                	lw	a4,0(a5)
  e4:	00e82023          	sw	a4,0(a6)
    while (i < n1) 
  e8:	0791                	addi	a5,a5,4
  ea:	0811                	addi	a6,a6,4
  ec:	fea79be3          	bne	a5,a0,e2 <merge+0xe2>
  f0:	2f05                	addiw	t5,t5,1
  f2:	00bf0f3b          	addw	t5,t5,a1
  f6:	41ff05bb          	subw	a1,t5,t6
        i++;
        k++;
    }
    
    // copy remaining elements of R[] (if any still remain)
    while (j < n2) 
  fa:	03d65463          	bge	a2,t4,122 <merge+0x122>
  fe:	00261793          	slli	a5,a2,0x2
 102:	979a                	add	a5,a5,t1
 104:	058a                	slli	a1,a1,0x2
 106:	00b88533          	add	a0,a7,a1
 10a:	9e91                	subw	a3,a3,a2
 10c:	1682                	slli	a3,a3,0x20
 10e:	9281                	srli	a3,a3,0x20
 110:	96b2                	add	a3,a3,a2
 112:	068a                	slli	a3,a3,0x2
 114:	969a                	add	a3,a3,t1
    {
        arr[k] = R[j];
 116:	4398                	lw	a4,0(a5)
 118:	c118                	sw	a4,0(a0)
    while (j < n2) 
 11a:	0791                	addi	a5,a5,4
 11c:	0511                	addi	a0,a0,4
 11e:	fed79ce3          	bne	a5,a3,116 <merge+0x116>
        j++;
        k++;
    }
}
 122:	ff040113          	addi	sp,s0,-16
 126:	6422                	ld	s0,8(sp)
 128:	0141                	addi	sp,sp,16
 12a:	8082                	ret

000000000000012c <mergeSort>:

// recursive merge sort function
void mergeSort(int arr[], int left, int right) 
{
    if (left < right) 
 12c:	00c5c363          	blt	a1,a2,132 <mergeSort+0x6>
 130:	8082                	ret
{
 132:	7139                	addi	sp,sp,-64
 134:	fc06                	sd	ra,56(sp)
 136:	f822                	sd	s0,48(sp)
 138:	f426                	sd	s1,40(sp)
 13a:	f04a                	sd	s2,32(sp)
 13c:	ec4e                	sd	s3,24(sp)
 13e:	e852                	sd	s4,16(sp)
 140:	e456                	sd	s5,8(sp)
 142:	0080                	addi	s0,sp,64
 144:	89aa                	mv	s3,a0
 146:	84ae                	mv	s1,a1
 148:	8932                	mv	s2,a2
    {
        // find the midpoint
        int mid = left + (right - left) / 2;
 14a:	40b607bb          	subw	a5,a2,a1
 14e:	01f7da1b          	srliw	s4,a5,0x1f
 152:	00fa0a3b          	addw	s4,s4,a5
 156:	401a5a1b          	sraiw	s4,s4,0x1
 15a:	00ba0a3b          	addw	s4,s4,a1
 15e:	000a0a9b          	sext.w	s5,s4

        // sort the first half
        mergeSort(arr, left, mid);
 162:	8656                	mv	a2,s5
 164:	fc9ff0ef          	jal	12c <mergeSort>

        // sort the second half
        mergeSort(arr, mid + 1, right);
 168:	864a                	mv	a2,s2
 16a:	001a059b          	addiw	a1,s4,1
 16e:	854e                	mv	a0,s3
 170:	fbdff0ef          	jal	12c <mergeSort>

        // merge the two sorted halves
        merge(arr, left, mid, right);
 174:	86ca                	mv	a3,s2
 176:	8656                	mv	a2,s5
 178:	85a6                	mv	a1,s1
 17a:	854e                	mv	a0,s3
 17c:	e85ff0ef          	jal	0 <merge>
    }
}
 180:	70e2                	ld	ra,56(sp)
 182:	7442                	ld	s0,48(sp)
 184:	74a2                	ld	s1,40(sp)
 186:	7902                	ld	s2,32(sp)
 188:	69e2                	ld	s3,24(sp)
 18a:	6a42                	ld	s4,16(sp)
 18c:	6aa2                	ld	s5,8(sp)
 18e:	6121                	addi	sp,sp,64
 190:	8082                	ret

0000000000000192 <main>:

int main(int argc, char *argv[])
{
 192:	7129                	addi	sp,sp,-320
 194:	fe06                	sd	ra,312(sp)
 196:	fa22                	sd	s0,304(sp)
 198:	0280                	addi	s0,sp,320
    // check input. if argument count is less than 2, no numbers to sort, so display proper usage of the command
    if(argc < 2) 
 19a:	4785                	li	a5,1
 19c:	08a7d163          	bge	a5,a0,21e <main+0x8c>
 1a0:	f626                	sd	s1,296(sp)
 1a2:	f24a                	sd	s2,288(sp)
 1a4:	ee4e                	sd	s3,280(sp)
 1a6:	ea52                	sd	s4,272(sp)
 1a8:	e656                	sd	s5,264(sp)
 1aa:	8aaa                	mv	s5,a0

    int n = argc - 1;
    int nums[64]; // maximum 64 numbers for now

    // convert arguments into integers
    for(int i = 1; i < argc; i++)
 1ac:	00858993          	addi	s3,a1,8
 1b0:	ec040493          	addi	s1,s0,-320
 1b4:	ffe50a1b          	addiw	s4,a0,-2
 1b8:	020a1793          	slli	a5,s4,0x20
 1bc:	01e7da13          	srli	s4,a5,0x1e
 1c0:	ec440793          	addi	a5,s0,-316
 1c4:	9a3e                	add	s4,s4,a5
    if(argc < 2) 
 1c6:	8926                	mv	s2,s1
    {
        nums[i-1] = atoi(argv[i]);
 1c8:	0009b503          	ld	a0,0(s3)
 1cc:	1e0000ef          	jal	3ac <atoi>
 1d0:	00a92023          	sw	a0,0(s2)
    for(int i = 1; i < argc; i++)
 1d4:	09a1                	addi	s3,s3,8
 1d6:	0911                	addi	s2,s2,4
 1d8:	ff4918e3          	bne	s2,s4,1c8 <main+0x36>
    }

    // apply merge sort
    mergeSort(nums, 0, n-1);
 1dc:	ffea861b          	addiw	a2,s5,-2
 1e0:	4581                	li	a1,0
 1e2:	ec040513          	addi	a0,s0,-320
 1e6:	f47ff0ef          	jal	12c <mergeSort>

    // printing the sorted results
    printf("Sorted: ");
 1ea:	00001517          	auipc	a0,0x1
 1ee:	90650513          	addi	a0,a0,-1786 # af0 <malloc+0x13e>
 1f2:	70c000ef          	jal	8fe <printf>
    for(int i = 0; i < n; i++)
    {
        printf("%d ", nums[i]);
 1f6:	00001917          	auipc	s2,0x1
 1fa:	90a90913          	addi	s2,s2,-1782 # b00 <malloc+0x14e>
 1fe:	408c                	lw	a1,0(s1)
 200:	854a                	mv	a0,s2
 202:	6fc000ef          	jal	8fe <printf>
    for(int i = 0; i < n; i++)
 206:	0491                	addi	s1,s1,4
 208:	ff449be3          	bne	s1,s4,1fe <main+0x6c>
    }
    printf("\n");
 20c:	00001517          	auipc	a0,0x1
 210:	8fc50513          	addi	a0,a0,-1796 # b08 <malloc+0x156>
 214:	6ea000ef          	jal	8fe <printf>
    exit(0);
 218:	4501                	li	a0,0
 21a:	2b4000ef          	jal	4ce <exit>
 21e:	f626                	sd	s1,296(sp)
 220:	f24a                	sd	s2,288(sp)
 222:	ee4e                	sd	s3,280(sp)
 224:	ea52                	sd	s4,272(sp)
 226:	e656                	sd	s5,264(sp)
        printf("Incorrect input. The proper syntax is: sort num1 num2 ...\n");
 228:	00001517          	auipc	a0,0x1
 22c:	88850513          	addi	a0,a0,-1912 # ab0 <malloc+0xfe>
 230:	6ce000ef          	jal	8fe <printf>
        exit(0);
 234:	4501                	li	a0,0
 236:	298000ef          	jal	4ce <exit>

000000000000023a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 23a:	1141                	addi	sp,sp,-16
 23c:	e406                	sd	ra,8(sp)
 23e:	e022                	sd	s0,0(sp)
 240:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 242:	f51ff0ef          	jal	192 <main>
  exit(r);
 246:	288000ef          	jal	4ce <exit>

000000000000024a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 24a:	1141                	addi	sp,sp,-16
 24c:	e422                	sd	s0,8(sp)
 24e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 250:	87aa                	mv	a5,a0
 252:	0585                	addi	a1,a1,1
 254:	0785                	addi	a5,a5,1
 256:	fff5c703          	lbu	a4,-1(a1)
 25a:	fee78fa3          	sb	a4,-1(a5)
 25e:	fb75                	bnez	a4,252 <strcpy+0x8>
    ;
  return os;
}
 260:	6422                	ld	s0,8(sp)
 262:	0141                	addi	sp,sp,16
 264:	8082                	ret

0000000000000266 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 266:	1141                	addi	sp,sp,-16
 268:	e422                	sd	s0,8(sp)
 26a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 26c:	00054783          	lbu	a5,0(a0)
 270:	cb91                	beqz	a5,284 <strcmp+0x1e>
 272:	0005c703          	lbu	a4,0(a1)
 276:	00f71763          	bne	a4,a5,284 <strcmp+0x1e>
    p++, q++;
 27a:	0505                	addi	a0,a0,1
 27c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 27e:	00054783          	lbu	a5,0(a0)
 282:	fbe5                	bnez	a5,272 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 284:	0005c503          	lbu	a0,0(a1)
}
 288:	40a7853b          	subw	a0,a5,a0
 28c:	6422                	ld	s0,8(sp)
 28e:	0141                	addi	sp,sp,16
 290:	8082                	ret

0000000000000292 <strlen>:

uint
strlen(const char *s)
{
 292:	1141                	addi	sp,sp,-16
 294:	e422                	sd	s0,8(sp)
 296:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 298:	00054783          	lbu	a5,0(a0)
 29c:	cf91                	beqz	a5,2b8 <strlen+0x26>
 29e:	0505                	addi	a0,a0,1
 2a0:	87aa                	mv	a5,a0
 2a2:	86be                	mv	a3,a5
 2a4:	0785                	addi	a5,a5,1
 2a6:	fff7c703          	lbu	a4,-1(a5)
 2aa:	ff65                	bnez	a4,2a2 <strlen+0x10>
 2ac:	40a6853b          	subw	a0,a3,a0
 2b0:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 2b2:	6422                	ld	s0,8(sp)
 2b4:	0141                	addi	sp,sp,16
 2b6:	8082                	ret
  for(n = 0; s[n]; n++)
 2b8:	4501                	li	a0,0
 2ba:	bfe5                	j	2b2 <strlen+0x20>

00000000000002bc <memset>:

void*
memset(void *dst, int c, uint n)
{
 2bc:	1141                	addi	sp,sp,-16
 2be:	e422                	sd	s0,8(sp)
 2c0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2c2:	ca19                	beqz	a2,2d8 <memset+0x1c>
 2c4:	87aa                	mv	a5,a0
 2c6:	1602                	slli	a2,a2,0x20
 2c8:	9201                	srli	a2,a2,0x20
 2ca:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2ce:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2d2:	0785                	addi	a5,a5,1
 2d4:	fee79de3          	bne	a5,a4,2ce <memset+0x12>
  }
  return dst;
}
 2d8:	6422                	ld	s0,8(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret

00000000000002de <strchr>:

char*
strchr(const char *s, char c)
{
 2de:	1141                	addi	sp,sp,-16
 2e0:	e422                	sd	s0,8(sp)
 2e2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2e4:	00054783          	lbu	a5,0(a0)
 2e8:	cb99                	beqz	a5,2fe <strchr+0x20>
    if(*s == c)
 2ea:	00f58763          	beq	a1,a5,2f8 <strchr+0x1a>
  for(; *s; s++)
 2ee:	0505                	addi	a0,a0,1
 2f0:	00054783          	lbu	a5,0(a0)
 2f4:	fbfd                	bnez	a5,2ea <strchr+0xc>
      return (char*)s;
  return 0;
 2f6:	4501                	li	a0,0
}
 2f8:	6422                	ld	s0,8(sp)
 2fa:	0141                	addi	sp,sp,16
 2fc:	8082                	ret
  return 0;
 2fe:	4501                	li	a0,0
 300:	bfe5                	j	2f8 <strchr+0x1a>

0000000000000302 <gets>:

char*
gets(char *buf, int max)
{
 302:	711d                	addi	sp,sp,-96
 304:	ec86                	sd	ra,88(sp)
 306:	e8a2                	sd	s0,80(sp)
 308:	e4a6                	sd	s1,72(sp)
 30a:	e0ca                	sd	s2,64(sp)
 30c:	fc4e                	sd	s3,56(sp)
 30e:	f852                	sd	s4,48(sp)
 310:	f456                	sd	s5,40(sp)
 312:	f05a                	sd	s6,32(sp)
 314:	ec5e                	sd	s7,24(sp)
 316:	1080                	addi	s0,sp,96
 318:	8baa                	mv	s7,a0
 31a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 31c:	892a                	mv	s2,a0
 31e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 320:	4aa9                	li	s5,10
 322:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 324:	89a6                	mv	s3,s1
 326:	2485                	addiw	s1,s1,1
 328:	0344d663          	bge	s1,s4,354 <gets+0x52>
    cc = read(0, &c, 1);
 32c:	4605                	li	a2,1
 32e:	faf40593          	addi	a1,s0,-81
 332:	4501                	li	a0,0
 334:	1b2000ef          	jal	4e6 <read>
    if(cc < 1)
 338:	00a05e63          	blez	a0,354 <gets+0x52>
    buf[i++] = c;
 33c:	faf44783          	lbu	a5,-81(s0)
 340:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 344:	01578763          	beq	a5,s5,352 <gets+0x50>
 348:	0905                	addi	s2,s2,1
 34a:	fd679de3          	bne	a5,s6,324 <gets+0x22>
    buf[i++] = c;
 34e:	89a6                	mv	s3,s1
 350:	a011                	j	354 <gets+0x52>
 352:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 354:	99de                	add	s3,s3,s7
 356:	00098023          	sb	zero,0(s3)
  return buf;
}
 35a:	855e                	mv	a0,s7
 35c:	60e6                	ld	ra,88(sp)
 35e:	6446                	ld	s0,80(sp)
 360:	64a6                	ld	s1,72(sp)
 362:	6906                	ld	s2,64(sp)
 364:	79e2                	ld	s3,56(sp)
 366:	7a42                	ld	s4,48(sp)
 368:	7aa2                	ld	s5,40(sp)
 36a:	7b02                	ld	s6,32(sp)
 36c:	6be2                	ld	s7,24(sp)
 36e:	6125                	addi	sp,sp,96
 370:	8082                	ret

0000000000000372 <stat>:

int
stat(const char *n, struct stat *st)
{
 372:	1101                	addi	sp,sp,-32
 374:	ec06                	sd	ra,24(sp)
 376:	e822                	sd	s0,16(sp)
 378:	e04a                	sd	s2,0(sp)
 37a:	1000                	addi	s0,sp,32
 37c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 37e:	4581                	li	a1,0
 380:	18e000ef          	jal	50e <open>
  if(fd < 0)
 384:	02054263          	bltz	a0,3a8 <stat+0x36>
 388:	e426                	sd	s1,8(sp)
 38a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 38c:	85ca                	mv	a1,s2
 38e:	198000ef          	jal	526 <fstat>
 392:	892a                	mv	s2,a0
  close(fd);
 394:	8526                	mv	a0,s1
 396:	160000ef          	jal	4f6 <close>
  return r;
 39a:	64a2                	ld	s1,8(sp)
}
 39c:	854a                	mv	a0,s2
 39e:	60e2                	ld	ra,24(sp)
 3a0:	6442                	ld	s0,16(sp)
 3a2:	6902                	ld	s2,0(sp)
 3a4:	6105                	addi	sp,sp,32
 3a6:	8082                	ret
    return -1;
 3a8:	597d                	li	s2,-1
 3aa:	bfcd                	j	39c <stat+0x2a>

00000000000003ac <atoi>:

int
atoi(const char *s)
{
 3ac:	1141                	addi	sp,sp,-16
 3ae:	e422                	sd	s0,8(sp)
 3b0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3b2:	00054683          	lbu	a3,0(a0)
 3b6:	fd06879b          	addiw	a5,a3,-48
 3ba:	0ff7f793          	zext.b	a5,a5
 3be:	4625                	li	a2,9
 3c0:	02f66863          	bltu	a2,a5,3f0 <atoi+0x44>
 3c4:	872a                	mv	a4,a0
  n = 0;
 3c6:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3c8:	0705                	addi	a4,a4,1
 3ca:	0025179b          	slliw	a5,a0,0x2
 3ce:	9fa9                	addw	a5,a5,a0
 3d0:	0017979b          	slliw	a5,a5,0x1
 3d4:	9fb5                	addw	a5,a5,a3
 3d6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3da:	00074683          	lbu	a3,0(a4)
 3de:	fd06879b          	addiw	a5,a3,-48
 3e2:	0ff7f793          	zext.b	a5,a5
 3e6:	fef671e3          	bgeu	a2,a5,3c8 <atoi+0x1c>
  return n;
}
 3ea:	6422                	ld	s0,8(sp)
 3ec:	0141                	addi	sp,sp,16
 3ee:	8082                	ret
  n = 0;
 3f0:	4501                	li	a0,0
 3f2:	bfe5                	j	3ea <atoi+0x3e>

00000000000003f4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3f4:	1141                	addi	sp,sp,-16
 3f6:	e422                	sd	s0,8(sp)
 3f8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3fa:	02b57463          	bgeu	a0,a1,422 <memmove+0x2e>
    while(n-- > 0)
 3fe:	00c05f63          	blez	a2,41c <memmove+0x28>
 402:	1602                	slli	a2,a2,0x20
 404:	9201                	srli	a2,a2,0x20
 406:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 40a:	872a                	mv	a4,a0
      *dst++ = *src++;
 40c:	0585                	addi	a1,a1,1
 40e:	0705                	addi	a4,a4,1
 410:	fff5c683          	lbu	a3,-1(a1)
 414:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 418:	fef71ae3          	bne	a4,a5,40c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 41c:	6422                	ld	s0,8(sp)
 41e:	0141                	addi	sp,sp,16
 420:	8082                	ret
    dst += n;
 422:	00c50733          	add	a4,a0,a2
    src += n;
 426:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 428:	fec05ae3          	blez	a2,41c <memmove+0x28>
 42c:	fff6079b          	addiw	a5,a2,-1
 430:	1782                	slli	a5,a5,0x20
 432:	9381                	srli	a5,a5,0x20
 434:	fff7c793          	not	a5,a5
 438:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 43a:	15fd                	addi	a1,a1,-1
 43c:	177d                	addi	a4,a4,-1
 43e:	0005c683          	lbu	a3,0(a1)
 442:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 446:	fee79ae3          	bne	a5,a4,43a <memmove+0x46>
 44a:	bfc9                	j	41c <memmove+0x28>

000000000000044c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 44c:	1141                	addi	sp,sp,-16
 44e:	e422                	sd	s0,8(sp)
 450:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 452:	ca05                	beqz	a2,482 <memcmp+0x36>
 454:	fff6069b          	addiw	a3,a2,-1
 458:	1682                	slli	a3,a3,0x20
 45a:	9281                	srli	a3,a3,0x20
 45c:	0685                	addi	a3,a3,1
 45e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 460:	00054783          	lbu	a5,0(a0)
 464:	0005c703          	lbu	a4,0(a1)
 468:	00e79863          	bne	a5,a4,478 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 46c:	0505                	addi	a0,a0,1
    p2++;
 46e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 470:	fed518e3          	bne	a0,a3,460 <memcmp+0x14>
  }
  return 0;
 474:	4501                	li	a0,0
 476:	a019                	j	47c <memcmp+0x30>
      return *p1 - *p2;
 478:	40e7853b          	subw	a0,a5,a4
}
 47c:	6422                	ld	s0,8(sp)
 47e:	0141                	addi	sp,sp,16
 480:	8082                	ret
  return 0;
 482:	4501                	li	a0,0
 484:	bfe5                	j	47c <memcmp+0x30>

0000000000000486 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 486:	1141                	addi	sp,sp,-16
 488:	e406                	sd	ra,8(sp)
 48a:	e022                	sd	s0,0(sp)
 48c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 48e:	f67ff0ef          	jal	3f4 <memmove>
}
 492:	60a2                	ld	ra,8(sp)
 494:	6402                	ld	s0,0(sp)
 496:	0141                	addi	sp,sp,16
 498:	8082                	ret

000000000000049a <sbrk>:

char *
sbrk(int n) {
 49a:	1141                	addi	sp,sp,-16
 49c:	e406                	sd	ra,8(sp)
 49e:	e022                	sd	s0,0(sp)
 4a0:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 4a2:	4585                	li	a1,1
 4a4:	0b2000ef          	jal	556 <sys_sbrk>
}
 4a8:	60a2                	ld	ra,8(sp)
 4aa:	6402                	ld	s0,0(sp)
 4ac:	0141                	addi	sp,sp,16
 4ae:	8082                	ret

00000000000004b0 <sbrklazy>:

char *
sbrklazy(int n) {
 4b0:	1141                	addi	sp,sp,-16
 4b2:	e406                	sd	ra,8(sp)
 4b4:	e022                	sd	s0,0(sp)
 4b6:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 4b8:	4589                	li	a1,2
 4ba:	09c000ef          	jal	556 <sys_sbrk>
}
 4be:	60a2                	ld	ra,8(sp)
 4c0:	6402                	ld	s0,0(sp)
 4c2:	0141                	addi	sp,sp,16
 4c4:	8082                	ret

00000000000004c6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4c6:	4885                	li	a7,1
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <exit>:
.global exit
exit:
 li a7, SYS_exit
 4ce:	4889                	li	a7,2
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4d6:	488d                	li	a7,3
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4de:	4891                	li	a7,4
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <read>:
.global read
read:
 li a7, SYS_read
 4e6:	4895                	li	a7,5
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <write>:
.global write
write:
 li a7, SYS_write
 4ee:	48c1                	li	a7,16
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <close>:
.global close
close:
 li a7, SYS_close
 4f6:	48d5                	li	a7,21
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <kill>:
.global kill
kill:
 li a7, SYS_kill
 4fe:	4899                	li	a7,6
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <exec>:
.global exec
exec:
 li a7, SYS_exec
 506:	489d                	li	a7,7
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <open>:
.global open
open:
 li a7, SYS_open
 50e:	48bd                	li	a7,15
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 516:	48c5                	li	a7,17
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 51e:	48c9                	li	a7,18
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 526:	48a1                	li	a7,8
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <link>:
.global link
link:
 li a7, SYS_link
 52e:	48cd                	li	a7,19
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 536:	48d1                	li	a7,20
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 53e:	48a5                	li	a7,9
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <dup>:
.global dup
dup:
 li a7, SYS_dup
 546:	48a9                	li	a7,10
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 54e:	48ad                	li	a7,11
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 556:	48b1                	li	a7,12
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <pause>:
.global pause
pause:
 li a7, SYS_pause
 55e:	48b5                	li	a7,13
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 566:	48b9                	li	a7,14
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 56e:	48d9                	li	a7,22
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 576:	1101                	addi	sp,sp,-32
 578:	ec06                	sd	ra,24(sp)
 57a:	e822                	sd	s0,16(sp)
 57c:	1000                	addi	s0,sp,32
 57e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 582:	4605                	li	a2,1
 584:	fef40593          	addi	a1,s0,-17
 588:	f67ff0ef          	jal	4ee <write>
}
 58c:	60e2                	ld	ra,24(sp)
 58e:	6442                	ld	s0,16(sp)
 590:	6105                	addi	sp,sp,32
 592:	8082                	ret

0000000000000594 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 594:	715d                	addi	sp,sp,-80
 596:	e486                	sd	ra,72(sp)
 598:	e0a2                	sd	s0,64(sp)
 59a:	f84a                	sd	s2,48(sp)
 59c:	0880                	addi	s0,sp,80
 59e:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 5a0:	c299                	beqz	a3,5a6 <printint+0x12>
 5a2:	0805c363          	bltz	a1,628 <printint+0x94>
  neg = 0;
 5a6:	4881                	li	a7,0
 5a8:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 5ac:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 5ae:	00000517          	auipc	a0,0x0
 5b2:	56a50513          	addi	a0,a0,1386 # b18 <digits>
 5b6:	883e                	mv	a6,a5
 5b8:	2785                	addiw	a5,a5,1
 5ba:	02c5f733          	remu	a4,a1,a2
 5be:	972a                	add	a4,a4,a0
 5c0:	00074703          	lbu	a4,0(a4)
 5c4:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 5c8:	872e                	mv	a4,a1
 5ca:	02c5d5b3          	divu	a1,a1,a2
 5ce:	0685                	addi	a3,a3,1
 5d0:	fec773e3          	bgeu	a4,a2,5b6 <printint+0x22>
  if(neg)
 5d4:	00088b63          	beqz	a7,5ea <printint+0x56>
    buf[i++] = '-';
 5d8:	fd078793          	addi	a5,a5,-48
 5dc:	97a2                	add	a5,a5,s0
 5de:	02d00713          	li	a4,45
 5e2:	fee78423          	sb	a4,-24(a5)
 5e6:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 5ea:	02f05a63          	blez	a5,61e <printint+0x8a>
 5ee:	fc26                	sd	s1,56(sp)
 5f0:	f44e                	sd	s3,40(sp)
 5f2:	fb840713          	addi	a4,s0,-72
 5f6:	00f704b3          	add	s1,a4,a5
 5fa:	fff70993          	addi	s3,a4,-1
 5fe:	99be                	add	s3,s3,a5
 600:	37fd                	addiw	a5,a5,-1
 602:	1782                	slli	a5,a5,0x20
 604:	9381                	srli	a5,a5,0x20
 606:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 60a:	fff4c583          	lbu	a1,-1(s1)
 60e:	854a                	mv	a0,s2
 610:	f67ff0ef          	jal	576 <putc>
  while(--i >= 0)
 614:	14fd                	addi	s1,s1,-1
 616:	ff349ae3          	bne	s1,s3,60a <printint+0x76>
 61a:	74e2                	ld	s1,56(sp)
 61c:	79a2                	ld	s3,40(sp)
}
 61e:	60a6                	ld	ra,72(sp)
 620:	6406                	ld	s0,64(sp)
 622:	7942                	ld	s2,48(sp)
 624:	6161                	addi	sp,sp,80
 626:	8082                	ret
    x = -xx;
 628:	40b005b3          	neg	a1,a1
    neg = 1;
 62c:	4885                	li	a7,1
    x = -xx;
 62e:	bfad                	j	5a8 <printint+0x14>

0000000000000630 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 630:	711d                	addi	sp,sp,-96
 632:	ec86                	sd	ra,88(sp)
 634:	e8a2                	sd	s0,80(sp)
 636:	e0ca                	sd	s2,64(sp)
 638:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 63a:	0005c903          	lbu	s2,0(a1)
 63e:	28090663          	beqz	s2,8ca <vprintf+0x29a>
 642:	e4a6                	sd	s1,72(sp)
 644:	fc4e                	sd	s3,56(sp)
 646:	f852                	sd	s4,48(sp)
 648:	f456                	sd	s5,40(sp)
 64a:	f05a                	sd	s6,32(sp)
 64c:	ec5e                	sd	s7,24(sp)
 64e:	e862                	sd	s8,16(sp)
 650:	e466                	sd	s9,8(sp)
 652:	8b2a                	mv	s6,a0
 654:	8a2e                	mv	s4,a1
 656:	8bb2                	mv	s7,a2
  state = 0;
 658:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 65a:	4481                	li	s1,0
 65c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 65e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 662:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 666:	06c00c93          	li	s9,108
 66a:	a005                	j	68a <vprintf+0x5a>
        putc(fd, c0);
 66c:	85ca                	mv	a1,s2
 66e:	855a                	mv	a0,s6
 670:	f07ff0ef          	jal	576 <putc>
 674:	a019                	j	67a <vprintf+0x4a>
    } else if(state == '%'){
 676:	03598263          	beq	s3,s5,69a <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 67a:	2485                	addiw	s1,s1,1
 67c:	8726                	mv	a4,s1
 67e:	009a07b3          	add	a5,s4,s1
 682:	0007c903          	lbu	s2,0(a5)
 686:	22090a63          	beqz	s2,8ba <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 68a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 68e:	fe0994e3          	bnez	s3,676 <vprintf+0x46>
      if(c0 == '%'){
 692:	fd579de3          	bne	a5,s5,66c <vprintf+0x3c>
        state = '%';
 696:	89be                	mv	s3,a5
 698:	b7cd                	j	67a <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 69a:	00ea06b3          	add	a3,s4,a4
 69e:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 6a2:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 6a4:	c681                	beqz	a3,6ac <vprintf+0x7c>
 6a6:	9752                	add	a4,a4,s4
 6a8:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 6ac:	05878363          	beq	a5,s8,6f2 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 6b0:	05978d63          	beq	a5,s9,70a <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 6b4:	07500713          	li	a4,117
 6b8:	0ee78763          	beq	a5,a4,7a6 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 6bc:	07800713          	li	a4,120
 6c0:	12e78963          	beq	a5,a4,7f2 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 6c4:	07000713          	li	a4,112
 6c8:	14e78e63          	beq	a5,a4,824 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 6cc:	06300713          	li	a4,99
 6d0:	18e78e63          	beq	a5,a4,86c <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 6d4:	07300713          	li	a4,115
 6d8:	1ae78463          	beq	a5,a4,880 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 6dc:	02500713          	li	a4,37
 6e0:	04e79563          	bne	a5,a4,72a <vprintf+0xfa>
        putc(fd, '%');
 6e4:	02500593          	li	a1,37
 6e8:	855a                	mv	a0,s6
 6ea:	e8dff0ef          	jal	576 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 6ee:	4981                	li	s3,0
 6f0:	b769                	j	67a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 6f2:	008b8913          	addi	s2,s7,8
 6f6:	4685                	li	a3,1
 6f8:	4629                	li	a2,10
 6fa:	000ba583          	lw	a1,0(s7)
 6fe:	855a                	mv	a0,s6
 700:	e95ff0ef          	jal	594 <printint>
 704:	8bca                	mv	s7,s2
      state = 0;
 706:	4981                	li	s3,0
 708:	bf8d                	j	67a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 70a:	06400793          	li	a5,100
 70e:	02f68963          	beq	a3,a5,740 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 712:	06c00793          	li	a5,108
 716:	04f68263          	beq	a3,a5,75a <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 71a:	07500793          	li	a5,117
 71e:	0af68063          	beq	a3,a5,7be <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 722:	07800793          	li	a5,120
 726:	0ef68263          	beq	a3,a5,80a <vprintf+0x1da>
        putc(fd, '%');
 72a:	02500593          	li	a1,37
 72e:	855a                	mv	a0,s6
 730:	e47ff0ef          	jal	576 <putc>
        putc(fd, c0);
 734:	85ca                	mv	a1,s2
 736:	855a                	mv	a0,s6
 738:	e3fff0ef          	jal	576 <putc>
      state = 0;
 73c:	4981                	li	s3,0
 73e:	bf35                	j	67a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 740:	008b8913          	addi	s2,s7,8
 744:	4685                	li	a3,1
 746:	4629                	li	a2,10
 748:	000bb583          	ld	a1,0(s7)
 74c:	855a                	mv	a0,s6
 74e:	e47ff0ef          	jal	594 <printint>
        i += 1;
 752:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 754:	8bca                	mv	s7,s2
      state = 0;
 756:	4981                	li	s3,0
        i += 1;
 758:	b70d                	j	67a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 75a:	06400793          	li	a5,100
 75e:	02f60763          	beq	a2,a5,78c <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 762:	07500793          	li	a5,117
 766:	06f60963          	beq	a2,a5,7d8 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 76a:	07800793          	li	a5,120
 76e:	faf61ee3          	bne	a2,a5,72a <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 772:	008b8913          	addi	s2,s7,8
 776:	4681                	li	a3,0
 778:	4641                	li	a2,16
 77a:	000bb583          	ld	a1,0(s7)
 77e:	855a                	mv	a0,s6
 780:	e15ff0ef          	jal	594 <printint>
        i += 2;
 784:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 786:	8bca                	mv	s7,s2
      state = 0;
 788:	4981                	li	s3,0
        i += 2;
 78a:	bdc5                	j	67a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 78c:	008b8913          	addi	s2,s7,8
 790:	4685                	li	a3,1
 792:	4629                	li	a2,10
 794:	000bb583          	ld	a1,0(s7)
 798:	855a                	mv	a0,s6
 79a:	dfbff0ef          	jal	594 <printint>
        i += 2;
 79e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 7a0:	8bca                	mv	s7,s2
      state = 0;
 7a2:	4981                	li	s3,0
        i += 2;
 7a4:	bdd9                	j	67a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 7a6:	008b8913          	addi	s2,s7,8
 7aa:	4681                	li	a3,0
 7ac:	4629                	li	a2,10
 7ae:	000be583          	lwu	a1,0(s7)
 7b2:	855a                	mv	a0,s6
 7b4:	de1ff0ef          	jal	594 <printint>
 7b8:	8bca                	mv	s7,s2
      state = 0;
 7ba:	4981                	li	s3,0
 7bc:	bd7d                	j	67a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7be:	008b8913          	addi	s2,s7,8
 7c2:	4681                	li	a3,0
 7c4:	4629                	li	a2,10
 7c6:	000bb583          	ld	a1,0(s7)
 7ca:	855a                	mv	a0,s6
 7cc:	dc9ff0ef          	jal	594 <printint>
        i += 1;
 7d0:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 7d2:	8bca                	mv	s7,s2
      state = 0;
 7d4:	4981                	li	s3,0
        i += 1;
 7d6:	b555                	j	67a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7d8:	008b8913          	addi	s2,s7,8
 7dc:	4681                	li	a3,0
 7de:	4629                	li	a2,10
 7e0:	000bb583          	ld	a1,0(s7)
 7e4:	855a                	mv	a0,s6
 7e6:	dafff0ef          	jal	594 <printint>
        i += 2;
 7ea:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 7ec:	8bca                	mv	s7,s2
      state = 0;
 7ee:	4981                	li	s3,0
        i += 2;
 7f0:	b569                	j	67a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 7f2:	008b8913          	addi	s2,s7,8
 7f6:	4681                	li	a3,0
 7f8:	4641                	li	a2,16
 7fa:	000be583          	lwu	a1,0(s7)
 7fe:	855a                	mv	a0,s6
 800:	d95ff0ef          	jal	594 <printint>
 804:	8bca                	mv	s7,s2
      state = 0;
 806:	4981                	li	s3,0
 808:	bd8d                	j	67a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 80a:	008b8913          	addi	s2,s7,8
 80e:	4681                	li	a3,0
 810:	4641                	li	a2,16
 812:	000bb583          	ld	a1,0(s7)
 816:	855a                	mv	a0,s6
 818:	d7dff0ef          	jal	594 <printint>
        i += 1;
 81c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 81e:	8bca                	mv	s7,s2
      state = 0;
 820:	4981                	li	s3,0
        i += 1;
 822:	bda1                	j	67a <vprintf+0x4a>
 824:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 826:	008b8d13          	addi	s10,s7,8
 82a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 82e:	03000593          	li	a1,48
 832:	855a                	mv	a0,s6
 834:	d43ff0ef          	jal	576 <putc>
  putc(fd, 'x');
 838:	07800593          	li	a1,120
 83c:	855a                	mv	a0,s6
 83e:	d39ff0ef          	jal	576 <putc>
 842:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 844:	00000b97          	auipc	s7,0x0
 848:	2d4b8b93          	addi	s7,s7,724 # b18 <digits>
 84c:	03c9d793          	srli	a5,s3,0x3c
 850:	97de                	add	a5,a5,s7
 852:	0007c583          	lbu	a1,0(a5)
 856:	855a                	mv	a0,s6
 858:	d1fff0ef          	jal	576 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 85c:	0992                	slli	s3,s3,0x4
 85e:	397d                	addiw	s2,s2,-1
 860:	fe0916e3          	bnez	s2,84c <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 864:	8bea                	mv	s7,s10
      state = 0;
 866:	4981                	li	s3,0
 868:	6d02                	ld	s10,0(sp)
 86a:	bd01                	j	67a <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 86c:	008b8913          	addi	s2,s7,8
 870:	000bc583          	lbu	a1,0(s7)
 874:	855a                	mv	a0,s6
 876:	d01ff0ef          	jal	576 <putc>
 87a:	8bca                	mv	s7,s2
      state = 0;
 87c:	4981                	li	s3,0
 87e:	bbf5                	j	67a <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 880:	008b8993          	addi	s3,s7,8
 884:	000bb903          	ld	s2,0(s7)
 888:	00090f63          	beqz	s2,8a6 <vprintf+0x276>
        for(; *s; s++)
 88c:	00094583          	lbu	a1,0(s2)
 890:	c195                	beqz	a1,8b4 <vprintf+0x284>
          putc(fd, *s);
 892:	855a                	mv	a0,s6
 894:	ce3ff0ef          	jal	576 <putc>
        for(; *s; s++)
 898:	0905                	addi	s2,s2,1
 89a:	00094583          	lbu	a1,0(s2)
 89e:	f9f5                	bnez	a1,892 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 8a0:	8bce                	mv	s7,s3
      state = 0;
 8a2:	4981                	li	s3,0
 8a4:	bbd9                	j	67a <vprintf+0x4a>
          s = "(null)";
 8a6:	00000917          	auipc	s2,0x0
 8aa:	26a90913          	addi	s2,s2,618 # b10 <malloc+0x15e>
        for(; *s; s++)
 8ae:	02800593          	li	a1,40
 8b2:	b7c5                	j	892 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 8b4:	8bce                	mv	s7,s3
      state = 0;
 8b6:	4981                	li	s3,0
 8b8:	b3c9                	j	67a <vprintf+0x4a>
 8ba:	64a6                	ld	s1,72(sp)
 8bc:	79e2                	ld	s3,56(sp)
 8be:	7a42                	ld	s4,48(sp)
 8c0:	7aa2                	ld	s5,40(sp)
 8c2:	7b02                	ld	s6,32(sp)
 8c4:	6be2                	ld	s7,24(sp)
 8c6:	6c42                	ld	s8,16(sp)
 8c8:	6ca2                	ld	s9,8(sp)
    }
  }
}
 8ca:	60e6                	ld	ra,88(sp)
 8cc:	6446                	ld	s0,80(sp)
 8ce:	6906                	ld	s2,64(sp)
 8d0:	6125                	addi	sp,sp,96
 8d2:	8082                	ret

00000000000008d4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8d4:	715d                	addi	sp,sp,-80
 8d6:	ec06                	sd	ra,24(sp)
 8d8:	e822                	sd	s0,16(sp)
 8da:	1000                	addi	s0,sp,32
 8dc:	e010                	sd	a2,0(s0)
 8de:	e414                	sd	a3,8(s0)
 8e0:	e818                	sd	a4,16(s0)
 8e2:	ec1c                	sd	a5,24(s0)
 8e4:	03043023          	sd	a6,32(s0)
 8e8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8ec:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8f0:	8622                	mv	a2,s0
 8f2:	d3fff0ef          	jal	630 <vprintf>
}
 8f6:	60e2                	ld	ra,24(sp)
 8f8:	6442                	ld	s0,16(sp)
 8fa:	6161                	addi	sp,sp,80
 8fc:	8082                	ret

00000000000008fe <printf>:

void
printf(const char *fmt, ...)
{
 8fe:	711d                	addi	sp,sp,-96
 900:	ec06                	sd	ra,24(sp)
 902:	e822                	sd	s0,16(sp)
 904:	1000                	addi	s0,sp,32
 906:	e40c                	sd	a1,8(s0)
 908:	e810                	sd	a2,16(s0)
 90a:	ec14                	sd	a3,24(s0)
 90c:	f018                	sd	a4,32(s0)
 90e:	f41c                	sd	a5,40(s0)
 910:	03043823          	sd	a6,48(s0)
 914:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 918:	00840613          	addi	a2,s0,8
 91c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 920:	85aa                	mv	a1,a0
 922:	4505                	li	a0,1
 924:	d0dff0ef          	jal	630 <vprintf>
}
 928:	60e2                	ld	ra,24(sp)
 92a:	6442                	ld	s0,16(sp)
 92c:	6125                	addi	sp,sp,96
 92e:	8082                	ret

0000000000000930 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 930:	1141                	addi	sp,sp,-16
 932:	e422                	sd	s0,8(sp)
 934:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 936:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 93a:	00000797          	auipc	a5,0x0
 93e:	6c67b783          	ld	a5,1734(a5) # 1000 <freep>
 942:	a02d                	j	96c <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 944:	4618                	lw	a4,8(a2)
 946:	9f2d                	addw	a4,a4,a1
 948:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 94c:	6398                	ld	a4,0(a5)
 94e:	6310                	ld	a2,0(a4)
 950:	a83d                	j	98e <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 952:	ff852703          	lw	a4,-8(a0)
 956:	9f31                	addw	a4,a4,a2
 958:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 95a:	ff053683          	ld	a3,-16(a0)
 95e:	a091                	j	9a2 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 960:	6398                	ld	a4,0(a5)
 962:	00e7e463          	bltu	a5,a4,96a <free+0x3a>
 966:	00e6ea63          	bltu	a3,a4,97a <free+0x4a>
{
 96a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 96c:	fed7fae3          	bgeu	a5,a3,960 <free+0x30>
 970:	6398                	ld	a4,0(a5)
 972:	00e6e463          	bltu	a3,a4,97a <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 976:	fee7eae3          	bltu	a5,a4,96a <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 97a:	ff852583          	lw	a1,-8(a0)
 97e:	6390                	ld	a2,0(a5)
 980:	02059813          	slli	a6,a1,0x20
 984:	01c85713          	srli	a4,a6,0x1c
 988:	9736                	add	a4,a4,a3
 98a:	fae60de3          	beq	a2,a4,944 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 98e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 992:	4790                	lw	a2,8(a5)
 994:	02061593          	slli	a1,a2,0x20
 998:	01c5d713          	srli	a4,a1,0x1c
 99c:	973e                	add	a4,a4,a5
 99e:	fae68ae3          	beq	a3,a4,952 <free+0x22>
    p->s.ptr = bp->s.ptr;
 9a2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9a4:	00000717          	auipc	a4,0x0
 9a8:	64f73e23          	sd	a5,1628(a4) # 1000 <freep>
}
 9ac:	6422                	ld	s0,8(sp)
 9ae:	0141                	addi	sp,sp,16
 9b0:	8082                	ret

00000000000009b2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9b2:	7139                	addi	sp,sp,-64
 9b4:	fc06                	sd	ra,56(sp)
 9b6:	f822                	sd	s0,48(sp)
 9b8:	f426                	sd	s1,40(sp)
 9ba:	ec4e                	sd	s3,24(sp)
 9bc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9be:	02051493          	slli	s1,a0,0x20
 9c2:	9081                	srli	s1,s1,0x20
 9c4:	04bd                	addi	s1,s1,15
 9c6:	8091                	srli	s1,s1,0x4
 9c8:	0014899b          	addiw	s3,s1,1
 9cc:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9ce:	00000517          	auipc	a0,0x0
 9d2:	63253503          	ld	a0,1586(a0) # 1000 <freep>
 9d6:	c915                	beqz	a0,a0a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9da:	4798                	lw	a4,8(a5)
 9dc:	08977a63          	bgeu	a4,s1,a70 <malloc+0xbe>
 9e0:	f04a                	sd	s2,32(sp)
 9e2:	e852                	sd	s4,16(sp)
 9e4:	e456                	sd	s5,8(sp)
 9e6:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9e8:	8a4e                	mv	s4,s3
 9ea:	0009871b          	sext.w	a4,s3
 9ee:	6685                	lui	a3,0x1
 9f0:	00d77363          	bgeu	a4,a3,9f6 <malloc+0x44>
 9f4:	6a05                	lui	s4,0x1
 9f6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9fa:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9fe:	00000917          	auipc	s2,0x0
 a02:	60290913          	addi	s2,s2,1538 # 1000 <freep>
  if(p == SBRK_ERROR)
 a06:	5afd                	li	s5,-1
 a08:	a081                	j	a48 <malloc+0x96>
 a0a:	f04a                	sd	s2,32(sp)
 a0c:	e852                	sd	s4,16(sp)
 a0e:	e456                	sd	s5,8(sp)
 a10:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a12:	00000797          	auipc	a5,0x0
 a16:	5fe78793          	addi	a5,a5,1534 # 1010 <base>
 a1a:	00000717          	auipc	a4,0x0
 a1e:	5ef73323          	sd	a5,1510(a4) # 1000 <freep>
 a22:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a24:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a28:	b7c1                	j	9e8 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 a2a:	6398                	ld	a4,0(a5)
 a2c:	e118                	sd	a4,0(a0)
 a2e:	a8a9                	j	a88 <malloc+0xd6>
  hp->s.size = nu;
 a30:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a34:	0541                	addi	a0,a0,16
 a36:	efbff0ef          	jal	930 <free>
  return freep;
 a3a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a3e:	c12d                	beqz	a0,aa0 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a40:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a42:	4798                	lw	a4,8(a5)
 a44:	02977263          	bgeu	a4,s1,a68 <malloc+0xb6>
    if(p == freep)
 a48:	00093703          	ld	a4,0(s2)
 a4c:	853e                	mv	a0,a5
 a4e:	fef719e3          	bne	a4,a5,a40 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 a52:	8552                	mv	a0,s4
 a54:	a47ff0ef          	jal	49a <sbrk>
  if(p == SBRK_ERROR)
 a58:	fd551ce3          	bne	a0,s5,a30 <malloc+0x7e>
        return 0;
 a5c:	4501                	li	a0,0
 a5e:	7902                	ld	s2,32(sp)
 a60:	6a42                	ld	s4,16(sp)
 a62:	6aa2                	ld	s5,8(sp)
 a64:	6b02                	ld	s6,0(sp)
 a66:	a03d                	j	a94 <malloc+0xe2>
 a68:	7902                	ld	s2,32(sp)
 a6a:	6a42                	ld	s4,16(sp)
 a6c:	6aa2                	ld	s5,8(sp)
 a6e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a70:	fae48de3          	beq	s1,a4,a2a <malloc+0x78>
        p->s.size -= nunits;
 a74:	4137073b          	subw	a4,a4,s3
 a78:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a7a:	02071693          	slli	a3,a4,0x20
 a7e:	01c6d713          	srli	a4,a3,0x1c
 a82:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a84:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a88:	00000717          	auipc	a4,0x0
 a8c:	56a73c23          	sd	a0,1400(a4) # 1000 <freep>
      return (void*)(p + 1);
 a90:	01078513          	addi	a0,a5,16
  }
}
 a94:	70e2                	ld	ra,56(sp)
 a96:	7442                	ld	s0,48(sp)
 a98:	74a2                	ld	s1,40(sp)
 a9a:	69e2                	ld	s3,24(sp)
 a9c:	6121                	addi	sp,sp,64
 a9e:	8082                	ret
 aa0:	7902                	ld	s2,32(sp)
 aa2:	6a42                	ld	s4,16(sp)
 aa4:	6aa2                	ld	s5,8(sp)
 aa6:	6b02                	ld	s6,0(sp)
 aa8:	b7f5                	j	a94 <malloc+0xe2>
