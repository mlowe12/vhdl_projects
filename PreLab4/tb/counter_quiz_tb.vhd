library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity counter_quiz is 
	port(
		 mclk: in std_logic;
		 mrst: in std_logic; 
		 button_n: in std_logic;
		 load_n :in std_logic;
		 up_n: in std_logic;  
		 input :in std_logic_vector(3 downto 0); 
		 output: out std_logic_vector(3 downto 0));

	end counter_quiz; 


architecture BHV of counter_quiz is

signal gen_out: std_logisc; 
signal temp; 

U_GEN : entity work.clk_gen
	port map(
		clk5MHz => mclk, 
		rst => mrst, 
		button_n => button_n, 
		clk_out => gen_out)

generic(ms_period := 2);


U_COUNT : entity work.counter
	port map(
		clk => gen_out,
		rst =>rst,
		up_n => up_n,
		load_n => load_n,
		input =>input, 
		output => output); 

end BHV;  




