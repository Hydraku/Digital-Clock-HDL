module sC(
    input A,
    input B,
    input C,
    input D,
    output c
);
	 //c = A'B + A'D + AB'C' + B'C'D'

    assign c = (~A & B) | (~A & D) | (A & ~B & ~C) | (~B & ~C & ~D);
	 
endmodule 