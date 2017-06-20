module vgaaaa(	CLOCK_50, VGA_CLK, VGA_HS,	VGA_VS,	VGA_BLANK_N, VGA_SYNC_N, VGA_R, VGA_G, VGA_B, colour
);	

	input			CLOCK_50;				//	50 MHz
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[9:0]
	output	[7:0]	VGA_G;	 				//	VGA Green[9:0]
	output 	[7:0]	VGA_B;   				//	VGA Blue[9:0]
	reg	vga_clock=0;
	
	
	
	wire	[9:0]	x;
	wire	[9:0]	y;	

	input	[5:0]	colour;
	wire	[5:0]	colour;

	
	
	always@(posedge CLOCK_50)begin

		vga_clock<=~vga_clock;

	end

vga_controller vga_controller_inst(
	.vga_clock(vga_clock),
	.x(x), 
	.y(y),
	.VGA_R(VGA_R),
	.VGA_G(VGA_G),
	.VGA_B(VGA_B),
	.VGA_HS(VGA_HS),
	.VGA_VS(VGA_VS),
	.VGA_BLANK(VGA_BLANK_N),
	.VGA_SYNC(VGA_SYNC_N),
	.VGA_CLK(VGA_CLK),
	.colour(colour),
);	

endmodule

