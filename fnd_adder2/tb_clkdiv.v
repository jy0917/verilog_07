`timescale 1ns / 1ps

module tb_clkdiv ();
    reg clk, reset;
    wire o_1khz;
    wire o_50mhz, o_25mhz, o_16mhz, o_8mhz;

    clk_div_2 U_CLK_DIV2 (
        .clk(clk),
        .reset(reset),
        .o_50mhz(o_50mhz)
    );

    clk_div_4 U_CLK_DIV4 (
        .clk(clk),
        .reset(reset),
        .o_25mhz(o_25mhz)
    );

    clk_div_6 U_CLK_DIV6 (
        .clk(clk),
        .reset(reset),
        .o_16mhz(o_16mhz)
    );

    clk_div_12 U_CLK_DIV12 (
        .clk(clk),
        .reset(reset),
        .o_8mhz(o_8mhz)
    );
    clk_div dut (
        .clk(clk),
        .reset(reset),
        .o_1khz(o_1khz)
    );

    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        reset = 1;
        #10;
        reset = 0;
        #(500_000 * 3);
        $stop;
    end

endmodule
