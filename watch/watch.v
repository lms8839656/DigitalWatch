/////////////////////////
//
//mode 3:time set
//		 2:alram set
//		 1:clock display
//selhm:3 am pm
//      2:hour
//      1:min
//
////////////////////////////
`define CLK clk10k
module watch (rst, clk, en, alen,imode, inc, iselhm, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, blink, LED, omode, oselhm);
input wire clk, en, rst;
input wire inc;
input wire alen;
input wire imode, iselhm;
output wire blink, LED;

output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6; // reflection
wire [0:6] cHEX0, cHEX1, cHEX2, cHEX3, cHEX4, cHEX5, cHEX6;
wire [0:6] aHEX0, aHEX1, aHEX2, aHEX3, aHEX4, aHEX5, aHEX6;
//wire [0:6] sHEX0, sHEX1, sHEX2, sHEX3, sHEX4, sHEX5, sHEX6;
reg [0:6] rHEX0, rHEX1, rHEX2, rHEX3, rHEX4, rHEX5, rHEX6;
reg [0:6] tHEX0, tHEX1, tHEX2, tHEX3, tHEX4, tHEX5, tHEX6;
//reg [0:6] stHEX0, stHEX1, stHEX2, stHEX3, stHEX4, stHEX5, stHEX6;
wire [6:0] sec, min;
wire [3:0] hour;
wire ap;
wire sout, mout, hout;
wire rst_n = ~rst;
assign blink = sec[0]; 



reg [3:1] mode, selhm;
output wire [2:1] omode, oselhm;
wire ones;

wire [6:0] amin;
wire [3:0] ahour;
wire aap;
wire amout, ahout;


wire [6:0] smin;
wire [3:0] shour;
wire smout, shout;


reg [6:0] tmin;
reg [3:0] thour;
reg rLED;
wire clk1M,clk10k,clk2k;
wire tc100h, tc1h;

clk_1k UC (
	.inclk0( clk),	// 50M
	.c0(clk1M),	// 1MHZ
	.c1(clk10k),	// 10k
	.c2(clk2k));	// 2k
	

	
wire incn = ~inc;

OS C8 (inc, `CLK, ones);
	
//modn default 12 cnt///////modn_cnt(rst, clk, en, q, rc);
modn_cnt #(7, 100) UC1 (1'b0, `CLK, en, , tc100h);
modn_cnt #(7, 100) UC2 (1'b0, `CLK, tc100h, , tc1h);

///time
mod60 US (rst_n, `CLK, tc1h, sec, sout);
mod60 UM (rst_n, `CLK, sout, min, mout);
mod12 UH (rst_n, `CLK, mout, hour, hout);
mod2 UN (rst_n, `CLK, hout, ap, );
//1 4 3+4 
seqhex H0 (mode[1], sec[3:0], cHEX0);
seqhex H1 (mode[1], {1'b0, sec[6:4]}, cHEX1);
seqhex H2 (mode[1], min[3:0], cHEX2);
seqhex H3 (mode[1], {1'b0, min[6:4]}, cHEX3);
dec12seg UD (mode[1], hour, {cHEX5,cHEX4});
//


/////////alram
mod60 AM (rst_n, ones, selhm[1], amin, amout);
mod12 AH (rst_n, ones, selhm[2], ahour, ahout);
mod2 AN (rst_n, inc, selhm[3], aap, );

seqhex A0 (mode[2], amin[3:0], aHEX2);
seqhex A1 (mode[2], {1'b0, amin[6:4]}, aHEX3);
dec12seg AD (mode[2], ahour, {aHEX5,aHEX4});


/*
/////set time
mod60 SM (rst_n, inc, selhm[1], min, mout);
mod12 SH (rst_n, inc, selhm[2], hour, hout);
//mod2 AN (rst_n, inc, selhm[3], aap, );
seqhex S0 (mode[3], min[3:0], cHEX2);
seqhex S1 (mode[3], {1'b0, min[6:4]}, cHEX3);
dec12seg SD (mode[3], ahour, {cHEX5,cHEX4});
*/


////////////


always @ (posedge iselhm) begin
	//selhm <= {selhm[2:1], selhm[3]};
	selhm <= {selhm[1], selhm[2]};
end

always @ (posedge imode) begin
	//mode <= {mode[2:1], mode[3]}; //modeshift
	mode <= {mode[1], mode[2]};
end



initial begin
	mode = 3'b001;
	selhm = 3'b001;
end




assign omode[2] = mode[2];
assign oselhm[2] = selhm[2];
assign omode[1] = mode[1];
assign oselhm[1] = selhm[1];




always @ (posedge `CLK) begin
if(mode[1]) begin
	if(alen &&
		(tHEX2 == rHEX2)&&
		(tHEX3 == rHEX3)&&
		(tHEX4 == rHEX4)&&
		(tHEX5 == rHEX5))
		//(tHEX6 == rHEX6))
		begin
		rLED = sec[0];
		end
		else  begin
		rLED = 1'b0;
		end
	end
end
//
always @ (posedge `CLK) begin
	if(mode[1]) begin
		rHEX0 = cHEX0;
		rHEX1 = cHEX1;
		rHEX2 = cHEX2;
		rHEX3 = cHEX3;
		rHEX4 = cHEX4;
		rHEX5 = cHEX5;
		rHEX6 = cHEX6;
	end
	else if(mode[2]) begin
		rHEX0 = 7'b1111111;
		rHEX1 = 7'b1111111;
		rHEX2 = aHEX2;
		rHEX3 = aHEX3;
		rHEX4 = aHEX4;
		rHEX5 = aHEX5;
		//rHEX6 = aHEX6;
		rHEX6 = 7'b1111111;
		tHEX0 = aHEX0;
		tHEX1 = aHEX1;
		tHEX2 = aHEX2;
		tHEX3 = aHEX3;
		tHEX4 = aHEX4;
		tHEX5 = aHEX5;
	end
end
	
assign HEX0 = rHEX0;
assign HEX1 = rHEX1;
assign HEX2 = rHEX2;
assign HEX3 = rHEX3;
assign HEX4 = rHEX4;
assign HEX5 = rHEX5;
assign HEX6 = rHEX6;
assign LED = rLED;
assign cHEX6 = (ap)? 7'b0011000 : 7'b000_1000;
endmodule
