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
        $display("REG[12] = %h",registers[12]);
        if((RW != 31) && RegWr) //stores BusW into RW register
            registers[RW] <= #3 BusW;
        //registers[
    end
endmodule
