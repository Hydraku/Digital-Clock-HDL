module IC47_TB;

	 // input
	 reg A, B, C, D;
	
	//output
	 wire a, b, c, d, e, f, g;
	 
	 //instantiating module
	 Segment_instance dut(a, b, c, d, e, f, g, A, B, C, D);
	 
	 //initializing
	 initial begin
		A = 0; B = 0; C = 0; D = 0; #10;
		A = 0; B = 0; C = 0; D = 1; #10;
		A = 0; B = 0; C = 1; D = 0; #10;
		A = 0; B = 0; C = 1; D = 1; #10;
		A = 0; B = 1; C = 0; D = 0; #10;
		A = 0; B = 1; C = 0; D = 1; #10;
		A = 0; B = 1; C = 1; D = 0; #10;
		A = 0; B = 1; C = 1; D = 1; #10;
		A = 1; B = 0; C = 0; D = 0; #10;
		A = 1; B = 0; C = 0; D = 1; #10;
		A = 1; B = 0; C = 1; D = 0; #10;
		A = 1; B = 0; C = 1; D = 1; #10;
		A = 1; B = 1; C = 0; D = 0; #10;
		A = 1; B = 1; C = 0; D = 1; #10;
		A = 1; B = 1; C = 1; D = 0; #10;
		A = 1; B = 1; C = 1; D = 1; #10;
	 end
	  
endmodule

