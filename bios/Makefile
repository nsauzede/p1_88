TARGET=bios

Q=qemu-system-i386

all:$(TARGET)

check: out.txt
	@cat out.txt

out.txt: bios
	$(Q) -display none -bios bios -S -s &
	-gdb -nx -q --command script.py > /dev/null 2>&1

%: %.asm
	nasm $^ -o $@
	ndisasm bios | tail -n 16

clean:
	$(RM) bios

clobber: clean
	$(RM) out.txt
