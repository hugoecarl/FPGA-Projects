	component niosLab2 is
		port (
			clk_clk                            : in  std_logic                    := 'X';             -- clk
			leds_export                        : out std_logic_vector(5 downto 0);                    -- export
			pio_bot_external_connection_export : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			pio_mot_external_connection_export : out std_logic_vector(3 downto 0);                    -- export
			reset_reset_n                      : in  std_logic                    := 'X'              -- reset_n
		);
	end component niosLab2;

	u0 : component niosLab2
		port map (
			clk_clk                            => CONNECTED_TO_clk_clk,                            --                         clk.clk
			leds_export                        => CONNECTED_TO_leds_export,                        --                        leds.export
			pio_bot_external_connection_export => CONNECTED_TO_pio_bot_external_connection_export, -- pio_bot_external_connection.export
			pio_mot_external_connection_export => CONNECTED_TO_pio_mot_external_connection_export, -- pio_mot_external_connection.export
			reset_reset_n                      => CONNECTED_TO_reset_reset_n                       --                       reset.reset_n
		);

