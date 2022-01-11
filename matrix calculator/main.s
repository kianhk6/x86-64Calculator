	.file	"main.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%4d %4d %4d %4d"
	.text
	.p2align 4,,15
	.globl	printMatrixByRow
	.type	printMatrixByRow, @function
printMatrixByRow:
.LFB24:
	.cfi_startproc
	testl	%esi, %esi
	jle	.L6
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	leaq	.LC0(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movslq	%esi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%r13, %r12
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	xorl	%ebp, %ebp
	movq	%rdi, %rbx
	.p2align 4,,10
	.p2align 3
.L3:
	movsbl	1(%rbx), %ecx
	movsbl	(%rbx), %edx
	movq	%r14, %rsi
	movsbl	3(%rbx), %r9d
	movsbl	2(%rbx), %r8d
	movl	$1, %edi
	xorl	%eax, %eax
	addl	$1, %ebp
	addq	%r13, %rbx
	call	__printf_chk@PLT
	movl	$10, %edi
	call	putchar@PLT
	cmpl	%ebp, %r12d
	jne	.L3
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_restore 13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_restore 14
	.cfi_def_cfa_offset 8
	movl	$10, %edi
	jmp	putchar@PLT
	.p2align 4,,10
	.p2align 3
.L6:
	movl	$10, %edi
	jmp	putchar@PLT
	.cfi_endproc
.LFE24:
	.size	printMatrixByRow, .-printMatrixByRow
	.section	.rodata.str1.1
.LC1:
	.string	"Copy: "
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC2:
	.string	"Rotating the matrix by 90 degrees clockwise: "
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	leaq	.LC1(%rip), %rdi
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	puts@PLT
	leaq	C(%rip), %rsi
	leaq	A(%rip), %rdi
	movl	$4, %edx
	call	copy@PLT
	leaq	A(%rip), %rdi
	movl	$4, %esi
	call	printMatrixByRow
	leaq	C(%rip), %rdi
	movl	$4, %esi
	call	printMatrixByRow
	leaq	.LC2(%rip), %rdi
	call	puts@PLT
	leaq	C(%rip), %rdi
	movl	$4, %esi
	xorl	%eax, %eax
	call	transpose@PLT
	leaq	C(%rip), %rdi
	movl	$4, %esi
	xorl	%eax, %eax
	call	reverseColumns@PLT
	leaq	C(%rip), %rdi
	movl	$4, %esi
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	jmp	printMatrixByRow
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.comm	C,16,16
	.globl	A
	.data
	.align 16
	.type	A, @object
	.size	A, 16
A:
	.byte	1
	.byte	-2
	.byte	3
	.byte	-4
	.byte	-5
	.byte	6
	.byte	-7
	.byte	8
	.byte	-1
	.byte	2
	.byte	-3
	.byte	4
	.byte	5
	.byte	-6
	.byte	7
	.byte	-8
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
