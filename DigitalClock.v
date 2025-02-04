// Top-Level Module for 12-Hour Digital Clock
module DigitalClock(
    input wire clk,           // Main clock input
    input wire reset,         // Master reset (active low)
    output wire [6:0] sec_ones_seg, // 7-segment outputs for seconds (ones)
    output wire [6:0] sec_tens_seg, // 7-segment outputs for seconds (tens)
    output wire [6:0] min_ones_seg, // 7-segment outputs for minutes (ones)
    output wire [6:0] min_tens_seg, // 7-segment outputs for minutes (tens)
    output wire [6:0] hour_ones_seg, // 7-segment outputs for hours (ones)
    output wire [6:0] hour_tens_seg  // 7-segment outputs for hours (tens)
);

    // Clock Divider to Generate 1Hz Signal
    reg [23:0] clk_div;
    wire clk_1hz;
    always @(posedge clk or negedge reset) begin
        if (!reset)
            clk_div <= 24'b0;
        else
            clk_div <= clk_div + 1;
    end
    assign clk_1hz = clk_div[23]; // Generate 1Hz clock signal

    // Wires for Counter Outputs
    wire [3:0] sec_ones, sec_tens;
    wire [3:0] min_ones, min_tens;
    reg [3:0] hour_ones, hour_tens;
    wire sec_tc; // Terminal count for seconds
    wire min_tc; // Terminal count for minutes

    // Seconds Counter (0-59)
    IC90 seconds_ones (
        .cka(clk_1hz),
        .ckb(1'b0),
        .r0_1(reset),
        .r0_2(reset),
        .r9_1(sec_ones == 4'd9),
        .r9_2(1'b1),
        .q(sec_ones)
    );
    IC90 seconds_tens (
        .cka(sec_ones == 4'd9),
        .ckb(1'b0),
        .r0_1(reset),
        .r0_2(reset),
        .r9_1(sec_tens == 4'd5 && sec_ones == 4'd9),
        .r9_2(1'b1),
        .q(sec_tens)
    );
    assign sec_tc = (sec_ones == 4'd9 && sec_tens == 4'd5); // When seconds reach 59

    // Minutes Counter (0-59)
    IC90 minutes_ones (
        .cka(sec_tc),
        .ckb(1'b0),
        .r0_1(reset),
        .r0_2(reset),
        .r9_1(min_ones == 4'd9),
        .r9_2(1'b1),
        .q(min_ones)
    );
    IC90 minutes_tens (
        .cka(min_ones == 4'd9),
        .ckb(1'b0),
        .r0_1(reset),
        .r0_2(reset),
        .r9_1(min_tens == 4'd5 && min_ones == 4'd9),
        .r9_2(1'b1),
        .q(min_tens)
    );
    assign min_tc = (min_ones == 4'd9 && min_tens == 4'd5); // When minutes reach 59

    // Hours Counter (1-12)
    reg am_pm; // AM/PM indicator (not implemented)
    always @(posedge clk_1hz or negedge reset) begin
        if (!reset) begin
            hour_ones <= 4'd1; // Reset to 01
            hour_tens <= 4'd0;
            am_pm <= 1'b0; // Default to AM
        end
        else if (min_tc) begin
            if (hour_ones == 4'd9 || (hour_tens == 4'd1 && hour_ones == 4'd2)) begin
                hour_ones <= 4'd1; // Wrap around to 01
                hour_tens <= 4'd0;
                am_pm <= ~am_pm; // Toggle AM/PM
            end
            else if (hour_ones == 4'd2 && hour_tens == 4'd1) begin
                hour_ones <= 4'd1; // Handle 12-hour wrap-around
                hour_tens <= 4'd0;
            end
            else begin
                hour_ones <= hour_ones + 1;
                if (hour_ones == 4'd9) begin
                    hour_ones <= 4'd0;
                    hour_tens <= hour_tens + 1;
                end
            end
        end
    end

    // Seven-segment decoders
    IC47 sec_ones_display (
        .A(sec_ones[3]),
        .B(sec_ones[2]),
        .C(sec_ones[1]),
        .D(sec_ones[0]),
        .a(sec_ones_seg[0]),
        .b(sec_ones_seg[1]),
        .c(sec_ones_seg[2]),
        .d(sec_ones_seg[3]),
        .e(sec_ones_seg[4]),
        .f(sec_ones_seg[5]),
        .g(sec_ones_seg[6])
    );

    IC47 sec_tens_display (
        .A(sec_tens[3]),
        .B(sec_tens[2]),
        .C(sec_tens[1]),
        .D(sec_tens[0]),
        .a(sec_tens_seg[0]),
        .b(sec_tens_seg[1]),
        .c(sec_tens_seg[2]),
        .d(sec_tens_seg[3]),
        .e(sec_tens_seg[4]),
        .f(sec_tens_seg[5]),
        .g(sec_tens_seg[6])
    );

    IC47 min_ones_display (
        .A(min_ones[3]),
        .B(min_ones[2]),
        .C(min_ones[1]),
        .D(min_ones[0]),
        .a(min_ones_seg[0]),
        .b(min_ones_seg[1]),
        .c(min_ones_seg[2]),
        .d(min_ones_seg[3]),
        .e(min_ones_seg[4]),
        .f(min_ones_seg[5]),
        .g(min_ones_seg[6])
    );

    IC47 min_tens_display (
        .A(min_tens[3]),
        .B(min_tens[2]),
        .C(min_tens[1]),
        .D(min_tens[0]),
        .a(min_tens_seg[0]),
        .b(min_tens_seg[1]),
        .c(min_tens_seg[2]),
        .d(min_tens_seg[3]),
        .e(min_tens_seg[4]),
        .f(min_tens_seg[5]),
        .g(min_tens_seg[6])
    );

    IC47 hour_ones_display (
        .A(hour_ones[3]),
        .B(hour_ones[2]),
        .C(hour_ones[1]),
        .D(hour_ones[0]),
        .a(hour_ones_seg[0]),
        .b(hour_ones_seg[1]),
        .c(hour_ones_seg[2]),
        .d(hour_ones_seg[3]),
        .e(hour_ones_seg[4]),
        .f(hour_ones_seg[5]),
        .g(hour_ones_seg[6])
    );

    IC47 hour_tens_display (
        .A(hour_tens[3]),
        .B(hour_tens[2]),
        .C(hour_tens[1]),
        .D(hour_tens[0]),
        .a(hour_tens_seg[0]),
        .b(hour_tens_seg[1]),
        .c(hour_tens_seg[2]),
        .d(hour_tens_seg[3]),
        .e(hour_tens_seg[4]),
        .f(hour_tens_seg[5]),
        .g(hour_tens_seg[6])
    );

endmodule
