--Michael Lowe
--EEL4717 Lab 2 7-seg decoder test bench 
--Spring 2017

 

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity decoder7seg_tb is
	end decoder7seg_tb;
	
architecture TestBench of decoder7seg_tb is
	
	component decoder7seg
	
	generic(
			in_WIDTH : positive := 4;
			out_WIDTH : positive := 7
	);
	
	port(
			input: in std_logic_vector(in_WIDTH -1 downto 0); 
			output: out std_logic_vector(out_WIDTH -1  downto 0) 
	); 
	
end component;

--DELCARE INITIALIZATIONS FOR Test Bench 
constant in_WIDTH: positive  := 4;
constant out_WIDTH: positive := 7; 
signal input: std_logic_vector(in_WIDTH -1  downto 0) := (others => '0'); 
signal output: std_logic_vector(out_WIDTH -1  downto 0) := (others => '0');

begin --Test Bench
	
	U_Test: decoder7seg
	port map(
		input => input,
		output => output
		
	);
	
	process
		
	begin
		input <= "0000";
		wait for 100 ns; 
		
		input <= "0001";
		wait for 100 ns; 
		
		input <= "0010";
		wait for 100 ns; 
		
		input <= "0011";
		wait for 100 ns; 
		input <= "0100";
		wait for 100 ns; 
		
		input <= "0101";
		wait for 100 ns;
		input <= "0110";
		wait for 100 ns; 
		
		input <= "0111";
		wait for 100 ns;
		
		input <= "1000";
		wait for 100 ns; 
		
		input <= "1011";
		wait for 100 ns; 
		 
		 
		
		
		
		
		
		
	end process; 
end TestBench; 







	