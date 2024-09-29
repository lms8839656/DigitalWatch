module OS (pbn, clk, tick);
input pbn, clk;
output tick;
reg tick;
reg [1:0] ps, ns;
localparam [1:0] zero = 2'b00, shot = 2'b10, one = 2'b01;

wire pb = ~pbn;

always @ (negedge pb, posedge clk)
	if (!pb) ps <= zero;
	else ps <=ns;

always @(ps, pb)
begin tick = 1'b0;
	case (ps)
		zero : if (pb) ns = shot; else ns = zero;
		one : if (pb) ns = one; else ns = zero;
		shot : begin tick = 1'b1;
			if (pb) ns = one; else ns =zero; end
		default : ns = zero;
	endcase
end
endmodule
