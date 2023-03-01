
.section .text
.globl test2

test2:
	sub	X1, X0, X1
	ADRP X0, msg1
    ADD X0,X0, :lo12:msg1
    //decrease the stack pointer
    
    //store the x30 reg onto the stack
    SUB sp, sp, #16
    STUR X30, [sp, #0]
    BL printf
    //load x30 fron the stack
    LDUR X30, [sp, #0]
    //increase the stack pointer
    ADD sp, sp, #16
    BR X30
	
.section .data
	msg1: .asciz "Result of test2(6, 5) = %lld\n"
