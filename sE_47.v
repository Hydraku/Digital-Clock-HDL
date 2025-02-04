module sE(
    input A,
    input B,
    input C,
    input D,
    output e
);
	 //e = A'CD' + B'C'D'

    assign e = (~A & C & ~D) | (~B & ~C & ~D);
	 
endmodule 