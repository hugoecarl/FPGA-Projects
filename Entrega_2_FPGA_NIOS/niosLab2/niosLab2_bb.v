
module niosLab2 (
	clk_clk,
	leds_export,
	pio_bot_external_connection_export,
	pio_mot_external_connection_export,
	reset_reset_n);	

	input		clk_clk;
	output	[5:0]	leds_export;
	input	[3:0]	pio_bot_external_connection_export;
	output	[3:0]	pio_mot_external_connection_export;
	input		reset_reset_n;
endmodule
