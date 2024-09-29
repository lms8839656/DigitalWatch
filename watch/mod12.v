
// mod12


module mod12 (rst, clk, en, q, rco);

input wire clk, en, rst;
output wire [3:0] q;
output wire rco;


modn_cnt #(4, 12) U0 (rst, clk, en, q[3:0], rco); // mod12

endmodule
