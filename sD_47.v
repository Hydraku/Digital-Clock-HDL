module sD(
    input A,
    input B,
    input C,
    input D,
    output d
);
	 //d = A'B'C + A'CD' + AB'C' + B'C'D' + A'BC'D

    assign d = (~A & ~B & C) | (~A & C & ~D) | (A & ~B & ~C) | (~B & ~C & ~D) | (~A & B & ~C & D);
	 
endmodule 