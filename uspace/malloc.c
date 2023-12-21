#include "malloc.h"

// Useful constants
#define NODE_SIZE sizeof(struct node)
#define HEADER_SIZE sizeof(struct header)
#define ALIGNMENT 8

typedef struct header {
    struct header *prev;
    struct header *next;
    uint64_t size;
} header;

typedef struct node {
    struct node *prev;
    struct node *next;
    uint64_t size;
} node;

node* free_head = NULL;
node* free_tail = NULL;
int free_len = 0;

header* malloc_head = NULL;
header* malloc_tail = NULL;
int malloc_len = 0;

void append_free_node(node* block) {
    block->next = NULL;
    block->prev = NULL;
    if (free_head == NULL && free_tail == NULL) {
        free_head = block;
        free_tail = block;
    }
    else {
        free_tail->next = block;
        block->prev = free_tail;
        free_tail = block;
    }
    free_len++;
}

void remove_free_node(node* block) {
    if (block == free_head) {
        free_head = block->next;
    }
    if (block == free_tail) {
        free_tail = block->prev;
    }
    if (block->next != NULL) {
        block->next->prev = block->prev;
    }
    if (block->prev != NULL) {
        block->prev->next = block->next;
    }
    free_len--;
}

void append_malloc_header(header* block) {
    block->next = NULL;
    block->prev = NULL;
    if (malloc_head == NULL && malloc_tail == NULL) {
        malloc_head = block;
        malloc_tail = block;
    }
    else {
        malloc_tail->next = block;
        block->prev = malloc_tail;
        malloc_tail = block;
    }
    malloc_len++;
}

void remove_malloc_header(header* block) {
    if (block == malloc_head) {
        malloc_head = block->next;
    }
    if (block == malloc_tail) {
        malloc_tail = block->prev;
    }
    if (block->next != NULL) {
        block->next->prev = block->prev;
    }
    if (block->prev != NULL) {
        block->prev->next = block->next;
    }
    malloc_len--;
}

struct node* get_free_block(uint64_t size) {
    node* current_node = free_head;
    while (current_node != NULL) {
        if (current_node->size >= HEADER_SIZE + size)
            return current_node;
        current_node = current_node->next;
    }
    return NULL;
}

uintptr_t allocate_block(uint64_t size) {
    node* free_block = get_free_block(size);
    if (free_block == NULL)
        return (uintptr_t) -1;

    // Remove block from the free-list
    remove_free_node(free_block);

    // Set up header and payload
    uintptr_t free_block_addr = (uintptr_t) free_block;
    uint64_t free_block_size = free_block->size;
    uint64_t payload_size = ROUNDUP(size, ALIGNMENT);
    header* new_header = (header*) free_block_addr;
    new_header->size = payload_size;

    // Split free block into allocated and free block (if possible)
    uint64_t malloc_block_size = HEADER_SIZE + payload_size;
    uint64_t leftover_size = free_block_size - malloc_block_size;

    if (leftover_size < NODE_SIZE) {
        new_header->size += leftover_size;
    }
    else {
        node* new_free_node = (node*) (free_block_addr + malloc_block_size);
        new_free_node->size = leftover_size;
        append_free_node(new_free_node);
    }

    append_malloc_header(new_header);
    return free_block_addr;
}


void free(void *firstbyte) {
    if (firstbyte == NULL)
        return;

    uintptr_t addr = (uintptr_t) firstbyte - HEADER_SIZE;

    // Remove header of freed block from malloc-list
    header* malloc_header = (header*) addr;
    uint64_t block_size = malloc_header->size + HEADER_SIZE;
    remove_malloc_header(malloc_header);

    // Add freed block to free-list
    node* free_block = (node*) addr;
    free_block->size = block_size;
    append_free_node(free_block);

    return;
}

void * malloc(uint64_t numbytes) {
    if (numbytes == 0) 
        return NULL;

    uintptr_t addr = allocate_block(numbytes);
    // Expand heap if necessary
    if (addr == (uintptr_t) -1) {
        intptr_t increment = ROUNDUP(numbytes, PAGESIZE*10);
        void* block_addr = sbrk(increment);
        if (block_addr == (void*) -1)
            return NULL;
        node* new_free_node = (node*) block_addr;
        new_free_node->size = increment;
        append_free_node(new_free_node);
        addr = allocate_block(numbytes);
    }
    // Return address to payload
    return (void *) (addr + HEADER_SIZE);
}

void * calloc(uint64_t num, uint64_t sz) {
    uint64_t total_size = num*sz;
    if (total_size == 0 || num * sz / num != sz || num * sz / sz != num) // Check for overflow
        return NULL;

    uint64_t numbytes = ROUNDUP(total_size, ALIGNMENT);
    void* addr = malloc(numbytes);
    if (addr == NULL)
        return NULL;

    memset(addr, 0, numbytes);
    return addr;
}

// realloc(ptr, sz)
// realloc changes the size of the memory block pointed to by ptr to size bytes.
// the contents will be unchanged in the range from the start of the region up to the
// minimum of the old and new sizes
// if the new size is larger than the old size, the added memory will not be initialized
// if ptr is NULL, then the call is equivalent to malloc(size) for all values of size
// if size is equal to zero, and ptr is not NULL, then the call is equivalent to free(ptr)
// unless ptr is NULL, it must have been returned by an earlier call to malloc(), or realloc().
// if the area pointed to was moved, a free(ptr) is done.
void * realloc(void * ptr, uint64_t sz) {
    if (ptr == NULL) {
        return malloc(sz);
    }
    if (sz == 0) {
        free(ptr);
        return NULL;
    }

    // No need to realloc if the size is the same
    header* old_header = (header*) ((uintptr_t) ptr - HEADER_SIZE);
    if (old_header->size == sz)
        return ptr;

    // Otherwise, reallocate by allocating a copy of the old block with the new size
    void* realloc_addr = malloc(sz);
    if (realloc_addr == NULL)
        return NULL;
    header* realloc_header = (header*) ((uintptr_t) realloc_addr - HEADER_SIZE);
    memcpy(realloc_addr, ptr, realloc_header->size);
    free(ptr);
    return realloc_addr;
}

// Struct to sort blocks by address in order to defrag them
typedef struct freeblock {
    void* addr;
    long size;
} freeblock;

// Quicksort implementation from stdlib (qsort)
// -------------------------------------------------------------
/* Byte-wise swap two items of size SIZE. */
#define SWAP(a, b, size)                              \
  do                                          \
    {                                         \
      size_t __size = (size);                             \
      char *__a = (a), *__b = (b);                        \
      do                                      \
    {                                     \
      char __tmp = *__a;                              \
      *__a++ = *__b;                              \
      *__b++ = __tmp;                             \
    } while (--__size > 0);                           \
    } while (0)
/* Discontinue quicksort algorithm when partition gets below this size.
   This particular magic number was chosen to work best on a Sun 4/260. */
#define MAX_THRESH 4
/* Stack node declarations used to store unfulfilled partition obligations. */
typedef struct
  {
    char *lo;
    char *hi;
  } stack_node;
/* The next 4 #defines implement a very fast in-line stack abstraction. */
/* The stack needs log (total_elements) entries (we could even subtract
   log(MAX_THRESH)).  Since total_elements has type size_t, we get as
   upper bound for log (total_elements):
   bits per byte (CHAR_BIT) * sizeof(size_t).  */
#define MAX_THRESH 4
#define CHAR_BIT 8
#define STACK_SIZE  (CHAR_BIT * sizeof (size_t))
#define PUSH(low, high) ((void) ((top->lo = (low)), (top->hi = (high)), ++top))
#define POP(low, high)  ((void) (--top, (low = top->lo), (high = top->hi)))
#define STACK_NOT_EMPTY (stack < top)
/* Order size using quicksort.  This implementation incorporates
   four optimizations discussed in Sedgewick:
   1. Non-recursive, using an explicit stack of pointer that store the
      next array partition to sort.  To save time, this maximum amount
      of space required to store an array of SIZE_MAX is allocated on the
      stack.  Assuming a 32-bit (64 bit) integer for size_t, this needs
      only 32 * sizeof(stack_node) == 256 bytes (for 64 bit: 1024 bytes).
      Pretty cheap, actually.
   2. Chose the pivot element using a median-of-three decision tree.
      This reduces the probability of selecting a bad pivot value and
      eliminates certain extraneous comparisons.
   3. Only quicksorts TOTAL_ELEMS / MAX_THRESH partitions, leaving
      insertion sort to order the MAX_THRESH items within each partition.
      This is a big win, since insertion sort is faster for small, mostly
      sorted array segments.
   4. The larger of the two sub-partitions is always pushed onto the
      stack first, with the algorithm then concentrating on the
      smaller partition.  This *guarantees* no more than log (total_elems)
      stack size is needed (actually O(1) in this case)!  */
typedef int (*__compar_fn_t) (const void *, const void *);
void quicksort(void *const pbase, size_t total_elems, size_t size, __compar_fn_t cmp)
{
  char *base_ptr = (char *) pbase;
  const size_t max_thresh = MAX_THRESH * size;
  if (total_elems == 0)
    /* Avoid lossage with unsigned arithmetic below.  */
    return;
  if (total_elems > MAX_THRESH)
    {
      char *lo = base_ptr;
      char *hi = &lo[size * (total_elems - 1)];
      stack_node stack[STACK_SIZE];
      stack_node *top = stack;
      PUSH (NULL, NULL);
      while (STACK_NOT_EMPTY)
        {
          char *left_ptr;
          char *right_ptr;
      /* Select median value from among LO, MID, and HI. Rearrange
         LO and HI so the three values are sorted. This lowers the
         probability of picking a pathological pivot value and
         skips a comparison for both the LEFT_PTR and RIGHT_PTR in
         the while loops. */
      char *mid = lo + size * ((hi - lo) / size >> 1);
      if ((*cmp) ((void *) mid, (void *) lo) < 0)
        SWAP (mid, lo, size);
      if ((*cmp) ((void *) hi, (void *) mid) < 0)
        SWAP (mid, hi, size);
      else
        goto jump_over;
      if ((*cmp) ((void *) mid, (void *) lo) < 0)
        SWAP (mid, lo, size);
    jump_over:;
      left_ptr  = lo + size;
      right_ptr = hi - size;
      /* Here's the famous ``collapse the walls'' section of quicksort.
         Gotta like those tight inner loops!  They are the main reason
         that this algorithm runs much faster than others. */
      do
        {
          while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
        left_ptr += size;
          while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
        right_ptr -= size;
          if (left_ptr < right_ptr)
        {
          SWAP (left_ptr, right_ptr, size);
          if (mid == left_ptr)
            mid = right_ptr;
          else if (mid == right_ptr)
            mid = left_ptr;
          left_ptr += size;
          right_ptr -= size;
        }
          else if (left_ptr == right_ptr)
        {
          left_ptr += size;
          right_ptr -= size;
          break;
        }
        }
      while (left_ptr <= right_ptr);
          /* Set up pointers for next iteration.  First determine whether
             left and right partitions are below the threshold size.  If so,
             ignore one or both.  Otherwise, push the larger partition's
             bounds on the stack and continue sorting the smaller one. */
          if ((size_t) (right_ptr - lo) <= max_thresh)
            {
              if ((size_t) (hi - left_ptr) <= max_thresh)
        /* Ignore both small partitions. */
                POP (lo, hi);
              else
        /* Ignore small left partition. */
                lo = left_ptr;
            }
          else if ((size_t) (hi - left_ptr) <= max_thresh)
        /* Ignore small right partition. */
            hi = right_ptr;
          else if ((right_ptr - lo) > (hi - left_ptr))
            {
          /* Push larger left partition indices. */
              PUSH (lo, right_ptr);
              lo = left_ptr;
            }
          else
            {
          /* Push larger right partition indices. */
              PUSH (left_ptr, hi);
              hi = right_ptr;
            }
        }
    }
  /* Once the BASE_PTR array is partially sorted by quicksort the rest
     is completely sorted using insertion sort, since this is efficient
     for partitions below MAX_THRESH size. BASE_PTR points to the beginning
     of the array to sort, and END_PTR points at the very last element in
     the array (*not* one beyond it!). */
#define min(x, y) ((x) < (y) ? (x) : (y))
  {
    char *const end_ptr = &base_ptr[size * (total_elems - 1)];
    char *tmp_ptr = base_ptr;
    char *thresh = min(end_ptr, base_ptr + max_thresh);
    char *run_ptr;
    /* Find smallest element in first threshold and place it at the
       array's beginning.  This is the smallest array element,
       and the operation speeds up insertion sort's inner loop. */
    for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
      if ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
        tmp_ptr = run_ptr;
    if (tmp_ptr != base_ptr)
      SWAP (tmp_ptr, base_ptr, size);
    /* Insertion sort, running from left-hand-side up to right-hand-side.  */
    run_ptr = base_ptr + size;
    while ((run_ptr += size) <= end_ptr)
      {
    tmp_ptr = run_ptr - size;
    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
      tmp_ptr -= size;
    tmp_ptr += size;
        if (tmp_ptr != run_ptr)
          {
            char *trav;
        trav = run_ptr + size;
        while (--trav >= run_ptr)
              {
                char c = *trav;
                char *hi, *lo;
                for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
                  *hi = *lo;
                *hi = c;
              }
          }
      }
  }
}
// -------------------------------------------------------------


int is_adjacent(freeblock* freeblock_list, int i, int j) {
    freeblock a = freeblock_list[i];
    freeblock b = freeblock_list[j];
    return (uintptr_t) a.addr + a.size == (uintptr_t) b.addr;
}

void connect(freeblock* ptrs_with_size, int i, int j) {
    node* node_a = (node*) ptrs_with_size[i].addr;
    node* node_b = (node*) ptrs_with_size[j].addr;
    node_a->size += node_b->size;
    remove_free_node(node_b);
}

// Comparison function for freeblocks in ascending order of address
int cmp_blocks_ascending(const void *a, const void *b){
    return (uintptr_t) (((freeblock *) a)->addr) - ((uintptr_t) ((freeblock *) b)->addr);
}

void defrag() {
    // Initialize freeblock_list
    freeblock freeblock_list[free_len];
    node* current_node = free_head;
    for (int i = 0; i < free_len; i++) {
        freeblock_list[i].addr = current_node;
        freeblock_list[i].size = current_node->size;
        current_node = current_node->next;
    }

    // Sort freeblock_list by address
    quicksort(freeblock_list, free_len, sizeof(freeblock_list[0]), &cmp_blocks_ascending);

    // Growing sliding window to defragment adjacent blocks
    int i = 0;
    int len = free_len;
    for (int j = 1; j < len; j++) {
        if (is_adjacent(freeblock_list, i, j)) {
            connect(freeblock_list, i, j);
        }
        else {
            i = j;
        }
    }
}

// Qsort comparison functions for heap_info
int cmp_size_array_descending(const void *a, const void *b) {
    return *((long *) b) - *((long *) a);
}

int cmp_ptr_array_descending(const void *a, const void *b) {
    header* header_a = (header*) ((uintptr_t) *((void **) a) - HEADER_SIZE);
    header* header_b = (header*) ((uintptr_t) *((void **) b) - HEADER_SIZE);
    return header_b->size - header_a->size;
}

int heap_info(heap_info_struct * info) {
    info->num_allocs = malloc_len;
    // Calculate free_space and largest_free_chunk
    int free_space = 0;
    int largest_free_chunk = 0;
    node* current_node = free_head;
    while (current_node != NULL) {
        int current_size = (int) current_node->size;
        if (current_size > largest_free_chunk) {
            largest_free_chunk = current_size;
        }
        free_space += current_size;
        current_node = current_node->next;
    }

    // Calculate size_array and ptr_array
    long* size_array;
    void** ptr_array;
    if (info->num_allocs == 0) {
        size_array = NULL;
        ptr_array = NULL;
    } 
    else {
        size_array = (long *) malloc(info->num_allocs * sizeof(long));
        if (size_array == NULL) {
            free(size_array);
            return -1;
        }
        ptr_array = (void **) malloc(info->num_allocs * sizeof(void*));
        if (ptr_array == NULL) {
            free(ptr_array);
            return -1;
        }

        header *current_header = malloc_head;
        for (int i = 0; i < info->num_allocs; i++) {
            size_array[i] = (long) current_header->size;
            ptr_array[i] = (void *) ((uintptr_t) current_header + HEADER_SIZE);
            current_header = current_header->next;
        }

        // Sort the two arrays
        quicksort(size_array, info->num_allocs, sizeof(size_array[0]), &cmp_size_array_descending);
        quicksort(ptr_array, info->num_allocs, sizeof(size_array[0]), &cmp_ptr_array_descending);
    }

    info->size_array = size_array;
    info->ptr_array = ptr_array;
    info->largest_free_chunk = largest_free_chunk;
    info->free_space = free_space;

    return 0;
}




