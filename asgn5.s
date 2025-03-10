	.file	"asgn5.c" # This shows the original scouce file 
	.text # this begins the text code section 
	.globl	myAddTwoNumbersFunction /* This declares the myAddTwoNumbersFunction as a global symbol so it an be referenced from other files*/
	.type	myAddTwoNumbersFunction, @function /*This specify that myAddTwoNumbersFunction is a function*/
myAddTwoNumbersFunction:
	pushq	%rbp /*This will save the base pointer of the caller onto the stack*/
	movq	%rsp, %rbp /*This will set the current stack pointer as the new base pointer*/
	movl	%edi, -4(%rbp) /*This will store the first argument into a local variable at offset -4 from %rbp*/
	movl	%esi, -8(%rbp) /*This will store the second argument into a local variable at offset -8 from %rbp*/
	movl	-4(%rbp), %edx # /*This will laod the first argument from the local variable into %edx*/
	movl	-8(%rbp), %eax /*This will load the second argument from the local variable into %eax*/
	addl	%edx, %eax /*This will add the value in %edx */
	popq	%rbp /*This will reset the caller's base pointer*/
	ret /*this will return from the funciton with the sum of %eax */

	.section	.rodata # This will begin the read only data section for the constants 
.LC0: .string	"The answer is %d\n" # This will define a constant string used for printing the answer

	.text # This will return to the text seciton 
	.globl	main # This will declare the main as a golbal symbol so the linker can find it as the program entry point
	.type	main, @function # This will specify that main is a function 
main:
	pushq	%rbp  # this will save the caller's base pointer 
	movq	%rsp, %rbp # This will set the current stack pointer as teh new base pointer for main 
	subq	$16, %rsp # this will allocate 16 bytes on the stack for local variables 
	movl	$10, -12(%rbp) # This will initialize local variable at offset -12 with constant 10 
	movl	$7, -8(%rbp) # This will initialzie the local variable at offset -8 with constant 7
	movl	$0, -4(%rbp) # This will initialize the local variable at offset -4 to 0 
	movl	-8(%rbp), %edx # this will load the second number 7 from local variable into %edx for function argument preparation
	movl	-12(%rbp), %eax # this will load the first number 10 from the local variable into %eax for function argument preparation
	movl	%edx, %esi # This will move the second number into %esi 
	movl	%eax, %edi # This will move the first number into %edi
	call	myAddTwoNumbersFunction # This will call the function myAddTwoNumbersFunction to add the two numbers
	movl	%eax, -4(%rbp) # The will store the result into local variable at offset -4
	movl	-4(%rbp), %eax #This will load the computed result from the local variable into %eax
	movl	%eax, %esi # # this will move the result into #esi to be used as argument for printf 
	leaq	.LC0(%rip), %rdi # this will load the address of the format string into %rdi
	movl	$0, %eax # this will set %eax to 0 as required by the calling convention for variadic functions 
	call	printf@PLT # will call the printf function to output the formatted string 
	movl	$0, %eax # this will set return value 0 in %eax for main
	leave # this will clean up the stack frame
	ret # this will return from main ending the program 

