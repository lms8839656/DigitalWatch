module oness (rst, clk, en , q, rc);

input rst, clk, en;
output q;
output rc;

reg rco;

assign rc = en & rco;

always @ (posedge rst, posedge clk)
	if (!rst)	begin q <= 1'b0; rco <= 1'b0; end
	else if (en) 
		if (q ==1'b0) begin q<= 1'b1; rco <=1'b1; end
		else begin q <= 1'b0; rco<=1'b0; end



endmodule
