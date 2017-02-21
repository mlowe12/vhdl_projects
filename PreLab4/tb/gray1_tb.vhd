library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gray1_tb is

end gray1_tb;

architecture TB of gray1_tb is

signal clk : std_logic := '0'; 
signal rst : std_logic; 
signal output: std_logic_vector(3 downto 0);
signal output2 :std_logic_vector(3 downto 0); 

begin  
U_GRAY2 : entity work.gray2
	port map(
				clk => clk,
				rst => rst, 
				output => output); 

 U_GRAY1 : entity work.gray1
	port map(
				clk => clk, 
				rst => rst, 
				output => output2);

	clk <= not clk after 10ns; 


	process 
	begin 

		rst <= '1';

		for i in 0 to  5 loop
			wait until clk'event and  clk = '1';

		end loop; 

		rst <= '0';

		for i in 0 to 1000 loop
			wait until clk'event and clk = '1';
		
		end loop;

		wait for 10ns; 

	end process; 

end TB;  