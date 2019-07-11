/***********************************************************************
                c__ - c__i32tox - v1.0.0 2010-03-04
  Prototypes:
	char *c__i32tox(int n, char *buf)

	Input values:
		* n: 32-bits integer to convert.
		* buf: 9-bytes length memory location (no special value needed).
	
	Output values:
		* return value: = buf. When returning, buf is a 9-bytes null-
		  terminated string. The first eight bytes are [0123456789ABCDEF].
	
	Registers:
		* EAX: Operation on n.
		* EBX: Holds n.
		* ECX: Current character of buffer.
		* EDX: Buffer start address.
***********************************************************************/

.equ A_N, 8
.equ A_BUF, 12

.globl c__i32tox
.type c__i32tox, @function

c__i32tox:
		pushl %ebp
		movl %esp, %ebp
		pushl %ebx
		movl A_N(%ebp), %ebx
		movl A_BUF(%ebp), %edx
		movl %edx, %ecx
		addl $8, %ecx
		movb $0x00, (%ecx)
		decl %ecx
_l0:
		movl %ebx, %eax
		andl $0x0F, %eax
		cmpw $9, %ax
		ja _j0
		addw $48, %ax
		jmp _j1
_j0:
		addw $55, %ax
_j1:
		movb %al, (%ecx)
		decl %ecx
		sar $4, %ebx
		cmpl %edx, %ecx
		jl _end
		jmp _l0
_end:
		movl %edx, %eax
		popl %ebx
		movl %ebp, %esp
		popl %ebp
		ret




.section .bss
	.lcomm buf, 9

.section .text

.globl _starttest
_starttest:
		nop
		pushl $buf
		pushl $0xabcd12ef
		call c__i32tox
		movl %eax, %ecx
		movl $4, %eax
		movl $1, %ebx
		movl $9, %edx
		int $0x80
		movl $1, %eax
		movl $0, %ebx
		int $0x80
