	component system is
		port (
			avalon_pwm_0_conduit_end_writeresponsevalid : out std_logic;        -- writeresponsevalid
			clk_clk                                     : in  std_logic := 'X'; -- clk
			reset_reset_n                               : in  std_logic := 'X'  -- reset_n
		);
	end component system;

	u0 : component system
		port map (
			avalon_pwm_0_conduit_end_writeresponsevalid => CONNECTED_TO_avalon_pwm_0_conduit_end_writeresponsevalid, -- avalon_pwm_0_conduit_end.writeresponsevalid
			clk_clk                                     => CONNECTED_TO_clk_clk,                                     --                      clk.clk
			reset_reset_n                               => CONNECTED_TO_reset_reset_n                                --                    reset.reset_n
		);

