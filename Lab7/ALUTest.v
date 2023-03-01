`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:02:47 03/05/2009
// Design Name:   ALU
// Module Name:   E:/350/Lab8/ALU/ALUTest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 32
module ALUTest_v;

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
	reg [63:0] BusA;
	reg [63:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusW;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;

                // Here is one example test vector, testing the ADD instruction:
         //ADD
		{BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h2}; #40; passTest({Zero, BusW}, 65'h0ABCD1234, "ADD 0x1234,0xABCD0000", passed);
		{BusA, BusB, ALUCtrl} = {64'h25dd2, 64'h900f0, 4'h2}; #40; passTest({Zero, BusW}, 65'hb5ec2, "ADD1, 25dd2, 900f0, ", passed);
		{BusA, BusB, ALUCtrl} = {64'h11111111, 64'hAAAAAAAA, 4'h2}; #40; passTest({Zero, BusW}, 65'hBBBBBBBB, "ADD, A*8,1*8, ", passed);
		//SUB
		{BusA, BusB, ALUCtrl} = {64'h11111111, 64'h11111111, 4'h6}; #40; passTest({Zero, BusW}, {{1'b1}, 64'h00000000}, "SUB, 1*8,1*8, ", passed);
		{BusA, BusB, ALUCtrl} = {64'hABCDABCD, 64'hA0C0A0C0, 4'h6}; #40; passTest({Zero, BusW}, 65'h0B0D0B0D, "SUB, ABC,A0C0, ", passed);
		{BusA, BusB, ALUCtrl} = {64'hAAAAAAAA, 64'h99999999, 4'h6}; #40; passTest({Zero, BusW}, 65'h11111111, "SUB, A*8,9*8, ", passed);
		//AND
		{BusA, BusB, ALUCtrl} = {64'h11111111, 64'h22222222, 4'h0}; #40; passTest({Zero, BusW}, {{1'b1}, 64'h00000000}, "AND, 1*8,2*8, ", passed);
		{BusA, BusB, ALUCtrl} = {64'h11111111, 64'h11111111, 4'h0}; #40; passTest({Zero, BusW}, 65'h11111111, "AND, 1*8,1*8, ", passed);
		{BusA, BusB, ALUCtrl} = {64'hFFFFFFFF, 64'h11111111, 4'h0}; #40; passTest({Zero, BusW}, 65'h11111111, "AND, F*8,1*8, ", passed);
		//OR
		{BusA, BusB, ALUCtrl} = {64'h00000000, 64'h00000000, 4'h1}; #40; passTest({Zero, BusW}, {{1'b1}, 64'h00000000}, "OR, A*8,9*8, ", passed);
		{BusA, BusB, ALUCtrl} = {64'h11111111, 64'h00000000, 4'h1}; #40; passTest({Zero, BusW}, 65'h11111111, "OR, 1*8,0*8, ", passed);
		{BusA, BusB, ALUCtrl} = {64'hFFFFFFFF, 64'h12345678, 4'h1}; #40; passTest({Zero, BusW}, 65'hFFFFFFFF, "OR, F*8,1-8, ", passed);
		//PassB
		{BusA, BusB, ALUCtrl} = {64'h00000000, 64'h11111111, 4'h7}; #40; passTest({Zero, BusW}, 65'h11111111, "PassB, 0*8,1*8, ", passed);
		{BusA, BusB, ALUCtrl} = {64'hFFFFFFFF, 64'h00000000, 4'h7}; #40; passTest({Zero, BusW}, {{1'b1}, 64'h00000000}, "PassB, F*8,0*8, ", passed);
		{BusA, BusB, ALUCtrl} = {64'h22222222, 64'h11111111, 4'h7}; #40; passTest({Zero, BusW}, 65'h11111111, "PassB, 2*8,1*8, ", passed);


		//Reformate and add your test vectors from the prelab here following the example of the testvector above.	


		allPassed(passed, 15);
	end
      
endmodule

