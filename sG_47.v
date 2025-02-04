module sG(
    input A,
    input B,
    input C,
    input D,
    output g
);
	 //g = A B'C' + A'B C' + A'B'C + A'C D'

    assign g = (A & ~B & ~C) | (~A & B & ~C) | (~A & ~B & C) | (~A & C & ~D);
	 
endmodule 