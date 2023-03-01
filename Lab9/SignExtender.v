module SignExtender(BusImm, Imm26, Ctrl, shift); 
   output reg [63:0] BusImm; 
   input [25:0]  Imm26; 
   input [2:0] Ctrl; 
   input [1:0] shift;
   
   //assign extBit = (Ctrl ? 2'b0 : Imm16[25]); //1'b0->2'b00 , 15->25
   //assign BusImm = {{26{extBit}}, Imm16}; //25->26 
   
   //-----------------
  always@(*) 
	begin
		case(Ctrl)
			3'b000: BusImm = {52'b0, Imm26[21:10]}; //ALUImm
			3'b001: BusImm = {{55{Imm26[20]}}, Imm26[20:12]}; //DTaddr
			3'b010: BusImm = {{36{Imm26[25]}}, Imm26, 2'b0}; //Baddr
			3'b011: BusImm = {{43{Imm26[23]}}, Imm26[23:5], 2'b0}; //CondBaddr
			
			3'b100: case(shift)
			   2'b00: BusImm = {48'b0, Imm26[20:5]}; //move immediate
			   2'b01: BusImm = {32'b0, Imm26[20:5], 16'b0};
			   2'b10: BusImm = {16'b0, Imm26[20:5], 32'b0};
			   2'b11: BusImm = {Imm26[20:5], 48'b0};
			   endcase
		endcase
	end
endmodule
   //assign ALUImm = {52'b0, ALU_immediate}
   //assign DTaddr = {55{DT_address[8]}, DT_address}
   //assign Baddr = {36{BR_address[25]}, BR_address, 2'b0}
   //assign CondBaddr = {43{COND_BR_address[25]}, COND_BR_address, 2'b0}
   

