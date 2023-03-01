module Mux21 ( out , in , sel ) ;
  input [ 1 : 0 ] in ;
  input sel ;
  output out;

	wire out0, out1, sel0;
	and and0(out0, in[1], sel);
	not not0(sel0, sel);
	and and1(out1, in[0], sel0);
	or or0(out, out0, out1);
endmodule
	
	
	
	
