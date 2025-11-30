PROGS := ls echo shutdown hello clear help

PRG := $(patsubst %,obj/%,$(PROGS))
COR := obj/boot obj/os obj/syscall
O := $(COR) $(PRG)
F := obj obj/cpy $(O) os.img

all: $(F)

obj/boot: src/boot.s
obj/os: src/os.s
obj/syscall: src/syscall.s

obj/cpy: src/cpy.c
	@echo "[C] $(shell basename $@)"
	@clang src/cpy.c -o obj/cpy

obj/%: src/%.s
	@echo "[S] $(shell basename $@)"
	@nasm -f bin -I src $< -o $@

os.img: $(O)
	@echo "[DD] $@"
	@dd if=/dev/zero of=os.img bs=512 count=2880 >/dev/null 2>&1
	@echo "[CPY] $@"
	@cd obj && ./cpy ../$@ $(patsubst obj/%,%,$^) 1>/dev/null

obj:
	@echo "[MKDIR] $@"
	@mkdir -p obj

clean:
	@echo "[RM] $(F)"
	@rm -rf $(F) filetable

run: obj os.img
	@echo "[QEMU] $<"
	@qemu-system-i386 -M pc -m 16M $<

.PHONY: all clean run
