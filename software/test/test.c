#include "uart.h"


int main (void)
{
     __asm(".option push\n"
    ".option norelax\n"
	  "la gp, __global_pointer$\n"
	  ".option pop");
	  __asm("la sp, __stack_top");
	  __asm("add s0, sp, zero");
    
    uart_puts("Hello World!!!\n");

  return 0;
}

// $(COMMON_DIR)/init.c \