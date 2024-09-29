
`timescale 100 ps / 10 ps

module tb_watch;

reg clk, en, rst;
wire blink;

watch DUT (rst, clk, en, blink);

always #200 clk = ~clk;

initial begin
clk = 1'b0; rst = 1'b1; en = 1'b1;
#900 rst = 1'b0;
#4000 en = 1'b0;
#800 en = 1'b1;
#2000000 $stop;
end

endmodule
