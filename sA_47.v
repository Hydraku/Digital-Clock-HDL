module sA(
    input A, B, C, D,
    output a
);

 //a = A'C + A'BD + AB'C' + B'C'D'
 
  assign a = (~A & C) | (~A & B & D) | (A & ~B & ~C) | (~B & ~C & ~D);
  
endmodule
