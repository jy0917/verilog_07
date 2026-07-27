`timescale 1ns / 1ps


// module seq_det_mealy (
//     input  clk,
//     input  rst,
//     input  din_bit,
//     output dout_bit
// );

//     reg [2:0] state_reg, next_state;

//     parameter start = 3'b000;
//     parameter rd0_once = 3'b001;
//     parameter rd1_once = 3'b010;
//     parameter rd0_twice = 3'b011;
//     parameter rd1_twice = 3'b100;

//     assign dout_bit = (((state_reg == rd0_twice) && (din_bit == 0) || (state_reg == rd1_twice) && (din_bit == 1))) ?1:0;

//     always @(state_reg or din_bit) begin
//         case (state_reg)
//             start:
//             if (din_bit == 0) next_state = rd0_once;
//             else if (din_bit == 1) next_state = rd1_once;
//             else next_state = start;
//             rd0_once:
//             if (din_bit == 0) next_state = rd0_twice;
//             else if (din_bit == 1) next_state = rd1_once;
//             else next_state = start;
//             rd0_twice:
//             if (din_bit == 0) next_state = rd0_twice;
//             else if (din_bit == 1) next_state = rd1_once;
//             else next_state = start;
//             rd1_once:
//             if (din_bit == 0) next_state = rd0_once;
//             else if (din_bit == 1) next_state = rd1_twice;
//             else next_state = start;
//             rd1_twice:
//             if (din_bit == 0) next_state = rd0_once;
//             else if (din_bit == 1) next_state = rd1_twice;
//             else next_state = start;
//             default: next_state = start;
//         endcase
//     end

//     always @(posedge clk or posedge rst) begin
//         if (rst == 1) state_reg <= start;
//         else state_reg <= next_state;
//     end

// endmodule

module seq_det_mealy (
    input  clk,
    input  rst,
    input  din_bit,
    output dout_bit
);
    parameter START = 3'b000;
    parameter S_0 = 3'b001;
    parameter S_01 = 3'b010;
    parameter S_010 = 3'b011;
    
    reg [2:0] state_reg, next_state;

    always@(*) begin
        case(state_reg)
        START:
        if(din_bit == 0) next_state = S_0;
        else next_state = START;

        S_0:
        if(din_bit == 1) next_state = S_01;
        else next_state = S_0;

        S_01:
        if(din_bit == 0) next_state = S_010;
        else next_state = START;

        S_010:
        if(din_bit == 1) next_state = START;
        else next_state = S_0;

        endcase
    end

    assign dout_bit = ((state_reg == S_010) && (din_bit == 1)) ? 1:0;

    always @(posedge clk or posedge rst) begin
        if (rst == 1) state_reg <= START;
        else state_reg <= next_state;
    end


    
endmodule


module seq_det_moore (
    input  clk,
    input  rst,
    input  din_bit,
    output dout_bit
);
    parameter START = 3'b000;
    parameter S_0 = 3'b001;
    parameter S_01 = 3'b010;
    parameter S_010 = 3'b011;
    parameter S_0101 = 3'b100;
    
    reg [2:0] state_reg, next_state;

    always@(*) begin
        case(state_reg)
        START:
        if(din_bit == 0) next_state = S_0;
        else next_state = START;

        S_0:
        if(din_bit == 1) next_state = S_01;
        else next_state = S_0;

        S_01:
        if(din_bit == 0) next_state = S_010;
        else next_state = START;

        S_010:
        if(din_bit == 1) next_state = S_0101;
        else next_state = S_0;

        S_0101:
        if(din_bit == 1) next_state = START;
        else next_state = S_0;
        endcase
    end

    assign dout_bit = ((state_reg == S_0101)) ? 1:0;

    always @(posedge clk or posedge rst) begin
        if (rst == 1) state_reg <= START;
        else state_reg <= next_state;
    end


    
endmodule
