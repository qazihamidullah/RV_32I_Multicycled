#include "uart.h"
#include <stdint.h>

/**
* Local variables... \n Base address of UART Pheripheral
*/
volatile uint64_t *m_uart;


/**
* uart_putc: Polled putchar \n
* Input c \n
* Output int \n
* This fucntion will send charater c through uart \n
* return 0 on successful execution of fucntion \n
*/
int uart_putc(char c)
{
    // While TX FIFO full

   //m_uart[U_TX] = c;
    volatile uint32_t	*sim_uart	= 	(volatile uint32_t*)0x800000;
    *sim_uart = c;
    return 0;
}


/**
* uart_print_string: \n
* Input pointer to array.\n
* Will send the string (array of char) through uart\n
*/ 
void uart_puts(char *data)
{
	int x = 0;
	while (data[x] != 0)
		{
			uart_putc(data[x]);
			x++;
		}
}
 