module IC47(a, b, c, d, e, f, g, A, B, C, D);

input A;
input B;
input C;
input D;
output a;
output b;
output c;
output d;
output e;
output f;
output g;


	  sA segA(A, B, C, D, a);
	  sB segB(A, B, C, D, b);
	  sC segC(A, B, C, D, c);
	  sD segD(A, B, C, D, d);
	  sE segE(A, B, C, D, e);
	  sF segF(A, B, C, D, f);
	  sG segG(A, B, C, D, g);
	  
endmodule
