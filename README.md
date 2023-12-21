**memory-management**

Implementation of key standard library features needed for user processes in a small operating system (WeensyOS).
Includes:
1. A heap-management system for the kernel: brk() and sbrk() system calls with Optimistic Allocation.
2. Standard C API for heap allocation: malloc(), calloc(), realloc(), and free().
3. Two new APIs: defrag() for defragmentation of the free-list, and heap_info() to provide a debugging feature in the form of a memory report.
