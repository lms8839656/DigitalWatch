
//

module modn_cnt(rst, clk, en, q, rc);

parameter N = 4, M=12;

input wire clk, en, rst;
output wire [N-1:0] q;
output wire rc;


reg [N-1:0] r_reg;
wire rco_n;
wire [N-1:0] r_next;
reg rco;

assign rc = en & rco;
assign q = r_reg;
assign r_next = (r_reg==(M-1)) ? {N{1'b0}} : r_reg + 1'b1;
assign rco_n = (r_reg==(M-2)) ? 1'b1 : 1'b0;

always @ (posedge rst or posedge clk)
	if (rst) begin r_reg <= {N{1'b0}}; rco <= 1'b0; end
	else if (en) begin r_reg <= r_next; rco <= rco_n; end
	
endmodule


