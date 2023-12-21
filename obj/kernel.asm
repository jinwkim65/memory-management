
obj/kernel.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000040000 <entry_from_boot>:
# The entry_from_boot routine sets the stack pointer to the top of the
# OS kernel stack, then jumps to the `kernel` routine.

.globl entry_from_boot
entry_from_boot:
        movq $0x80000, %rsp
   40000:	48 c7 c4 00 00 08 00 	mov    $0x80000,%rsp
        movq %rsp, %rbp
   40007:	48 89 e5             	mov    %rsp,%rbp
        pushq $0
   4000a:	6a 00                	push   $0x0
        popfq
   4000c:	9d                   	popf   
        // Check for multiboot command line; if found pass it along.
        cmpl $0x2BADB002, %eax
   4000d:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
        jne 1f
   40012:	75 0d                	jne    40021 <entry_from_boot+0x21>
        testl $4, (%rbx)
   40014:	f7 03 04 00 00 00    	testl  $0x4,(%rbx)
        je 1f
   4001a:	74 05                	je     40021 <entry_from_boot+0x21>
        movl 16(%rbx), %edi
   4001c:	8b 7b 10             	mov    0x10(%rbx),%edi
        jmp 2f
   4001f:	eb 07                	jmp    40028 <entry_from_boot+0x28>
1:      movq $0, %rdi
   40021:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
2:      jmp kernel
   40028:	e9 3a 01 00 00       	jmp    40167 <kernel>
   4002d:	90                   	nop

000000000004002e <gpf_int_handler>:
# Interrupt handlers
.align 2

        .globl gpf_int_handler
gpf_int_handler:
        pushq $13               // trap number
   4002e:	6a 0d                	push   $0xd
        jmp generic_exception_handler
   40030:	eb 6e                	jmp    400a0 <generic_exception_handler>

0000000000040032 <pagefault_int_handler>:

        .globl pagefault_int_handler
pagefault_int_handler:
        pushq $14
   40032:	6a 0e                	push   $0xe
        jmp generic_exception_handler
   40034:	eb 6a                	jmp    400a0 <generic_exception_handler>

0000000000040036 <timer_int_handler>:

        .globl timer_int_handler
timer_int_handler:
        pushq $0                // error code
   40036:	6a 00                	push   $0x0
        pushq $32
   40038:	6a 20                	push   $0x20
        jmp generic_exception_handler
   4003a:	eb 64                	jmp    400a0 <generic_exception_handler>

000000000004003c <sys48_int_handler>:

sys48_int_handler:
        pushq $0
   4003c:	6a 00                	push   $0x0
        pushq $48
   4003e:	6a 30                	push   $0x30
        jmp generic_exception_handler
   40040:	eb 5e                	jmp    400a0 <generic_exception_handler>

0000000000040042 <sys49_int_handler>:

sys49_int_handler:
        pushq $0
   40042:	6a 00                	push   $0x0
        pushq $49
   40044:	6a 31                	push   $0x31
        jmp generic_exception_handler
   40046:	eb 58                	jmp    400a0 <generic_exception_handler>

0000000000040048 <sys50_int_handler>:

sys50_int_handler:
        pushq $0
   40048:	6a 00                	push   $0x0
        pushq $50
   4004a:	6a 32                	push   $0x32
        jmp generic_exception_handler
   4004c:	eb 52                	jmp    400a0 <generic_exception_handler>

000000000004004e <sys51_int_handler>:

sys51_int_handler:
        pushq $0
   4004e:	6a 00                	push   $0x0
        pushq $51
   40050:	6a 33                	push   $0x33
        jmp generic_exception_handler
   40052:	eb 4c                	jmp    400a0 <generic_exception_handler>

0000000000040054 <sys52_int_handler>:

sys52_int_handler:
        pushq $0
   40054:	6a 00                	push   $0x0
        pushq $52
   40056:	6a 34                	push   $0x34
        jmp generic_exception_handler
   40058:	eb 46                	jmp    400a0 <generic_exception_handler>

000000000004005a <sys53_int_handler>:

sys53_int_handler:
        pushq $0
   4005a:	6a 00                	push   $0x0
        pushq $53
   4005c:	6a 35                	push   $0x35
        jmp generic_exception_handler
   4005e:	eb 40                	jmp    400a0 <generic_exception_handler>

0000000000040060 <sys54_int_handler>:

sys54_int_handler:
        pushq $0
   40060:	6a 00                	push   $0x0
        pushq $54
   40062:	6a 36                	push   $0x36
        jmp generic_exception_handler
   40064:	eb 3a                	jmp    400a0 <generic_exception_handler>

0000000000040066 <sys55_int_handler>:

sys55_int_handler:
        pushq $0
   40066:	6a 00                	push   $0x0
        pushq $55
   40068:	6a 37                	push   $0x37
        jmp generic_exception_handler
   4006a:	eb 34                	jmp    400a0 <generic_exception_handler>

000000000004006c <sys56_int_handler>:

sys56_int_handler:
        pushq $0
   4006c:	6a 00                	push   $0x0
        pushq $56
   4006e:	6a 38                	push   $0x38
        jmp generic_exception_handler
   40070:	eb 2e                	jmp    400a0 <generic_exception_handler>

0000000000040072 <sys57_int_handler>:

sys57_int_handler:
        pushq $0
   40072:	6a 00                	push   $0x0
        pushq $57
   40074:	6a 39                	push   $0x39
        jmp generic_exception_handler
   40076:	eb 28                	jmp    400a0 <generic_exception_handler>

0000000000040078 <sys58_int_handler>:

sys58_int_handler:
        pushq $0
   40078:	6a 00                	push   $0x0
        pushq $58
   4007a:	6a 3a                	push   $0x3a
        jmp generic_exception_handler
   4007c:	eb 22                	jmp    400a0 <generic_exception_handler>

000000000004007e <sys59_int_handler>:

sys59_int_handler:
        pushq $0
   4007e:	6a 00                	push   $0x0
        pushq $59
   40080:	6a 3b                	push   $0x3b
        jmp generic_exception_handler
   40082:	eb 1c                	jmp    400a0 <generic_exception_handler>

0000000000040084 <sys60_int_handler>:

sys60_int_handler:
        pushq $0
   40084:	6a 00                	push   $0x0
        pushq $60
   40086:	6a 3c                	push   $0x3c
        jmp generic_exception_handler
   40088:	eb 16                	jmp    400a0 <generic_exception_handler>

000000000004008a <sys61_int_handler>:

sys61_int_handler:
        pushq $0
   4008a:	6a 00                	push   $0x0
        pushq $61
   4008c:	6a 3d                	push   $0x3d
        jmp generic_exception_handler
   4008e:	eb 10                	jmp    400a0 <generic_exception_handler>

0000000000040090 <sys62_int_handler>:

sys62_int_handler:
        pushq $0
   40090:	6a 00                	push   $0x0
        pushq $62
   40092:	6a 3e                	push   $0x3e
        jmp generic_exception_handler
   40094:	eb 0a                	jmp    400a0 <generic_exception_handler>

0000000000040096 <sys63_int_handler>:

sys63_int_handler:
        pushq $0
   40096:	6a 00                	push   $0x0
        pushq $63
   40098:	6a 3f                	push   $0x3f
        jmp generic_exception_handler
   4009a:	eb 04                	jmp    400a0 <generic_exception_handler>

000000000004009c <default_int_handler>:

        .globl default_int_handler
default_int_handler:
        pushq $0
   4009c:	6a 00                	push   $0x0
        jmp generic_exception_handler
   4009e:	eb 00                	jmp    400a0 <generic_exception_handler>

00000000000400a0 <generic_exception_handler>:


generic_exception_handler:
        pushq %gs
   400a0:	0f a8                	push   %gs
        pushq %fs
   400a2:	0f a0                	push   %fs
        pushq %r15
   400a4:	41 57                	push   %r15
        pushq %r14
   400a6:	41 56                	push   %r14
        pushq %r13
   400a8:	41 55                	push   %r13
        pushq %r12
   400aa:	41 54                	push   %r12
        pushq %r11
   400ac:	41 53                	push   %r11
        pushq %r10
   400ae:	41 52                	push   %r10
        pushq %r9
   400b0:	41 51                	push   %r9
        pushq %r8
   400b2:	41 50                	push   %r8
        pushq %rdi
   400b4:	57                   	push   %rdi
        pushq %rsi
   400b5:	56                   	push   %rsi
        pushq %rbp
   400b6:	55                   	push   %rbp
        pushq %rbx
   400b7:	53                   	push   %rbx
        pushq %rdx
   400b8:	52                   	push   %rdx
        pushq %rcx
   400b9:	51                   	push   %rcx
        pushq %rax
   400ba:	50                   	push   %rax
        movq %rsp, %rdi
   400bb:	48 89 e7             	mov    %rsp,%rdi
        call exception
   400be:	e8 62 06 00 00       	call   40725 <exception>

00000000000400c3 <exception_return>:
        # `exception` should never return.


        .globl exception_return
exception_return:
        movq %rdi, %rsp
   400c3:	48 89 fc             	mov    %rdi,%rsp
        popq %rax
   400c6:	58                   	pop    %rax
        popq %rcx
   400c7:	59                   	pop    %rcx
        popq %rdx
   400c8:	5a                   	pop    %rdx
        popq %rbx
   400c9:	5b                   	pop    %rbx
        popq %rbp
   400ca:	5d                   	pop    %rbp
        popq %rsi
   400cb:	5e                   	pop    %rsi
        popq %rdi
   400cc:	5f                   	pop    %rdi
        popq %r8
   400cd:	41 58                	pop    %r8
        popq %r9
   400cf:	41 59                	pop    %r9
        popq %r10
   400d1:	41 5a                	pop    %r10
        popq %r11
   400d3:	41 5b                	pop    %r11
        popq %r12
   400d5:	41 5c                	pop    %r12
        popq %r13
   400d7:	41 5d                	pop    %r13
        popq %r14
   400d9:	41 5e                	pop    %r14
        popq %r15
   400db:	41 5f                	pop    %r15
        popq %fs
   400dd:	0f a1                	pop    %fs
        popq %gs
   400df:	0f a9                	pop    %gs
        addq $16, %rsp
   400e1:	48 83 c4 10          	add    $0x10,%rsp
        iretq
   400e5:	48 cf                	iretq  

00000000000400e7 <sys_int_handlers>:
   400e7:	3c 00                	cmp    $0x0,%al
   400e9:	04 00                	add    $0x0,%al
   400eb:	00 00                	add    %al,(%rax)
   400ed:	00 00                	add    %al,(%rax)
   400ef:	42 00 04 00          	add    %al,(%rax,%r8,1)
   400f3:	00 00                	add    %al,(%rax)
   400f5:	00 00                	add    %al,(%rax)
   400f7:	48 00 04 00          	rex.W add %al,(%rax,%rax,1)
   400fb:	00 00                	add    %al,(%rax)
   400fd:	00 00                	add    %al,(%rax)
   400ff:	4e 00 04 00          	rex.WRX add %r8b,(%rax,%r8,1)
   40103:	00 00                	add    %al,(%rax)
   40105:	00 00                	add    %al,(%rax)
   40107:	54                   	push   %rsp
   40108:	00 04 00             	add    %al,(%rax,%rax,1)
   4010b:	00 00                	add    %al,(%rax)
   4010d:	00 00                	add    %al,(%rax)
   4010f:	5a                   	pop    %rdx
   40110:	00 04 00             	add    %al,(%rax,%rax,1)
   40113:	00 00                	add    %al,(%rax)
   40115:	00 00                	add    %al,(%rax)
   40117:	60                   	(bad)  
   40118:	00 04 00             	add    %al,(%rax,%rax,1)
   4011b:	00 00                	add    %al,(%rax)
   4011d:	00 00                	add    %al,(%rax)
   4011f:	66 00 04 00          	data16 add %al,(%rax,%rax,1)
   40123:	00 00                	add    %al,(%rax)
   40125:	00 00                	add    %al,(%rax)
   40127:	6c                   	insb   (%dx),%es:(%rdi)
   40128:	00 04 00             	add    %al,(%rax,%rax,1)
   4012b:	00 00                	add    %al,(%rax)
   4012d:	00 00                	add    %al,(%rax)
   4012f:	72 00                	jb     40131 <sys_int_handlers+0x4a>
   40131:	04 00                	add    $0x0,%al
   40133:	00 00                	add    %al,(%rax)
   40135:	00 00                	add    %al,(%rax)
   40137:	78 00                	js     40139 <sys_int_handlers+0x52>
   40139:	04 00                	add    $0x0,%al
   4013b:	00 00                	add    %al,(%rax)
   4013d:	00 00                	add    %al,(%rax)
   4013f:	7e 00                	jle    40141 <sys_int_handlers+0x5a>
   40141:	04 00                	add    $0x0,%al
   40143:	00 00                	add    %al,(%rax)
   40145:	00 00                	add    %al,(%rax)
   40147:	84 00                	test   %al,(%rax)
   40149:	04 00                	add    $0x0,%al
   4014b:	00 00                	add    %al,(%rax)
   4014d:	00 00                	add    %al,(%rax)
   4014f:	8a 00                	mov    (%rax),%al
   40151:	04 00                	add    $0x0,%al
   40153:	00 00                	add    %al,(%rax)
   40155:	00 00                	add    %al,(%rax)
   40157:	90                   	nop
   40158:	00 04 00             	add    %al,(%rax,%rax,1)
   4015b:	00 00                	add    %al,(%rax)
   4015d:	00 00                	add    %al,(%rax)
   4015f:	96                   	xchg   %eax,%esi
   40160:	00 04 00             	add    %al,(%rax,%rax,1)
   40163:	00 00                	add    %al,(%rax)
	...

0000000000040167 <kernel>:

// kernel(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

void kernel(const char* command) {
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 20          	sub    $0x20,%rsp
   4016f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40173:	e8 b1 14 00 00       	call   41629 <hardware_init>
    pageinfo_init();
   40178:	e8 25 0b 00 00       	call   40ca2 <pageinfo_init>
    console_clear();
   4017d:	e8 88 4a 00 00       	call   44c0a <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 89 19 00 00       	call   41b15 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 00 f0 04 00       	mov    $0x4f000,%edi
   4019b:	e8 50 3b 00 00       	call   43cf0 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401a7:	eb 44                	jmp    401ed <kernel+0x86>
        processes[i].p_pid = i;
   401a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401ac:	48 63 d0             	movslq %eax,%rdx
   401af:	48 89 d0             	mov    %rdx,%rax
   401b2:	48 c1 e0 04          	shl    $0x4,%rax
   401b6:	48 29 d0             	sub    %rdx,%rax
   401b9:	48 c1 e0 04          	shl    $0x4,%rax
   401bd:	48 8d 90 00 f0 04 00 	lea    0x4f000(%rax),%rdx
   401c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401c7:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401cc:	48 63 d0             	movslq %eax,%rdx
   401cf:	48 89 d0             	mov    %rdx,%rax
   401d2:	48 c1 e0 04          	shl    $0x4,%rax
   401d6:	48 29 d0             	sub    %rdx,%rax
   401d9:	48 c1 e0 04          	shl    $0x4,%rax
   401dd:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   401e3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   401e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ed:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   401f1:	7e b6                	jle    401a9 <kernel+0x42>
    }

    if (command && strcmp(command, "malloc") == 0) {
   401f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   401f8:	74 29                	je     40223 <kernel+0xbc>
   401fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   401fe:	be 86 4c 04 00       	mov    $0x44c86,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 de 3b 00 00       	call   43de9 <strcmp>
   4020b:	85 c0                	test   %eax,%eax
   4020d:	75 14                	jne    40223 <kernel+0xbc>
        process_setup(1, 1);
   4020f:	be 01 00 00 00       	mov    $0x1,%esi
   40214:	bf 01 00 00 00       	mov    $0x1,%edi
   40219:	e8 b8 00 00 00       	call   402d6 <process_setup>
   4021e:	e9 a9 00 00 00       	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "alloctests") == 0) {
   40223:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40228:	74 26                	je     40250 <kernel+0xe9>
   4022a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4022e:	be 8d 4c 04 00       	mov    $0x44c8d,%esi
   40233:	48 89 c7             	mov    %rax,%rdi
   40236:	e8 ae 3b 00 00       	call   43de9 <strcmp>
   4023b:	85 c0                	test   %eax,%eax
   4023d:	75 11                	jne    40250 <kernel+0xe9>
        process_setup(1, 2);
   4023f:	be 02 00 00 00       	mov    $0x2,%esi
   40244:	bf 01 00 00 00       	mov    $0x1,%edi
   40249:	e8 88 00 00 00       	call   402d6 <process_setup>
   4024e:	eb 7c                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test") == 0){
   40250:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40255:	74 26                	je     4027d <kernel+0x116>
   40257:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4025b:	be 98 4c 04 00       	mov    $0x44c98,%esi
   40260:	48 89 c7             	mov    %rax,%rdi
   40263:	e8 81 3b 00 00       	call   43de9 <strcmp>
   40268:	85 c0                	test   %eax,%eax
   4026a:	75 11                	jne    4027d <kernel+0x116>
        process_setup(1, 3);
   4026c:	be 03 00 00 00       	mov    $0x3,%esi
   40271:	bf 01 00 00 00       	mov    $0x1,%edi
   40276:	e8 5b 00 00 00       	call   402d6 <process_setup>
   4027b:	eb 4f                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test2") == 0) {
   4027d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40282:	74 39                	je     402bd <kernel+0x156>
   40284:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40288:	be 9d 4c 04 00       	mov    $0x44c9d,%esi
   4028d:	48 89 c7             	mov    %rax,%rdi
   40290:	e8 54 3b 00 00       	call   43de9 <strcmp>
   40295:	85 c0                	test   %eax,%eax
   40297:	75 24                	jne    402bd <kernel+0x156>
        for (pid_t i = 1; i <= 2; ++i) {
   40299:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402a0:	eb 13                	jmp    402b5 <kernel+0x14e>
            process_setup(i, 3);
   402a2:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402a5:	be 03 00 00 00       	mov    $0x3,%esi
   402aa:	89 c7                	mov    %eax,%edi
   402ac:	e8 25 00 00 00       	call   402d6 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402b1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   402b5:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   402b9:	7e e7                	jle    402a2 <kernel+0x13b>
   402bb:	eb 0f                	jmp    402cc <kernel+0x165>
        }
    } else {
        process_setup(1, 0);
   402bd:	be 00 00 00 00       	mov    $0x0,%esi
   402c2:	bf 01 00 00 00       	mov    $0x1,%edi
   402c7:	e8 0a 00 00 00       	call   402d6 <process_setup>
    }

    // Switch to the first process using run()
    run(&processes[1]);
   402cc:	bf f0 f0 04 00       	mov    $0x4f0f0,%edi
   402d1:	e8 3b 09 00 00       	call   40c11 <run>

00000000000402d6 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   402d6:	55                   	push   %rbp
   402d7:	48 89 e5             	mov    %rsp,%rbp
   402da:	48 83 ec 10          	sub    $0x10,%rsp
   402de:	89 7d fc             	mov    %edi,-0x4(%rbp)
   402e1:	89 75 f8             	mov    %esi,-0x8(%rbp)
    process_init(&processes[pid], 0);
   402e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402e7:	48 63 d0             	movslq %eax,%rdx
   402ea:	48 89 d0             	mov    %rdx,%rax
   402ed:	48 c1 e0 04          	shl    $0x4,%rax
   402f1:	48 29 d0             	sub    %rdx,%rax
   402f4:	48 c1 e0 04          	shl    $0x4,%rax
   402f8:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   402fe:	be 00 00 00 00       	mov    $0x0,%esi
   40303:	48 89 c7             	mov    %rax,%rdi
   40306:	e8 9b 1a 00 00       	call   41da6 <process_init>
    assert(process_config_tables(pid) == 0);
   4030b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4030e:	89 c7                	mov    %eax,%edi
   40310:	e8 a4 31 00 00       	call   434b9 <process_config_tables>
   40315:	85 c0                	test   %eax,%eax
   40317:	74 14                	je     4032d <process_setup+0x57>
   40319:	ba a8 4c 04 00       	mov    $0x44ca8,%edx
   4031e:	be 77 00 00 00       	mov    $0x77,%esi
   40323:	bf c8 4c 04 00       	mov    $0x44cc8,%edi
   40328:	e8 47 22 00 00       	call   42574 <assert_fail>

    /* Calls program_load in k-loader */
    assert(process_load(&processes[pid], program_number) >= 0);
   4032d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40330:	48 63 d0             	movslq %eax,%rdx
   40333:	48 89 d0             	mov    %rdx,%rax
   40336:	48 c1 e0 04          	shl    $0x4,%rax
   4033a:	48 29 d0             	sub    %rdx,%rax
   4033d:	48 c1 e0 04          	shl    $0x4,%rax
   40341:	48 8d 90 00 f0 04 00 	lea    0x4f000(%rax),%rdx
   40348:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4034b:	89 c6                	mov    %eax,%esi
   4034d:	48 89 d7             	mov    %rdx,%rdi
   40350:	e8 b2 34 00 00       	call   43807 <process_load>
   40355:	85 c0                	test   %eax,%eax
   40357:	79 14                	jns    4036d <process_setup+0x97>
   40359:	ba d8 4c 04 00       	mov    $0x44cd8,%edx
   4035e:	be 7a 00 00 00       	mov    $0x7a,%esi
   40363:	bf c8 4c 04 00       	mov    $0x44cc8,%edi
   40368:	e8 07 22 00 00       	call   42574 <assert_fail>

    process_setup_stack(&processes[pid]);
   4036d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40370:	48 63 d0             	movslq %eax,%rdx
   40373:	48 89 d0             	mov    %rdx,%rax
   40376:	48 c1 e0 04          	shl    $0x4,%rax
   4037a:	48 29 d0             	sub    %rdx,%rax
   4037d:	48 c1 e0 04          	shl    $0x4,%rax
   40381:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   40387:	48 89 c7             	mov    %rax,%rdi
   4038a:	e8 b0 34 00 00       	call   4383f <process_setup_stack>

    processes[pid].p_state = P_RUNNABLE;
   4038f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40392:	48 63 d0             	movslq %eax,%rdx
   40395:	48 89 d0             	mov    %rdx,%rax
   40398:	48 c1 e0 04          	shl    $0x4,%rax
   4039c:	48 29 d0             	sub    %rdx,%rax
   4039f:	48 c1 e0 04          	shl    $0x4,%rax
   403a3:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   403a9:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   403af:	90                   	nop
   403b0:	c9                   	leave  
   403b1:	c3                   	ret    

00000000000403b2 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   403b2:	55                   	push   %rbp
   403b3:	48 89 e5             	mov    %rsp,%rbp
   403b6:	48 83 ec 10          	sub    $0x10,%rsp
   403ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   403be:	89 f0                	mov    %esi,%eax
   403c0:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   403c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403c7:	25 ff 0f 00 00       	and    $0xfff,%eax
   403cc:	48 85 c0             	test   %rax,%rax
   403cf:	75 20                	jne    403f1 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   403d1:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   403d8:	00 
   403d9:	77 16                	ja     403f1 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   403db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403df:	48 c1 e8 0c          	shr    $0xc,%rax
   403e3:	48 98                	cltq   
   403e5:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   403ec:	00 
   403ed:	84 c0                	test   %al,%al
   403ef:	74 07                	je     403f8 <assign_physical_page+0x46>
        return -1;
   403f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   403f6:	eb 2c                	jmp    40424 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   403f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403fc:	48 c1 e8 0c          	shr    $0xc,%rax
   40400:	48 98                	cltq   
   40402:	c6 84 00 21 ff 04 00 	movb   $0x1,0x4ff21(%rax,%rax,1)
   40409:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4040a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4040e:	48 c1 e8 0c          	shr    $0xc,%rax
   40412:	48 98                	cltq   
   40414:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40418:	88 94 00 20 ff 04 00 	mov    %dl,0x4ff20(%rax,%rax,1)
        return 0;
   4041f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40424:	c9                   	leave  
   40425:	c3                   	ret    

0000000000040426 <syscall_fork>:

pid_t syscall_fork() {
   40426:	55                   	push   %rbp
   40427:	48 89 e5             	mov    %rsp,%rbp
    return process_fork(current);
   4042a:	48 8b 05 cf fa 00 00 	mov    0xfacf(%rip),%rax        # 4ff00 <current>
   40431:	48 89 c7             	mov    %rax,%rdi
   40434:	e8 b9 34 00 00       	call   438f2 <process_fork>
}
   40439:	5d                   	pop    %rbp
   4043a:	c3                   	ret    

000000000004043b <syscall_exit>:


void syscall_exit() {
   4043b:	55                   	push   %rbp
   4043c:	48 89 e5             	mov    %rsp,%rbp
    process_free(current->p_pid);
   4043f:	48 8b 05 ba fa 00 00 	mov    0xfaba(%rip),%rax        # 4ff00 <current>
   40446:	8b 00                	mov    (%rax),%eax
   40448:	89 c7                	mov    %eax,%edi
   4044a:	e8 88 2d 00 00       	call   431d7 <process_free>
}
   4044f:	90                   	nop
   40450:	5d                   	pop    %rbp
   40451:	c3                   	ret    

0000000000040452 <syscall_page_alloc>:

int syscall_page_alloc(uintptr_t addr) {
   40452:	55                   	push   %rbp
   40453:	48 89 e5             	mov    %rsp,%rbp
   40456:	48 83 ec 10          	sub    $0x10,%rsp
   4045a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return process_page_alloc(current, addr);
   4045e:	48 8b 05 9b fa 00 00 	mov    0xfa9b(%rip),%rax        # 4ff00 <current>
   40465:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40469:	48 89 d6             	mov    %rdx,%rsi
   4046c:	48 89 c7             	mov    %rax,%rdi
   4046f:	e8 10 37 00 00       	call   43b84 <process_page_alloc>
}
   40474:	c9                   	leave  
   40475:	c3                   	ret    

0000000000040476 <unmap>:

// Helper function to unmap a page
void unmap(int pn) {
   40476:	55                   	push   %rbp
   40477:	48 89 e5             	mov    %rsp,%rbp
   4047a:	48 83 ec 08          	sub    $0x8,%rsp
   4047e:	89 7d fc             	mov    %edi,-0x4(%rbp)
    pageinfo[pn].refcount--;
   40481:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40484:	48 98                	cltq   
   40486:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   4048d:	00 
   4048e:	83 e8 01             	sub    $0x1,%eax
   40491:	89 c2                	mov    %eax,%edx
   40493:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40496:	48 98                	cltq   
   40498:	88 94 00 21 ff 04 00 	mov    %dl,0x4ff21(%rax,%rax,1)
    if (pageinfo[pn].refcount == 0) {
   4049f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   404a2:	48 98                	cltq   
   404a4:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   404ab:	00 
   404ac:	84 c0                	test   %al,%al
   404ae:	75 0d                	jne    404bd <unmap+0x47>
        pageinfo[pn].owner = PO_FREE;
   404b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   404b3:	48 98                	cltq   
   404b5:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   404bc:	00 
    }
}
   404bd:	90                   	nop
   404be:	c9                   	leave  
   404bf:	c3                   	ret    

00000000000404c0 <sbrk>:

int sbrk(proc * p, intptr_t difference) {
   404c0:	55                   	push   %rbp
   404c1:	48 89 e5             	mov    %rsp,%rbp
   404c4:	48 83 ec 60          	sub    $0x60,%rsp
   404c8:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   404cc:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
    // TODO : Your code here
    uintptr_t old_break = p->program_break;
   404d0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   404d4:	48 8b 40 08          	mov    0x8(%rax),%rax
   404d8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t new_break = p->program_break + difference;
   404dc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   404e0:	48 8b 50 08          	mov    0x8(%rax),%rdx
   404e4:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   404e8:	48 01 d0             	add    %rdx,%rax
   404eb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    
    // Error cases
    if (new_break >= MEMSIZE_VIRTUAL - PAGESIZE || new_break < p->original_break) {
   404ef:	48 81 7d e8 ff ef 2f 	cmpq   $0x2fefff,-0x18(%rbp)
   404f6:	00 
   404f7:	77 0e                	ja     40507 <sbrk+0x47>
   404f9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   404fd:	48 8b 40 10          	mov    0x10(%rax),%rax
   40501:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40505:	73 0a                	jae    40511 <sbrk+0x51>
        return -1;
   40507:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4050c:	e9 c6 00 00 00       	jmp    405d7 <sbrk+0x117>
    }
    // Deallocate memory if difference is negative
    if (difference < 0) {
   40511:	48 83 7d a0 00       	cmpq   $0x0,-0x60(%rbp)
   40516:	0f 89 ab 00 00 00    	jns    405c7 <sbrk+0x107>
        for (uintptr_t va = ROUNDUP(new_break, PAGESIZE); va <= ROUNDDOWN(old_break, PAGESIZE); va += PAGESIZE) {
   4051c:	48 c7 45 e0 00 10 00 	movq   $0x1000,-0x20(%rbp)
   40523:	00 
   40524:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40528:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4052c:	48 01 d0             	add    %rdx,%rax
   4052f:	48 83 e8 01          	sub    $0x1,%rax
   40533:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   40537:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4053b:	ba 00 00 00 00       	mov    $0x0,%edx
   40540:	48 f7 75 e0          	divq   -0x20(%rbp)
   40544:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40548:	48 29 d0             	sub    %rdx,%rax
   4054b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4054f:	eb 5e                	jmp    405af <sbrk+0xef>
            vamapping info = virtual_memory_lookup(p->p_pagetable, va);
   40551:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40555:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4055c:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40560:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40564:	48 89 ce             	mov    %rcx,%rsi
   40567:	48 89 c7             	mov    %rax,%rdi
   4056a:	e8 c7 26 00 00       	call   42c36 <virtual_memory_lookup>
            if (info.pn >= 0) {
   4056f:	8b 45 b8             	mov    -0x48(%rbp),%eax
   40572:	85 c0                	test   %eax,%eax
   40574:	78 31                	js     405a7 <sbrk+0xe7>
                unmap(info.pn);
   40576:	8b 45 b8             	mov    -0x48(%rbp),%eax
   40579:	89 c7                	mov    %eax,%edi
   4057b:	e8 f6 fe ff ff       	call   40476 <unmap>
                virtual_memory_map(p->p_pagetable, va, 0, PAGESIZE, PTE_W | PTE_U);
   40580:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40584:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4058b:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   4058f:	41 b8 06 00 00 00    	mov    $0x6,%r8d
   40595:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4059a:	ba 00 00 00 00       	mov    $0x0,%edx
   4059f:	48 89 c7             	mov    %rax,%rdi
   405a2:	e8 cc 22 00 00       	call   42873 <virtual_memory_map>
        for (uintptr_t va = ROUNDUP(new_break, PAGESIZE); va <= ROUNDDOWN(old_break, PAGESIZE); va += PAGESIZE) {
   405a7:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   405ae:	00 
   405af:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   405b3:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   405b7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   405bb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   405c1:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
   405c5:	73 8a                	jae    40551 <sbrk+0x91>
            }
        }
    }
    // Update break
    p->program_break = new_break;
   405c7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   405cb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   405cf:	48 89 50 08          	mov    %rdx,0x8(%rax)
    return old_break;
   405d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
   405d7:	c9                   	leave  
   405d8:	c3                   	ret    

00000000000405d9 <syscall_mapping>:


void syscall_mapping(proc* p){
   405d9:	55                   	push   %rbp
   405da:	48 89 e5             	mov    %rsp,%rbp
   405dd:	48 83 ec 70          	sub    $0x70,%rsp
   405e1:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   405e5:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   405e9:	48 8b 40 48          	mov    0x48(%rax),%rax
   405ed:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   405f1:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   405f5:	48 8b 40 40          	mov    0x40(%rax),%rax
   405f9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   405fd:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40601:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40608:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4060c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40610:	48 89 ce             	mov    %rcx,%rsi
   40613:	48 89 c7             	mov    %rax,%rdi
   40616:	e8 1b 26 00 00       	call   42c36 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   4061b:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4061e:	48 98                	cltq   
   40620:	83 e0 06             	and    $0x6,%eax
   40623:	48 83 f8 06          	cmp    $0x6,%rax
   40627:	0f 85 89 00 00 00    	jne    406b6 <syscall_mapping+0xdd>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   4062d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40631:	48 83 c0 17          	add    $0x17,%rax
   40635:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if (PAGENUMBER(endaddr) != PAGENUMBER(ptr)){
   40639:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4063d:	48 c1 e8 0c          	shr    $0xc,%rax
   40641:	89 c2                	mov    %eax,%edx
   40643:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40647:	48 c1 e8 0c          	shr    $0xc,%rax
   4064b:	39 c2                	cmp    %eax,%edx
   4064d:	74 2c                	je     4067b <syscall_mapping+0xa2>
        vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   4064f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40653:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4065a:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4065e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40662:	48 89 ce             	mov    %rcx,%rsi
   40665:	48 89 c7             	mov    %rax,%rdi
   40668:	e8 c9 25 00 00       	call   42c36 <virtual_memory_lookup>
        // check for write access for end address
        if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   4066d:	8b 45 b0             	mov    -0x50(%rbp),%eax
   40670:	48 98                	cltq   
   40672:	83 e0 03             	and    $0x3,%eax
   40675:	48 83 f8 03          	cmp    $0x3,%rax
   40679:	75 3e                	jne    406b9 <syscall_mapping+0xe0>
            return; 
    }
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   4067b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4067f:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40686:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   4068a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4068e:	48 89 ce             	mov    %rcx,%rsi
   40691:	48 89 c7             	mov    %rax,%rdi
   40694:	e8 9d 25 00 00       	call   42c36 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40699:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4069d:	48 89 c1             	mov    %rax,%rcx
   406a0:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   406a4:	ba 18 00 00 00       	mov    $0x18,%edx
   406a9:	48 89 c6             	mov    %rax,%rsi
   406ac:	48 89 cf             	mov    %rcx,%rdi
   406af:	e8 3e 35 00 00       	call   43bf2 <memcpy>
   406b4:	eb 04                	jmp    406ba <syscall_mapping+0xe1>
        return;
   406b6:	90                   	nop
   406b7:	eb 01                	jmp    406ba <syscall_mapping+0xe1>
            return; 
   406b9:	90                   	nop
}
   406ba:	c9                   	leave  
   406bb:	c3                   	ret    

00000000000406bc <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   406bc:	55                   	push   %rbp
   406bd:	48 89 e5             	mov    %rsp,%rbp
   406c0:	48 83 ec 18          	sub    $0x18,%rsp
   406c4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   406c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   406cc:	48 8b 40 48          	mov    0x48(%rax),%rax
   406d0:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   406d3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   406d7:	75 14                	jne    406ed <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   406d9:	0f b6 05 20 59 00 00 	movzbl 0x5920(%rip),%eax        # 46000 <disp_global>
   406e0:	84 c0                	test   %al,%al
   406e2:	0f 94 c0             	sete   %al
   406e5:	88 05 15 59 00 00    	mov    %al,0x5915(%rip)        # 46000 <disp_global>
   406eb:	eb 36                	jmp    40723 <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   406ed:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   406f1:	78 2f                	js     40722 <syscall_mem_tog+0x66>
   406f3:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   406f7:	7f 29                	jg     40722 <syscall_mem_tog+0x66>
   406f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   406fd:	8b 00                	mov    (%rax),%eax
   406ff:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40702:	75 1e                	jne    40722 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   40704:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40708:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   4070f:	84 c0                	test   %al,%al
   40711:	0f 94 c0             	sete   %al
   40714:	89 c2                	mov    %eax,%edx
   40716:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4071a:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   40720:	eb 01                	jmp    40723 <syscall_mem_tog+0x67>
            return;
   40722:	90                   	nop
    }
}
   40723:	c9                   	leave  
   40724:	c3                   	ret    

0000000000040725 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40725:	55                   	push   %rbp
   40726:	48 89 e5             	mov    %rsp,%rbp
   40729:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
   40730:	48 89 bd f8 fe ff ff 	mov    %rdi,-0x108(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40737:	48 8b 05 c2 f7 00 00 	mov    0xf7c2(%rip),%rax        # 4ff00 <current>
   4073e:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
   40745:	48 83 c0 18          	add    $0x18,%rax
   40749:	48 89 d6             	mov    %rdx,%rsi
   4074c:	ba 18 00 00 00       	mov    $0x18,%edx
   40751:	48 89 c7             	mov    %rax,%rdi
   40754:	48 89 d1             	mov    %rdx,%rcx
   40757:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   4075a:	48 8b 05 9f 18 01 00 	mov    0x1189f(%rip),%rax        # 52000 <kernel_pagetable>
   40761:	48 89 c7             	mov    %rax,%rdi
   40764:	e8 d9 1f 00 00       	call   42742 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40769:	8b 05 8d 88 07 00    	mov    0x7888d(%rip),%eax        # b8ffc <cursorpos>
   4076f:	89 c7                	mov    %eax,%edi
   40771:	e8 fa 16 00 00       	call   41e70 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT
   40776:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   4077d:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40784:	48 83 f8 0e          	cmp    $0xe,%rax
   40788:	74 14                	je     4079e <exception+0x79>
        && reg->reg_intno != INT_GPF)
   4078a:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40791:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40798:	48 83 f8 0d          	cmp    $0xd,%rax
   4079c:	75 16                	jne    407b4 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) {
   4079e:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   407a5:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   407ac:	83 e0 04             	and    $0x4,%eax
   407af:	48 85 c0             	test   %rax,%rax
   407b2:	74 1a                	je     407ce <exception+0xa9>
        check_virtual_memory();
   407b4:	e8 80 08 00 00       	call   41039 <check_virtual_memory>
        if(disp_global){
   407b9:	0f b6 05 40 58 00 00 	movzbl 0x5840(%rip),%eax        # 46000 <disp_global>
   407c0:	84 c0                	test   %al,%al
   407c2:	74 0a                	je     407ce <exception+0xa9>
            memshow_physical();
   407c4:	e8 e8 09 00 00       	call   411b1 <memshow_physical>
            memshow_virtual_animate();
   407c9:	e8 12 0d 00 00       	call   414e0 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   407ce:	e8 80 1b 00 00       	call   42353 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   407d3:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   407da:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   407e1:	48 83 e8 0e          	sub    $0xe,%rax
   407e5:	48 83 f8 2c          	cmp    $0x2c,%rax
   407e9:	0f 87 71 03 00 00    	ja     40b60 <exception+0x43b>
   407ef:	48 8b 04 c5 98 4d 04 	mov    0x44d98(,%rax,8),%rax
   407f6:	00 
   407f7:	ff e0                	jmp    *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   407f9:	48 8b 05 00 f7 00 00 	mov    0xf700(%rip),%rax        # 4ff00 <current>
   40800:	48 8b 40 48          	mov    0x48(%rax),%rax
   40804:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
                    if((void *)addr == NULL)
   40808:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4080d:	75 0f                	jne    4081e <exception+0xf9>
                        kernel_panic(NULL);
   4080f:	bf 00 00 00 00       	mov    $0x0,%edi
   40814:	b8 00 00 00 00       	mov    $0x0,%eax
   40819:	e8 76 1c 00 00       	call   42494 <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   4081e:	48 8b 05 db f6 00 00 	mov    0xf6db(%rip),%rax        # 4ff00 <current>
   40825:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4082c:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40830:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40834:	48 89 ce             	mov    %rcx,%rsi
   40837:	48 89 c7             	mov    %rax,%rdi
   4083a:	e8 f7 23 00 00       	call   42c36 <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   4083f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40843:	48 89 c1             	mov    %rax,%rcx
   40846:	48 8d 85 00 ff ff ff 	lea    -0x100(%rbp),%rax
   4084d:	ba a0 00 00 00       	mov    $0xa0,%edx
   40852:	48 89 ce             	mov    %rcx,%rsi
   40855:	48 89 c7             	mov    %rax,%rdi
   40858:	e8 95 33 00 00       	call   43bf2 <memcpy>
                    kernel_panic(msg);
   4085d:	48 8d 85 00 ff ff ff 	lea    -0x100(%rbp),%rax
   40864:	48 89 c7             	mov    %rax,%rdi
   40867:	b8 00 00 00 00       	mov    $0x0,%eax
   4086c:	e8 23 1c 00 00       	call   42494 <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   40871:	48 8b 05 88 f6 00 00 	mov    0xf688(%rip),%rax        # 4ff00 <current>
   40878:	8b 10                	mov    (%rax),%edx
   4087a:	48 8b 05 7f f6 00 00 	mov    0xf67f(%rip),%rax        # 4ff00 <current>
   40881:	48 63 d2             	movslq %edx,%rdx
   40884:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   40888:	e9 e5 02 00 00       	jmp    40b72 <exception+0x44d>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   4088d:	b8 00 00 00 00       	mov    $0x0,%eax
   40892:	e8 8f fb ff ff       	call   40426 <syscall_fork>
   40897:	89 c2                	mov    %eax,%edx
   40899:	48 8b 05 60 f6 00 00 	mov    0xf660(%rip),%rax        # 4ff00 <current>
   408a0:	48 63 d2             	movslq %edx,%rdx
   408a3:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   408a7:	e9 c6 02 00 00       	jmp    40b72 <exception+0x44d>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   408ac:	48 8b 05 4d f6 00 00 	mov    0xf64d(%rip),%rax        # 4ff00 <current>
   408b3:	48 89 c7             	mov    %rax,%rdi
   408b6:	e8 1e fd ff ff       	call   405d9 <syscall_mapping>
                break;
   408bb:	e9 b2 02 00 00       	jmp    40b72 <exception+0x44d>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   408c0:	b8 00 00 00 00       	mov    $0x0,%eax
   408c5:	e8 71 fb ff ff       	call   4043b <syscall_exit>
                schedule();
   408ca:	e8 cc 02 00 00       	call   40b9b <schedule>
                break;
   408cf:	e9 9e 02 00 00       	jmp    40b72 <exception+0x44d>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   408d4:	e8 c2 02 00 00       	call   40b9b <schedule>
                break;                  /* will not be reached */
   408d9:	e9 94 02 00 00       	jmp    40b72 <exception+0x44d>

        case INT_SYS_BRK:
            {
                // TODO : Your code here

                int result = sbrk(current, (intptr_t) reg->reg_rdi - (intptr_t) current->program_break);
   408de:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   408e5:	48 8b 40 30          	mov    0x30(%rax),%rax
   408e9:	48 89 c2             	mov    %rax,%rdx
   408ec:	48 8b 05 0d f6 00 00 	mov    0xf60d(%rip),%rax        # 4ff00 <current>
   408f3:	48 8b 40 08          	mov    0x8(%rax),%rax
   408f7:	48 29 c2             	sub    %rax,%rdx
   408fa:	48 8b 05 ff f5 00 00 	mov    0xf5ff(%rip),%rax        # 4ff00 <current>
   40901:	48 89 d6             	mov    %rdx,%rsi
   40904:	48 89 c7             	mov    %rax,%rdi
   40907:	e8 b4 fb ff ff       	call   404c0 <sbrk>
   4090c:	89 45 fc             	mov    %eax,-0x4(%rbp)
                if (result == -1)
   4090f:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   40913:	75 14                	jne    40929 <exception+0x204>
                    current->p_registers.reg_rax = -1;
   40915:	48 8b 05 e4 f5 00 00 	mov    0xf5e4(%rip),%rax        # 4ff00 <current>
   4091c:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   40923:	ff 
                else
                    current->p_registers.reg_rax = 0;
                break;
   40924:	e9 49 02 00 00       	jmp    40b72 <exception+0x44d>
                    current->p_registers.reg_rax = 0;
   40929:	48 8b 05 d0 f5 00 00 	mov    0xf5d0(%rip),%rax        # 4ff00 <current>
   40930:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
   40937:	00 
                break;
   40938:	e9 35 02 00 00       	jmp    40b72 <exception+0x44d>
            }

        case INT_SYS_SBRK:
            {
                current->p_registers.reg_rax = sbrk(current, (intptr_t) reg->reg_rdi); 
   4093d:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40944:	48 8b 40 30          	mov    0x30(%rax),%rax
   40948:	48 89 c2             	mov    %rax,%rdx
   4094b:	48 8b 05 ae f5 00 00 	mov    0xf5ae(%rip),%rax        # 4ff00 <current>
   40952:	48 89 d6             	mov    %rdx,%rsi
   40955:	48 89 c7             	mov    %rax,%rdi
   40958:	e8 63 fb ff ff       	call   404c0 <sbrk>
   4095d:	89 c2                	mov    %eax,%edx
   4095f:	48 8b 05 9a f5 00 00 	mov    0xf59a(%rip),%rax        # 4ff00 <current>
   40966:	48 63 d2             	movslq %edx,%rdx
   40969:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   4096d:	e9 00 02 00 00       	jmp    40b72 <exception+0x44d>
            }
    case INT_SYS_PAGE_ALLOC:
        {
        intptr_t addr = reg->reg_rdi;
   40972:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40979:	48 8b 40 30          	mov    0x30(%rax),%rax
   4097d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        syscall_page_alloc(addr);
   40981:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40985:	48 89 c7             	mov    %rax,%rdi
   40988:	e8 c5 fa ff ff       	call   40452 <syscall_page_alloc>
        break;
   4098d:	e9 e0 01 00 00       	jmp    40b72 <exception+0x44d>
        }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   40992:	48 8b 05 67 f5 00 00 	mov    0xf567(%rip),%rax        # 4ff00 <current>
   40999:	48 89 c7             	mov    %rax,%rdi
   4099c:	e8 1b fd ff ff       	call   406bc <syscall_mem_tog>
                break;
   409a1:	e9 cc 01 00 00       	jmp    40b72 <exception+0x44d>
            }

        case INT_TIMER:
            {
                ++ticks;
   409a6:	8b 05 74 f9 00 00    	mov    0xf974(%rip),%eax        # 50320 <ticks>
   409ac:	83 c0 01             	add    $0x1,%eax
   409af:	89 05 6b f9 00 00    	mov    %eax,0xf96b(%rip)        # 50320 <ticks>
                schedule();
   409b5:	e8 e1 01 00 00       	call   40b9b <schedule>
                break;                  /* will not be reached */
   409ba:	e9 b3 01 00 00       	jmp    40b72 <exception+0x44d>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   409bf:	0f 20 d0             	mov    %cr2,%rax
   409c2:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    return val;
   409c6:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
            }

        case INT_PAGEFAULT: 
            {
                // Analyze faulting address and access type.
                uintptr_t addr = rcr2();
   409ca:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
                const char* operation = reg->reg_err & PFERR_WRITE
   409ce:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   409d5:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   409dc:	83 e0 02             	and    $0x2,%eax
                    ? "write" : "read";
   409df:	48 85 c0             	test   %rax,%rax
   409e2:	74 07                	je     409eb <exception+0x2c6>
   409e4:	b8 0b 4d 04 00       	mov    $0x44d0b,%eax
   409e9:	eb 05                	jmp    409f0 <exception+0x2cb>
   409eb:	b8 11 4d 04 00       	mov    $0x44d11,%eax
                const char* operation = reg->reg_err & PFERR_WRITE
   409f0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
                const char* problem = reg->reg_err & PFERR_PRESENT
   409f4:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   409fb:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a02:	83 e0 01             	and    $0x1,%eax
                    ? "protection problem" : "missing page";
   40a05:	48 85 c0             	test   %rax,%rax
   40a08:	74 07                	je     40a11 <exception+0x2ec>
   40a0a:	b8 16 4d 04 00       	mov    $0x44d16,%eax
   40a0f:	eb 05                	jmp    40a16 <exception+0x2f1>
   40a11:	b8 29 4d 04 00       	mov    $0x44d29,%eax
                const char* problem = reg->reg_err & PFERR_PRESENT
   40a16:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

                if (!(reg->reg_err & PFERR_USER)) {
   40a1a:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40a21:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a28:	83 e0 04             	and    $0x4,%eax
   40a2b:	48 85 c0             	test   %rax,%rax
   40a2e:	75 2f                	jne    40a5f <exception+0x33a>
                    kernel_panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40a30:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40a37:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40a3e:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   40a42:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40a46:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40a4a:	49 89 f0             	mov    %rsi,%r8
   40a4d:	48 89 c6             	mov    %rax,%rsi
   40a50:	bf 38 4d 04 00       	mov    $0x44d38,%edi
   40a55:	b8 00 00 00 00       	mov    $0x0,%eax
   40a5a:	e8 35 1a 00 00       	call   42494 <kernel_panic>
                            addr, operation, problem, reg->reg_rip);
                }

                addr = ROUNDDOWN(addr, PAGESIZE);
   40a5f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40a63:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   40a67:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40a6b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40a71:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
                if (!(addr >= current->original_break && addr <= current->program_break)) {
   40a75:	48 8b 05 84 f4 00 00 	mov    0xf484(%rip),%rax        # 4ff00 <current>
   40a7c:	48 8b 40 10          	mov    0x10(%rax),%rax
   40a80:	48 39 45 e0          	cmp    %rax,-0x20(%rbp)
   40a84:	72 11                	jb     40a97 <exception+0x372>
   40a86:	48 8b 05 73 f4 00 00 	mov    0xf473(%rip),%rax        # 4ff00 <current>
   40a8d:	48 8b 40 08          	mov    0x8(%rax),%rax
   40a91:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   40a95:	73 65                	jae    40afc <exception+0x3d7>
                    console_printf(CPOS(24, 0), 0x0C00,
   40a97:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40a9e:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                        "Process %d page fault for %p (%s %s, rip=%p)!\n",
                        current->p_pid, addr, operation, problem, reg->reg_rip);
   40aa5:	48 8b 05 54 f4 00 00 	mov    0xf454(%rip),%rax        # 4ff00 <current>
                    console_printf(CPOS(24, 0), 0x0C00,
   40aac:	8b 00                	mov    (%rax),%eax
   40aae:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   40ab2:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   40ab6:	52                   	push   %rdx
   40ab7:	ff 75 d0             	push   -0x30(%rbp)
   40aba:	49 89 f1             	mov    %rsi,%r9
   40abd:	49 89 c8             	mov    %rcx,%r8
   40ac0:	89 c1                	mov    %eax,%ecx
   40ac2:	ba 68 4d 04 00       	mov    $0x44d68,%edx
   40ac7:	be 00 0c 00 00       	mov    $0xc00,%esi
   40acc:	bf 80 07 00 00       	mov    $0x780,%edi
   40ad1:	b8 00 00 00 00       	mov    $0x0,%eax
   40ad6:	e8 cc 3f 00 00       	call   44aa7 <console_printf>
   40adb:	48 83 c4 10          	add    $0x10,%rsp
                    current->p_state = P_BROKEN;
   40adf:	48 8b 05 1a f4 00 00 	mov    0xf41a(%rip),%rax        # 4ff00 <current>
   40ae6:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40aed:	00 00 00 
                    syscall_exit();
   40af0:	b8 00 00 00 00       	mov    $0x0,%eax
   40af5:	e8 41 f9 ff ff       	call   4043b <syscall_exit>
                    }
                    else {
                        current->p_state = P_RUNNABLE;
                    }
                }
                break;
   40afa:	eb 75                	jmp    40b71 <exception+0x44c>
                else if (strcmp(problem, "missing page") == 0) {
   40afc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40b00:	be 29 4d 04 00       	mov    $0x44d29,%esi
   40b05:	48 89 c7             	mov    %rax,%rdi
   40b08:	e8 dc 32 00 00       	call   43de9 <strcmp>
   40b0d:	85 c0                	test   %eax,%eax
   40b0f:	75 60                	jne    40b71 <exception+0x44c>
                    int pa = process_page_alloc(current, addr);
   40b11:	48 8b 05 e8 f3 00 00 	mov    0xf3e8(%rip),%rax        # 4ff00 <current>
   40b18:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40b1c:	48 89 d6             	mov    %rdx,%rsi
   40b1f:	48 89 c7             	mov    %rax,%rdi
   40b22:	e8 5d 30 00 00       	call   43b84 <process_page_alloc>
   40b27:	89 45 c4             	mov    %eax,-0x3c(%rbp)
                    if (pa < 0) {
   40b2a:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
   40b2e:	79 1d                	jns    40b4d <exception+0x428>
                        current->p_state = P_BROKEN;
   40b30:	48 8b 05 c9 f3 00 00 	mov    0xf3c9(%rip),%rax        # 4ff00 <current>
   40b37:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40b3e:	00 00 00 
                        syscall_exit();
   40b41:	b8 00 00 00 00       	mov    $0x0,%eax
   40b46:	e8 f0 f8 ff ff       	call   4043b <syscall_exit>
                break;
   40b4b:	eb 24                	jmp    40b71 <exception+0x44c>
                        current->p_state = P_RUNNABLE;
   40b4d:	48 8b 05 ac f3 00 00 	mov    0xf3ac(%rip),%rax        # 4ff00 <current>
   40b54:	c7 80 d8 00 00 00 01 	movl   $0x1,0xd8(%rax)
   40b5b:	00 00 00 
                break;
   40b5e:	eb 11                	jmp    40b71 <exception+0x44c>
            }

        default:
            default_exception(current);
   40b60:	48 8b 05 99 f3 00 00 	mov    0xf399(%rip),%rax        # 4ff00 <current>
   40b67:	48 89 c7             	mov    %rax,%rdi
   40b6a:	e8 35 1a 00 00       	call   425a4 <default_exception>
            break;                  /* will not be reached */
   40b6f:	eb 01                	jmp    40b72 <exception+0x44d>
                break;
   40b71:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40b72:	48 8b 05 87 f3 00 00 	mov    0xf387(%rip),%rax        # 4ff00 <current>
   40b79:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40b7f:	83 f8 01             	cmp    $0x1,%eax
   40b82:	75 0f                	jne    40b93 <exception+0x46e>
        run(current);
   40b84:	48 8b 05 75 f3 00 00 	mov    0xf375(%rip),%rax        # 4ff00 <current>
   40b8b:	48 89 c7             	mov    %rax,%rdi
   40b8e:	e8 7e 00 00 00       	call   40c11 <run>
    } else {
        schedule();
   40b93:	e8 03 00 00 00       	call   40b9b <schedule>
    }
}
   40b98:	90                   	nop
   40b99:	c9                   	leave  
   40b9a:	c3                   	ret    

0000000000040b9b <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40b9b:	55                   	push   %rbp
   40b9c:	48 89 e5             	mov    %rsp,%rbp
   40b9f:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40ba3:	48 8b 05 56 f3 00 00 	mov    0xf356(%rip),%rax        # 4ff00 <current>
   40baa:	8b 00                	mov    (%rax),%eax
   40bac:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40baf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bb2:	8d 50 01             	lea    0x1(%rax),%edx
   40bb5:	89 d0                	mov    %edx,%eax
   40bb7:	c1 f8 1f             	sar    $0x1f,%eax
   40bba:	c1 e8 1c             	shr    $0x1c,%eax
   40bbd:	01 c2                	add    %eax,%edx
   40bbf:	83 e2 0f             	and    $0xf,%edx
   40bc2:	29 c2                	sub    %eax,%edx
   40bc4:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40bc7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bca:	48 63 d0             	movslq %eax,%rdx
   40bcd:	48 89 d0             	mov    %rdx,%rax
   40bd0:	48 c1 e0 04          	shl    $0x4,%rax
   40bd4:	48 29 d0             	sub    %rdx,%rax
   40bd7:	48 c1 e0 04          	shl    $0x4,%rax
   40bdb:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   40be1:	8b 00                	mov    (%rax),%eax
   40be3:	83 f8 01             	cmp    $0x1,%eax
   40be6:	75 22                	jne    40c0a <schedule+0x6f>
            run(&processes[pid]);
   40be8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40beb:	48 63 d0             	movslq %eax,%rdx
   40bee:	48 89 d0             	mov    %rdx,%rax
   40bf1:	48 c1 e0 04          	shl    $0x4,%rax
   40bf5:	48 29 d0             	sub    %rdx,%rax
   40bf8:	48 c1 e0 04          	shl    $0x4,%rax
   40bfc:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   40c02:	48 89 c7             	mov    %rax,%rdi
   40c05:	e8 07 00 00 00       	call   40c11 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40c0a:	e8 44 17 00 00       	call   42353 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40c0f:	eb 9e                	jmp    40baf <schedule+0x14>

0000000000040c11 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40c11:	55                   	push   %rbp
   40c12:	48 89 e5             	mov    %rsp,%rbp
   40c15:	48 83 ec 10          	sub    $0x10,%rsp
   40c19:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40c1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c21:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40c27:	83 f8 01             	cmp    $0x1,%eax
   40c2a:	74 14                	je     40c40 <run+0x2f>
   40c2c:	ba 00 4f 04 00       	mov    $0x44f00,%edx
   40c31:	be a9 01 00 00       	mov    $0x1a9,%esi
   40c36:	bf c8 4c 04 00       	mov    $0x44cc8,%edi
   40c3b:	e8 34 19 00 00       	call   42574 <assert_fail>
    current = p;
   40c40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c44:	48 89 05 b5 f2 00 00 	mov    %rax,0xf2b5(%rip)        # 4ff00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40c4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c4f:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40c51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c55:	8b 00                	mov    (%rax),%eax
   40c57:	83 c0 02             	add    $0x2,%eax
   40c5a:	48 98                	cltq   
   40c5c:	0f b7 84 00 60 4c 04 	movzwl 0x44c60(%rax,%rax,1),%eax
   40c63:	00 
    console_printf(CPOS(24, 79),
   40c64:	0f b7 c0             	movzwl %ax,%eax
   40c67:	89 d1                	mov    %edx,%ecx
   40c69:	ba 19 4f 04 00       	mov    $0x44f19,%edx
   40c6e:	89 c6                	mov    %eax,%esi
   40c70:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40c75:	b8 00 00 00 00       	mov    $0x0,%eax
   40c7a:	e8 28 3e 00 00       	call   44aa7 <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40c7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c83:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40c8a:	48 89 c7             	mov    %rax,%rdi
   40c8d:	e8 b0 1a 00 00       	call   42742 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40c92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c96:	48 83 c0 18          	add    $0x18,%rax
   40c9a:	48 89 c7             	mov    %rax,%rdi
   40c9d:	e8 21 f4 ff ff       	call   400c3 <exception_return>

0000000000040ca2 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40ca2:	55                   	push   %rbp
   40ca3:	48 89 e5             	mov    %rsp,%rbp
   40ca6:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40caa:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40cb1:	00 
   40cb2:	e9 81 00 00 00       	jmp    40d38 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40cb7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cbb:	48 89 c7             	mov    %rax,%rdi
   40cbe:	e8 1e 0f 00 00       	call   41be1 <physical_memory_isreserved>
   40cc3:	85 c0                	test   %eax,%eax
   40cc5:	74 09                	je     40cd0 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40cc7:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40cce:	eb 2f                	jmp    40cff <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40cd0:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40cd7:	00 
   40cd8:	76 0b                	jbe    40ce5 <pageinfo_init+0x43>
   40cda:	b8 10 80 05 00       	mov    $0x58010,%eax
   40cdf:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ce3:	72 0a                	jb     40cef <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40ce5:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40cec:	00 
   40ced:	75 09                	jne    40cf8 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40cef:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40cf6:	eb 07                	jmp    40cff <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40cf8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40cff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d03:	48 c1 e8 0c          	shr    $0xc,%rax
   40d07:	89 c1                	mov    %eax,%ecx
   40d09:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40d0c:	89 c2                	mov    %eax,%edx
   40d0e:	48 63 c1             	movslq %ecx,%rax
   40d11:	88 94 00 20 ff 04 00 	mov    %dl,0x4ff20(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40d18:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40d1c:	0f 95 c2             	setne  %dl
   40d1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d23:	48 c1 e8 0c          	shr    $0xc,%rax
   40d27:	48 98                	cltq   
   40d29:	88 94 00 21 ff 04 00 	mov    %dl,0x4ff21(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40d30:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40d37:	00 
   40d38:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40d3f:	00 
   40d40:	0f 86 71 ff ff ff    	jbe    40cb7 <pageinfo_init+0x15>
    }
}
   40d46:	90                   	nop
   40d47:	90                   	nop
   40d48:	c9                   	leave  
   40d49:	c3                   	ret    

0000000000040d4a <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40d4a:	55                   	push   %rbp
   40d4b:	48 89 e5             	mov    %rsp,%rbp
   40d4e:	48 83 ec 50          	sub    $0x50,%rsp
   40d52:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40d56:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40d5a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40d60:	48 89 c2             	mov    %rax,%rdx
   40d63:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40d67:	48 39 c2             	cmp    %rax,%rdx
   40d6a:	74 14                	je     40d80 <check_page_table_mappings+0x36>
   40d6c:	ba 20 4f 04 00       	mov    $0x44f20,%edx
   40d71:	be d7 01 00 00       	mov    $0x1d7,%esi
   40d76:	bf c8 4c 04 00       	mov    $0x44cc8,%edi
   40d7b:	e8 f4 17 00 00       	call   42574 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40d80:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40d87:	00 
   40d88:	e9 9a 00 00 00       	jmp    40e27 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40d8d:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40d91:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40d95:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40d99:	48 89 ce             	mov    %rcx,%rsi
   40d9c:	48 89 c7             	mov    %rax,%rdi
   40d9f:	e8 92 1e 00 00       	call   42c36 <virtual_memory_lookup>
        if (vam.pa != va) {
   40da4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40da8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40dac:	74 27                	je     40dd5 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40dae:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40db2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40db6:	49 89 d0             	mov    %rdx,%r8
   40db9:	48 89 c1             	mov    %rax,%rcx
   40dbc:	ba 3f 4f 04 00       	mov    $0x44f3f,%edx
   40dc1:	be 00 c0 00 00       	mov    $0xc000,%esi
   40dc6:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40dcb:	b8 00 00 00 00       	mov    $0x0,%eax
   40dd0:	e8 d2 3c 00 00       	call   44aa7 <console_printf>
        }
        assert(vam.pa == va);
   40dd5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40dd9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ddd:	74 14                	je     40df3 <check_page_table_mappings+0xa9>
   40ddf:	ba 49 4f 04 00       	mov    $0x44f49,%edx
   40de4:	be e0 01 00 00       	mov    $0x1e0,%esi
   40de9:	bf c8 4c 04 00       	mov    $0x44cc8,%edi
   40dee:	e8 81 17 00 00       	call   42574 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40df3:	b8 00 60 04 00       	mov    $0x46000,%eax
   40df8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40dfc:	72 21                	jb     40e1f <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40dfe:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40e01:	48 98                	cltq   
   40e03:	83 e0 02             	and    $0x2,%eax
   40e06:	48 85 c0             	test   %rax,%rax
   40e09:	75 14                	jne    40e1f <check_page_table_mappings+0xd5>
   40e0b:	ba 56 4f 04 00       	mov    $0x44f56,%edx
   40e10:	be e2 01 00 00       	mov    $0x1e2,%esi
   40e15:	bf c8 4c 04 00       	mov    $0x44cc8,%edi
   40e1a:	e8 55 17 00 00       	call   42574 <assert_fail>
         va += PAGESIZE) {
   40e1f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e26:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40e27:	b8 10 80 05 00       	mov    $0x58010,%eax
   40e2c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e30:	0f 82 57 ff ff ff    	jb     40d8d <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40e36:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40e3d:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40e3e:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40e42:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40e46:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40e4a:	48 89 ce             	mov    %rcx,%rsi
   40e4d:	48 89 c7             	mov    %rax,%rdi
   40e50:	e8 e1 1d 00 00       	call   42c36 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40e55:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40e59:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40e5d:	74 14                	je     40e73 <check_page_table_mappings+0x129>
   40e5f:	ba 67 4f 04 00       	mov    $0x44f67,%edx
   40e64:	be e9 01 00 00       	mov    $0x1e9,%esi
   40e69:	bf c8 4c 04 00       	mov    $0x44cc8,%edi
   40e6e:	e8 01 17 00 00       	call   42574 <assert_fail>
    assert(vam.perm & PTE_W);
   40e73:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40e76:	48 98                	cltq   
   40e78:	83 e0 02             	and    $0x2,%eax
   40e7b:	48 85 c0             	test   %rax,%rax
   40e7e:	75 14                	jne    40e94 <check_page_table_mappings+0x14a>
   40e80:	ba 56 4f 04 00       	mov    $0x44f56,%edx
   40e85:	be ea 01 00 00       	mov    $0x1ea,%esi
   40e8a:	bf c8 4c 04 00       	mov    $0x44cc8,%edi
   40e8f:	e8 e0 16 00 00       	call   42574 <assert_fail>
}
   40e94:	90                   	nop
   40e95:	c9                   	leave  
   40e96:	c3                   	ret    

0000000000040e97 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40e97:	55                   	push   %rbp
   40e98:	48 89 e5             	mov    %rsp,%rbp
   40e9b:	48 83 ec 20          	sub    $0x20,%rsp
   40e9f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40ea3:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40ea6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40ea9:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40eac:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40eb3:	48 8b 05 46 11 01 00 	mov    0x11146(%rip),%rax        # 52000 <kernel_pagetable>
   40eba:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40ebe:	75 67                	jne    40f27 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40ec0:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40ec7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40ece:	eb 51                	jmp    40f21 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40ed0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ed3:	48 63 d0             	movslq %eax,%rdx
   40ed6:	48 89 d0             	mov    %rdx,%rax
   40ed9:	48 c1 e0 04          	shl    $0x4,%rax
   40edd:	48 29 d0             	sub    %rdx,%rax
   40ee0:	48 c1 e0 04          	shl    $0x4,%rax
   40ee4:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   40eea:	8b 00                	mov    (%rax),%eax
   40eec:	85 c0                	test   %eax,%eax
   40eee:	74 2d                	je     40f1d <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40ef0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ef3:	48 63 d0             	movslq %eax,%rdx
   40ef6:	48 89 d0             	mov    %rdx,%rax
   40ef9:	48 c1 e0 04          	shl    $0x4,%rax
   40efd:	48 29 d0             	sub    %rdx,%rax
   40f00:	48 c1 e0 04          	shl    $0x4,%rax
   40f04:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   40f0a:	48 8b 10             	mov    (%rax),%rdx
   40f0d:	48 8b 05 ec 10 01 00 	mov    0x110ec(%rip),%rax        # 52000 <kernel_pagetable>
   40f14:	48 39 c2             	cmp    %rax,%rdx
   40f17:	75 04                	jne    40f1d <check_page_table_ownership+0x86>
                ++expected_refcount;
   40f19:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40f1d:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40f21:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40f25:	7e a9                	jle    40ed0 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40f27:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40f2a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f2d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f31:	be 00 00 00 00       	mov    $0x0,%esi
   40f36:	48 89 c7             	mov    %rax,%rdi
   40f39:	e8 03 00 00 00       	call   40f41 <check_page_table_ownership_level>
}
   40f3e:	90                   	nop
   40f3f:	c9                   	leave  
   40f40:	c3                   	ret    

0000000000040f41 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40f41:	55                   	push   %rbp
   40f42:	48 89 e5             	mov    %rsp,%rbp
   40f45:	48 83 ec 30          	sub    $0x30,%rsp
   40f49:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40f4d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40f50:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40f53:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40f56:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f5a:	48 c1 e8 0c          	shr    $0xc,%rax
   40f5e:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40f63:	7e 14                	jle    40f79 <check_page_table_ownership_level+0x38>
   40f65:	ba 78 4f 04 00       	mov    $0x44f78,%edx
   40f6a:	be 07 02 00 00       	mov    $0x207,%esi
   40f6f:	bf c8 4c 04 00       	mov    $0x44cc8,%edi
   40f74:	e8 fb 15 00 00       	call   42574 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40f79:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f7d:	48 c1 e8 0c          	shr    $0xc,%rax
   40f81:	48 98                	cltq   
   40f83:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   40f8a:	00 
   40f8b:	0f be c0             	movsbl %al,%eax
   40f8e:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40f91:	74 14                	je     40fa7 <check_page_table_ownership_level+0x66>
   40f93:	ba 90 4f 04 00       	mov    $0x44f90,%edx
   40f98:	be 08 02 00 00       	mov    $0x208,%esi
   40f9d:	bf c8 4c 04 00       	mov    $0x44cc8,%edi
   40fa2:	e8 cd 15 00 00       	call   42574 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40fa7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fab:	48 c1 e8 0c          	shr    $0xc,%rax
   40faf:	48 98                	cltq   
   40fb1:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   40fb8:	00 
   40fb9:	0f be c0             	movsbl %al,%eax
   40fbc:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40fbf:	74 14                	je     40fd5 <check_page_table_ownership_level+0x94>
   40fc1:	ba b8 4f 04 00       	mov    $0x44fb8,%edx
   40fc6:	be 09 02 00 00       	mov    $0x209,%esi
   40fcb:	bf c8 4c 04 00       	mov    $0x44cc8,%edi
   40fd0:	e8 9f 15 00 00       	call   42574 <assert_fail>
    if (level < 3) {
   40fd5:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40fd9:	7f 5b                	jg     41036 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40fdb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40fe2:	eb 49                	jmp    4102d <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   40fe4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fe8:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40feb:	48 63 d2             	movslq %edx,%rdx
   40fee:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40ff2:	48 85 c0             	test   %rax,%rax
   40ff5:	74 32                	je     41029 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40ff7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40ffb:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40ffe:	48 63 d2             	movslq %edx,%rdx
   41001:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41005:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   4100b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   4100f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41012:	8d 70 01             	lea    0x1(%rax),%esi
   41015:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41018:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4101c:	b9 01 00 00 00       	mov    $0x1,%ecx
   41021:	48 89 c7             	mov    %rax,%rdi
   41024:	e8 18 ff ff ff       	call   40f41 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41029:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4102d:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41034:	7e ae                	jle    40fe4 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   41036:	90                   	nop
   41037:	c9                   	leave  
   41038:	c3                   	ret    

0000000000041039 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41039:	55                   	push   %rbp
   4103a:	48 89 e5             	mov    %rsp,%rbp
   4103d:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   41041:	8b 05 91 e0 00 00    	mov    0xe091(%rip),%eax        # 4f0d8 <processes+0xd8>
   41047:	85 c0                	test   %eax,%eax
   41049:	74 14                	je     4105f <check_virtual_memory+0x26>
   4104b:	ba e8 4f 04 00       	mov    $0x44fe8,%edx
   41050:	be 1c 02 00 00       	mov    $0x21c,%esi
   41055:	bf c8 4c 04 00       	mov    $0x44cc8,%edi
   4105a:	e8 15 15 00 00       	call   42574 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   4105f:	48 8b 05 9a 0f 01 00 	mov    0x10f9a(%rip),%rax        # 52000 <kernel_pagetable>
   41066:	48 89 c7             	mov    %rax,%rdi
   41069:	e8 dc fc ff ff       	call   40d4a <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   4106e:	48 8b 05 8b 0f 01 00 	mov    0x10f8b(%rip),%rax        # 52000 <kernel_pagetable>
   41075:	be ff ff ff ff       	mov    $0xffffffff,%esi
   4107a:	48 89 c7             	mov    %rax,%rdi
   4107d:	e8 15 fe ff ff       	call   40e97 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41082:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41089:	e9 9c 00 00 00       	jmp    4112a <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   4108e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41091:	48 63 d0             	movslq %eax,%rdx
   41094:	48 89 d0             	mov    %rdx,%rax
   41097:	48 c1 e0 04          	shl    $0x4,%rax
   4109b:	48 29 d0             	sub    %rdx,%rax
   4109e:	48 c1 e0 04          	shl    $0x4,%rax
   410a2:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   410a8:	8b 00                	mov    (%rax),%eax
   410aa:	85 c0                	test   %eax,%eax
   410ac:	74 78                	je     41126 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   410ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410b1:	48 63 d0             	movslq %eax,%rdx
   410b4:	48 89 d0             	mov    %rdx,%rax
   410b7:	48 c1 e0 04          	shl    $0x4,%rax
   410bb:	48 29 d0             	sub    %rdx,%rax
   410be:	48 c1 e0 04          	shl    $0x4,%rax
   410c2:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   410c8:	48 8b 10             	mov    (%rax),%rdx
   410cb:	48 8b 05 2e 0f 01 00 	mov    0x10f2e(%rip),%rax        # 52000 <kernel_pagetable>
   410d2:	48 39 c2             	cmp    %rax,%rdx
   410d5:	74 4f                	je     41126 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   410d7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410da:	48 63 d0             	movslq %eax,%rdx
   410dd:	48 89 d0             	mov    %rdx,%rax
   410e0:	48 c1 e0 04          	shl    $0x4,%rax
   410e4:	48 29 d0             	sub    %rdx,%rax
   410e7:	48 c1 e0 04          	shl    $0x4,%rax
   410eb:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   410f1:	48 8b 00             	mov    (%rax),%rax
   410f4:	48 89 c7             	mov    %rax,%rdi
   410f7:	e8 4e fc ff ff       	call   40d4a <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   410fc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410ff:	48 63 d0             	movslq %eax,%rdx
   41102:	48 89 d0             	mov    %rdx,%rax
   41105:	48 c1 e0 04          	shl    $0x4,%rax
   41109:	48 29 d0             	sub    %rdx,%rax
   4110c:	48 c1 e0 04          	shl    $0x4,%rax
   41110:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   41116:	48 8b 00             	mov    (%rax),%rax
   41119:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4111c:	89 d6                	mov    %edx,%esi
   4111e:	48 89 c7             	mov    %rax,%rdi
   41121:	e8 71 fd ff ff       	call   40e97 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41126:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4112a:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4112e:	0f 8e 5a ff ff ff    	jle    4108e <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41134:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4113b:	eb 67                	jmp    411a4 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   4113d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41140:	48 98                	cltq   
   41142:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   41149:	00 
   4114a:	84 c0                	test   %al,%al
   4114c:	7e 52                	jle    411a0 <check_virtual_memory+0x167>
   4114e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41151:	48 98                	cltq   
   41153:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   4115a:	00 
   4115b:	84 c0                	test   %al,%al
   4115d:	78 41                	js     411a0 <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   4115f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41162:	48 98                	cltq   
   41164:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   4116b:	00 
   4116c:	0f be c0             	movsbl %al,%eax
   4116f:	48 63 d0             	movslq %eax,%rdx
   41172:	48 89 d0             	mov    %rdx,%rax
   41175:	48 c1 e0 04          	shl    $0x4,%rax
   41179:	48 29 d0             	sub    %rdx,%rax
   4117c:	48 c1 e0 04          	shl    $0x4,%rax
   41180:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   41186:	8b 00                	mov    (%rax),%eax
   41188:	85 c0                	test   %eax,%eax
   4118a:	75 14                	jne    411a0 <check_virtual_memory+0x167>
   4118c:	ba 08 50 04 00       	mov    $0x45008,%edx
   41191:	be 33 02 00 00       	mov    $0x233,%esi
   41196:	bf c8 4c 04 00       	mov    $0x44cc8,%edi
   4119b:	e8 d4 13 00 00       	call   42574 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   411a0:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   411a4:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   411ab:	7e 90                	jle    4113d <check_virtual_memory+0x104>
        }
    }
}
   411ad:	90                   	nop
   411ae:	90                   	nop
   411af:	c9                   	leave  
   411b0:	c3                   	ret    

00000000000411b1 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   411b1:	55                   	push   %rbp
   411b2:	48 89 e5             	mov    %rsp,%rbp
   411b5:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   411b9:	ba 38 50 04 00       	mov    $0x45038,%edx
   411be:	be 00 0f 00 00       	mov    $0xf00,%esi
   411c3:	bf 20 00 00 00       	mov    $0x20,%edi
   411c8:	b8 00 00 00 00       	mov    $0x0,%eax
   411cd:	e8 d5 38 00 00       	call   44aa7 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   411d2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   411d9:	e9 f8 00 00 00       	jmp    412d6 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   411de:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411e1:	83 e0 3f             	and    $0x3f,%eax
   411e4:	85 c0                	test   %eax,%eax
   411e6:	75 3c                	jne    41224 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   411e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411eb:	c1 e0 0c             	shl    $0xc,%eax
   411ee:	89 c1                	mov    %eax,%ecx
   411f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411f3:	8d 50 3f             	lea    0x3f(%rax),%edx
   411f6:	85 c0                	test   %eax,%eax
   411f8:	0f 48 c2             	cmovs  %edx,%eax
   411fb:	c1 f8 06             	sar    $0x6,%eax
   411fe:	8d 50 01             	lea    0x1(%rax),%edx
   41201:	89 d0                	mov    %edx,%eax
   41203:	c1 e0 02             	shl    $0x2,%eax
   41206:	01 d0                	add    %edx,%eax
   41208:	c1 e0 04             	shl    $0x4,%eax
   4120b:	83 c0 03             	add    $0x3,%eax
   4120e:	ba 48 50 04 00       	mov    $0x45048,%edx
   41213:	be 00 0f 00 00       	mov    $0xf00,%esi
   41218:	89 c7                	mov    %eax,%edi
   4121a:	b8 00 00 00 00       	mov    $0x0,%eax
   4121f:	e8 83 38 00 00       	call   44aa7 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41224:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41227:	48 98                	cltq   
   41229:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   41230:	00 
   41231:	0f be c0             	movsbl %al,%eax
   41234:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41237:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4123a:	48 98                	cltq   
   4123c:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   41243:	00 
   41244:	84 c0                	test   %al,%al
   41246:	75 07                	jne    4124f <memshow_physical+0x9e>
            owner = PO_FREE;
   41248:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4124f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41252:	83 c0 02             	add    $0x2,%eax
   41255:	48 98                	cltq   
   41257:	0f b7 84 00 60 4c 04 	movzwl 0x44c60(%rax,%rax,1),%eax
   4125e:	00 
   4125f:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41263:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41266:	48 98                	cltq   
   41268:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   4126f:	00 
   41270:	3c 01                	cmp    $0x1,%al
   41272:	7e 1a                	jle    4128e <memshow_physical+0xdd>
   41274:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41279:	48 c1 e8 0c          	shr    $0xc,%rax
   4127d:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41280:	74 0c                	je     4128e <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41282:	b8 53 00 00 00       	mov    $0x53,%eax
   41287:	80 cc 0f             	or     $0xf,%ah
   4128a:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
        color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   4128e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41291:	8d 50 3f             	lea    0x3f(%rax),%edx
   41294:	85 c0                	test   %eax,%eax
   41296:	0f 48 c2             	cmovs  %edx,%eax
   41299:	c1 f8 06             	sar    $0x6,%eax
   4129c:	8d 50 01             	lea    0x1(%rax),%edx
   4129f:	89 d0                	mov    %edx,%eax
   412a1:	c1 e0 02             	shl    $0x2,%eax
   412a4:	01 d0                	add    %edx,%eax
   412a6:	c1 e0 04             	shl    $0x4,%eax
   412a9:	89 c1                	mov    %eax,%ecx
   412ab:	8b 55 fc             	mov    -0x4(%rbp),%edx
   412ae:	89 d0                	mov    %edx,%eax
   412b0:	c1 f8 1f             	sar    $0x1f,%eax
   412b3:	c1 e8 1a             	shr    $0x1a,%eax
   412b6:	01 c2                	add    %eax,%edx
   412b8:	83 e2 3f             	and    $0x3f,%edx
   412bb:	29 c2                	sub    %eax,%edx
   412bd:	89 d0                	mov    %edx,%eax
   412bf:	83 c0 0c             	add    $0xc,%eax
   412c2:	01 c8                	add    %ecx,%eax
   412c4:	48 98                	cltq   
   412c6:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   412ca:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   412d1:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412d2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   412d6:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   412dd:	0f 8e fb fe ff ff    	jle    411de <memshow_physical+0x2d>
    }
}
   412e3:	90                   	nop
   412e4:	90                   	nop
   412e5:	c9                   	leave  
   412e6:	c3                   	ret    

00000000000412e7 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   412e7:	55                   	push   %rbp
   412e8:	48 89 e5             	mov    %rsp,%rbp
   412eb:	48 83 ec 40          	sub    $0x40,%rsp
   412ef:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   412f3:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   412f7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   412fb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41301:	48 89 c2             	mov    %rax,%rdx
   41304:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41308:	48 39 c2             	cmp    %rax,%rdx
   4130b:	74 14                	je     41321 <memshow_virtual+0x3a>
   4130d:	ba 50 50 04 00       	mov    $0x45050,%edx
   41312:	be 64 02 00 00       	mov    $0x264,%esi
   41317:	bf c8 4c 04 00       	mov    $0x44cc8,%edi
   4131c:	e8 53 12 00 00       	call   42574 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41321:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41325:	48 89 c1             	mov    %rax,%rcx
   41328:	ba 7d 50 04 00       	mov    $0x4507d,%edx
   4132d:	be 00 0f 00 00       	mov    $0xf00,%esi
   41332:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41337:	b8 00 00 00 00       	mov    $0x0,%eax
   4133c:	e8 66 37 00 00       	call   44aa7 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41341:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41348:	00 
   41349:	e9 80 01 00 00       	jmp    414ce <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   4134e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41352:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41356:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4135a:	48 89 ce             	mov    %rcx,%rsi
   4135d:	48 89 c7             	mov    %rax,%rdi
   41360:	e8 d1 18 00 00       	call   42c36 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41365:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41368:	85 c0                	test   %eax,%eax
   4136a:	79 0b                	jns    41377 <memshow_virtual+0x90>
            color = ' ';
   4136c:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41372:	e9 d7 00 00 00       	jmp    4144e <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41377:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4137b:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41381:	76 14                	jbe    41397 <memshow_virtual+0xb0>
   41383:	ba 9a 50 04 00       	mov    $0x4509a,%edx
   41388:	be 6d 02 00 00       	mov    $0x26d,%esi
   4138d:	bf c8 4c 04 00       	mov    $0x44cc8,%edi
   41392:	e8 dd 11 00 00       	call   42574 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41397:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4139a:	48 98                	cltq   
   4139c:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   413a3:	00 
   413a4:	0f be c0             	movsbl %al,%eax
   413a7:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   413aa:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413ad:	48 98                	cltq   
   413af:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   413b6:	00 
   413b7:	84 c0                	test   %al,%al
   413b9:	75 07                	jne    413c2 <memshow_virtual+0xdb>
                owner = PO_FREE;
   413bb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   413c2:	8b 45 f0             	mov    -0x10(%rbp),%eax
   413c5:	83 c0 02             	add    $0x2,%eax
   413c8:	48 98                	cltq   
   413ca:	0f b7 84 00 60 4c 04 	movzwl 0x44c60(%rax,%rax,1),%eax
   413d1:	00 
   413d2:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   413d6:	8b 45 e0             	mov    -0x20(%rbp),%eax
   413d9:	48 98                	cltq   
   413db:	83 e0 04             	and    $0x4,%eax
   413de:	48 85 c0             	test   %rax,%rax
   413e1:	74 27                	je     4140a <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   413e3:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413e7:	c1 e0 04             	shl    $0x4,%eax
   413ea:	66 25 00 f0          	and    $0xf000,%ax
   413ee:	89 c2                	mov    %eax,%edx
   413f0:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413f4:	c1 f8 04             	sar    $0x4,%eax
   413f7:	66 25 00 0f          	and    $0xf00,%ax
   413fb:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   413fd:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41401:	0f b6 c0             	movzbl %al,%eax
   41404:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41406:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   4140a:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4140d:	48 98                	cltq   
   4140f:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   41416:	00 
   41417:	3c 01                	cmp    $0x1,%al
   41419:	7e 33                	jle    4144e <memshow_virtual+0x167>
   4141b:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41420:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41424:	74 28                	je     4144e <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41426:	b8 53 00 00 00       	mov    $0x53,%eax
   4142b:	89 c2                	mov    %eax,%edx
   4142d:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41431:	66 25 00 f0          	and    $0xf000,%ax
   41435:	09 d0                	or     %edx,%eax
   41437:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   4143b:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4143e:	48 98                	cltq   
   41440:	83 e0 04             	and    $0x4,%eax
   41443:	48 85 c0             	test   %rax,%rax
   41446:	75 06                	jne    4144e <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41448:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
        color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   4144e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41452:	48 c1 e8 0c          	shr    $0xc,%rax
   41456:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41459:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4145c:	83 e0 3f             	and    $0x3f,%eax
   4145f:	85 c0                	test   %eax,%eax
   41461:	75 34                	jne    41497 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41463:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41466:	c1 e8 06             	shr    $0x6,%eax
   41469:	89 c2                	mov    %eax,%edx
   4146b:	89 d0                	mov    %edx,%eax
   4146d:	c1 e0 02             	shl    $0x2,%eax
   41470:	01 d0                	add    %edx,%eax
   41472:	c1 e0 04             	shl    $0x4,%eax
   41475:	05 73 03 00 00       	add    $0x373,%eax
   4147a:	89 c7                	mov    %eax,%edi
   4147c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41480:	48 89 c1             	mov    %rax,%rcx
   41483:	ba 48 50 04 00       	mov    $0x45048,%edx
   41488:	be 00 0f 00 00       	mov    $0xf00,%esi
   4148d:	b8 00 00 00 00       	mov    $0x0,%eax
   41492:	e8 10 36 00 00       	call   44aa7 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41497:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4149a:	c1 e8 06             	shr    $0x6,%eax
   4149d:	89 c2                	mov    %eax,%edx
   4149f:	89 d0                	mov    %edx,%eax
   414a1:	c1 e0 02             	shl    $0x2,%eax
   414a4:	01 d0                	add    %edx,%eax
   414a6:	c1 e0 04             	shl    $0x4,%eax
   414a9:	89 c2                	mov    %eax,%edx
   414ab:	8b 45 ec             	mov    -0x14(%rbp),%eax
   414ae:	83 e0 3f             	and    $0x3f,%eax
   414b1:	01 d0                	add    %edx,%eax
   414b3:	05 7c 03 00 00       	add    $0x37c,%eax
   414b8:	89 c2                	mov    %eax,%edx
   414ba:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414be:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   414c5:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   414c6:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   414cd:	00 
   414ce:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   414d5:	00 
   414d6:	0f 86 72 fe ff ff    	jbe    4134e <memshow_virtual+0x67>
    }
}
   414dc:	90                   	nop
   414dd:	90                   	nop
   414de:	c9                   	leave  
   414df:	c3                   	ret    

00000000000414e0 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   414e0:	55                   	push   %rbp
   414e1:	48 89 e5             	mov    %rsp,%rbp
   414e4:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   414e8:	8b 05 36 ee 00 00    	mov    0xee36(%rip),%eax        # 50324 <last_ticks.1>
   414ee:	85 c0                	test   %eax,%eax
   414f0:	74 13                	je     41505 <memshow_virtual_animate+0x25>
   414f2:	8b 15 28 ee 00 00    	mov    0xee28(%rip),%edx        # 50320 <ticks>
   414f8:	8b 05 26 ee 00 00    	mov    0xee26(%rip),%eax        # 50324 <last_ticks.1>
   414fe:	29 c2                	sub    %eax,%edx
   41500:	83 fa 31             	cmp    $0x31,%edx
   41503:	76 2c                	jbe    41531 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   41505:	8b 05 15 ee 00 00    	mov    0xee15(%rip),%eax        # 50320 <ticks>
   4150b:	89 05 13 ee 00 00    	mov    %eax,0xee13(%rip)        # 50324 <last_ticks.1>
        ++showing;
   41511:	8b 05 ed 4a 00 00    	mov    0x4aed(%rip),%eax        # 46004 <showing.0>
   41517:	83 c0 01             	add    $0x1,%eax
   4151a:	89 05 e4 4a 00 00    	mov    %eax,0x4ae4(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41520:	eb 0f                	jmp    41531 <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   41522:	8b 05 dc 4a 00 00    	mov    0x4adc(%rip),%eax        # 46004 <showing.0>
   41528:	83 c0 01             	add    $0x1,%eax
   4152b:	89 05 d3 4a 00 00    	mov    %eax,0x4ad3(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41531:	8b 05 cd 4a 00 00    	mov    0x4acd(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   41537:	83 f8 20             	cmp    $0x20,%eax
   4153a:	7f 34                	jg     41570 <memshow_virtual_animate+0x90>
   4153c:	8b 15 c2 4a 00 00    	mov    0x4ac2(%rip),%edx        # 46004 <showing.0>
   41542:	89 d0                	mov    %edx,%eax
   41544:	c1 f8 1f             	sar    $0x1f,%eax
   41547:	c1 e8 1c             	shr    $0x1c,%eax
   4154a:	01 c2                	add    %eax,%edx
   4154c:	83 e2 0f             	and    $0xf,%edx
   4154f:	29 c2                	sub    %eax,%edx
   41551:	89 d0                	mov    %edx,%eax
   41553:	48 63 d0             	movslq %eax,%rdx
   41556:	48 89 d0             	mov    %rdx,%rax
   41559:	48 c1 e0 04          	shl    $0x4,%rax
   4155d:	48 29 d0             	sub    %rdx,%rax
   41560:	48 c1 e0 04          	shl    $0x4,%rax
   41564:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   4156a:	8b 00                	mov    (%rax),%eax
   4156c:	85 c0                	test   %eax,%eax
   4156e:	74 b2                	je     41522 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41570:	8b 15 8e 4a 00 00    	mov    0x4a8e(%rip),%edx        # 46004 <showing.0>
   41576:	89 d0                	mov    %edx,%eax
   41578:	c1 f8 1f             	sar    $0x1f,%eax
   4157b:	c1 e8 1c             	shr    $0x1c,%eax
   4157e:	01 c2                	add    %eax,%edx
   41580:	83 e2 0f             	and    $0xf,%edx
   41583:	29 c2                	sub    %eax,%edx
   41585:	89 d0                	mov    %edx,%eax
   41587:	89 05 77 4a 00 00    	mov    %eax,0x4a77(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   4158d:	8b 05 71 4a 00 00    	mov    0x4a71(%rip),%eax        # 46004 <showing.0>
   41593:	48 63 d0             	movslq %eax,%rdx
   41596:	48 89 d0             	mov    %rdx,%rax
   41599:	48 c1 e0 04          	shl    $0x4,%rax
   4159d:	48 29 d0             	sub    %rdx,%rax
   415a0:	48 c1 e0 04          	shl    $0x4,%rax
   415a4:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   415aa:	8b 00                	mov    (%rax),%eax
   415ac:	85 c0                	test   %eax,%eax
   415ae:	74 76                	je     41626 <memshow_virtual_animate+0x146>
   415b0:	8b 05 4e 4a 00 00    	mov    0x4a4e(%rip),%eax        # 46004 <showing.0>
   415b6:	48 63 d0             	movslq %eax,%rdx
   415b9:	48 89 d0             	mov    %rdx,%rax
   415bc:	48 c1 e0 04          	shl    $0x4,%rax
   415c0:	48 29 d0             	sub    %rdx,%rax
   415c3:	48 c1 e0 04          	shl    $0x4,%rax
   415c7:	48 05 e8 f0 04 00    	add    $0x4f0e8,%rax
   415cd:	0f b6 00             	movzbl (%rax),%eax
   415d0:	84 c0                	test   %al,%al
   415d2:	74 52                	je     41626 <memshow_virtual_animate+0x146>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   415d4:	8b 15 2a 4a 00 00    	mov    0x4a2a(%rip),%edx        # 46004 <showing.0>
   415da:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   415de:	89 d1                	mov    %edx,%ecx
   415e0:	ba b4 50 04 00       	mov    $0x450b4,%edx
   415e5:	be 04 00 00 00       	mov    $0x4,%esi
   415ea:	48 89 c7             	mov    %rax,%rdi
   415ed:	b8 00 00 00 00       	mov    $0x0,%eax
   415f2:	e8 bc 35 00 00       	call   44bb3 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   415f7:	8b 05 07 4a 00 00    	mov    0x4a07(%rip),%eax        # 46004 <showing.0>
   415fd:	48 63 d0             	movslq %eax,%rdx
   41600:	48 89 d0             	mov    %rdx,%rax
   41603:	48 c1 e0 04          	shl    $0x4,%rax
   41607:	48 29 d0             	sub    %rdx,%rax
   4160a:	48 c1 e0 04          	shl    $0x4,%rax
   4160e:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   41614:	48 8b 00             	mov    (%rax),%rax
   41617:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   4161b:	48 89 d6             	mov    %rdx,%rsi
   4161e:	48 89 c7             	mov    %rax,%rdi
   41621:	e8 c1 fc ff ff       	call   412e7 <memshow_virtual>
    }
}
   41626:	90                   	nop
   41627:	c9                   	leave  
   41628:	c3                   	ret    

0000000000041629 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41629:	55                   	push   %rbp
   4162a:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   4162d:	e8 4f 01 00 00       	call   41781 <segments_init>
    interrupt_init();
   41632:	e8 d0 03 00 00       	call   41a07 <interrupt_init>
    virtual_memory_init();
   41637:	e8 f3 0f 00 00       	call   4262f <virtual_memory_init>
}
   4163c:	90                   	nop
   4163d:	5d                   	pop    %rbp
   4163e:	c3                   	ret    

000000000004163f <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   4163f:	55                   	push   %rbp
   41640:	48 89 e5             	mov    %rsp,%rbp
   41643:	48 83 ec 18          	sub    $0x18,%rsp
   41647:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4164b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4164f:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41652:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41655:	48 98                	cltq   
   41657:	48 c1 e0 2d          	shl    $0x2d,%rax
   4165b:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   4165f:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41666:	90 00 00 
   41669:	48 09 c2             	or     %rax,%rdx
    *segment = type
   4166c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41670:	48 89 10             	mov    %rdx,(%rax)
}
   41673:	90                   	nop
   41674:	c9                   	leave  
   41675:	c3                   	ret    

0000000000041676 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41676:	55                   	push   %rbp
   41677:	48 89 e5             	mov    %rsp,%rbp
   4167a:	48 83 ec 28          	sub    $0x28,%rsp
   4167e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41682:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41686:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41689:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   4168d:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41691:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41695:	48 c1 e0 10          	shl    $0x10,%rax
   41699:	48 89 c2             	mov    %rax,%rdx
   4169c:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   416a3:	00 00 00 
   416a6:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   416a9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   416ad:	48 c1 e0 20          	shl    $0x20,%rax
   416b1:	48 89 c1             	mov    %rax,%rcx
   416b4:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   416bb:	00 00 ff 
   416be:	48 21 c8             	and    %rcx,%rax
   416c1:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   416c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   416c8:	48 83 e8 01          	sub    $0x1,%rax
   416cc:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   416cf:	48 09 d0             	or     %rdx,%rax
        | type
   416d2:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   416d6:	8b 55 ec             	mov    -0x14(%rbp),%edx
   416d9:	48 63 d2             	movslq %edx,%rdx
   416dc:	48 c1 e2 2d          	shl    $0x2d,%rdx
   416e0:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   416e3:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   416ea:	80 00 00 
   416ed:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   416f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416f4:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   416f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416fb:	48 83 c0 08          	add    $0x8,%rax
   416ff:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41703:	48 c1 ea 20          	shr    $0x20,%rdx
   41707:	48 89 10             	mov    %rdx,(%rax)
}
   4170a:	90                   	nop
   4170b:	c9                   	leave  
   4170c:	c3                   	ret    

000000000004170d <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   4170d:	55                   	push   %rbp
   4170e:	48 89 e5             	mov    %rsp,%rbp
   41711:	48 83 ec 20          	sub    $0x20,%rsp
   41715:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41719:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4171d:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41720:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41724:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41728:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   4172b:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   4172f:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41732:	48 63 d2             	movslq %edx,%rdx
   41735:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41739:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   4173c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41740:	48 c1 e0 20          	shl    $0x20,%rax
   41744:	48 89 c1             	mov    %rax,%rcx
   41747:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   4174e:	00 ff ff 
   41751:	48 21 c8             	and    %rcx,%rax
   41754:	48 09 c2             	or     %rax,%rdx
   41757:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   4175e:	80 00 00 
   41761:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41764:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41768:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   4176b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4176f:	48 c1 e8 20          	shr    $0x20,%rax
   41773:	48 89 c2             	mov    %rax,%rdx
   41776:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4177a:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   4177e:	90                   	nop
   4177f:	c9                   	leave  
   41780:	c3                   	ret    

0000000000041781 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41781:	55                   	push   %rbp
   41782:	48 89 e5             	mov    %rsp,%rbp
   41785:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41789:	48 c7 05 ac eb 00 00 	movq   $0x0,0xebac(%rip)        # 50340 <segments>
   41790:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41794:	ba 00 00 00 00       	mov    $0x0,%edx
   41799:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   417a0:	08 20 00 
   417a3:	48 89 c6             	mov    %rax,%rsi
   417a6:	bf 48 03 05 00       	mov    $0x50348,%edi
   417ab:	e8 8f fe ff ff       	call   4163f <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   417b0:	ba 03 00 00 00       	mov    $0x3,%edx
   417b5:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   417bc:	08 20 00 
   417bf:	48 89 c6             	mov    %rax,%rsi
   417c2:	bf 50 03 05 00       	mov    $0x50350,%edi
   417c7:	e8 73 fe ff ff       	call   4163f <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   417cc:	ba 00 00 00 00       	mov    $0x0,%edx
   417d1:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   417d8:	02 00 00 
   417db:	48 89 c6             	mov    %rax,%rsi
   417de:	bf 58 03 05 00       	mov    $0x50358,%edi
   417e3:	e8 57 fe ff ff       	call   4163f <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   417e8:	ba 03 00 00 00       	mov    $0x3,%edx
   417ed:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   417f4:	02 00 00 
   417f7:	48 89 c6             	mov    %rax,%rsi
   417fa:	bf 60 03 05 00       	mov    $0x50360,%edi
   417ff:	e8 3b fe ff ff       	call   4163f <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41804:	b8 80 13 05 00       	mov    $0x51380,%eax
   41809:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   4180f:	48 89 c1             	mov    %rax,%rcx
   41812:	ba 00 00 00 00       	mov    $0x0,%edx
   41817:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   4181e:	09 00 00 
   41821:	48 89 c6             	mov    %rax,%rsi
   41824:	bf 68 03 05 00       	mov    $0x50368,%edi
   41829:	e8 48 fe ff ff       	call   41676 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   4182e:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41834:	b8 40 03 05 00       	mov    $0x50340,%eax
   41839:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   4183d:	ba 60 00 00 00       	mov    $0x60,%edx
   41842:	be 00 00 00 00       	mov    $0x0,%esi
   41847:	bf 80 13 05 00       	mov    $0x51380,%edi
   4184c:	e8 9f 24 00 00       	call   43cf0 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41851:	48 c7 05 28 fb 00 00 	movq   $0x80000,0xfb28(%rip)        # 51384 <kernel_task_descriptor+0x4>
   41858:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   4185c:	ba 00 10 00 00       	mov    $0x1000,%edx
   41861:	be 00 00 00 00       	mov    $0x0,%esi
   41866:	bf 80 03 05 00       	mov    $0x50380,%edi
   4186b:	e8 80 24 00 00       	call   43cf0 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41870:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41877:	eb 30                	jmp    418a9 <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41879:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4187e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41881:	48 c1 e0 04          	shl    $0x4,%rax
   41885:	48 05 80 03 05 00    	add    $0x50380,%rax
   4188b:	48 89 d1             	mov    %rdx,%rcx
   4188e:	ba 00 00 00 00       	mov    $0x0,%edx
   41893:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4189a:	0e 00 00 
   4189d:	48 89 c7             	mov    %rax,%rdi
   418a0:	e8 68 fe ff ff       	call   4170d <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   418a5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   418a9:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   418b0:	76 c7                	jbe    41879 <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   418b2:	b8 36 00 04 00       	mov    $0x40036,%eax
   418b7:	48 89 c1             	mov    %rax,%rcx
   418ba:	ba 00 00 00 00       	mov    $0x0,%edx
   418bf:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418c6:	0e 00 00 
   418c9:	48 89 c6             	mov    %rax,%rsi
   418cc:	bf 80 05 05 00       	mov    $0x50580,%edi
   418d1:	e8 37 fe ff ff       	call   4170d <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   418d6:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   418db:	48 89 c1             	mov    %rax,%rcx
   418de:	ba 00 00 00 00       	mov    $0x0,%edx
   418e3:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418ea:	0e 00 00 
   418ed:	48 89 c6             	mov    %rax,%rsi
   418f0:	bf 50 04 05 00       	mov    $0x50450,%edi
   418f5:	e8 13 fe ff ff       	call   4170d <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   418fa:	b8 32 00 04 00       	mov    $0x40032,%eax
   418ff:	48 89 c1             	mov    %rax,%rcx
   41902:	ba 00 00 00 00       	mov    $0x0,%edx
   41907:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4190e:	0e 00 00 
   41911:	48 89 c6             	mov    %rax,%rsi
   41914:	bf 60 04 05 00       	mov    $0x50460,%edi
   41919:	e8 ef fd ff ff       	call   4170d <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4191e:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41925:	eb 3e                	jmp    41965 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41927:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4192a:	83 e8 30             	sub    $0x30,%eax
   4192d:	89 c0                	mov    %eax,%eax
   4192f:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41936:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41937:	48 89 c2             	mov    %rax,%rdx
   4193a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4193d:	48 c1 e0 04          	shl    $0x4,%rax
   41941:	48 05 80 03 05 00    	add    $0x50380,%rax
   41947:	48 89 d1             	mov    %rdx,%rcx
   4194a:	ba 03 00 00 00       	mov    $0x3,%edx
   4194f:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41956:	0e 00 00 
   41959:	48 89 c7             	mov    %rax,%rdi
   4195c:	e8 ac fd ff ff       	call   4170d <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41961:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41965:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41969:	76 bc                	jbe    41927 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   4196b:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41971:	b8 80 03 05 00       	mov    $0x50380,%eax
   41976:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   4197a:	b8 28 00 00 00       	mov    $0x28,%eax
   4197f:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41983:	0f 00 d8             	ltr    %ax
   41986:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   4198a:	0f 20 c0             	mov    %cr0,%rax
   4198d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41991:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41995:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41998:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   4199f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   419a2:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   419a5:	8b 45 f0             	mov    -0x10(%rbp),%eax
   419a8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   419ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   419b0:	0f 22 c0             	mov    %rax,%cr0
}
   419b3:	90                   	nop
    lcr0(cr0);
}
   419b4:	90                   	nop
   419b5:	c9                   	leave  
   419b6:	c3                   	ret    

00000000000419b7 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   419b7:	55                   	push   %rbp
   419b8:	48 89 e5             	mov    %rsp,%rbp
   419bb:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   419bf:	0f b7 05 1a fa 00 00 	movzwl 0xfa1a(%rip),%eax        # 513e0 <interrupts_enabled>
   419c6:	f7 d0                	not    %eax
   419c8:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   419cc:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   419d0:	0f b6 c0             	movzbl %al,%eax
   419d3:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   419da:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419dd:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   419e1:	8b 55 f0             	mov    -0x10(%rbp),%edx
   419e4:	ee                   	out    %al,(%dx)
}
   419e5:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   419e6:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   419ea:	66 c1 e8 08          	shr    $0x8,%ax
   419ee:	0f b6 c0             	movzbl %al,%eax
   419f1:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   419f8:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419fb:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   419ff:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41a02:	ee                   	out    %al,(%dx)
}
   41a03:	90                   	nop
}
   41a04:	90                   	nop
   41a05:	c9                   	leave  
   41a06:	c3                   	ret    

0000000000041a07 <interrupt_init>:

void interrupt_init(void) {
   41a07:	55                   	push   %rbp
   41a08:	48 89 e5             	mov    %rsp,%rbp
   41a0b:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41a0f:	66 c7 05 c8 f9 00 00 	movw   $0x0,0xf9c8(%rip)        # 513e0 <interrupts_enabled>
   41a16:	00 00 
    interrupt_mask();
   41a18:	e8 9a ff ff ff       	call   419b7 <interrupt_mask>
   41a1d:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41a24:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a28:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41a2c:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41a2f:	ee                   	out    %al,(%dx)
}
   41a30:	90                   	nop
   41a31:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41a38:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a3c:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41a40:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41a43:	ee                   	out    %al,(%dx)
}
   41a44:	90                   	nop
   41a45:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41a4c:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a50:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41a54:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41a57:	ee                   	out    %al,(%dx)
}
   41a58:	90                   	nop
   41a59:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41a60:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a64:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41a68:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41a6b:	ee                   	out    %al,(%dx)
}
   41a6c:	90                   	nop
   41a6d:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41a74:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a78:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41a7c:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41a7f:	ee                   	out    %al,(%dx)
}
   41a80:	90                   	nop
   41a81:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41a88:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a8c:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41a90:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41a93:	ee                   	out    %al,(%dx)
}
   41a94:	90                   	nop
   41a95:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41a9c:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aa0:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41aa4:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41aa7:	ee                   	out    %al,(%dx)
}
   41aa8:	90                   	nop
   41aa9:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41ab0:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ab4:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41ab8:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41abb:	ee                   	out    %al,(%dx)
}
   41abc:	90                   	nop
   41abd:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41ac4:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ac8:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41acc:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41acf:	ee                   	out    %al,(%dx)
}
   41ad0:	90                   	nop
   41ad1:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41ad8:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41adc:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41ae0:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41ae3:	ee                   	out    %al,(%dx)
}
   41ae4:	90                   	nop
   41ae5:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41aec:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41af0:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41af4:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41af7:	ee                   	out    %al,(%dx)
}
   41af8:	90                   	nop
   41af9:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41b00:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b04:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41b08:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41b0b:	ee                   	out    %al,(%dx)
}
   41b0c:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41b0d:	e8 a5 fe ff ff       	call   419b7 <interrupt_mask>
}
   41b12:	90                   	nop
   41b13:	c9                   	leave  
   41b14:	c3                   	ret    

0000000000041b15 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41b15:	55                   	push   %rbp
   41b16:	48 89 e5             	mov    %rsp,%rbp
   41b19:	48 83 ec 28          	sub    $0x28,%rsp
   41b1d:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41b20:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41b24:	0f 8e 9e 00 00 00    	jle    41bc8 <timer_init+0xb3>
   41b2a:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41b31:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b35:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b39:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b3c:	ee                   	out    %al,(%dx)
}
   41b3d:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41b3e:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41b41:	89 c2                	mov    %eax,%edx
   41b43:	c1 ea 1f             	shr    $0x1f,%edx
   41b46:	01 d0                	add    %edx,%eax
   41b48:	d1 f8                	sar    %eax
   41b4a:	05 de 34 12 00       	add    $0x1234de,%eax
   41b4f:	99                   	cltd   
   41b50:	f7 7d dc             	idivl  -0x24(%rbp)
   41b53:	89 c2                	mov    %eax,%edx
   41b55:	89 d0                	mov    %edx,%eax
   41b57:	c1 f8 1f             	sar    $0x1f,%eax
   41b5a:	c1 e8 18             	shr    $0x18,%eax
   41b5d:	01 c2                	add    %eax,%edx
   41b5f:	0f b6 d2             	movzbl %dl,%edx
   41b62:	29 c2                	sub    %eax,%edx
   41b64:	89 d0                	mov    %edx,%eax
   41b66:	0f b6 c0             	movzbl %al,%eax
   41b69:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41b70:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b73:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41b77:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b7a:	ee                   	out    %al,(%dx)
}
   41b7b:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41b7c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41b7f:	89 c2                	mov    %eax,%edx
   41b81:	c1 ea 1f             	shr    $0x1f,%edx
   41b84:	01 d0                	add    %edx,%eax
   41b86:	d1 f8                	sar    %eax
   41b88:	05 de 34 12 00       	add    $0x1234de,%eax
   41b8d:	99                   	cltd   
   41b8e:	f7 7d dc             	idivl  -0x24(%rbp)
   41b91:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41b97:	85 c0                	test   %eax,%eax
   41b99:	0f 48 c2             	cmovs  %edx,%eax
   41b9c:	c1 f8 08             	sar    $0x8,%eax
   41b9f:	0f b6 c0             	movzbl %al,%eax
   41ba2:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41ba9:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bac:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41bb0:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41bb3:	ee                   	out    %al,(%dx)
}
   41bb4:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41bb5:	0f b7 05 24 f8 00 00 	movzwl 0xf824(%rip),%eax        # 513e0 <interrupts_enabled>
   41bbc:	83 c8 01             	or     $0x1,%eax
   41bbf:	66 89 05 1a f8 00 00 	mov    %ax,0xf81a(%rip)        # 513e0 <interrupts_enabled>
   41bc6:	eb 11                	jmp    41bd9 <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41bc8:	0f b7 05 11 f8 00 00 	movzwl 0xf811(%rip),%eax        # 513e0 <interrupts_enabled>
   41bcf:	83 e0 fe             	and    $0xfffffffe,%eax
   41bd2:	66 89 05 07 f8 00 00 	mov    %ax,0xf807(%rip)        # 513e0 <interrupts_enabled>
    }
    interrupt_mask();
   41bd9:	e8 d9 fd ff ff       	call   419b7 <interrupt_mask>
}
   41bde:	90                   	nop
   41bdf:	c9                   	leave  
   41be0:	c3                   	ret    

0000000000041be1 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41be1:	55                   	push   %rbp
   41be2:	48 89 e5             	mov    %rsp,%rbp
   41be5:	48 83 ec 08          	sub    $0x8,%rsp
   41be9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41bed:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41bf2:	74 14                	je     41c08 <physical_memory_isreserved+0x27>
   41bf4:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41bfb:	00 
   41bfc:	76 11                	jbe    41c0f <physical_memory_isreserved+0x2e>
   41bfe:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41c05:	00 
   41c06:	77 07                	ja     41c0f <physical_memory_isreserved+0x2e>
   41c08:	b8 01 00 00 00       	mov    $0x1,%eax
   41c0d:	eb 05                	jmp    41c14 <physical_memory_isreserved+0x33>
   41c0f:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41c14:	c9                   	leave  
   41c15:	c3                   	ret    

0000000000041c16 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41c16:	55                   	push   %rbp
   41c17:	48 89 e5             	mov    %rsp,%rbp
   41c1a:	48 83 ec 10          	sub    $0x10,%rsp
   41c1e:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41c21:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41c24:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41c27:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c2a:	c1 e0 10             	shl    $0x10,%eax
   41c2d:	89 c2                	mov    %eax,%edx
   41c2f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c32:	c1 e0 0b             	shl    $0xb,%eax
   41c35:	09 c2                	or     %eax,%edx
   41c37:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c3a:	c1 e0 08             	shl    $0x8,%eax
   41c3d:	09 d0                	or     %edx,%eax
}
   41c3f:	c9                   	leave  
   41c40:	c3                   	ret    

0000000000041c41 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41c41:	55                   	push   %rbp
   41c42:	48 89 e5             	mov    %rsp,%rbp
   41c45:	48 83 ec 18          	sub    $0x18,%rsp
   41c49:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41c4c:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41c4f:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c52:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41c55:	09 d0                	or     %edx,%eax
   41c57:	0d 00 00 00 80       	or     $0x80000000,%eax
   41c5c:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41c63:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41c66:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c69:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c6c:	ef                   	out    %eax,(%dx)
}
   41c6d:	90                   	nop
   41c6e:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41c75:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c78:	89 c2                	mov    %eax,%edx
   41c7a:	ed                   	in     (%dx),%eax
   41c7b:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41c7e:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41c81:	c9                   	leave  
   41c82:	c3                   	ret    

0000000000041c83 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41c83:	55                   	push   %rbp
   41c84:	48 89 e5             	mov    %rsp,%rbp
   41c87:	48 83 ec 28          	sub    $0x28,%rsp
   41c8b:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41c8e:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41c91:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41c98:	eb 73                	jmp    41d0d <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41c9a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41ca1:	eb 60                	jmp    41d03 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41ca3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41caa:	eb 4a                	jmp    41cf6 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41cac:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41caf:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41cb2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41cb5:	89 ce                	mov    %ecx,%esi
   41cb7:	89 c7                	mov    %eax,%edi
   41cb9:	e8 58 ff ff ff       	call   41c16 <pci_make_configaddr>
   41cbe:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41cc1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41cc4:	be 00 00 00 00       	mov    $0x0,%esi
   41cc9:	89 c7                	mov    %eax,%edi
   41ccb:	e8 71 ff ff ff       	call   41c41 <pci_config_readl>
   41cd0:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41cd3:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41cd6:	c1 e0 10             	shl    $0x10,%eax
   41cd9:	0b 45 dc             	or     -0x24(%rbp),%eax
   41cdc:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41cdf:	75 05                	jne    41ce6 <pci_find_device+0x63>
                    return configaddr;
   41ce1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41ce4:	eb 35                	jmp    41d1b <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41ce6:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41cea:	75 06                	jne    41cf2 <pci_find_device+0x6f>
   41cec:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41cf0:	74 0c                	je     41cfe <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41cf2:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41cf6:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41cfa:	75 b0                	jne    41cac <pci_find_device+0x29>
   41cfc:	eb 01                	jmp    41cff <pci_find_device+0x7c>
                    break;
   41cfe:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41cff:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41d03:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41d07:	75 9a                	jne    41ca3 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41d09:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41d0d:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41d14:	75 84                	jne    41c9a <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41d16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41d1b:	c9                   	leave  
   41d1c:	c3                   	ret    

0000000000041d1d <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41d1d:	55                   	push   %rbp
   41d1e:	48 89 e5             	mov    %rsp,%rbp
   41d21:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41d25:	be 13 71 00 00       	mov    $0x7113,%esi
   41d2a:	bf 86 80 00 00       	mov    $0x8086,%edi
   41d2f:	e8 4f ff ff ff       	call   41c83 <pci_find_device>
   41d34:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41d37:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41d3b:	78 30                	js     41d6d <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41d3d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d40:	be 40 00 00 00       	mov    $0x40,%esi
   41d45:	89 c7                	mov    %eax,%edi
   41d47:	e8 f5 fe ff ff       	call   41c41 <pci_config_readl>
   41d4c:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41d51:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41d54:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41d57:	83 c0 04             	add    $0x4,%eax
   41d5a:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41d5d:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41d63:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41d67:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d6a:	66 ef                	out    %ax,(%dx)
}
   41d6c:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41d6d:	ba c0 50 04 00       	mov    $0x450c0,%edx
   41d72:	be 00 c0 00 00       	mov    $0xc000,%esi
   41d77:	bf 80 07 00 00       	mov    $0x780,%edi
   41d7c:	b8 00 00 00 00       	mov    $0x0,%eax
   41d81:	e8 21 2d 00 00       	call   44aa7 <console_printf>
 spinloop: goto spinloop;
   41d86:	eb fe                	jmp    41d86 <poweroff+0x69>

0000000000041d88 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41d88:	55                   	push   %rbp
   41d89:	48 89 e5             	mov    %rsp,%rbp
   41d8c:	48 83 ec 10          	sub    $0x10,%rsp
   41d90:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41d97:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d9b:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d9f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41da2:	ee                   	out    %al,(%dx)
}
   41da3:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41da4:	eb fe                	jmp    41da4 <reboot+0x1c>

0000000000041da6 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41da6:	55                   	push   %rbp
   41da7:	48 89 e5             	mov    %rsp,%rbp
   41daa:	48 83 ec 10          	sub    $0x10,%rsp
   41dae:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41db2:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41db5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41db9:	48 83 c0 18          	add    $0x18,%rax
   41dbd:	ba c0 00 00 00       	mov    $0xc0,%edx
   41dc2:	be 00 00 00 00       	mov    $0x0,%esi
   41dc7:	48 89 c7             	mov    %rax,%rdi
   41dca:	e8 21 1f 00 00       	call   43cf0 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41dcf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dd3:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   41dda:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41ddc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41de0:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   41de7:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41deb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41def:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   41df6:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41dfa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dfe:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   41e05:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41e07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e0b:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   41e12:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41e16:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e19:	83 e0 01             	and    $0x1,%eax
   41e1c:	85 c0                	test   %eax,%eax
   41e1e:	74 1c                	je     41e3c <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41e20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e24:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41e2b:	80 cc 30             	or     $0x30,%ah
   41e2e:	48 89 c2             	mov    %rax,%rdx
   41e31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e35:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41e3c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e3f:	83 e0 02             	and    $0x2,%eax
   41e42:	85 c0                	test   %eax,%eax
   41e44:	74 1c                	je     41e62 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41e46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e4a:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41e51:	80 e4 fd             	and    $0xfd,%ah
   41e54:	48 89 c2             	mov    %rax,%rdx
   41e57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e5b:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   41e62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e66:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   41e6d:	90                   	nop
   41e6e:	c9                   	leave  
   41e6f:	c3                   	ret    

0000000000041e70 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41e70:	55                   	push   %rbp
   41e71:	48 89 e5             	mov    %rsp,%rbp
   41e74:	48 83 ec 28          	sub    $0x28,%rsp
   41e78:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41e7b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41e7f:	78 09                	js     41e8a <console_show_cursor+0x1a>
   41e81:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41e88:	7e 07                	jle    41e91 <console_show_cursor+0x21>
        cpos = 0;
   41e8a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41e91:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41e98:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e9c:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41ea0:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41ea3:	ee                   	out    %al,(%dx)
}
   41ea4:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41ea5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41ea8:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41eae:	85 c0                	test   %eax,%eax
   41eb0:	0f 48 c2             	cmovs  %edx,%eax
   41eb3:	c1 f8 08             	sar    $0x8,%eax
   41eb6:	0f b6 c0             	movzbl %al,%eax
   41eb9:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41ec0:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ec3:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41ec7:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41eca:	ee                   	out    %al,(%dx)
}
   41ecb:	90                   	nop
   41ecc:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41ed3:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ed7:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41edb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ede:	ee                   	out    %al,(%dx)
}
   41edf:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41ee0:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41ee3:	89 d0                	mov    %edx,%eax
   41ee5:	c1 f8 1f             	sar    $0x1f,%eax
   41ee8:	c1 e8 18             	shr    $0x18,%eax
   41eeb:	01 c2                	add    %eax,%edx
   41eed:	0f b6 d2             	movzbl %dl,%edx
   41ef0:	29 c2                	sub    %eax,%edx
   41ef2:	89 d0                	mov    %edx,%eax
   41ef4:	0f b6 c0             	movzbl %al,%eax
   41ef7:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41efe:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f01:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f05:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41f08:	ee                   	out    %al,(%dx)
}
   41f09:	90                   	nop
}
   41f0a:	90                   	nop
   41f0b:	c9                   	leave  
   41f0c:	c3                   	ret    

0000000000041f0d <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41f0d:	55                   	push   %rbp
   41f0e:	48 89 e5             	mov    %rsp,%rbp
   41f11:	48 83 ec 20          	sub    $0x20,%rsp
   41f15:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f1c:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f1f:	89 c2                	mov    %eax,%edx
   41f21:	ec                   	in     (%dx),%al
   41f22:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41f25:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41f29:	0f b6 c0             	movzbl %al,%eax
   41f2c:	83 e0 01             	and    $0x1,%eax
   41f2f:	85 c0                	test   %eax,%eax
   41f31:	75 0a                	jne    41f3d <keyboard_readc+0x30>
        return -1;
   41f33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41f38:	e9 e7 01 00 00       	jmp    42124 <keyboard_readc+0x217>
   41f3d:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f44:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41f47:	89 c2                	mov    %eax,%edx
   41f49:	ec                   	in     (%dx),%al
   41f4a:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41f4d:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41f51:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41f54:	0f b6 05 87 f4 00 00 	movzbl 0xf487(%rip),%eax        # 513e2 <last_escape.2>
   41f5b:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41f5e:	c6 05 7d f4 00 00 00 	movb   $0x0,0xf47d(%rip)        # 513e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41f65:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41f69:	75 11                	jne    41f7c <keyboard_readc+0x6f>
        last_escape = 0x80;
   41f6b:	c6 05 70 f4 00 00 80 	movb   $0x80,0xf470(%rip)        # 513e2 <last_escape.2>
        return 0;
   41f72:	b8 00 00 00 00       	mov    $0x0,%eax
   41f77:	e9 a8 01 00 00       	jmp    42124 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41f7c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f80:	84 c0                	test   %al,%al
   41f82:	79 60                	jns    41fe4 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   41f84:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f88:	83 e0 7f             	and    $0x7f,%eax
   41f8b:	89 c2                	mov    %eax,%edx
   41f8d:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41f91:	09 d0                	or     %edx,%eax
   41f93:	48 98                	cltq   
   41f95:	0f b6 80 e0 50 04 00 	movzbl 0x450e0(%rax),%eax
   41f9c:	0f b6 c0             	movzbl %al,%eax
   41f9f:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   41fa2:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   41fa9:	7e 2f                	jle    41fda <keyboard_readc+0xcd>
   41fab:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   41fb2:	7f 26                	jg     41fda <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   41fb4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41fb7:	2d fa 00 00 00       	sub    $0xfa,%eax
   41fbc:	ba 01 00 00 00       	mov    $0x1,%edx
   41fc1:	89 c1                	mov    %eax,%ecx
   41fc3:	d3 e2                	shl    %cl,%edx
   41fc5:	89 d0                	mov    %edx,%eax
   41fc7:	f7 d0                	not    %eax
   41fc9:	89 c2                	mov    %eax,%edx
   41fcb:	0f b6 05 11 f4 00 00 	movzbl 0xf411(%rip),%eax        # 513e3 <modifiers.1>
   41fd2:	21 d0                	and    %edx,%eax
   41fd4:	88 05 09 f4 00 00    	mov    %al,0xf409(%rip)        # 513e3 <modifiers.1>
        }
        return 0;
   41fda:	b8 00 00 00 00       	mov    $0x0,%eax
   41fdf:	e9 40 01 00 00       	jmp    42124 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   41fe4:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fe8:	0a 45 fa             	or     -0x6(%rbp),%al
   41feb:	0f b6 c0             	movzbl %al,%eax
   41fee:	48 98                	cltq   
   41ff0:	0f b6 80 e0 50 04 00 	movzbl 0x450e0(%rax),%eax
   41ff7:	0f b6 c0             	movzbl %al,%eax
   41ffa:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   41ffd:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   42001:	7e 57                	jle    4205a <keyboard_readc+0x14d>
   42003:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42007:	7f 51                	jg     4205a <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   42009:	0f b6 05 d3 f3 00 00 	movzbl 0xf3d3(%rip),%eax        # 513e3 <modifiers.1>
   42010:	0f b6 c0             	movzbl %al,%eax
   42013:	83 e0 02             	and    $0x2,%eax
   42016:	85 c0                	test   %eax,%eax
   42018:	74 09                	je     42023 <keyboard_readc+0x116>
            ch -= 0x60;
   4201a:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4201e:	e9 fd 00 00 00       	jmp    42120 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42023:	0f b6 05 b9 f3 00 00 	movzbl 0xf3b9(%rip),%eax        # 513e3 <modifiers.1>
   4202a:	0f b6 c0             	movzbl %al,%eax
   4202d:	83 e0 01             	and    $0x1,%eax
   42030:	85 c0                	test   %eax,%eax
   42032:	0f 94 c2             	sete   %dl
   42035:	0f b6 05 a7 f3 00 00 	movzbl 0xf3a7(%rip),%eax        # 513e3 <modifiers.1>
   4203c:	0f b6 c0             	movzbl %al,%eax
   4203f:	83 e0 08             	and    $0x8,%eax
   42042:	85 c0                	test   %eax,%eax
   42044:	0f 94 c0             	sete   %al
   42047:	31 d0                	xor    %edx,%eax
   42049:	84 c0                	test   %al,%al
   4204b:	0f 84 cf 00 00 00    	je     42120 <keyboard_readc+0x213>
            ch -= 0x20;
   42051:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42055:	e9 c6 00 00 00       	jmp    42120 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   4205a:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42061:	7e 30                	jle    42093 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42063:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42066:	2d fa 00 00 00       	sub    $0xfa,%eax
   4206b:	ba 01 00 00 00       	mov    $0x1,%edx
   42070:	89 c1                	mov    %eax,%ecx
   42072:	d3 e2                	shl    %cl,%edx
   42074:	89 d0                	mov    %edx,%eax
   42076:	89 c2                	mov    %eax,%edx
   42078:	0f b6 05 64 f3 00 00 	movzbl 0xf364(%rip),%eax        # 513e3 <modifiers.1>
   4207f:	31 d0                	xor    %edx,%eax
   42081:	88 05 5c f3 00 00    	mov    %al,0xf35c(%rip)        # 513e3 <modifiers.1>
        ch = 0;
   42087:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4208e:	e9 8e 00 00 00       	jmp    42121 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42093:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   4209a:	7e 2d                	jle    420c9 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   4209c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4209f:	2d fa 00 00 00       	sub    $0xfa,%eax
   420a4:	ba 01 00 00 00       	mov    $0x1,%edx
   420a9:	89 c1                	mov    %eax,%ecx
   420ab:	d3 e2                	shl    %cl,%edx
   420ad:	89 d0                	mov    %edx,%eax
   420af:	89 c2                	mov    %eax,%edx
   420b1:	0f b6 05 2b f3 00 00 	movzbl 0xf32b(%rip),%eax        # 513e3 <modifiers.1>
   420b8:	09 d0                	or     %edx,%eax
   420ba:	88 05 23 f3 00 00    	mov    %al,0xf323(%rip)        # 513e3 <modifiers.1>
        ch = 0;
   420c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   420c7:	eb 58                	jmp    42121 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   420c9:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   420cd:	7e 31                	jle    42100 <keyboard_readc+0x1f3>
   420cf:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   420d6:	7f 28                	jg     42100 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   420d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420db:	8d 50 80             	lea    -0x80(%rax),%edx
   420de:	0f b6 05 fe f2 00 00 	movzbl 0xf2fe(%rip),%eax        # 513e3 <modifiers.1>
   420e5:	0f b6 c0             	movzbl %al,%eax
   420e8:	83 e0 03             	and    $0x3,%eax
   420eb:	48 98                	cltq   
   420ed:	48 63 d2             	movslq %edx,%rdx
   420f0:	0f b6 84 90 e0 51 04 	movzbl 0x451e0(%rax,%rdx,4),%eax
   420f7:	00 
   420f8:	0f b6 c0             	movzbl %al,%eax
   420fb:	89 45 fc             	mov    %eax,-0x4(%rbp)
   420fe:	eb 21                	jmp    42121 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42100:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42104:	7f 1b                	jg     42121 <keyboard_readc+0x214>
   42106:	0f b6 05 d6 f2 00 00 	movzbl 0xf2d6(%rip),%eax        # 513e3 <modifiers.1>
   4210d:	0f b6 c0             	movzbl %al,%eax
   42110:	83 e0 02             	and    $0x2,%eax
   42113:	85 c0                	test   %eax,%eax
   42115:	74 0a                	je     42121 <keyboard_readc+0x214>
        ch = 0;
   42117:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4211e:	eb 01                	jmp    42121 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   42120:	90                   	nop
    }

    return ch;
   42121:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42124:	c9                   	leave  
   42125:	c3                   	ret    

0000000000042126 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42126:	55                   	push   %rbp
   42127:	48 89 e5             	mov    %rsp,%rbp
   4212a:	48 83 ec 20          	sub    $0x20,%rsp
   4212e:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42135:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42138:	89 c2                	mov    %eax,%edx
   4213a:	ec                   	in     (%dx),%al
   4213b:	88 45 e3             	mov    %al,-0x1d(%rbp)
   4213e:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42145:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42148:	89 c2                	mov    %eax,%edx
   4214a:	ec                   	in     (%dx),%al
   4214b:	88 45 eb             	mov    %al,-0x15(%rbp)
   4214e:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42155:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42158:	89 c2                	mov    %eax,%edx
   4215a:	ec                   	in     (%dx),%al
   4215b:	88 45 f3             	mov    %al,-0xd(%rbp)
   4215e:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42165:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42168:	89 c2                	mov    %eax,%edx
   4216a:	ec                   	in     (%dx),%al
   4216b:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   4216e:	90                   	nop
   4216f:	c9                   	leave  
   42170:	c3                   	ret    

0000000000042171 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42171:	55                   	push   %rbp
   42172:	48 89 e5             	mov    %rsp,%rbp
   42175:	48 83 ec 40          	sub    $0x40,%rsp
   42179:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4217d:	89 f0                	mov    %esi,%eax
   4217f:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42182:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42185:	8b 05 59 f2 00 00    	mov    0xf259(%rip),%eax        # 513e4 <initialized.0>
   4218b:	85 c0                	test   %eax,%eax
   4218d:	75 1e                	jne    421ad <parallel_port_putc+0x3c>
   4218f:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42196:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4219a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4219e:	8b 55 f8             	mov    -0x8(%rbp),%edx
   421a1:	ee                   	out    %al,(%dx)
}
   421a2:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   421a3:	c7 05 37 f2 00 00 01 	movl   $0x1,0xf237(%rip)        # 513e4 <initialized.0>
   421aa:	00 00 00 
    }

    for (int i = 0;
   421ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   421b4:	eb 09                	jmp    421bf <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   421b6:	e8 6b ff ff ff       	call   42126 <delay>
         ++i) {
   421bb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   421bf:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   421c6:	7f 18                	jg     421e0 <parallel_port_putc+0x6f>
   421c8:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   421cf:	8b 45 f0             	mov    -0x10(%rbp),%eax
   421d2:	89 c2                	mov    %eax,%edx
   421d4:	ec                   	in     (%dx),%al
   421d5:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   421d8:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   421dc:	84 c0                	test   %al,%al
   421de:	79 d6                	jns    421b6 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   421e0:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   421e4:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   421eb:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421ee:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   421f2:	8b 55 d8             	mov    -0x28(%rbp),%edx
   421f5:	ee                   	out    %al,(%dx)
}
   421f6:	90                   	nop
   421f7:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   421fe:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42202:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42206:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42209:	ee                   	out    %al,(%dx)
}
   4220a:	90                   	nop
   4220b:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42212:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42216:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   4221a:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4221d:	ee                   	out    %al,(%dx)
}
   4221e:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   4221f:	90                   	nop
   42220:	c9                   	leave  
   42221:	c3                   	ret    

0000000000042222 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42222:	55                   	push   %rbp
   42223:	48 89 e5             	mov    %rsp,%rbp
   42226:	48 83 ec 20          	sub    $0x20,%rsp
   4222a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4222e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42232:	48 c7 45 f8 71 21 04 	movq   $0x42171,-0x8(%rbp)
   42239:	00 
    printer_vprintf(&p, 0, format, val);
   4223a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   4223e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42242:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42246:	be 00 00 00 00       	mov    $0x0,%esi
   4224b:	48 89 c7             	mov    %rax,%rdi
   4224e:	e8 39 1d 00 00       	call   43f8c <printer_vprintf>
}
   42253:	90                   	nop
   42254:	c9                   	leave  
   42255:	c3                   	ret    

0000000000042256 <log_printf>:

void log_printf(const char* format, ...) {
   42256:	55                   	push   %rbp
   42257:	48 89 e5             	mov    %rsp,%rbp
   4225a:	48 83 ec 60          	sub    $0x60,%rsp
   4225e:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42262:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42266:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4226a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4226e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42272:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42276:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   4227d:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42281:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42285:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42289:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   4228d:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42291:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42295:	48 89 d6             	mov    %rdx,%rsi
   42298:	48 89 c7             	mov    %rax,%rdi
   4229b:	e8 82 ff ff ff       	call   42222 <log_vprintf>
    va_end(val);
}
   422a0:	90                   	nop
   422a1:	c9                   	leave  
   422a2:	c3                   	ret    

00000000000422a3 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   422a3:	55                   	push   %rbp
   422a4:	48 89 e5             	mov    %rsp,%rbp
   422a7:	48 83 ec 40          	sub    $0x40,%rsp
   422ab:	89 7d dc             	mov    %edi,-0x24(%rbp)
   422ae:	89 75 d8             	mov    %esi,-0x28(%rbp)
   422b1:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   422b5:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   422b9:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   422bd:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   422c1:	48 8b 0a             	mov    (%rdx),%rcx
   422c4:	48 89 08             	mov    %rcx,(%rax)
   422c7:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   422cb:	48 89 48 08          	mov    %rcx,0x8(%rax)
   422cf:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   422d3:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   422d7:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   422db:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   422df:	48 89 d6             	mov    %rdx,%rsi
   422e2:	48 89 c7             	mov    %rax,%rdi
   422e5:	e8 38 ff ff ff       	call   42222 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   422ea:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   422ee:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   422f2:	8b 75 d8             	mov    -0x28(%rbp),%esi
   422f5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   422f8:	89 c7                	mov    %eax,%edi
   422fa:	e8 3c 27 00 00       	call   44a3b <console_vprintf>
}
   422ff:	c9                   	leave  
   42300:	c3                   	ret    

0000000000042301 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42301:	55                   	push   %rbp
   42302:	48 89 e5             	mov    %rsp,%rbp
   42305:	48 83 ec 60          	sub    $0x60,%rsp
   42309:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4230c:	89 75 a8             	mov    %esi,-0x58(%rbp)
   4230f:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42313:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42317:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4231b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4231f:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42326:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4232a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4232e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42332:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42336:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4233a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4233e:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42341:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42344:	89 c7                	mov    %eax,%edi
   42346:	e8 58 ff ff ff       	call   422a3 <error_vprintf>
   4234b:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4234e:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42351:	c9                   	leave  
   42352:	c3                   	ret    

0000000000042353 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42353:	55                   	push   %rbp
   42354:	48 89 e5             	mov    %rsp,%rbp
   42357:	53                   	push   %rbx
   42358:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   4235c:	e8 ac fb ff ff       	call   41f0d <keyboard_readc>
   42361:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   42364:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42368:	74 1c                	je     42386 <check_keyboard+0x33>
   4236a:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   4236e:	74 16                	je     42386 <check_keyboard+0x33>
   42370:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42374:	74 10                	je     42386 <check_keyboard+0x33>
   42376:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4237a:	74 0a                	je     42386 <check_keyboard+0x33>
   4237c:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42380:	0f 85 e9 00 00 00    	jne    4246f <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42386:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   4238d:	00 
        memset(pt, 0, PAGESIZE * 3);
   4238e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42392:	ba 00 30 00 00       	mov    $0x3000,%edx
   42397:	be 00 00 00 00       	mov    $0x0,%esi
   4239c:	48 89 c7             	mov    %rax,%rdi
   4239f:	e8 4c 19 00 00       	call   43cf0 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   423a4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423a8:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   423af:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423b3:	48 05 00 10 00 00    	add    $0x1000,%rax
   423b9:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   423c0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423c4:	48 05 00 20 00 00    	add    $0x2000,%rax
   423ca:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   423d1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423d5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   423d9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   423dd:	0f 22 d8             	mov    %rax,%cr3
}
   423e0:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   423e1:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   423e8:	48 c7 45 e8 38 52 04 	movq   $0x45238,-0x18(%rbp)
   423ef:	00 
        if (c == 'a') {
   423f0:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   423f4:	75 0a                	jne    42400 <check_keyboard+0xad>
            argument = "allocator";
   423f6:	48 c7 45 e8 3f 52 04 	movq   $0x4523f,-0x18(%rbp)
   423fd:	00 
   423fe:	eb 2e                	jmp    4242e <check_keyboard+0xdb>
        } else if (c == 'c') {
   42400:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42404:	75 0a                	jne    42410 <check_keyboard+0xbd>
            argument = "alloctests";
   42406:	48 c7 45 e8 49 52 04 	movq   $0x45249,-0x18(%rbp)
   4240d:	00 
   4240e:	eb 1e                	jmp    4242e <check_keyboard+0xdb>
        } else if(c == 't'){
   42410:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42414:	75 0a                	jne    42420 <check_keyboard+0xcd>
            argument = "test";
   42416:	48 c7 45 e8 54 52 04 	movq   $0x45254,-0x18(%rbp)
   4241d:	00 
   4241e:	eb 0e                	jmp    4242e <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42420:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42424:	75 08                	jne    4242e <check_keyboard+0xdb>
            argument = "test2";
   42426:	48 c7 45 e8 59 52 04 	movq   $0x45259,-0x18(%rbp)
   4242d:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   4242e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42432:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42436:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4243b:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   4243f:	73 14                	jae    42455 <check_keyboard+0x102>
   42441:	ba 5f 52 04 00       	mov    $0x4525f,%edx
   42446:	be 5c 02 00 00       	mov    $0x25c,%esi
   4244b:	bf 7b 52 04 00       	mov    $0x4527b,%edi
   42450:	e8 1f 01 00 00       	call   42574 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42455:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42459:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   4245c:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42460:	48 89 c3             	mov    %rax,%rbx
   42463:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42468:	e9 93 db ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   4246d:	eb 11                	jmp    42480 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   4246f:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42473:	74 06                	je     4247b <check_keyboard+0x128>
   42475:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42479:	75 05                	jne    42480 <check_keyboard+0x12d>
        poweroff();
   4247b:	e8 9d f8 ff ff       	call   41d1d <poweroff>
    }
    return c;
   42480:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42483:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42487:	c9                   	leave  
   42488:	c3                   	ret    

0000000000042489 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42489:	55                   	push   %rbp
   4248a:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   4248d:	e8 c1 fe ff ff       	call   42353 <check_keyboard>
   42492:	eb f9                	jmp    4248d <fail+0x4>

0000000000042494 <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   42494:	55                   	push   %rbp
   42495:	48 89 e5             	mov    %rsp,%rbp
   42498:	48 83 ec 60          	sub    $0x60,%rsp
   4249c:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   424a0:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   424a4:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   424a8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   424ac:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   424b0:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   424b4:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   424bb:	48 8d 45 10          	lea    0x10(%rbp),%rax
   424bf:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   424c3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   424c7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   424cb:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   424d0:	0f 84 80 00 00 00    	je     42556 <kernel_panic+0xc2>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   424d6:	ba 8f 52 04 00       	mov    $0x4528f,%edx
   424db:	be 00 c0 00 00       	mov    $0xc000,%esi
   424e0:	bf 30 07 00 00       	mov    $0x730,%edi
   424e5:	b8 00 00 00 00       	mov    $0x0,%eax
   424ea:	e8 12 fe ff ff       	call   42301 <error_printf>
   424ef:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   424f2:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   424f6:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   424fa:	8b 45 cc             	mov    -0x34(%rbp),%eax
   424fd:	be 00 c0 00 00       	mov    $0xc000,%esi
   42502:	89 c7                	mov    %eax,%edi
   42504:	e8 9a fd ff ff       	call   422a3 <error_vprintf>
   42509:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   4250c:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   4250f:	48 63 c1             	movslq %ecx,%rax
   42512:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42519:	48 c1 e8 20          	shr    $0x20,%rax
   4251d:	89 c2                	mov    %eax,%edx
   4251f:	c1 fa 05             	sar    $0x5,%edx
   42522:	89 c8                	mov    %ecx,%eax
   42524:	c1 f8 1f             	sar    $0x1f,%eax
   42527:	29 c2                	sub    %eax,%edx
   42529:	89 d0                	mov    %edx,%eax
   4252b:	c1 e0 02             	shl    $0x2,%eax
   4252e:	01 d0                	add    %edx,%eax
   42530:	c1 e0 04             	shl    $0x4,%eax
   42533:	29 c1                	sub    %eax,%ecx
   42535:	89 ca                	mov    %ecx,%edx
   42537:	85 d2                	test   %edx,%edx
   42539:	74 34                	je     4256f <kernel_panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   4253b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4253e:	ba 97 52 04 00       	mov    $0x45297,%edx
   42543:	be 00 c0 00 00       	mov    $0xc000,%esi
   42548:	89 c7                	mov    %eax,%edi
   4254a:	b8 00 00 00 00       	mov    $0x0,%eax
   4254f:	e8 ad fd ff ff       	call   42301 <error_printf>
   42554:	eb 19                	jmp    4256f <kernel_panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42556:	ba 99 52 04 00       	mov    $0x45299,%edx
   4255b:	be 00 c0 00 00       	mov    $0xc000,%esi
   42560:	bf 30 07 00 00       	mov    $0x730,%edi
   42565:	b8 00 00 00 00       	mov    $0x0,%eax
   4256a:	e8 92 fd ff ff       	call   42301 <error_printf>
    }

    va_end(val);
    fail();
   4256f:	e8 15 ff ff ff       	call   42489 <fail>

0000000000042574 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42574:	55                   	push   %rbp
   42575:	48 89 e5             	mov    %rsp,%rbp
   42578:	48 83 ec 20          	sub    $0x20,%rsp
   4257c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42580:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42583:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42587:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   4258b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4258e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42592:	48 89 c6             	mov    %rax,%rsi
   42595:	bf 9f 52 04 00       	mov    $0x4529f,%edi
   4259a:	b8 00 00 00 00       	mov    $0x0,%eax
   4259f:	e8 f0 fe ff ff       	call   42494 <kernel_panic>

00000000000425a4 <default_exception>:
}

void default_exception(proc* p){
   425a4:	55                   	push   %rbp
   425a5:	48 89 e5             	mov    %rsp,%rbp
   425a8:	48 83 ec 20          	sub    $0x20,%rsp
   425ac:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   425b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   425b4:	48 83 c0 18          	add    $0x18,%rax
   425b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   425bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425c0:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   425c7:	48 89 c6             	mov    %rax,%rsi
   425ca:	bf bd 52 04 00       	mov    $0x452bd,%edi
   425cf:	b8 00 00 00 00       	mov    $0x0,%eax
   425d4:	e8 bb fe ff ff       	call   42494 <kernel_panic>

00000000000425d9 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   425d9:	55                   	push   %rbp
   425da:	48 89 e5             	mov    %rsp,%rbp
   425dd:	48 83 ec 10          	sub    $0x10,%rsp
   425e1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   425e5:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   425e8:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   425ec:	78 06                	js     425f4 <pageindex+0x1b>
   425ee:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   425f2:	7e 14                	jle    42608 <pageindex+0x2f>
   425f4:	ba d8 52 04 00       	mov    $0x452d8,%edx
   425f9:	be 1e 00 00 00       	mov    $0x1e,%esi
   425fe:	bf f1 52 04 00       	mov    $0x452f1,%edi
   42603:	e8 6c ff ff ff       	call   42574 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42608:	b8 03 00 00 00       	mov    $0x3,%eax
   4260d:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42610:	89 c2                	mov    %eax,%edx
   42612:	89 d0                	mov    %edx,%eax
   42614:	c1 e0 03             	shl    $0x3,%eax
   42617:	01 d0                	add    %edx,%eax
   42619:	83 c0 0c             	add    $0xc,%eax
   4261c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42620:	89 c1                	mov    %eax,%ecx
   42622:	48 d3 ea             	shr    %cl,%rdx
   42625:	48 89 d0             	mov    %rdx,%rax
   42628:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   4262d:	c9                   	leave  
   4262e:	c3                   	ret    

000000000004262f <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   4262f:	55                   	push   %rbp
   42630:	48 89 e5             	mov    %rsp,%rbp
   42633:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42637:	48 c7 05 be f9 00 00 	movq   $0x53000,0xf9be(%rip)        # 52000 <kernel_pagetable>
   4263e:	00 30 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42642:	ba 00 50 00 00       	mov    $0x5000,%edx
   42647:	be 00 00 00 00       	mov    $0x0,%esi
   4264c:	bf 00 30 05 00       	mov    $0x53000,%edi
   42651:	e8 9a 16 00 00       	call   43cf0 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42656:	b8 00 40 05 00       	mov    $0x54000,%eax
   4265b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   4265f:	48 89 05 9a 09 01 00 	mov    %rax,0x1099a(%rip)        # 53000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42666:	b8 00 50 05 00       	mov    $0x55000,%eax
   4266b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   4266f:	48 89 05 8a 19 01 00 	mov    %rax,0x1198a(%rip)        # 54000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42676:	b8 00 60 05 00       	mov    $0x56000,%eax
   4267b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   4267f:	48 89 05 7a 29 01 00 	mov    %rax,0x1297a(%rip)        # 55000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42686:	b8 00 70 05 00       	mov    $0x57000,%eax
   4268b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   4268f:	48 89 05 72 29 01 00 	mov    %rax,0x12972(%rip)        # 55008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42696:	48 8b 05 63 f9 00 00 	mov    0xf963(%rip),%rax        # 52000 <kernel_pagetable>
   4269d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   426a3:	b9 00 00 20 00       	mov    $0x200000,%ecx
   426a8:	ba 00 00 00 00       	mov    $0x0,%edx
   426ad:	be 00 00 00 00       	mov    $0x0,%esi
   426b2:	48 89 c7             	mov    %rax,%rdi
   426b5:	e8 b9 01 00 00       	call   42873 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   426ba:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   426c1:	00 
   426c2:	eb 62                	jmp    42726 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   426c4:	48 8b 0d 35 f9 00 00 	mov    0xf935(%rip),%rcx        # 52000 <kernel_pagetable>
   426cb:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   426cf:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   426d3:	48 89 ce             	mov    %rcx,%rsi
   426d6:	48 89 c7             	mov    %rax,%rdi
   426d9:	e8 58 05 00 00       	call   42c36 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   426de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   426e2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   426e6:	74 14                	je     426fc <virtual_memory_init+0xcd>
   426e8:	ba 05 53 04 00       	mov    $0x45305,%edx
   426ed:	be 2d 00 00 00       	mov    $0x2d,%esi
   426f2:	bf 15 53 04 00       	mov    $0x45315,%edi
   426f7:	e8 78 fe ff ff       	call   42574 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   426fc:	8b 45 f0             	mov    -0x10(%rbp),%eax
   426ff:	48 98                	cltq   
   42701:	83 e0 03             	and    $0x3,%eax
   42704:	48 83 f8 03          	cmp    $0x3,%rax
   42708:	74 14                	je     4271e <virtual_memory_init+0xef>
   4270a:	ba 28 53 04 00       	mov    $0x45328,%edx
   4270f:	be 2e 00 00 00       	mov    $0x2e,%esi
   42714:	bf 15 53 04 00       	mov    $0x45315,%edi
   42719:	e8 56 fe ff ff       	call   42574 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4271e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42725:	00 
   42726:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4272d:	00 
   4272e:	76 94                	jbe    426c4 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42730:	48 8b 05 c9 f8 00 00 	mov    0xf8c9(%rip),%rax        # 52000 <kernel_pagetable>
   42737:	48 89 c7             	mov    %rax,%rdi
   4273a:	e8 03 00 00 00       	call   42742 <set_pagetable>
}
   4273f:	90                   	nop
   42740:	c9                   	leave  
   42741:	c3                   	ret    

0000000000042742 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42742:	55                   	push   %rbp
   42743:	48 89 e5             	mov    %rsp,%rbp
   42746:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4274a:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   4274e:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42752:	25 ff 0f 00 00       	and    $0xfff,%eax
   42757:	48 85 c0             	test   %rax,%rax
   4275a:	74 14                	je     42770 <set_pagetable+0x2e>
   4275c:	ba 55 53 04 00       	mov    $0x45355,%edx
   42761:	be 3d 00 00 00       	mov    $0x3d,%esi
   42766:	bf 15 53 04 00       	mov    $0x45315,%edi
   4276b:	e8 04 fe ff ff       	call   42574 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42770:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42775:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42779:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4277d:	48 89 ce             	mov    %rcx,%rsi
   42780:	48 89 c7             	mov    %rax,%rdi
   42783:	e8 ae 04 00 00       	call   42c36 <virtual_memory_lookup>
   42788:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4278c:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42791:	48 39 d0             	cmp    %rdx,%rax
   42794:	74 14                	je     427aa <set_pagetable+0x68>
   42796:	ba 70 53 04 00       	mov    $0x45370,%edx
   4279b:	be 3f 00 00 00       	mov    $0x3f,%esi
   427a0:	bf 15 53 04 00       	mov    $0x45315,%edi
   427a5:	e8 ca fd ff ff       	call   42574 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   427aa:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   427ae:	48 8b 0d 4b f8 00 00 	mov    0xf84b(%rip),%rcx        # 52000 <kernel_pagetable>
   427b5:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   427b9:	48 89 ce             	mov    %rcx,%rsi
   427bc:	48 89 c7             	mov    %rax,%rdi
   427bf:	e8 72 04 00 00       	call   42c36 <virtual_memory_lookup>
   427c4:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   427c8:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   427cc:	48 39 c2             	cmp    %rax,%rdx
   427cf:	74 14                	je     427e5 <set_pagetable+0xa3>
   427d1:	ba d8 53 04 00       	mov    $0x453d8,%edx
   427d6:	be 41 00 00 00       	mov    $0x41,%esi
   427db:	bf 15 53 04 00       	mov    $0x45315,%edi
   427e0:	e8 8f fd ff ff       	call   42574 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   427e5:	48 8b 05 14 f8 00 00 	mov    0xf814(%rip),%rax        # 52000 <kernel_pagetable>
   427ec:	48 89 c2             	mov    %rax,%rdx
   427ef:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   427f3:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   427f7:	48 89 ce             	mov    %rcx,%rsi
   427fa:	48 89 c7             	mov    %rax,%rdi
   427fd:	e8 34 04 00 00       	call   42c36 <virtual_memory_lookup>
   42802:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42806:	48 8b 15 f3 f7 00 00 	mov    0xf7f3(%rip),%rdx        # 52000 <kernel_pagetable>
   4280d:	48 39 d0             	cmp    %rdx,%rax
   42810:	74 14                	je     42826 <set_pagetable+0xe4>
   42812:	ba 38 54 04 00       	mov    $0x45438,%edx
   42817:	be 43 00 00 00       	mov    $0x43,%esi
   4281c:	bf 15 53 04 00       	mov    $0x45315,%edi
   42821:	e8 4e fd ff ff       	call   42574 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42826:	ba 73 28 04 00       	mov    $0x42873,%edx
   4282b:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4282f:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42833:	48 89 ce             	mov    %rcx,%rsi
   42836:	48 89 c7             	mov    %rax,%rdi
   42839:	e8 f8 03 00 00       	call   42c36 <virtual_memory_lookup>
   4283e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42842:	ba 73 28 04 00       	mov    $0x42873,%edx
   42847:	48 39 d0             	cmp    %rdx,%rax
   4284a:	74 14                	je     42860 <set_pagetable+0x11e>
   4284c:	ba a0 54 04 00       	mov    $0x454a0,%edx
   42851:	be 45 00 00 00       	mov    $0x45,%esi
   42856:	bf 15 53 04 00       	mov    $0x45315,%edi
   4285b:	e8 14 fd ff ff       	call   42574 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42860:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42864:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42868:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4286c:	0f 22 d8             	mov    %rax,%cr3
}
   4286f:	90                   	nop
}
   42870:	90                   	nop
   42871:	c9                   	leave  
   42872:	c3                   	ret    

0000000000042873 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42873:	55                   	push   %rbp
   42874:	48 89 e5             	mov    %rsp,%rbp
   42877:	53                   	push   %rbx
   42878:	48 83 ec 58          	sub    $0x58,%rsp
   4287c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42880:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42884:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42888:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   4288c:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42890:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42894:	25 ff 0f 00 00       	and    $0xfff,%eax
   42899:	48 85 c0             	test   %rax,%rax
   4289c:	74 14                	je     428b2 <virtual_memory_map+0x3f>
   4289e:	ba 06 55 04 00       	mov    $0x45506,%edx
   428a3:	be 66 00 00 00       	mov    $0x66,%esi
   428a8:	bf 15 53 04 00       	mov    $0x45315,%edi
   428ad:	e8 c2 fc ff ff       	call   42574 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   428b2:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428b6:	25 ff 0f 00 00       	and    $0xfff,%eax
   428bb:	48 85 c0             	test   %rax,%rax
   428be:	74 14                	je     428d4 <virtual_memory_map+0x61>
   428c0:	ba 19 55 04 00       	mov    $0x45519,%edx
   428c5:	be 67 00 00 00       	mov    $0x67,%esi
   428ca:	bf 15 53 04 00       	mov    $0x45315,%edi
   428cf:	e8 a0 fc ff ff       	call   42574 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   428d4:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   428d8:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428dc:	48 01 d0             	add    %rdx,%rax
   428df:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   428e3:	73 24                	jae    42909 <virtual_memory_map+0x96>
   428e5:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   428e9:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428ed:	48 01 d0             	add    %rdx,%rax
   428f0:	48 85 c0             	test   %rax,%rax
   428f3:	74 14                	je     42909 <virtual_memory_map+0x96>
   428f5:	ba 2c 55 04 00       	mov    $0x4552c,%edx
   428fa:	be 68 00 00 00       	mov    $0x68,%esi
   428ff:	bf 15 53 04 00       	mov    $0x45315,%edi
   42904:	e8 6b fc ff ff       	call   42574 <assert_fail>
    if (perm & PTE_P) {
   42909:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4290c:	48 98                	cltq   
   4290e:	83 e0 01             	and    $0x1,%eax
   42911:	48 85 c0             	test   %rax,%rax
   42914:	74 6e                	je     42984 <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42916:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4291a:	25 ff 0f 00 00       	and    $0xfff,%eax
   4291f:	48 85 c0             	test   %rax,%rax
   42922:	74 14                	je     42938 <virtual_memory_map+0xc5>
   42924:	ba 4a 55 04 00       	mov    $0x4554a,%edx
   42929:	be 6a 00 00 00       	mov    $0x6a,%esi
   4292e:	bf 15 53 04 00       	mov    $0x45315,%edi
   42933:	e8 3c fc ff ff       	call   42574 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42938:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4293c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42940:	48 01 d0             	add    %rdx,%rax
   42943:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42947:	73 14                	jae    4295d <virtual_memory_map+0xea>
   42949:	ba 5d 55 04 00       	mov    $0x4555d,%edx
   4294e:	be 6b 00 00 00       	mov    $0x6b,%esi
   42953:	bf 15 53 04 00       	mov    $0x45315,%edi
   42958:	e8 17 fc ff ff       	call   42574 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   4295d:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42961:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42965:	48 01 d0             	add    %rdx,%rax
   42968:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   4296e:	76 14                	jbe    42984 <virtual_memory_map+0x111>
   42970:	ba 6b 55 04 00       	mov    $0x4556b,%edx
   42975:	be 6c 00 00 00       	mov    $0x6c,%esi
   4297a:	bf 15 53 04 00       	mov    $0x45315,%edi
   4297f:	e8 f0 fb ff ff       	call   42574 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42984:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42988:	78 09                	js     42993 <virtual_memory_map+0x120>
   4298a:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42991:	7e 14                	jle    429a7 <virtual_memory_map+0x134>
   42993:	ba 87 55 04 00       	mov    $0x45587,%edx
   42998:	be 6e 00 00 00       	mov    $0x6e,%esi
   4299d:	bf 15 53 04 00       	mov    $0x45315,%edi
   429a2:	e8 cd fb ff ff       	call   42574 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   429a7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   429ab:	25 ff 0f 00 00       	and    $0xfff,%eax
   429b0:	48 85 c0             	test   %rax,%rax
   429b3:	74 14                	je     429c9 <virtual_memory_map+0x156>
   429b5:	ba a8 55 04 00       	mov    $0x455a8,%edx
   429ba:	be 6f 00 00 00       	mov    $0x6f,%esi
   429bf:	bf 15 53 04 00       	mov    $0x45315,%edi
   429c4:	e8 ab fb ff ff       	call   42574 <assert_fail>

    int last_index123 = -1;
   429c9:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   429d0:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   429d7:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   429d8:	e9 e1 00 00 00       	jmp    42abe <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   429dd:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   429e1:	48 c1 e8 15          	shr    $0x15,%rax
   429e5:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   429e8:	8b 45 dc             	mov    -0x24(%rbp),%eax
   429eb:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   429ee:	74 20                	je     42a10 <virtual_memory_map+0x19d>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   429f0:	8b 55 ac             	mov    -0x54(%rbp),%edx
   429f3:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   429f7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   429fb:	48 89 ce             	mov    %rcx,%rsi
   429fe:	48 89 c7             	mov    %rax,%rdi
   42a01:	e8 ce 00 00 00       	call   42ad4 <lookup_l4pagetable>
   42a06:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   42a0a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42a0d:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   42a10:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a13:	48 98                	cltq   
   42a15:	83 e0 01             	and    $0x1,%eax
   42a18:	48 85 c0             	test   %rax,%rax
   42a1b:	74 34                	je     42a51 <virtual_memory_map+0x1de>
   42a1d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42a22:	74 2d                	je     42a51 <virtual_memory_map+0x1de>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   42a24:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a27:	48 63 d8             	movslq %eax,%rbx
   42a2a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a2e:	be 03 00 00 00       	mov    $0x3,%esi
   42a33:	48 89 c7             	mov    %rax,%rdi
   42a36:	e8 9e fb ff ff       	call   425d9 <pageindex>
   42a3b:	89 c2                	mov    %eax,%edx
   42a3d:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42a41:	48 89 d9             	mov    %rbx,%rcx
   42a44:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42a48:	48 63 d2             	movslq %edx,%rdx
   42a4b:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42a4f:	eb 55                	jmp    42aa6 <virtual_memory_map+0x233>
        } else if (l4pagetable) { // if page is NOT marked present
   42a51:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42a56:	74 26                	je     42a7e <virtual_memory_map+0x20b>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42a58:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a5c:	be 03 00 00 00       	mov    $0x3,%esi
   42a61:	48 89 c7             	mov    %rax,%rdi
   42a64:	e8 70 fb ff ff       	call   425d9 <pageindex>
   42a69:	89 c2                	mov    %eax,%edx
   42a6b:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a6e:	48 63 c8             	movslq %eax,%rcx
   42a71:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42a75:	48 63 d2             	movslq %edx,%rdx
   42a78:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42a7c:	eb 28                	jmp    42aa6 <virtual_memory_map+0x233>
        } else if (perm & PTE_P) {
   42a7e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a81:	48 98                	cltq   
   42a83:	83 e0 01             	and    $0x1,%eax
   42a86:	48 85 c0             	test   %rax,%rax
   42a89:	74 1b                	je     42aa6 <virtual_memory_map+0x233>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42a8b:	be 84 00 00 00       	mov    $0x84,%esi
   42a90:	bf d0 55 04 00       	mov    $0x455d0,%edi
   42a95:	b8 00 00 00 00       	mov    $0x0,%eax
   42a9a:	e8 b7 f7 ff ff       	call   42256 <log_printf>
            return -1;
   42a9f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42aa4:	eb 28                	jmp    42ace <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42aa6:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42aad:	00 
   42aae:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42ab5:	00 
   42ab6:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42abd:	00 
   42abe:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42ac3:	0f 85 14 ff ff ff    	jne    429dd <virtual_memory_map+0x16a>
        }
    }
    return 0;
   42ac9:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42ace:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42ad2:	c9                   	leave  
   42ad3:	c3                   	ret    

0000000000042ad4 <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42ad4:	55                   	push   %rbp
   42ad5:	48 89 e5             	mov    %rsp,%rbp
   42ad8:	48 83 ec 40          	sub    $0x40,%rsp
   42adc:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42ae0:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42ae4:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42ae7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42aeb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42aef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42af6:	e9 2b 01 00 00       	jmp    42c26 <lookup_l4pagetable+0x152>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42afb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42afe:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42b02:	89 d6                	mov    %edx,%esi
   42b04:	48 89 c7             	mov    %rax,%rdi
   42b07:	e8 cd fa ff ff       	call   425d9 <pageindex>
   42b0c:	89 c2                	mov    %eax,%edx
   42b0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42b12:	48 63 d2             	movslq %edx,%rdx
   42b15:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42b19:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42b1d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b21:	83 e0 01             	and    $0x1,%eax
   42b24:	48 85 c0             	test   %rax,%rax
   42b27:	75 63                	jne    42b8c <lookup_l4pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42b29:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42b2c:	8d 48 02             	lea    0x2(%rax),%ecx
   42b2f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b33:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b38:	48 89 c2             	mov    %rax,%rdx
   42b3b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b3f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b45:	48 89 c6             	mov    %rax,%rsi
   42b48:	bf 18 56 04 00       	mov    $0x45618,%edi
   42b4d:	b8 00 00 00 00       	mov    $0x0,%eax
   42b52:	e8 ff f6 ff ff       	call   42256 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42b57:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b5a:	48 98                	cltq   
   42b5c:	83 e0 01             	and    $0x1,%eax
   42b5f:	48 85 c0             	test   %rax,%rax
   42b62:	75 0a                	jne    42b6e <lookup_l4pagetable+0x9a>
                return NULL;
   42b64:	b8 00 00 00 00       	mov    $0x0,%eax
   42b69:	e9 c6 00 00 00       	jmp    42c34 <lookup_l4pagetable+0x160>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42b6e:	be a7 00 00 00       	mov    $0xa7,%esi
   42b73:	bf 80 56 04 00       	mov    $0x45680,%edi
   42b78:	b8 00 00 00 00       	mov    $0x0,%eax
   42b7d:	e8 d4 f6 ff ff       	call   42256 <log_printf>
            return NULL;
   42b82:	b8 00 00 00 00       	mov    $0x0,%eax
   42b87:	e9 a8 00 00 00       	jmp    42c34 <lookup_l4pagetable+0x160>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42b8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b90:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b96:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42b9c:	76 14                	jbe    42bb2 <lookup_l4pagetable+0xde>
   42b9e:	ba c8 56 04 00       	mov    $0x456c8,%edx
   42ba3:	be ac 00 00 00       	mov    $0xac,%esi
   42ba8:	bf 15 53 04 00       	mov    $0x45315,%edi
   42bad:	e8 c2 f9 ff ff       	call   42574 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42bb2:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42bb5:	48 98                	cltq   
   42bb7:	83 e0 02             	and    $0x2,%eax
   42bba:	48 85 c0             	test   %rax,%rax
   42bbd:	74 20                	je     42bdf <lookup_l4pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42bbf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bc3:	83 e0 02             	and    $0x2,%eax
   42bc6:	48 85 c0             	test   %rax,%rax
   42bc9:	75 14                	jne    42bdf <lookup_l4pagetable+0x10b>
   42bcb:	ba e8 56 04 00       	mov    $0x456e8,%edx
   42bd0:	be ae 00 00 00       	mov    $0xae,%esi
   42bd5:	bf 15 53 04 00       	mov    $0x45315,%edi
   42bda:	e8 95 f9 ff ff       	call   42574 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42bdf:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42be2:	48 98                	cltq   
   42be4:	83 e0 04             	and    $0x4,%eax
   42be7:	48 85 c0             	test   %rax,%rax
   42bea:	74 20                	je     42c0c <lookup_l4pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42bec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bf0:	83 e0 04             	and    $0x4,%eax
   42bf3:	48 85 c0             	test   %rax,%rax
   42bf6:	75 14                	jne    42c0c <lookup_l4pagetable+0x138>
   42bf8:	ba f3 56 04 00       	mov    $0x456f3,%edx
   42bfd:	be b1 00 00 00       	mov    $0xb1,%esi
   42c02:	bf 15 53 04 00       	mov    $0x45315,%edi
   42c07:	e8 68 f9 ff ff       	call   42574 <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   42c0c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42c13:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42c14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c18:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c1e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42c22:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42c26:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42c2a:	0f 8e cb fe ff ff    	jle    42afb <lookup_l4pagetable+0x27>
    }
    return pt;
   42c30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42c34:	c9                   	leave  
   42c35:	c3                   	ret    

0000000000042c36 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42c36:	55                   	push   %rbp
   42c37:	48 89 e5             	mov    %rsp,%rbp
   42c3a:	48 83 ec 50          	sub    $0x50,%rsp
   42c3e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42c42:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42c46:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42c4a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c4e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42c52:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42c59:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42c5a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42c61:	eb 41                	jmp    42ca4 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42c63:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42c66:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42c6a:	89 d6                	mov    %edx,%esi
   42c6c:	48 89 c7             	mov    %rax,%rdi
   42c6f:	e8 65 f9 ff ff       	call   425d9 <pageindex>
   42c74:	89 c2                	mov    %eax,%edx
   42c76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c7a:	48 63 d2             	movslq %edx,%rdx
   42c7d:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42c81:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c85:	83 e0 06             	and    $0x6,%eax
   42c88:	48 f7 d0             	not    %rax
   42c8b:	48 21 d0             	and    %rdx,%rax
   42c8e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42c92:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c96:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c9c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42ca0:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42ca4:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42ca8:	7f 0c                	jg     42cb6 <virtual_memory_lookup+0x80>
   42caa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cae:	83 e0 01             	and    $0x1,%eax
   42cb1:	48 85 c0             	test   %rax,%rax
   42cb4:	75 ad                	jne    42c63 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42cb6:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42cbd:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42cc4:	ff 
   42cc5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42ccc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cd0:	83 e0 01             	and    $0x1,%eax
   42cd3:	48 85 c0             	test   %rax,%rax
   42cd6:	74 34                	je     42d0c <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42cd8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cdc:	48 c1 e8 0c          	shr    $0xc,%rax
   42ce0:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42ce3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ce7:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42ced:	48 89 c2             	mov    %rax,%rdx
   42cf0:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42cf4:	25 ff 0f 00 00       	and    $0xfff,%eax
   42cf9:	48 09 d0             	or     %rdx,%rax
   42cfc:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42d00:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d04:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d09:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42d0c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d10:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42d14:	48 89 10             	mov    %rdx,(%rax)
   42d17:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42d1b:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42d1f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42d23:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42d27:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d2b:	c9                   	leave  
   42d2c:	c3                   	ret    

0000000000042d2d <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42d2d:	55                   	push   %rbp
   42d2e:	48 89 e5             	mov    %rsp,%rbp
   42d31:	48 83 ec 40          	sub    $0x40,%rsp
   42d35:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42d39:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42d3c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42d40:	c7 45 f8 04 00 00 00 	movl   $0x4,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42d47:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42d4b:	78 08                	js     42d55 <program_load+0x28>
   42d4d:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42d50:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42d53:	7c 14                	jl     42d69 <program_load+0x3c>
   42d55:	ba 00 57 04 00       	mov    $0x45700,%edx
   42d5a:	be 2e 00 00 00       	mov    $0x2e,%esi
   42d5f:	bf 30 57 04 00       	mov    $0x45730,%edi
   42d64:	e8 0b f8 ff ff       	call   42574 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42d69:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42d6c:	48 98                	cltq   
   42d6e:	48 c1 e0 04          	shl    $0x4,%rax
   42d72:	48 05 20 60 04 00    	add    $0x46020,%rax
   42d78:	48 8b 00             	mov    (%rax),%rax
   42d7b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42d7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d83:	8b 00                	mov    (%rax),%eax
   42d85:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42d8a:	74 14                	je     42da0 <program_load+0x73>
   42d8c:	ba 42 57 04 00       	mov    $0x45742,%edx
   42d91:	be 30 00 00 00       	mov    $0x30,%esi
   42d96:	bf 30 57 04 00       	mov    $0x45730,%edi
   42d9b:	e8 d4 f7 ff ff       	call   42574 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42da0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42da4:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42da8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42dac:	48 01 d0             	add    %rdx,%rax
   42daf:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42db3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42dba:	e9 94 00 00 00       	jmp    42e53 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42dbf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42dc2:	48 63 d0             	movslq %eax,%rdx
   42dc5:	48 89 d0             	mov    %rdx,%rax
   42dc8:	48 c1 e0 03          	shl    $0x3,%rax
   42dcc:	48 29 d0             	sub    %rdx,%rax
   42dcf:	48 c1 e0 03          	shl    $0x3,%rax
   42dd3:	48 89 c2             	mov    %rax,%rdx
   42dd6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42dda:	48 01 d0             	add    %rdx,%rax
   42ddd:	8b 00                	mov    (%rax),%eax
   42ddf:	83 f8 01             	cmp    $0x1,%eax
   42de2:	75 6b                	jne    42e4f <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42de4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42de7:	48 63 d0             	movslq %eax,%rdx
   42dea:	48 89 d0             	mov    %rdx,%rax
   42ded:	48 c1 e0 03          	shl    $0x3,%rax
   42df1:	48 29 d0             	sub    %rdx,%rax
   42df4:	48 c1 e0 03          	shl    $0x3,%rax
   42df8:	48 89 c2             	mov    %rax,%rdx
   42dfb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42dff:	48 01 d0             	add    %rdx,%rax
   42e02:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42e06:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e0a:	48 01 d0             	add    %rdx,%rax
   42e0d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42e11:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42e14:	48 63 d0             	movslq %eax,%rdx
   42e17:	48 89 d0             	mov    %rdx,%rax
   42e1a:	48 c1 e0 03          	shl    $0x3,%rax
   42e1e:	48 29 d0             	sub    %rdx,%rax
   42e21:	48 c1 e0 03          	shl    $0x3,%rax
   42e25:	48 89 c2             	mov    %rax,%rdx
   42e28:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e2c:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42e30:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42e34:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42e38:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e3c:	48 89 c7             	mov    %rax,%rdi
   42e3f:	e8 3d 00 00 00       	call   42e81 <program_load_segment>
   42e44:	85 c0                	test   %eax,%eax
   42e46:	79 07                	jns    42e4f <program_load+0x122>
                return -1;
   42e48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42e4d:	eb 30                	jmp    42e7f <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42e4f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42e53:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e57:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42e5b:	0f b7 c0             	movzwl %ax,%eax
   42e5e:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42e61:	0f 8c 58 ff ff ff    	jl     42dbf <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42e67:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e6b:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42e6f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e73:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   42e7a:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42e7f:	c9                   	leave  
   42e80:	c3                   	ret    

0000000000042e81 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42e81:	55                   	push   %rbp
   42e82:	48 89 e5             	mov    %rsp,%rbp
   42e85:	48 81 ec 90 00 00 00 	sub    $0x90,%rsp
   42e8c:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
   42e90:	48 89 75 80          	mov    %rsi,-0x80(%rbp)
   42e94:	48 89 95 78 ff ff ff 	mov    %rdx,-0x88(%rbp)
   42e9b:	48 89 8d 70 ff ff ff 	mov    %rcx,-0x90(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42ea2:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   42ea6:	48 8b 40 10          	mov    0x10(%rax),%rax
   42eaa:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42eae:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   42eb2:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42eb6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42eba:	48 01 d0             	add    %rdx,%rax
   42ebd:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   42ec1:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   42ec5:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42ec9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ecd:	48 01 d0             	add    %rdx,%rax
   42ed0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42ed4:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   42edb:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42edc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ee0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42ee4:	eb 7c                	jmp    42f62 <program_load_segment+0xe1>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   42ee6:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42eea:	8b 00                	mov    (%rax),%eax
   42eec:	89 c7                	mov    %eax,%edi
   42eee:	e8 cb 01 00 00       	call   430be <palloc>
   42ef3:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   42ef7:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42efc:	74 2a                	je     42f28 <program_load_segment+0xa7>
   42efe:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42f02:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42f09:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   42f0d:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42f11:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42f17:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42f1c:	48 89 c7             	mov    %rax,%rdi
   42f1f:	e8 4f f9 ff ff       	call   42873 <virtual_memory_map>
   42f24:	85 c0                	test   %eax,%eax
   42f26:	79 32                	jns    42f5a <program_load_segment+0xd9>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   42f28:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42f2c:	8b 00                	mov    (%rax),%eax
   42f2e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42f32:	49 89 d0             	mov    %rdx,%r8
   42f35:	89 c1                	mov    %eax,%ecx
   42f37:	ba 60 57 04 00       	mov    $0x45760,%edx
   42f3c:	be 00 c0 00 00       	mov    $0xc000,%esi
   42f41:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42f46:	b8 00 00 00 00       	mov    $0x0,%eax
   42f4b:	e8 57 1b 00 00       	call   44aa7 <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   42f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42f55:	e9 62 01 00 00       	jmp    430bc <program_load_segment+0x23b>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42f5a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42f61:	00 
   42f62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f66:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   42f6a:	0f 82 76 ff ff ff    	jb     42ee6 <program_load_segment+0x65>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42f70:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42f74:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42f7b:	48 89 c7             	mov    %rax,%rdi
   42f7e:	e8 bf f7 ff ff       	call   42742 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42f83:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f87:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42f8b:	48 89 c2             	mov    %rax,%rdx
   42f8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f92:	48 8b 8d 78 ff ff ff 	mov    -0x88(%rbp),%rcx
   42f99:	48 89 ce             	mov    %rcx,%rsi
   42f9c:	48 89 c7             	mov    %rax,%rdi
   42f9f:	e8 4e 0c 00 00       	call   43bf2 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42fa4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fa8:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   42fac:	48 89 c2             	mov    %rax,%rdx
   42faf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42fb3:	be 00 00 00 00       	mov    $0x0,%esi
   42fb8:	48 89 c7             	mov    %rax,%rdi
   42fbb:	e8 30 0d 00 00       	call   43cf0 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   42fc0:	48 8b 05 39 f0 00 00 	mov    0xf039(%rip),%rax        # 52000 <kernel_pagetable>
   42fc7:	48 89 c7             	mov    %rax,%rdi
   42fca:	e8 73 f7 ff ff       	call   42742 <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   42fcf:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   42fd3:	8b 40 04             	mov    0x4(%rax),%eax
   42fd6:	83 e0 02             	and    $0x2,%eax
   42fd9:	85 c0                	test   %eax,%eax
   42fdb:	75 60                	jne    4303d <program_load_segment+0x1bc>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42fdd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fe1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42fe5:	eb 4c                	jmp    43033 <program_load_segment+0x1b2>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   42fe7:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42feb:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   42ff2:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42ff6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   42ffa:	48 89 ce             	mov    %rcx,%rsi
   42ffd:	48 89 c7             	mov    %rax,%rdi
   43000:	e8 31 fc ff ff       	call   42c36 <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   43005:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   43009:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4300d:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43014:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   43018:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   4301e:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43023:	48 89 c7             	mov    %rax,%rdi
   43026:	e8 48 f8 ff ff       	call   42873 <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4302b:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43032:	00 
   43033:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43037:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4303b:	72 aa                	jb     42fe7 <program_load_segment+0x166>
                    PTE_P | PTE_U);
        }
    }
    // TODO : Add code here
    p->original_break = ROUNDUP(end_mem, PAGESIZE);
   4303d:	48 c7 45 d0 00 10 00 	movq   $0x1000,-0x30(%rbp)
   43044:	00 
   43045:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   43049:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4304d:	48 01 d0             	add    %rdx,%rax
   43050:	48 83 e8 01          	sub    $0x1,%rax
   43054:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   43058:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4305c:	ba 00 00 00 00       	mov    $0x0,%edx
   43061:	48 f7 75 d0          	divq   -0x30(%rbp)
   43065:	48 89 d1             	mov    %rdx,%rcx
   43068:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4306c:	48 29 c8             	sub    %rcx,%rax
   4306f:	48 89 c2             	mov    %rax,%rdx
   43072:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   43076:	48 89 50 10          	mov    %rdx,0x10(%rax)
    p->program_break = ROUNDUP(end_mem, PAGESIZE);
   4307a:	48 c7 45 c0 00 10 00 	movq   $0x1000,-0x40(%rbp)
   43081:	00 
   43082:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   43086:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4308a:	48 01 d0             	add    %rdx,%rax
   4308d:	48 83 e8 01          	sub    $0x1,%rax
   43091:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   43095:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43099:	ba 00 00 00 00       	mov    $0x0,%edx
   4309e:	48 f7 75 c0          	divq   -0x40(%rbp)
   430a2:	48 89 d1             	mov    %rdx,%rcx
   430a5:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   430a9:	48 29 c8             	sub    %rcx,%rax
   430ac:	48 89 c2             	mov    %rax,%rdx
   430af:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   430b3:	48 89 50 08          	mov    %rdx,0x8(%rax)
    return 0;
   430b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
   430bc:	c9                   	leave  
   430bd:	c3                   	ret    

00000000000430be <palloc>:
   430be:	55                   	push   %rbp
   430bf:	48 89 e5             	mov    %rsp,%rbp
   430c2:	48 83 ec 20          	sub    $0x20,%rsp
   430c6:	89 7d ec             	mov    %edi,-0x14(%rbp)
   430c9:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   430d0:	00 
   430d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430d5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   430d9:	e9 95 00 00 00       	jmp    43173 <palloc+0xb5>
   430de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430e2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   430e6:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   430ed:	00 
   430ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430f2:	48 c1 e8 0c          	shr    $0xc,%rax
   430f6:	48 98                	cltq   
   430f8:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   430ff:	00 
   43100:	84 c0                	test   %al,%al
   43102:	75 6f                	jne    43173 <palloc+0xb5>
   43104:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43108:	48 c1 e8 0c          	shr    $0xc,%rax
   4310c:	48 98                	cltq   
   4310e:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43115:	00 
   43116:	84 c0                	test   %al,%al
   43118:	75 59                	jne    43173 <palloc+0xb5>
   4311a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4311e:	48 c1 e8 0c          	shr    $0xc,%rax
   43122:	89 c2                	mov    %eax,%edx
   43124:	48 63 c2             	movslq %edx,%rax
   43127:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   4312e:	00 
   4312f:	83 c0 01             	add    $0x1,%eax
   43132:	89 c1                	mov    %eax,%ecx
   43134:	48 63 c2             	movslq %edx,%rax
   43137:	88 8c 00 21 ff 04 00 	mov    %cl,0x4ff21(%rax,%rax,1)
   4313e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43142:	48 c1 e8 0c          	shr    $0xc,%rax
   43146:	89 c1                	mov    %eax,%ecx
   43148:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4314b:	89 c2                	mov    %eax,%edx
   4314d:	48 63 c1             	movslq %ecx,%rax
   43150:	88 94 00 20 ff 04 00 	mov    %dl,0x4ff20(%rax,%rax,1)
   43157:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4315b:	ba 00 10 00 00       	mov    $0x1000,%edx
   43160:	be cc 00 00 00       	mov    $0xcc,%esi
   43165:	48 89 c7             	mov    %rax,%rdi
   43168:	e8 83 0b 00 00       	call   43cf0 <memset>
   4316d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43171:	eb 2c                	jmp    4319f <palloc+0xe1>
   43173:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4317a:	00 
   4317b:	0f 86 5d ff ff ff    	jbe    430de <palloc+0x20>
   43181:	ba 98 57 04 00       	mov    $0x45798,%edx
   43186:	be 00 0c 00 00       	mov    $0xc00,%esi
   4318b:	bf 80 07 00 00       	mov    $0x780,%edi
   43190:	b8 00 00 00 00       	mov    $0x0,%eax
   43195:	e8 0d 19 00 00       	call   44aa7 <console_printf>
   4319a:	b8 00 00 00 00       	mov    $0x0,%eax
   4319f:	c9                   	leave  
   431a0:	c3                   	ret    

00000000000431a1 <palloc_target>:
   431a1:	55                   	push   %rbp
   431a2:	48 89 e5             	mov    %rsp,%rbp
   431a5:	48 8b 05 54 4e 01 00 	mov    0x14e54(%rip),%rax        # 58000 <palloc_target_proc>
   431ac:	48 85 c0             	test   %rax,%rax
   431af:	75 14                	jne    431c5 <palloc_target+0x24>
   431b1:	ba b1 57 04 00       	mov    $0x457b1,%edx
   431b6:	be 27 00 00 00       	mov    $0x27,%esi
   431bb:	bf cc 57 04 00       	mov    $0x457cc,%edi
   431c0:	e8 af f3 ff ff       	call   42574 <assert_fail>
   431c5:	48 8b 05 34 4e 01 00 	mov    0x14e34(%rip),%rax        # 58000 <palloc_target_proc>
   431cc:	8b 00                	mov    (%rax),%eax
   431ce:	89 c7                	mov    %eax,%edi
   431d0:	e8 e9 fe ff ff       	call   430be <palloc>
   431d5:	5d                   	pop    %rbp
   431d6:	c3                   	ret    

00000000000431d7 <process_free>:
   431d7:	55                   	push   %rbp
   431d8:	48 89 e5             	mov    %rsp,%rbp
   431db:	48 83 ec 60          	sub    $0x60,%rsp
   431df:	89 7d ac             	mov    %edi,-0x54(%rbp)
   431e2:	8b 45 ac             	mov    -0x54(%rbp),%eax
   431e5:	48 63 d0             	movslq %eax,%rdx
   431e8:	48 89 d0             	mov    %rdx,%rax
   431eb:	48 c1 e0 04          	shl    $0x4,%rax
   431ef:	48 29 d0             	sub    %rdx,%rax
   431f2:	48 c1 e0 04          	shl    $0x4,%rax
   431f6:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   431fc:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   43202:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43209:	00 
   4320a:	e9 ad 00 00 00       	jmp    432bc <process_free+0xe5>
   4320f:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43212:	48 63 d0             	movslq %eax,%rdx
   43215:	48 89 d0             	mov    %rdx,%rax
   43218:	48 c1 e0 04          	shl    $0x4,%rax
   4321c:	48 29 d0             	sub    %rdx,%rax
   4321f:	48 c1 e0 04          	shl    $0x4,%rax
   43223:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43229:	48 8b 08             	mov    (%rax),%rcx
   4322c:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   43230:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43234:	48 89 ce             	mov    %rcx,%rsi
   43237:	48 89 c7             	mov    %rax,%rdi
   4323a:	e8 f7 f9 ff ff       	call   42c36 <virtual_memory_lookup>
   4323f:	8b 45 c8             	mov    -0x38(%rbp),%eax
   43242:	48 98                	cltq   
   43244:	83 e0 01             	and    $0x1,%eax
   43247:	48 85 c0             	test   %rax,%rax
   4324a:	74 68                	je     432b4 <process_free+0xdd>
   4324c:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4324f:	48 63 d0             	movslq %eax,%rdx
   43252:	0f b6 94 12 21 ff 04 	movzbl 0x4ff21(%rdx,%rdx,1),%edx
   43259:	00 
   4325a:	83 ea 01             	sub    $0x1,%edx
   4325d:	48 98                	cltq   
   4325f:	88 94 00 21 ff 04 00 	mov    %dl,0x4ff21(%rax,%rax,1)
   43266:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43269:	48 98                	cltq   
   4326b:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43272:	00 
   43273:	84 c0                	test   %al,%al
   43275:	75 0f                	jne    43286 <process_free+0xaf>
   43277:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4327a:	48 98                	cltq   
   4327c:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43283:	00 
   43284:	eb 2e                	jmp    432b4 <process_free+0xdd>
   43286:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43289:	48 98                	cltq   
   4328b:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   43292:	00 
   43293:	0f be c0             	movsbl %al,%eax
   43296:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   43299:	75 19                	jne    432b4 <process_free+0xdd>
   4329b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4329f:	8b 55 ac             	mov    -0x54(%rbp),%edx
   432a2:	48 89 c6             	mov    %rax,%rsi
   432a5:	bf d8 57 04 00       	mov    $0x457d8,%edi
   432aa:	b8 00 00 00 00       	mov    $0x0,%eax
   432af:	e8 a2 ef ff ff       	call   42256 <log_printf>
   432b4:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   432bb:	00 
   432bc:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   432c3:	00 
   432c4:	0f 86 45 ff ff ff    	jbe    4320f <process_free+0x38>
   432ca:	8b 45 ac             	mov    -0x54(%rbp),%eax
   432cd:	48 63 d0             	movslq %eax,%rdx
   432d0:	48 89 d0             	mov    %rdx,%rax
   432d3:	48 c1 e0 04          	shl    $0x4,%rax
   432d7:	48 29 d0             	sub    %rdx,%rax
   432da:	48 c1 e0 04          	shl    $0x4,%rax
   432de:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   432e4:	48 8b 00             	mov    (%rax),%rax
   432e7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   432eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432ef:	48 8b 00             	mov    (%rax),%rax
   432f2:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432f8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   432fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43300:	48 8b 00             	mov    (%rax),%rax
   43303:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43309:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4330d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43311:	48 8b 00             	mov    (%rax),%rax
   43314:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4331a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   4331e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43322:	48 8b 40 08          	mov    0x8(%rax),%rax
   43326:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4332c:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   43330:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43334:	48 c1 e8 0c          	shr    $0xc,%rax
   43338:	48 98                	cltq   
   4333a:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43341:	00 
   43342:	3c 01                	cmp    $0x1,%al
   43344:	74 14                	je     4335a <process_free+0x183>
   43346:	ba 10 58 04 00       	mov    $0x45810,%edx
   4334b:	be 4f 00 00 00       	mov    $0x4f,%esi
   43350:	bf cc 57 04 00       	mov    $0x457cc,%edi
   43355:	e8 1a f2 ff ff       	call   42574 <assert_fail>
   4335a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4335e:	48 c1 e8 0c          	shr    $0xc,%rax
   43362:	48 98                	cltq   
   43364:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4336b:	00 
   4336c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43370:	48 c1 e8 0c          	shr    $0xc,%rax
   43374:	48 98                	cltq   
   43376:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4337d:	00 
   4337e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43382:	48 c1 e8 0c          	shr    $0xc,%rax
   43386:	48 98                	cltq   
   43388:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   4338f:	00 
   43390:	3c 01                	cmp    $0x1,%al
   43392:	74 14                	je     433a8 <process_free+0x1d1>
   43394:	ba 38 58 04 00       	mov    $0x45838,%edx
   43399:	be 52 00 00 00       	mov    $0x52,%esi
   4339e:	bf cc 57 04 00       	mov    $0x457cc,%edi
   433a3:	e8 cc f1 ff ff       	call   42574 <assert_fail>
   433a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433ac:	48 c1 e8 0c          	shr    $0xc,%rax
   433b0:	48 98                	cltq   
   433b2:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   433b9:	00 
   433ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433be:	48 c1 e8 0c          	shr    $0xc,%rax
   433c2:	48 98                	cltq   
   433c4:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   433cb:	00 
   433cc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   433d0:	48 c1 e8 0c          	shr    $0xc,%rax
   433d4:	48 98                	cltq   
   433d6:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   433dd:	00 
   433de:	3c 01                	cmp    $0x1,%al
   433e0:	74 14                	je     433f6 <process_free+0x21f>
   433e2:	ba 60 58 04 00       	mov    $0x45860,%edx
   433e7:	be 55 00 00 00       	mov    $0x55,%esi
   433ec:	bf cc 57 04 00       	mov    $0x457cc,%edi
   433f1:	e8 7e f1 ff ff       	call   42574 <assert_fail>
   433f6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   433fa:	48 c1 e8 0c          	shr    $0xc,%rax
   433fe:	48 98                	cltq   
   43400:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43407:	00 
   43408:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4340c:	48 c1 e8 0c          	shr    $0xc,%rax
   43410:	48 98                	cltq   
   43412:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43419:	00 
   4341a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4341e:	48 c1 e8 0c          	shr    $0xc,%rax
   43422:	48 98                	cltq   
   43424:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   4342b:	00 
   4342c:	3c 01                	cmp    $0x1,%al
   4342e:	74 14                	je     43444 <process_free+0x26d>
   43430:	ba 88 58 04 00       	mov    $0x45888,%edx
   43435:	be 58 00 00 00       	mov    $0x58,%esi
   4343a:	bf cc 57 04 00       	mov    $0x457cc,%edi
   4343f:	e8 30 f1 ff ff       	call   42574 <assert_fail>
   43444:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43448:	48 c1 e8 0c          	shr    $0xc,%rax
   4344c:	48 98                	cltq   
   4344e:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43455:	00 
   43456:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4345a:	48 c1 e8 0c          	shr    $0xc,%rax
   4345e:	48 98                	cltq   
   43460:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43467:	00 
   43468:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4346c:	48 c1 e8 0c          	shr    $0xc,%rax
   43470:	48 98                	cltq   
   43472:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43479:	00 
   4347a:	3c 01                	cmp    $0x1,%al
   4347c:	74 14                	je     43492 <process_free+0x2bb>
   4347e:	ba b0 58 04 00       	mov    $0x458b0,%edx
   43483:	be 5b 00 00 00       	mov    $0x5b,%esi
   43488:	bf cc 57 04 00       	mov    $0x457cc,%edi
   4348d:	e8 e2 f0 ff ff       	call   42574 <assert_fail>
   43492:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43496:	48 c1 e8 0c          	shr    $0xc,%rax
   4349a:	48 98                	cltq   
   4349c:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   434a3:	00 
   434a4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   434a8:	48 c1 e8 0c          	shr    $0xc,%rax
   434ac:	48 98                	cltq   
   434ae:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   434b5:	00 
   434b6:	90                   	nop
   434b7:	c9                   	leave  
   434b8:	c3                   	ret    

00000000000434b9 <process_config_tables>:
   434b9:	55                   	push   %rbp
   434ba:	48 89 e5             	mov    %rsp,%rbp
   434bd:	48 83 ec 40          	sub    $0x40,%rsp
   434c1:	89 7d cc             	mov    %edi,-0x34(%rbp)
   434c4:	8b 45 cc             	mov    -0x34(%rbp),%eax
   434c7:	89 c7                	mov    %eax,%edi
   434c9:	e8 f0 fb ff ff       	call   430be <palloc>
   434ce:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   434d2:	8b 45 cc             	mov    -0x34(%rbp),%eax
   434d5:	89 c7                	mov    %eax,%edi
   434d7:	e8 e2 fb ff ff       	call   430be <palloc>
   434dc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   434e0:	8b 45 cc             	mov    -0x34(%rbp),%eax
   434e3:	89 c7                	mov    %eax,%edi
   434e5:	e8 d4 fb ff ff       	call   430be <palloc>
   434ea:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   434ee:	8b 45 cc             	mov    -0x34(%rbp),%eax
   434f1:	89 c7                	mov    %eax,%edi
   434f3:	e8 c6 fb ff ff       	call   430be <palloc>
   434f8:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   434fc:	8b 45 cc             	mov    -0x34(%rbp),%eax
   434ff:	89 c7                	mov    %eax,%edi
   43501:	e8 b8 fb ff ff       	call   430be <palloc>
   43506:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   4350a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   4350f:	74 20                	je     43531 <process_config_tables+0x78>
   43511:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43516:	74 19                	je     43531 <process_config_tables+0x78>
   43518:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4351d:	74 12                	je     43531 <process_config_tables+0x78>
   4351f:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43524:	74 0b                	je     43531 <process_config_tables+0x78>
   43526:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4352b:	0f 85 e1 00 00 00    	jne    43612 <process_config_tables+0x159>
   43531:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43536:	74 24                	je     4355c <process_config_tables+0xa3>
   43538:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4353c:	48 c1 e8 0c          	shr    $0xc,%rax
   43540:	48 98                	cltq   
   43542:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43549:	00 
   4354a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4354e:	48 c1 e8 0c          	shr    $0xc,%rax
   43552:	48 98                	cltq   
   43554:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4355b:	00 
   4355c:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43561:	74 24                	je     43587 <process_config_tables+0xce>
   43563:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43567:	48 c1 e8 0c          	shr    $0xc,%rax
   4356b:	48 98                	cltq   
   4356d:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43574:	00 
   43575:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43579:	48 c1 e8 0c          	shr    $0xc,%rax
   4357d:	48 98                	cltq   
   4357f:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43586:	00 
   43587:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4358c:	74 24                	je     435b2 <process_config_tables+0xf9>
   4358e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43592:	48 c1 e8 0c          	shr    $0xc,%rax
   43596:	48 98                	cltq   
   43598:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4359f:	00 
   435a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435a4:	48 c1 e8 0c          	shr    $0xc,%rax
   435a8:	48 98                	cltq   
   435aa:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   435b1:	00 
   435b2:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   435b7:	74 24                	je     435dd <process_config_tables+0x124>
   435b9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   435bd:	48 c1 e8 0c          	shr    $0xc,%rax
   435c1:	48 98                	cltq   
   435c3:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   435ca:	00 
   435cb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   435cf:	48 c1 e8 0c          	shr    $0xc,%rax
   435d3:	48 98                	cltq   
   435d5:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   435dc:	00 
   435dd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   435e2:	74 24                	je     43608 <process_config_tables+0x14f>
   435e4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435e8:	48 c1 e8 0c          	shr    $0xc,%rax
   435ec:	48 98                	cltq   
   435ee:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   435f5:	00 
   435f6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435fa:	48 c1 e8 0c          	shr    $0xc,%rax
   435fe:	48 98                	cltq   
   43600:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43607:	00 
   43608:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4360d:	e9 f3 01 00 00       	jmp    43805 <process_config_tables+0x34c>
   43612:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43616:	ba 00 10 00 00       	mov    $0x1000,%edx
   4361b:	be 00 00 00 00       	mov    $0x0,%esi
   43620:	48 89 c7             	mov    %rax,%rdi
   43623:	e8 c8 06 00 00       	call   43cf0 <memset>
   43628:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4362c:	ba 00 10 00 00       	mov    $0x1000,%edx
   43631:	be 00 00 00 00       	mov    $0x0,%esi
   43636:	48 89 c7             	mov    %rax,%rdi
   43639:	e8 b2 06 00 00       	call   43cf0 <memset>
   4363e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43642:	ba 00 10 00 00       	mov    $0x1000,%edx
   43647:	be 00 00 00 00       	mov    $0x0,%esi
   4364c:	48 89 c7             	mov    %rax,%rdi
   4364f:	e8 9c 06 00 00       	call   43cf0 <memset>
   43654:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43658:	ba 00 10 00 00       	mov    $0x1000,%edx
   4365d:	be 00 00 00 00       	mov    $0x0,%esi
   43662:	48 89 c7             	mov    %rax,%rdi
   43665:	e8 86 06 00 00       	call   43cf0 <memset>
   4366a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4366e:	ba 00 10 00 00       	mov    $0x1000,%edx
   43673:	be 00 00 00 00       	mov    $0x0,%esi
   43678:	48 89 c7             	mov    %rax,%rdi
   4367b:	e8 70 06 00 00       	call   43cf0 <memset>
   43680:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43684:	48 83 c8 07          	or     $0x7,%rax
   43688:	48 89 c2             	mov    %rax,%rdx
   4368b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4368f:	48 89 10             	mov    %rdx,(%rax)
   43692:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43696:	48 83 c8 07          	or     $0x7,%rax
   4369a:	48 89 c2             	mov    %rax,%rdx
   4369d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436a1:	48 89 10             	mov    %rdx,(%rax)
   436a4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   436a8:	48 83 c8 07          	or     $0x7,%rax
   436ac:	48 89 c2             	mov    %rax,%rdx
   436af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436b3:	48 89 10             	mov    %rdx,(%rax)
   436b6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   436ba:	48 83 c8 07          	or     $0x7,%rax
   436be:	48 89 c2             	mov    %rax,%rdx
   436c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436c5:	48 89 50 08          	mov    %rdx,0x8(%rax)
   436c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436cd:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   436d3:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   436d9:	b9 00 00 10 00       	mov    $0x100000,%ecx
   436de:	ba 00 00 00 00       	mov    $0x0,%edx
   436e3:	be 00 00 00 00       	mov    $0x0,%esi
   436e8:	48 89 c7             	mov    %rax,%rdi
   436eb:	e8 83 f1 ff ff       	call   42873 <virtual_memory_map>
   436f0:	85 c0                	test   %eax,%eax
   436f2:	75 2f                	jne    43723 <process_config_tables+0x26a>
   436f4:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   436f9:	be 00 80 0b 00       	mov    $0xb8000,%esi
   436fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43702:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43708:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4370e:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43713:	48 89 c7             	mov    %rax,%rdi
   43716:	e8 58 f1 ff ff       	call   42873 <virtual_memory_map>
   4371b:	85 c0                	test   %eax,%eax
   4371d:	0f 84 bb 00 00 00    	je     437de <process_config_tables+0x325>
   43723:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43727:	48 c1 e8 0c          	shr    $0xc,%rax
   4372b:	48 98                	cltq   
   4372d:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43734:	00 
   43735:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43739:	48 c1 e8 0c          	shr    $0xc,%rax
   4373d:	48 98                	cltq   
   4373f:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43746:	00 
   43747:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4374b:	48 c1 e8 0c          	shr    $0xc,%rax
   4374f:	48 98                	cltq   
   43751:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43758:	00 
   43759:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4375d:	48 c1 e8 0c          	shr    $0xc,%rax
   43761:	48 98                	cltq   
   43763:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4376a:	00 
   4376b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4376f:	48 c1 e8 0c          	shr    $0xc,%rax
   43773:	48 98                	cltq   
   43775:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4377c:	00 
   4377d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43781:	48 c1 e8 0c          	shr    $0xc,%rax
   43785:	48 98                	cltq   
   43787:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4378e:	00 
   4378f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43793:	48 c1 e8 0c          	shr    $0xc,%rax
   43797:	48 98                	cltq   
   43799:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   437a0:	00 
   437a1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   437a5:	48 c1 e8 0c          	shr    $0xc,%rax
   437a9:	48 98                	cltq   
   437ab:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   437b2:	00 
   437b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   437b7:	48 c1 e8 0c          	shr    $0xc,%rax
   437bb:	48 98                	cltq   
   437bd:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   437c4:	00 
   437c5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   437c9:	48 c1 e8 0c          	shr    $0xc,%rax
   437cd:	48 98                	cltq   
   437cf:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   437d6:	00 
   437d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   437dc:	eb 27                	jmp    43805 <process_config_tables+0x34c>
   437de:	8b 45 cc             	mov    -0x34(%rbp),%eax
   437e1:	48 63 d0             	movslq %eax,%rdx
   437e4:	48 89 d0             	mov    %rdx,%rax
   437e7:	48 c1 e0 04          	shl    $0x4,%rax
   437eb:	48 29 d0             	sub    %rdx,%rax
   437ee:	48 c1 e0 04          	shl    $0x4,%rax
   437f2:	48 8d 90 e0 f0 04 00 	lea    0x4f0e0(%rax),%rdx
   437f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437fd:	48 89 02             	mov    %rax,(%rdx)
   43800:	b8 00 00 00 00       	mov    $0x0,%eax
   43805:	c9                   	leave  
   43806:	c3                   	ret    

0000000000043807 <process_load>:
   43807:	55                   	push   %rbp
   43808:	48 89 e5             	mov    %rsp,%rbp
   4380b:	48 83 ec 20          	sub    $0x20,%rsp
   4380f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43813:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43816:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4381a:	48 89 05 df 47 01 00 	mov    %rax,0x147df(%rip)        # 58000 <palloc_target_proc>
   43821:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   43824:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43828:	ba a1 31 04 00       	mov    $0x431a1,%edx
   4382d:	89 ce                	mov    %ecx,%esi
   4382f:	48 89 c7             	mov    %rax,%rdi
   43832:	e8 f6 f4 ff ff       	call   42d2d <program_load>
   43837:	89 45 fc             	mov    %eax,-0x4(%rbp)
   4383a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4383d:	c9                   	leave  
   4383e:	c3                   	ret    

000000000004383f <process_setup_stack>:
   4383f:	55                   	push   %rbp
   43840:	48 89 e5             	mov    %rsp,%rbp
   43843:	48 83 ec 20          	sub    $0x20,%rsp
   43847:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4384b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4384f:	8b 00                	mov    (%rax),%eax
   43851:	89 c7                	mov    %eax,%edi
   43853:	e8 66 f8 ff ff       	call   430be <palloc>
   43858:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4385c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43860:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   43867:	00 00 30 00 
   4386b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4386f:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43876:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4387a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43880:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43886:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4388b:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   43890:	48 89 c7             	mov    %rax,%rdi
   43893:	e8 db ef ff ff       	call   42873 <virtual_memory_map>
   43898:	90                   	nop
   43899:	c9                   	leave  
   4389a:	c3                   	ret    

000000000004389b <find_free_pid>:
   4389b:	55                   	push   %rbp
   4389c:	48 89 e5             	mov    %rsp,%rbp
   4389f:	48 83 ec 10          	sub    $0x10,%rsp
   438a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   438aa:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   438b1:	eb 24                	jmp    438d7 <find_free_pid+0x3c>
   438b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   438b6:	48 63 d0             	movslq %eax,%rdx
   438b9:	48 89 d0             	mov    %rdx,%rax
   438bc:	48 c1 e0 04          	shl    $0x4,%rax
   438c0:	48 29 d0             	sub    %rdx,%rax
   438c3:	48 c1 e0 04          	shl    $0x4,%rax
   438c7:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   438cd:	8b 00                	mov    (%rax),%eax
   438cf:	85 c0                	test   %eax,%eax
   438d1:	74 0c                	je     438df <find_free_pid+0x44>
   438d3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   438d7:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   438db:	7e d6                	jle    438b3 <find_free_pid+0x18>
   438dd:	eb 01                	jmp    438e0 <find_free_pid+0x45>
   438df:	90                   	nop
   438e0:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   438e4:	74 05                	je     438eb <find_free_pid+0x50>
   438e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   438e9:	eb 05                	jmp    438f0 <find_free_pid+0x55>
   438eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   438f0:	c9                   	leave  
   438f1:	c3                   	ret    

00000000000438f2 <process_fork>:
   438f2:	55                   	push   %rbp
   438f3:	48 89 e5             	mov    %rsp,%rbp
   438f6:	48 83 ec 40          	sub    $0x40,%rsp
   438fa:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   438fe:	b8 00 00 00 00       	mov    $0x0,%eax
   43903:	e8 93 ff ff ff       	call   4389b <find_free_pid>
   43908:	89 45 f4             	mov    %eax,-0xc(%rbp)
   4390b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   4390f:	75 0a                	jne    4391b <process_fork+0x29>
   43911:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43916:	e9 67 02 00 00       	jmp    43b82 <process_fork+0x290>
   4391b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4391e:	48 63 d0             	movslq %eax,%rdx
   43921:	48 89 d0             	mov    %rdx,%rax
   43924:	48 c1 e0 04          	shl    $0x4,%rax
   43928:	48 29 d0             	sub    %rdx,%rax
   4392b:	48 c1 e0 04          	shl    $0x4,%rax
   4392f:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   43935:	be 00 00 00 00       	mov    $0x0,%esi
   4393a:	48 89 c7             	mov    %rax,%rdi
   4393d:	e8 64 e4 ff ff       	call   41da6 <process_init>
   43942:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43945:	89 c7                	mov    %eax,%edi
   43947:	e8 6d fb ff ff       	call   434b9 <process_config_tables>
   4394c:	83 f8 ff             	cmp    $0xffffffff,%eax
   4394f:	75 0a                	jne    4395b <process_fork+0x69>
   43951:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43956:	e9 27 02 00 00       	jmp    43b82 <process_fork+0x290>
   4395b:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43962:	00 
   43963:	e9 79 01 00 00       	jmp    43ae1 <process_fork+0x1ef>
   43968:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4396c:	8b 00                	mov    (%rax),%eax
   4396e:	48 63 d0             	movslq %eax,%rdx
   43971:	48 89 d0             	mov    %rdx,%rax
   43974:	48 c1 e0 04          	shl    $0x4,%rax
   43978:	48 29 d0             	sub    %rdx,%rax
   4397b:	48 c1 e0 04          	shl    $0x4,%rax
   4397f:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43985:	48 8b 08             	mov    (%rax),%rcx
   43988:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4398c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43990:	48 89 ce             	mov    %rcx,%rsi
   43993:	48 89 c7             	mov    %rax,%rdi
   43996:	e8 9b f2 ff ff       	call   42c36 <virtual_memory_lookup>
   4399b:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4399e:	48 98                	cltq   
   439a0:	83 e0 07             	and    $0x7,%eax
   439a3:	48 83 f8 07          	cmp    $0x7,%rax
   439a7:	0f 85 a1 00 00 00    	jne    43a4e <process_fork+0x15c>
   439ad:	8b 45 f4             	mov    -0xc(%rbp),%eax
   439b0:	89 c7                	mov    %eax,%edi
   439b2:	e8 07 f7 ff ff       	call   430be <palloc>
   439b7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   439bb:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   439c0:	75 14                	jne    439d6 <process_fork+0xe4>
   439c2:	8b 45 f4             	mov    -0xc(%rbp),%eax
   439c5:	89 c7                	mov    %eax,%edi
   439c7:	e8 0b f8 ff ff       	call   431d7 <process_free>
   439cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   439d1:	e9 ac 01 00 00       	jmp    43b82 <process_fork+0x290>
   439d6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   439da:	48 89 c1             	mov    %rax,%rcx
   439dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439e1:	ba 00 10 00 00       	mov    $0x1000,%edx
   439e6:	48 89 ce             	mov    %rcx,%rsi
   439e9:	48 89 c7             	mov    %rax,%rdi
   439ec:	e8 01 02 00 00       	call   43bf2 <memcpy>
   439f1:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   439f5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   439f8:	48 63 d0             	movslq %eax,%rdx
   439fb:	48 89 d0             	mov    %rdx,%rax
   439fe:	48 c1 e0 04          	shl    $0x4,%rax
   43a02:	48 29 d0             	sub    %rdx,%rax
   43a05:	48 c1 e0 04          	shl    $0x4,%rax
   43a09:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43a0f:	48 8b 00             	mov    (%rax),%rax
   43a12:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43a16:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43a1c:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43a22:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43a27:	48 89 fa             	mov    %rdi,%rdx
   43a2a:	48 89 c7             	mov    %rax,%rdi
   43a2d:	e8 41 ee ff ff       	call   42873 <virtual_memory_map>
   43a32:	85 c0                	test   %eax,%eax
   43a34:	0f 84 9f 00 00 00    	je     43ad9 <process_fork+0x1e7>
   43a3a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a3d:	89 c7                	mov    %eax,%edi
   43a3f:	e8 93 f7 ff ff       	call   431d7 <process_free>
   43a44:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a49:	e9 34 01 00 00       	jmp    43b82 <process_fork+0x290>
   43a4e:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43a51:	48 98                	cltq   
   43a53:	83 e0 05             	and    $0x5,%eax
   43a56:	48 83 f8 05          	cmp    $0x5,%rax
   43a5a:	75 7d                	jne    43ad9 <process_fork+0x1e7>
   43a5c:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   43a60:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a63:	48 63 d0             	movslq %eax,%rdx
   43a66:	48 89 d0             	mov    %rdx,%rax
   43a69:	48 c1 e0 04          	shl    $0x4,%rax
   43a6d:	48 29 d0             	sub    %rdx,%rax
   43a70:	48 c1 e0 04          	shl    $0x4,%rax
   43a74:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43a7a:	48 8b 00             	mov    (%rax),%rax
   43a7d:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43a81:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43a87:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43a8d:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43a92:	48 89 fa             	mov    %rdi,%rdx
   43a95:	48 89 c7             	mov    %rax,%rdi
   43a98:	e8 d6 ed ff ff       	call   42873 <virtual_memory_map>
   43a9d:	85 c0                	test   %eax,%eax
   43a9f:	74 14                	je     43ab5 <process_fork+0x1c3>
   43aa1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43aa4:	89 c7                	mov    %eax,%edi
   43aa6:	e8 2c f7 ff ff       	call   431d7 <process_free>
   43aab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43ab0:	e9 cd 00 00 00       	jmp    43b82 <process_fork+0x290>
   43ab5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43ab9:	48 c1 e8 0c          	shr    $0xc,%rax
   43abd:	89 c2                	mov    %eax,%edx
   43abf:	48 63 c2             	movslq %edx,%rax
   43ac2:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43ac9:	00 
   43aca:	83 c0 01             	add    $0x1,%eax
   43acd:	89 c1                	mov    %eax,%ecx
   43acf:	48 63 c2             	movslq %edx,%rax
   43ad2:	88 8c 00 21 ff 04 00 	mov    %cl,0x4ff21(%rax,%rax,1)
   43ad9:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43ae0:	00 
   43ae1:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43ae8:	00 
   43ae9:	0f 86 79 fe ff ff    	jbe    43968 <process_fork+0x76>
   43aef:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43af3:	8b 08                	mov    (%rax),%ecx
   43af5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43af8:	48 63 d0             	movslq %eax,%rdx
   43afb:	48 89 d0             	mov    %rdx,%rax
   43afe:	48 c1 e0 04          	shl    $0x4,%rax
   43b02:	48 29 d0             	sub    %rdx,%rax
   43b05:	48 c1 e0 04          	shl    $0x4,%rax
   43b09:	48 8d b0 10 f0 04 00 	lea    0x4f010(%rax),%rsi
   43b10:	48 63 d1             	movslq %ecx,%rdx
   43b13:	48 89 d0             	mov    %rdx,%rax
   43b16:	48 c1 e0 04          	shl    $0x4,%rax
   43b1a:	48 29 d0             	sub    %rdx,%rax
   43b1d:	48 c1 e0 04          	shl    $0x4,%rax
   43b21:	48 8d 90 10 f0 04 00 	lea    0x4f010(%rax),%rdx
   43b28:	48 8d 46 08          	lea    0x8(%rsi),%rax
   43b2c:	48 83 c2 08          	add    $0x8,%rdx
   43b30:	b9 18 00 00 00       	mov    $0x18,%ecx
   43b35:	48 89 c7             	mov    %rax,%rdi
   43b38:	48 89 d6             	mov    %rdx,%rsi
   43b3b:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   43b3e:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b41:	48 63 d0             	movslq %eax,%rdx
   43b44:	48 89 d0             	mov    %rdx,%rax
   43b47:	48 c1 e0 04          	shl    $0x4,%rax
   43b4b:	48 29 d0             	sub    %rdx,%rax
   43b4e:	48 c1 e0 04          	shl    $0x4,%rax
   43b52:	48 05 18 f0 04 00    	add    $0x4f018,%rax
   43b58:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   43b5f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b62:	48 63 d0             	movslq %eax,%rdx
   43b65:	48 89 d0             	mov    %rdx,%rax
   43b68:	48 c1 e0 04          	shl    $0x4,%rax
   43b6c:	48 29 d0             	sub    %rdx,%rax
   43b6f:	48 c1 e0 04          	shl    $0x4,%rax
   43b73:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   43b79:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   43b7f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b82:	c9                   	leave  
   43b83:	c3                   	ret    

0000000000043b84 <process_page_alloc>:
   43b84:	55                   	push   %rbp
   43b85:	48 89 e5             	mov    %rsp,%rbp
   43b88:	48 83 ec 20          	sub    $0x20,%rsp
   43b8c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43b90:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43b94:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   43b9b:	00 
   43b9c:	77 07                	ja     43ba5 <process_page_alloc+0x21>
   43b9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43ba3:	eb 4b                	jmp    43bf0 <process_page_alloc+0x6c>
   43ba5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ba9:	8b 00                	mov    (%rax),%eax
   43bab:	89 c7                	mov    %eax,%edi
   43bad:	e8 0c f5 ff ff       	call   430be <palloc>
   43bb2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43bb6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43bbb:	74 2e                	je     43beb <process_page_alloc+0x67>
   43bbd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43bc1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bc5:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43bcc:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   43bd0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43bd6:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43bdc:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43be1:	48 89 c7             	mov    %rax,%rdi
   43be4:	e8 8a ec ff ff       	call   42873 <virtual_memory_map>
   43be9:	eb 05                	jmp    43bf0 <process_page_alloc+0x6c>
   43beb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43bf0:	c9                   	leave  
   43bf1:	c3                   	ret    

0000000000043bf2 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43bf2:	55                   	push   %rbp
   43bf3:	48 89 e5             	mov    %rsp,%rbp
   43bf6:	48 83 ec 28          	sub    $0x28,%rsp
   43bfa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43bfe:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43c02:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43c06:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43c0a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43c0e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c12:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43c16:	eb 1c                	jmp    43c34 <memcpy+0x42>
        *d = *s;
   43c18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c1c:	0f b6 10             	movzbl (%rax),%edx
   43c1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c23:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43c25:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43c2a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43c2f:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43c34:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43c39:	75 dd                	jne    43c18 <memcpy+0x26>
    }
    return dst;
   43c3b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43c3f:	c9                   	leave  
   43c40:	c3                   	ret    

0000000000043c41 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43c41:	55                   	push   %rbp
   43c42:	48 89 e5             	mov    %rsp,%rbp
   43c45:	48 83 ec 28          	sub    $0x28,%rsp
   43c49:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c4d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43c51:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43c55:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43c59:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43c5d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c61:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43c65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c69:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43c6d:	73 6a                	jae    43cd9 <memmove+0x98>
   43c6f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43c73:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c77:	48 01 d0             	add    %rdx,%rax
   43c7a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43c7e:	73 59                	jae    43cd9 <memmove+0x98>
        s += n, d += n;
   43c80:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c84:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43c88:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c8c:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43c90:	eb 17                	jmp    43ca9 <memmove+0x68>
            *--d = *--s;
   43c92:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43c97:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43c9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ca0:	0f b6 10             	movzbl (%rax),%edx
   43ca3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ca7:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43ca9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43cad:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43cb1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43cb5:	48 85 c0             	test   %rax,%rax
   43cb8:	75 d8                	jne    43c92 <memmove+0x51>
    if (s < d && s + n > d) {
   43cba:	eb 2e                	jmp    43cea <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43cbc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43cc0:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43cc4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43cc8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ccc:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43cd0:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43cd4:	0f b6 12             	movzbl (%rdx),%edx
   43cd7:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43cd9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43cdd:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43ce1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43ce5:	48 85 c0             	test   %rax,%rax
   43ce8:	75 d2                	jne    43cbc <memmove+0x7b>
        }
    }
    return dst;
   43cea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43cee:	c9                   	leave  
   43cef:	c3                   	ret    

0000000000043cf0 <memset>:

void* memset(void* v, int c, size_t n) {
   43cf0:	55                   	push   %rbp
   43cf1:	48 89 e5             	mov    %rsp,%rbp
   43cf4:	48 83 ec 28          	sub    $0x28,%rsp
   43cf8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43cfc:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43cff:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43d03:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d07:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43d0b:	eb 15                	jmp    43d22 <memset+0x32>
        *p = c;
   43d0d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43d10:	89 c2                	mov    %eax,%edx
   43d12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d16:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43d18:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43d1d:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43d22:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43d27:	75 e4                	jne    43d0d <memset+0x1d>
    }
    return v;
   43d29:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43d2d:	c9                   	leave  
   43d2e:	c3                   	ret    

0000000000043d2f <strlen>:

size_t strlen(const char* s) {
   43d2f:	55                   	push   %rbp
   43d30:	48 89 e5             	mov    %rsp,%rbp
   43d33:	48 83 ec 18          	sub    $0x18,%rsp
   43d37:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43d3b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43d42:	00 
   43d43:	eb 0a                	jmp    43d4f <strlen+0x20>
        ++n;
   43d45:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43d4a:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43d4f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d53:	0f b6 00             	movzbl (%rax),%eax
   43d56:	84 c0                	test   %al,%al
   43d58:	75 eb                	jne    43d45 <strlen+0x16>
    }
    return n;
   43d5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43d5e:	c9                   	leave  
   43d5f:	c3                   	ret    

0000000000043d60 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43d60:	55                   	push   %rbp
   43d61:	48 89 e5             	mov    %rsp,%rbp
   43d64:	48 83 ec 20          	sub    $0x20,%rsp
   43d68:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d6c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43d70:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43d77:	00 
   43d78:	eb 0a                	jmp    43d84 <strnlen+0x24>
        ++n;
   43d7a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43d7f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43d84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d88:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43d8c:	74 0b                	je     43d99 <strnlen+0x39>
   43d8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d92:	0f b6 00             	movzbl (%rax),%eax
   43d95:	84 c0                	test   %al,%al
   43d97:	75 e1                	jne    43d7a <strnlen+0x1a>
    }
    return n;
   43d99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43d9d:	c9                   	leave  
   43d9e:	c3                   	ret    

0000000000043d9f <strcpy>:

char* strcpy(char* dst, const char* src) {
   43d9f:	55                   	push   %rbp
   43da0:	48 89 e5             	mov    %rsp,%rbp
   43da3:	48 83 ec 20          	sub    $0x20,%rsp
   43da7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43dab:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43daf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43db3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43db7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43dbb:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43dbf:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43dc3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dc7:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43dcb:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43dcf:	0f b6 12             	movzbl (%rdx),%edx
   43dd2:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43dd4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dd8:	48 83 e8 01          	sub    $0x1,%rax
   43ddc:	0f b6 00             	movzbl (%rax),%eax
   43ddf:	84 c0                	test   %al,%al
   43de1:	75 d4                	jne    43db7 <strcpy+0x18>
    return dst;
   43de3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43de7:	c9                   	leave  
   43de8:	c3                   	ret    

0000000000043de9 <strcmp>:

int strcmp(const char* a, const char* b) {
   43de9:	55                   	push   %rbp
   43dea:	48 89 e5             	mov    %rsp,%rbp
   43ded:	48 83 ec 10          	sub    $0x10,%rsp
   43df1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43df5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43df9:	eb 0a                	jmp    43e05 <strcmp+0x1c>
        ++a, ++b;
   43dfb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43e00:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43e05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e09:	0f b6 00             	movzbl (%rax),%eax
   43e0c:	84 c0                	test   %al,%al
   43e0e:	74 1d                	je     43e2d <strcmp+0x44>
   43e10:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e14:	0f b6 00             	movzbl (%rax),%eax
   43e17:	84 c0                	test   %al,%al
   43e19:	74 12                	je     43e2d <strcmp+0x44>
   43e1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e1f:	0f b6 10             	movzbl (%rax),%edx
   43e22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e26:	0f b6 00             	movzbl (%rax),%eax
   43e29:	38 c2                	cmp    %al,%dl
   43e2b:	74 ce                	je     43dfb <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43e2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e31:	0f b6 00             	movzbl (%rax),%eax
   43e34:	89 c2                	mov    %eax,%edx
   43e36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e3a:	0f b6 00             	movzbl (%rax),%eax
   43e3d:	38 d0                	cmp    %dl,%al
   43e3f:	0f 92 c0             	setb   %al
   43e42:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43e45:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e49:	0f b6 00             	movzbl (%rax),%eax
   43e4c:	89 c1                	mov    %eax,%ecx
   43e4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e52:	0f b6 00             	movzbl (%rax),%eax
   43e55:	38 c1                	cmp    %al,%cl
   43e57:	0f 92 c0             	setb   %al
   43e5a:	0f b6 c0             	movzbl %al,%eax
   43e5d:	29 c2                	sub    %eax,%edx
   43e5f:	89 d0                	mov    %edx,%eax
}
   43e61:	c9                   	leave  
   43e62:	c3                   	ret    

0000000000043e63 <strchr>:

char* strchr(const char* s, int c) {
   43e63:	55                   	push   %rbp
   43e64:	48 89 e5             	mov    %rsp,%rbp
   43e67:	48 83 ec 10          	sub    $0x10,%rsp
   43e6b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43e6f:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43e72:	eb 05                	jmp    43e79 <strchr+0x16>
        ++s;
   43e74:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43e79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e7d:	0f b6 00             	movzbl (%rax),%eax
   43e80:	84 c0                	test   %al,%al
   43e82:	74 0e                	je     43e92 <strchr+0x2f>
   43e84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e88:	0f b6 00             	movzbl (%rax),%eax
   43e8b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43e8e:	38 d0                	cmp    %dl,%al
   43e90:	75 e2                	jne    43e74 <strchr+0x11>
    }
    if (*s == (char) c) {
   43e92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e96:	0f b6 00             	movzbl (%rax),%eax
   43e99:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43e9c:	38 d0                	cmp    %dl,%al
   43e9e:	75 06                	jne    43ea6 <strchr+0x43>
        return (char*) s;
   43ea0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ea4:	eb 05                	jmp    43eab <strchr+0x48>
    } else {
        return NULL;
   43ea6:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43eab:	c9                   	leave  
   43eac:	c3                   	ret    

0000000000043ead <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43ead:	55                   	push   %rbp
   43eae:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43eb1:	8b 05 51 41 01 00    	mov    0x14151(%rip),%eax        # 58008 <rand_seed_set>
   43eb7:	85 c0                	test   %eax,%eax
   43eb9:	75 0a                	jne    43ec5 <rand+0x18>
        srand(819234718U);
   43ebb:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43ec0:	e8 24 00 00 00       	call   43ee9 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43ec5:	8b 05 41 41 01 00    	mov    0x14141(%rip),%eax        # 5800c <rand_seed>
   43ecb:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43ed1:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43ed6:	89 05 30 41 01 00    	mov    %eax,0x14130(%rip)        # 5800c <rand_seed>
    return rand_seed & RAND_MAX;
   43edc:	8b 05 2a 41 01 00    	mov    0x1412a(%rip),%eax        # 5800c <rand_seed>
   43ee2:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43ee7:	5d                   	pop    %rbp
   43ee8:	c3                   	ret    

0000000000043ee9 <srand>:

void srand(unsigned seed) {
   43ee9:	55                   	push   %rbp
   43eea:	48 89 e5             	mov    %rsp,%rbp
   43eed:	48 83 ec 08          	sub    $0x8,%rsp
   43ef1:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43ef4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43ef7:	89 05 0f 41 01 00    	mov    %eax,0x1410f(%rip)        # 5800c <rand_seed>
    rand_seed_set = 1;
   43efd:	c7 05 01 41 01 00 01 	movl   $0x1,0x14101(%rip)        # 58008 <rand_seed_set>
   43f04:	00 00 00 
}
   43f07:	90                   	nop
   43f08:	c9                   	leave  
   43f09:	c3                   	ret    

0000000000043f0a <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43f0a:	55                   	push   %rbp
   43f0b:	48 89 e5             	mov    %rsp,%rbp
   43f0e:	48 83 ec 28          	sub    $0x28,%rsp
   43f12:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43f16:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43f1a:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43f1d:	48 c7 45 f8 c0 5a 04 	movq   $0x45ac0,-0x8(%rbp)
   43f24:	00 
    if (base < 0) {
   43f25:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43f29:	79 0b                	jns    43f36 <fill_numbuf+0x2c>
        digits = lower_digits;
   43f2b:	48 c7 45 f8 e0 5a 04 	movq   $0x45ae0,-0x8(%rbp)
   43f32:	00 
        base = -base;
   43f33:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43f36:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43f3b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f3f:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43f42:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43f45:	48 63 c8             	movslq %eax,%rcx
   43f48:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f4c:	ba 00 00 00 00       	mov    $0x0,%edx
   43f51:	48 f7 f1             	div    %rcx
   43f54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f58:	48 01 d0             	add    %rdx,%rax
   43f5b:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43f60:	0f b6 10             	movzbl (%rax),%edx
   43f63:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f67:	88 10                	mov    %dl,(%rax)
        val /= base;
   43f69:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43f6c:	48 63 f0             	movslq %eax,%rsi
   43f6f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f73:	ba 00 00 00 00       	mov    $0x0,%edx
   43f78:	48 f7 f6             	div    %rsi
   43f7b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43f7f:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43f84:	75 bc                	jne    43f42 <fill_numbuf+0x38>
    return numbuf_end;
   43f86:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43f8a:	c9                   	leave  
   43f8b:	c3                   	ret    

0000000000043f8c <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43f8c:	55                   	push   %rbp
   43f8d:	48 89 e5             	mov    %rsp,%rbp
   43f90:	53                   	push   %rbx
   43f91:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43f98:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43f9f:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43fa5:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43fac:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43fb3:	e9 8a 09 00 00       	jmp    44942 <printer_vprintf+0x9b6>
        if (*format != '%') {
   43fb8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fbf:	0f b6 00             	movzbl (%rax),%eax
   43fc2:	3c 25                	cmp    $0x25,%al
   43fc4:	74 31                	je     43ff7 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   43fc6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43fcd:	4c 8b 00             	mov    (%rax),%r8
   43fd0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fd7:	0f b6 00             	movzbl (%rax),%eax
   43fda:	0f b6 c8             	movzbl %al,%ecx
   43fdd:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43fe3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43fea:	89 ce                	mov    %ecx,%esi
   43fec:	48 89 c7             	mov    %rax,%rdi
   43fef:	41 ff d0             	call   *%r8
            continue;
   43ff2:	e9 43 09 00 00       	jmp    4493a <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   43ff7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43ffe:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44005:	01 
   44006:	eb 44                	jmp    4404c <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   44008:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4400f:	0f b6 00             	movzbl (%rax),%eax
   44012:	0f be c0             	movsbl %al,%eax
   44015:	89 c6                	mov    %eax,%esi
   44017:	bf e0 58 04 00       	mov    $0x458e0,%edi
   4401c:	e8 42 fe ff ff       	call   43e63 <strchr>
   44021:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   44025:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   4402a:	74 30                	je     4405c <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   4402c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   44030:	48 2d e0 58 04 00    	sub    $0x458e0,%rax
   44036:	ba 01 00 00 00       	mov    $0x1,%edx
   4403b:	89 c1                	mov    %eax,%ecx
   4403d:	d3 e2                	shl    %cl,%edx
   4403f:	89 d0                	mov    %edx,%eax
   44041:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   44044:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4404b:	01 
   4404c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44053:	0f b6 00             	movzbl (%rax),%eax
   44056:	84 c0                	test   %al,%al
   44058:	75 ae                	jne    44008 <printer_vprintf+0x7c>
   4405a:	eb 01                	jmp    4405d <printer_vprintf+0xd1>
            } else {
                break;
   4405c:	90                   	nop
            }
        }

        // process width
        int width = -1;
   4405d:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   44064:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4406b:	0f b6 00             	movzbl (%rax),%eax
   4406e:	3c 30                	cmp    $0x30,%al
   44070:	7e 67                	jle    440d9 <printer_vprintf+0x14d>
   44072:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44079:	0f b6 00             	movzbl (%rax),%eax
   4407c:	3c 39                	cmp    $0x39,%al
   4407e:	7f 59                	jg     440d9 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   44080:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   44087:	eb 2e                	jmp    440b7 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   44089:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4408c:	89 d0                	mov    %edx,%eax
   4408e:	c1 e0 02             	shl    $0x2,%eax
   44091:	01 d0                	add    %edx,%eax
   44093:	01 c0                	add    %eax,%eax
   44095:	89 c1                	mov    %eax,%ecx
   44097:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4409e:	48 8d 50 01          	lea    0x1(%rax),%rdx
   440a2:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   440a9:	0f b6 00             	movzbl (%rax),%eax
   440ac:	0f be c0             	movsbl %al,%eax
   440af:	01 c8                	add    %ecx,%eax
   440b1:	83 e8 30             	sub    $0x30,%eax
   440b4:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   440b7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440be:	0f b6 00             	movzbl (%rax),%eax
   440c1:	3c 2f                	cmp    $0x2f,%al
   440c3:	0f 8e 85 00 00 00    	jle    4414e <printer_vprintf+0x1c2>
   440c9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440d0:	0f b6 00             	movzbl (%rax),%eax
   440d3:	3c 39                	cmp    $0x39,%al
   440d5:	7e b2                	jle    44089 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   440d7:	eb 75                	jmp    4414e <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   440d9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440e0:	0f b6 00             	movzbl (%rax),%eax
   440e3:	3c 2a                	cmp    $0x2a,%al
   440e5:	75 68                	jne    4414f <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   440e7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440ee:	8b 00                	mov    (%rax),%eax
   440f0:	83 f8 2f             	cmp    $0x2f,%eax
   440f3:	77 30                	ja     44125 <printer_vprintf+0x199>
   440f5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440fc:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44100:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44107:	8b 00                	mov    (%rax),%eax
   44109:	89 c0                	mov    %eax,%eax
   4410b:	48 01 d0             	add    %rdx,%rax
   4410e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44115:	8b 12                	mov    (%rdx),%edx
   44117:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4411a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44121:	89 0a                	mov    %ecx,(%rdx)
   44123:	eb 1a                	jmp    4413f <printer_vprintf+0x1b3>
   44125:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4412c:	48 8b 40 08          	mov    0x8(%rax),%rax
   44130:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44134:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4413b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4413f:	8b 00                	mov    (%rax),%eax
   44141:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   44144:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4414b:	01 
   4414c:	eb 01                	jmp    4414f <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   4414e:	90                   	nop
        }

        // process precision
        int precision = -1;
   4414f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   44156:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4415d:	0f b6 00             	movzbl (%rax),%eax
   44160:	3c 2e                	cmp    $0x2e,%al
   44162:	0f 85 00 01 00 00    	jne    44268 <printer_vprintf+0x2dc>
            ++format;
   44168:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4416f:	01 
            if (*format >= '0' && *format <= '9') {
   44170:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44177:	0f b6 00             	movzbl (%rax),%eax
   4417a:	3c 2f                	cmp    $0x2f,%al
   4417c:	7e 67                	jle    441e5 <printer_vprintf+0x259>
   4417e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44185:	0f b6 00             	movzbl (%rax),%eax
   44188:	3c 39                	cmp    $0x39,%al
   4418a:	7f 59                	jg     441e5 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4418c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   44193:	eb 2e                	jmp    441c3 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   44195:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   44198:	89 d0                	mov    %edx,%eax
   4419a:	c1 e0 02             	shl    $0x2,%eax
   4419d:	01 d0                	add    %edx,%eax
   4419f:	01 c0                	add    %eax,%eax
   441a1:	89 c1                	mov    %eax,%ecx
   441a3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441aa:	48 8d 50 01          	lea    0x1(%rax),%rdx
   441ae:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   441b5:	0f b6 00             	movzbl (%rax),%eax
   441b8:	0f be c0             	movsbl %al,%eax
   441bb:	01 c8                	add    %ecx,%eax
   441bd:	83 e8 30             	sub    $0x30,%eax
   441c0:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   441c3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441ca:	0f b6 00             	movzbl (%rax),%eax
   441cd:	3c 2f                	cmp    $0x2f,%al
   441cf:	0f 8e 85 00 00 00    	jle    4425a <printer_vprintf+0x2ce>
   441d5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441dc:	0f b6 00             	movzbl (%rax),%eax
   441df:	3c 39                	cmp    $0x39,%al
   441e1:	7e b2                	jle    44195 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   441e3:	eb 75                	jmp    4425a <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   441e5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441ec:	0f b6 00             	movzbl (%rax),%eax
   441ef:	3c 2a                	cmp    $0x2a,%al
   441f1:	75 68                	jne    4425b <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   441f3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441fa:	8b 00                	mov    (%rax),%eax
   441fc:	83 f8 2f             	cmp    $0x2f,%eax
   441ff:	77 30                	ja     44231 <printer_vprintf+0x2a5>
   44201:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44208:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4420c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44213:	8b 00                	mov    (%rax),%eax
   44215:	89 c0                	mov    %eax,%eax
   44217:	48 01 d0             	add    %rdx,%rax
   4421a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44221:	8b 12                	mov    (%rdx),%edx
   44223:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44226:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4422d:	89 0a                	mov    %ecx,(%rdx)
   4422f:	eb 1a                	jmp    4424b <printer_vprintf+0x2bf>
   44231:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44238:	48 8b 40 08          	mov    0x8(%rax),%rax
   4423c:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44240:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44247:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4424b:	8b 00                	mov    (%rax),%eax
   4424d:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   44250:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44257:	01 
   44258:	eb 01                	jmp    4425b <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   4425a:	90                   	nop
            }
            if (precision < 0) {
   4425b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4425f:	79 07                	jns    44268 <printer_vprintf+0x2dc>
                precision = 0;
   44261:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   44268:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   4426f:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   44276:	00 
        int length = 0;
   44277:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   4427e:	48 c7 45 c8 e6 58 04 	movq   $0x458e6,-0x38(%rbp)
   44285:	00 
    again:
        switch (*format) {
   44286:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4428d:	0f b6 00             	movzbl (%rax),%eax
   44290:	0f be c0             	movsbl %al,%eax
   44293:	83 e8 43             	sub    $0x43,%eax
   44296:	83 f8 37             	cmp    $0x37,%eax
   44299:	0f 87 9f 03 00 00    	ja     4463e <printer_vprintf+0x6b2>
   4429f:	89 c0                	mov    %eax,%eax
   442a1:	48 8b 04 c5 f8 58 04 	mov    0x458f8(,%rax,8),%rax
   442a8:	00 
   442a9:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   442ab:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   442b2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   442b9:	01 
            goto again;
   442ba:	eb ca                	jmp    44286 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   442bc:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   442c0:	74 5d                	je     4431f <printer_vprintf+0x393>
   442c2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442c9:	8b 00                	mov    (%rax),%eax
   442cb:	83 f8 2f             	cmp    $0x2f,%eax
   442ce:	77 30                	ja     44300 <printer_vprintf+0x374>
   442d0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442d7:	48 8b 50 10          	mov    0x10(%rax),%rdx
   442db:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442e2:	8b 00                	mov    (%rax),%eax
   442e4:	89 c0                	mov    %eax,%eax
   442e6:	48 01 d0             	add    %rdx,%rax
   442e9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442f0:	8b 12                	mov    (%rdx),%edx
   442f2:	8d 4a 08             	lea    0x8(%rdx),%ecx
   442f5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442fc:	89 0a                	mov    %ecx,(%rdx)
   442fe:	eb 1a                	jmp    4431a <printer_vprintf+0x38e>
   44300:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44307:	48 8b 40 08          	mov    0x8(%rax),%rax
   4430b:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4430f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44316:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4431a:	48 8b 00             	mov    (%rax),%rax
   4431d:	eb 5c                	jmp    4437b <printer_vprintf+0x3ef>
   4431f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44326:	8b 00                	mov    (%rax),%eax
   44328:	83 f8 2f             	cmp    $0x2f,%eax
   4432b:	77 30                	ja     4435d <printer_vprintf+0x3d1>
   4432d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44334:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44338:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4433f:	8b 00                	mov    (%rax),%eax
   44341:	89 c0                	mov    %eax,%eax
   44343:	48 01 d0             	add    %rdx,%rax
   44346:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4434d:	8b 12                	mov    (%rdx),%edx
   4434f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44352:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44359:	89 0a                	mov    %ecx,(%rdx)
   4435b:	eb 1a                	jmp    44377 <printer_vprintf+0x3eb>
   4435d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44364:	48 8b 40 08          	mov    0x8(%rax),%rax
   44368:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4436c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44373:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44377:	8b 00                	mov    (%rax),%eax
   44379:	48 98                	cltq   
   4437b:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   4437f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44383:	48 c1 f8 38          	sar    $0x38,%rax
   44387:	25 80 00 00 00       	and    $0x80,%eax
   4438c:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   4438f:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   44393:	74 09                	je     4439e <printer_vprintf+0x412>
   44395:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44399:	48 f7 d8             	neg    %rax
   4439c:	eb 04                	jmp    443a2 <printer_vprintf+0x416>
   4439e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   443a2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   443a6:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   443a9:	83 c8 60             	or     $0x60,%eax
   443ac:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   443af:	e9 cf 02 00 00       	jmp    44683 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   443b4:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   443b8:	74 5d                	je     44417 <printer_vprintf+0x48b>
   443ba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443c1:	8b 00                	mov    (%rax),%eax
   443c3:	83 f8 2f             	cmp    $0x2f,%eax
   443c6:	77 30                	ja     443f8 <printer_vprintf+0x46c>
   443c8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443cf:	48 8b 50 10          	mov    0x10(%rax),%rdx
   443d3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443da:	8b 00                	mov    (%rax),%eax
   443dc:	89 c0                	mov    %eax,%eax
   443de:	48 01 d0             	add    %rdx,%rax
   443e1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443e8:	8b 12                	mov    (%rdx),%edx
   443ea:	8d 4a 08             	lea    0x8(%rdx),%ecx
   443ed:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443f4:	89 0a                	mov    %ecx,(%rdx)
   443f6:	eb 1a                	jmp    44412 <printer_vprintf+0x486>
   443f8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443ff:	48 8b 40 08          	mov    0x8(%rax),%rax
   44403:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44407:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4440e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44412:	48 8b 00             	mov    (%rax),%rax
   44415:	eb 5c                	jmp    44473 <printer_vprintf+0x4e7>
   44417:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4441e:	8b 00                	mov    (%rax),%eax
   44420:	83 f8 2f             	cmp    $0x2f,%eax
   44423:	77 30                	ja     44455 <printer_vprintf+0x4c9>
   44425:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4442c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44430:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44437:	8b 00                	mov    (%rax),%eax
   44439:	89 c0                	mov    %eax,%eax
   4443b:	48 01 d0             	add    %rdx,%rax
   4443e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44445:	8b 12                	mov    (%rdx),%edx
   44447:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4444a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44451:	89 0a                	mov    %ecx,(%rdx)
   44453:	eb 1a                	jmp    4446f <printer_vprintf+0x4e3>
   44455:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4445c:	48 8b 40 08          	mov    0x8(%rax),%rax
   44460:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44464:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4446b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4446f:	8b 00                	mov    (%rax),%eax
   44471:	89 c0                	mov    %eax,%eax
   44473:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   44477:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   4447b:	e9 03 02 00 00       	jmp    44683 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   44480:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   44487:	e9 28 ff ff ff       	jmp    443b4 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   4448c:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   44493:	e9 1c ff ff ff       	jmp    443b4 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   44498:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4449f:	8b 00                	mov    (%rax),%eax
   444a1:	83 f8 2f             	cmp    $0x2f,%eax
   444a4:	77 30                	ja     444d6 <printer_vprintf+0x54a>
   444a6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444ad:	48 8b 50 10          	mov    0x10(%rax),%rdx
   444b1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444b8:	8b 00                	mov    (%rax),%eax
   444ba:	89 c0                	mov    %eax,%eax
   444bc:	48 01 d0             	add    %rdx,%rax
   444bf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444c6:	8b 12                	mov    (%rdx),%edx
   444c8:	8d 4a 08             	lea    0x8(%rdx),%ecx
   444cb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444d2:	89 0a                	mov    %ecx,(%rdx)
   444d4:	eb 1a                	jmp    444f0 <printer_vprintf+0x564>
   444d6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444dd:	48 8b 40 08          	mov    0x8(%rax),%rax
   444e1:	48 8d 48 08          	lea    0x8(%rax),%rcx
   444e5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444ec:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   444f0:	48 8b 00             	mov    (%rax),%rax
   444f3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   444f7:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   444fe:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   44505:	e9 79 01 00 00       	jmp    44683 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   4450a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44511:	8b 00                	mov    (%rax),%eax
   44513:	83 f8 2f             	cmp    $0x2f,%eax
   44516:	77 30                	ja     44548 <printer_vprintf+0x5bc>
   44518:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4451f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44523:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4452a:	8b 00                	mov    (%rax),%eax
   4452c:	89 c0                	mov    %eax,%eax
   4452e:	48 01 d0             	add    %rdx,%rax
   44531:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44538:	8b 12                	mov    (%rdx),%edx
   4453a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4453d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44544:	89 0a                	mov    %ecx,(%rdx)
   44546:	eb 1a                	jmp    44562 <printer_vprintf+0x5d6>
   44548:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4454f:	48 8b 40 08          	mov    0x8(%rax),%rax
   44553:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44557:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4455e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44562:	48 8b 00             	mov    (%rax),%rax
   44565:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   44569:	e9 15 01 00 00       	jmp    44683 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   4456e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44575:	8b 00                	mov    (%rax),%eax
   44577:	83 f8 2f             	cmp    $0x2f,%eax
   4457a:	77 30                	ja     445ac <printer_vprintf+0x620>
   4457c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44583:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44587:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4458e:	8b 00                	mov    (%rax),%eax
   44590:	89 c0                	mov    %eax,%eax
   44592:	48 01 d0             	add    %rdx,%rax
   44595:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4459c:	8b 12                	mov    (%rdx),%edx
   4459e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   445a1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445a8:	89 0a                	mov    %ecx,(%rdx)
   445aa:	eb 1a                	jmp    445c6 <printer_vprintf+0x63a>
   445ac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445b3:	48 8b 40 08          	mov    0x8(%rax),%rax
   445b7:	48 8d 48 08          	lea    0x8(%rax),%rcx
   445bb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445c2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   445c6:	8b 00                	mov    (%rax),%eax
   445c8:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   445ce:	e9 67 03 00 00       	jmp    4493a <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   445d3:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   445d7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   445db:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445e2:	8b 00                	mov    (%rax),%eax
   445e4:	83 f8 2f             	cmp    $0x2f,%eax
   445e7:	77 30                	ja     44619 <printer_vprintf+0x68d>
   445e9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445f0:	48 8b 50 10          	mov    0x10(%rax),%rdx
   445f4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445fb:	8b 00                	mov    (%rax),%eax
   445fd:	89 c0                	mov    %eax,%eax
   445ff:	48 01 d0             	add    %rdx,%rax
   44602:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44609:	8b 12                	mov    (%rdx),%edx
   4460b:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4460e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44615:	89 0a                	mov    %ecx,(%rdx)
   44617:	eb 1a                	jmp    44633 <printer_vprintf+0x6a7>
   44619:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44620:	48 8b 40 08          	mov    0x8(%rax),%rax
   44624:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44628:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4462f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44633:	8b 00                	mov    (%rax),%eax
   44635:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44638:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   4463c:	eb 45                	jmp    44683 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   4463e:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44642:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   44646:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4464d:	0f b6 00             	movzbl (%rax),%eax
   44650:	84 c0                	test   %al,%al
   44652:	74 0c                	je     44660 <printer_vprintf+0x6d4>
   44654:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4465b:	0f b6 00             	movzbl (%rax),%eax
   4465e:	eb 05                	jmp    44665 <printer_vprintf+0x6d9>
   44660:	b8 25 00 00 00       	mov    $0x25,%eax
   44665:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44668:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   4466c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44673:	0f b6 00             	movzbl (%rax),%eax
   44676:	84 c0                	test   %al,%al
   44678:	75 08                	jne    44682 <printer_vprintf+0x6f6>
                format--;
   4467a:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   44681:	01 
            }
            break;
   44682:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   44683:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44686:	83 e0 20             	and    $0x20,%eax
   44689:	85 c0                	test   %eax,%eax
   4468b:	74 1e                	je     446ab <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   4468d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44691:	48 83 c0 18          	add    $0x18,%rax
   44695:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44698:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   4469c:	48 89 ce             	mov    %rcx,%rsi
   4469f:	48 89 c7             	mov    %rax,%rdi
   446a2:	e8 63 f8 ff ff       	call   43f0a <fill_numbuf>
   446a7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   446ab:	48 c7 45 c0 e6 58 04 	movq   $0x458e6,-0x40(%rbp)
   446b2:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   446b3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446b6:	83 e0 20             	and    $0x20,%eax
   446b9:	85 c0                	test   %eax,%eax
   446bb:	74 48                	je     44705 <printer_vprintf+0x779>
   446bd:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446c0:	83 e0 40             	and    $0x40,%eax
   446c3:	85 c0                	test   %eax,%eax
   446c5:	74 3e                	je     44705 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   446c7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446ca:	25 80 00 00 00       	and    $0x80,%eax
   446cf:	85 c0                	test   %eax,%eax
   446d1:	74 0a                	je     446dd <printer_vprintf+0x751>
                prefix = "-";
   446d3:	48 c7 45 c0 e7 58 04 	movq   $0x458e7,-0x40(%rbp)
   446da:	00 
            if (flags & FLAG_NEGATIVE) {
   446db:	eb 73                	jmp    44750 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   446dd:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446e0:	83 e0 10             	and    $0x10,%eax
   446e3:	85 c0                	test   %eax,%eax
   446e5:	74 0a                	je     446f1 <printer_vprintf+0x765>
                prefix = "+";
   446e7:	48 c7 45 c0 e9 58 04 	movq   $0x458e9,-0x40(%rbp)
   446ee:	00 
            if (flags & FLAG_NEGATIVE) {
   446ef:	eb 5f                	jmp    44750 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   446f1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446f4:	83 e0 08             	and    $0x8,%eax
   446f7:	85 c0                	test   %eax,%eax
   446f9:	74 55                	je     44750 <printer_vprintf+0x7c4>
                prefix = " ";
   446fb:	48 c7 45 c0 eb 58 04 	movq   $0x458eb,-0x40(%rbp)
   44702:	00 
            if (flags & FLAG_NEGATIVE) {
   44703:	eb 4b                	jmp    44750 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   44705:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44708:	83 e0 20             	and    $0x20,%eax
   4470b:	85 c0                	test   %eax,%eax
   4470d:	74 42                	je     44751 <printer_vprintf+0x7c5>
   4470f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44712:	83 e0 01             	and    $0x1,%eax
   44715:	85 c0                	test   %eax,%eax
   44717:	74 38                	je     44751 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   44719:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   4471d:	74 06                	je     44725 <printer_vprintf+0x799>
   4471f:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44723:	75 2c                	jne    44751 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   44725:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4472a:	75 0c                	jne    44738 <printer_vprintf+0x7ac>
   4472c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4472f:	25 00 01 00 00       	and    $0x100,%eax
   44734:	85 c0                	test   %eax,%eax
   44736:	74 19                	je     44751 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   44738:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   4473c:	75 07                	jne    44745 <printer_vprintf+0x7b9>
   4473e:	b8 ed 58 04 00       	mov    $0x458ed,%eax
   44743:	eb 05                	jmp    4474a <printer_vprintf+0x7be>
   44745:	b8 f0 58 04 00       	mov    $0x458f0,%eax
   4474a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4474e:	eb 01                	jmp    44751 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   44750:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   44751:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44755:	78 24                	js     4477b <printer_vprintf+0x7ef>
   44757:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4475a:	83 e0 20             	and    $0x20,%eax
   4475d:	85 c0                	test   %eax,%eax
   4475f:	75 1a                	jne    4477b <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   44761:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44764:	48 63 d0             	movslq %eax,%rdx
   44767:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4476b:	48 89 d6             	mov    %rdx,%rsi
   4476e:	48 89 c7             	mov    %rax,%rdi
   44771:	e8 ea f5 ff ff       	call   43d60 <strnlen>
   44776:	89 45 bc             	mov    %eax,-0x44(%rbp)
   44779:	eb 0f                	jmp    4478a <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   4477b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4477f:	48 89 c7             	mov    %rax,%rdi
   44782:	e8 a8 f5 ff ff       	call   43d2f <strlen>
   44787:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   4478a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4478d:	83 e0 20             	and    $0x20,%eax
   44790:	85 c0                	test   %eax,%eax
   44792:	74 20                	je     447b4 <printer_vprintf+0x828>
   44794:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44798:	78 1a                	js     447b4 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   4479a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4479d:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   447a0:	7e 08                	jle    447aa <printer_vprintf+0x81e>
   447a2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   447a5:	2b 45 bc             	sub    -0x44(%rbp),%eax
   447a8:	eb 05                	jmp    447af <printer_vprintf+0x823>
   447aa:	b8 00 00 00 00       	mov    $0x0,%eax
   447af:	89 45 b8             	mov    %eax,-0x48(%rbp)
   447b2:	eb 5c                	jmp    44810 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   447b4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   447b7:	83 e0 20             	and    $0x20,%eax
   447ba:	85 c0                	test   %eax,%eax
   447bc:	74 4b                	je     44809 <printer_vprintf+0x87d>
   447be:	8b 45 ec             	mov    -0x14(%rbp),%eax
   447c1:	83 e0 02             	and    $0x2,%eax
   447c4:	85 c0                	test   %eax,%eax
   447c6:	74 41                	je     44809 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   447c8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   447cb:	83 e0 04             	and    $0x4,%eax
   447ce:	85 c0                	test   %eax,%eax
   447d0:	75 37                	jne    44809 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   447d2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   447d6:	48 89 c7             	mov    %rax,%rdi
   447d9:	e8 51 f5 ff ff       	call   43d2f <strlen>
   447de:	89 c2                	mov    %eax,%edx
   447e0:	8b 45 bc             	mov    -0x44(%rbp),%eax
   447e3:	01 d0                	add    %edx,%eax
   447e5:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   447e8:	7e 1f                	jle    44809 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   447ea:	8b 45 e8             	mov    -0x18(%rbp),%eax
   447ed:	2b 45 bc             	sub    -0x44(%rbp),%eax
   447f0:	89 c3                	mov    %eax,%ebx
   447f2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   447f6:	48 89 c7             	mov    %rax,%rdi
   447f9:	e8 31 f5 ff ff       	call   43d2f <strlen>
   447fe:	89 c2                	mov    %eax,%edx
   44800:	89 d8                	mov    %ebx,%eax
   44802:	29 d0                	sub    %edx,%eax
   44804:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44807:	eb 07                	jmp    44810 <printer_vprintf+0x884>
        } else {
            zeros = 0;
   44809:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   44810:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44813:	8b 45 b8             	mov    -0x48(%rbp),%eax
   44816:	01 d0                	add    %edx,%eax
   44818:	48 63 d8             	movslq %eax,%rbx
   4481b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4481f:	48 89 c7             	mov    %rax,%rdi
   44822:	e8 08 f5 ff ff       	call   43d2f <strlen>
   44827:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   4482b:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4482e:	29 d0                	sub    %edx,%eax
   44830:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44833:	eb 25                	jmp    4485a <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   44835:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4483c:	48 8b 08             	mov    (%rax),%rcx
   4483f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44845:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4484c:	be 20 00 00 00       	mov    $0x20,%esi
   44851:	48 89 c7             	mov    %rax,%rdi
   44854:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44856:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   4485a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4485d:	83 e0 04             	and    $0x4,%eax
   44860:	85 c0                	test   %eax,%eax
   44862:	75 36                	jne    4489a <printer_vprintf+0x90e>
   44864:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44868:	7f cb                	jg     44835 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   4486a:	eb 2e                	jmp    4489a <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   4486c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44873:	4c 8b 00             	mov    (%rax),%r8
   44876:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4487a:	0f b6 00             	movzbl (%rax),%eax
   4487d:	0f b6 c8             	movzbl %al,%ecx
   44880:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44886:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4488d:	89 ce                	mov    %ecx,%esi
   4488f:	48 89 c7             	mov    %rax,%rdi
   44892:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   44895:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   4489a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4489e:	0f b6 00             	movzbl (%rax),%eax
   448a1:	84 c0                	test   %al,%al
   448a3:	75 c7                	jne    4486c <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   448a5:	eb 25                	jmp    448cc <printer_vprintf+0x940>
            p->putc(p, '0', color);
   448a7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448ae:	48 8b 08             	mov    (%rax),%rcx
   448b1:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448b7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448be:	be 30 00 00 00       	mov    $0x30,%esi
   448c3:	48 89 c7             	mov    %rax,%rdi
   448c6:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   448c8:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   448cc:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   448d0:	7f d5                	jg     448a7 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   448d2:	eb 32                	jmp    44906 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   448d4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448db:	4c 8b 00             	mov    (%rax),%r8
   448de:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   448e2:	0f b6 00             	movzbl (%rax),%eax
   448e5:	0f b6 c8             	movzbl %al,%ecx
   448e8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448ee:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448f5:	89 ce                	mov    %ecx,%esi
   448f7:	48 89 c7             	mov    %rax,%rdi
   448fa:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   448fd:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44902:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44906:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   4490a:	7f c8                	jg     448d4 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   4490c:	eb 25                	jmp    44933 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   4490e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44915:	48 8b 08             	mov    (%rax),%rcx
   44918:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4491e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44925:	be 20 00 00 00       	mov    $0x20,%esi
   4492a:	48 89 c7             	mov    %rax,%rdi
   4492d:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   4492f:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44933:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44937:	7f d5                	jg     4490e <printer_vprintf+0x982>
        }
    done: ;
   44939:	90                   	nop
    for (; *format; ++format) {
   4493a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44941:	01 
   44942:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44949:	0f b6 00             	movzbl (%rax),%eax
   4494c:	84 c0                	test   %al,%al
   4494e:	0f 85 64 f6 ff ff    	jne    43fb8 <printer_vprintf+0x2c>
    }
}
   44954:	90                   	nop
   44955:	90                   	nop
   44956:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4495a:	c9                   	leave  
   4495b:	c3                   	ret    

000000000004495c <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   4495c:	55                   	push   %rbp
   4495d:	48 89 e5             	mov    %rsp,%rbp
   44960:	48 83 ec 20          	sub    $0x20,%rsp
   44964:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44968:	89 f0                	mov    %esi,%eax
   4496a:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4496d:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44970:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44974:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44978:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4497c:	48 8b 40 08          	mov    0x8(%rax),%rax
   44980:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   44985:	48 39 d0             	cmp    %rdx,%rax
   44988:	72 0c                	jb     44996 <console_putc+0x3a>
        cp->cursor = console;
   4498a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4498e:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   44995:	00 
    }
    if (c == '\n') {
   44996:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   4499a:	75 78                	jne    44a14 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   4499c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449a0:	48 8b 40 08          	mov    0x8(%rax),%rax
   449a4:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   449aa:	48 d1 f8             	sar    %rax
   449ad:	48 89 c1             	mov    %rax,%rcx
   449b0:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   449b7:	66 66 66 
   449ba:	48 89 c8             	mov    %rcx,%rax
   449bd:	48 f7 ea             	imul   %rdx
   449c0:	48 c1 fa 05          	sar    $0x5,%rdx
   449c4:	48 89 c8             	mov    %rcx,%rax
   449c7:	48 c1 f8 3f          	sar    $0x3f,%rax
   449cb:	48 29 c2             	sub    %rax,%rdx
   449ce:	48 89 d0             	mov    %rdx,%rax
   449d1:	48 c1 e0 02          	shl    $0x2,%rax
   449d5:	48 01 d0             	add    %rdx,%rax
   449d8:	48 c1 e0 04          	shl    $0x4,%rax
   449dc:	48 29 c1             	sub    %rax,%rcx
   449df:	48 89 ca             	mov    %rcx,%rdx
   449e2:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   449e5:	eb 25                	jmp    44a0c <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   449e7:	8b 45 e0             	mov    -0x20(%rbp),%eax
   449ea:	83 c8 20             	or     $0x20,%eax
   449ed:	89 c6                	mov    %eax,%esi
   449ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449f3:	48 8b 40 08          	mov    0x8(%rax),%rax
   449f7:	48 8d 48 02          	lea    0x2(%rax),%rcx
   449fb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   449ff:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44a03:	89 f2                	mov    %esi,%edx
   44a05:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   44a08:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44a0c:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44a10:	75 d5                	jne    449e7 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44a12:	eb 24                	jmp    44a38 <console_putc+0xdc>
        *cp->cursor++ = c | color;
   44a14:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   44a18:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44a1b:	09 d0                	or     %edx,%eax
   44a1d:	89 c6                	mov    %eax,%esi
   44a1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44a23:	48 8b 40 08          	mov    0x8(%rax),%rax
   44a27:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44a2b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44a2f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44a33:	89 f2                	mov    %esi,%edx
   44a35:	66 89 10             	mov    %dx,(%rax)
}
   44a38:	90                   	nop
   44a39:	c9                   	leave  
   44a3a:	c3                   	ret    

0000000000044a3b <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44a3b:	55                   	push   %rbp
   44a3c:	48 89 e5             	mov    %rsp,%rbp
   44a3f:	48 83 ec 30          	sub    $0x30,%rsp
   44a43:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44a46:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44a49:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44a4d:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44a51:	48 c7 45 f0 5c 49 04 	movq   $0x4495c,-0x10(%rbp)
   44a58:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44a59:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44a5d:	78 09                	js     44a68 <console_vprintf+0x2d>
   44a5f:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44a66:	7e 07                	jle    44a6f <console_vprintf+0x34>
        cpos = 0;
   44a68:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44a6f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44a72:	48 98                	cltq   
   44a74:	48 01 c0             	add    %rax,%rax
   44a77:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   44a7d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44a81:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44a85:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44a89:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44a8c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44a90:	48 89 c7             	mov    %rax,%rdi
   44a93:	e8 f4 f4 ff ff       	call   43f8c <printer_vprintf>
    return cp.cursor - console;
   44a98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44a9c:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44aa2:	48 d1 f8             	sar    %rax
}
   44aa5:	c9                   	leave  
   44aa6:	c3                   	ret    

0000000000044aa7 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44aa7:	55                   	push   %rbp
   44aa8:	48 89 e5             	mov    %rsp,%rbp
   44aab:	48 83 ec 60          	sub    $0x60,%rsp
   44aaf:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44ab2:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44ab5:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44ab9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44abd:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44ac1:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44ac5:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44acc:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44ad0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44ad4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44ad8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44adc:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44ae0:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44ae4:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44ae7:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44aea:	89 c7                	mov    %eax,%edi
   44aec:	e8 4a ff ff ff       	call   44a3b <console_vprintf>
   44af1:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44af4:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44af7:	c9                   	leave  
   44af8:	c3                   	ret    

0000000000044af9 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44af9:	55                   	push   %rbp
   44afa:	48 89 e5             	mov    %rsp,%rbp
   44afd:	48 83 ec 20          	sub    $0x20,%rsp
   44b01:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44b05:	89 f0                	mov    %esi,%eax
   44b07:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44b0a:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44b0d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44b11:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44b15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44b19:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44b1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44b21:	48 8b 40 10          	mov    0x10(%rax),%rax
   44b25:	48 39 c2             	cmp    %rax,%rdx
   44b28:	73 1a                	jae    44b44 <string_putc+0x4b>
        *sp->s++ = c;
   44b2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44b2e:	48 8b 40 08          	mov    0x8(%rax),%rax
   44b32:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44b36:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44b3a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44b3e:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44b42:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44b44:	90                   	nop
   44b45:	c9                   	leave  
   44b46:	c3                   	ret    

0000000000044b47 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44b47:	55                   	push   %rbp
   44b48:	48 89 e5             	mov    %rsp,%rbp
   44b4b:	48 83 ec 40          	sub    $0x40,%rsp
   44b4f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44b53:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44b57:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44b5b:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44b5f:	48 c7 45 e8 f9 4a 04 	movq   $0x44af9,-0x18(%rbp)
   44b66:	00 
    sp.s = s;
   44b67:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44b6b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44b6f:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44b74:	74 33                	je     44ba9 <vsnprintf+0x62>
        sp.end = s + size - 1;
   44b76:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44b7a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44b7e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44b82:	48 01 d0             	add    %rdx,%rax
   44b85:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44b89:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44b8d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44b91:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44b95:	be 00 00 00 00       	mov    $0x0,%esi
   44b9a:	48 89 c7             	mov    %rax,%rdi
   44b9d:	e8 ea f3 ff ff       	call   43f8c <printer_vprintf>
        *sp.s = 0;
   44ba2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44ba6:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44ba9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44bad:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44bb1:	c9                   	leave  
   44bb2:	c3                   	ret    

0000000000044bb3 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44bb3:	55                   	push   %rbp
   44bb4:	48 89 e5             	mov    %rsp,%rbp
   44bb7:	48 83 ec 70          	sub    $0x70,%rsp
   44bbb:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44bbf:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44bc3:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44bc7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44bcb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44bcf:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44bd3:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44bda:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44bde:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44be2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44be6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44bea:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44bee:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44bf2:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44bf6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44bfa:	48 89 c7             	mov    %rax,%rdi
   44bfd:	e8 45 ff ff ff       	call   44b47 <vsnprintf>
   44c02:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44c05:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44c08:	c9                   	leave  
   44c09:	c3                   	ret    

0000000000044c0a <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44c0a:	55                   	push   %rbp
   44c0b:	48 89 e5             	mov    %rsp,%rbp
   44c0e:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44c12:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44c19:	eb 13                	jmp    44c2e <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   44c1b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44c1e:	48 98                	cltq   
   44c20:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   44c27:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44c2a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44c2e:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44c35:	7e e4                	jle    44c1b <console_clear+0x11>
    }
    cursorpos = 0;
   44c37:	c7 05 bb 43 07 00 00 	movl   $0x0,0x743bb(%rip)        # b8ffc <cursorpos>
   44c3e:	00 00 00 
}
   44c41:	90                   	nop
   44c42:	c9                   	leave  
   44c43:	c3                   	ret    
