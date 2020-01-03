`ifdef ADD32_ONCE
`else
`define ADD32_ONCE

`include "add.sv"

module Add32(
    input wire adv,
    input wire [31:0] in_a, in_b,
    output reg [31:0] result,
    output reg c8
);

    wire p0, p1, p2, p3, p4, p5, p6, p7;
    wire g0, g1, g2, g3, g4, g5, g6, g7;
    wire c1, c2, c3, c4, c5, c6, c7;

    Add add0(.adv(adv), .in_a(in_a[3:0]), .in_b(in_b[3:0]), .result(result[3:0]), .pp(p0), .gg(g0));
    Add add1(.adv(c1), .in_a(in_a[7:4]), .in_b(in_b[7:4]), .result(result[7:4]), .pp(p1), .gg(g1));
    Add add2(.adv(c2), .in_a(in_a[11:8]), .in_b(in_b[11:8]), .result(result[11:8]), .pp(p2), .gg(g2));
    Add add3(.adv(c3), .in_a(in_a[15:12]), .in_b(in_b[15:12]), .result(result[15:12]), .pp(p3), .gg(g3));
    Add add4(.adv(c4), .in_a(in_a[19:16]), .in_b(in_b[19:16]), .result(result[19:16]), .pp(p4), .gg(g4));
    Add add5(.adv(c5), .in_a(in_a[23:20]), .in_b(in_b[23:20]), .result(result[23:20]), .pp(p5), .gg(g5));
    Add add6(.adv(c6), .in_a(in_a[27:24]), .in_b(in_b[27:24]), .result(result[27:24]), .pp(p6), .gg(g6));
    Add add7(.adv(c7), .in_a(in_a[31:28]), .in_b(in_b[31:28]), .result(result[31:28]), .pp(p7), .gg(g7));

    assign c1 = g0 | (p0 & adv);
    assign c2 = g1 | (p1 & g0) | (p1 & p0 & adv);
    assign c3 = g2 | (p2 & g1) | (p2 & p1 & g0) | (p2 & p1 & p0 & adv);
    assign c4 = g3 | (p3 & g2) | (p3 & p2 & g1) | (p3 & p2 & p1 & g0) | (p3 & p2 & p1 & p0 & g0);
    assign c5 = g4 | (p4 & g3) | (p4 & p3 & g2) | (p4 & p3 & p2 & g1) | (p4 & p3 & p2 & p1 & g0) | (p4 & p3 & p2 & p1 & p0 & adv);
    assign c6 = g5 | (p5 & g4) | (p5 & p4 & g3) | (p5 & p4 & p3 & g2) | (p5 & p4 & p3 & p2 & g1) | (p5 & p4 & p3 & p2 & p1 & g0) |
                (p5 & p4 & p3 & p2 & p1 & p0 & adv);
    assign c7 = g6 | (p6 & g5) | (p6 & p5 & g4) | (p6 & p5 & p4 & g3) | (p6 & p5 & p4 & p3 & g2) | (p6 & p5 & p4 & p3 & p2 & g1) |
                (p6 & p5 & p4 & p3 & p2 & p1 & g0) | (p6 & p5 & p4 & p3 & p2 & p1 & p0 & adv);
    assign c8 = g7 | (p7 & g6) | (p7 & p6 & g5) | (p7 & p6 & p5 & g4) | (p7 & p6 & p5 & p4 & g3) | (p7 & p6 & p5 & p4 & p3 & g2) |
                (p7 & p6 & p5 & p4 & p3 & p2 & g1) | (p7 & p6 & p5 & p4 & p3 & p2 & p1 & g0) | (p7 & p6 & p5 & p4 & p3 & p2 & p1 & p0 & adv);

    /*always @(c8) begin
        if(c8 == 1'b1) begin
            $error("オーバフロー");
        end
    end*/

endmodule

`endif