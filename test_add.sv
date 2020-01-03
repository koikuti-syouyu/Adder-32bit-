`include "add32.sv"

module TestAdd();
    reg clk = 0, rst = 1, adv = 0;
    reg [31:0] in_a, in_b;
    reg [31:0] result;
    reg c8;

    Add32 add32(.*);

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0, TestAdd);
        #10 rst = 0; clk = 0;
        #10 rst = 1;
        in_a = 32'h0000000A;
        in_b = 32'h0000000A;
        /*#10 clk = 1;
        #10 clk = 0;
        #10 clk = 1;
        #10 clk = 0;
        #10 clk = 1;
        #10 clk = 0;*/
        #10
        $display("%d, %d", result, c8);
    end
endmodule