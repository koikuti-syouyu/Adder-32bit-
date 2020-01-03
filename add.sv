`ifdef ADD_ONCE
`else
`define ADD_ONCE

//`include "reg1.sv"

module Add (
    input wire clk, rst, adv,
    input wire [3:0] in_a, in_b,
    output reg [3:0] result,
    output reg pp, gg
);

    wire [3:0] p, g, c, q;
    /*wire adv_reg_out1, adv_reg_out2, adv_reg_out3;

    Reg1 reg1_1(.clk(clk), .rst(rst), .in(adv), .out(adv_reg_out1));
    Reg1 reg1_2(.clk(clk), .rst(rst), .in(adv_reg_out1), .out(adv_reg_out2));
    Reg1 reg1_3(.clk(clk), .rst(rst), .in(adv_reg_out2), .out(adv_reg_out3));


    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            p <= 4'b0000;
            g <= 4'b0000;
        end else begin
            p <= in_a ^ in_b;
            g <= in_a & in_b;
        end
    end

    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            c <= 4'b0000;
        end else begin
            c[0] <= g[0] ^ p[0] & adv_reg_out2;
            c[1] <= g[1] ^ p[1] & (g[0] ^ p[0] & adv_reg_out2);
            c[2] <= g[2] ^ p[2] & g[1] ^ p[2] & p[1] & g[0] ^ p[2] & p[1] & p[0] & adv_reg_out2;
            c[3] <= g[3] ^ p[3] & g[2] ^ p[3] & p[2] & g[1] ^ p[3] & p[2] & p[1] & g[0] ^ p[3] & p[2] & p[1] & p[0] & adv_reg_out2;
        end
    end

    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            result <= 4'b0000;
            adv_out <= 1'b0;
        end else begin
            result[0] <= p[0] ^ adv_reg_out3;
            result[1] <= p[1] ^ c[0];
            result[2] <= p[2] ^ c[1];
            result[3] <= p[3] ^ c[2];
            adv_out <= c[3];
        end
    end*/

    assign p = in_a | in_b;
    assign q = in_a ^ in_b;
    assign g = in_a & in_b;
    assign pp = p[0] & p[1] &p[2] & p[3];
    assign gg = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);

    assign c[0] = g[0] | (p[0] & adv);
    assign c[1] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & adv);
    assign c[2] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & adv);
    assign c[3] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & adv);

    assign result[0] = q[0] ^ adv;
    assign result[1] = q[1] ^ c[0];
    assign result[2] = q[2] ^ c[1];
    assign result[3] = q[3] ^ c[2];

    
endmodule

`endif