#include "mem.h"

void memory_copy(uint8_t *source, uint8_t *dest, int nbytes) {
    int i;
    for (i = 0; i < nbytes; i++) {
        *(dest + i) = *(source + i);
    }
}

void memory_set(uint8_t *dest, uint8_t val, uint32_t len) {
    uint8_t *temp = (uint8_t *)dest;
    for ( ; len != 0; len--) *temp++ = val;
}

/* This should be computed at link time, but a hardcoded
 * value is fine for now. Remember that our kernel starts
 * at 0x1000 as defined on the Makefile */
uint32_t free_mem_addr = 0x10000;
/* Implementation is just a pointer to some free memory which
 * keeps growing */
uint32_t kmalloc(size_t size, int align, uint32_t *phys_addr) {
    /* Pages are aligned to 4K, or 0x1000 */
    
    // size kan vara mer än 4Kb det kommer ändå maskas

    if (align == 1 && (free_mem_addr & 0xFFFFF000)) {
        free_mem_addr &= 0xFFFFF000;//maskar bort skräp från förra custom size
                                    //som ändå va mindre än 4kb
        free_mem_addr += 0x1000; // lägger till ny 4kb
                                // två allokeringar måste ligga
                                // i två olika pages
    }
    /* Save also the physical address */
    if (phys_addr) *phys_addr = free_mem_addr;

    uint32_t ret = free_mem_addr; // ret är nu starten på fria minnet
    free_mem_addr += size; // sätter pekaren till sizen som används, slutet av 
                           // förgående allokering

    // när du skriver till pekaren som du retunerar så
    // får den inte skriva till nåt > free_mem_addr
    return ret;
}
