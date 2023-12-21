
obj/p-malloc.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	53                   	push   %rbx
  100005:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100009:	cd 31                	int    $0x31
  10000b:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10000d:	b8 4f 30 10 00       	mov    $0x10304f,%eax
  100012:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100018:	48 89 05 e9 1f 00 00 	mov    %rax,0x1fe9(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10001f:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100022:	48 83 e8 01          	sub    $0x1,%rax
  100026:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10002c:	48 89 05 cd 1f 00 00 	mov    %rax,0x1fcd(%rip)        # 102000 <stack_bottom>
  100033:	eb 02                	jmp    100037 <process_main+0x37>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  100035:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  100037:	e8 09 0d 00 00       	call   100d45 <rand>
  10003c:	48 63 d0             	movslq %eax,%rdx
  10003f:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100046:	48 c1 fa 25          	sar    $0x25,%rdx
  10004a:	89 c1                	mov    %eax,%ecx
  10004c:	c1 f9 1f             	sar    $0x1f,%ecx
  10004f:	29 ca                	sub    %ecx,%edx
  100051:	6b d2 64             	imul   $0x64,%edx,%edx
  100054:	29 d0                	sub    %edx,%eax
  100056:	39 d8                	cmp    %ebx,%eax
  100058:	7d db                	jge    100035 <process_main+0x35>
	    void * ret = malloc(PAGESIZE);
  10005a:	bf 00 10 00 00       	mov    $0x1000,%edi
  10005f:	e8 2c 02 00 00       	call   100290 <malloc>
	    if(ret == NULL)
  100064:	48 85 c0             	test   %rax,%rax
  100067:	74 04                	je     10006d <process_main+0x6d>
		break;
	    *((int*)ret) = p;       // check we have write access
  100069:	89 18                	mov    %ebx,(%rax)
  10006b:	eb c8                	jmp    100035 <process_main+0x35>
  10006d:	cd 32                	int    $0x32
  10006f:	eb fc                	jmp    10006d <process_main+0x6d>

0000000000100071 <cmp_blocks_ascending>:
    remove_free_node(node_b);
}

// Comparison function for freeblocks in ascending order of address
int cmp_blocks_ascending(const void *a, const void *b){
    return (uintptr_t) (((freeblock *) a)->addr) - ((uintptr_t) ((freeblock *) b)->addr);
  100071:	48 8b 07             	mov    (%rdi),%rax
  100074:	2b 06                	sub    (%rsi),%eax
}
  100076:	c3                   	ret    

0000000000100077 <cmp_size_array_descending>:
    }
}

// Qsort comparison functions for heap_info
int cmp_size_array_descending(const void *a, const void *b) {
    return *((long *) b) - *((long *) a);
  100077:	48 8b 06             	mov    (%rsi),%rax
  10007a:	2b 07                	sub    (%rdi),%eax
}
  10007c:	c3                   	ret    

000000000010007d <cmp_ptr_array_descending>:

int cmp_ptr_array_descending(const void *a, const void *b) {
    header* header_a = (header*) ((uintptr_t) *((void **) a) - HEADER_SIZE);
    header* header_b = (header*) ((uintptr_t) *((void **) b) - HEADER_SIZE);
    return header_b->size - header_a->size;
  10007d:	48 8b 06             	mov    (%rsi),%rax
  100080:	48 8b 40 f8          	mov    -0x8(%rax),%rax
  100084:	48 8b 17             	mov    (%rdi),%rdx
  100087:	2b 42 f8             	sub    -0x8(%rdx),%eax
}
  10008a:	c3                   	ret    

000000000010008b <append_free_node>:
    block->next = NULL;
  10008b:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  100092:	00 
    block->prev = NULL;
  100093:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    if (free_head == NULL && free_tail == NULL) {
  10009a:	48 83 3d 96 1f 00 00 	cmpq   $0x0,0x1f96(%rip)        # 102038 <free_head>
  1000a1:	00 
  1000a2:	74 1d                	je     1000c1 <append_free_node+0x36>
        free_tail->next = block;
  1000a4:	48 8b 05 85 1f 00 00 	mov    0x1f85(%rip),%rax        # 102030 <free_tail>
  1000ab:	48 89 78 08          	mov    %rdi,0x8(%rax)
        block->prev = free_tail;
  1000af:	48 89 07             	mov    %rax,(%rdi)
        free_tail = block;
  1000b2:	48 89 3d 77 1f 00 00 	mov    %rdi,0x1f77(%rip)        # 102030 <free_tail>
    free_len++;
  1000b9:	83 05 68 1f 00 00 01 	addl   $0x1,0x1f68(%rip)        # 102028 <free_len>
}
  1000c0:	c3                   	ret    
    if (free_head == NULL && free_tail == NULL) {
  1000c1:	48 83 3d 67 1f 00 00 	cmpq   $0x0,0x1f67(%rip)        # 102030 <free_tail>
  1000c8:	00 
  1000c9:	75 d9                	jne    1000a4 <append_free_node+0x19>
        free_head = block;
  1000cb:	48 89 3d 66 1f 00 00 	mov    %rdi,0x1f66(%rip)        # 102038 <free_head>
        free_tail = block;
  1000d2:	eb de                	jmp    1000b2 <append_free_node+0x27>

00000000001000d4 <remove_free_node>:
    if (block == free_head) {
  1000d4:	48 39 3d 5d 1f 00 00 	cmp    %rdi,0x1f5d(%rip)        # 102038 <free_head>
  1000db:	74 30                	je     10010d <remove_free_node+0x39>
    if (block == free_tail) {
  1000dd:	48 39 3d 4c 1f 00 00 	cmp    %rdi,0x1f4c(%rip)        # 102030 <free_tail>
  1000e4:	74 34                	je     10011a <remove_free_node+0x46>
    if (block->next != NULL) {
  1000e6:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1000ea:	48 85 c0             	test   %rax,%rax
  1000ed:	74 06                	je     1000f5 <remove_free_node+0x21>
        block->next->prev = block->prev;
  1000ef:	48 8b 17             	mov    (%rdi),%rdx
  1000f2:	48 89 10             	mov    %rdx,(%rax)
    if (block->prev != NULL) {
  1000f5:	48 8b 07             	mov    (%rdi),%rax
  1000f8:	48 85 c0             	test   %rax,%rax
  1000fb:	74 08                	je     100105 <remove_free_node+0x31>
        block->prev->next = block->next;
  1000fd:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  100101:	48 89 50 08          	mov    %rdx,0x8(%rax)
    free_len--;
  100105:	83 2d 1c 1f 00 00 01 	subl   $0x1,0x1f1c(%rip)        # 102028 <free_len>
}
  10010c:	c3                   	ret    
        free_head = block->next;
  10010d:	48 8b 47 08          	mov    0x8(%rdi),%rax
  100111:	48 89 05 20 1f 00 00 	mov    %rax,0x1f20(%rip)        # 102038 <free_head>
  100118:	eb c3                	jmp    1000dd <remove_free_node+0x9>
        free_tail = block->prev;
  10011a:	48 8b 07             	mov    (%rdi),%rax
  10011d:	48 89 05 0c 1f 00 00 	mov    %rax,0x1f0c(%rip)        # 102030 <free_tail>
  100124:	eb c0                	jmp    1000e6 <remove_free_node+0x12>

0000000000100126 <append_malloc_header>:
    block->next = NULL;
  100126:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  10012d:	00 
    block->prev = NULL;
  10012e:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    if (malloc_head == NULL && malloc_tail == NULL) {
  100135:	48 83 3d e3 1e 00 00 	cmpq   $0x0,0x1ee3(%rip)        # 102020 <malloc_head>
  10013c:	00 
  10013d:	74 1d                	je     10015c <append_malloc_header+0x36>
        malloc_tail->next = block;
  10013f:	48 8b 05 d2 1e 00 00 	mov    0x1ed2(%rip),%rax        # 102018 <malloc_tail>
  100146:	48 89 78 08          	mov    %rdi,0x8(%rax)
        block->prev = malloc_tail;
  10014a:	48 89 07             	mov    %rax,(%rdi)
        malloc_tail = block;
  10014d:	48 89 3d c4 1e 00 00 	mov    %rdi,0x1ec4(%rip)        # 102018 <malloc_tail>
    malloc_len++;
  100154:	83 05 b5 1e 00 00 01 	addl   $0x1,0x1eb5(%rip)        # 102010 <malloc_len>
}
  10015b:	c3                   	ret    
    if (malloc_head == NULL && malloc_tail == NULL) {
  10015c:	48 83 3d b4 1e 00 00 	cmpq   $0x0,0x1eb4(%rip)        # 102018 <malloc_tail>
  100163:	00 
  100164:	75 d9                	jne    10013f <append_malloc_header+0x19>
        malloc_head = block;
  100166:	48 89 3d b3 1e 00 00 	mov    %rdi,0x1eb3(%rip)        # 102020 <malloc_head>
        malloc_tail = block;
  10016d:	eb de                	jmp    10014d <append_malloc_header+0x27>

000000000010016f <remove_malloc_header>:
    if (block == malloc_head) {
  10016f:	48 39 3d aa 1e 00 00 	cmp    %rdi,0x1eaa(%rip)        # 102020 <malloc_head>
  100176:	74 30                	je     1001a8 <remove_malloc_header+0x39>
    if (block == malloc_tail) {
  100178:	48 39 3d 99 1e 00 00 	cmp    %rdi,0x1e99(%rip)        # 102018 <malloc_tail>
  10017f:	74 34                	je     1001b5 <remove_malloc_header+0x46>
    if (block->next != NULL) {
  100181:	48 8b 47 08          	mov    0x8(%rdi),%rax
  100185:	48 85 c0             	test   %rax,%rax
  100188:	74 06                	je     100190 <remove_malloc_header+0x21>
        block->next->prev = block->prev;
  10018a:	48 8b 17             	mov    (%rdi),%rdx
  10018d:	48 89 10             	mov    %rdx,(%rax)
    if (block->prev != NULL) {
  100190:	48 8b 07             	mov    (%rdi),%rax
  100193:	48 85 c0             	test   %rax,%rax
  100196:	74 08                	je     1001a0 <remove_malloc_header+0x31>
        block->prev->next = block->next;
  100198:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10019c:	48 89 50 08          	mov    %rdx,0x8(%rax)
    malloc_len--;
  1001a0:	83 2d 69 1e 00 00 01 	subl   $0x1,0x1e69(%rip)        # 102010 <malloc_len>
}
  1001a7:	c3                   	ret    
        malloc_head = block->next;
  1001a8:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1001ac:	48 89 05 6d 1e 00 00 	mov    %rax,0x1e6d(%rip)        # 102020 <malloc_head>
  1001b3:	eb c3                	jmp    100178 <remove_malloc_header+0x9>
        malloc_tail = block->prev;
  1001b5:	48 8b 07             	mov    (%rdi),%rax
  1001b8:	48 89 05 59 1e 00 00 	mov    %rax,0x1e59(%rip)        # 102018 <malloc_tail>
  1001bf:	eb c0                	jmp    100181 <remove_malloc_header+0x12>

00000000001001c1 <get_free_block>:
    node* current_node = free_head;
  1001c1:	48 8b 05 70 1e 00 00 	mov    0x1e70(%rip),%rax        # 102038 <free_head>
    while (current_node != NULL) {
  1001c8:	48 85 c0             	test   %rax,%rax
  1001cb:	74 13                	je     1001e0 <get_free_block+0x1f>
        if (current_node->size >= HEADER_SIZE + size)
  1001cd:	48 83 c7 18          	add    $0x18,%rdi
  1001d1:	48 39 78 10          	cmp    %rdi,0x10(%rax)
  1001d5:	73 09                	jae    1001e0 <get_free_block+0x1f>
        current_node = current_node->next;
  1001d7:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (current_node != NULL) {
  1001db:	48 85 c0             	test   %rax,%rax
  1001de:	75 f1                	jne    1001d1 <get_free_block+0x10>
}
  1001e0:	c3                   	ret    

00000000001001e1 <allocate_block>:
uintptr_t allocate_block(uint64_t size) {
  1001e1:	55                   	push   %rbp
  1001e2:	48 89 e5             	mov    %rsp,%rbp
  1001e5:	41 55                	push   %r13
  1001e7:	41 54                	push   %r12
  1001e9:	53                   	push   %rbx
  1001ea:	48 83 ec 08          	sub    $0x8,%rsp
  1001ee:	48 89 fb             	mov    %rdi,%rbx
    node* free_block = get_free_block(size);
  1001f1:	e8 cb ff ff ff       	call   1001c1 <get_free_block>
    if (free_block == NULL)
  1001f6:	48 85 c0             	test   %rax,%rax
  1001f9:	74 5a                	je     100255 <allocate_block+0x74>
  1001fb:	49 89 c4             	mov    %rax,%r12
    remove_free_node(free_block);
  1001fe:	48 89 c7             	mov    %rax,%rdi
  100201:	e8 ce fe ff ff       	call   1000d4 <remove_free_node>
    uintptr_t free_block_addr = (uintptr_t) free_block;
  100206:	4d 89 e5             	mov    %r12,%r13
    uint64_t free_block_size = free_block->size;
  100209:	49 8b 44 24 10       	mov    0x10(%r12),%rax
    uint64_t payload_size = ROUNDUP(size, ALIGNMENT);
  10020e:	48 8d 7b 07          	lea    0x7(%rbx),%rdi
  100212:	48 83 e7 f8          	and    $0xfffffffffffffff8,%rdi
    new_header->size = payload_size;
  100216:	49 89 7c 24 10       	mov    %rdi,0x10(%r12)
    uint64_t malloc_block_size = HEADER_SIZE + payload_size;
  10021b:	48 8d 57 18          	lea    0x18(%rdi),%rdx
    uint64_t leftover_size = free_block_size - malloc_block_size;
  10021f:	48 29 d0             	sub    %rdx,%rax
    if (leftover_size < NODE_SIZE) {
  100222:	48 83 f8 17          	cmp    $0x17,%rax
  100226:	77 1e                	ja     100246 <allocate_block+0x65>
        new_header->size += leftover_size;
  100228:	48 01 c7             	add    %rax,%rdi
  10022b:	49 89 7c 24 10       	mov    %rdi,0x10(%r12)
    append_malloc_header(new_header);
  100230:	4c 89 e7             	mov    %r12,%rdi
  100233:	e8 ee fe ff ff       	call   100126 <append_malloc_header>
}
  100238:	4c 89 e8             	mov    %r13,%rax
  10023b:	48 83 c4 08          	add    $0x8,%rsp
  10023f:	5b                   	pop    %rbx
  100240:	41 5c                	pop    %r12
  100242:	41 5d                	pop    %r13
  100244:	5d                   	pop    %rbp
  100245:	c3                   	ret    
        node* new_free_node = (node*) (free_block_addr + malloc_block_size);
  100246:	49 8d 3c 14          	lea    (%r12,%rdx,1),%rdi
        new_free_node->size = leftover_size;
  10024a:	48 89 47 10          	mov    %rax,0x10(%rdi)
        append_free_node(new_free_node);
  10024e:	e8 38 fe ff ff       	call   10008b <append_free_node>
  100253:	eb db                	jmp    100230 <allocate_block+0x4f>
        return (uintptr_t) -1;
  100255:	49 c7 c5 ff ff ff ff 	mov    $0xffffffffffffffff,%r13
  10025c:	eb da                	jmp    100238 <allocate_block+0x57>

000000000010025e <free>:
    if (firstbyte == NULL)
  10025e:	48 85 ff             	test   %rdi,%rdi
  100261:	74 2c                	je     10028f <free+0x31>
void free(void *firstbyte) {
  100263:	55                   	push   %rbp
  100264:	48 89 e5             	mov    %rsp,%rbp
  100267:	41 54                	push   %r12
  100269:	53                   	push   %rbx
    uintptr_t addr = (uintptr_t) firstbyte - HEADER_SIZE;
  10026a:	48 8d 5f e8          	lea    -0x18(%rdi),%rbx
    uint64_t block_size = malloc_header->size + HEADER_SIZE;
  10026e:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  100272:	4c 8d 60 18          	lea    0x18(%rax),%r12
    remove_malloc_header(malloc_header);
  100276:	48 89 df             	mov    %rbx,%rdi
  100279:	e8 f1 fe ff ff       	call   10016f <remove_malloc_header>
    free_block->size = block_size;
  10027e:	4c 89 63 10          	mov    %r12,0x10(%rbx)
    append_free_node(free_block);
  100282:	48 89 df             	mov    %rbx,%rdi
  100285:	e8 01 fe ff ff       	call   10008b <append_free_node>
}
  10028a:	5b                   	pop    %rbx
  10028b:	41 5c                	pop    %r12
  10028d:	5d                   	pop    %rbp
  10028e:	c3                   	ret    
  10028f:	c3                   	ret    

0000000000100290 <malloc>:
        return NULL;
  100290:	b8 00 00 00 00       	mov    $0x0,%eax
    if (numbytes == 0) 
  100295:	48 85 ff             	test   %rdi,%rdi
  100298:	74 70                	je     10030a <malloc+0x7a>
void * malloc(uint64_t numbytes) {
  10029a:	55                   	push   %rbp
  10029b:	48 89 e5             	mov    %rsp,%rbp
  10029e:	53                   	push   %rbx
  10029f:	48 83 ec 08          	sub    $0x8,%rsp
  1002a3:	48 89 fb             	mov    %rdi,%rbx
    uintptr_t addr = allocate_block(numbytes);
  1002a6:	e8 36 ff ff ff       	call   1001e1 <allocate_block>
    if (addr == (uintptr_t) -1) {
  1002ab:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1002af:	74 0a                	je     1002bb <malloc+0x2b>
    return (void *) (addr + HEADER_SIZE);
  1002b1:	48 83 c0 18          	add    $0x18,%rax
}
  1002b5:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1002b9:	c9                   	leave  
  1002ba:	c3                   	ret    
        intptr_t increment = ROUNDUP(numbytes, PAGESIZE*10);
  1002bb:	48 8d 93 ff 9f 00 00 	lea    0x9fff(%rbx),%rdx
  1002c2:	48 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rcx
  1002c9:	cc cc cc 
  1002cc:	48 89 d0             	mov    %rdx,%rax
  1002cf:	48 f7 e1             	mul    %rcx
  1002d2:	48 c1 ea 0f          	shr    $0xf,%rdx
  1002d6:	48 8d 3c 92          	lea    (%rdx,%rdx,4),%rdi
  1002da:	48 c1 e7 0d          	shl    $0xd,%rdi
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  1002de:	cd 3a                	int    $0x3a
  1002e0:	48 89 05 59 1d 00 00 	mov    %rax,0x1d59(%rip)        # 102040 <result.0>
        if (block_addr == (void*) -1)
  1002e7:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1002eb:	74 16                	je     100303 <malloc+0x73>
        new_free_node->size = increment;
  1002ed:	48 89 78 10          	mov    %rdi,0x10(%rax)
        append_free_node(new_free_node);
  1002f1:	48 89 c7             	mov    %rax,%rdi
  1002f4:	e8 92 fd ff ff       	call   10008b <append_free_node>
        addr = allocate_block(numbytes);
  1002f9:	48 89 df             	mov    %rbx,%rdi
  1002fc:	e8 e0 fe ff ff       	call   1001e1 <allocate_block>
  100301:	eb ae                	jmp    1002b1 <malloc+0x21>
            return NULL;
  100303:	b8 00 00 00 00       	mov    $0x0,%eax
  100308:	eb ab                	jmp    1002b5 <malloc+0x25>
}
  10030a:	c3                   	ret    

000000000010030b <calloc>:
void * calloc(uint64_t num, uint64_t sz) {
  10030b:	55                   	push   %rbp
  10030c:	48 89 e5             	mov    %rsp,%rbp
  10030f:	41 54                	push   %r12
  100311:	53                   	push   %rbx
    uint64_t total_size = num*sz;
  100312:	48 89 fb             	mov    %rdi,%rbx
  100315:	48 0f af de          	imul   %rsi,%rbx
    if (total_size == 0 || num * sz / num != sz || num * sz / sz != num) // Check for overflow
  100319:	48 85 db             	test   %rbx,%rbx
  10031c:	74 56                	je     100374 <calloc+0x69>
  10031e:	48 89 d8             	mov    %rbx,%rax
  100321:	ba 00 00 00 00       	mov    $0x0,%edx
  100326:	48 f7 f7             	div    %rdi
        return NULL;
  100329:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    if (total_size == 0 || num * sz / num != sz || num * sz / sz != num) // Check for overflow
  10032f:	48 39 f0             	cmp    %rsi,%rax
  100332:	75 38                	jne    10036c <calloc+0x61>
  100334:	48 89 d8             	mov    %rbx,%rax
  100337:	ba 00 00 00 00       	mov    $0x0,%edx
  10033c:	48 f7 f6             	div    %rsi
  10033f:	48 39 f8             	cmp    %rdi,%rax
  100342:	75 28                	jne    10036c <calloc+0x61>
    uint64_t numbytes = ROUNDUP(total_size, ALIGNMENT);
  100344:	48 83 c3 07          	add    $0x7,%rbx
  100348:	48 83 e3 f8          	and    $0xfffffffffffffff8,%rbx
    void* addr = malloc(numbytes);
  10034c:	48 89 df             	mov    %rbx,%rdi
  10034f:	e8 3c ff ff ff       	call   100290 <malloc>
  100354:	49 89 c4             	mov    %rax,%r12
    if (addr == NULL)
  100357:	48 85 c0             	test   %rax,%rax
  10035a:	74 10                	je     10036c <calloc+0x61>
    memset(addr, 0, numbytes);
  10035c:	48 89 da             	mov    %rbx,%rdx
  10035f:	be 00 00 00 00       	mov    $0x0,%esi
  100364:	48 89 c7             	mov    %rax,%rdi
  100367:	e8 1c 08 00 00       	call   100b88 <memset>
}
  10036c:	4c 89 e0             	mov    %r12,%rax
  10036f:	5b                   	pop    %rbx
  100370:	41 5c                	pop    %r12
  100372:	5d                   	pop    %rbp
  100373:	c3                   	ret    
        return NULL;
  100374:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  10037a:	eb f0                	jmp    10036c <calloc+0x61>

000000000010037c <realloc>:
void * realloc(void * ptr, uint64_t sz) {
  10037c:	55                   	push   %rbp
  10037d:	48 89 e5             	mov    %rsp,%rbp
  100380:	41 54                	push   %r12
  100382:	53                   	push   %rbx
    if (ptr == NULL) {
  100383:	48 85 ff             	test   %rdi,%rdi
  100386:	74 40                	je     1003c8 <realloc+0x4c>
  100388:	48 89 fb             	mov    %rdi,%rbx
    if (sz == 0) {
  10038b:	48 85 f6             	test   %rsi,%rsi
  10038e:	74 45                	je     1003d5 <realloc+0x59>
        return ptr;
  100390:	49 89 fc             	mov    %rdi,%r12
    if (old_header->size == sz)
  100393:	48 39 77 f8          	cmp    %rsi,-0x8(%rdi)
  100397:	74 27                	je     1003c0 <realloc+0x44>
    void* realloc_addr = malloc(sz);
  100399:	48 89 f7             	mov    %rsi,%rdi
  10039c:	e8 ef fe ff ff       	call   100290 <malloc>
  1003a1:	49 89 c4             	mov    %rax,%r12
    if (realloc_addr == NULL)
  1003a4:	48 85 c0             	test   %rax,%rax
  1003a7:	74 17                	je     1003c0 <realloc+0x44>
    memcpy(realloc_addr, ptr, realloc_header->size);
  1003a9:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
  1003ad:	48 89 de             	mov    %rbx,%rsi
  1003b0:	48 89 c7             	mov    %rax,%rdi
  1003b3:	e8 d2 06 00 00       	call   100a8a <memcpy>
    free(ptr);
  1003b8:	48 89 df             	mov    %rbx,%rdi
  1003bb:	e8 9e fe ff ff       	call   10025e <free>
}
  1003c0:	4c 89 e0             	mov    %r12,%rax
  1003c3:	5b                   	pop    %rbx
  1003c4:	41 5c                	pop    %r12
  1003c6:	5d                   	pop    %rbp
  1003c7:	c3                   	ret    
        return malloc(sz);
  1003c8:	48 89 f7             	mov    %rsi,%rdi
  1003cb:	e8 c0 fe ff ff       	call   100290 <malloc>
  1003d0:	49 89 c4             	mov    %rax,%r12
  1003d3:	eb eb                	jmp    1003c0 <realloc+0x44>
        free(ptr);
  1003d5:	e8 84 fe ff ff       	call   10025e <free>
        return NULL;
  1003da:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  1003e0:	eb de                	jmp    1003c0 <realloc+0x44>

00000000001003e2 <quicksort>:
  if (total_elems == 0)
  1003e2:	48 85 f6             	test   %rsi,%rsi
  1003e5:	0f 84 5f 04 00 00    	je     10084a <quicksort+0x468>
{
  1003eb:	55                   	push   %rbp
  1003ec:	48 89 e5             	mov    %rsp,%rbp
  1003ef:	41 57                	push   %r15
  1003f1:	41 56                	push   %r14
  1003f3:	41 55                	push   %r13
  1003f5:	41 54                	push   %r12
  1003f7:	53                   	push   %rbx
  1003f8:	48 81 ec 48 04 00 00 	sub    $0x448,%rsp
  1003ff:	49 89 f5             	mov    %rsi,%r13
  100402:	49 89 d7             	mov    %rdx,%r15
  100405:	49 89 cc             	mov    %rcx,%r12
  const size_t max_thresh = MAX_THRESH * size;
  100408:	48 8d 0c 95 00 00 00 	lea    0x0(,%rdx,4),%rcx
  10040f:	00 
  if (total_elems > MAX_THRESH)
  100410:	48 83 fe 04          	cmp    $0x4,%rsi
  100414:	0f 86 0a 03 00 00    	jbe    100724 <quicksort+0x342>
      char *hi = &lo[size * (total_elems - 1)];
  10041a:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
  10041e:	48 0f af c2          	imul   %rdx,%rax
  100422:	48 01 f8             	add    %rdi,%rax
  100425:	48 89 85 c0 fb ff ff 	mov    %rax,-0x440(%rbp)
      PUSH (NULL, NULL);
  10042c:	48 c7 85 d0 fb ff ff 	movq   $0x0,-0x430(%rbp)
  100433:	00 00 00 00 
  100437:	48 c7 85 d8 fb ff ff 	movq   $0x0,-0x428(%rbp)
  10043e:	00 00 00 00 
      char *lo = base_ptr;
  100442:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
      PUSH (NULL, NULL);
  100449:	48 8d 85 e0 fb ff ff 	lea    -0x420(%rbp),%rax
  100450:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
      right_ptr = hi - size;
  100457:	49 89 d6             	mov    %rdx,%r14
  10045a:	49 f7 de             	neg    %r14
  10045d:	48 89 8d a8 fb ff ff 	mov    %rcx,-0x458(%rbp)
  100464:	48 89 bd a0 fb ff ff 	mov    %rdi,-0x460(%rbp)
  10046b:	48 89 b5 98 fb ff ff 	mov    %rsi,-0x468(%rbp)
  100472:	48 89 95 c8 fb ff ff 	mov    %rdx,-0x438(%rbp)
  100479:	e9 9b 01 00 00       	jmp    100619 <quicksort+0x237>
  10047e:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100485:	49 8d 7c 05 00       	lea    0x0(%r13,%rax,1),%rdi
      if ((*cmp) ((void *) mid, (void *) lo) < 0)
  10048a:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
        SWAP (mid, lo, size);
  100491:	4c 89 e8             	mov    %r13,%rax
  100494:	0f b6 08             	movzbl (%rax),%ecx
  100497:	48 83 c0 01          	add    $0x1,%rax
  10049b:	0f b6 32             	movzbl (%rdx),%esi
  10049e:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  1004a2:	48 83 c2 01          	add    $0x1,%rdx
  1004a6:	88 4a ff             	mov    %cl,-0x1(%rdx)
  1004a9:	48 39 c7             	cmp    %rax,%rdi
  1004ac:	75 e6                	jne    100494 <quicksort+0xb2>
  1004ae:	e9 a2 01 00 00       	jmp    100655 <quicksort+0x273>
  1004b3:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  1004ba:	49 8d 5c 05 00       	lea    0x0(%r13,%rax,1),%rbx
      if ((*cmp) ((void *) hi, (void *) mid) < 0)
  1004bf:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
        SWAP (mid, hi, size);
  1004c6:	4c 89 e8             	mov    %r13,%rax
  1004c9:	0f b6 08             	movzbl (%rax),%ecx
  1004cc:	48 83 c0 01          	add    $0x1,%rax
  1004d0:	0f b6 32             	movzbl (%rdx),%esi
  1004d3:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  1004d7:	48 83 c2 01          	add    $0x1,%rdx
  1004db:	88 4a ff             	mov    %cl,-0x1(%rdx)
  1004de:	48 39 c3             	cmp    %rax,%rbx
  1004e1:	75 e6                	jne    1004c9 <quicksort+0xe7>
      if ((*cmp) ((void *) mid, (void *) lo) < 0)
  1004e3:	48 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%rsi
  1004ea:	4c 89 ef             	mov    %r13,%rdi
  1004ed:	41 ff d4             	call   *%r12
  1004f0:	85 c0                	test   %eax,%eax
  1004f2:	0f 89 72 01 00 00    	jns    10066a <quicksort+0x288>
  1004f8:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
        SWAP (mid, lo, size);
  1004ff:	4c 89 e8             	mov    %r13,%rax
  100502:	0f b6 08             	movzbl (%rax),%ecx
  100505:	48 83 c0 01          	add    $0x1,%rax
  100509:	0f b6 32             	movzbl (%rdx),%esi
  10050c:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  100510:	48 83 c2 01          	add    $0x1,%rdx
  100514:	88 4a ff             	mov    %cl,-0x1(%rdx)
  100517:	48 39 c3             	cmp    %rax,%rbx
  10051a:	75 e6                	jne    100502 <quicksort+0x120>
    jump_over:;
  10051c:	e9 49 01 00 00       	jmp    10066a <quicksort+0x288>
        right_ptr -= size;
  100521:	4c 01 f3             	add    %r14,%rbx
          while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
  100524:	48 89 de             	mov    %rbx,%rsi
  100527:	4c 89 ef             	mov    %r13,%rdi
  10052a:	41 ff d4             	call   *%r12
  10052d:	85 c0                	test   %eax,%eax
  10052f:	78 f0                	js     100521 <quicksort+0x13f>
          if (left_ptr < right_ptr)
  100531:	49 39 df             	cmp    %rbx,%r15
  100534:	72 20                	jb     100556 <quicksort+0x174>
          else if (left_ptr == right_ptr)
  100536:	74 62                	je     10059a <quicksort+0x1b8>
      while (left_ptr <= right_ptr);
  100538:	4c 39 fb             	cmp    %r15,%rbx
  10053b:	72 6a                	jb     1005a7 <quicksort+0x1c5>
          while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
  10053d:	4c 89 ee             	mov    %r13,%rsi
  100540:	4c 89 ff             	mov    %r15,%rdi
  100543:	41 ff d4             	call   *%r12
  100546:	85 c0                	test   %eax,%eax
  100548:	79 da                	jns    100524 <quicksort+0x142>
        left_ptr += size;
  10054a:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100551:	49 01 c7             	add    %rax,%r15
  100554:	eb e7                	jmp    10053d <quicksort+0x15b>
  100556:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  10055d:	49 8d 3c 07          	lea    (%r15,%rax,1),%rdi
          if (left_ptr < right_ptr)
  100561:	48 89 da             	mov    %rbx,%rdx
  100564:	4c 89 f8             	mov    %r15,%rax
          SWAP (left_ptr, right_ptr, size);
  100567:	0f b6 08             	movzbl (%rax),%ecx
  10056a:	48 83 c0 01          	add    $0x1,%rax
  10056e:	0f b6 32             	movzbl (%rdx),%esi
  100571:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  100575:	48 83 c2 01          	add    $0x1,%rdx
  100579:	88 4a ff             	mov    %cl,-0x1(%rdx)
  10057c:	48 39 f8             	cmp    %rdi,%rax
  10057f:	75 e6                	jne    100567 <quicksort+0x185>
          if (mid == left_ptr)
  100581:	4d 39 ef             	cmp    %r13,%r15
  100584:	74 0f                	je     100595 <quicksort+0x1b3>
          else if (mid == right_ptr)
  100586:	4c 39 eb             	cmp    %r13,%rbx
  100589:	4d 0f 44 ef          	cmove  %r15,%r13
          right_ptr -= size;
  10058d:	4c 01 f3             	add    %r14,%rbx
          left_ptr += size;
  100590:	49 89 ff             	mov    %rdi,%r15
  100593:	eb a3                	jmp    100538 <quicksort+0x156>
  100595:	49 89 dd             	mov    %rbx,%r13
  100598:	eb f3                	jmp    10058d <quicksort+0x1ab>
          left_ptr += size;
  10059a:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  1005a1:	49 01 c7             	add    %rax,%r15
          right_ptr -= size;
  1005a4:	4c 01 f3             	add    %r14,%rbx
          if ((size_t) (right_ptr - lo) <= max_thresh)
  1005a7:	48 89 d8             	mov    %rbx,%rax
  1005aa:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
  1005b1:	48 29 d0             	sub    %rdx,%rax
  1005b4:	48 8b bd a8 fb ff ff 	mov    -0x458(%rbp),%rdi
  1005bb:	48 39 c7             	cmp    %rax,%rdi
  1005be:	0f 82 c8 00 00 00    	jb     10068c <quicksort+0x2aa>
              if ((size_t) (hi - left_ptr) <= max_thresh)
  1005c4:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  1005cb:	4c 29 f8             	sub    %r15,%rax
                lo = left_ptr;
  1005ce:	4c 89 bd b8 fb ff ff 	mov    %r15,-0x448(%rbp)
              if ((size_t) (hi - left_ptr) <= max_thresh)
  1005d5:	48 39 c7             	cmp    %rax,%rdi
  1005d8:	72 28                	jb     100602 <quicksort+0x220>
                POP (lo, hi);
  1005da:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  1005e1:	48 8b 78 f0          	mov    -0x10(%rax),%rdi
  1005e5:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
  1005ec:	48 8b 78 f8          	mov    -0x8(%rax),%rdi
  1005f0:	48 89 bd c0 fb ff ff 	mov    %rdi,-0x440(%rbp)
  1005f7:	48 8d 40 f0          	lea    -0x10(%rax),%rax
  1005fb:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
      while (STACK_NOT_EMPTY)
  100602:	48 8d 85 d0 fb ff ff 	lea    -0x430(%rbp),%rax
  100609:	48 8b bd b0 fb ff ff 	mov    -0x450(%rbp),%rdi
  100610:	48 39 f8             	cmp    %rdi,%rax
  100613:	0f 83 ef 00 00 00    	jae    100708 <quicksort+0x326>
      char *mid = lo + size * ((hi - lo) / size >> 1);
  100619:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  100620:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  100627:	48 29 f8             	sub    %rdi,%rax
  10062a:	48 8b 8d c8 fb ff ff 	mov    -0x438(%rbp),%rcx
  100631:	ba 00 00 00 00       	mov    $0x0,%edx
  100636:	48 f7 f1             	div    %rcx
  100639:	48 d1 e8             	shr    %rax
  10063c:	48 0f af c1          	imul   %rcx,%rax
  100640:	4c 8d 2c 07          	lea    (%rdi,%rax,1),%r13
      if ((*cmp) ((void *) mid, (void *) lo) < 0)
  100644:	48 89 fe             	mov    %rdi,%rsi
  100647:	4c 89 ef             	mov    %r13,%rdi
  10064a:	41 ff d4             	call   *%r12
  10064d:	85 c0                	test   %eax,%eax
  10064f:	0f 88 29 fe ff ff    	js     10047e <quicksort+0x9c>
      if ((*cmp) ((void *) hi, (void *) mid) < 0)
  100655:	4c 89 ee             	mov    %r13,%rsi
  100658:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  10065f:	41 ff d4             	call   *%r12
  100662:	85 c0                	test   %eax,%eax
  100664:	0f 88 49 fe ff ff    	js     1004b3 <quicksort+0xd1>
      left_ptr  = lo + size;
  10066a:	48 8b 85 b8 fb ff ff 	mov    -0x448(%rbp),%rax
  100671:	48 8b 95 c8 fb ff ff 	mov    -0x438(%rbp),%rdx
  100678:	4c 8d 3c 10          	lea    (%rax,%rdx,1),%r15
      right_ptr = hi - size;
  10067c:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  100683:	4a 8d 1c 30          	lea    (%rax,%r14,1),%rbx
  100687:	e9 b1 fe ff ff       	jmp    10053d <quicksort+0x15b>
          else if ((size_t) (hi - left_ptr) <= max_thresh)
  10068c:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
  100693:	4c 29 fa             	sub    %r15,%rdx
  100696:	48 39 95 a8 fb ff ff 	cmp    %rdx,-0x458(%rbp)
  10069d:	73 5d                	jae    1006fc <quicksort+0x31a>
          else if ((right_ptr - lo) > (hi - left_ptr))
  10069f:	48 39 d0             	cmp    %rdx,%rax
  1006a2:	7e 2c                	jle    1006d0 <quicksort+0x2ee>
              PUSH (lo, right_ptr);
  1006a4:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  1006ab:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  1006b2:	48 89 38             	mov    %rdi,(%rax)
  1006b5:	48 89 58 08          	mov    %rbx,0x8(%rax)
  1006b9:	48 83 c0 10          	add    $0x10,%rax
  1006bd:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
              lo = left_ptr;
  1006c4:	4c 89 bd b8 fb ff ff 	mov    %r15,-0x448(%rbp)
  1006cb:	e9 32 ff ff ff       	jmp    100602 <quicksort+0x220>
              PUSH (left_ptr, hi);
  1006d0:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  1006d7:	4c 89 38             	mov    %r15,(%rax)
  1006da:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  1006e1:	48 89 78 08          	mov    %rdi,0x8(%rax)
  1006e5:	48 83 c0 10          	add    $0x10,%rax
  1006e9:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
              hi = right_ptr;
  1006f0:	48 89 9d c0 fb ff ff 	mov    %rbx,-0x440(%rbp)
  1006f7:	e9 06 ff ff ff       	jmp    100602 <quicksort+0x220>
            hi = right_ptr;
  1006fc:	48 89 9d c0 fb ff ff 	mov    %rbx,-0x440(%rbp)
  100703:	e9 fa fe ff ff       	jmp    100602 <quicksort+0x220>
  100708:	48 8b 8d a8 fb ff ff 	mov    -0x458(%rbp),%rcx
  10070f:	48 8b bd a0 fb ff ff 	mov    -0x460(%rbp),%rdi
  100716:	4c 8b ad 98 fb ff ff 	mov    -0x468(%rbp),%r13
  10071d:	4c 8b bd c8 fb ff ff 	mov    -0x438(%rbp),%r15
    char *const end_ptr = &base_ptr[size * (total_elems - 1)];
  100724:	49 8d 45 ff          	lea    -0x1(%r13),%rax
  100728:	49 0f af c7          	imul   %r15,%rax
  10072c:	48 8d 14 07          	lea    (%rdi,%rax,1),%rdx
  100730:	48 89 95 c8 fb ff ff 	mov    %rdx,-0x438(%rbp)
    char *thresh = min(end_ptr, base_ptr + max_thresh);
  100737:	48 8d 04 0f          	lea    (%rdi,%rcx,1),%rax
  10073b:	48 39 c2             	cmp    %rax,%rdx
  10073e:	48 0f 46 c2          	cmovbe %rdx,%rax
    for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  100742:	4a 8d 1c 3f          	lea    (%rdi,%r15,1),%rbx
  100746:	48 39 d8             	cmp    %rbx,%rax
  100749:	72 62                	jb     1007ad <quicksort+0x3cb>
  10074b:	49 89 de             	mov    %rbx,%r14
    char *tmp_ptr = base_ptr;
  10074e:	49 89 fd             	mov    %rdi,%r13
  100751:	48 89 9d c0 fb ff ff 	mov    %rbx,-0x440(%rbp)
  100758:	48 89 c3             	mov    %rax,%rbx
  10075b:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
      if ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  100762:	4c 89 ee             	mov    %r13,%rsi
  100765:	4c 89 f7             	mov    %r14,%rdi
  100768:	41 ff d4             	call   *%r12
  10076b:	85 c0                	test   %eax,%eax
  10076d:	4d 0f 48 ee          	cmovs  %r14,%r13
    for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  100771:	4d 01 fe             	add    %r15,%r14
  100774:	4c 39 f3             	cmp    %r14,%rbx
  100777:	73 e9                	jae    100762 <quicksort+0x380>
  100779:	48 8b 9d c0 fb ff ff 	mov    -0x440(%rbp),%rbx
  100780:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
    if (tmp_ptr != base_ptr)
  100787:	4b 8d 4c 3d 00       	lea    0x0(%r13,%r15,1),%rcx
  10078c:	49 39 fd             	cmp    %rdi,%r13
  10078f:	74 1c                	je     1007ad <quicksort+0x3cb>
      SWAP (tmp_ptr, base_ptr, size);
  100791:	41 0f b6 45 00       	movzbl 0x0(%r13),%eax
  100796:	49 83 c5 01          	add    $0x1,%r13
  10079a:	0f b6 17             	movzbl (%rdi),%edx
  10079d:	41 88 55 ff          	mov    %dl,-0x1(%r13)
  1007a1:	48 83 c7 01          	add    $0x1,%rdi
  1007a5:	88 47 ff             	mov    %al,-0x1(%rdi)
  1007a8:	49 39 cd             	cmp    %rcx,%r13
  1007ab:	75 e4                	jne    100791 <quicksort+0x3af>
    while ((run_ptr += size) <= end_ptr)
  1007ad:	4e 8d 34 3b          	lea    (%rbx,%r15,1),%r14
    tmp_ptr = run_ptr - size;
  1007b1:	4d 89 fd             	mov    %r15,%r13
  1007b4:	49 f7 dd             	neg    %r13
    while ((run_ptr += size) <= end_ptr)
  1007b7:	4c 39 b5 c8 fb ff ff 	cmp    %r14,-0x438(%rbp)
  1007be:	73 15                	jae    1007d5 <quicksort+0x3f3>
}
  1007c0:	48 81 c4 48 04 00 00 	add    $0x448,%rsp
  1007c7:	5b                   	pop    %rbx
  1007c8:	41 5c                	pop    %r12
  1007ca:	41 5d                	pop    %r13
  1007cc:	41 5e                	pop    %r14
  1007ce:	41 5f                	pop    %r15
  1007d0:	5d                   	pop    %rbp
  1007d1:	c3                   	ret    
      tmp_ptr -= size;
  1007d2:	4c 01 eb             	add    %r13,%rbx
    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  1007d5:	48 89 de             	mov    %rbx,%rsi
  1007d8:	4c 89 f7             	mov    %r14,%rdi
  1007db:	41 ff d4             	call   *%r12
  1007de:	85 c0                	test   %eax,%eax
  1007e0:	78 f0                	js     1007d2 <quicksort+0x3f0>
    tmp_ptr += size;
  1007e2:	4a 8d 34 3b          	lea    (%rbx,%r15,1),%rsi
        if (tmp_ptr != run_ptr)
  1007e6:	4c 39 f6             	cmp    %r14,%rsi
  1007e9:	75 15                	jne    100800 <quicksort+0x41e>
    while ((run_ptr += size) <= end_ptr)
  1007eb:	4b 8d 04 3e          	lea    (%r14,%r15,1),%rax
  1007ef:	4c 89 f3             	mov    %r14,%rbx
  1007f2:	48 39 85 c8 fb ff ff 	cmp    %rax,-0x438(%rbp)
  1007f9:	72 c5                	jb     1007c0 <quicksort+0x3de>
  1007fb:	49 89 c6             	mov    %rax,%r14
    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  1007fe:	eb d5                	jmp    1007d5 <quicksort+0x3f3>
        while (--trav >= run_ptr)
  100800:	4b 8d 7c 3e ff       	lea    -0x1(%r14,%r15,1),%rdi
  100805:	4c 39 f7             	cmp    %r14,%rdi
  100808:	72 e1                	jb     1007eb <quicksort+0x409>
  10080a:	4d 8d 46 ff          	lea    -0x1(%r14),%r8
  10080e:	4d 89 c2             	mov    %r8,%r10
  100811:	eb 13                	jmp    100826 <quicksort+0x444>
                for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  100813:	48 89 f9             	mov    %rdi,%rcx
                *hi = c;
  100816:	44 88 09             	mov    %r9b,(%rcx)
        while (--trav >= run_ptr)
  100819:	48 83 ef 01          	sub    $0x1,%rdi
  10081d:	49 83 e8 01          	sub    $0x1,%r8
  100821:	49 39 fa             	cmp    %rdi,%r10
  100824:	74 c5                	je     1007eb <quicksort+0x409>
                char c = *trav;
  100826:	44 0f b6 0f          	movzbl (%rdi),%r9d
                for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  10082a:	4c 89 c0             	mov    %r8,%rax
  10082d:	49 39 f0             	cmp    %rsi,%r8
  100830:	72 e1                	jb     100813 <quicksort+0x431>
  100832:	48 89 fa             	mov    %rdi,%rdx
                  *hi = *lo;
  100835:	0f b6 08             	movzbl (%rax),%ecx
  100838:	88 0a                	mov    %cl,(%rdx)
                for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  10083a:	48 89 c1             	mov    %rax,%rcx
  10083d:	4c 01 e8             	add    %r13,%rax
  100840:	4c 29 fa             	sub    %r15,%rdx
  100843:	48 39 f0             	cmp    %rsi,%rax
  100846:	73 ed                	jae    100835 <quicksort+0x453>
  100848:	eb cc                	jmp    100816 <quicksort+0x434>
  10084a:	c3                   	ret    

000000000010084b <is_adjacent>:
    freeblock a = freeblock_list[i];
  10084b:	48 63 f6             	movslq %esi,%rsi
  10084e:	48 c1 e6 04          	shl    $0x4,%rsi
  100852:	48 01 fe             	add    %rdi,%rsi
    return (uintptr_t) a.addr + a.size == (uintptr_t) b.addr;
  100855:	48 8b 46 08          	mov    0x8(%rsi),%rax
  100859:	48 03 06             	add    (%rsi),%rax
    freeblock b = freeblock_list[j];
  10085c:	48 63 d2             	movslq %edx,%rdx
  10085f:	48 c1 e2 04          	shl    $0x4,%rdx
    return (uintptr_t) a.addr + a.size == (uintptr_t) b.addr;
  100863:	48 39 04 17          	cmp    %rax,(%rdi,%rdx,1)
  100867:	0f 94 c0             	sete   %al
  10086a:	0f b6 c0             	movzbl %al,%eax
}
  10086d:	c3                   	ret    

000000000010086e <connect>:
void connect(freeblock* ptrs_with_size, int i, int j) {
  10086e:	55                   	push   %rbp
  10086f:	48 89 e5             	mov    %rsp,%rbp
    node* node_a = (node*) ptrs_with_size[i].addr;
  100872:	48 63 f6             	movslq %esi,%rsi
  100875:	48 c1 e6 04          	shl    $0x4,%rsi
  100879:	48 8b 04 37          	mov    (%rdi,%rsi,1),%rax
    node* node_b = (node*) ptrs_with_size[j].addr;
  10087d:	48 63 d2             	movslq %edx,%rdx
  100880:	48 c1 e2 04          	shl    $0x4,%rdx
  100884:	48 8b 3c 17          	mov    (%rdi,%rdx,1),%rdi
    node_a->size += node_b->size;
  100888:	48 8b 57 10          	mov    0x10(%rdi),%rdx
  10088c:	48 01 50 10          	add    %rdx,0x10(%rax)
    remove_free_node(node_b);
  100890:	e8 3f f8 ff ff       	call   1000d4 <remove_free_node>
}
  100895:	5d                   	pop    %rbp
  100896:	c3                   	ret    

0000000000100897 <defrag>:
void defrag() {
  100897:	55                   	push   %rbp
  100898:	48 89 e5             	mov    %rsp,%rbp
  10089b:	41 56                	push   %r14
  10089d:	41 55                	push   %r13
  10089f:	41 54                	push   %r12
  1008a1:	53                   	push   %rbx
    freeblock freeblock_list[free_len];
  1008a2:	8b 05 80 17 00 00    	mov    0x1780(%rip),%eax        # 102028 <free_len>
  1008a8:	48 63 f8             	movslq %eax,%rdi
  1008ab:	48 89 fe             	mov    %rdi,%rsi
  1008ae:	48 c1 e6 04          	shl    $0x4,%rsi
  1008b2:	48 29 f4             	sub    %rsi,%rsp
  1008b5:	49 89 e5             	mov    %rsp,%r13
    node* current_node = free_head;
  1008b8:	48 8b 15 79 17 00 00 	mov    0x1779(%rip),%rdx        # 102038 <free_head>
    for (int i = 0; i < free_len; i++) {
  1008bf:	85 c0                	test   %eax,%eax
  1008c1:	7e 1e                	jle    1008e1 <defrag+0x4a>
  1008c3:	4c 89 e8             	mov    %r13,%rax
  1008c6:	4c 01 ee             	add    %r13,%rsi
        freeblock_list[i].addr = current_node;
  1008c9:	48 89 10             	mov    %rdx,(%rax)
        freeblock_list[i].size = current_node->size;
  1008cc:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  1008d0:	48 89 48 08          	mov    %rcx,0x8(%rax)
        current_node = current_node->next;
  1008d4:	48 8b 52 08          	mov    0x8(%rdx),%rdx
    for (int i = 0; i < free_len; i++) {
  1008d8:	48 83 c0 10          	add    $0x10,%rax
  1008dc:	48 39 f0             	cmp    %rsi,%rax
  1008df:	75 e8                	jne    1008c9 <defrag+0x32>
    quicksort(freeblock_list, free_len, sizeof(freeblock_list[0]), &cmp_blocks_ascending);
  1008e1:	b9 71 00 10 00       	mov    $0x100071,%ecx
  1008e6:	ba 10 00 00 00       	mov    $0x10,%edx
  1008eb:	48 89 fe             	mov    %rdi,%rsi
  1008ee:	4c 89 ef             	mov    %r13,%rdi
  1008f1:	e8 ec fa ff ff       	call   1003e2 <quicksort>
    int len = free_len;
  1008f6:	44 8b 35 2b 17 00 00 	mov    0x172b(%rip),%r14d        # 102028 <free_len>
    for (int j = 1; j < len; j++) {
  1008fd:	41 83 fe 01          	cmp    $0x1,%r14d
  100901:	7e 38                	jle    10093b <defrag+0xa4>
  100903:	bb 01 00 00 00       	mov    $0x1,%ebx
    int i = 0;
  100908:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  10090e:	eb 15                	jmp    100925 <defrag+0x8e>
            connect(freeblock_list, i, j);
  100910:	89 da                	mov    %ebx,%edx
  100912:	44 89 e6             	mov    %r12d,%esi
  100915:	4c 89 ef             	mov    %r13,%rdi
  100918:	e8 51 ff ff ff       	call   10086e <connect>
    for (int j = 1; j < len; j++) {
  10091d:	83 c3 01             	add    $0x1,%ebx
  100920:	41 39 de             	cmp    %ebx,%r14d
  100923:	74 16                	je     10093b <defrag+0xa4>
        if (is_adjacent(freeblock_list, i, j)) {
  100925:	89 da                	mov    %ebx,%edx
  100927:	44 89 e6             	mov    %r12d,%esi
  10092a:	4c 89 ef             	mov    %r13,%rdi
  10092d:	e8 19 ff ff ff       	call   10084b <is_adjacent>
  100932:	85 c0                	test   %eax,%eax
  100934:	75 da                	jne    100910 <defrag+0x79>
  100936:	41 89 dc             	mov    %ebx,%r12d
  100939:	eb e2                	jmp    10091d <defrag+0x86>
}
  10093b:	48 8d 65 e0          	lea    -0x20(%rbp),%rsp
  10093f:	5b                   	pop    %rbx
  100940:	41 5c                	pop    %r12
  100942:	41 5d                	pop    %r13
  100944:	41 5e                	pop    %r14
  100946:	5d                   	pop    %rbp
  100947:	c3                   	ret    

0000000000100948 <heap_info>:

int heap_info(heap_info_struct * info) {
  100948:	55                   	push   %rbp
  100949:	48 89 e5             	mov    %rsp,%rbp
  10094c:	41 57                	push   %r15
  10094e:	41 56                	push   %r14
  100950:	41 55                	push   %r13
  100952:	41 54                	push   %r12
  100954:	53                   	push   %rbx
  100955:	48 83 ec 08          	sub    $0x8,%rsp
  100959:	49 89 fd             	mov    %rdi,%r13
    info->num_allocs = malloc_len;
  10095c:	8b 35 ae 16 00 00    	mov    0x16ae(%rip),%esi        # 102010 <malloc_len>
  100962:	89 37                	mov    %esi,(%rdi)
    // Calculate free_space and largest_free_chunk
    int free_space = 0;
    int largest_free_chunk = 0;
    node* current_node = free_head;
  100964:	48 8b 05 cd 16 00 00 	mov    0x16cd(%rip),%rax        # 102038 <free_head>
    while (current_node != NULL) {
  10096b:	48 85 c0             	test   %rax,%rax
  10096e:	74 54                	je     1009c4 <heap_info+0x7c>
    int largest_free_chunk = 0;
  100970:	bb 00 00 00 00       	mov    $0x0,%ebx
    int free_space = 0;
  100975:	41 bc 00 00 00 00    	mov    $0x0,%r12d
        int current_size = (int) current_node->size;
  10097b:	48 8b 50 10          	mov    0x10(%rax),%rdx
        if (current_size > largest_free_chunk) {
  10097f:	39 d3                	cmp    %edx,%ebx
  100981:	0f 4c da             	cmovl  %edx,%ebx
            largest_free_chunk = current_size;
        }
        free_space += current_size;
  100984:	41 01 d4             	add    %edx,%r12d
        current_node = current_node->next;
  100987:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (current_node != NULL) {
  10098b:	48 85 c0             	test   %rax,%rax
  10098e:	75 eb                	jne    10097b <heap_info+0x33>
    // Calculate size_array and ptr_array
    long* size_array;
    void** ptr_array;
    if (info->num_allocs == 0) {
        size_array = NULL;
        ptr_array = NULL;
  100990:	41 be 00 00 00 00    	mov    $0x0,%r14d
        size_array = NULL;
  100996:	41 bf 00 00 00 00    	mov    $0x0,%r15d
    if (info->num_allocs == 0) {
  10099c:	85 f6                	test   %esi,%esi
  10099e:	75 31                	jne    1009d1 <heap_info+0x89>
        // Sort the two arrays
        quicksort(size_array, info->num_allocs, sizeof(size_array[0]), &cmp_size_array_descending);
        quicksort(ptr_array, info->num_allocs, sizeof(size_array[0]), &cmp_ptr_array_descending);
    }

    info->size_array = size_array;
  1009a0:	4d 89 7d 08          	mov    %r15,0x8(%r13)
    info->ptr_array = ptr_array;
  1009a4:	4d 89 75 10          	mov    %r14,0x10(%r13)
    info->largest_free_chunk = largest_free_chunk;
  1009a8:	41 89 5d 1c          	mov    %ebx,0x1c(%r13)
    info->free_space = free_space;
  1009ac:	45 89 65 18          	mov    %r12d,0x18(%r13)

    return 0;
  1009b0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1009b5:	48 83 c4 08          	add    $0x8,%rsp
  1009b9:	5b                   	pop    %rbx
  1009ba:	41 5c                	pop    %r12
  1009bc:	41 5d                	pop    %r13
  1009be:	41 5e                	pop    %r14
  1009c0:	41 5f                	pop    %r15
  1009c2:	5d                   	pop    %rbp
  1009c3:	c3                   	ret    
    int largest_free_chunk = 0;
  1009c4:	bb 00 00 00 00       	mov    $0x0,%ebx
    int free_space = 0;
  1009c9:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  1009cf:	eb bf                	jmp    100990 <heap_info+0x48>
        size_array = (long *) malloc(info->num_allocs * sizeof(long));
  1009d1:	48 63 f6             	movslq %esi,%rsi
  1009d4:	48 8d 3c f5 00 00 00 	lea    0x0(,%rsi,8),%rdi
  1009db:	00 
  1009dc:	e8 af f8 ff ff       	call   100290 <malloc>
  1009e1:	49 89 c7             	mov    %rax,%r15
        if (size_array == NULL) {
  1009e4:	48 85 c0             	test   %rax,%rax
  1009e7:	74 79                	je     100a62 <heap_info+0x11a>
        ptr_array = (void **) malloc(info->num_allocs * sizeof(void*));
  1009e9:	49 63 7d 00          	movslq 0x0(%r13),%rdi
  1009ed:	48 c1 e7 03          	shl    $0x3,%rdi
  1009f1:	e8 9a f8 ff ff       	call   100290 <malloc>
  1009f6:	49 89 c6             	mov    %rax,%r14
        if (ptr_array == NULL) {
  1009f9:	48 85 c0             	test   %rax,%rax
  1009fc:	74 78                	je     100a76 <heap_info+0x12e>
        header *current_header = malloc_head;
  1009fe:	48 8b 15 1b 16 00 00 	mov    0x161b(%rip),%rdx        # 102020 <malloc_head>
        for (int i = 0; i < info->num_allocs; i++) {
  100a05:	41 8b 75 00          	mov    0x0(%r13),%esi
  100a09:	85 f6                	test   %esi,%esi
  100a0b:	7e 25                	jle    100a32 <heap_info+0xea>
  100a0d:	b8 00 00 00 00       	mov    $0x0,%eax
            size_array[i] = (long) current_header->size;
  100a12:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  100a16:	49 89 0c c7          	mov    %rcx,(%r15,%rax,8)
            ptr_array[i] = (void *) ((uintptr_t) current_header + HEADER_SIZE);
  100a1a:	48 8d 4a 18          	lea    0x18(%rdx),%rcx
  100a1e:	49 89 0c c6          	mov    %rcx,(%r14,%rax,8)
            current_header = current_header->next;
  100a22:	48 8b 52 08          	mov    0x8(%rdx),%rdx
        for (int i = 0; i < info->num_allocs; i++) {
  100a26:	41 8b 75 00          	mov    0x0(%r13),%esi
  100a2a:	48 83 c0 01          	add    $0x1,%rax
  100a2e:	39 c6                	cmp    %eax,%esi
  100a30:	7f e0                	jg     100a12 <heap_info+0xca>
        quicksort(size_array, info->num_allocs, sizeof(size_array[0]), &cmp_size_array_descending);
  100a32:	48 63 f6             	movslq %esi,%rsi
  100a35:	b9 77 00 10 00       	mov    $0x100077,%ecx
  100a3a:	ba 08 00 00 00       	mov    $0x8,%edx
  100a3f:	4c 89 ff             	mov    %r15,%rdi
  100a42:	e8 9b f9 ff ff       	call   1003e2 <quicksort>
        quicksort(ptr_array, info->num_allocs, sizeof(size_array[0]), &cmp_ptr_array_descending);
  100a47:	49 63 75 00          	movslq 0x0(%r13),%rsi
  100a4b:	b9 7d 00 10 00       	mov    $0x10007d,%ecx
  100a50:	ba 08 00 00 00       	mov    $0x8,%edx
  100a55:	4c 89 f7             	mov    %r14,%rdi
  100a58:	e8 85 f9 ff ff       	call   1003e2 <quicksort>
  100a5d:	e9 3e ff ff ff       	jmp    1009a0 <heap_info+0x58>
            free(size_array);
  100a62:	bf 00 00 00 00       	mov    $0x0,%edi
  100a67:	e8 f2 f7 ff ff       	call   10025e <free>
            return -1;
  100a6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100a71:	e9 3f ff ff ff       	jmp    1009b5 <heap_info+0x6d>
            free(ptr_array);
  100a76:	bf 00 00 00 00       	mov    $0x0,%edi
  100a7b:	e8 de f7 ff ff       	call   10025e <free>
            return -1;
  100a80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100a85:	e9 2b ff ff ff       	jmp    1009b5 <heap_info+0x6d>

0000000000100a8a <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100a8a:	55                   	push   %rbp
  100a8b:	48 89 e5             	mov    %rsp,%rbp
  100a8e:	48 83 ec 28          	sub    $0x28,%rsp
  100a92:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100a96:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100a9a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100a9e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100aa2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100aa6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100aaa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100aae:	eb 1c                	jmp    100acc <memcpy+0x42>
        *d = *s;
  100ab0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100ab4:	0f b6 10             	movzbl (%rax),%edx
  100ab7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100abb:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100abd:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100ac2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100ac7:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100acc:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100ad1:	75 dd                	jne    100ab0 <memcpy+0x26>
    }
    return dst;
  100ad3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100ad7:	c9                   	leave  
  100ad8:	c3                   	ret    

0000000000100ad9 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100ad9:	55                   	push   %rbp
  100ada:	48 89 e5             	mov    %rsp,%rbp
  100add:	48 83 ec 28          	sub    $0x28,%rsp
  100ae1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100ae5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100ae9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100aed:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100af1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100af5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100af9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100afd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b01:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100b05:	73 6a                	jae    100b71 <memmove+0x98>
  100b07:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100b0b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100b0f:	48 01 d0             	add    %rdx,%rax
  100b12:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100b16:	73 59                	jae    100b71 <memmove+0x98>
        s += n, d += n;
  100b18:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100b1c:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100b20:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100b24:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100b28:	eb 17                	jmp    100b41 <memmove+0x68>
            *--d = *--s;
  100b2a:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100b2f:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100b34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b38:	0f b6 10             	movzbl (%rax),%edx
  100b3b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100b3f:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100b41:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100b45:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100b49:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100b4d:	48 85 c0             	test   %rax,%rax
  100b50:	75 d8                	jne    100b2a <memmove+0x51>
    if (s < d && s + n > d) {
  100b52:	eb 2e                	jmp    100b82 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100b54:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100b58:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100b5c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100b60:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100b64:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100b68:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100b6c:	0f b6 12             	movzbl (%rdx),%edx
  100b6f:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100b71:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100b75:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100b79:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100b7d:	48 85 c0             	test   %rax,%rax
  100b80:	75 d2                	jne    100b54 <memmove+0x7b>
        }
    }
    return dst;
  100b82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100b86:	c9                   	leave  
  100b87:	c3                   	ret    

0000000000100b88 <memset>:

void* memset(void* v, int c, size_t n) {
  100b88:	55                   	push   %rbp
  100b89:	48 89 e5             	mov    %rsp,%rbp
  100b8c:	48 83 ec 28          	sub    $0x28,%rsp
  100b90:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100b94:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100b97:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100b9b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100b9f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100ba3:	eb 15                	jmp    100bba <memset+0x32>
        *p = c;
  100ba5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100ba8:	89 c2                	mov    %eax,%edx
  100baa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bae:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100bb0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100bb5:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100bba:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100bbf:	75 e4                	jne    100ba5 <memset+0x1d>
    }
    return v;
  100bc1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100bc5:	c9                   	leave  
  100bc6:	c3                   	ret    

0000000000100bc7 <strlen>:

size_t strlen(const char* s) {
  100bc7:	55                   	push   %rbp
  100bc8:	48 89 e5             	mov    %rsp,%rbp
  100bcb:	48 83 ec 18          	sub    $0x18,%rsp
  100bcf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100bd3:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100bda:	00 
  100bdb:	eb 0a                	jmp    100be7 <strlen+0x20>
        ++n;
  100bdd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100be2:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100be7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100beb:	0f b6 00             	movzbl (%rax),%eax
  100bee:	84 c0                	test   %al,%al
  100bf0:	75 eb                	jne    100bdd <strlen+0x16>
    }
    return n;
  100bf2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100bf6:	c9                   	leave  
  100bf7:	c3                   	ret    

0000000000100bf8 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100bf8:	55                   	push   %rbp
  100bf9:	48 89 e5             	mov    %rsp,%rbp
  100bfc:	48 83 ec 20          	sub    $0x20,%rsp
  100c00:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100c04:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100c08:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100c0f:	00 
  100c10:	eb 0a                	jmp    100c1c <strnlen+0x24>
        ++n;
  100c12:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100c17:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100c1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c20:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100c24:	74 0b                	je     100c31 <strnlen+0x39>
  100c26:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100c2a:	0f b6 00             	movzbl (%rax),%eax
  100c2d:	84 c0                	test   %al,%al
  100c2f:	75 e1                	jne    100c12 <strnlen+0x1a>
    }
    return n;
  100c31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100c35:	c9                   	leave  
  100c36:	c3                   	ret    

0000000000100c37 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100c37:	55                   	push   %rbp
  100c38:	48 89 e5             	mov    %rsp,%rbp
  100c3b:	48 83 ec 20          	sub    $0x20,%rsp
  100c3f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100c43:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100c47:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100c4b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100c4f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100c53:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100c57:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100c5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c5f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100c63:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100c67:	0f b6 12             	movzbl (%rdx),%edx
  100c6a:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100c6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c70:	48 83 e8 01          	sub    $0x1,%rax
  100c74:	0f b6 00             	movzbl (%rax),%eax
  100c77:	84 c0                	test   %al,%al
  100c79:	75 d4                	jne    100c4f <strcpy+0x18>
    return dst;
  100c7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100c7f:	c9                   	leave  
  100c80:	c3                   	ret    

0000000000100c81 <strcmp>:

int strcmp(const char* a, const char* b) {
  100c81:	55                   	push   %rbp
  100c82:	48 89 e5             	mov    %rsp,%rbp
  100c85:	48 83 ec 10          	sub    $0x10,%rsp
  100c89:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100c8d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100c91:	eb 0a                	jmp    100c9d <strcmp+0x1c>
        ++a, ++b;
  100c93:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100c98:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100c9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100ca1:	0f b6 00             	movzbl (%rax),%eax
  100ca4:	84 c0                	test   %al,%al
  100ca6:	74 1d                	je     100cc5 <strcmp+0x44>
  100ca8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100cac:	0f b6 00             	movzbl (%rax),%eax
  100caf:	84 c0                	test   %al,%al
  100cb1:	74 12                	je     100cc5 <strcmp+0x44>
  100cb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100cb7:	0f b6 10             	movzbl (%rax),%edx
  100cba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100cbe:	0f b6 00             	movzbl (%rax),%eax
  100cc1:	38 c2                	cmp    %al,%dl
  100cc3:	74 ce                	je     100c93 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100cc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100cc9:	0f b6 00             	movzbl (%rax),%eax
  100ccc:	89 c2                	mov    %eax,%edx
  100cce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100cd2:	0f b6 00             	movzbl (%rax),%eax
  100cd5:	38 d0                	cmp    %dl,%al
  100cd7:	0f 92 c0             	setb   %al
  100cda:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100cdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100ce1:	0f b6 00             	movzbl (%rax),%eax
  100ce4:	89 c1                	mov    %eax,%ecx
  100ce6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100cea:	0f b6 00             	movzbl (%rax),%eax
  100ced:	38 c1                	cmp    %al,%cl
  100cef:	0f 92 c0             	setb   %al
  100cf2:	0f b6 c0             	movzbl %al,%eax
  100cf5:	29 c2                	sub    %eax,%edx
  100cf7:	89 d0                	mov    %edx,%eax
}
  100cf9:	c9                   	leave  
  100cfa:	c3                   	ret    

0000000000100cfb <strchr>:

char* strchr(const char* s, int c) {
  100cfb:	55                   	push   %rbp
  100cfc:	48 89 e5             	mov    %rsp,%rbp
  100cff:	48 83 ec 10          	sub    $0x10,%rsp
  100d03:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100d07:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100d0a:	eb 05                	jmp    100d11 <strchr+0x16>
        ++s;
  100d0c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100d11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d15:	0f b6 00             	movzbl (%rax),%eax
  100d18:	84 c0                	test   %al,%al
  100d1a:	74 0e                	je     100d2a <strchr+0x2f>
  100d1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d20:	0f b6 00             	movzbl (%rax),%eax
  100d23:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100d26:	38 d0                	cmp    %dl,%al
  100d28:	75 e2                	jne    100d0c <strchr+0x11>
    }
    if (*s == (char) c) {
  100d2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d2e:	0f b6 00             	movzbl (%rax),%eax
  100d31:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100d34:	38 d0                	cmp    %dl,%al
  100d36:	75 06                	jne    100d3e <strchr+0x43>
        return (char*) s;
  100d38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d3c:	eb 05                	jmp    100d43 <strchr+0x48>
    } else {
        return NULL;
  100d3e:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100d43:	c9                   	leave  
  100d44:	c3                   	ret    

0000000000100d45 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100d45:	55                   	push   %rbp
  100d46:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100d49:	8b 05 f9 12 00 00    	mov    0x12f9(%rip),%eax        # 102048 <rand_seed_set>
  100d4f:	85 c0                	test   %eax,%eax
  100d51:	75 0a                	jne    100d5d <rand+0x18>
        srand(819234718U);
  100d53:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100d58:	e8 24 00 00 00       	call   100d81 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100d5d:	8b 05 e9 12 00 00    	mov    0x12e9(%rip),%eax        # 10204c <rand_seed>
  100d63:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100d69:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100d6e:	89 05 d8 12 00 00    	mov    %eax,0x12d8(%rip)        # 10204c <rand_seed>
    return rand_seed & RAND_MAX;
  100d74:	8b 05 d2 12 00 00    	mov    0x12d2(%rip),%eax        # 10204c <rand_seed>
  100d7a:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100d7f:	5d                   	pop    %rbp
  100d80:	c3                   	ret    

0000000000100d81 <srand>:

void srand(unsigned seed) {
  100d81:	55                   	push   %rbp
  100d82:	48 89 e5             	mov    %rsp,%rbp
  100d85:	48 83 ec 08          	sub    $0x8,%rsp
  100d89:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100d8c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100d8f:	89 05 b7 12 00 00    	mov    %eax,0x12b7(%rip)        # 10204c <rand_seed>
    rand_seed_set = 1;
  100d95:	c7 05 a9 12 00 00 01 	movl   $0x1,0x12a9(%rip)        # 102048 <rand_seed_set>
  100d9c:	00 00 00 
}
  100d9f:	90                   	nop
  100da0:	c9                   	leave  
  100da1:	c3                   	ret    

0000000000100da2 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100da2:	55                   	push   %rbp
  100da3:	48 89 e5             	mov    %rsp,%rbp
  100da6:	48 83 ec 28          	sub    $0x28,%rsp
  100daa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100dae:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100db2:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100db5:	48 c7 45 f8 c0 1c 10 	movq   $0x101cc0,-0x8(%rbp)
  100dbc:	00 
    if (base < 0) {
  100dbd:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100dc1:	79 0b                	jns    100dce <fill_numbuf+0x2c>
        digits = lower_digits;
  100dc3:	48 c7 45 f8 e0 1c 10 	movq   $0x101ce0,-0x8(%rbp)
  100dca:	00 
        base = -base;
  100dcb:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100dce:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100dd3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100dd7:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100dda:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100ddd:	48 63 c8             	movslq %eax,%rcx
  100de0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100de4:	ba 00 00 00 00       	mov    $0x0,%edx
  100de9:	48 f7 f1             	div    %rcx
  100dec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100df0:	48 01 d0             	add    %rdx,%rax
  100df3:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100df8:	0f b6 10             	movzbl (%rax),%edx
  100dfb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100dff:	88 10                	mov    %dl,(%rax)
        val /= base;
  100e01:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100e04:	48 63 f0             	movslq %eax,%rsi
  100e07:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100e0b:	ba 00 00 00 00       	mov    $0x0,%edx
  100e10:	48 f7 f6             	div    %rsi
  100e13:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100e17:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100e1c:	75 bc                	jne    100dda <fill_numbuf+0x38>
    return numbuf_end;
  100e1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100e22:	c9                   	leave  
  100e23:	c3                   	ret    

0000000000100e24 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100e24:	55                   	push   %rbp
  100e25:	48 89 e5             	mov    %rsp,%rbp
  100e28:	53                   	push   %rbx
  100e29:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100e30:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100e37:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100e3d:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100e44:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100e4b:	e9 8a 09 00 00       	jmp    1017da <printer_vprintf+0x9b6>
        if (*format != '%') {
  100e50:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e57:	0f b6 00             	movzbl (%rax),%eax
  100e5a:	3c 25                	cmp    $0x25,%al
  100e5c:	74 31                	je     100e8f <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100e5e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e65:	4c 8b 00             	mov    (%rax),%r8
  100e68:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e6f:	0f b6 00             	movzbl (%rax),%eax
  100e72:	0f b6 c8             	movzbl %al,%ecx
  100e75:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e7b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e82:	89 ce                	mov    %ecx,%esi
  100e84:	48 89 c7             	mov    %rax,%rdi
  100e87:	41 ff d0             	call   *%r8
            continue;
  100e8a:	e9 43 09 00 00       	jmp    1017d2 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100e8f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100e96:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100e9d:	01 
  100e9e:	eb 44                	jmp    100ee4 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100ea0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ea7:	0f b6 00             	movzbl (%rax),%eax
  100eaa:	0f be c0             	movsbl %al,%eax
  100ead:	89 c6                	mov    %eax,%esi
  100eaf:	bf e0 1a 10 00       	mov    $0x101ae0,%edi
  100eb4:	e8 42 fe ff ff       	call   100cfb <strchr>
  100eb9:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100ebd:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100ec2:	74 30                	je     100ef4 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100ec4:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100ec8:	48 2d e0 1a 10 00    	sub    $0x101ae0,%rax
  100ece:	ba 01 00 00 00       	mov    $0x1,%edx
  100ed3:	89 c1                	mov    %eax,%ecx
  100ed5:	d3 e2                	shl    %cl,%edx
  100ed7:	89 d0                	mov    %edx,%eax
  100ed9:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100edc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ee3:	01 
  100ee4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100eeb:	0f b6 00             	movzbl (%rax),%eax
  100eee:	84 c0                	test   %al,%al
  100ef0:	75 ae                	jne    100ea0 <printer_vprintf+0x7c>
  100ef2:	eb 01                	jmp    100ef5 <printer_vprintf+0xd1>
            } else {
                break;
  100ef4:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100ef5:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100efc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f03:	0f b6 00             	movzbl (%rax),%eax
  100f06:	3c 30                	cmp    $0x30,%al
  100f08:	7e 67                	jle    100f71 <printer_vprintf+0x14d>
  100f0a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f11:	0f b6 00             	movzbl (%rax),%eax
  100f14:	3c 39                	cmp    $0x39,%al
  100f16:	7f 59                	jg     100f71 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100f18:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100f1f:	eb 2e                	jmp    100f4f <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100f21:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100f24:	89 d0                	mov    %edx,%eax
  100f26:	c1 e0 02             	shl    $0x2,%eax
  100f29:	01 d0                	add    %edx,%eax
  100f2b:	01 c0                	add    %eax,%eax
  100f2d:	89 c1                	mov    %eax,%ecx
  100f2f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f36:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100f3a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100f41:	0f b6 00             	movzbl (%rax),%eax
  100f44:	0f be c0             	movsbl %al,%eax
  100f47:	01 c8                	add    %ecx,%eax
  100f49:	83 e8 30             	sub    $0x30,%eax
  100f4c:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100f4f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f56:	0f b6 00             	movzbl (%rax),%eax
  100f59:	3c 2f                	cmp    $0x2f,%al
  100f5b:	0f 8e 85 00 00 00    	jle    100fe6 <printer_vprintf+0x1c2>
  100f61:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f68:	0f b6 00             	movzbl (%rax),%eax
  100f6b:	3c 39                	cmp    $0x39,%al
  100f6d:	7e b2                	jle    100f21 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100f6f:	eb 75                	jmp    100fe6 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100f71:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f78:	0f b6 00             	movzbl (%rax),%eax
  100f7b:	3c 2a                	cmp    $0x2a,%al
  100f7d:	75 68                	jne    100fe7 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100f7f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f86:	8b 00                	mov    (%rax),%eax
  100f88:	83 f8 2f             	cmp    $0x2f,%eax
  100f8b:	77 30                	ja     100fbd <printer_vprintf+0x199>
  100f8d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f94:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f98:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f9f:	8b 00                	mov    (%rax),%eax
  100fa1:	89 c0                	mov    %eax,%eax
  100fa3:	48 01 d0             	add    %rdx,%rax
  100fa6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fad:	8b 12                	mov    (%rdx),%edx
  100faf:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100fb2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fb9:	89 0a                	mov    %ecx,(%rdx)
  100fbb:	eb 1a                	jmp    100fd7 <printer_vprintf+0x1b3>
  100fbd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fc4:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fc8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100fcc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fd3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100fd7:	8b 00                	mov    (%rax),%eax
  100fd9:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100fdc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100fe3:	01 
  100fe4:	eb 01                	jmp    100fe7 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100fe6:	90                   	nop
        }

        // process precision
        int precision = -1;
  100fe7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100fee:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ff5:	0f b6 00             	movzbl (%rax),%eax
  100ff8:	3c 2e                	cmp    $0x2e,%al
  100ffa:	0f 85 00 01 00 00    	jne    101100 <printer_vprintf+0x2dc>
            ++format;
  101000:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101007:	01 
            if (*format >= '0' && *format <= '9') {
  101008:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10100f:	0f b6 00             	movzbl (%rax),%eax
  101012:	3c 2f                	cmp    $0x2f,%al
  101014:	7e 67                	jle    10107d <printer_vprintf+0x259>
  101016:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10101d:	0f b6 00             	movzbl (%rax),%eax
  101020:	3c 39                	cmp    $0x39,%al
  101022:	7f 59                	jg     10107d <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  101024:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  10102b:	eb 2e                	jmp    10105b <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  10102d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  101030:	89 d0                	mov    %edx,%eax
  101032:	c1 e0 02             	shl    $0x2,%eax
  101035:	01 d0                	add    %edx,%eax
  101037:	01 c0                	add    %eax,%eax
  101039:	89 c1                	mov    %eax,%ecx
  10103b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101042:	48 8d 50 01          	lea    0x1(%rax),%rdx
  101046:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10104d:	0f b6 00             	movzbl (%rax),%eax
  101050:	0f be c0             	movsbl %al,%eax
  101053:	01 c8                	add    %ecx,%eax
  101055:	83 e8 30             	sub    $0x30,%eax
  101058:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10105b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101062:	0f b6 00             	movzbl (%rax),%eax
  101065:	3c 2f                	cmp    $0x2f,%al
  101067:	0f 8e 85 00 00 00    	jle    1010f2 <printer_vprintf+0x2ce>
  10106d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101074:	0f b6 00             	movzbl (%rax),%eax
  101077:	3c 39                	cmp    $0x39,%al
  101079:	7e b2                	jle    10102d <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  10107b:	eb 75                	jmp    1010f2 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  10107d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101084:	0f b6 00             	movzbl (%rax),%eax
  101087:	3c 2a                	cmp    $0x2a,%al
  101089:	75 68                	jne    1010f3 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  10108b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101092:	8b 00                	mov    (%rax),%eax
  101094:	83 f8 2f             	cmp    $0x2f,%eax
  101097:	77 30                	ja     1010c9 <printer_vprintf+0x2a5>
  101099:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010a0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1010a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010ab:	8b 00                	mov    (%rax),%eax
  1010ad:	89 c0                	mov    %eax,%eax
  1010af:	48 01 d0             	add    %rdx,%rax
  1010b2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010b9:	8b 12                	mov    (%rdx),%edx
  1010bb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1010be:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010c5:	89 0a                	mov    %ecx,(%rdx)
  1010c7:	eb 1a                	jmp    1010e3 <printer_vprintf+0x2bf>
  1010c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010d0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010d4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1010d8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010df:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010e3:	8b 00                	mov    (%rax),%eax
  1010e5:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  1010e8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1010ef:	01 
  1010f0:	eb 01                	jmp    1010f3 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  1010f2:	90                   	nop
            }
            if (precision < 0) {
  1010f3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1010f7:	79 07                	jns    101100 <printer_vprintf+0x2dc>
                precision = 0;
  1010f9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  101100:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  101107:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  10110e:	00 
        int length = 0;
  10110f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  101116:	48 c7 45 c8 e6 1a 10 	movq   $0x101ae6,-0x38(%rbp)
  10111d:	00 
    again:
        switch (*format) {
  10111e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101125:	0f b6 00             	movzbl (%rax),%eax
  101128:	0f be c0             	movsbl %al,%eax
  10112b:	83 e8 43             	sub    $0x43,%eax
  10112e:	83 f8 37             	cmp    $0x37,%eax
  101131:	0f 87 9f 03 00 00    	ja     1014d6 <printer_vprintf+0x6b2>
  101137:	89 c0                	mov    %eax,%eax
  101139:	48 8b 04 c5 f8 1a 10 	mov    0x101af8(,%rax,8),%rax
  101140:	00 
  101141:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  101143:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  10114a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101151:	01 
            goto again;
  101152:	eb ca                	jmp    10111e <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  101154:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  101158:	74 5d                	je     1011b7 <printer_vprintf+0x393>
  10115a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101161:	8b 00                	mov    (%rax),%eax
  101163:	83 f8 2f             	cmp    $0x2f,%eax
  101166:	77 30                	ja     101198 <printer_vprintf+0x374>
  101168:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10116f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101173:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10117a:	8b 00                	mov    (%rax),%eax
  10117c:	89 c0                	mov    %eax,%eax
  10117e:	48 01 d0             	add    %rdx,%rax
  101181:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101188:	8b 12                	mov    (%rdx),%edx
  10118a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10118d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101194:	89 0a                	mov    %ecx,(%rdx)
  101196:	eb 1a                	jmp    1011b2 <printer_vprintf+0x38e>
  101198:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10119f:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011a3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1011a7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011ae:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011b2:	48 8b 00             	mov    (%rax),%rax
  1011b5:	eb 5c                	jmp    101213 <printer_vprintf+0x3ef>
  1011b7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011be:	8b 00                	mov    (%rax),%eax
  1011c0:	83 f8 2f             	cmp    $0x2f,%eax
  1011c3:	77 30                	ja     1011f5 <printer_vprintf+0x3d1>
  1011c5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011cc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1011d0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011d7:	8b 00                	mov    (%rax),%eax
  1011d9:	89 c0                	mov    %eax,%eax
  1011db:	48 01 d0             	add    %rdx,%rax
  1011de:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011e5:	8b 12                	mov    (%rdx),%edx
  1011e7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1011ea:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011f1:	89 0a                	mov    %ecx,(%rdx)
  1011f3:	eb 1a                	jmp    10120f <printer_vprintf+0x3eb>
  1011f5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011fc:	48 8b 40 08          	mov    0x8(%rax),%rax
  101200:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101204:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10120b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10120f:	8b 00                	mov    (%rax),%eax
  101211:	48 98                	cltq   
  101213:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  101217:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10121b:	48 c1 f8 38          	sar    $0x38,%rax
  10121f:	25 80 00 00 00       	and    $0x80,%eax
  101224:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  101227:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  10122b:	74 09                	je     101236 <printer_vprintf+0x412>
  10122d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101231:	48 f7 d8             	neg    %rax
  101234:	eb 04                	jmp    10123a <printer_vprintf+0x416>
  101236:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10123a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  10123e:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  101241:	83 c8 60             	or     $0x60,%eax
  101244:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  101247:	e9 cf 02 00 00       	jmp    10151b <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10124c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  101250:	74 5d                	je     1012af <printer_vprintf+0x48b>
  101252:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101259:	8b 00                	mov    (%rax),%eax
  10125b:	83 f8 2f             	cmp    $0x2f,%eax
  10125e:	77 30                	ja     101290 <printer_vprintf+0x46c>
  101260:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101267:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10126b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101272:	8b 00                	mov    (%rax),%eax
  101274:	89 c0                	mov    %eax,%eax
  101276:	48 01 d0             	add    %rdx,%rax
  101279:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101280:	8b 12                	mov    (%rdx),%edx
  101282:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101285:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10128c:	89 0a                	mov    %ecx,(%rdx)
  10128e:	eb 1a                	jmp    1012aa <printer_vprintf+0x486>
  101290:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101297:	48 8b 40 08          	mov    0x8(%rax),%rax
  10129b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10129f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012a6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1012aa:	48 8b 00             	mov    (%rax),%rax
  1012ad:	eb 5c                	jmp    10130b <printer_vprintf+0x4e7>
  1012af:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012b6:	8b 00                	mov    (%rax),%eax
  1012b8:	83 f8 2f             	cmp    $0x2f,%eax
  1012bb:	77 30                	ja     1012ed <printer_vprintf+0x4c9>
  1012bd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012c4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1012c8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012cf:	8b 00                	mov    (%rax),%eax
  1012d1:	89 c0                	mov    %eax,%eax
  1012d3:	48 01 d0             	add    %rdx,%rax
  1012d6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012dd:	8b 12                	mov    (%rdx),%edx
  1012df:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1012e2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012e9:	89 0a                	mov    %ecx,(%rdx)
  1012eb:	eb 1a                	jmp    101307 <printer_vprintf+0x4e3>
  1012ed:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012f4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1012f8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1012fc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101303:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101307:	8b 00                	mov    (%rax),%eax
  101309:	89 c0                	mov    %eax,%eax
  10130b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  10130f:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  101313:	e9 03 02 00 00       	jmp    10151b <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  101318:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  10131f:	e9 28 ff ff ff       	jmp    10124c <printer_vprintf+0x428>
        case 'X':
            base = 16;
  101324:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  10132b:	e9 1c ff ff ff       	jmp    10124c <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  101330:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101337:	8b 00                	mov    (%rax),%eax
  101339:	83 f8 2f             	cmp    $0x2f,%eax
  10133c:	77 30                	ja     10136e <printer_vprintf+0x54a>
  10133e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101345:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101349:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101350:	8b 00                	mov    (%rax),%eax
  101352:	89 c0                	mov    %eax,%eax
  101354:	48 01 d0             	add    %rdx,%rax
  101357:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10135e:	8b 12                	mov    (%rdx),%edx
  101360:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101363:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10136a:	89 0a                	mov    %ecx,(%rdx)
  10136c:	eb 1a                	jmp    101388 <printer_vprintf+0x564>
  10136e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101375:	48 8b 40 08          	mov    0x8(%rax),%rax
  101379:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10137d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101384:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101388:	48 8b 00             	mov    (%rax),%rax
  10138b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  10138f:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  101396:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  10139d:	e9 79 01 00 00       	jmp    10151b <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  1013a2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013a9:	8b 00                	mov    (%rax),%eax
  1013ab:	83 f8 2f             	cmp    $0x2f,%eax
  1013ae:	77 30                	ja     1013e0 <printer_vprintf+0x5bc>
  1013b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013b7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1013bb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013c2:	8b 00                	mov    (%rax),%eax
  1013c4:	89 c0                	mov    %eax,%eax
  1013c6:	48 01 d0             	add    %rdx,%rax
  1013c9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013d0:	8b 12                	mov    (%rdx),%edx
  1013d2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1013d5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013dc:	89 0a                	mov    %ecx,(%rdx)
  1013de:	eb 1a                	jmp    1013fa <printer_vprintf+0x5d6>
  1013e0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013e7:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013eb:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1013ef:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013f6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1013fa:	48 8b 00             	mov    (%rax),%rax
  1013fd:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  101401:	e9 15 01 00 00       	jmp    10151b <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  101406:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10140d:	8b 00                	mov    (%rax),%eax
  10140f:	83 f8 2f             	cmp    $0x2f,%eax
  101412:	77 30                	ja     101444 <printer_vprintf+0x620>
  101414:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10141b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10141f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101426:	8b 00                	mov    (%rax),%eax
  101428:	89 c0                	mov    %eax,%eax
  10142a:	48 01 d0             	add    %rdx,%rax
  10142d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101434:	8b 12                	mov    (%rdx),%edx
  101436:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101439:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101440:	89 0a                	mov    %ecx,(%rdx)
  101442:	eb 1a                	jmp    10145e <printer_vprintf+0x63a>
  101444:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10144b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10144f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101453:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10145a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10145e:	8b 00                	mov    (%rax),%eax
  101460:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  101466:	e9 67 03 00 00       	jmp    1017d2 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  10146b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  10146f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  101473:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10147a:	8b 00                	mov    (%rax),%eax
  10147c:	83 f8 2f             	cmp    $0x2f,%eax
  10147f:	77 30                	ja     1014b1 <printer_vprintf+0x68d>
  101481:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101488:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10148c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101493:	8b 00                	mov    (%rax),%eax
  101495:	89 c0                	mov    %eax,%eax
  101497:	48 01 d0             	add    %rdx,%rax
  10149a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1014a1:	8b 12                	mov    (%rdx),%edx
  1014a3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1014a6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1014ad:	89 0a                	mov    %ecx,(%rdx)
  1014af:	eb 1a                	jmp    1014cb <printer_vprintf+0x6a7>
  1014b1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014b8:	48 8b 40 08          	mov    0x8(%rax),%rax
  1014bc:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1014c0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1014c7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1014cb:	8b 00                	mov    (%rax),%eax
  1014cd:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1014d0:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  1014d4:	eb 45                	jmp    10151b <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  1014d6:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1014da:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  1014de:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1014e5:	0f b6 00             	movzbl (%rax),%eax
  1014e8:	84 c0                	test   %al,%al
  1014ea:	74 0c                	je     1014f8 <printer_vprintf+0x6d4>
  1014ec:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1014f3:	0f b6 00             	movzbl (%rax),%eax
  1014f6:	eb 05                	jmp    1014fd <printer_vprintf+0x6d9>
  1014f8:	b8 25 00 00 00       	mov    $0x25,%eax
  1014fd:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  101500:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  101504:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10150b:	0f b6 00             	movzbl (%rax),%eax
  10150e:	84 c0                	test   %al,%al
  101510:	75 08                	jne    10151a <printer_vprintf+0x6f6>
                format--;
  101512:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  101519:	01 
            }
            break;
  10151a:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  10151b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10151e:	83 e0 20             	and    $0x20,%eax
  101521:	85 c0                	test   %eax,%eax
  101523:	74 1e                	je     101543 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  101525:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101529:	48 83 c0 18          	add    $0x18,%rax
  10152d:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101530:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101534:	48 89 ce             	mov    %rcx,%rsi
  101537:	48 89 c7             	mov    %rax,%rdi
  10153a:	e8 63 f8 ff ff       	call   100da2 <fill_numbuf>
  10153f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  101543:	48 c7 45 c0 e6 1a 10 	movq   $0x101ae6,-0x40(%rbp)
  10154a:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  10154b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10154e:	83 e0 20             	and    $0x20,%eax
  101551:	85 c0                	test   %eax,%eax
  101553:	74 48                	je     10159d <printer_vprintf+0x779>
  101555:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101558:	83 e0 40             	and    $0x40,%eax
  10155b:	85 c0                	test   %eax,%eax
  10155d:	74 3e                	je     10159d <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  10155f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101562:	25 80 00 00 00       	and    $0x80,%eax
  101567:	85 c0                	test   %eax,%eax
  101569:	74 0a                	je     101575 <printer_vprintf+0x751>
                prefix = "-";
  10156b:	48 c7 45 c0 e7 1a 10 	movq   $0x101ae7,-0x40(%rbp)
  101572:	00 
            if (flags & FLAG_NEGATIVE) {
  101573:	eb 73                	jmp    1015e8 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  101575:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101578:	83 e0 10             	and    $0x10,%eax
  10157b:	85 c0                	test   %eax,%eax
  10157d:	74 0a                	je     101589 <printer_vprintf+0x765>
                prefix = "+";
  10157f:	48 c7 45 c0 e9 1a 10 	movq   $0x101ae9,-0x40(%rbp)
  101586:	00 
            if (flags & FLAG_NEGATIVE) {
  101587:	eb 5f                	jmp    1015e8 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  101589:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10158c:	83 e0 08             	and    $0x8,%eax
  10158f:	85 c0                	test   %eax,%eax
  101591:	74 55                	je     1015e8 <printer_vprintf+0x7c4>
                prefix = " ";
  101593:	48 c7 45 c0 eb 1a 10 	movq   $0x101aeb,-0x40(%rbp)
  10159a:	00 
            if (flags & FLAG_NEGATIVE) {
  10159b:	eb 4b                	jmp    1015e8 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  10159d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015a0:	83 e0 20             	and    $0x20,%eax
  1015a3:	85 c0                	test   %eax,%eax
  1015a5:	74 42                	je     1015e9 <printer_vprintf+0x7c5>
  1015a7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015aa:	83 e0 01             	and    $0x1,%eax
  1015ad:	85 c0                	test   %eax,%eax
  1015af:	74 38                	je     1015e9 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  1015b1:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  1015b5:	74 06                	je     1015bd <printer_vprintf+0x799>
  1015b7:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1015bb:	75 2c                	jne    1015e9 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  1015bd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1015c2:	75 0c                	jne    1015d0 <printer_vprintf+0x7ac>
  1015c4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015c7:	25 00 01 00 00       	and    $0x100,%eax
  1015cc:	85 c0                	test   %eax,%eax
  1015ce:	74 19                	je     1015e9 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  1015d0:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1015d4:	75 07                	jne    1015dd <printer_vprintf+0x7b9>
  1015d6:	b8 ed 1a 10 00       	mov    $0x101aed,%eax
  1015db:	eb 05                	jmp    1015e2 <printer_vprintf+0x7be>
  1015dd:	b8 f0 1a 10 00       	mov    $0x101af0,%eax
  1015e2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1015e6:	eb 01                	jmp    1015e9 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  1015e8:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1015e9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1015ed:	78 24                	js     101613 <printer_vprintf+0x7ef>
  1015ef:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015f2:	83 e0 20             	and    $0x20,%eax
  1015f5:	85 c0                	test   %eax,%eax
  1015f7:	75 1a                	jne    101613 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  1015f9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1015fc:	48 63 d0             	movslq %eax,%rdx
  1015ff:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101603:	48 89 d6             	mov    %rdx,%rsi
  101606:	48 89 c7             	mov    %rax,%rdi
  101609:	e8 ea f5 ff ff       	call   100bf8 <strnlen>
  10160e:	89 45 bc             	mov    %eax,-0x44(%rbp)
  101611:	eb 0f                	jmp    101622 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  101613:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101617:	48 89 c7             	mov    %rax,%rdi
  10161a:	e8 a8 f5 ff ff       	call   100bc7 <strlen>
  10161f:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  101622:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101625:	83 e0 20             	and    $0x20,%eax
  101628:	85 c0                	test   %eax,%eax
  10162a:	74 20                	je     10164c <printer_vprintf+0x828>
  10162c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101630:	78 1a                	js     10164c <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  101632:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101635:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  101638:	7e 08                	jle    101642 <printer_vprintf+0x81e>
  10163a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10163d:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101640:	eb 05                	jmp    101647 <printer_vprintf+0x823>
  101642:	b8 00 00 00 00       	mov    $0x0,%eax
  101647:	89 45 b8             	mov    %eax,-0x48(%rbp)
  10164a:	eb 5c                	jmp    1016a8 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  10164c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10164f:	83 e0 20             	and    $0x20,%eax
  101652:	85 c0                	test   %eax,%eax
  101654:	74 4b                	je     1016a1 <printer_vprintf+0x87d>
  101656:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101659:	83 e0 02             	and    $0x2,%eax
  10165c:	85 c0                	test   %eax,%eax
  10165e:	74 41                	je     1016a1 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  101660:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101663:	83 e0 04             	and    $0x4,%eax
  101666:	85 c0                	test   %eax,%eax
  101668:	75 37                	jne    1016a1 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  10166a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10166e:	48 89 c7             	mov    %rax,%rdi
  101671:	e8 51 f5 ff ff       	call   100bc7 <strlen>
  101676:	89 c2                	mov    %eax,%edx
  101678:	8b 45 bc             	mov    -0x44(%rbp),%eax
  10167b:	01 d0                	add    %edx,%eax
  10167d:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  101680:	7e 1f                	jle    1016a1 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  101682:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101685:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101688:	89 c3                	mov    %eax,%ebx
  10168a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10168e:	48 89 c7             	mov    %rax,%rdi
  101691:	e8 31 f5 ff ff       	call   100bc7 <strlen>
  101696:	89 c2                	mov    %eax,%edx
  101698:	89 d8                	mov    %ebx,%eax
  10169a:	29 d0                	sub    %edx,%eax
  10169c:	89 45 b8             	mov    %eax,-0x48(%rbp)
  10169f:	eb 07                	jmp    1016a8 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  1016a1:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  1016a8:	8b 55 bc             	mov    -0x44(%rbp),%edx
  1016ab:	8b 45 b8             	mov    -0x48(%rbp),%eax
  1016ae:	01 d0                	add    %edx,%eax
  1016b0:	48 63 d8             	movslq %eax,%rbx
  1016b3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1016b7:	48 89 c7             	mov    %rax,%rdi
  1016ba:	e8 08 f5 ff ff       	call   100bc7 <strlen>
  1016bf:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  1016c3:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1016c6:	29 d0                	sub    %edx,%eax
  1016c8:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1016cb:	eb 25                	jmp    1016f2 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  1016cd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1016d4:	48 8b 08             	mov    (%rax),%rcx
  1016d7:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1016dd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1016e4:	be 20 00 00 00       	mov    $0x20,%esi
  1016e9:	48 89 c7             	mov    %rax,%rdi
  1016ec:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1016ee:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1016f2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1016f5:	83 e0 04             	and    $0x4,%eax
  1016f8:	85 c0                	test   %eax,%eax
  1016fa:	75 36                	jne    101732 <printer_vprintf+0x90e>
  1016fc:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101700:	7f cb                	jg     1016cd <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  101702:	eb 2e                	jmp    101732 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  101704:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10170b:	4c 8b 00             	mov    (%rax),%r8
  10170e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101712:	0f b6 00             	movzbl (%rax),%eax
  101715:	0f b6 c8             	movzbl %al,%ecx
  101718:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10171e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101725:	89 ce                	mov    %ecx,%esi
  101727:	48 89 c7             	mov    %rax,%rdi
  10172a:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  10172d:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  101732:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101736:	0f b6 00             	movzbl (%rax),%eax
  101739:	84 c0                	test   %al,%al
  10173b:	75 c7                	jne    101704 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  10173d:	eb 25                	jmp    101764 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  10173f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101746:	48 8b 08             	mov    (%rax),%rcx
  101749:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10174f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101756:	be 30 00 00 00       	mov    $0x30,%esi
  10175b:	48 89 c7             	mov    %rax,%rdi
  10175e:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  101760:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  101764:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101768:	7f d5                	jg     10173f <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  10176a:	eb 32                	jmp    10179e <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  10176c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101773:	4c 8b 00             	mov    (%rax),%r8
  101776:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10177a:	0f b6 00             	movzbl (%rax),%eax
  10177d:	0f b6 c8             	movzbl %al,%ecx
  101780:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101786:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10178d:	89 ce                	mov    %ecx,%esi
  10178f:	48 89 c7             	mov    %rax,%rdi
  101792:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101795:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  10179a:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  10179e:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  1017a2:	7f c8                	jg     10176c <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  1017a4:	eb 25                	jmp    1017cb <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  1017a6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1017ad:	48 8b 08             	mov    (%rax),%rcx
  1017b0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1017b6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1017bd:	be 20 00 00 00       	mov    $0x20,%esi
  1017c2:	48 89 c7             	mov    %rax,%rdi
  1017c5:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1017c7:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1017cb:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1017cf:	7f d5                	jg     1017a6 <printer_vprintf+0x982>
        }
    done: ;
  1017d1:	90                   	nop
    for (; *format; ++format) {
  1017d2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1017d9:	01 
  1017da:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1017e1:	0f b6 00             	movzbl (%rax),%eax
  1017e4:	84 c0                	test   %al,%al
  1017e6:	0f 85 64 f6 ff ff    	jne    100e50 <printer_vprintf+0x2c>
    }
}
  1017ec:	90                   	nop
  1017ed:	90                   	nop
  1017ee:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1017f2:	c9                   	leave  
  1017f3:	c3                   	ret    

00000000001017f4 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1017f4:	55                   	push   %rbp
  1017f5:	48 89 e5             	mov    %rsp,%rbp
  1017f8:	48 83 ec 20          	sub    $0x20,%rsp
  1017fc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101800:	89 f0                	mov    %esi,%eax
  101802:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101805:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101808:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10180c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101810:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101814:	48 8b 40 08          	mov    0x8(%rax),%rax
  101818:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  10181d:	48 39 d0             	cmp    %rdx,%rax
  101820:	72 0c                	jb     10182e <console_putc+0x3a>
        cp->cursor = console;
  101822:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101826:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  10182d:	00 
    }
    if (c == '\n') {
  10182e:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101832:	75 78                	jne    1018ac <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  101834:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101838:	48 8b 40 08          	mov    0x8(%rax),%rax
  10183c:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101842:	48 d1 f8             	sar    %rax
  101845:	48 89 c1             	mov    %rax,%rcx
  101848:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  10184f:	66 66 66 
  101852:	48 89 c8             	mov    %rcx,%rax
  101855:	48 f7 ea             	imul   %rdx
  101858:	48 c1 fa 05          	sar    $0x5,%rdx
  10185c:	48 89 c8             	mov    %rcx,%rax
  10185f:	48 c1 f8 3f          	sar    $0x3f,%rax
  101863:	48 29 c2             	sub    %rax,%rdx
  101866:	48 89 d0             	mov    %rdx,%rax
  101869:	48 c1 e0 02          	shl    $0x2,%rax
  10186d:	48 01 d0             	add    %rdx,%rax
  101870:	48 c1 e0 04          	shl    $0x4,%rax
  101874:	48 29 c1             	sub    %rax,%rcx
  101877:	48 89 ca             	mov    %rcx,%rdx
  10187a:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  10187d:	eb 25                	jmp    1018a4 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  10187f:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101882:	83 c8 20             	or     $0x20,%eax
  101885:	89 c6                	mov    %eax,%esi
  101887:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10188b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10188f:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101893:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101897:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10189b:	89 f2                	mov    %esi,%edx
  10189d:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  1018a0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1018a4:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1018a8:	75 d5                	jne    10187f <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  1018aa:	eb 24                	jmp    1018d0 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  1018ac:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  1018b0:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1018b3:	09 d0                	or     %edx,%eax
  1018b5:	89 c6                	mov    %eax,%esi
  1018b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1018bb:	48 8b 40 08          	mov    0x8(%rax),%rax
  1018bf:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1018c3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1018c7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1018cb:	89 f2                	mov    %esi,%edx
  1018cd:	66 89 10             	mov    %dx,(%rax)
}
  1018d0:	90                   	nop
  1018d1:	c9                   	leave  
  1018d2:	c3                   	ret    

00000000001018d3 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1018d3:	55                   	push   %rbp
  1018d4:	48 89 e5             	mov    %rsp,%rbp
  1018d7:	48 83 ec 30          	sub    $0x30,%rsp
  1018db:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1018de:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1018e1:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1018e5:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1018e9:	48 c7 45 f0 f4 17 10 	movq   $0x1017f4,-0x10(%rbp)
  1018f0:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1018f1:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1018f5:	78 09                	js     101900 <console_vprintf+0x2d>
  1018f7:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1018fe:	7e 07                	jle    101907 <console_vprintf+0x34>
        cpos = 0;
  101900:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101907:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10190a:	48 98                	cltq   
  10190c:	48 01 c0             	add    %rax,%rax
  10190f:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  101915:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101919:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  10191d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101921:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101924:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101928:	48 89 c7             	mov    %rax,%rdi
  10192b:	e8 f4 f4 ff ff       	call   100e24 <printer_vprintf>
    return cp.cursor - console;
  101930:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101934:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  10193a:	48 d1 f8             	sar    %rax
}
  10193d:	c9                   	leave  
  10193e:	c3                   	ret    

000000000010193f <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  10193f:	55                   	push   %rbp
  101940:	48 89 e5             	mov    %rsp,%rbp
  101943:	48 83 ec 60          	sub    $0x60,%rsp
  101947:	89 7d ac             	mov    %edi,-0x54(%rbp)
  10194a:	89 75 a8             	mov    %esi,-0x58(%rbp)
  10194d:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  101951:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101955:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101959:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10195d:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101964:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101968:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10196c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101970:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101974:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101978:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  10197c:	8b 75 a8             	mov    -0x58(%rbp),%esi
  10197f:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101982:	89 c7                	mov    %eax,%edi
  101984:	e8 4a ff ff ff       	call   1018d3 <console_vprintf>
  101989:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  10198c:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  10198f:	c9                   	leave  
  101990:	c3                   	ret    

0000000000101991 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101991:	55                   	push   %rbp
  101992:	48 89 e5             	mov    %rsp,%rbp
  101995:	48 83 ec 20          	sub    $0x20,%rsp
  101999:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10199d:	89 f0                	mov    %esi,%eax
  10199f:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1019a2:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1019a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1019a9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  1019ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1019b1:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1019b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1019b9:	48 8b 40 10          	mov    0x10(%rax),%rax
  1019bd:	48 39 c2             	cmp    %rax,%rdx
  1019c0:	73 1a                	jae    1019dc <string_putc+0x4b>
        *sp->s++ = c;
  1019c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1019c6:	48 8b 40 08          	mov    0x8(%rax),%rax
  1019ca:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1019ce:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1019d2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1019d6:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1019da:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1019dc:	90                   	nop
  1019dd:	c9                   	leave  
  1019de:	c3                   	ret    

00000000001019df <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1019df:	55                   	push   %rbp
  1019e0:	48 89 e5             	mov    %rsp,%rbp
  1019e3:	48 83 ec 40          	sub    $0x40,%rsp
  1019e7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1019eb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1019ef:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1019f3:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1019f7:	48 c7 45 e8 91 19 10 	movq   $0x101991,-0x18(%rbp)
  1019fe:	00 
    sp.s = s;
  1019ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101a03:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101a07:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101a0c:	74 33                	je     101a41 <vsnprintf+0x62>
        sp.end = s + size - 1;
  101a0e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101a12:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101a16:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101a1a:	48 01 d0             	add    %rdx,%rax
  101a1d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101a21:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101a25:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101a29:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101a2d:	be 00 00 00 00       	mov    $0x0,%esi
  101a32:	48 89 c7             	mov    %rax,%rdi
  101a35:	e8 ea f3 ff ff       	call   100e24 <printer_vprintf>
        *sp.s = 0;
  101a3a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101a3e:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101a41:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101a45:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101a49:	c9                   	leave  
  101a4a:	c3                   	ret    

0000000000101a4b <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101a4b:	55                   	push   %rbp
  101a4c:	48 89 e5             	mov    %rsp,%rbp
  101a4f:	48 83 ec 70          	sub    $0x70,%rsp
  101a53:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101a57:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101a5b:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101a5f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101a63:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101a67:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101a6b:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101a72:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101a76:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101a7a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101a7e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101a82:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101a86:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101a8a:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101a8e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101a92:	48 89 c7             	mov    %rax,%rdi
  101a95:	e8 45 ff ff ff       	call   1019df <vsnprintf>
  101a9a:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101a9d:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101aa0:	c9                   	leave  
  101aa1:	c3                   	ret    

0000000000101aa2 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101aa2:	55                   	push   %rbp
  101aa3:	48 89 e5             	mov    %rsp,%rbp
  101aa6:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101aaa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101ab1:	eb 13                	jmp    101ac6 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  101ab3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101ab6:	48 98                	cltq   
  101ab8:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  101abf:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101ac2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101ac6:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101acd:	7e e4                	jle    101ab3 <console_clear+0x11>
    }
    cursorpos = 0;
  101acf:	c7 05 23 75 fb ff 00 	movl   $0x0,-0x48add(%rip)        # b8ffc <cursorpos>
  101ad6:	00 00 00 
}
  101ad9:	90                   	nop
  101ada:	c9                   	leave  
  101adb:	c3                   	ret    
