library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity counter_tb is

end counter_tb; 


architecture TB of counter_tb is 

signal input: std_logic_vector(3 downto 0); 
signal rst, up_n, load_n: std_logic;
signal clk: std_logic := '0';
signal output: std_logic_vector(3 downto 0); 

begin
U_COUNT : entity work.counter
	port map(
				clk => clk,
				rst => rst, 
				load_n => load_n, 
				up_n => up_n,
				input => input, 
				output => output);

clk <= not clk after 10ns; 


	process 
	begin
		rst <= '1'; 
		for i in 0 to 5 loop
			wait until clk'event and clk = '1'; 

		end loop;

		rst <= '0'; 
		up_n <= '0'; 
		load_n <= '1'; 

		for  i in 0 to 64 loop
			wait until clk'event and clk = '1'; 
		end loop; 

		rst <= '0'; 
		up_n <= '1';
		load_n <= '0'; 
		input <= "0110"; 

		for i in 0 to 64 loop
			wait until clk'event and clk = '1';

		end loop; 

		wait for 10ns; 

	end process; 

end TB; 



