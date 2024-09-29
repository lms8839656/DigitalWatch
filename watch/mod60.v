
// mod60

module mod60 (rst, clk, en, q, rco);

input wire clk, en, rst;
output wire [6:0] q;
output wire rco;
wire tc1, tc2;

assign rco = tc1 & tc2;

modn_cnt #(4, 10) U0 (rst, clk, en, q[3:0], tc1); // mod10
modn_cnt #(3, 6) U1 (rst, clk, tc1, q[6:4], tc2); // mod6

endmodule


