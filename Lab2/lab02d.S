.section .text
.globl lab02d

lab02d:
	ADD X3, X0, #1000 // adding 1000 to the input
	ADR X5, myvalue // Getting memory address of myvalue
	STUR X3, [X5,0] // Storing result into memory address of myvalue
	ADR X0, myvalue
	BR X30
	




.section .data

myvalue:
.quad 2
	
