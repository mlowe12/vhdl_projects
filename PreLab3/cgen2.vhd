library ieee; 
use ieee.std_logic_1164.all; 

entity cgen2 is
	port(
			c_i, p_i, g_i, g_i1, p_i1: in std_logic;
			c_i1, c_i2, BP, BG: out std_logic 

		); end cgen2;

architecture cgen2_BHV of cgen2 is
signal C_car: std_logic;

begin
	C_car <= g_i or (p_i and c_i);
	c_i1 <= C_car;
	c_i2 <= g_i1 or (p_i1 and C_car);
	BP <= p_i1 and p_i; 
	BG <= g_i1 or (p_i1 and g_i1);

end cgen2_BHV; 