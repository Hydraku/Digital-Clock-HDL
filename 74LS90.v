module IC90(
    input wire cka,              // Clock input for divide-by-2 section
    input wire ckb,              // Clock input for divide-by-5 section
    input wire r0_1,             // Asynchronous Reset Input 1
    input wire r0_2,             // Asynchronous Reset Input 2
    input wire r9_1,             // Asynchronous Reset Input 1 for divide-by-5
    input wire r9_2,             // Asynchronous Reset Input 2 for divide-by-5
    output wire [3:0] q          // 4-bit counter output
);

    // Intermediate signals
    wire q0_inverted, q1_inverted, q2_inverted, q3_inverted;
    wire reset_all = ~(r0_1 & r0_2);
    wire set_all = ~(r9_1 & r9_2);

    // Divide-by-2 counter (First JK flip-flop)
    IC76 divide_by_2 (
        .clk(cka),
        .reset(reset_all),  // Active low reset for divide-by-2 section
        .set(1'b0),         // No set for divide-by-2
        .j(1'b1),           // JK inputs set to toggle
        .k(1'b1),
        .q(q[0]),
        .q_inverted(q0_inverted)
    );

    // Divide-by-5 counter (Second JK flip-flop chain)
    IC76 divide_by_5_stage1 (
        .clk(q[0]),          // Triggered by output of divide-by-2
        .reset(reset_all | set_all),  // Active low reset
        .set(1'b0),         // No set
        .j(1'b1),           // JK inputs set to toggle
        .k(1'b1),
        .q(q[1]),
        .q_inverted(q1_inverted)
    );

    IC76 divide_by_5_stage2 (
        .clk(q[1]),          // Triggered by output of previous stage
        .reset(reset_all | set_all),  // Active low reset for divide-by-5 section
        .set(1'b0),         // No set
        .j(1'b1),           // JK inputs set to toggle
        .k(1'b1),
        .q(q[2]),
        .q_inverted(q2_inverted)
    );

    IC76 divide_by_5_stage3 (
        .clk(q[2]),          // Triggered by output of previous stage
        .reset(reset_all),  // Active low reset for divide-by-5 section
        .set(1'b0),         // No set
        .j(1'b1),           // JK inputs set to toggle
        .k(1'b1),
        .q(q[3]),
        .q_inverted(q3_inverted)
    );

endmodule
