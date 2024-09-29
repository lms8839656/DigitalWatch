module mod2 (rst, clk, en, q, rco);

input wire clk, en, rst;
output wire  q;
output wire rco;


modn_cnt #(1, 2) U1 (rst, clk, en, q, rco); // mod2

endmodule


