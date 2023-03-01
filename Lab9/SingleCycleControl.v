`define OPCODE_ANDREG 11'b?0001010???
`define OPCODE_ORRREG 11'b?0101010???
`define OPCODE_ADDREG 11'b?0?01011???
`define OPCODE_SUBREG 11'b?1?01011???

`define OPCODE_ADDIMM 11'b?0?10001???
`define OPCODE_SUBIMM 11'b?1?10001???

`define OPCODE_MOVZ   11'b110100101??

`define OPCODE_B      11'b?00101?????
`define OPCODE_CBZ    11'b?011010????

`define OPCODE_LDUR   11'b??111000010
`define OPCODE_STUR   11'b??111000000

`timescale 1ns / 1ps

module SingleCycleControl(
	       output reg 	reg2loc,
	       output reg 	alusrc,
	       output reg 	mem2reg,
	       output reg 	regwrite,
	       output reg 	memread,
	       output reg 	memwrite,
	       output reg 	branch,
	       output reg 	uncond_branch,
	       output reg [3:0] aluop,
	       output reg [2:0] signop,
	       output reg [1:0] shift,
	       input [10:0] 	opcode
	       );

   always @(*)
     begin
	casez (opcode)

          /* Add cases here for each instruction your processor supports */
	  
	  `OPCODE_LDUR: begin
	  	    //$display("Goes through LDUR ALOT ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
	       reg2loc       = 1'b1; //was an x
	       uncond_branch = 1'b0;
	       branch        = 1'b0;
	       memread       = 1'b1;
	       mem2reg       = 1'b1;
	       memwrite      = 1'b0;
               alusrc        = 1'b1;
               regwrite      = 1'b1;
               aluop         = 4'b0010;
               signop        = 3'b001;
	       shift         = 2'b00;
            end
	    `OPCODE_STUR: begin
	       reg2loc       = 1'b1;
	       uncond_branch = 1'b0;
	       branch        = 1'b0;
	       memread       = 1'b0;
	       mem2reg       = 1'b0; //was an x
	       memwrite      = 1'b1;
               alusrc        = 1'b1;
               regwrite      = 1'b0;
               aluop         = 4'b0010;
               signop        = 3'b001;
	       shift         = 2'b00;
            end
	    `OPCODE_ADDIMM: begin
	       reg2loc       = 1'b1; //was an x
	       uncond_branch = 1'b0;
	       branch        = 1'b0;
	       memread       = 1'b0;
	       mem2reg       = 1'b0;
	       memwrite      = 1'b0;
               alusrc        = 1'b1; //or 0
               regwrite      = 1'b1;
               aluop         = 4'b0010;
               signop        = 3'b000;
	       shift         = 2'b00;
            end
	    `OPCODE_ADDREG: begin
	       reg2loc       = 1'b0;
	       uncond_branch = 1'b0;
	       branch        = 1'b0;
	       memread       = 1'b0;
	       mem2reg       = 1'b0;
	       memwrite      = 1'b0;
               alusrc        = 1'b0; //or 1
               regwrite      = 1'b1;
               aluop         = 4'b0010;
               signop        = 3'b001;
	       shift         = 2'b00;
            end
	    `OPCODE_SUBIMM: begin
	       reg2loc       = 1'b0;
	       uncond_branch = 1'b0;
	       branch        = 1'b0;
	       memread       = 1'b0;
	       mem2reg       = 1'b0;
	       memwrite      = 1'b0;
               alusrc        = 1'b0; //or 0
               regwrite      = 1'b1;
               aluop         = 4'b0110;
               signop        = 3'b000;
	       shift         = 2'b00;
            end
	    `OPCODE_SUBREG: begin
	       reg2loc       = 1'b0;
	       uncond_branch = 1'b0;
	       branch        = 1'b0;
	       memread       = 1'b0;
	       mem2reg       = 1'b0;
	       memwrite      = 1'b0;
               alusrc        = 1'b0; //or 1
               regwrite      = 1'b1;
               aluop         = 4'b0110;
               signop        = 3'b001;
	       shift         = 2'b00;
            end
	    `OPCODE_ANDREG: begin
	       reg2loc       = 1'b0;
	       uncond_branch = 1'b0;
	       branch        = 1'b0;
	       memread       = 1'b0;
	       mem2reg       = 1'b0;
	       memwrite      = 1'b0;
               alusrc        = 1'b0;
               regwrite      = 1'b1;
               aluop         = 4'b0000;
               signop        = 3'b001;
	       shift         = 2'b00;
            end
	    `OPCODE_ORRREG: begin
	       reg2loc       = 1'b0;
	       uncond_branch = 1'b0;
	       branch        = 1'b0;
	       memread       = 1'b0;
	       mem2reg       = 1'b0;
	       memwrite      = 1'b0;
               alusrc        = 1'b0;
               regwrite      = 1'b1;
               aluop         = 4'b0001;
               signop        = 3'b001;
	       shift         = 2'b00;
            end
	    `OPCODE_CBZ: begin
	       reg2loc       = 1'b1;
	       uncond_branch = 1'b0;
	       branch        = 1'b1;
	       memread       = 1'b0;
	       mem2reg       = 1'b1;
	       memwrite      = 1'b0;
               alusrc        = 1'b0;
               regwrite      = 1'b0;
               aluop         = 4'b0111;
               signop        = 3'b011;
	       shift         = 2'b00;
            end
	    `OPCODE_B: begin
	       reg2loc       = 1'b0;
	       uncond_branch = 1'b1;
	       branch        = 1'b0;
	       memread       = 1'b0;
	       mem2reg       = 1'b0;
	       memwrite      = 1'b0;
               alusrc        = 1'b0;
               regwrite      = 1'b0;
               aluop         = 4'b0000;
               signop        = 3'b010;
	       shift         = 2'b00;
            end
	    
	    `OPCODE_MOVZ: begin
	       reg2loc       = 1'b0;
	       uncond_branch = 1'b0;
	       branch        = 1'b0;
	       memread       = 1'b0;
	       mem2reg       = 1'b0;
	       memwrite      = 1'b0;
               alusrc        = 1'b1;
               regwrite      = 1'b1;
               aluop         = 4'b0111;
               signop        = 3'b100;
	       shift         = opcode[1:0];
            end
	  

          default:
            begin
	    //$display("Goes through this ALOT");
               reg2loc       = 1'b0; //was an x
               alusrc        = 1'b0; //was an x
               mem2reg       = 1'b0; //was an x
               regwrite      = 1'b0;
               memread       = 1'b0;
               memwrite      = 1'b0;
               branch        = 1'b0;
               uncond_branch = 1'b0;
               aluop         = 4'b0000; //was an x
               signop        = 3'b000; //was an x
	       shift         = 2'b00;
            end
	endcase
     end

endmodule

