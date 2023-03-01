`timescale 1ns / 1ps

`define STRLEN 15
module NextPCLogicTest;

   initial
     begin
      $dumpfile("NextPCLogicTest.vcd");
      $dumpvars(0,NextPCLogicTest);
     end
     	
	task passTest;
		input [64:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	
	reg [63:0] CurrentPC;
	reg [63:0] SignExtImm64;
	reg Branch;
	reg ALUZero;
	reg Uncondbranch;
	reg [7:0] passed;

	// Outputs
	wire [63:0] NextPC;

	// Instantiate the Unit Under Test (UUT)
	NextPClogic uut (
		.CurrentPC(CurrentPC), 
		.SignExtImm64(SignExtImm64), 
		.Branch(Branch), 
		.Uncondbranch(Uncondbranch), 
		.ALUZero(ALUZero),
		.NextPC(NextPC)
	);

	initial begin
		// Initialize Inputs
	CurrentPC=0;
	SignExtImm64=0;
	Branch=0;
	ALUZero=0;
	Uncondbranch=0;
	passed=0;

                // Here is one example test vector, testing the ADD instruction:
         
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1, 64'hABCD0000, 1'b0, 1'b0, 1'b0}; #40; passTest(NextPC, 64'h5, " test Uncond =F and B = F", passed); //normal and no zero pos
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1, 64'hABCD0000, 1'b0, 1'b1, 1'b0}; #40; passTest(NextPC, 64'h5, " test Uncond =F and B = F", passed); //normal and zero pos
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1, -64'hABCD0000, 1'b0, 1'b0, 1'b0}; #40; passTest(NextPC, 64'h5, " test Uncond =F and B = F", passed); //normal and no zero neg
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1, -64'hABCD0000, 1'b0, 1'b1, 1'b0}; #40; passTest(NextPC, 64'h5, " test Uncond =F and B = F", passed); //normal and zero neg
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1, 64'hABCD0000, 1'b1, 1'b0, 1'b0}; #40; passTest(NextPC, 64'h5, " test Uncond =F and B = F", passed); //cond and no zero pos
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1, 64'h1, 1'b1, 1'b1, 1'b0}; #40; passTest(NextPC, 64'h5, " test Uncond =F and B = F", passed); //cond and zero pos
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1, {{62'b1},{2'b00}}, 1'b1, 1'b0, 1'b0}; #40; passTest(NextPC, 64'h5, " test #2 Uncond =T and B = F", passed); //cond and no zero neg
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h9, -64'h1, 1'b1, 1'b1, 1'b0}; #40; passTest(NextPC, 64'h5, " test #2 Uncond =T and B = F", passed); //cond and zero neg

		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1, 64'h1, 1'b0, 1'b0, 1'b1}; #40; passTest(NextPC, 64'h5, " test Uncond =F and B = F", passed); //unncond and no zero pos
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1, 64'h1, 1'b0, 1'b0, 1'b1}; #40; passTest(NextPC, 64'h5, " test Uncond =F and B = F", passed); //uncond and zero pos
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h9, -64'h1, 1'b0, 1'b0, 1'b1}; #40; passTest(NextPC, 64'h5, " test Uncond =F and B = F", passed); //uncond and no zero neg
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h9, -64'h1, 1'b0, 1'b0, 1'b1}; #40; passTest(NextPC, 64'h5, " test Uncond =F and B = F", passed); //uncond and zero neg
		
		/*
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1, 64'h1111, 1'b0, 1'b1, 1'b0}; #40; passTest(NextPC, 64'h5, " test #1 Uncond =T and B = F", passed);
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1, 64'h0004, 1'b0, 1'b1, 1'b1}; #40; passTest(NextPC, 64'h0005, " test #2 Uncond =T and B = F", passed);
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1, , 1'b1, 1'b0, 1'b0}; #40; passTest(NextPC, 64'h0005, " test #2 Uncond =T and B = F", passed);
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h9, {{62'b1},{2'b00}}, 1'b1, 1'b1, 1'b0}; #40; passTest(NextPC, 64'h0005, " test #2 Uncond =T and B = F", passed);
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1, 64'h1111, 1'b1, 1'b1, 1'b0}; #40; passTest(NextPC, 64'h1111, " test ALU = T", passed);
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1, 64'h1111, 1'b1, 1'b0, 1'b0}; #40; passTest(NextPC, 64'h2, " test ALU = F", passed);
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h3, 64'h1111, 1'b1, 1'b0, 1'b0}; #40; passTest(NextPC, 64'h4, " test ALU = F", passed);
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h3, 64'h1111, 1'b1, 1'b1, 1'b0}; #40; passTest(NextPC, 64'h1111, " test ALU = T", passed);
		*/
		

		//Reformate and add your test vectors from the prelab here following the example of the testvector above.	


		allPassed(passed, 12);
	end
      
endmodule
