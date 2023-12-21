
obj/p-alloctests.full:     file format elf64-x86-64


Disassembly of section .text:

00000000002c0000 <process_main>:
#include "time.h"
#include "malloc.h"

extern uint8_t end[];

void process_main(void) {
  2c0000:	55                   	push   %rbp
  2c0001:	48 89 e5             	mov    %rsp,%rbp
  2c0004:	41 56                	push   %r14
  2c0006:	41 55                	push   %r13
  2c0008:	41 54                	push   %r12
  2c000a:	53                   	push   %rbx
  2c000b:	48 83 ec 20          	sub    $0x20,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  2c000f:	cd 31                	int    $0x31
  2c0011:	41 89 c4             	mov    %eax,%r12d
    
    pid_t p = getpid();
    srand(p);
  2c0014:	89 c7                	mov    %eax,%edi
  2c0016:	e8 02 10 00 00       	call   2c101d <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001b:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0020:	e8 07 05 00 00       	call   2c052c <malloc>
  2c0025:	48 89 c7             	mov    %rax,%rdi
  2c0028:	ba 00 00 00 00       	mov    $0x0,%edx
    
    // set array elements
    for(int  i = 0 ; i < 10; i++){
	array[i] = i;
  2c002d:	89 14 97             	mov    %edx,(%rdi,%rdx,4)
    for(int  i = 0 ; i < 10; i++){
  2c0030:	48 83 c2 01          	add    $0x1,%rdx
  2c0034:	48 83 fa 0a          	cmp    $0xa,%rdx
  2c0038:	75 f3                	jne    2c002d <process_main+0x2d>
    }

    // realloc array to size 20
    array = (int*)realloc(array, sizeof(int) * 20);
  2c003a:	be 50 00 00 00       	mov    $0x50,%esi
  2c003f:	e8 d4 05 00 00       	call   2c0618 <realloc>
  2c0044:	49 89 c5             	mov    %rax,%r13
  2c0047:	b8 00 00 00 00       	mov    $0x0,%eax

    // check if contents are same
    for(int i = 0 ; i < 10 ; i++){
	assert(array[i] == i);
  2c004c:	41 39 44 85 00       	cmp    %eax,0x0(%r13,%rax,4)
  2c0051:	75 64                	jne    2c00b7 <process_main+0xb7>
    for(int i = 0 ; i < 10 ; i++){
  2c0053:	48 83 c0 01          	add    $0x1,%rax
  2c0057:	48 83 f8 0a          	cmp    $0xa,%rax
  2c005b:	75 ef                	jne    2c004c <process_main+0x4c>
    }

    // alloc int array of size 30 using calloc
    int * array2 = (int *)calloc(30, sizeof(int));
  2c005d:	be 04 00 00 00       	mov    $0x4,%esi
  2c0062:	bf 1e 00 00 00       	mov    $0x1e,%edi
  2c0067:	e8 3b 05 00 00       	call   2c05a7 <calloc>
  2c006c:	49 89 c6             	mov    %rax,%r14

    // assert array[i] == 0
    for(int i = 0 ; i < 30; i++){
  2c006f:	48 8d 50 78          	lea    0x78(%rax),%rdx
	assert(array2[i] == 0);
  2c0073:	8b 18                	mov    (%rax),%ebx
  2c0075:	85 db                	test   %ebx,%ebx
  2c0077:	75 52                	jne    2c00cb <process_main+0xcb>
    for(int i = 0 ; i < 30; i++){
  2c0079:	48 83 c0 04          	add    $0x4,%rax
  2c007d:	48 39 d0             	cmp    %rdx,%rax
  2c0080:	75 f1                	jne    2c0073 <process_main+0x73>
    }
    
    heap_info_struct info;
    if(heap_info(&info) == 0){
  2c0082:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
  2c0086:	e8 59 0b 00 00       	call   2c0be4 <heap_info>
  2c008b:	85 c0                	test   %eax,%eax
  2c008d:	75 64                	jne    2c00f3 <process_main+0xf3>
	// check if allocations are in sorted order
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c008f:	8b 55 c0             	mov    -0x40(%rbp),%edx
  2c0092:	83 fa 01             	cmp    $0x1,%edx
  2c0095:	7e 70                	jle    2c0107 <process_main+0x107>
  2c0097:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c009b:	8d 52 fe             	lea    -0x2(%rdx),%edx
  2c009e:	48 8d 54 d0 08       	lea    0x8(%rax,%rdx,8),%rdx
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00a3:	48 8b 30             	mov    (%rax),%rsi
  2c00a6:	48 39 70 08          	cmp    %rsi,0x8(%rax)
  2c00aa:	7d 33                	jge    2c00df <process_main+0xdf>
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c00ac:	48 83 c0 08          	add    $0x8,%rax
  2c00b0:	48 39 d0             	cmp    %rdx,%rax
  2c00b3:	75 ee                	jne    2c00a3 <process_main+0xa3>
  2c00b5:	eb 50                	jmp    2c0107 <process_main+0x107>
	assert(array[i] == i);
  2c00b7:	ba 80 1d 2c 00       	mov    $0x2c1d80,%edx
  2c00bc:	be 19 00 00 00       	mov    $0x19,%esi
  2c00c1:	bf 8e 1d 2c 00       	mov    $0x2c1d8e,%edi
  2c00c6:	e8 13 02 00 00       	call   2c02de <assert_fail>
	assert(array2[i] == 0);
  2c00cb:	ba a4 1d 2c 00       	mov    $0x2c1da4,%edx
  2c00d0:	be 21 00 00 00       	mov    $0x21,%esi
  2c00d5:	bf 8e 1d 2c 00       	mov    $0x2c1d8e,%edi
  2c00da:	e8 ff 01 00 00       	call   2c02de <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00df:	ba c8 1d 2c 00       	mov    $0x2c1dc8,%edx
  2c00e4:	be 28 00 00 00       	mov    $0x28,%esi
  2c00e9:	bf 8e 1d 2c 00       	mov    $0x2c1d8e,%edi
  2c00ee:	e8 eb 01 00 00       	call   2c02de <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c00f3:	be b3 1d 2c 00       	mov    $0x2c1db3,%esi
  2c00f8:	bf 00 00 00 00       	mov    $0x0,%edi
  2c00fd:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0102:	e8 79 00 00 00       	call   2c0180 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0107:	4c 89 ef             	mov    %r13,%rdi
  2c010a:	e8 eb 03 00 00       	call   2c04fa <free>
    free(array2);
  2c010f:	4c 89 f7             	mov    %r14,%rdi
  2c0112:	e8 e3 03 00 00       	call   2c04fa <free>

    uint64_t total_time = 0;
  2c0117:	41 bd 00 00 00 00    	mov    $0x0,%r13d
/* rdtscp */
static uint64_t rdtsc(void) {
	uint64_t var;
	uint32_t hi, lo;

	__asm volatile
  2c011d:	0f 31                	rdtsc  
	    ("rdtsc" : "=a" (lo), "=d" (hi));

	var = ((uint64_t)hi << 32) | lo;
  2c011f:	48 c1 e2 20          	shl    $0x20,%rdx
  2c0123:	89 c0                	mov    %eax,%eax
  2c0125:	48 09 c2             	or     %rax,%rdx
  2c0128:	49 89 d6             	mov    %rdx,%r14
    int total_pages = 0;
    
    // allocate pages till no more memory
    while (1) {
	uint64_t time = rdtsc();
	void * ptr = malloc(PAGESIZE);
  2c012b:	bf 00 10 00 00       	mov    $0x1000,%edi
  2c0130:	e8 f7 03 00 00       	call   2c052c <malloc>
  2c0135:	48 89 c1             	mov    %rax,%rcx
	__asm volatile
  2c0138:	0f 31                	rdtsc  
	var = ((uint64_t)hi << 32) | lo;
  2c013a:	48 c1 e2 20          	shl    $0x20,%rdx
  2c013e:	89 c0                	mov    %eax,%eax
  2c0140:	48 09 c2             	or     %rax,%rdx
	total_time += (rdtsc() - time);
  2c0143:	4c 29 f2             	sub    %r14,%rdx
  2c0146:	49 01 d5             	add    %rdx,%r13
	if(ptr == NULL)
  2c0149:	48 85 c9             	test   %rcx,%rcx
  2c014c:	74 08                	je     2c0156 <process_main+0x156>
	    break;
	total_pages++;
  2c014e:	83 c3 01             	add    $0x1,%ebx
	*((int *)ptr) = p; // check write access
  2c0151:	44 89 21             	mov    %r12d,(%rcx)
    while (1) {
  2c0154:	eb c7                	jmp    2c011d <process_main+0x11d>
    }

    app_printf(p, "Total_time taken to alloc: %d Average time: %d\n", total_time, total_time/total_pages);
  2c0156:	48 63 db             	movslq %ebx,%rbx
  2c0159:	4c 89 e8             	mov    %r13,%rax
  2c015c:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0161:	48 f7 f3             	div    %rbx
  2c0164:	48 89 c1             	mov    %rax,%rcx
  2c0167:	4c 89 ea             	mov    %r13,%rdx
  2c016a:	be f8 1d 2c 00       	mov    $0x2c1df8,%esi
  2c016f:	44 89 e7             	mov    %r12d,%edi
  2c0172:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0177:	e8 04 00 00 00       	call   2c0180 <app_printf>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  2c017c:	cd 32                	int    $0x32
  2c017e:	eb fc                	jmp    2c017c <process_main+0x17c>

00000000002c0180 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  2c0180:	55                   	push   %rbp
  2c0181:	48 89 e5             	mov    %rsp,%rbp
  2c0184:	48 83 ec 50          	sub    $0x50,%rsp
  2c0188:	49 89 f2             	mov    %rsi,%r10
  2c018b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c018f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c0193:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c0197:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  2c019b:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  2c01a0:	85 ff                	test   %edi,%edi
  2c01a2:	78 2e                	js     2c01d2 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  2c01a4:	48 63 ff             	movslq %edi,%rdi
  2c01a7:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  2c01ae:	cc cc cc 
  2c01b1:	48 89 f8             	mov    %rdi,%rax
  2c01b4:	48 f7 e2             	mul    %rdx
  2c01b7:	48 89 d0             	mov    %rdx,%rax
  2c01ba:	48 c1 e8 02          	shr    $0x2,%rax
  2c01be:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  2c01c2:	48 01 c2             	add    %rax,%rdx
  2c01c5:	48 29 d7             	sub    %rdx,%rdi
  2c01c8:	0f b6 b7 5d 1e 2c 00 	movzbl 0x2c1e5d(%rdi),%esi
  2c01cf:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  2c01d2:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  2c01d9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c01dd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c01e1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c01e5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  2c01e9:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c01ed:	4c 89 d2             	mov    %r10,%rdx
  2c01f0:	8b 3d 06 8e df ff    	mov    -0x2071fa(%rip),%edi        # b8ffc <cursorpos>
  2c01f6:	e8 74 19 00 00       	call   2c1b6f <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  2c01fb:	3d 30 07 00 00       	cmp    $0x730,%eax
  2c0200:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0205:	0f 4d c2             	cmovge %edx,%eax
  2c0208:	89 05 ee 8d df ff    	mov    %eax,-0x207212(%rip)        # b8ffc <cursorpos>
    }
}
  2c020e:	c9                   	leave  
  2c020f:	c3                   	ret    

00000000002c0210 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  2c0210:	55                   	push   %rbp
  2c0211:	48 89 e5             	mov    %rsp,%rbp
  2c0214:	53                   	push   %rbx
  2c0215:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  2c021c:	48 89 fb             	mov    %rdi,%rbx
  2c021f:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  2c0223:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  2c0227:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  2c022b:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  2c022f:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  2c0233:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  2c023a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c023e:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  2c0242:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  2c0246:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  2c024a:	ba 07 00 00 00       	mov    $0x7,%edx
  2c024f:	be 28 1e 2c 00       	mov    $0x2c1e28,%esi
  2c0254:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c025b:	e8 c6 0a 00 00       	call   2c0d26 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0260:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0264:	48 89 da             	mov    %rbx,%rdx
  2c0267:	be 99 00 00 00       	mov    $0x99,%esi
  2c026c:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c0273:	e8 03 1a 00 00       	call   2c1c7b <vsnprintf>
  2c0278:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  2c027b:	85 d2                	test   %edx,%edx
  2c027d:	7e 0f                	jle    2c028e <kernel_panic+0x7e>
  2c027f:	83 c0 06             	add    $0x6,%eax
  2c0282:	48 98                	cltq   
  2c0284:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  2c028b:	0a 
  2c028c:	75 2a                	jne    2c02b8 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  2c028e:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  2c0295:	48 89 d9             	mov    %rbx,%rcx
  2c0298:	ba 30 1e 2c 00       	mov    $0x2c1e30,%edx
  2c029d:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02a2:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02a7:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ac:	e8 2a 19 00 00       	call   2c1bdb <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  2c02b1:	48 89 df             	mov    %rbx,%rdi
  2c02b4:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  2c02b6:	eb fe                	jmp    2c02b6 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  2c02b8:	48 63 c2             	movslq %edx,%rax
  2c02bb:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  2c02c1:	0f 94 c2             	sete   %dl
  2c02c4:	0f b6 d2             	movzbl %dl,%edx
  2c02c7:	48 29 d0             	sub    %rdx,%rax
  2c02ca:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  2c02d1:	ff 
  2c02d2:	be c3 1d 2c 00       	mov    $0x2c1dc3,%esi
  2c02d7:	e8 f7 0b 00 00       	call   2c0ed3 <strcpy>
  2c02dc:	eb b0                	jmp    2c028e <kernel_panic+0x7e>

00000000002c02de <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  2c02de:	55                   	push   %rbp
  2c02df:	48 89 e5             	mov    %rsp,%rbp
  2c02e2:	48 89 f9             	mov    %rdi,%rcx
  2c02e5:	41 89 f0             	mov    %esi,%r8d
  2c02e8:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  2c02eb:	ba 38 1e 2c 00       	mov    $0x2c1e38,%edx
  2c02f0:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02f5:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02fa:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ff:	e8 d7 18 00 00       	call   2c1bdb <console_printf>
    asm volatile ("int %0" : /* no result */
  2c0304:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0309:	cd 30                	int    $0x30
 loop: goto loop;
  2c030b:	eb fe                	jmp    2c030b <assert_fail+0x2d>

00000000002c030d <cmp_blocks_ascending>:
    remove_free_node(node_b);
}

// Comparison function for freeblocks in ascending order of address
int cmp_blocks_ascending(const void *a, const void *b){
    return (uintptr_t) (((freeblock *) a)->addr) - ((uintptr_t) ((freeblock *) b)->addr);
  2c030d:	48 8b 07             	mov    (%rdi),%rax
  2c0310:	2b 06                	sub    (%rsi),%eax
}
  2c0312:	c3                   	ret    

00000000002c0313 <cmp_size_array_descending>:
    }
}

// Qsort comparison functions for heap_info
int cmp_size_array_descending(const void *a, const void *b) {
    return *((long *) b) - *((long *) a);
  2c0313:	48 8b 06             	mov    (%rsi),%rax
  2c0316:	2b 07                	sub    (%rdi),%eax
}
  2c0318:	c3                   	ret    

00000000002c0319 <cmp_ptr_array_descending>:

int cmp_ptr_array_descending(const void *a, const void *b) {
    header* header_a = (header*) ((uintptr_t) *((void **) a) - HEADER_SIZE);
    header* header_b = (header*) ((uintptr_t) *((void **) b) - HEADER_SIZE);
    return header_b->size - header_a->size;
  2c0319:	48 8b 06             	mov    (%rsi),%rax
  2c031c:	48 8b 40 f8          	mov    -0x8(%rax),%rax
  2c0320:	48 8b 17             	mov    (%rdi),%rdx
  2c0323:	2b 42 f8             	sub    -0x8(%rdx),%eax
}
  2c0326:	c3                   	ret    

00000000002c0327 <append_free_node>:
    block->next = NULL;
  2c0327:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c032e:	00 
    block->prev = NULL;
  2c032f:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    if (free_head == NULL && free_tail == NULL) {
  2c0336:	48 83 3d ea 2c 00 00 	cmpq   $0x0,0x2cea(%rip)        # 2c3028 <free_head>
  2c033d:	00 
  2c033e:	74 1d                	je     2c035d <append_free_node+0x36>
        free_tail->next = block;
  2c0340:	48 8b 05 d9 2c 00 00 	mov    0x2cd9(%rip),%rax        # 2c3020 <free_tail>
  2c0347:	48 89 78 08          	mov    %rdi,0x8(%rax)
        block->prev = free_tail;
  2c034b:	48 89 07             	mov    %rax,(%rdi)
        free_tail = block;
  2c034e:	48 89 3d cb 2c 00 00 	mov    %rdi,0x2ccb(%rip)        # 2c3020 <free_tail>
    free_len++;
  2c0355:	83 05 bc 2c 00 00 01 	addl   $0x1,0x2cbc(%rip)        # 2c3018 <free_len>
}
  2c035c:	c3                   	ret    
    if (free_head == NULL && free_tail == NULL) {
  2c035d:	48 83 3d bb 2c 00 00 	cmpq   $0x0,0x2cbb(%rip)        # 2c3020 <free_tail>
  2c0364:	00 
  2c0365:	75 d9                	jne    2c0340 <append_free_node+0x19>
        free_head = block;
  2c0367:	48 89 3d ba 2c 00 00 	mov    %rdi,0x2cba(%rip)        # 2c3028 <free_head>
        free_tail = block;
  2c036e:	eb de                	jmp    2c034e <append_free_node+0x27>

00000000002c0370 <remove_free_node>:
    if (block == free_head) {
  2c0370:	48 39 3d b1 2c 00 00 	cmp    %rdi,0x2cb1(%rip)        # 2c3028 <free_head>
  2c0377:	74 30                	je     2c03a9 <remove_free_node+0x39>
    if (block == free_tail) {
  2c0379:	48 39 3d a0 2c 00 00 	cmp    %rdi,0x2ca0(%rip)        # 2c3020 <free_tail>
  2c0380:	74 34                	je     2c03b6 <remove_free_node+0x46>
    if (block->next != NULL) {
  2c0382:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c0386:	48 85 c0             	test   %rax,%rax
  2c0389:	74 06                	je     2c0391 <remove_free_node+0x21>
        block->next->prev = block->prev;
  2c038b:	48 8b 17             	mov    (%rdi),%rdx
  2c038e:	48 89 10             	mov    %rdx,(%rax)
    if (block->prev != NULL) {
  2c0391:	48 8b 07             	mov    (%rdi),%rax
  2c0394:	48 85 c0             	test   %rax,%rax
  2c0397:	74 08                	je     2c03a1 <remove_free_node+0x31>
        block->prev->next = block->next;
  2c0399:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c039d:	48 89 50 08          	mov    %rdx,0x8(%rax)
    free_len--;
  2c03a1:	83 2d 70 2c 00 00 01 	subl   $0x1,0x2c70(%rip)        # 2c3018 <free_len>
}
  2c03a8:	c3                   	ret    
        free_head = block->next;
  2c03a9:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c03ad:	48 89 05 74 2c 00 00 	mov    %rax,0x2c74(%rip)        # 2c3028 <free_head>
  2c03b4:	eb c3                	jmp    2c0379 <remove_free_node+0x9>
        free_tail = block->prev;
  2c03b6:	48 8b 07             	mov    (%rdi),%rax
  2c03b9:	48 89 05 60 2c 00 00 	mov    %rax,0x2c60(%rip)        # 2c3020 <free_tail>
  2c03c0:	eb c0                	jmp    2c0382 <remove_free_node+0x12>

00000000002c03c2 <append_malloc_header>:
    block->next = NULL;
  2c03c2:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c03c9:	00 
    block->prev = NULL;
  2c03ca:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    if (malloc_head == NULL && malloc_tail == NULL) {
  2c03d1:	48 83 3d 37 2c 00 00 	cmpq   $0x0,0x2c37(%rip)        # 2c3010 <malloc_head>
  2c03d8:	00 
  2c03d9:	74 1d                	je     2c03f8 <append_malloc_header+0x36>
        malloc_tail->next = block;
  2c03db:	48 8b 05 26 2c 00 00 	mov    0x2c26(%rip),%rax        # 2c3008 <malloc_tail>
  2c03e2:	48 89 78 08          	mov    %rdi,0x8(%rax)
        block->prev = malloc_tail;
  2c03e6:	48 89 07             	mov    %rax,(%rdi)
        malloc_tail = block;
  2c03e9:	48 89 3d 18 2c 00 00 	mov    %rdi,0x2c18(%rip)        # 2c3008 <malloc_tail>
    malloc_len++;
  2c03f0:	83 05 09 2c 00 00 01 	addl   $0x1,0x2c09(%rip)        # 2c3000 <malloc_len>
}
  2c03f7:	c3                   	ret    
    if (malloc_head == NULL && malloc_tail == NULL) {
  2c03f8:	48 83 3d 08 2c 00 00 	cmpq   $0x0,0x2c08(%rip)        # 2c3008 <malloc_tail>
  2c03ff:	00 
  2c0400:	75 d9                	jne    2c03db <append_malloc_header+0x19>
        malloc_head = block;
  2c0402:	48 89 3d 07 2c 00 00 	mov    %rdi,0x2c07(%rip)        # 2c3010 <malloc_head>
        malloc_tail = block;
  2c0409:	eb de                	jmp    2c03e9 <append_malloc_header+0x27>

00000000002c040b <remove_malloc_header>:
    if (block == malloc_head) {
  2c040b:	48 39 3d fe 2b 00 00 	cmp    %rdi,0x2bfe(%rip)        # 2c3010 <malloc_head>
  2c0412:	74 30                	je     2c0444 <remove_malloc_header+0x39>
    if (block == malloc_tail) {
  2c0414:	48 39 3d ed 2b 00 00 	cmp    %rdi,0x2bed(%rip)        # 2c3008 <malloc_tail>
  2c041b:	74 34                	je     2c0451 <remove_malloc_header+0x46>
    if (block->next != NULL) {
  2c041d:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c0421:	48 85 c0             	test   %rax,%rax
  2c0424:	74 06                	je     2c042c <remove_malloc_header+0x21>
        block->next->prev = block->prev;
  2c0426:	48 8b 17             	mov    (%rdi),%rdx
  2c0429:	48 89 10             	mov    %rdx,(%rax)
    if (block->prev != NULL) {
  2c042c:	48 8b 07             	mov    (%rdi),%rax
  2c042f:	48 85 c0             	test   %rax,%rax
  2c0432:	74 08                	je     2c043c <remove_malloc_header+0x31>
        block->prev->next = block->next;
  2c0434:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c0438:	48 89 50 08          	mov    %rdx,0x8(%rax)
    malloc_len--;
  2c043c:	83 2d bd 2b 00 00 01 	subl   $0x1,0x2bbd(%rip)        # 2c3000 <malloc_len>
}
  2c0443:	c3                   	ret    
        malloc_head = block->next;
  2c0444:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c0448:	48 89 05 c1 2b 00 00 	mov    %rax,0x2bc1(%rip)        # 2c3010 <malloc_head>
  2c044f:	eb c3                	jmp    2c0414 <remove_malloc_header+0x9>
        malloc_tail = block->prev;
  2c0451:	48 8b 07             	mov    (%rdi),%rax
  2c0454:	48 89 05 ad 2b 00 00 	mov    %rax,0x2bad(%rip)        # 2c3008 <malloc_tail>
  2c045b:	eb c0                	jmp    2c041d <remove_malloc_header+0x12>

00000000002c045d <get_free_block>:
    node* current_node = free_head;
  2c045d:	48 8b 05 c4 2b 00 00 	mov    0x2bc4(%rip),%rax        # 2c3028 <free_head>
    while (current_node != NULL) {
  2c0464:	48 85 c0             	test   %rax,%rax
  2c0467:	74 13                	je     2c047c <get_free_block+0x1f>
        if (current_node->size >= HEADER_SIZE + size)
  2c0469:	48 83 c7 18          	add    $0x18,%rdi
  2c046d:	48 39 78 10          	cmp    %rdi,0x10(%rax)
  2c0471:	73 09                	jae    2c047c <get_free_block+0x1f>
        current_node = current_node->next;
  2c0473:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (current_node != NULL) {
  2c0477:	48 85 c0             	test   %rax,%rax
  2c047a:	75 f1                	jne    2c046d <get_free_block+0x10>
}
  2c047c:	c3                   	ret    

00000000002c047d <allocate_block>:
uintptr_t allocate_block(uint64_t size) {
  2c047d:	55                   	push   %rbp
  2c047e:	48 89 e5             	mov    %rsp,%rbp
  2c0481:	41 55                	push   %r13
  2c0483:	41 54                	push   %r12
  2c0485:	53                   	push   %rbx
  2c0486:	48 83 ec 08          	sub    $0x8,%rsp
  2c048a:	48 89 fb             	mov    %rdi,%rbx
    node* free_block = get_free_block(size);
  2c048d:	e8 cb ff ff ff       	call   2c045d <get_free_block>
    if (free_block == NULL)
  2c0492:	48 85 c0             	test   %rax,%rax
  2c0495:	74 5a                	je     2c04f1 <allocate_block+0x74>
  2c0497:	49 89 c4             	mov    %rax,%r12
    remove_free_node(free_block);
  2c049a:	48 89 c7             	mov    %rax,%rdi
  2c049d:	e8 ce fe ff ff       	call   2c0370 <remove_free_node>
    uintptr_t free_block_addr = (uintptr_t) free_block;
  2c04a2:	4d 89 e5             	mov    %r12,%r13
    uint64_t free_block_size = free_block->size;
  2c04a5:	49 8b 44 24 10       	mov    0x10(%r12),%rax
    uint64_t payload_size = ROUNDUP(size, ALIGNMENT);
  2c04aa:	48 8d 7b 07          	lea    0x7(%rbx),%rdi
  2c04ae:	48 83 e7 f8          	and    $0xfffffffffffffff8,%rdi
    new_header->size = payload_size;
  2c04b2:	49 89 7c 24 10       	mov    %rdi,0x10(%r12)
    uint64_t malloc_block_size = HEADER_SIZE + payload_size;
  2c04b7:	48 8d 57 18          	lea    0x18(%rdi),%rdx
    uint64_t leftover_size = free_block_size - malloc_block_size;
  2c04bb:	48 29 d0             	sub    %rdx,%rax
    if (leftover_size < NODE_SIZE) {
  2c04be:	48 83 f8 17          	cmp    $0x17,%rax
  2c04c2:	77 1e                	ja     2c04e2 <allocate_block+0x65>
        new_header->size += leftover_size;
  2c04c4:	48 01 c7             	add    %rax,%rdi
  2c04c7:	49 89 7c 24 10       	mov    %rdi,0x10(%r12)
    append_malloc_header(new_header);
  2c04cc:	4c 89 e7             	mov    %r12,%rdi
  2c04cf:	e8 ee fe ff ff       	call   2c03c2 <append_malloc_header>
}
  2c04d4:	4c 89 e8             	mov    %r13,%rax
  2c04d7:	48 83 c4 08          	add    $0x8,%rsp
  2c04db:	5b                   	pop    %rbx
  2c04dc:	41 5c                	pop    %r12
  2c04de:	41 5d                	pop    %r13
  2c04e0:	5d                   	pop    %rbp
  2c04e1:	c3                   	ret    
        node* new_free_node = (node*) (free_block_addr + malloc_block_size);
  2c04e2:	49 8d 3c 14          	lea    (%r12,%rdx,1),%rdi
        new_free_node->size = leftover_size;
  2c04e6:	48 89 47 10          	mov    %rax,0x10(%rdi)
        append_free_node(new_free_node);
  2c04ea:	e8 38 fe ff ff       	call   2c0327 <append_free_node>
  2c04ef:	eb db                	jmp    2c04cc <allocate_block+0x4f>
        return (uintptr_t) -1;
  2c04f1:	49 c7 c5 ff ff ff ff 	mov    $0xffffffffffffffff,%r13
  2c04f8:	eb da                	jmp    2c04d4 <allocate_block+0x57>

00000000002c04fa <free>:
    if (firstbyte == NULL)
  2c04fa:	48 85 ff             	test   %rdi,%rdi
  2c04fd:	74 2c                	je     2c052b <free+0x31>
void free(void *firstbyte) {
  2c04ff:	55                   	push   %rbp
  2c0500:	48 89 e5             	mov    %rsp,%rbp
  2c0503:	41 54                	push   %r12
  2c0505:	53                   	push   %rbx
    uintptr_t addr = (uintptr_t) firstbyte - HEADER_SIZE;
  2c0506:	48 8d 5f e8          	lea    -0x18(%rdi),%rbx
    uint64_t block_size = malloc_header->size + HEADER_SIZE;
  2c050a:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  2c050e:	4c 8d 60 18          	lea    0x18(%rax),%r12
    remove_malloc_header(malloc_header);
  2c0512:	48 89 df             	mov    %rbx,%rdi
  2c0515:	e8 f1 fe ff ff       	call   2c040b <remove_malloc_header>
    free_block->size = block_size;
  2c051a:	4c 89 63 10          	mov    %r12,0x10(%rbx)
    append_free_node(free_block);
  2c051e:	48 89 df             	mov    %rbx,%rdi
  2c0521:	e8 01 fe ff ff       	call   2c0327 <append_free_node>
}
  2c0526:	5b                   	pop    %rbx
  2c0527:	41 5c                	pop    %r12
  2c0529:	5d                   	pop    %rbp
  2c052a:	c3                   	ret    
  2c052b:	c3                   	ret    

00000000002c052c <malloc>:
        return NULL;
  2c052c:	b8 00 00 00 00       	mov    $0x0,%eax
    if (numbytes == 0) 
  2c0531:	48 85 ff             	test   %rdi,%rdi
  2c0534:	74 70                	je     2c05a6 <malloc+0x7a>
void * malloc(uint64_t numbytes) {
  2c0536:	55                   	push   %rbp
  2c0537:	48 89 e5             	mov    %rsp,%rbp
  2c053a:	53                   	push   %rbx
  2c053b:	48 83 ec 08          	sub    $0x8,%rsp
  2c053f:	48 89 fb             	mov    %rdi,%rbx
    uintptr_t addr = allocate_block(numbytes);
  2c0542:	e8 36 ff ff ff       	call   2c047d <allocate_block>
    if (addr == (uintptr_t) -1) {
  2c0547:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c054b:	74 0a                	je     2c0557 <malloc+0x2b>
    return (void *) (addr + HEADER_SIZE);
  2c054d:	48 83 c0 18          	add    $0x18,%rax
}
  2c0551:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c0555:	c9                   	leave  
  2c0556:	c3                   	ret    
        intptr_t increment = ROUNDUP(numbytes, PAGESIZE*10);
  2c0557:	48 8d 93 ff 9f 00 00 	lea    0x9fff(%rbx),%rdx
  2c055e:	48 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rcx
  2c0565:	cc cc cc 
  2c0568:	48 89 d0             	mov    %rdx,%rax
  2c056b:	48 f7 e1             	mul    %rcx
  2c056e:	48 c1 ea 0f          	shr    $0xf,%rdx
  2c0572:	48 8d 3c 92          	lea    (%rdx,%rdx,4),%rdi
  2c0576:	48 c1 e7 0d          	shl    $0xd,%rdi
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  2c057a:	cd 3a                	int    $0x3a
  2c057c:	48 89 05 ad 2a 00 00 	mov    %rax,0x2aad(%rip)        # 2c3030 <result.0>
        if (block_addr == (void*) -1)
  2c0583:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c0587:	74 16                	je     2c059f <malloc+0x73>
        new_free_node->size = increment;
  2c0589:	48 89 78 10          	mov    %rdi,0x10(%rax)
        append_free_node(new_free_node);
  2c058d:	48 89 c7             	mov    %rax,%rdi
  2c0590:	e8 92 fd ff ff       	call   2c0327 <append_free_node>
        addr = allocate_block(numbytes);
  2c0595:	48 89 df             	mov    %rbx,%rdi
  2c0598:	e8 e0 fe ff ff       	call   2c047d <allocate_block>
  2c059d:	eb ae                	jmp    2c054d <malloc+0x21>
            return NULL;
  2c059f:	b8 00 00 00 00       	mov    $0x0,%eax
  2c05a4:	eb ab                	jmp    2c0551 <malloc+0x25>
}
  2c05a6:	c3                   	ret    

00000000002c05a7 <calloc>:
void * calloc(uint64_t num, uint64_t sz) {
  2c05a7:	55                   	push   %rbp
  2c05a8:	48 89 e5             	mov    %rsp,%rbp
  2c05ab:	41 54                	push   %r12
  2c05ad:	53                   	push   %rbx
    uint64_t total_size = num*sz;
  2c05ae:	48 89 fb             	mov    %rdi,%rbx
  2c05b1:	48 0f af de          	imul   %rsi,%rbx
    if (total_size == 0 || num * sz / num != sz || num * sz / sz != num) // Check for overflow
  2c05b5:	48 85 db             	test   %rbx,%rbx
  2c05b8:	74 56                	je     2c0610 <calloc+0x69>
  2c05ba:	48 89 d8             	mov    %rbx,%rax
  2c05bd:	ba 00 00 00 00       	mov    $0x0,%edx
  2c05c2:	48 f7 f7             	div    %rdi
        return NULL;
  2c05c5:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    if (total_size == 0 || num * sz / num != sz || num * sz / sz != num) // Check for overflow
  2c05cb:	48 39 f0             	cmp    %rsi,%rax
  2c05ce:	75 38                	jne    2c0608 <calloc+0x61>
  2c05d0:	48 89 d8             	mov    %rbx,%rax
  2c05d3:	ba 00 00 00 00       	mov    $0x0,%edx
  2c05d8:	48 f7 f6             	div    %rsi
  2c05db:	48 39 f8             	cmp    %rdi,%rax
  2c05de:	75 28                	jne    2c0608 <calloc+0x61>
    uint64_t numbytes = ROUNDUP(total_size, ALIGNMENT);
  2c05e0:	48 83 c3 07          	add    $0x7,%rbx
  2c05e4:	48 83 e3 f8          	and    $0xfffffffffffffff8,%rbx
    void* addr = malloc(numbytes);
  2c05e8:	48 89 df             	mov    %rbx,%rdi
  2c05eb:	e8 3c ff ff ff       	call   2c052c <malloc>
  2c05f0:	49 89 c4             	mov    %rax,%r12
    if (addr == NULL)
  2c05f3:	48 85 c0             	test   %rax,%rax
  2c05f6:	74 10                	je     2c0608 <calloc+0x61>
    memset(addr, 0, numbytes);
  2c05f8:	48 89 da             	mov    %rbx,%rdx
  2c05fb:	be 00 00 00 00       	mov    $0x0,%esi
  2c0600:	48 89 c7             	mov    %rax,%rdi
  2c0603:	e8 1c 08 00 00       	call   2c0e24 <memset>
}
  2c0608:	4c 89 e0             	mov    %r12,%rax
  2c060b:	5b                   	pop    %rbx
  2c060c:	41 5c                	pop    %r12
  2c060e:	5d                   	pop    %rbp
  2c060f:	c3                   	ret    
        return NULL;
  2c0610:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c0616:	eb f0                	jmp    2c0608 <calloc+0x61>

00000000002c0618 <realloc>:
void * realloc(void * ptr, uint64_t sz) {
  2c0618:	55                   	push   %rbp
  2c0619:	48 89 e5             	mov    %rsp,%rbp
  2c061c:	41 54                	push   %r12
  2c061e:	53                   	push   %rbx
    if (ptr == NULL) {
  2c061f:	48 85 ff             	test   %rdi,%rdi
  2c0622:	74 40                	je     2c0664 <realloc+0x4c>
  2c0624:	48 89 fb             	mov    %rdi,%rbx
    if (sz == 0) {
  2c0627:	48 85 f6             	test   %rsi,%rsi
  2c062a:	74 45                	je     2c0671 <realloc+0x59>
        return ptr;
  2c062c:	49 89 fc             	mov    %rdi,%r12
    if (old_header->size == sz)
  2c062f:	48 39 77 f8          	cmp    %rsi,-0x8(%rdi)
  2c0633:	74 27                	je     2c065c <realloc+0x44>
    void* realloc_addr = malloc(sz);
  2c0635:	48 89 f7             	mov    %rsi,%rdi
  2c0638:	e8 ef fe ff ff       	call   2c052c <malloc>
  2c063d:	49 89 c4             	mov    %rax,%r12
    if (realloc_addr == NULL)
  2c0640:	48 85 c0             	test   %rax,%rax
  2c0643:	74 17                	je     2c065c <realloc+0x44>
    memcpy(realloc_addr, ptr, realloc_header->size);
  2c0645:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  2c0649:	48 89 de             	mov    %rbx,%rsi
  2c064c:	48 89 c7             	mov    %rax,%rdi
  2c064f:	e8 d2 06 00 00       	call   2c0d26 <memcpy>
    free(ptr);
  2c0654:	48 89 df             	mov    %rbx,%rdi
  2c0657:	e8 9e fe ff ff       	call   2c04fa <free>
}
  2c065c:	4c 89 e0             	mov    %r12,%rax
  2c065f:	5b                   	pop    %rbx
  2c0660:	41 5c                	pop    %r12
  2c0662:	5d                   	pop    %rbp
  2c0663:	c3                   	ret    
        return malloc(sz);
  2c0664:	48 89 f7             	mov    %rsi,%rdi
  2c0667:	e8 c0 fe ff ff       	call   2c052c <malloc>
  2c066c:	49 89 c4             	mov    %rax,%r12
  2c066f:	eb eb                	jmp    2c065c <realloc+0x44>
        free(ptr);
  2c0671:	e8 84 fe ff ff       	call   2c04fa <free>
        return NULL;
  2c0676:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c067c:	eb de                	jmp    2c065c <realloc+0x44>

00000000002c067e <quicksort>:
  if (total_elems == 0)
  2c067e:	48 85 f6             	test   %rsi,%rsi
  2c0681:	0f 84 5f 04 00 00    	je     2c0ae6 <quicksort+0x468>
{
  2c0687:	55                   	push   %rbp
  2c0688:	48 89 e5             	mov    %rsp,%rbp
  2c068b:	41 57                	push   %r15
  2c068d:	41 56                	push   %r14
  2c068f:	41 55                	push   %r13
  2c0691:	41 54                	push   %r12
  2c0693:	53                   	push   %rbx
  2c0694:	48 81 ec 48 04 00 00 	sub    $0x448,%rsp
  2c069b:	49 89 f5             	mov    %rsi,%r13
  2c069e:	49 89 d7             	mov    %rdx,%r15
  2c06a1:	49 89 cc             	mov    %rcx,%r12
  const size_t max_thresh = MAX_THRESH * size;
  2c06a4:	48 8d 0c 95 00 00 00 	lea    0x0(,%rdx,4),%rcx
  2c06ab:	00 
  if (total_elems > MAX_THRESH)
  2c06ac:	48 83 fe 04          	cmp    $0x4,%rsi
  2c06b0:	0f 86 0a 03 00 00    	jbe    2c09c0 <quicksort+0x342>
      char *hi = &lo[size * (total_elems - 1)];
  2c06b6:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
  2c06ba:	48 0f af c2          	imul   %rdx,%rax
  2c06be:	48 01 f8             	add    %rdi,%rax
  2c06c1:	48 89 85 c0 fb ff ff 	mov    %rax,-0x440(%rbp)
      PUSH (NULL, NULL);
  2c06c8:	48 c7 85 d0 fb ff ff 	movq   $0x0,-0x430(%rbp)
  2c06cf:	00 00 00 00 
  2c06d3:	48 c7 85 d8 fb ff ff 	movq   $0x0,-0x428(%rbp)
  2c06da:	00 00 00 00 
      char *lo = base_ptr;
  2c06de:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
      PUSH (NULL, NULL);
  2c06e5:	48 8d 85 e0 fb ff ff 	lea    -0x420(%rbp),%rax
  2c06ec:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
      right_ptr = hi - size;
  2c06f3:	49 89 d6             	mov    %rdx,%r14
  2c06f6:	49 f7 de             	neg    %r14
  2c06f9:	48 89 8d a8 fb ff ff 	mov    %rcx,-0x458(%rbp)
  2c0700:	48 89 bd a0 fb ff ff 	mov    %rdi,-0x460(%rbp)
  2c0707:	48 89 b5 98 fb ff ff 	mov    %rsi,-0x468(%rbp)
  2c070e:	48 89 95 c8 fb ff ff 	mov    %rdx,-0x438(%rbp)
  2c0715:	e9 9b 01 00 00       	jmp    2c08b5 <quicksort+0x237>
  2c071a:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0721:	49 8d 7c 05 00       	lea    0x0(%r13,%rax,1),%rdi
      if ((*cmp) ((void *) mid, (void *) lo) < 0)
  2c0726:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
        SWAP (mid, lo, size);
  2c072d:	4c 89 e8             	mov    %r13,%rax
  2c0730:	0f b6 08             	movzbl (%rax),%ecx
  2c0733:	48 83 c0 01          	add    $0x1,%rax
  2c0737:	0f b6 32             	movzbl (%rdx),%esi
  2c073a:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  2c073e:	48 83 c2 01          	add    $0x1,%rdx
  2c0742:	88 4a ff             	mov    %cl,-0x1(%rdx)
  2c0745:	48 39 c7             	cmp    %rax,%rdi
  2c0748:	75 e6                	jne    2c0730 <quicksort+0xb2>
  2c074a:	e9 a2 01 00 00       	jmp    2c08f1 <quicksort+0x273>
  2c074f:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0756:	49 8d 5c 05 00       	lea    0x0(%r13,%rax,1),%rbx
      if ((*cmp) ((void *) hi, (void *) mid) < 0)
  2c075b:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
        SWAP (mid, hi, size);
  2c0762:	4c 89 e8             	mov    %r13,%rax
  2c0765:	0f b6 08             	movzbl (%rax),%ecx
  2c0768:	48 83 c0 01          	add    $0x1,%rax
  2c076c:	0f b6 32             	movzbl (%rdx),%esi
  2c076f:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  2c0773:	48 83 c2 01          	add    $0x1,%rdx
  2c0777:	88 4a ff             	mov    %cl,-0x1(%rdx)
  2c077a:	48 39 c3             	cmp    %rax,%rbx
  2c077d:	75 e6                	jne    2c0765 <quicksort+0xe7>
      if ((*cmp) ((void *) mid, (void *) lo) < 0)
  2c077f:	48 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%rsi
  2c0786:	4c 89 ef             	mov    %r13,%rdi
  2c0789:	41 ff d4             	call   *%r12
  2c078c:	85 c0                	test   %eax,%eax
  2c078e:	0f 89 72 01 00 00    	jns    2c0906 <quicksort+0x288>
  2c0794:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
        SWAP (mid, lo, size);
  2c079b:	4c 89 e8             	mov    %r13,%rax
  2c079e:	0f b6 08             	movzbl (%rax),%ecx
  2c07a1:	48 83 c0 01          	add    $0x1,%rax
  2c07a5:	0f b6 32             	movzbl (%rdx),%esi
  2c07a8:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  2c07ac:	48 83 c2 01          	add    $0x1,%rdx
  2c07b0:	88 4a ff             	mov    %cl,-0x1(%rdx)
  2c07b3:	48 39 c3             	cmp    %rax,%rbx
  2c07b6:	75 e6                	jne    2c079e <quicksort+0x120>
    jump_over:;
  2c07b8:	e9 49 01 00 00       	jmp    2c0906 <quicksort+0x288>
        right_ptr -= size;
  2c07bd:	4c 01 f3             	add    %r14,%rbx
          while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
  2c07c0:	48 89 de             	mov    %rbx,%rsi
  2c07c3:	4c 89 ef             	mov    %r13,%rdi
  2c07c6:	41 ff d4             	call   *%r12
  2c07c9:	85 c0                	test   %eax,%eax
  2c07cb:	78 f0                	js     2c07bd <quicksort+0x13f>
          if (left_ptr < right_ptr)
  2c07cd:	49 39 df             	cmp    %rbx,%r15
  2c07d0:	72 20                	jb     2c07f2 <quicksort+0x174>
          else if (left_ptr == right_ptr)
  2c07d2:	74 62                	je     2c0836 <quicksort+0x1b8>
      while (left_ptr <= right_ptr);
  2c07d4:	4c 39 fb             	cmp    %r15,%rbx
  2c07d7:	72 6a                	jb     2c0843 <quicksort+0x1c5>
          while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
  2c07d9:	4c 89 ee             	mov    %r13,%rsi
  2c07dc:	4c 89 ff             	mov    %r15,%rdi
  2c07df:	41 ff d4             	call   *%r12
  2c07e2:	85 c0                	test   %eax,%eax
  2c07e4:	79 da                	jns    2c07c0 <quicksort+0x142>
        left_ptr += size;
  2c07e6:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c07ed:	49 01 c7             	add    %rax,%r15
  2c07f0:	eb e7                	jmp    2c07d9 <quicksort+0x15b>
  2c07f2:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c07f9:	49 8d 3c 07          	lea    (%r15,%rax,1),%rdi
          if (left_ptr < right_ptr)
  2c07fd:	48 89 da             	mov    %rbx,%rdx
  2c0800:	4c 89 f8             	mov    %r15,%rax
          SWAP (left_ptr, right_ptr, size);
  2c0803:	0f b6 08             	movzbl (%rax),%ecx
  2c0806:	48 83 c0 01          	add    $0x1,%rax
  2c080a:	0f b6 32             	movzbl (%rdx),%esi
  2c080d:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  2c0811:	48 83 c2 01          	add    $0x1,%rdx
  2c0815:	88 4a ff             	mov    %cl,-0x1(%rdx)
  2c0818:	48 39 f8             	cmp    %rdi,%rax
  2c081b:	75 e6                	jne    2c0803 <quicksort+0x185>
          if (mid == left_ptr)
  2c081d:	4d 39 ef             	cmp    %r13,%r15
  2c0820:	74 0f                	je     2c0831 <quicksort+0x1b3>
          else if (mid == right_ptr)
  2c0822:	4c 39 eb             	cmp    %r13,%rbx
  2c0825:	4d 0f 44 ef          	cmove  %r15,%r13
          right_ptr -= size;
  2c0829:	4c 01 f3             	add    %r14,%rbx
          left_ptr += size;
  2c082c:	49 89 ff             	mov    %rdi,%r15
  2c082f:	eb a3                	jmp    2c07d4 <quicksort+0x156>
  2c0831:	49 89 dd             	mov    %rbx,%r13
  2c0834:	eb f3                	jmp    2c0829 <quicksort+0x1ab>
          left_ptr += size;
  2c0836:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c083d:	49 01 c7             	add    %rax,%r15
          right_ptr -= size;
  2c0840:	4c 01 f3             	add    %r14,%rbx
          if ((size_t) (right_ptr - lo) <= max_thresh)
  2c0843:	48 89 d8             	mov    %rbx,%rax
  2c0846:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
  2c084d:	48 29 d0             	sub    %rdx,%rax
  2c0850:	48 8b bd a8 fb ff ff 	mov    -0x458(%rbp),%rdi
  2c0857:	48 39 c7             	cmp    %rax,%rdi
  2c085a:	0f 82 c8 00 00 00    	jb     2c0928 <quicksort+0x2aa>
              if ((size_t) (hi - left_ptr) <= max_thresh)
  2c0860:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  2c0867:	4c 29 f8             	sub    %r15,%rax
                lo = left_ptr;
  2c086a:	4c 89 bd b8 fb ff ff 	mov    %r15,-0x448(%rbp)
              if ((size_t) (hi - left_ptr) <= max_thresh)
  2c0871:	48 39 c7             	cmp    %rax,%rdi
  2c0874:	72 28                	jb     2c089e <quicksort+0x220>
                POP (lo, hi);
  2c0876:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  2c087d:	48 8b 78 f0          	mov    -0x10(%rax),%rdi
  2c0881:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
  2c0888:	48 8b 78 f8          	mov    -0x8(%rax),%rdi
  2c088c:	48 89 bd c0 fb ff ff 	mov    %rdi,-0x440(%rbp)
  2c0893:	48 8d 40 f0          	lea    -0x10(%rax),%rax
  2c0897:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
      while (STACK_NOT_EMPTY)
  2c089e:	48 8d 85 d0 fb ff ff 	lea    -0x430(%rbp),%rax
  2c08a5:	48 8b bd b0 fb ff ff 	mov    -0x450(%rbp),%rdi
  2c08ac:	48 39 f8             	cmp    %rdi,%rax
  2c08af:	0f 83 ef 00 00 00    	jae    2c09a4 <quicksort+0x326>
      char *mid = lo + size * ((hi - lo) / size >> 1);
  2c08b5:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  2c08bc:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  2c08c3:	48 29 f8             	sub    %rdi,%rax
  2c08c6:	48 8b 8d c8 fb ff ff 	mov    -0x438(%rbp),%rcx
  2c08cd:	ba 00 00 00 00       	mov    $0x0,%edx
  2c08d2:	48 f7 f1             	div    %rcx
  2c08d5:	48 d1 e8             	shr    %rax
  2c08d8:	48 0f af c1          	imul   %rcx,%rax
  2c08dc:	4c 8d 2c 07          	lea    (%rdi,%rax,1),%r13
      if ((*cmp) ((void *) mid, (void *) lo) < 0)
  2c08e0:	48 89 fe             	mov    %rdi,%rsi
  2c08e3:	4c 89 ef             	mov    %r13,%rdi
  2c08e6:	41 ff d4             	call   *%r12
  2c08e9:	85 c0                	test   %eax,%eax
  2c08eb:	0f 88 29 fe ff ff    	js     2c071a <quicksort+0x9c>
      if ((*cmp) ((void *) hi, (void *) mid) < 0)
  2c08f1:	4c 89 ee             	mov    %r13,%rsi
  2c08f4:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  2c08fb:	41 ff d4             	call   *%r12
  2c08fe:	85 c0                	test   %eax,%eax
  2c0900:	0f 88 49 fe ff ff    	js     2c074f <quicksort+0xd1>
      left_ptr  = lo + size;
  2c0906:	48 8b 85 b8 fb ff ff 	mov    -0x448(%rbp),%rax
  2c090d:	48 8b 95 c8 fb ff ff 	mov    -0x438(%rbp),%rdx
  2c0914:	4c 8d 3c 10          	lea    (%rax,%rdx,1),%r15
      right_ptr = hi - size;
  2c0918:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  2c091f:	4a 8d 1c 30          	lea    (%rax,%r14,1),%rbx
  2c0923:	e9 b1 fe ff ff       	jmp    2c07d9 <quicksort+0x15b>
          else if ((size_t) (hi - left_ptr) <= max_thresh)
  2c0928:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
  2c092f:	4c 29 fa             	sub    %r15,%rdx
  2c0932:	48 39 95 a8 fb ff ff 	cmp    %rdx,-0x458(%rbp)
  2c0939:	73 5d                	jae    2c0998 <quicksort+0x31a>
          else if ((right_ptr - lo) > (hi - left_ptr))
  2c093b:	48 39 d0             	cmp    %rdx,%rax
  2c093e:	7e 2c                	jle    2c096c <quicksort+0x2ee>
              PUSH (lo, right_ptr);
  2c0940:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  2c0947:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  2c094e:	48 89 38             	mov    %rdi,(%rax)
  2c0951:	48 89 58 08          	mov    %rbx,0x8(%rax)
  2c0955:	48 83 c0 10          	add    $0x10,%rax
  2c0959:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
              lo = left_ptr;
  2c0960:	4c 89 bd b8 fb ff ff 	mov    %r15,-0x448(%rbp)
  2c0967:	e9 32 ff ff ff       	jmp    2c089e <quicksort+0x220>
              PUSH (left_ptr, hi);
  2c096c:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  2c0973:	4c 89 38             	mov    %r15,(%rax)
  2c0976:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  2c097d:	48 89 78 08          	mov    %rdi,0x8(%rax)
  2c0981:	48 83 c0 10          	add    $0x10,%rax
  2c0985:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
              hi = right_ptr;
  2c098c:	48 89 9d c0 fb ff ff 	mov    %rbx,-0x440(%rbp)
  2c0993:	e9 06 ff ff ff       	jmp    2c089e <quicksort+0x220>
            hi = right_ptr;
  2c0998:	48 89 9d c0 fb ff ff 	mov    %rbx,-0x440(%rbp)
  2c099f:	e9 fa fe ff ff       	jmp    2c089e <quicksort+0x220>
  2c09a4:	48 8b 8d a8 fb ff ff 	mov    -0x458(%rbp),%rcx
  2c09ab:	48 8b bd a0 fb ff ff 	mov    -0x460(%rbp),%rdi
  2c09b2:	4c 8b ad 98 fb ff ff 	mov    -0x468(%rbp),%r13
  2c09b9:	4c 8b bd c8 fb ff ff 	mov    -0x438(%rbp),%r15
    char *const end_ptr = &base_ptr[size * (total_elems - 1)];
  2c09c0:	49 8d 45 ff          	lea    -0x1(%r13),%rax
  2c09c4:	49 0f af c7          	imul   %r15,%rax
  2c09c8:	48 8d 14 07          	lea    (%rdi,%rax,1),%rdx
  2c09cc:	48 89 95 c8 fb ff ff 	mov    %rdx,-0x438(%rbp)
    char *thresh = min(end_ptr, base_ptr + max_thresh);
  2c09d3:	48 8d 04 0f          	lea    (%rdi,%rcx,1),%rax
  2c09d7:	48 39 c2             	cmp    %rax,%rdx
  2c09da:	48 0f 46 c2          	cmovbe %rdx,%rax
    for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  2c09de:	4a 8d 1c 3f          	lea    (%rdi,%r15,1),%rbx
  2c09e2:	48 39 d8             	cmp    %rbx,%rax
  2c09e5:	72 62                	jb     2c0a49 <quicksort+0x3cb>
  2c09e7:	49 89 de             	mov    %rbx,%r14
    char *tmp_ptr = base_ptr;
  2c09ea:	49 89 fd             	mov    %rdi,%r13
  2c09ed:	48 89 9d c0 fb ff ff 	mov    %rbx,-0x440(%rbp)
  2c09f4:	48 89 c3             	mov    %rax,%rbx
  2c09f7:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
      if ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  2c09fe:	4c 89 ee             	mov    %r13,%rsi
  2c0a01:	4c 89 f7             	mov    %r14,%rdi
  2c0a04:	41 ff d4             	call   *%r12
  2c0a07:	85 c0                	test   %eax,%eax
  2c0a09:	4d 0f 48 ee          	cmovs  %r14,%r13
    for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  2c0a0d:	4d 01 fe             	add    %r15,%r14
  2c0a10:	4c 39 f3             	cmp    %r14,%rbx
  2c0a13:	73 e9                	jae    2c09fe <quicksort+0x380>
  2c0a15:	48 8b 9d c0 fb ff ff 	mov    -0x440(%rbp),%rbx
  2c0a1c:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
    if (tmp_ptr != base_ptr)
  2c0a23:	4b 8d 4c 3d 00       	lea    0x0(%r13,%r15,1),%rcx
  2c0a28:	49 39 fd             	cmp    %rdi,%r13
  2c0a2b:	74 1c                	je     2c0a49 <quicksort+0x3cb>
      SWAP (tmp_ptr, base_ptr, size);
  2c0a2d:	41 0f b6 45 00       	movzbl 0x0(%r13),%eax
  2c0a32:	49 83 c5 01          	add    $0x1,%r13
  2c0a36:	0f b6 17             	movzbl (%rdi),%edx
  2c0a39:	41 88 55 ff          	mov    %dl,-0x1(%r13)
  2c0a3d:	48 83 c7 01          	add    $0x1,%rdi
  2c0a41:	88 47 ff             	mov    %al,-0x1(%rdi)
  2c0a44:	49 39 cd             	cmp    %rcx,%r13
  2c0a47:	75 e4                	jne    2c0a2d <quicksort+0x3af>
    while ((run_ptr += size) <= end_ptr)
  2c0a49:	4e 8d 34 3b          	lea    (%rbx,%r15,1),%r14
    tmp_ptr = run_ptr - size;
  2c0a4d:	4d 89 fd             	mov    %r15,%r13
  2c0a50:	49 f7 dd             	neg    %r13
    while ((run_ptr += size) <= end_ptr)
  2c0a53:	4c 39 b5 c8 fb ff ff 	cmp    %r14,-0x438(%rbp)
  2c0a5a:	73 15                	jae    2c0a71 <quicksort+0x3f3>
}
  2c0a5c:	48 81 c4 48 04 00 00 	add    $0x448,%rsp
  2c0a63:	5b                   	pop    %rbx
  2c0a64:	41 5c                	pop    %r12
  2c0a66:	41 5d                	pop    %r13
  2c0a68:	41 5e                	pop    %r14
  2c0a6a:	41 5f                	pop    %r15
  2c0a6c:	5d                   	pop    %rbp
  2c0a6d:	c3                   	ret    
      tmp_ptr -= size;
  2c0a6e:	4c 01 eb             	add    %r13,%rbx
    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  2c0a71:	48 89 de             	mov    %rbx,%rsi
  2c0a74:	4c 89 f7             	mov    %r14,%rdi
  2c0a77:	41 ff d4             	call   *%r12
  2c0a7a:	85 c0                	test   %eax,%eax
  2c0a7c:	78 f0                	js     2c0a6e <quicksort+0x3f0>
    tmp_ptr += size;
  2c0a7e:	4a 8d 34 3b          	lea    (%rbx,%r15,1),%rsi
        if (tmp_ptr != run_ptr)
  2c0a82:	4c 39 f6             	cmp    %r14,%rsi
  2c0a85:	75 15                	jne    2c0a9c <quicksort+0x41e>
    while ((run_ptr += size) <= end_ptr)
  2c0a87:	4b 8d 04 3e          	lea    (%r14,%r15,1),%rax
  2c0a8b:	4c 89 f3             	mov    %r14,%rbx
  2c0a8e:	48 39 85 c8 fb ff ff 	cmp    %rax,-0x438(%rbp)
  2c0a95:	72 c5                	jb     2c0a5c <quicksort+0x3de>
  2c0a97:	49 89 c6             	mov    %rax,%r14
    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  2c0a9a:	eb d5                	jmp    2c0a71 <quicksort+0x3f3>
        while (--trav >= run_ptr)
  2c0a9c:	4b 8d 7c 3e ff       	lea    -0x1(%r14,%r15,1),%rdi
  2c0aa1:	4c 39 f7             	cmp    %r14,%rdi
  2c0aa4:	72 e1                	jb     2c0a87 <quicksort+0x409>
  2c0aa6:	4d 8d 46 ff          	lea    -0x1(%r14),%r8
  2c0aaa:	4d 89 c2             	mov    %r8,%r10
  2c0aad:	eb 13                	jmp    2c0ac2 <quicksort+0x444>
                for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  2c0aaf:	48 89 f9             	mov    %rdi,%rcx
                *hi = c;
  2c0ab2:	44 88 09             	mov    %r9b,(%rcx)
        while (--trav >= run_ptr)
  2c0ab5:	48 83 ef 01          	sub    $0x1,%rdi
  2c0ab9:	49 83 e8 01          	sub    $0x1,%r8
  2c0abd:	49 39 fa             	cmp    %rdi,%r10
  2c0ac0:	74 c5                	je     2c0a87 <quicksort+0x409>
                char c = *trav;
  2c0ac2:	44 0f b6 0f          	movzbl (%rdi),%r9d
                for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  2c0ac6:	4c 89 c0             	mov    %r8,%rax
  2c0ac9:	49 39 f0             	cmp    %rsi,%r8
  2c0acc:	72 e1                	jb     2c0aaf <quicksort+0x431>
  2c0ace:	48 89 fa             	mov    %rdi,%rdx
                  *hi = *lo;
  2c0ad1:	0f b6 08             	movzbl (%rax),%ecx
  2c0ad4:	88 0a                	mov    %cl,(%rdx)
                for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  2c0ad6:	48 89 c1             	mov    %rax,%rcx
  2c0ad9:	4c 01 e8             	add    %r13,%rax
  2c0adc:	4c 29 fa             	sub    %r15,%rdx
  2c0adf:	48 39 f0             	cmp    %rsi,%rax
  2c0ae2:	73 ed                	jae    2c0ad1 <quicksort+0x453>
  2c0ae4:	eb cc                	jmp    2c0ab2 <quicksort+0x434>
  2c0ae6:	c3                   	ret    

00000000002c0ae7 <is_adjacent>:
    freeblock a = freeblock_list[i];
  2c0ae7:	48 63 f6             	movslq %esi,%rsi
  2c0aea:	48 c1 e6 04          	shl    $0x4,%rsi
  2c0aee:	48 01 fe             	add    %rdi,%rsi
    return (uintptr_t) a.addr + a.size == (uintptr_t) b.addr;
  2c0af1:	48 8b 46 08          	mov    0x8(%rsi),%rax
  2c0af5:	48 03 06             	add    (%rsi),%rax
    freeblock b = freeblock_list[j];
  2c0af8:	48 63 d2             	movslq %edx,%rdx
  2c0afb:	48 c1 e2 04          	shl    $0x4,%rdx
    return (uintptr_t) a.addr + a.size == (uintptr_t) b.addr;
  2c0aff:	48 39 04 17          	cmp    %rax,(%rdi,%rdx,1)
  2c0b03:	0f 94 c0             	sete   %al
  2c0b06:	0f b6 c0             	movzbl %al,%eax
}
  2c0b09:	c3                   	ret    

00000000002c0b0a <connect>:
void connect(freeblock* ptrs_with_size, int i, int j) {
  2c0b0a:	55                   	push   %rbp
  2c0b0b:	48 89 e5             	mov    %rsp,%rbp
    node* node_a = (node*) ptrs_with_size[i].addr;
  2c0b0e:	48 63 f6             	movslq %esi,%rsi
  2c0b11:	48 c1 e6 04          	shl    $0x4,%rsi
  2c0b15:	48 8b 04 37          	mov    (%rdi,%rsi,1),%rax
    node* node_b = (node*) ptrs_with_size[j].addr;
  2c0b19:	48 63 d2             	movslq %edx,%rdx
  2c0b1c:	48 c1 e2 04          	shl    $0x4,%rdx
  2c0b20:	48 8b 3c 17          	mov    (%rdi,%rdx,1),%rdi
    node_a->size += node_b->size;
  2c0b24:	48 8b 57 10          	mov    0x10(%rdi),%rdx
  2c0b28:	48 01 50 10          	add    %rdx,0x10(%rax)
    remove_free_node(node_b);
  2c0b2c:	e8 3f f8 ff ff       	call   2c0370 <remove_free_node>
}
  2c0b31:	5d                   	pop    %rbp
  2c0b32:	c3                   	ret    

00000000002c0b33 <defrag>:
void defrag() {
  2c0b33:	55                   	push   %rbp
  2c0b34:	48 89 e5             	mov    %rsp,%rbp
  2c0b37:	41 56                	push   %r14
  2c0b39:	41 55                	push   %r13
  2c0b3b:	41 54                	push   %r12
  2c0b3d:	53                   	push   %rbx
    freeblock freeblock_list[free_len];
  2c0b3e:	8b 05 d4 24 00 00    	mov    0x24d4(%rip),%eax        # 2c3018 <free_len>
  2c0b44:	48 63 f8             	movslq %eax,%rdi
  2c0b47:	48 89 fe             	mov    %rdi,%rsi
  2c0b4a:	48 c1 e6 04          	shl    $0x4,%rsi
  2c0b4e:	48 29 f4             	sub    %rsi,%rsp
  2c0b51:	49 89 e5             	mov    %rsp,%r13
    node* current_node = free_head;
  2c0b54:	48 8b 15 cd 24 00 00 	mov    0x24cd(%rip),%rdx        # 2c3028 <free_head>
    for (int i = 0; i < free_len; i++) {
  2c0b5b:	85 c0                	test   %eax,%eax
  2c0b5d:	7e 1e                	jle    2c0b7d <defrag+0x4a>
  2c0b5f:	4c 89 e8             	mov    %r13,%rax
  2c0b62:	4c 01 ee             	add    %r13,%rsi
        freeblock_list[i].addr = current_node;
  2c0b65:	48 89 10             	mov    %rdx,(%rax)
        freeblock_list[i].size = current_node->size;
  2c0b68:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  2c0b6c:	48 89 48 08          	mov    %rcx,0x8(%rax)
        current_node = current_node->next;
  2c0b70:	48 8b 52 08          	mov    0x8(%rdx),%rdx
    for (int i = 0; i < free_len; i++) {
  2c0b74:	48 83 c0 10          	add    $0x10,%rax
  2c0b78:	48 39 f0             	cmp    %rsi,%rax
  2c0b7b:	75 e8                	jne    2c0b65 <defrag+0x32>
    quicksort(freeblock_list, free_len, sizeof(freeblock_list[0]), &cmp_blocks_ascending);
  2c0b7d:	b9 0d 03 2c 00       	mov    $0x2c030d,%ecx
  2c0b82:	ba 10 00 00 00       	mov    $0x10,%edx
  2c0b87:	48 89 fe             	mov    %rdi,%rsi
  2c0b8a:	4c 89 ef             	mov    %r13,%rdi
  2c0b8d:	e8 ec fa ff ff       	call   2c067e <quicksort>
    int len = free_len;
  2c0b92:	44 8b 35 7f 24 00 00 	mov    0x247f(%rip),%r14d        # 2c3018 <free_len>
    for (int j = 1; j < len; j++) {
  2c0b99:	41 83 fe 01          	cmp    $0x1,%r14d
  2c0b9d:	7e 38                	jle    2c0bd7 <defrag+0xa4>
  2c0b9f:	bb 01 00 00 00       	mov    $0x1,%ebx
    int i = 0;
  2c0ba4:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c0baa:	eb 15                	jmp    2c0bc1 <defrag+0x8e>
            connect(freeblock_list, i, j);
  2c0bac:	89 da                	mov    %ebx,%edx
  2c0bae:	44 89 e6             	mov    %r12d,%esi
  2c0bb1:	4c 89 ef             	mov    %r13,%rdi
  2c0bb4:	e8 51 ff ff ff       	call   2c0b0a <connect>
    for (int j = 1; j < len; j++) {
  2c0bb9:	83 c3 01             	add    $0x1,%ebx
  2c0bbc:	41 39 de             	cmp    %ebx,%r14d
  2c0bbf:	74 16                	je     2c0bd7 <defrag+0xa4>
        if (is_adjacent(freeblock_list, i, j)) {
  2c0bc1:	89 da                	mov    %ebx,%edx
  2c0bc3:	44 89 e6             	mov    %r12d,%esi
  2c0bc6:	4c 89 ef             	mov    %r13,%rdi
  2c0bc9:	e8 19 ff ff ff       	call   2c0ae7 <is_adjacent>
  2c0bce:	85 c0                	test   %eax,%eax
  2c0bd0:	75 da                	jne    2c0bac <defrag+0x79>
  2c0bd2:	41 89 dc             	mov    %ebx,%r12d
  2c0bd5:	eb e2                	jmp    2c0bb9 <defrag+0x86>
}
  2c0bd7:	48 8d 65 e0          	lea    -0x20(%rbp),%rsp
  2c0bdb:	5b                   	pop    %rbx
  2c0bdc:	41 5c                	pop    %r12
  2c0bde:	41 5d                	pop    %r13
  2c0be0:	41 5e                	pop    %r14
  2c0be2:	5d                   	pop    %rbp
  2c0be3:	c3                   	ret    

00000000002c0be4 <heap_info>:

int heap_info(heap_info_struct * info) {
  2c0be4:	55                   	push   %rbp
  2c0be5:	48 89 e5             	mov    %rsp,%rbp
  2c0be8:	41 57                	push   %r15
  2c0bea:	41 56                	push   %r14
  2c0bec:	41 55                	push   %r13
  2c0bee:	41 54                	push   %r12
  2c0bf0:	53                   	push   %rbx
  2c0bf1:	48 83 ec 08          	sub    $0x8,%rsp
  2c0bf5:	49 89 fd             	mov    %rdi,%r13
    info->num_allocs = malloc_len;
  2c0bf8:	8b 35 02 24 00 00    	mov    0x2402(%rip),%esi        # 2c3000 <malloc_len>
  2c0bfe:	89 37                	mov    %esi,(%rdi)
    // Calculate free_space and largest_free_chunk
    int free_space = 0;
    int largest_free_chunk = 0;
    node* current_node = free_head;
  2c0c00:	48 8b 05 21 24 00 00 	mov    0x2421(%rip),%rax        # 2c3028 <free_head>
    while (current_node != NULL) {
  2c0c07:	48 85 c0             	test   %rax,%rax
  2c0c0a:	74 54                	je     2c0c60 <heap_info+0x7c>
    int largest_free_chunk = 0;
  2c0c0c:	bb 00 00 00 00       	mov    $0x0,%ebx
    int free_space = 0;
  2c0c11:	41 bc 00 00 00 00    	mov    $0x0,%r12d
        int current_size = (int) current_node->size;
  2c0c17:	48 8b 50 10          	mov    0x10(%rax),%rdx
        if (current_size > largest_free_chunk) {
  2c0c1b:	39 d3                	cmp    %edx,%ebx
  2c0c1d:	0f 4c da             	cmovl  %edx,%ebx
            largest_free_chunk = current_size;
        }
        free_space += current_size;
  2c0c20:	41 01 d4             	add    %edx,%r12d
        current_node = current_node->next;
  2c0c23:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (current_node != NULL) {
  2c0c27:	48 85 c0             	test   %rax,%rax
  2c0c2a:	75 eb                	jne    2c0c17 <heap_info+0x33>
    // Calculate size_array and ptr_array
    long* size_array;
    void** ptr_array;
    if (info->num_allocs == 0) {
        size_array = NULL;
        ptr_array = NULL;
  2c0c2c:	41 be 00 00 00 00    	mov    $0x0,%r14d
        size_array = NULL;
  2c0c32:	41 bf 00 00 00 00    	mov    $0x0,%r15d
    if (info->num_allocs == 0) {
  2c0c38:	85 f6                	test   %esi,%esi
  2c0c3a:	75 31                	jne    2c0c6d <heap_info+0x89>
        // Sort the two arrays
        quicksort(size_array, info->num_allocs, sizeof(size_array[0]), &cmp_size_array_descending);
        quicksort(ptr_array, info->num_allocs, sizeof(size_array[0]), &cmp_ptr_array_descending);
    }

    info->size_array = size_array;
  2c0c3c:	4d 89 7d 08          	mov    %r15,0x8(%r13)
    info->ptr_array = ptr_array;
  2c0c40:	4d 89 75 10          	mov    %r14,0x10(%r13)
    info->largest_free_chunk = largest_free_chunk;
  2c0c44:	41 89 5d 1c          	mov    %ebx,0x1c(%r13)
    info->free_space = free_space;
  2c0c48:	45 89 65 18          	mov    %r12d,0x18(%r13)

    return 0;
  2c0c4c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  2c0c51:	48 83 c4 08          	add    $0x8,%rsp
  2c0c55:	5b                   	pop    %rbx
  2c0c56:	41 5c                	pop    %r12
  2c0c58:	41 5d                	pop    %r13
  2c0c5a:	41 5e                	pop    %r14
  2c0c5c:	41 5f                	pop    %r15
  2c0c5e:	5d                   	pop    %rbp
  2c0c5f:	c3                   	ret    
    int largest_free_chunk = 0;
  2c0c60:	bb 00 00 00 00       	mov    $0x0,%ebx
    int free_space = 0;
  2c0c65:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c0c6b:	eb bf                	jmp    2c0c2c <heap_info+0x48>
        size_array = (long *) malloc(info->num_allocs * sizeof(long));
  2c0c6d:	48 63 f6             	movslq %esi,%rsi
  2c0c70:	48 8d 3c f5 00 00 00 	lea    0x0(,%rsi,8),%rdi
  2c0c77:	00 
  2c0c78:	e8 af f8 ff ff       	call   2c052c <malloc>
  2c0c7d:	49 89 c7             	mov    %rax,%r15
        if (size_array == NULL) {
  2c0c80:	48 85 c0             	test   %rax,%rax
  2c0c83:	74 79                	je     2c0cfe <heap_info+0x11a>
        ptr_array = (void **) malloc(info->num_allocs * sizeof(void*));
  2c0c85:	49 63 7d 00          	movslq 0x0(%r13),%rdi
  2c0c89:	48 c1 e7 03          	shl    $0x3,%rdi
  2c0c8d:	e8 9a f8 ff ff       	call   2c052c <malloc>
  2c0c92:	49 89 c6             	mov    %rax,%r14
        if (ptr_array == NULL) {
  2c0c95:	48 85 c0             	test   %rax,%rax
  2c0c98:	74 78                	je     2c0d12 <heap_info+0x12e>
        header *current_header = malloc_head;
  2c0c9a:	48 8b 15 6f 23 00 00 	mov    0x236f(%rip),%rdx        # 2c3010 <malloc_head>
        for (int i = 0; i < info->num_allocs; i++) {
  2c0ca1:	41 8b 75 00          	mov    0x0(%r13),%esi
  2c0ca5:	85 f6                	test   %esi,%esi
  2c0ca7:	7e 25                	jle    2c0cce <heap_info+0xea>
  2c0ca9:	b8 00 00 00 00       	mov    $0x0,%eax
            size_array[i] = (long) current_header->size;
  2c0cae:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  2c0cb2:	49 89 0c c7          	mov    %rcx,(%r15,%rax,8)
            ptr_array[i] = (void *) ((uintptr_t) current_header + HEADER_SIZE);
  2c0cb6:	48 8d 4a 18          	lea    0x18(%rdx),%rcx
  2c0cba:	49 89 0c c6          	mov    %rcx,(%r14,%rax,8)
            current_header = current_header->next;
  2c0cbe:	48 8b 52 08          	mov    0x8(%rdx),%rdx
        for (int i = 0; i < info->num_allocs; i++) {
  2c0cc2:	41 8b 75 00          	mov    0x0(%r13),%esi
  2c0cc6:	48 83 c0 01          	add    $0x1,%rax
  2c0cca:	39 c6                	cmp    %eax,%esi
  2c0ccc:	7f e0                	jg     2c0cae <heap_info+0xca>
        quicksort(size_array, info->num_allocs, sizeof(size_array[0]), &cmp_size_array_descending);
  2c0cce:	48 63 f6             	movslq %esi,%rsi
  2c0cd1:	b9 13 03 2c 00       	mov    $0x2c0313,%ecx
  2c0cd6:	ba 08 00 00 00       	mov    $0x8,%edx
  2c0cdb:	4c 89 ff             	mov    %r15,%rdi
  2c0cde:	e8 9b f9 ff ff       	call   2c067e <quicksort>
        quicksort(ptr_array, info->num_allocs, sizeof(size_array[0]), &cmp_ptr_array_descending);
  2c0ce3:	49 63 75 00          	movslq 0x0(%r13),%rsi
  2c0ce7:	b9 19 03 2c 00       	mov    $0x2c0319,%ecx
  2c0cec:	ba 08 00 00 00       	mov    $0x8,%edx
  2c0cf1:	4c 89 f7             	mov    %r14,%rdi
  2c0cf4:	e8 85 f9 ff ff       	call   2c067e <quicksort>
  2c0cf9:	e9 3e ff ff ff       	jmp    2c0c3c <heap_info+0x58>
            free(size_array);
  2c0cfe:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0d03:	e8 f2 f7 ff ff       	call   2c04fa <free>
            return -1;
  2c0d08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c0d0d:	e9 3f ff ff ff       	jmp    2c0c51 <heap_info+0x6d>
            free(ptr_array);
  2c0d12:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0d17:	e8 de f7 ff ff       	call   2c04fa <free>
            return -1;
  2c0d1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c0d21:	e9 2b ff ff ff       	jmp    2c0c51 <heap_info+0x6d>

00000000002c0d26 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c0d26:	55                   	push   %rbp
  2c0d27:	48 89 e5             	mov    %rsp,%rbp
  2c0d2a:	48 83 ec 28          	sub    $0x28,%rsp
  2c0d2e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0d32:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0d36:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0d3a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0d3e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0d42:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0d46:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c0d4a:	eb 1c                	jmp    2c0d68 <memcpy+0x42>
        *d = *s;
  2c0d4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0d50:	0f b6 10             	movzbl (%rax),%edx
  2c0d53:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0d57:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0d59:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0d5e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0d63:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c0d68:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0d6d:	75 dd                	jne    2c0d4c <memcpy+0x26>
    }
    return dst;
  2c0d6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0d73:	c9                   	leave  
  2c0d74:	c3                   	ret    

00000000002c0d75 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c0d75:	55                   	push   %rbp
  2c0d76:	48 89 e5             	mov    %rsp,%rbp
  2c0d79:	48 83 ec 28          	sub    $0x28,%rsp
  2c0d7d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0d81:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0d85:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0d89:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0d8d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c0d91:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0d95:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c0d99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0d9d:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c0da1:	73 6a                	jae    2c0e0d <memmove+0x98>
  2c0da3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0da7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0dab:	48 01 d0             	add    %rdx,%rax
  2c0dae:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c0db2:	73 59                	jae    2c0e0d <memmove+0x98>
        s += n, d += n;
  2c0db4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0db8:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c0dbc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0dc0:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c0dc4:	eb 17                	jmp    2c0ddd <memmove+0x68>
            *--d = *--s;
  2c0dc6:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c0dcb:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c0dd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0dd4:	0f b6 10             	movzbl (%rax),%edx
  2c0dd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0ddb:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0ddd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0de1:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0de5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0de9:	48 85 c0             	test   %rax,%rax
  2c0dec:	75 d8                	jne    2c0dc6 <memmove+0x51>
    if (s < d && s + n > d) {
  2c0dee:	eb 2e                	jmp    2c0e1e <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c0df0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0df4:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0df8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0dfc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0e00:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0e04:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c0e08:	0f b6 12             	movzbl (%rdx),%edx
  2c0e0b:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0e0d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0e11:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0e15:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0e19:	48 85 c0             	test   %rax,%rax
  2c0e1c:	75 d2                	jne    2c0df0 <memmove+0x7b>
        }
    }
    return dst;
  2c0e1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0e22:	c9                   	leave  
  2c0e23:	c3                   	ret    

00000000002c0e24 <memset>:

void* memset(void* v, int c, size_t n) {
  2c0e24:	55                   	push   %rbp
  2c0e25:	48 89 e5             	mov    %rsp,%rbp
  2c0e28:	48 83 ec 28          	sub    $0x28,%rsp
  2c0e2c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0e30:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c0e33:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0e37:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0e3b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0e3f:	eb 15                	jmp    2c0e56 <memset+0x32>
        *p = c;
  2c0e41:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0e44:	89 c2                	mov    %eax,%edx
  2c0e46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0e4a:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0e4c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0e51:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0e56:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0e5b:	75 e4                	jne    2c0e41 <memset+0x1d>
    }
    return v;
  2c0e5d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0e61:	c9                   	leave  
  2c0e62:	c3                   	ret    

00000000002c0e63 <strlen>:

size_t strlen(const char* s) {
  2c0e63:	55                   	push   %rbp
  2c0e64:	48 89 e5             	mov    %rsp,%rbp
  2c0e67:	48 83 ec 18          	sub    $0x18,%rsp
  2c0e6b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c0e6f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0e76:	00 
  2c0e77:	eb 0a                	jmp    2c0e83 <strlen+0x20>
        ++n;
  2c0e79:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c0e7e:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0e83:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0e87:	0f b6 00             	movzbl (%rax),%eax
  2c0e8a:	84 c0                	test   %al,%al
  2c0e8c:	75 eb                	jne    2c0e79 <strlen+0x16>
    }
    return n;
  2c0e8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0e92:	c9                   	leave  
  2c0e93:	c3                   	ret    

00000000002c0e94 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0e94:	55                   	push   %rbp
  2c0e95:	48 89 e5             	mov    %rsp,%rbp
  2c0e98:	48 83 ec 20          	sub    $0x20,%rsp
  2c0e9c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0ea0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0ea4:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0eab:	00 
  2c0eac:	eb 0a                	jmp    2c0eb8 <strnlen+0x24>
        ++n;
  2c0eae:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0eb3:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0eb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ebc:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c0ec0:	74 0b                	je     2c0ecd <strnlen+0x39>
  2c0ec2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0ec6:	0f b6 00             	movzbl (%rax),%eax
  2c0ec9:	84 c0                	test   %al,%al
  2c0ecb:	75 e1                	jne    2c0eae <strnlen+0x1a>
    }
    return n;
  2c0ecd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0ed1:	c9                   	leave  
  2c0ed2:	c3                   	ret    

00000000002c0ed3 <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c0ed3:	55                   	push   %rbp
  2c0ed4:	48 89 e5             	mov    %rsp,%rbp
  2c0ed7:	48 83 ec 20          	sub    $0x20,%rsp
  2c0edb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0edf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c0ee3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0ee7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c0eeb:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c0eef:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0ef3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c0ef7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0efb:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0eff:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c0f03:	0f b6 12             	movzbl (%rdx),%edx
  2c0f06:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c0f08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0f0c:	48 83 e8 01          	sub    $0x1,%rax
  2c0f10:	0f b6 00             	movzbl (%rax),%eax
  2c0f13:	84 c0                	test   %al,%al
  2c0f15:	75 d4                	jne    2c0eeb <strcpy+0x18>
    return dst;
  2c0f17:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0f1b:	c9                   	leave  
  2c0f1c:	c3                   	ret    

00000000002c0f1d <strcmp>:

int strcmp(const char* a, const char* b) {
  2c0f1d:	55                   	push   %rbp
  2c0f1e:	48 89 e5             	mov    %rsp,%rbp
  2c0f21:	48 83 ec 10          	sub    $0x10,%rsp
  2c0f25:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0f29:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0f2d:	eb 0a                	jmp    2c0f39 <strcmp+0x1c>
        ++a, ++b;
  2c0f2f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0f34:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0f39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0f3d:	0f b6 00             	movzbl (%rax),%eax
  2c0f40:	84 c0                	test   %al,%al
  2c0f42:	74 1d                	je     2c0f61 <strcmp+0x44>
  2c0f44:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0f48:	0f b6 00             	movzbl (%rax),%eax
  2c0f4b:	84 c0                	test   %al,%al
  2c0f4d:	74 12                	je     2c0f61 <strcmp+0x44>
  2c0f4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0f53:	0f b6 10             	movzbl (%rax),%edx
  2c0f56:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0f5a:	0f b6 00             	movzbl (%rax),%eax
  2c0f5d:	38 c2                	cmp    %al,%dl
  2c0f5f:	74 ce                	je     2c0f2f <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c0f61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0f65:	0f b6 00             	movzbl (%rax),%eax
  2c0f68:	89 c2                	mov    %eax,%edx
  2c0f6a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0f6e:	0f b6 00             	movzbl (%rax),%eax
  2c0f71:	38 d0                	cmp    %dl,%al
  2c0f73:	0f 92 c0             	setb   %al
  2c0f76:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c0f79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0f7d:	0f b6 00             	movzbl (%rax),%eax
  2c0f80:	89 c1                	mov    %eax,%ecx
  2c0f82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0f86:	0f b6 00             	movzbl (%rax),%eax
  2c0f89:	38 c1                	cmp    %al,%cl
  2c0f8b:	0f 92 c0             	setb   %al
  2c0f8e:	0f b6 c0             	movzbl %al,%eax
  2c0f91:	29 c2                	sub    %eax,%edx
  2c0f93:	89 d0                	mov    %edx,%eax
}
  2c0f95:	c9                   	leave  
  2c0f96:	c3                   	ret    

00000000002c0f97 <strchr>:

char* strchr(const char* s, int c) {
  2c0f97:	55                   	push   %rbp
  2c0f98:	48 89 e5             	mov    %rsp,%rbp
  2c0f9b:	48 83 ec 10          	sub    $0x10,%rsp
  2c0f9f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0fa3:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c0fa6:	eb 05                	jmp    2c0fad <strchr+0x16>
        ++s;
  2c0fa8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c0fad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0fb1:	0f b6 00             	movzbl (%rax),%eax
  2c0fb4:	84 c0                	test   %al,%al
  2c0fb6:	74 0e                	je     2c0fc6 <strchr+0x2f>
  2c0fb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0fbc:	0f b6 00             	movzbl (%rax),%eax
  2c0fbf:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0fc2:	38 d0                	cmp    %dl,%al
  2c0fc4:	75 e2                	jne    2c0fa8 <strchr+0x11>
    }
    if (*s == (char) c) {
  2c0fc6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0fca:	0f b6 00             	movzbl (%rax),%eax
  2c0fcd:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0fd0:	38 d0                	cmp    %dl,%al
  2c0fd2:	75 06                	jne    2c0fda <strchr+0x43>
        return (char*) s;
  2c0fd4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0fd8:	eb 05                	jmp    2c0fdf <strchr+0x48>
    } else {
        return NULL;
  2c0fda:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c0fdf:	c9                   	leave  
  2c0fe0:	c3                   	ret    

00000000002c0fe1 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c0fe1:	55                   	push   %rbp
  2c0fe2:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c0fe5:	8b 05 4d 20 00 00    	mov    0x204d(%rip),%eax        # 2c3038 <rand_seed_set>
  2c0feb:	85 c0                	test   %eax,%eax
  2c0fed:	75 0a                	jne    2c0ff9 <rand+0x18>
        srand(819234718U);
  2c0fef:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c0ff4:	e8 24 00 00 00       	call   2c101d <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0ff9:	8b 05 3d 20 00 00    	mov    0x203d(%rip),%eax        # 2c303c <rand_seed>
  2c0fff:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c1005:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c100a:	89 05 2c 20 00 00    	mov    %eax,0x202c(%rip)        # 2c303c <rand_seed>
    return rand_seed & RAND_MAX;
  2c1010:	8b 05 26 20 00 00    	mov    0x2026(%rip),%eax        # 2c303c <rand_seed>
  2c1016:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c101b:	5d                   	pop    %rbp
  2c101c:	c3                   	ret    

00000000002c101d <srand>:

void srand(unsigned seed) {
  2c101d:	55                   	push   %rbp
  2c101e:	48 89 e5             	mov    %rsp,%rbp
  2c1021:	48 83 ec 08          	sub    $0x8,%rsp
  2c1025:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c1028:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c102b:	89 05 0b 20 00 00    	mov    %eax,0x200b(%rip)        # 2c303c <rand_seed>
    rand_seed_set = 1;
  2c1031:	c7 05 fd 1f 00 00 01 	movl   $0x1,0x1ffd(%rip)        # 2c3038 <rand_seed_set>
  2c1038:	00 00 00 
}
  2c103b:	90                   	nop
  2c103c:	c9                   	leave  
  2c103d:	c3                   	ret    

00000000002c103e <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c103e:	55                   	push   %rbp
  2c103f:	48 89 e5             	mov    %rsp,%rbp
  2c1042:	48 83 ec 28          	sub    $0x28,%rsp
  2c1046:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c104a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c104e:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c1051:	48 c7 45 f8 50 20 2c 	movq   $0x2c2050,-0x8(%rbp)
  2c1058:	00 
    if (base < 0) {
  2c1059:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c105d:	79 0b                	jns    2c106a <fill_numbuf+0x2c>
        digits = lower_digits;
  2c105f:	48 c7 45 f8 70 20 2c 	movq   $0x2c2070,-0x8(%rbp)
  2c1066:	00 
        base = -base;
  2c1067:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c106a:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c106f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1073:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c1076:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c1079:	48 63 c8             	movslq %eax,%rcx
  2c107c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c1080:	ba 00 00 00 00       	mov    $0x0,%edx
  2c1085:	48 f7 f1             	div    %rcx
  2c1088:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c108c:	48 01 d0             	add    %rdx,%rax
  2c108f:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c1094:	0f b6 10             	movzbl (%rax),%edx
  2c1097:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c109b:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c109d:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c10a0:	48 63 f0             	movslq %eax,%rsi
  2c10a3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c10a7:	ba 00 00 00 00       	mov    $0x0,%edx
  2c10ac:	48 f7 f6             	div    %rsi
  2c10af:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c10b3:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c10b8:	75 bc                	jne    2c1076 <fill_numbuf+0x38>
    return numbuf_end;
  2c10ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c10be:	c9                   	leave  
  2c10bf:	c3                   	ret    

00000000002c10c0 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c10c0:	55                   	push   %rbp
  2c10c1:	48 89 e5             	mov    %rsp,%rbp
  2c10c4:	53                   	push   %rbx
  2c10c5:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c10cc:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c10d3:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c10d9:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c10e0:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c10e7:	e9 8a 09 00 00       	jmp    2c1a76 <printer_vprintf+0x9b6>
        if (*format != '%') {
  2c10ec:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c10f3:	0f b6 00             	movzbl (%rax),%eax
  2c10f6:	3c 25                	cmp    $0x25,%al
  2c10f8:	74 31                	je     2c112b <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  2c10fa:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1101:	4c 8b 00             	mov    (%rax),%r8
  2c1104:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c110b:	0f b6 00             	movzbl (%rax),%eax
  2c110e:	0f b6 c8             	movzbl %al,%ecx
  2c1111:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1117:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c111e:	89 ce                	mov    %ecx,%esi
  2c1120:	48 89 c7             	mov    %rax,%rdi
  2c1123:	41 ff d0             	call   *%r8
            continue;
  2c1126:	e9 43 09 00 00       	jmp    2c1a6e <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  2c112b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c1132:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1139:	01 
  2c113a:	eb 44                	jmp    2c1180 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  2c113c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1143:	0f b6 00             	movzbl (%rax),%eax
  2c1146:	0f be c0             	movsbl %al,%eax
  2c1149:	89 c6                	mov    %eax,%esi
  2c114b:	bf 70 1e 2c 00       	mov    $0x2c1e70,%edi
  2c1150:	e8 42 fe ff ff       	call   2c0f97 <strchr>
  2c1155:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c1159:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c115e:	74 30                	je     2c1190 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  2c1160:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c1164:	48 2d 70 1e 2c 00    	sub    $0x2c1e70,%rax
  2c116a:	ba 01 00 00 00       	mov    $0x1,%edx
  2c116f:	89 c1                	mov    %eax,%ecx
  2c1171:	d3 e2                	shl    %cl,%edx
  2c1173:	89 d0                	mov    %edx,%eax
  2c1175:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c1178:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c117f:	01 
  2c1180:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1187:	0f b6 00             	movzbl (%rax),%eax
  2c118a:	84 c0                	test   %al,%al
  2c118c:	75 ae                	jne    2c113c <printer_vprintf+0x7c>
  2c118e:	eb 01                	jmp    2c1191 <printer_vprintf+0xd1>
            } else {
                break;
  2c1190:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c1191:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c1198:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c119f:	0f b6 00             	movzbl (%rax),%eax
  2c11a2:	3c 30                	cmp    $0x30,%al
  2c11a4:	7e 67                	jle    2c120d <printer_vprintf+0x14d>
  2c11a6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c11ad:	0f b6 00             	movzbl (%rax),%eax
  2c11b0:	3c 39                	cmp    $0x39,%al
  2c11b2:	7f 59                	jg     2c120d <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c11b4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c11bb:	eb 2e                	jmp    2c11eb <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  2c11bd:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c11c0:	89 d0                	mov    %edx,%eax
  2c11c2:	c1 e0 02             	shl    $0x2,%eax
  2c11c5:	01 d0                	add    %edx,%eax
  2c11c7:	01 c0                	add    %eax,%eax
  2c11c9:	89 c1                	mov    %eax,%ecx
  2c11cb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c11d2:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c11d6:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c11dd:	0f b6 00             	movzbl (%rax),%eax
  2c11e0:	0f be c0             	movsbl %al,%eax
  2c11e3:	01 c8                	add    %ecx,%eax
  2c11e5:	83 e8 30             	sub    $0x30,%eax
  2c11e8:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c11eb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c11f2:	0f b6 00             	movzbl (%rax),%eax
  2c11f5:	3c 2f                	cmp    $0x2f,%al
  2c11f7:	0f 8e 85 00 00 00    	jle    2c1282 <printer_vprintf+0x1c2>
  2c11fd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1204:	0f b6 00             	movzbl (%rax),%eax
  2c1207:	3c 39                	cmp    $0x39,%al
  2c1209:	7e b2                	jle    2c11bd <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  2c120b:	eb 75                	jmp    2c1282 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  2c120d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1214:	0f b6 00             	movzbl (%rax),%eax
  2c1217:	3c 2a                	cmp    $0x2a,%al
  2c1219:	75 68                	jne    2c1283 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  2c121b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1222:	8b 00                	mov    (%rax),%eax
  2c1224:	83 f8 2f             	cmp    $0x2f,%eax
  2c1227:	77 30                	ja     2c1259 <printer_vprintf+0x199>
  2c1229:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1230:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1234:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c123b:	8b 00                	mov    (%rax),%eax
  2c123d:	89 c0                	mov    %eax,%eax
  2c123f:	48 01 d0             	add    %rdx,%rax
  2c1242:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1249:	8b 12                	mov    (%rdx),%edx
  2c124b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c124e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1255:	89 0a                	mov    %ecx,(%rdx)
  2c1257:	eb 1a                	jmp    2c1273 <printer_vprintf+0x1b3>
  2c1259:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1260:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1264:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1268:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c126f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1273:	8b 00                	mov    (%rax),%eax
  2c1275:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c1278:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c127f:	01 
  2c1280:	eb 01                	jmp    2c1283 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  2c1282:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c1283:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c128a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1291:	0f b6 00             	movzbl (%rax),%eax
  2c1294:	3c 2e                	cmp    $0x2e,%al
  2c1296:	0f 85 00 01 00 00    	jne    2c139c <printer_vprintf+0x2dc>
            ++format;
  2c129c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c12a3:	01 
            if (*format >= '0' && *format <= '9') {
  2c12a4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c12ab:	0f b6 00             	movzbl (%rax),%eax
  2c12ae:	3c 2f                	cmp    $0x2f,%al
  2c12b0:	7e 67                	jle    2c1319 <printer_vprintf+0x259>
  2c12b2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c12b9:	0f b6 00             	movzbl (%rax),%eax
  2c12bc:	3c 39                	cmp    $0x39,%al
  2c12be:	7f 59                	jg     2c1319 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c12c0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c12c7:	eb 2e                	jmp    2c12f7 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  2c12c9:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c12cc:	89 d0                	mov    %edx,%eax
  2c12ce:	c1 e0 02             	shl    $0x2,%eax
  2c12d1:	01 d0                	add    %edx,%eax
  2c12d3:	01 c0                	add    %eax,%eax
  2c12d5:	89 c1                	mov    %eax,%ecx
  2c12d7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c12de:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c12e2:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c12e9:	0f b6 00             	movzbl (%rax),%eax
  2c12ec:	0f be c0             	movsbl %al,%eax
  2c12ef:	01 c8                	add    %ecx,%eax
  2c12f1:	83 e8 30             	sub    $0x30,%eax
  2c12f4:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c12f7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c12fe:	0f b6 00             	movzbl (%rax),%eax
  2c1301:	3c 2f                	cmp    $0x2f,%al
  2c1303:	0f 8e 85 00 00 00    	jle    2c138e <printer_vprintf+0x2ce>
  2c1309:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1310:	0f b6 00             	movzbl (%rax),%eax
  2c1313:	3c 39                	cmp    $0x39,%al
  2c1315:	7e b2                	jle    2c12c9 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  2c1317:	eb 75                	jmp    2c138e <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  2c1319:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1320:	0f b6 00             	movzbl (%rax),%eax
  2c1323:	3c 2a                	cmp    $0x2a,%al
  2c1325:	75 68                	jne    2c138f <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  2c1327:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c132e:	8b 00                	mov    (%rax),%eax
  2c1330:	83 f8 2f             	cmp    $0x2f,%eax
  2c1333:	77 30                	ja     2c1365 <printer_vprintf+0x2a5>
  2c1335:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c133c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1340:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1347:	8b 00                	mov    (%rax),%eax
  2c1349:	89 c0                	mov    %eax,%eax
  2c134b:	48 01 d0             	add    %rdx,%rax
  2c134e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1355:	8b 12                	mov    (%rdx),%edx
  2c1357:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c135a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1361:	89 0a                	mov    %ecx,(%rdx)
  2c1363:	eb 1a                	jmp    2c137f <printer_vprintf+0x2bf>
  2c1365:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c136c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1370:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1374:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c137b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c137f:	8b 00                	mov    (%rax),%eax
  2c1381:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c1384:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c138b:	01 
  2c138c:	eb 01                	jmp    2c138f <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  2c138e:	90                   	nop
            }
            if (precision < 0) {
  2c138f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1393:	79 07                	jns    2c139c <printer_vprintf+0x2dc>
                precision = 0;
  2c1395:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c139c:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c13a3:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c13aa:	00 
        int length = 0;
  2c13ab:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c13b2:	48 c7 45 c8 76 1e 2c 	movq   $0x2c1e76,-0x38(%rbp)
  2c13b9:	00 
    again:
        switch (*format) {
  2c13ba:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c13c1:	0f b6 00             	movzbl (%rax),%eax
  2c13c4:	0f be c0             	movsbl %al,%eax
  2c13c7:	83 e8 43             	sub    $0x43,%eax
  2c13ca:	83 f8 37             	cmp    $0x37,%eax
  2c13cd:	0f 87 9f 03 00 00    	ja     2c1772 <printer_vprintf+0x6b2>
  2c13d3:	89 c0                	mov    %eax,%eax
  2c13d5:	48 8b 04 c5 88 1e 2c 	mov    0x2c1e88(,%rax,8),%rax
  2c13dc:	00 
  2c13dd:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  2c13df:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c13e6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c13ed:	01 
            goto again;
  2c13ee:	eb ca                	jmp    2c13ba <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c13f0:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c13f4:	74 5d                	je     2c1453 <printer_vprintf+0x393>
  2c13f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13fd:	8b 00                	mov    (%rax),%eax
  2c13ff:	83 f8 2f             	cmp    $0x2f,%eax
  2c1402:	77 30                	ja     2c1434 <printer_vprintf+0x374>
  2c1404:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c140b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c140f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1416:	8b 00                	mov    (%rax),%eax
  2c1418:	89 c0                	mov    %eax,%eax
  2c141a:	48 01 d0             	add    %rdx,%rax
  2c141d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1424:	8b 12                	mov    (%rdx),%edx
  2c1426:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1429:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1430:	89 0a                	mov    %ecx,(%rdx)
  2c1432:	eb 1a                	jmp    2c144e <printer_vprintf+0x38e>
  2c1434:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c143b:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c143f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1443:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c144a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c144e:	48 8b 00             	mov    (%rax),%rax
  2c1451:	eb 5c                	jmp    2c14af <printer_vprintf+0x3ef>
  2c1453:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c145a:	8b 00                	mov    (%rax),%eax
  2c145c:	83 f8 2f             	cmp    $0x2f,%eax
  2c145f:	77 30                	ja     2c1491 <printer_vprintf+0x3d1>
  2c1461:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1468:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c146c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1473:	8b 00                	mov    (%rax),%eax
  2c1475:	89 c0                	mov    %eax,%eax
  2c1477:	48 01 d0             	add    %rdx,%rax
  2c147a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1481:	8b 12                	mov    (%rdx),%edx
  2c1483:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1486:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c148d:	89 0a                	mov    %ecx,(%rdx)
  2c148f:	eb 1a                	jmp    2c14ab <printer_vprintf+0x3eb>
  2c1491:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1498:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c149c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c14a0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c14a7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c14ab:	8b 00                	mov    (%rax),%eax
  2c14ad:	48 98                	cltq   
  2c14af:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c14b3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c14b7:	48 c1 f8 38          	sar    $0x38,%rax
  2c14bb:	25 80 00 00 00       	and    $0x80,%eax
  2c14c0:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c14c3:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c14c7:	74 09                	je     2c14d2 <printer_vprintf+0x412>
  2c14c9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c14cd:	48 f7 d8             	neg    %rax
  2c14d0:	eb 04                	jmp    2c14d6 <printer_vprintf+0x416>
  2c14d2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c14d6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c14da:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c14dd:	83 c8 60             	or     $0x60,%eax
  2c14e0:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c14e3:	e9 cf 02 00 00       	jmp    2c17b7 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c14e8:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c14ec:	74 5d                	je     2c154b <printer_vprintf+0x48b>
  2c14ee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c14f5:	8b 00                	mov    (%rax),%eax
  2c14f7:	83 f8 2f             	cmp    $0x2f,%eax
  2c14fa:	77 30                	ja     2c152c <printer_vprintf+0x46c>
  2c14fc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1503:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1507:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c150e:	8b 00                	mov    (%rax),%eax
  2c1510:	89 c0                	mov    %eax,%eax
  2c1512:	48 01 d0             	add    %rdx,%rax
  2c1515:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c151c:	8b 12                	mov    (%rdx),%edx
  2c151e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1521:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1528:	89 0a                	mov    %ecx,(%rdx)
  2c152a:	eb 1a                	jmp    2c1546 <printer_vprintf+0x486>
  2c152c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1533:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1537:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c153b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1542:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1546:	48 8b 00             	mov    (%rax),%rax
  2c1549:	eb 5c                	jmp    2c15a7 <printer_vprintf+0x4e7>
  2c154b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1552:	8b 00                	mov    (%rax),%eax
  2c1554:	83 f8 2f             	cmp    $0x2f,%eax
  2c1557:	77 30                	ja     2c1589 <printer_vprintf+0x4c9>
  2c1559:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1560:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1564:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c156b:	8b 00                	mov    (%rax),%eax
  2c156d:	89 c0                	mov    %eax,%eax
  2c156f:	48 01 d0             	add    %rdx,%rax
  2c1572:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1579:	8b 12                	mov    (%rdx),%edx
  2c157b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c157e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1585:	89 0a                	mov    %ecx,(%rdx)
  2c1587:	eb 1a                	jmp    2c15a3 <printer_vprintf+0x4e3>
  2c1589:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1590:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1594:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1598:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c159f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c15a3:	8b 00                	mov    (%rax),%eax
  2c15a5:	89 c0                	mov    %eax,%eax
  2c15a7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c15ab:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c15af:	e9 03 02 00 00       	jmp    2c17b7 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  2c15b4:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c15bb:	e9 28 ff ff ff       	jmp    2c14e8 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  2c15c0:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c15c7:	e9 1c ff ff ff       	jmp    2c14e8 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c15cc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c15d3:	8b 00                	mov    (%rax),%eax
  2c15d5:	83 f8 2f             	cmp    $0x2f,%eax
  2c15d8:	77 30                	ja     2c160a <printer_vprintf+0x54a>
  2c15da:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c15e1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c15e5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c15ec:	8b 00                	mov    (%rax),%eax
  2c15ee:	89 c0                	mov    %eax,%eax
  2c15f0:	48 01 d0             	add    %rdx,%rax
  2c15f3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c15fa:	8b 12                	mov    (%rdx),%edx
  2c15fc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c15ff:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1606:	89 0a                	mov    %ecx,(%rdx)
  2c1608:	eb 1a                	jmp    2c1624 <printer_vprintf+0x564>
  2c160a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1611:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1615:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1619:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1620:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1624:	48 8b 00             	mov    (%rax),%rax
  2c1627:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c162b:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c1632:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c1639:	e9 79 01 00 00       	jmp    2c17b7 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  2c163e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1645:	8b 00                	mov    (%rax),%eax
  2c1647:	83 f8 2f             	cmp    $0x2f,%eax
  2c164a:	77 30                	ja     2c167c <printer_vprintf+0x5bc>
  2c164c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1653:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1657:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c165e:	8b 00                	mov    (%rax),%eax
  2c1660:	89 c0                	mov    %eax,%eax
  2c1662:	48 01 d0             	add    %rdx,%rax
  2c1665:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c166c:	8b 12                	mov    (%rdx),%edx
  2c166e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1671:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1678:	89 0a                	mov    %ecx,(%rdx)
  2c167a:	eb 1a                	jmp    2c1696 <printer_vprintf+0x5d6>
  2c167c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1683:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1687:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c168b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1692:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1696:	48 8b 00             	mov    (%rax),%rax
  2c1699:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c169d:	e9 15 01 00 00       	jmp    2c17b7 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  2c16a2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c16a9:	8b 00                	mov    (%rax),%eax
  2c16ab:	83 f8 2f             	cmp    $0x2f,%eax
  2c16ae:	77 30                	ja     2c16e0 <printer_vprintf+0x620>
  2c16b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c16b7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c16bb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c16c2:	8b 00                	mov    (%rax),%eax
  2c16c4:	89 c0                	mov    %eax,%eax
  2c16c6:	48 01 d0             	add    %rdx,%rax
  2c16c9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c16d0:	8b 12                	mov    (%rdx),%edx
  2c16d2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c16d5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c16dc:	89 0a                	mov    %ecx,(%rdx)
  2c16de:	eb 1a                	jmp    2c16fa <printer_vprintf+0x63a>
  2c16e0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c16e7:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c16eb:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c16ef:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c16f6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c16fa:	8b 00                	mov    (%rax),%eax
  2c16fc:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c1702:	e9 67 03 00 00       	jmp    2c1a6e <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  2c1707:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c170b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c170f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1716:	8b 00                	mov    (%rax),%eax
  2c1718:	83 f8 2f             	cmp    $0x2f,%eax
  2c171b:	77 30                	ja     2c174d <printer_vprintf+0x68d>
  2c171d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1724:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1728:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c172f:	8b 00                	mov    (%rax),%eax
  2c1731:	89 c0                	mov    %eax,%eax
  2c1733:	48 01 d0             	add    %rdx,%rax
  2c1736:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c173d:	8b 12                	mov    (%rdx),%edx
  2c173f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1742:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1749:	89 0a                	mov    %ecx,(%rdx)
  2c174b:	eb 1a                	jmp    2c1767 <printer_vprintf+0x6a7>
  2c174d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1754:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1758:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c175c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1763:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1767:	8b 00                	mov    (%rax),%eax
  2c1769:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c176c:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c1770:	eb 45                	jmp    2c17b7 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  2c1772:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1776:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c177a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1781:	0f b6 00             	movzbl (%rax),%eax
  2c1784:	84 c0                	test   %al,%al
  2c1786:	74 0c                	je     2c1794 <printer_vprintf+0x6d4>
  2c1788:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c178f:	0f b6 00             	movzbl (%rax),%eax
  2c1792:	eb 05                	jmp    2c1799 <printer_vprintf+0x6d9>
  2c1794:	b8 25 00 00 00       	mov    $0x25,%eax
  2c1799:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c179c:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c17a0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c17a7:	0f b6 00             	movzbl (%rax),%eax
  2c17aa:	84 c0                	test   %al,%al
  2c17ac:	75 08                	jne    2c17b6 <printer_vprintf+0x6f6>
                format--;
  2c17ae:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c17b5:	01 
            }
            break;
  2c17b6:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c17b7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c17ba:	83 e0 20             	and    $0x20,%eax
  2c17bd:	85 c0                	test   %eax,%eax
  2c17bf:	74 1e                	je     2c17df <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c17c1:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c17c5:	48 83 c0 18          	add    $0x18,%rax
  2c17c9:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c17cc:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c17d0:	48 89 ce             	mov    %rcx,%rsi
  2c17d3:	48 89 c7             	mov    %rax,%rdi
  2c17d6:	e8 63 f8 ff ff       	call   2c103e <fill_numbuf>
  2c17db:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c17df:	48 c7 45 c0 76 1e 2c 	movq   $0x2c1e76,-0x40(%rbp)
  2c17e6:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c17e7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c17ea:	83 e0 20             	and    $0x20,%eax
  2c17ed:	85 c0                	test   %eax,%eax
  2c17ef:	74 48                	je     2c1839 <printer_vprintf+0x779>
  2c17f1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c17f4:	83 e0 40             	and    $0x40,%eax
  2c17f7:	85 c0                	test   %eax,%eax
  2c17f9:	74 3e                	je     2c1839 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  2c17fb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c17fe:	25 80 00 00 00       	and    $0x80,%eax
  2c1803:	85 c0                	test   %eax,%eax
  2c1805:	74 0a                	je     2c1811 <printer_vprintf+0x751>
                prefix = "-";
  2c1807:	48 c7 45 c0 77 1e 2c 	movq   $0x2c1e77,-0x40(%rbp)
  2c180e:	00 
            if (flags & FLAG_NEGATIVE) {
  2c180f:	eb 73                	jmp    2c1884 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c1811:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1814:	83 e0 10             	and    $0x10,%eax
  2c1817:	85 c0                	test   %eax,%eax
  2c1819:	74 0a                	je     2c1825 <printer_vprintf+0x765>
                prefix = "+";
  2c181b:	48 c7 45 c0 79 1e 2c 	movq   $0x2c1e79,-0x40(%rbp)
  2c1822:	00 
            if (flags & FLAG_NEGATIVE) {
  2c1823:	eb 5f                	jmp    2c1884 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c1825:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1828:	83 e0 08             	and    $0x8,%eax
  2c182b:	85 c0                	test   %eax,%eax
  2c182d:	74 55                	je     2c1884 <printer_vprintf+0x7c4>
                prefix = " ";
  2c182f:	48 c7 45 c0 7b 1e 2c 	movq   $0x2c1e7b,-0x40(%rbp)
  2c1836:	00 
            if (flags & FLAG_NEGATIVE) {
  2c1837:	eb 4b                	jmp    2c1884 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c1839:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c183c:	83 e0 20             	and    $0x20,%eax
  2c183f:	85 c0                	test   %eax,%eax
  2c1841:	74 42                	je     2c1885 <printer_vprintf+0x7c5>
  2c1843:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1846:	83 e0 01             	and    $0x1,%eax
  2c1849:	85 c0                	test   %eax,%eax
  2c184b:	74 38                	je     2c1885 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  2c184d:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c1851:	74 06                	je     2c1859 <printer_vprintf+0x799>
  2c1853:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c1857:	75 2c                	jne    2c1885 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  2c1859:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c185e:	75 0c                	jne    2c186c <printer_vprintf+0x7ac>
  2c1860:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1863:	25 00 01 00 00       	and    $0x100,%eax
  2c1868:	85 c0                	test   %eax,%eax
  2c186a:	74 19                	je     2c1885 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  2c186c:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c1870:	75 07                	jne    2c1879 <printer_vprintf+0x7b9>
  2c1872:	b8 7d 1e 2c 00       	mov    $0x2c1e7d,%eax
  2c1877:	eb 05                	jmp    2c187e <printer_vprintf+0x7be>
  2c1879:	b8 80 1e 2c 00       	mov    $0x2c1e80,%eax
  2c187e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1882:	eb 01                	jmp    2c1885 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  2c1884:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c1885:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1889:	78 24                	js     2c18af <printer_vprintf+0x7ef>
  2c188b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c188e:	83 e0 20             	and    $0x20,%eax
  2c1891:	85 c0                	test   %eax,%eax
  2c1893:	75 1a                	jne    2c18af <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  2c1895:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1898:	48 63 d0             	movslq %eax,%rdx
  2c189b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c189f:	48 89 d6             	mov    %rdx,%rsi
  2c18a2:	48 89 c7             	mov    %rax,%rdi
  2c18a5:	e8 ea f5 ff ff       	call   2c0e94 <strnlen>
  2c18aa:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c18ad:	eb 0f                	jmp    2c18be <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  2c18af:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c18b3:	48 89 c7             	mov    %rax,%rdi
  2c18b6:	e8 a8 f5 ff ff       	call   2c0e63 <strlen>
  2c18bb:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c18be:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c18c1:	83 e0 20             	and    $0x20,%eax
  2c18c4:	85 c0                	test   %eax,%eax
  2c18c6:	74 20                	je     2c18e8 <printer_vprintf+0x828>
  2c18c8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c18cc:	78 1a                	js     2c18e8 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  2c18ce:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c18d1:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c18d4:	7e 08                	jle    2c18de <printer_vprintf+0x81e>
  2c18d6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c18d9:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c18dc:	eb 05                	jmp    2c18e3 <printer_vprintf+0x823>
  2c18de:	b8 00 00 00 00       	mov    $0x0,%eax
  2c18e3:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c18e6:	eb 5c                	jmp    2c1944 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c18e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c18eb:	83 e0 20             	and    $0x20,%eax
  2c18ee:	85 c0                	test   %eax,%eax
  2c18f0:	74 4b                	je     2c193d <printer_vprintf+0x87d>
  2c18f2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c18f5:	83 e0 02             	and    $0x2,%eax
  2c18f8:	85 c0                	test   %eax,%eax
  2c18fa:	74 41                	je     2c193d <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c18fc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c18ff:	83 e0 04             	and    $0x4,%eax
  2c1902:	85 c0                	test   %eax,%eax
  2c1904:	75 37                	jne    2c193d <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  2c1906:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c190a:	48 89 c7             	mov    %rax,%rdi
  2c190d:	e8 51 f5 ff ff       	call   2c0e63 <strlen>
  2c1912:	89 c2                	mov    %eax,%edx
  2c1914:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c1917:	01 d0                	add    %edx,%eax
  2c1919:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c191c:	7e 1f                	jle    2c193d <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  2c191e:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c1921:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c1924:	89 c3                	mov    %eax,%ebx
  2c1926:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c192a:	48 89 c7             	mov    %rax,%rdi
  2c192d:	e8 31 f5 ff ff       	call   2c0e63 <strlen>
  2c1932:	89 c2                	mov    %eax,%edx
  2c1934:	89 d8                	mov    %ebx,%eax
  2c1936:	29 d0                	sub    %edx,%eax
  2c1938:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c193b:	eb 07                	jmp    2c1944 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  2c193d:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c1944:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c1947:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c194a:	01 d0                	add    %edx,%eax
  2c194c:	48 63 d8             	movslq %eax,%rbx
  2c194f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1953:	48 89 c7             	mov    %rax,%rdi
  2c1956:	e8 08 f5 ff ff       	call   2c0e63 <strlen>
  2c195b:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c195f:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c1962:	29 d0                	sub    %edx,%eax
  2c1964:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1967:	eb 25                	jmp    2c198e <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  2c1969:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1970:	48 8b 08             	mov    (%rax),%rcx
  2c1973:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1979:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1980:	be 20 00 00 00       	mov    $0x20,%esi
  2c1985:	48 89 c7             	mov    %rax,%rdi
  2c1988:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c198a:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c198e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1991:	83 e0 04             	and    $0x4,%eax
  2c1994:	85 c0                	test   %eax,%eax
  2c1996:	75 36                	jne    2c19ce <printer_vprintf+0x90e>
  2c1998:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c199c:	7f cb                	jg     2c1969 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  2c199e:	eb 2e                	jmp    2c19ce <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  2c19a0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c19a7:	4c 8b 00             	mov    (%rax),%r8
  2c19aa:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c19ae:	0f b6 00             	movzbl (%rax),%eax
  2c19b1:	0f b6 c8             	movzbl %al,%ecx
  2c19b4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c19ba:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c19c1:	89 ce                	mov    %ecx,%esi
  2c19c3:	48 89 c7             	mov    %rax,%rdi
  2c19c6:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c19c9:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c19ce:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c19d2:	0f b6 00             	movzbl (%rax),%eax
  2c19d5:	84 c0                	test   %al,%al
  2c19d7:	75 c7                	jne    2c19a0 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  2c19d9:	eb 25                	jmp    2c1a00 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  2c19db:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c19e2:	48 8b 08             	mov    (%rax),%rcx
  2c19e5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c19eb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c19f2:	be 30 00 00 00       	mov    $0x30,%esi
  2c19f7:	48 89 c7             	mov    %rax,%rdi
  2c19fa:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c19fc:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c1a00:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c1a04:	7f d5                	jg     2c19db <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  2c1a06:	eb 32                	jmp    2c1a3a <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  2c1a08:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1a0f:	4c 8b 00             	mov    (%rax),%r8
  2c1a12:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1a16:	0f b6 00             	movzbl (%rax),%eax
  2c1a19:	0f b6 c8             	movzbl %al,%ecx
  2c1a1c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1a22:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1a29:	89 ce                	mov    %ecx,%esi
  2c1a2b:	48 89 c7             	mov    %rax,%rdi
  2c1a2e:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c1a31:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c1a36:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c1a3a:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c1a3e:	7f c8                	jg     2c1a08 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  2c1a40:	eb 25                	jmp    2c1a67 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  2c1a42:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1a49:	48 8b 08             	mov    (%rax),%rcx
  2c1a4c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1a52:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1a59:	be 20 00 00 00       	mov    $0x20,%esi
  2c1a5e:	48 89 c7             	mov    %rax,%rdi
  2c1a61:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c1a63:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1a67:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1a6b:	7f d5                	jg     2c1a42 <printer_vprintf+0x982>
        }
    done: ;
  2c1a6d:	90                   	nop
    for (; *format; ++format) {
  2c1a6e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1a75:	01 
  2c1a76:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1a7d:	0f b6 00             	movzbl (%rax),%eax
  2c1a80:	84 c0                	test   %al,%al
  2c1a82:	0f 85 64 f6 ff ff    	jne    2c10ec <printer_vprintf+0x2c>
    }
}
  2c1a88:	90                   	nop
  2c1a89:	90                   	nop
  2c1a8a:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c1a8e:	c9                   	leave  
  2c1a8f:	c3                   	ret    

00000000002c1a90 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c1a90:	55                   	push   %rbp
  2c1a91:	48 89 e5             	mov    %rsp,%rbp
  2c1a94:	48 83 ec 20          	sub    $0x20,%rsp
  2c1a98:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1a9c:	89 f0                	mov    %esi,%eax
  2c1a9e:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1aa1:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c1aa4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1aa8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1aac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1ab0:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1ab4:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  2c1ab9:	48 39 d0             	cmp    %rdx,%rax
  2c1abc:	72 0c                	jb     2c1aca <console_putc+0x3a>
        cp->cursor = console;
  2c1abe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1ac2:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  2c1ac9:	00 
    }
    if (c == '\n') {
  2c1aca:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c1ace:	75 78                	jne    2c1b48 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  2c1ad0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1ad4:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1ad8:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c1ade:	48 d1 f8             	sar    %rax
  2c1ae1:	48 89 c1             	mov    %rax,%rcx
  2c1ae4:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c1aeb:	66 66 66 
  2c1aee:	48 89 c8             	mov    %rcx,%rax
  2c1af1:	48 f7 ea             	imul   %rdx
  2c1af4:	48 c1 fa 05          	sar    $0x5,%rdx
  2c1af8:	48 89 c8             	mov    %rcx,%rax
  2c1afb:	48 c1 f8 3f          	sar    $0x3f,%rax
  2c1aff:	48 29 c2             	sub    %rax,%rdx
  2c1b02:	48 89 d0             	mov    %rdx,%rax
  2c1b05:	48 c1 e0 02          	shl    $0x2,%rax
  2c1b09:	48 01 d0             	add    %rdx,%rax
  2c1b0c:	48 c1 e0 04          	shl    $0x4,%rax
  2c1b10:	48 29 c1             	sub    %rax,%rcx
  2c1b13:	48 89 ca             	mov    %rcx,%rdx
  2c1b16:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c1b19:	eb 25                	jmp    2c1b40 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  2c1b1b:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c1b1e:	83 c8 20             	or     $0x20,%eax
  2c1b21:	89 c6                	mov    %eax,%esi
  2c1b23:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1b27:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1b2b:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1b2f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1b33:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1b37:	89 f2                	mov    %esi,%edx
  2c1b39:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c1b3c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1b40:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c1b44:	75 d5                	jne    2c1b1b <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c1b46:	eb 24                	jmp    2c1b6c <console_putc+0xdc>
        *cp->cursor++ = c | color;
  2c1b48:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  2c1b4c:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1b4f:	09 d0                	or     %edx,%eax
  2c1b51:	89 c6                	mov    %eax,%esi
  2c1b53:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1b57:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1b5b:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1b5f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1b63:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1b67:	89 f2                	mov    %esi,%edx
  2c1b69:	66 89 10             	mov    %dx,(%rax)
}
  2c1b6c:	90                   	nop
  2c1b6d:	c9                   	leave  
  2c1b6e:	c3                   	ret    

00000000002c1b6f <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c1b6f:	55                   	push   %rbp
  2c1b70:	48 89 e5             	mov    %rsp,%rbp
  2c1b73:	48 83 ec 30          	sub    $0x30,%rsp
  2c1b77:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c1b7a:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c1b7d:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c1b81:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c1b85:	48 c7 45 f0 90 1a 2c 	movq   $0x2c1a90,-0x10(%rbp)
  2c1b8c:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1b8d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c1b91:	78 09                	js     2c1b9c <console_vprintf+0x2d>
  2c1b93:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c1b9a:	7e 07                	jle    2c1ba3 <console_vprintf+0x34>
        cpos = 0;
  2c1b9c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c1ba3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1ba6:	48 98                	cltq   
  2c1ba8:	48 01 c0             	add    %rax,%rax
  2c1bab:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  2c1bb1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c1bb5:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1bb9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c1bbd:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c1bc0:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c1bc4:	48 89 c7             	mov    %rax,%rdi
  2c1bc7:	e8 f4 f4 ff ff       	call   2c10c0 <printer_vprintf>
    return cp.cursor - console;
  2c1bcc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1bd0:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c1bd6:	48 d1 f8             	sar    %rax
}
  2c1bd9:	c9                   	leave  
  2c1bda:	c3                   	ret    

00000000002c1bdb <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c1bdb:	55                   	push   %rbp
  2c1bdc:	48 89 e5             	mov    %rsp,%rbp
  2c1bdf:	48 83 ec 60          	sub    $0x60,%rsp
  2c1be3:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c1be6:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c1be9:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c1bed:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1bf1:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1bf5:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1bf9:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c1c00:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1c04:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1c08:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1c0c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c1c10:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c1c14:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c1c18:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c1c1b:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c1c1e:	89 c7                	mov    %eax,%edi
  2c1c20:	e8 4a ff ff ff       	call   2c1b6f <console_vprintf>
  2c1c25:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c1c28:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c1c2b:	c9                   	leave  
  2c1c2c:	c3                   	ret    

00000000002c1c2d <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c1c2d:	55                   	push   %rbp
  2c1c2e:	48 89 e5             	mov    %rsp,%rbp
  2c1c31:	48 83 ec 20          	sub    $0x20,%rsp
  2c1c35:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1c39:	89 f0                	mov    %esi,%eax
  2c1c3b:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1c3e:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c1c41:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1c45:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c1c49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1c4d:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c1c51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1c55:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c1c59:	48 39 c2             	cmp    %rax,%rdx
  2c1c5c:	73 1a                	jae    2c1c78 <string_putc+0x4b>
        *sp->s++ = c;
  2c1c5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1c62:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1c66:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c1c6a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c1c6e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1c72:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c1c76:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c1c78:	90                   	nop
  2c1c79:	c9                   	leave  
  2c1c7a:	c3                   	ret    

00000000002c1c7b <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c1c7b:	55                   	push   %rbp
  2c1c7c:	48 89 e5             	mov    %rsp,%rbp
  2c1c7f:	48 83 ec 40          	sub    $0x40,%rsp
  2c1c83:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c1c87:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c1c8b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c1c8f:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c1c93:	48 c7 45 e8 2d 1c 2c 	movq   $0x2c1c2d,-0x18(%rbp)
  2c1c9a:	00 
    sp.s = s;
  2c1c9b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1c9f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c1ca3:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c1ca8:	74 33                	je     2c1cdd <vsnprintf+0x62>
        sp.end = s + size - 1;
  2c1caa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c1cae:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c1cb2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1cb6:	48 01 d0             	add    %rdx,%rax
  2c1cb9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c1cbd:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c1cc1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c1cc5:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c1cc9:	be 00 00 00 00       	mov    $0x0,%esi
  2c1cce:	48 89 c7             	mov    %rax,%rdi
  2c1cd1:	e8 ea f3 ff ff       	call   2c10c0 <printer_vprintf>
        *sp.s = 0;
  2c1cd6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1cda:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c1cdd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1ce1:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c1ce5:	c9                   	leave  
  2c1ce6:	c3                   	ret    

00000000002c1ce7 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c1ce7:	55                   	push   %rbp
  2c1ce8:	48 89 e5             	mov    %rsp,%rbp
  2c1ceb:	48 83 ec 70          	sub    $0x70,%rsp
  2c1cef:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c1cf3:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c1cf7:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c1cfb:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1cff:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1d03:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1d07:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c1d0e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1d12:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c1d16:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1d1a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c1d1e:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c1d22:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c1d26:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c1d2a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1d2e:	48 89 c7             	mov    %rax,%rdi
  2c1d31:	e8 45 ff ff ff       	call   2c1c7b <vsnprintf>
  2c1d36:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c1d39:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c1d3c:	c9                   	leave  
  2c1d3d:	c3                   	ret    

00000000002c1d3e <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c1d3e:	55                   	push   %rbp
  2c1d3f:	48 89 e5             	mov    %rsp,%rbp
  2c1d42:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1d46:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c1d4d:	eb 13                	jmp    2c1d62 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  2c1d4f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c1d52:	48 98                	cltq   
  2c1d54:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  2c1d5b:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1d5e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1d62:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c1d69:	7e e4                	jle    2c1d4f <console_clear+0x11>
    }
    cursorpos = 0;
  2c1d6b:	c7 05 87 72 df ff 00 	movl   $0x0,-0x208d79(%rip)        # b8ffc <cursorpos>
  2c1d72:	00 00 00 
}
  2c1d75:	90                   	nop
  2c1d76:	c9                   	leave  
  2c1d77:	c3                   	ret    
