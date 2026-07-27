`timescale 1ns / 1ps

module tb_dut;

    // 입력 신호 선언
    reg  clk;
    reg  rst;
    reg  din_bit;

    // 출력 신호 선언
    wire dout_bit,dout_bit2;

    // DUT 인스턴스화 

    seq_det_moore U_moore (
        .clk(clk),
        .rst(rst),
        .din_bit(din_bit),
        .dout_bit(dout_bit)
    );

    seq_det_mealy dut (
        .clk(clk),
        .rst(rst),
        .din_bit(din_bit),
        .dout_bit(dout_bit2)
    );

    // 클럭 생성 (예: 10ns 주기)
    always #5 clk = ~clk;

    initial begin
        // 초기값 설정
        clk = 0;
        rst = 1;
        din_bit = 0;

        // 리셋 신호
        #10; rst = 0;

        // 입력 신호 패턴 (예시)
      
        #10; din_bit = 1;
        #10; din_bit = 0;
        #10; din_bit = 1;
        #10; din_bit = 0;
        #10; din_bit = 1;
        #10; din_bit = 0;
        #10; din_bit = 1;
        #10; din_bit = 0;
        #10; din_bit = 1;
        #10; din_bit = 0;
        #10; din_bit = 1;
        #10; din_bit = 0;
        // 시뮬레이션 종료
        #100 $finish;
    end

endmodule
