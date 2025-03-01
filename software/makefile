CC = /opt/riscv64/bin/riscv64-unknown-elf-gcc
ELFSIZE = /opt/riscv64/bin/riscv64-unknown-elf-size
OBJCOPY = /opt/riscv64/bin/riscv64-unknown-elf-objcopy

COMMON_DIR = common
TEST = test
COREMARK_DIR = coremark

UART_SW 	= ../design/uncore/uart/sw


CFLAGS =	-I$(TEST) \
			-I$(UART_SW) \
			-I$(COMMON_DIR) \
		-O3 -ffunction-sections -fdata-sections -mabi=ilp32 -march=rv32i
		
LDFLAGS =	-T $(COMMON_DIR)/link.ld \
		--specs=nosys.specs \
		-nostartfiles

SRCS_COMMON =		$(UART_SW)/uart.c 
				 



baremetal_compile:
	$(CC) -o main.elf $(TEST)/test.c $(SRCS_COMMON) $(CFLAGS) $(LDFLAGS)




generate_hex:
		$(ELFSIZE) main.elf
		$(OBJCOPY) -O binary --gap-fill 0 main.elf sys_onchip_memory2_0.bin
		$(COMMON_DIR)/bin2hex_2 sys_onchip_memory2_0.bin mem.hex
		$(COMMON_DIR)/hex_text sys_onchip_memory2_0.bin mem.text
		sed -i 's/0x//' mem.text
		cp mem.text ../sim/mem.txt 
		cp mem.hex ../sim/mem.hex 
		
	
		
.PHONY: baremetal
baremetal: clean baremetal_compile generate_hex


.PHONY: clean
clean:
	rm -f *.elf *.bin *.hex *.text
