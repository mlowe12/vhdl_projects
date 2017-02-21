library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity clk_gen is
    generic (
        ms_period : positive);          -- amount of ms for button to be
                                        -- pressed before creating clock pulse
    port (
        clk50MHz : in  std_logic;
        rst      : in  std_logic;
        button_n : in  std_logic;
        clk_out  : out std_logic);

end clk_gen;


architecture BHV of clk_gen is

signal inter_out: std_logic; --output of clk_div
signal cnt: natural := 0; -- counter for external system 
signal temp: std_logic;  --temp holds output to be assigned


--component clk_div
--	generic(
	--		clk_in_freq: natural := 5000000, 
--			clk_out_freq: natural := 1000);
--	port(
--			clk_in: std_logic;
--			clk_out: std_logic;
--			rst: std_logic); 

--	end component; 

begin

U_DIV: entity work.clk_div
	generic map(
					clk_in_freq => 50000000, 
					clk_out_freq => 1000 )

	port map(
				clk_in => clk50MHz,
				clk_out => inter_out,
				rst => rst);



	process(inter_out, rst)
	begin

		if (rst = '1')
		then 
			clk_out <= '0'; 
			cnt <= 0; 
			--inter_out <= '0'; 

		elsif( inter_out'event and inter_out = '1')
		then
			if(button_n = '0')
			then
				if(ms_period = cnt) 
				then 
					clk_out <= '1';
					cnt <= cnt + 1;  
				elsif(cnt = ms_period + 1)
				then

					cnt <= 2;
					clk_out <= '0'; 	 
				else
					cnt <= cnt +1;

				end if;

				else
					cnt <= 0;
					clk_out <= '0';   


			end if;


		end if;



 		

	end process;

end BHV; 







