// Testbench for DigitalClock
module DigitalClock_TB;

reg clk;
reg reset;
wire [6:0] sec_ones_seg;
wire [6:0] sec_tens_seg;
wire [6:0] min_ones_seg;
wire [6:0] min_tens_seg;
wire [6:0] hour_ones_seg;
wire [6:0] hour_tens_seg;

DigitalClock uut (
    .clk(clk),
    .reset(reset),
    .sec_ones_seg(sec_ones_seg),
    .sec_tens_seg(sec_tens_seg),
    .min_ones_seg(min_ones_seg),
    .min_tens_seg(min_tens_seg),
    .hour_ones_seg(hour_ones_seg),
    .hour_tens_seg(hour_tens_seg)
);

initial begin
    $dumpfile("digital_clock.vcd");
    $dumpvars(0, DigitalClock_TB);
end

initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0;
end

always #10 clk = ~clk; // 100 Hz clock

initial begin
    #1000 $display("Seconds: %b:%b", sec_tens_seg, sec_ones_seg);
    #1000 $display("Minutes: %b:%b", min_tens_seg, min_ones_seg);
    #1000 $display("Hours: %b:%b", hour_tens_seg, hour_ones_seg);
    #10000 $finish;
end

endmodule 