/*
module ALU(BusW, BusA, BusB, ALUCtrl, Zero);
module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
module SignExtender(BusImm, Imm26, Ctrl); 
module RegisterFile(BusA, BusB, BusW, RW, RA, RB, RegWr, Clk);
module InstructionMemory(Data, Address);
*/

`timescale 1ns / 1ps
module singlecycle(
		   input 	     resetl,
		   input [63:0]      startpc,
		   output reg [63:0] currentpc,
		   output [63:0]     MemtoRegOut,  // this should be
						   // attached to the
						   // output of the
						   // MemtoReg Mux
		   input 	     CLK
		   );

   // Next PC connections
   wire [63:0] 			     nextpc;       // The next PC, to be updated on clock cycle

   // Instruction Memory connections
   wire [31:0] 			     instruction;  // The current instruction

   // Parts of instruction
   wire [4:0] 			     rd;            // The destination register
   wire [4:0] 			     rm;            // Operand 1
   wire [4:0] 			     rn;            // Operand 2
   wire [10:0] 			     opcode;

   // Control wires
   wire 			     reg2loc;
   wire 			     alusrc;
   wire 			     mem2reg;
   wire 			     regwrite;
   wire 			     memread;
   wire 			     memwrite;
   wire 			     branch;
   wire 			     uncond_branch;
   wire [3:0] 			     aluctrl;
   wire [2:0] 			     signop;
   wire [1:0]			     shift;

   // Register file connections
   wire [63:0] 			     regoutA;     // Output A
   wire [63:0] 			     regoutB;     // Output B
  // wire [63:0] BusW;

   // ALU connections
   wire [63:0] 			     aluout;
   wire 			     zero;

   // Sign Extender connections
   wire [63:0] 			     extimm;

   // PC update logic
   always @(negedge CLK)
     begin
        if (resetl) begin
          currentpc <= #3 nextpc;
	  //$display("LDUR %h",MemtoRegOut);
	  //$display("Branch %b ALUZero %b",branch,zero);
        end else 
          currentpc <= #3 startpc;
     end
   // Parts of instruction
   assign rd = instruction[4:0];
   assign rm = instruction[9:5];
   assign rn = reg2loc ? instruction[4:0] : instruction[20:16];
   assign opcode = instruction[31:21];
   wire [63:0] alumux;
   assign alumux = alusrc ? extimm : regoutB;
   wire [63:0] MemOut;
   assign MemtoRegOut = mem2reg ? MemOut : aluout;

   InstructionMemory imem(
			  .Data(instruction),
			  .Address(currentpc)
			  );

   SingleCycleControl control(
		   .reg2loc(reg2loc),
		   .alusrc(alusrc),
		   .mem2reg(mem2reg),
		   .regwrite(regwrite),
		   .memread(memread),
		   .memwrite(memwrite),
		   .branch(branch),
		   .uncond_branch(uncond_branch),
		   .aluop(aluctrl),
		   .signop(signop),
		   .shift(shift),
		   .opcode(opcode)
		   );

   /*
    * Connect the remaining datapath elements below.
    * Do not forget any additional multiplexers that may be required.
    */
    
    ALU alu(.BusW(aluout), .BusA(regoutA), .BusB(alumux), .ALUCtrl(aluctrl), .Zero(zero));
    NextPClogic npc(.NextPC(nextpc), .CurrentPC(currentpc), .SignExtImm64(extimm), .Branch(branch), .ALUZero(zero), .Uncondbranch(uncond_branch));
    RegisterFile regfile(.BusA(regoutA), .BusB(regoutB), .BusW(MemtoRegOut), .RW(rd), .RA(rm), .RB(rn), .RegWr(regwrite), .Clk(CLK));
    SignExtender signext(.BusImm(extimm), .Imm26(instruction[25:0]), .Ctrl(signop), .shift(shift)); 
    DataMemory datam(.ReadData(MemOut) , .Address(aluout) , .WriteData(regoutB) , .MemoryRead(memread) , .MemoryWrite(memwrite) , .Clock(CLK));
    



endmodule

