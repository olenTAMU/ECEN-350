module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
   input [63:0] CurrentPC, SignExtImm64; 
   input 	Branch, ALUZero, Uncondbranch; 
   output reg [63:0] NextPC; 

   /* write your code here */ 
   always@* begin
   
   /*
   if(!Uncondbranch & !Branch) begin
   //$display("Testing not U. not B %h Next is %h", CurrentPC, NextPC);
      assign NextPC = CurrentPC + 64'b1;
     // $display("After not U. not B %h Next is %h", CurrentPC, NextPC);
   end
   else if(Uncondbranch & !Branch) begin
     // $display("Testing U. not B");
      assign NextPC = SignExtImm64;
   end
   else if(!Uncondbranch & Branch) begin
      //$display("Testing not U, B");
      if(ALUZero) begin
         assign NextPC = SignExtImm64;
      end 
      else if(!ALUZero) begin
         assign NextPC = CurrentPC + 1'b1;
      end
   end
   */
  // assign [63:0] shiftSign = SignExtImm64 << 2;
   if((Branch && ALUZero) || Uncondbranch) begin
      NextPC = SignExtImm64 + CurrentPC;
      $display("NextPC %h, Branch&zero %b signout %h",NextPC,Branch && ALUZero,SignExtImm64);
   end 
   else begin
      NextPC = CurrentPC + 4'h4;
   end
   
   end
   
   /*
   if branch & zero or uncondbranch
      add signext shifted 4 with the pc
   otherwise
      just add 4
   
   
   
   
   */
   

   initial       
      if(Branch==1'b1&&ALUZero==1'b1)
         $display("NexPC %h",NextPC);
endmodule
