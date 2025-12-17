// Gated SR latch: latch only responds to S/R when enable = 1.
module gated_sr_latch (
    input  wire S,
    input  wire R,
    input  wire EN,   // enable
    output wire Q,
    output wire Q_bar
);
    wire S_g;
    wire R_g;

    // Gate the S and R inputs with EN
    assign S_g = ~(S & EN);  // active-low inputs to NAND latch
    assign R_g = ~(R & EN);

    // Cross-coupled NAND core
    nand (Q,     S_g, Q_bar);
    nand (Q_bar, R_g, Q);

endmodule
