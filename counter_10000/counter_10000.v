`timescale 1ns / 1ps

module top_counter_10000 (
    input clk,
    input reset,
    input [2:0] sw,
    output [3:0] fnd_com,
    output [7:0] fnd_data
);
    wire [13:0] w_counter;
    wire w_reset;

    assign w_reset = reset | sw[2];

    datapath_10000 U_DATAPATH_10000 (
        .clk(clk),
        .reset(w_reset),
        .mode(sw[0]),
        .run_stop(sw[1]),
        .counter(w_counter)
    );

    fnd_controller U_FND_CNTL (
        .clk(clk),
        .reset(w_reset),
        .fnd_in(w_counter),
        .fnd_com(fnd_com),
        .fnd_data(fnd_data)
    );

endmodule

module datapath_10000 (
    input clk,
    input reset,
    input mode,
    input run_stop,
    output [13:0] counter
);
    wire w_tick;

    counter_10000 U_COUNTER_10000 (
        .clk(clk),
        .reset(reset),
        .mode(mode),
        .run_stop(run_stop),
        .i_tick(w_tick),
        .counter(counter)
    );
    tick_gen U_TICK_GEN (
        .clk(clk),
        .reset(reset),
        .run_stop(run_stop),
        .tick(w_tick)
    );

endmodule

module counter_10000 (
    input clk,
    input reset,
    input mode,
    input run_stop,
    input i_tick,
    output [13:0] counter
);

    reg [$clog2(10000)-1:0] tick_counter_reg;

    assign counter = tick_counter_reg;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            tick_counter_reg <= 0;
        end else begin
            if (run_stop & i_tick) begin
                if (!mode) begin  //0 mode up count
                    tick_counter_reg <= tick_counter_reg + 1;
                    if (tick_counter_reg == (10000 - 1)) tick_counter_reg <= 0;
                end else begin  //1 mode down count
                    tick_counter_reg <= tick_counter_reg - 1;
                    if (tick_counter_reg == 0) tick_counter_reg <= (10000 - 1);
                end
            end
        end
    end
endmodule

module tick_gen (
    input  clk,
    input  reset,
    input  run_stop,
    output tick
);

    reg [$clog2(1_000_000)-1:0] counter_reg;
    reg tick_reg;

    assign tick = tick_reg;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            counter_reg <= 0;
            tick_reg <= 0;
        end else begin
            if (run_stop) begin
                counter_reg <= counter_reg + 1;

                if (counter_reg == (1_000_000 - 1)) begin
                    counter_reg <= 0;
                    tick_reg <= 1'b1;
                end else begin
                    tick_reg <= 1'b0;
                end
            end
        end
    end

endmodule
