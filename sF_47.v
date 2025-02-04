module sF(
    input A,
    input B,
    input C,
    input D,
    output f
);
	 //f = A’C’D’ + A B' C’ + A’ B C’ + A' B D'

    assign f = (~A & ~C & ~D) | (A & ~B & ~C) | (~A & B & ~C) | (~A & B & ~D);
	 
endmodule 