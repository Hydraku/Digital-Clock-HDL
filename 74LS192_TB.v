 module IC192_TB;

    // Inputs
    reg clk;
    reg reset;
    reg pl;
    reg up;
    reg down;
    reg [3:0] d;

    // Outputs
    wire [3:0] q;
    wire tcu;
    wire tcd;

    // Instantiate the Unit Under Test (UUT)
    UpDownCounter uut (
        .clk(clk), 
        .reset(reset), 
        .pl(pl), 
        .up(up), 
        .down(down), 
        .d(d), 
        .q(q), 
        .tcu(tcu), 
        .tcd(tcd)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 ns
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 0;
        pl = 1;
        up = 0;
        down = 0;
        d = 4'b0000;

        // Reset the counter
        #10 reset = 1;
        #10 reset = 0;
        #10 reset = 1;

        // Load parallel data into the counter
        #10 d = 4'b0101; // Load 5
        pl = 0;
        #10 pl = 1;

        // Count up
        #10 up = 1;
        #50 up = 0;

        // Count down
        #10 down = 1;
        #50 down = 0;

        // Apply reset
        #10 reset = 0;
        #10 reset = 1;

        // Finish simulation
        #100 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time = %0dns, clk = %b, reset = %b, pl = %b, up = %b, down = %b, d = %b, q = %b, tcu = %b, tcd = %b", 
                 $time, clk, reset, pl, up, down, d, q, tcu, tcd);
    end

endmodule
