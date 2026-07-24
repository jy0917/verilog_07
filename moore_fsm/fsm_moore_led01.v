`timescale 1ns / 1ps
module fsm_moore_led01 (
    input clk,
    input reset,
    input [2:0] sw,
    // output led
    output reg [2:0] led
);

    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

    //state register
    reg [2:0] current_state, next_state;

    //state register
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    //next state Combination Logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            S0: begin
                if (sw == 3'b001) next_state = S1;
                else if (sw == 3'b100) next_state = S4;
                else next_state = S0;
            end
            S1: begin
                if (sw == 3'b010) next_state = S2;
                else next_state = S1;
            end
            S2: begin
                if (sw == 3'b011) next_state = S3;
                else next_state = S2;
            end
            S3: begin
                if (sw == 3'b100) next_state = S4;
                else next_state = S3;
            end
            S4: begin
                if (sw == 3'b111) next_state = S0;
                else if (sw == 3'b001) next_state = S1;
                else next_state = S4;
            end
            default: next_state = current_state;
        endcase
    end

    //output combinational logic
    // assign led = (current_state == S1) ? 1'b1 : 1'b0;
    always @(*) begin
        case (current_state)
            S0: led = 3'b000;
            S1: led = 3'b001;
            S2: led = 3'b010;
            S3: led = 3'b011;
            S4: led = 3'b100;
            default : led = 3'b000;
        endcase
    end
endmodule
