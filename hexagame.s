/***********************************************************************
             hexagame v1.0.0 - by Bruno Oberle - 2010-03-04

  This is a game: The user must enter a hexadecimal digit according
	to a four-digits binary pattern, or enter a four-digits binary
	pattern according to a hexadecimal digit.
	Give no answer to quit.
***********************************************************************/


/************************ data section ********************************/

.section .data
	correct_answer: .asciz "You're ok.\n"
	wrong_answer: .asciz "You're wrong. Try again: "
	asking_hexa: .asciz "What is the hexa code for [xxxx]? "
	asking_bin: .asciz "What is the binary pattern for [x]? "
	end_of_strings:
	.equ LEN_CORRECT_ANSWER, wrong_answer-correct_answer
	.equ LEN_WRONG_ANSWER, asking_hexa-wrong_answer
	.equ LEN_ASKING_HEXA, asking_bin-asking_hexa
	.equ LEN_ASKING_BIN, end_of_strings-asking_bin


/*********************** bss section **********************************/

.section .bss
	.lcomm hexa_buf, 9
	.lcomm bin_buf, 33
	.lcomm user_buf, 5


/************************ text section ********************************/

.section .text

.globl _startok


/*
  function main
*/

_startok:
		nop

_l0:
		call ___get_time				# RANDOM NUMBER ############################
		andl $0x0F, %eax
		movl %eax, %ebx					# prepare to call c__i32tox
		pushl $hexa_buf
		pushl %ebx
		call c__i32tox
		addl $8, %esp
		pushl $bin_buf					# prepare to call c__i32tobin
		pushl %ebx
		call c__i32tobin
		addl $8, %esp
		movl %ebx, %ecx					# prepare to call ___get_time
		call ___get_time
		movl %ecx, %ebx
		testl $0x01, %eax				# if EAX:0 is set, ask binary, else hexa
		jz _ask_bin

		movl $0, %esi						# ASKING HEXA ##############################
		movl $bin_buf, %ecx			# change string for displaying
		addl $28, %ecx
		movl (%ecx), %edx
		movl $asking_hexa, %ecx
		addl $27, %ecx
		movl %edx, (%ecx)
		movl $4, %eax						# write sys call
		movl $1, %ebx
		movl $asking_hexa, %ecx
		movl $LEN_ASKING_HEXA, %edx
		int $0x80
_l1:
		movl $3, %eax						# read sys call
		movl $0, %ebx
		movl $user_buf, %ecx
		movl $5, %edx
		int $0x80
		cmpb $'\n', user_buf 		# quit if no answer
		jz _end
		movl $hexa_buf, %eax		# get the solution
		addl $7, %eax
		movb (%eax), %al
		andl $0xFF, %eax
		movb user_buf, %bl			# get the user answer
		andl $0xFF, %ebx
		cmpl %eax, %ebx					# compare
		jz _j_correct_answer
		jmp _j_wrong_answer

_ask_bin:										# ASKING BINARY ############################ 
		movl $1, %esi
		movl $hexa_buf, %ecx		# change string for displaying
		addl $7, %ecx
		movb (%ecx), %dl
		andl $0xFF, %edx
		movl $asking_bin, %ecx
		addl $32, %ecx
		movb %dl, (%ecx)
		movl $4, %eax						# write sys call
		movl $1, %ebx
		movl $asking_bin, %ecx
		movl $LEN_ASKING_BIN, %edx
		int $0x80
_l2:
		movl $3, %eax						# read sys call
		movl $0, %ebx
		movl $user_buf, %ecx
		movl $5, %edx
		int $0x80
		cmpb $'\n', user_buf 		# quit if no answer
		jz _end
		movl $bin_buf, %eax			# get the solution
		addl $28, %eax
		movl (%eax), %eax
		movl user_buf, %ebx			# get the user answer
		cmpl %eax, %ebx					# compare
		jz _j_correct_answer
		jmp _j_wrong_answer

_j_correct_answer:					# DISPLAYING RESULT ########################
		movl $4, %eax						# display msg
		movl $1, %ebx
		movl $correct_answer, %ecx
		movl $LEN_CORRECT_ANSWER, %edx
		int $0x80
		jmp _l0
_j_wrong_answer:
		movl $4, %eax						# display msg
		movl $1, %ebx
		movl $wrong_answer, %ecx
		movl $LEN_WRONG_ANSWER, %edx
		int $0x80
		cmpl $0, %esi
		jz _l1
		jmp _l2

_end:												# END ######################################
	movl $1, %eax
	movl $0x00, %ebx
	int $0x80


/*
  ___get_time function

	Used reg: eax, ebx.
	Return value in eax.
*/

___get_time:
		movl $13, %eax
		xorl %ebx, %ebx
		int $0x80
		ret
	
/* vim: set tabstop=2 shiftwidth=2 noexpandtab: */
