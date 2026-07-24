`timescale 1ns / 1ps

module tb_10000_counter ();
    reg clk;
    reg reset;
    reg btn_L;
    reg btn_R;
    reg btn_UP;
    wire [3:0] fnd_com;
    wire [7:0] fnd_data;

    //25ms delay
    parameter TEST_DELAY = 10_000_000;

    top_counter_10000 dut (
        .clk(clk),
        .reset(reset),
        .btn_L(btn_L),  //run_Stop
        .btn_R(btn_R),  //clear
        .btn_UP(btn_UP), //mode
        .fnd_com(fnd_com),
        .fnd_data(fnd_data)
    );

    //clock generation 100Mhz
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        {btn_R, btn_L, btn_UP} = 3'b000;
        #10;
        reset = 0;

        // 1 STOP
        {btn_R, btn_L, btn_UP} = 3'b000;
        #(TEST_DELAY);

        //2 RUN btn push
        #6;
        {btn_R, btn_L, btn_UP} = 3'b010;
        #10;
        {btn_R, btn_L, btn_UP} = 3'b000;
        #(TEST_DELAY);

        #1000;
        $stop;
    end

endmodule
