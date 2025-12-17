// Asynchronous SR latch using cross-coupled NAND gates.
// S = set (active high), R = reset (active high)
module sr_latch_async (
    input  wire S,
    input  wire R,
    output wire Q,
    output wire Q_bar
);
    wire S_n;
    wire R_n;

    // Convert active-high S/R into active-low inputs for NAND latch
    assign S_n = ~S;
    assign R_n = ~R;

    // Cross-coupled NAND gate implementation
    nand (Q,     S_n, Q_bar);
    nand (Q_bar, R_n, Q);

endmodule
