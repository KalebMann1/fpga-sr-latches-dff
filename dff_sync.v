// Positive-edge triggered D flip-flop with asynchronous reset.
module dff_sync (
    input  wire clk,
    input  wire reset,   // active high async reset
    input  wire D,
    output reg  Q
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 1'b0;
        else
            Q <= D;
    end

endmodule
