`timescale 1ns / 1ps

`define STRLEN 15
module SignExtender_tb;


   initial
     begin
      $dumpfile("SignExtender_tb.vcd");
      $dumpvars(0,SignExtender_tb);
     end
     
	task passTest;
		input [63:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [6:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %h should be %h", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [6:0] passed;
		input [6:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask
	
	task stim;
		input [25:0] newIn;
		input [1:0] newSel;
		output [25:0] setIn;
		output [1:0]  setSel;
		
		begin
			#90;
			setIn = newIn;
			setSel = newSel;
		end
	endtask
	
	// Inputs
	reg [25:0] Imm26;
	reg [1:0] Ctrl;
	reg [6:0] passed;

	// Outputs
	wire [63:0] BusImm;

	// Instantiate the Unit Under Test (UUT)
	SignExtender uut (
		.Imm26(Imm26),
		.Ctrl(Ctrl), 
		.BusImm(BusImm)
	);

	initial begin
		// Initialize Inputs
		Imm26 = 0;
		Ctrl = 0;
		passed = 0;

		// Add stimulus here
		
		
		stim(26'b0, 2'b00, Imm26, Ctrl); #90; passTest(BusImm, 64'b0, "ALU immediate: ", passed);
		stim({{1'b1}, {25'b0}}, 2'b00, Imm26, Ctrl); #90; passTest(BusImm, 64'b0, "ALU immediate msb =1: ", passed);
		stim(21'b0, 2'b01, Imm26, Ctrl); #90; passTest(BusImm, 64'b0, "DT addr msb=0:", passed);
		stim({21{1'b1}}, 2'b01, Imm26, Ctrl); #90; passTest(BusImm, {64{1'b1}}, "DT addr msb=1:", passed);
		stim(26'b0, 2'b10, Imm26, Ctrl); #90; passTest(BusImm, 64'b0, "B addr msb=0:", passed);
		stim({{1'b1}, {25'b0}}, 2'b10, Imm26, Ctrl); #90; passTest(BusImm, {{37{1'b1}}, 27'b0}, "B addr msb=1:", passed);
		stim(26'b0, 2'b11, Imm26, Ctrl); #90 passTest(BusImm, 64'b0, "Cond B addr msb=0:", passed);
		stim({{1'b1},{23'b0}}, 2'b11, Imm26, Ctrl); #90 passTest(BusImm, {{44{1'b1}}, 20'b0}, "Cond B addr msb=1:", passed);		
		#90;
		
		//stim(26'b0, 2'b00, Imm26, Ctrl); #90; passTest(BusImm, 64'b0, "ALU immediate: ", passed);
		//stim(21'b0, 2'b01, Imm26, Ctrl); #90; passTest(BusImm, 64'b0, "DT addr msb=0:", passed);
		//stim({{1'b1}, {20'b0}}, 2'b01, Imm26, Ctrl); #90; passTest(BusImm, {{55'b1}, Imm26[20:12]}, "DT addr msb=1:", passed);
		//stim(26'b0, 2'b10, Imm26, Ctrl); #90; passTest(BusImm, 64'b0, "B addr msb=0:", passed);
		//stim({{1'b1}, {25'b0}}, 2'b10, Imm26, Ctrl); #90; passTest(BusImm, {{36'b1}, {25'b1}, {1'b0},{2'b1}}, "B addr msb=1:", passed);
		//stim(26'b0, 2'b11, Imm26, Ctrl); #90 passTest(BusImm, 64'b0, "Cond B addr msb=0:", passed);
		//stim({{1'b1},{25'b0}}, 2'b11, Imm26, Ctrl); #90 passTest(BusImm, {{43'b1}, Imm26[23:5], {2'b0}}, "Cond B addr msb=1:", passed);		
		//#90;
		
		
		allPassed(passed, 7);

	end
      
endmodule
