module Decode24 ( out , in ) ;
  input [ 1 : 0 ] in ;
  output [ 3 : 0 ] out ;
  
	wire inv0, inv1;
	not not0(inv0, in[0]);
	not not1(inv1, in[1]);
	and and0(out[0], inv0, inv1);
	and and1(out[1], in[0], inv1);
	and and2(out[2], inv0, in[1]);
	and and3(out[3], in[0], in[1]);
endmodule
