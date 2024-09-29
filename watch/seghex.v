module seqhex (en, bin, hex);
input en;
input wire [3:0] bin;
output reg [6:0] hex;

always @ *
	case (bin)
		4'h0 : hex = 7'b000_0001;	// 0_on
		4'h1 : hex = 7'b100_1111;
		4'h2 : hex = 7'b001_0010;
		4'h3 : hex = 7'b000_0110;
		4'h4 : hex = 7'b100_1100;
		4'h5 : hex = 7'b010_0100;
		4'h6 : hex = 7'b010_0000;
		4'h7 : hex = 7'b000_1101;
		4'h8 : hex = 7'b000_0000;
		4'h9 : hex = 7'b000_0100;
		4'ha : hex = 7'b000_1000;
		4'hb : hex = 7'b110_0000;
		4'hc : hex = 7'b111_0010;
		4'hd : hex = 7'b100_0010;
		4'he : hex = 7'b011_0000;
		4'hf : hex = 7'b011_1000;
	default:  hex = 7'b000_0001;
	endcase

endmodule
