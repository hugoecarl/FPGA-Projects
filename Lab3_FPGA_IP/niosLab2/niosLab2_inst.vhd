	component niosLab2 is
		port (
			clk_clk       : in  std_logic                    := 'X'; -- clk
			leds_1_name   : out std_logic_vector(3 downto 0);        -- name
			reset_reset_n : in  std_logic                    := 'X'  -- reset_n
		);
	end component niosLab2;

	u0 : component niosLab2
		port map (
			clk_clk       => CONNECTED_TO_clk_clk,       --    clk.clk
			leds_1_name   => CONNECTED_TO_leds_1_name,   -- leds_1.name
			reset_reset_n => CONNECTED_TO_reset_reset_n  --  reset.reset_n
		);

