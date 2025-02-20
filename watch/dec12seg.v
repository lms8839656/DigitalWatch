module dec12seg (en, i, o1);
input en;
input [3:0] i;
output reg [13:0] o1;


always @ *
	case (i)
		4'h0 : o1 = 14'b000_0001_000_0001;	// 0_on
		4'h1 : o1 = 14'b000_0001_100_1111;
		4'h2 : o1 = 14'b000_0001_001_0010;
		4'h3 : o1 = 14'b000_0001_000_0110;
		4'h4 : o1 = 14'b000_0001_100_1100;
		4'h5 : o1 = 14'b000_0001_010_0100;
		4'h6 : o1 = 14'b000_0001_010_0000;
		4'h7 : o1 = 14'b000_0001_000_1101;
		4'h8 : o1 = 14'b000_0001_000_0000;
		4'h9 : o1 = 14'b000_0001_000_0100;
		4'ha : o1 = 14'b100_1111_000_0001;
		4'hb : o1 = 14'b100_1111_100_1111;
		4'hc : o1 = 14'b100_1111_001_0010;
	default:  o1 = 14'b000_0001_000_0001;
	endcase


endmodule