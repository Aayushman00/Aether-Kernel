# Paths
BUILD_DIR = build
ISO_DIR = $(BUILD_DIR)/iso
KERNEL_SRC = kernel/kernel.c
KERNEL_BIN = $(BUILD_DIR)/kernel.bin
TARGET = i686-elf

# Compiler
CC = $(TARGET)-gcc
LD = $(TARGET)-ld

# Flags
CFLAGS = -ffreestanding -O2 -Wall -Wextra
LDFLAGS = -T linker.ld

# Targets
all: iso

$(KERNEL_BIN): $(KERNEL_SRC)
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $(BUILD_DIR)/kernel.o
	$(LD) $(LDFLAGS) $(BUILD_DIR)/kernel.o -o $@

iso: $(KERNEL_BIN)
	mkdir -p $(ISO_DIR)/boot/grub
	cp $(KERNEL_BIN) $(ISO_DIR)/boot/kernel.bin
	cp boot/grub/grub.cfg $(ISO_DIR)/boot/grub/grub.cfg
	grub-mkrescue -o $(BUILD_DIR)/myos.iso $(ISO_DIR)

run: iso
	qemu-system-i386 -cdrom $(BUILD_DIR)/myos.iso

clean:
	rm -rf $(BUILD_DIR)
