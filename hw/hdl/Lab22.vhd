LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Lab22 is
port
	(
		clk     :  IN STD_LOGIC;
		Reset_n :  IN STD_LOGIC;
		Adr     :  IN STD_LOGIC_VECTOR(1 downto 0);
		CS      :  IN STD_LOGIC;
		Rd      :  IN STD_LOGIC;
		Wr      :  IN STD_LOGIC;
		WRData  :  IN STD_LOGIC_VECTOR(31 downto 0);
		RDData  :  OUT STD_LOGIC_VECTOR(31 downto 0);
		PWMa    :  OUT STD_LOGIC
	);
end Lab22;


architecture comp of Lab22 is

signal RegPeriod    :  unsigned(31 downto 0);     --Reg. Periode of PWM
signal RegNewDuty   :  unsigned(31 downto 0);     --Reg. Duty cylce
signal RegPol       :  std_logic;                 --Reg. Polarity
signal CntPWM       :  unsigned(31 downto 0);     --Counter for PWM
signal PWMEn        :  std_logic;                 --PWM enable Begin

Begin


-----------------------------------------------
-----------------------------------------------
---------------- Parallel port ----------------
-----------------------------------------------
-----------------------------------------------

-- Process to write internal registers through Avalon bus interface 
-- Synchronous access in rising_edge of clk 
-- Addresses allows to select write registers if CS and Wr activated

WrReg: process(clk, Reset_n)							  -- Write by Avalon slave access
	begin
		if Reset_n = '0' then							  
			RegPeriod <= (others => '0');
			RegNewDuty <= (others => '0');
			PWMEn <= '0';
		elsif rising_edge(clk) then
			if (CS = '1') and (Wr = '1') then
			case Adr is 
				when "00" => 
					RegPeriod <= unsigned(WRData);
				when "01" =>
					RegNewDuty <= unsigned(WRData);
				when "10" =>
					PWMEn <= WRData(0);
				when "11" =>
					RegPol <= WRData(0);
				when others =>
					null;
				end case;
			end if;
		end if;
	end process WrReg;

-- Process to read the different sources of data by the Avalon bus interface 
RdReg: process(Cs, Rd, Adr, RegPeriod, RegNewDuty, PWMEn, RegPol)
	begin
		if rising_edge(clk) then
			RDData <= (others => '0');
			if (CS = '1') and (Rd = '1') then
				case Adr is
					when "00" =>
						RDData <= std_logic_vector(RegPeriod);
					when "01" =>
						RDData <= std_logic_vector(RegNewDuty);
					when "10" =>
						RDData(0) <= PWMEn;
					when "11" =>
						RDData(0) <= RegPol;
					when others =>
						RDData <= (others => '0');
				end case;
			end if;
		end if;
	end process RdReg;

	
-----------------------------------------------
-----------------------------------------------
--------------- PWM Controller ----------------
-----------------------------------------------
-----------------------------------------------

-- Process to generate PWM 

-- Process to count until Period value
CountingPWM: process(clk, Reset_n)
begin
	if Reset_n = '0' then
		CntPWM <= (others => '0');
	elsif rising_edge(clk) then
		if (CntPWM < (RegPeriod - 1)) then
			CntPWM <= CntPWM + 1;
		else
			CntPWM <= (others => '0');
		end if;
	end if;
end process CountingPWM;

-- Process to assign PWM value and polarity
Pulse: process(clk, Reset_n)
begin
	if Reset_n = '0' then
		PWMa <= '0';
	elsif rising_edge(clk) then
		if (PWMEn = '1') then
			if (RegPol = '0') then
				if (RegNewDuty > CntPWM) then
					PWMa <= '1';
				else
					PWMa <= '0';
				end if;
			elsif (RegPol = '1') then
				if (RegNewDuty > CntPWM) then
					PWMa <= '0';
				else
					PWMa <= '1';
				end if;
			end if;
		end if;
	end if;
end process Pulse;

				
End comp;
