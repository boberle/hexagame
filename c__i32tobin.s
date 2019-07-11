/***********************************************************************
              c__ - c__i32tobin - v1.0.0 2010-03-04
  Prototypes:
	char *c__i32tobin(int n, char *buf)

	Input values:
		* n: Number to convert.
		* buf: 33-bytes length memory location. Bytes can be everything.
	
	Output values:
		* return value: = buf. buf is a 32-bytes null-terminated string
		  that contains 32 zeros or ones.
	
	Registers:
		* EAX: Holds n.
		* EBX: Unused.
		* ECX: Counter for buffer.
		* EDX: Buffer start address.
***********************************************************************/

.section .text

.equ A_N, 8
.equ A_BUF, 12

.globl c__i32tobin
.type c__i32tobin, @function

c__i32tobin:
		pushl %ebp
		movl %esp, %ebp
		movl A_N(%ebp), %eax				# init
		movl A_BUF(%ebp), %edx
		movl %edx, %ecx
		addl $32, %ecx
		movl $0x00, (%ecx)
		decl %ecx
_l0:
		testl $0x01, %eax
		jz _j0
		movb $'1', (%ecx)
		jmp _j1
_j0:
		movb $'0', (%ecx)
_j1:
		decl %ecx
		sarl %eax
		cmp %edx, %ecx
		jae _l0
		movl %edx, %eax							# end
		movl %ebp, %esp
		popl %ebp
		ret

.section .bss
	.lcomm buf, 33

.section .text

.globl _start
_start:
	nop
	pushl $buf
	pushl $0x12345678
	call c__i32tobin
	movl $4, %eax
	movl $1, %ebx
	movl $buf, %ecx
	movl $33, %edx
	int $0x80
	movl $1, %eax
	movl $0, %ebx
	int $0x80

