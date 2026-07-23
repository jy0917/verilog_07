`timescale 1ns / 1ps

module tb_10000_counter ();
    reg clk;
    reg reset;
    reg [2:0] sw;
    wire [3:0] fnd_com;
    wire [7:0] fnd_data;

    //25ms delay
    parameter TEST_DELAY = 25_000_000; 

    top_counter_10000 dut (
        .clk(clk),
        .reset(reset),
        .sw(sw),
        .fnd_com(fnd_com),
        .fnd_data(fnd_data)
    );

    //clock generation 100Mhz
    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        reset = 1;
        sw = 3'b000;
        #10;
        reset = 0;

        // 1
        sw = 3'b000;
        #(TEST_DELAY);

        //2
        sw = 3'b010;
        #(TEST_DELAY);
        
        //3
        sw = 3'b000;
        #(TEST_DELAY);

        //4
        sw = 3'b011;
        #(TEST_DELAY * 2); //0~9999

        //5
        sw = 3'b001;
        #(TEST_DELAY);

        //6
        sw = 3'b101;
        #(TEST_DELAY);

        //7
        sw = 3'b000;
        #(TEST_DELAY);


        // //period tick : 1_000_000, 1 clock : 10nsec, 10 : 10tick
        // #(1_000_000 * 10 * 10);
        #1000;
        $stop;
    end

endmodule
