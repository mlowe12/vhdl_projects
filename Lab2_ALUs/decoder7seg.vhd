--Michael Lowe
--EEL4717 Lab 2 7-seg decoder 
--Spring 2017

 

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity decoder7seg is
	port(
			input: in std_logic_vector(3 downto 0); --4 bit control input
			output: out std_logic_vector(6 downto 0) --7 segment output
	
	); 
	
end decoder7seg;

--begin behavioral architecture of 7 segment decoder given a 4-bit vector input
	--pins specified in Quartus in pin planner
		--architecture will be implemented and tested in decoder7seg_tb
		 
architecture LED_Display of decoder7seg is

signal in_not : std_logic_vector(3 downto 0); 

begin

in_not <= not(input); 
	
	process(input) --sensitivity list composed of  4 bit vector input 
		
	begin
		
		case in_not is
			
			when "0000" =>
			
				output <= "1000000"; --display "0"
				
			when "0001" =>
				
				output <= "1111001";  --display "1"
				
			when "0010" => 
				
				output <= "0100100";  --display "2"
				
			when "0011" =>
				
				output <= "0110000";  --display "3"
				
			when "0100" =>
				
				output <= "0011001";  --display "4"
				
			when "0101" =>
				
				output <= "0010010";  --display "5"
				
			when "0110" =>
				
				output <= "0000010";  --display "6"
				
			when "0111" =>
				
				output <= "1111000";  --display "7"
				
			when "1000" =>
				
				output <= "0000000";  --display "8"
				
			when "1001" =>
				
				output <= "0011000";  --display "9"
				
			when "1010" =>
				
				output <= "0001000";  --display "A"
				
			when "1011" =>
				
				output <= "0000011";  --display "b"
				
			when "1100" =>
				
				output <= "1000110";  --display "C"
				
			when "1101" =>
				
				output <= "0100001";  --display "d"
				
			when "1110" =>
				
				output <= "0000110";  --display "E"
				
			when "1111" =>
			 
				output <= "0001110";  --display "F"

			when others => null; --handles garbage input 
				
		end case;
		
	end process; 
	
end LED_Display; 

		
	
		
			
			
			
			
			
	



