COMPILER=arm-none-eabi-gcc
COMPILER_FLAGS= -mcpu=cortex-m3 -std=gnu11 -c -I Include -O0 -ffunction-sections -fdata-sections -Wall  --specs=nano.specs -mfloat-abi=soft -mthumb
COMPILER_FLAGS_STARTUP=-mcpu=cortex-m3 -c -x assembler-with-cpp -specs=nano.specs -mfloat-abi=soft -mthumb
LINKER_FLAGS = -mcpu=cortex-m3 -T STM32F103CBTX_FLASH.ld --specs=nosys.specs -Wl,--gc-sections -static --specs=nano.specs -mfloat-abi=soft -mthumb

all: main.o RCC_program.o GPIO_program.o SYSTICK_program.o startup_stm32f103cbtx.o myFirmware.elf
main.o: main.c
	$(COMPILER) $(COMPILER_FLAGS) -o $@ $^ 
	@echo 'Finished building target: $@'
	@echo ' '

RCC_program.o: RCC_program.c
	$(COMPILER) $(COMPILER_FLAGS) -o $@ $^
	@echo 'Finished building target: $@'
	@echo ' '

GPIO_program.o: GPIO_program.c
	$(COMPILER) $(COMPILER_FLAGS) -o $@ $^
	@echo 'Finished building target: $@'
	@echo ' '

SYSTICK_program.o: SYSTICK_program.c
	$(COMPILER) $(COMPILER_FLAGS) -o $@ $^
	@echo 'Finished building target: $@'
	@echo ' '

startup_stm32f103cbtx.o: startup_stm32f103cbtx.s
	$(COMPILER) $(COMPILER_FLAGS_STARTUP) -o $@ $^
	@echo 'Finished building target: $@'
	@echo ' '

myFirmware.elf: main.o RCC_program.o GPIO_program.o SYSTICK_program.o startup_stm32f103cbtx.o
	$(COMPILER) $(LINKER_FLAGS) -o $@ $^
	@echo 'Finished building target: $@'
	@echo ' '
	arm-none-eabi-size $@
	arm-none-eabi-objcopy  -O ihex $@  "myFirmware.hex"
clean:
	rm -rf *.o *.elf 