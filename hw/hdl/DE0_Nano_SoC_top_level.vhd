-- #############################################################################
-- DE0_Nano_SoC_top_level.vhd
--
-- BOARD         : DE0-Nano-SoC from Terasic
-- Author        : Sahand Kashani-Akhavan from Terasic documentation
-- Revision      : 1.1
-- Creation date : 11/06/2015
--
-- Syntax Rule : GROUP_NAME_N[bit]
--
-- GROUP : specify a particular interface (ex: SDR_)
-- NAME  : signal name (ex: CONFIG, D, ...)
-- bit   : signal index
-- _N    : to specify an active-low signal
-- #############################################################################

library ieee;
use ieee.std_logic_1164.all;

entity DE0_Nano_SoC_top_level is
    port(

        FPGA_CLK1_50     : in    std_logic;

        -- KEY
        KEY_N            : in    std_logic_vector(1 downto 0);

        -- LED
        LED              : out   std_logic_vector(7 downto 0);

   
        -- GPIO_0
        GPIO_0           : inout std_logic_vector(35 downto 0)

    );
end entity DE0_Nano_SoC_top_level;

architecture rtl of DE0_Nano_SoC_top_level is
		component system is
		port (
			avalon_pwm_0_conduit_end_writeresponsevalid : out std_logic;        -- writeresponsevalid
			clk_clk                                     : in  std_logic := 'X'; -- clk
			reset_reset_n                               : in  std_logic := 'X'  -- reset_n
		);
	end component system;

begin
u0 : component system
		port map (
			avalon_pwm_0_conduit_end_writeresponsevalid => GPIO_0(0), -- avalon_pwm_0_conduit_end.writeresponsevalid
			clk_clk                                     => FPGA_CLK1_50,                                     --                      clk.clk
			reset_reset_n                               => KEY_N(0)                                --                    reset.reset_n
		);

end;
