module HalfAdd ( Cout , Sum , A, B ) ;
  input A, B ;
  output Cout , Sum ;
  
  xor xor0(Sum, A, B); //uses an xor gates
  and and0(Cout, A, B); //uses an add gate
endmodule
