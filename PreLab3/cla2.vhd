library ieee;
use ieee.std_logic_1164.all;


entity cla2 is
	port(
			x, y: in std_logic_vector(1 downto 0);
			s: out std_logic_vector(1 downto 0); 
			cin: in std_logic; 
			cout, BP, BG: out std_logic 
		); end cla2;

architecture CLA2_BHV of cla2 is
signal SUM, PROP, GEN : std_logic_vector(1 downto 0); 
signal C_car: std_logic; 

begin
	
	PROP <= x or y;
	GEN <= x and y;
	SUM <= x xor y;
	C_car <= GEN(0) or (PROP(0) and cin); 
	s(0) <= sum(0) xor cin;
	s(1) <= sum(1) xor C_car;
	BP <= PROP(1) and PROP(0); 
	BG <= GEN(1) and (PROP(1) and GEN(0)); 
	cout <= GEN(1) or (PROP(1) and C_car);

end CLA2_BHV; 





