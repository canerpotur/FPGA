module vga_controller( CLOCK_50,	vga_clock, x, 	y,	VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK,
	VGA_SYNC, VGA_CLK);	

	parameter C_VERT_NUM_PIXELS  = 10'd480;
	parameter C_VERT_SYNC_START  = 10'd493;
	parameter C_VERT_SYNC_END    = 10'd494; //(C_VERT_SYNC_START + 2 - 1); 
	parameter C_VERT_TOTAL_COUNT = 10'd525;
	parameter C_HORZ_NUM_PIXELS  = 10'd640;
	parameter C_HORZ_SYNC_START  = 10'd659;
	parameter C_HORZ_SYNC_END    = 10'd754; //(C_HORZ_SYNC_START + 96 - 1); 
	parameter C_HORZ_TOTAL_COUNT = 10'd800;	

		


	
	input CLOCK_50;
	input			vga_clock;
	output	[9:0]	x;
	output	[9:0]	y;
	output reg[7:0] VGA_R;
	output reg[7:0] VGA_G;
	output reg[7:0] VGA_B;
	output reg		VGA_HS;
	output reg		VGA_VS;
	output reg		VGA_BLANK;
	output			VGA_SYNC;
	output			VGA_CLK;

	

	reg				VGA_HS1;
	reg				VGA_VS1;
	reg				VGA_BLANK1; 
	reg		[9:0]	xCounter=0;
	reg		[9:0]	yCounter=0;
	wire			xCounter_clear;
	wire			yCounter_clear;



	always @(posedge vga_clock)
	begin
		if (xCounter_clear)
			xCounter <= 10'd0;
		else
		begin
			xCounter <= xCounter + 1'b1;
		end
	end
	assign xCounter_clear = (xCounter == (C_HORZ_TOTAL_COUNT-1));



	always @(posedge vga_clock)
	begin
		if (xCounter_clear && yCounter_clear)
			yCounter <= 10'd0;
		else if (xCounter_clear)		//Increment when x counter resets
			yCounter <= yCounter + 1'b1;
	end
	
	assign yCounter_clear = (yCounter == (C_VERT_TOTAL_COUNT-1)); 
	assign x = xCounter;
	assign y = yCounter;

	

	always @(posedge vga_clock)
	begin
		VGA_HS1 <= ~((xCounter >= C_HORZ_SYNC_START) && (xCounter <= C_HORZ_SYNC_END));
		VGA_VS1 <= ~((yCounter >= C_VERT_SYNC_START) && (yCounter <= C_VERT_SYNC_END));
		VGA_BLANK1 <= ((xCounter < C_HORZ_NUM_PIXELS) && (yCounter < C_VERT_NUM_PIXELS));	

	//DELAY//
		VGA_HS <= VGA_HS1;
		VGA_VS <= VGA_VS1;
		VGA_BLANK <= VGA_BLANK1;	

	end

	

	/* VGA sync should be 1 at all times. */

	assign VGA_SYNC = 1'b1;

	

	/* Generate the VGA clock signal. */

	assign VGA_CLK = vga_clock;
	reg [7:0] rom[0:76899];
	reg signed [10:0]X = 10'd280;
	reg signed [10:0]Y = 10'd200;
	wire [16:0] FUNC;
   assign FUNC = y*240+x;
	reg[7:0] Q1;
	
	initial
    begin
        $readmemh("nonoise1.hex", rom);
    end
	 always @ (posedge CLOCK_50)
	 begin
	 Q1=rom[FUNC];
	 end
	

    always @ (posedge CLOCK_50)
    begin
	 
	 if ( x<240 && y<320)
			begin
			
      VGA_R<= Q1;
		VGA_G<= Q1;
		VGA_B<= Q1;
    end

end


endmodule
