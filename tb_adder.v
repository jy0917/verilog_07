`timescale 1ns / 1ps

module tb_adder ();

    reg [7:0] a, b;  //4bit msb: lsb
    wire [7:0] s;  //4bit wire
    wire c;
    integer i, j;
    // full_adder_4bit dut (
    //     .a0(a[0]),  // 0th bit of reg a
    //     .a1(a[1]),  // 1st bit of reg a
    //     .a2(a[2]),  // 2nd bit of reg a 
    //     .a3(a[3]),  //3rd bit of reg a
    //     .b0(b[0]),
    //     .b1(b[1]),
    //     .b2(b[2]),
    //     .b3(b[3]),
    //     .s0(s[0]),
    //     .s1(s[1]),
    //     .s2(s[2]),
    //     .s3(s[3]),
    //     .c (c)
    // );
    adder dut(
        .a(a),
        .b(b),
        .c(c),
        .s(s)
    );
    initial begin
        a = 8'b00000000;
        b = 8'b00000000;
        #10;
        for(i=0; i<256; i=i+1)begin
            for(j=0; j<256; j=j+1)begin
                a = i;
                b = j;
                #10;
            end
        end
        //$stop;    //simulation pausing
        $finish;  //simulation ending
    end

endmodule
