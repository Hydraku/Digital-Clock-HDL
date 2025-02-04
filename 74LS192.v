module IC192(
    input wire clk,             // Clock input
    input wire reset,           // Master Reset (Active Low)
    input wire pl,              // Parallel Load (Active Low)
    input wire up,              // Count Up Signal (Active High)
    input wire down,            // Count Down Signal (Active High)
    input wire [3:0] d,         // Parallel Data Inputs
    output reg [3:0] q,         // 4-bit Counter Output
    output wire tcu,            // Terminal Count Up (Carry Output)
    output wire tcd             // Terminal Count Down (Borrow Output)
);

    // Up/Down Counter Logic
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            q <= 4'b0000; // Reset counter to 0
        end else if (!pl) begin
            q <= d; // Load parallel data into the counter
        end else if (up && !down) begin
            if (q == 4'b1001) begin
                q <= 4'b0000; // Wrap around to 0 after reaching maximum (15)
            end else begin
                q <= q + 1; // Increment counter
            end
        end else if (!up && down) begin
            if (q == 4'b0000) begin
                q <= 4'b1001; // Wrap around to maximum (15) after reaching 0
            end else begin
                q <= q - 1; // Decrement counter
            end
        end
    end

    // Generate Terminal Count Up (Carry Output)
    assign tcu = (q == 4'b1001) && up;

    // Generate Terminal Count Down (Borrow Output)
    assign tcd = (q == 4'b0000) && down;

endmodule
