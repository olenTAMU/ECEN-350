module SignExtender(BusImm, Imm26, Ctrl); 
   output reg [63:0] BusImm; 
   input [25:0]  Imm26; 
   input [1:0] Ctrl; 
   
   //assign extBit = (Ctrl ? 2'b0 : Imm16[25]); //1'b0->2'b00 , 15->25
   //assign BusImm = {{26{extBit}}, Imm16}; //25->26 
   
   //-----------------
  always@(*) 
	begin
		case(Ctrl)
			2'b00: BusImm = {52'b0, Imm26[21:10]}; //ALUImm
			2'b01: BusImm = {{55{Imm26[20]}}, Imm26[20:12]}; //DTaddr
			2'b10: BusImm = {{36{Imm26[25]}}, Imm26, 2'b0}; //Baddr
			2'b11: BusImm = {{43{Imm26[23]}}, Imm26[23:5], 2'b0}; //CondBaddr
		endcase
	end
endmodule
   //assign ALUImm = {52'b0, ALU_immediate}
   //assign DTaddr = {55{DT_address[8]}, DT_address}
   //assign Baddr = {36{BR_address[25]}, BR_address, 2'b0}
   //assign CondBaddr = {43{COND_BR_address[25]}, COND_BR_address, 2'b0}
   

