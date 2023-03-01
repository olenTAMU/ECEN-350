`timescale 1ns / 1ps
module RegisterFile(BusA, BusB, BusW, RW, RA, RB, RegWr, Clk);
    output [63:0] BusA;
    output [63:0] BusB;
    input [63:0] BusW;
    input [4:0] RW, RA, RB;
    input RegWr;
    input Clk;
    reg [63:0] registers [31:0];
     
    assign #2 BusA = (RA!=5'd31)?registers[RA]:64'h0;
    assign #2 BusB = (RB!=5'd31)?registers[RB]:64'h0;
    
    
     
    always @ (negedge Clk) begin
        //$display("[!]BusA = %h",BusA);
        //$display("[!]BusB = %h",BusB);
      // $display("*REG[1] = %h",registers[1]);
      // $display("*REG[2] = %h",registers[2]);
      // $display("*REG[3] = %h",registers[3]);
      // $display("*REG[4] = %h",registers[4]);
      //  $display("*REG[9] = %h",registers[9]);
        if((RW != 31) && RegWr) //stores BusW into RW register
            registers[RW] <= #3 BusW;
          //  $display("*jREG[9] = %h",registers[9]);
          //  $display("*REG[10] = %h",registers[10]);
          //  $display("*REG[11] = %h",registers[11]);
          //$display("*REG[12] = %h",registers[12]);
          //  $display("*REG[13] = %h",registers[13]);
          //  $display("*RW = %d",RW);
          //  $display("*BusW = %h",BusW);
        
    end
endmodule
