`timescale 1ns/1ps

module tb_latches;

    // DUT signals
    reg  S, R, EN;
    reg  clk, reset, D;

    wire Q_sr, Qb_sr;
    wire Q_gated, Qb_gated;
    wire Q_dff;

    // Instantiate DUTs
    sr_latch_async u_sr (
        .S(S),
        .R(R),
        .Q(Q_sr),
        .Q_bar(Qb_sr)
    );

    gated_sr_latch u_gated (
        .S(S),
        .R(R),
        .EN(EN),
        .Q(Q_gated),
        .Q_bar(Qb_gated)
    );

    dff_sync u_dff (
        .clk(clk),
        .reset(reset),
        .D(D),
        .Q(Q_dff)
    );

    // Clock generation for DFF
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 100 MHz clock (10 ns period)
    end

    initial begin
        // Initialize
        S     = 0;
        R     = 0;
        EN    = 0;
        D     = 0;
        reset = 1;

        // Release reset after a bit
        #20 reset = 0;

        // -------- Test async SR latch (and gated latch with EN=1) --------
        EN = 1;

        // Set condition
        #10 S = 1; R = 0;
        #20 S = 0;

        // Reset condition
        #20 R = 1;
        #20 R = 0;

        // Invalid condition (S=R=1)
        #20 S = 1; R = 1;
        #20 S = 0; R = 0;

        // Disable gated latch, SR still responds but gated should hold
        #20 EN = 0;
        #20 S = 1; R = 0;
        #20 S = 0; R = 0;

        // -------- Test D flip-flop --------
        #20 D = 1;
        #20 D = 0;
        #20 D = 1;

        // Assert reset again
        #20 reset = 1;
        #10 reset = 0;

        #50 $finish;
    end

endmodule
