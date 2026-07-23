`timescale 1ns / 1ps

module tb_full_adder();

     reg a,b,cin;
     wire s,c,s1,c1,c2;

    full_adder dut(
        .a(a),
        .b(b),
        .s(s1),
        .c(c1),
        .a(s1),
        .b(cin),
        .s(s),
        .c(c2)
    );
    
    initial begin
        a = 0;
        b = 0;
        #10;
        a = 0;
        b = 1;
        #10
        a = 1;
        b = 0;
        #10
        a = 1;
        b = 1;
        #10;
        $stop;
    end

endmodule
