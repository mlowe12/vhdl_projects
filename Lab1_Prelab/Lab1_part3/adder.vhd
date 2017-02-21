library ieee;
use ieee.std_logic_1164.all;

-- DO NOT CHANGE ANYTHING IN THE ENTITY

entity adder is
  port (
    input1    : in  std_logic_vector(3 downto 0);
    input2    : in  std_logic_vector(3 downto 0);
    carry_in  : in  std_logic;
    sum       : out std_logic_vector(3 downto 0);
    carry_out : out std_logic);
end adder;

-- DEFINE A RIPPLE-CARRY ADDER USING A STRUCTURE DESCRIPTION THAT CONSISTS OF 4
-- FULL ADDERS

architecture STR of adder is 
	signal mini_carry: std_logic_vector(3 downto 1); --inputs into intermediate ripple carry_outs
	component fullAdder port(
	input1, input2, carry_in: in std_logic; 
	sum, carry_out: out std_logic
	 
	); end component; 
begin  -- STR
		--initializations for each port map 
	fa0: fullAdder port map(
		carry_in, input1(0), input2(0), mini_carry(1), sum(0)
	); 
	
	fa1: fullAdder port map(
		mini_carry(1), input1(1), input2(1), mini_carry(2), sum(1)
	); 
	
	fa2: fullAdder port map(
		mini_carry(2), input1(2), input2(2), mini_carry(3), sum(2)
	);
	
	fa3: fullAdder port map(
		mini_carry(3), input1(3), input2(3), carry_out, sum(3)
	); 
	
	
	
	
	


end STR;


