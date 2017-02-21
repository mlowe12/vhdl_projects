--Create a 4-bit hierarchical CLA (cla4.vhd) entity with a structural architecture that connects 2 of the 2-
--bit CLAs with one of the carry generators
--notes: must think in terms of distributing via 4 bit vector

library ieee; 
use ieee.std_logic_1164.all;

entity cla4 is
	port(
			x, y: in std_logic_vector(3 downto 0);
			cin: in std_logic; 
			s: out std_logic_vector(3 downto 0);
			cout, BP, BG: out std_logic
		); end cla4;


architecture HIERARCHY of cla4 is

signal car_CLA, prop_CLA0, prop_CLA1, gen_CLA1, gen_CLA0: std_logic; 

begin

	--generate carry gen for overall look ahead adder

	U_CGEN2: entity work.cgen2 port map(
		c_i => cin,
		p_i => prop_CLA0,
		g_i => gen_CLA0,
		g_i1 => prop_CLA1,
		p_i1 => gen_CLA1, 
		c_i1 => car_CLA, 
		c_i2 => cout,
		BP => BP, 
		BG => BG 

		); 
	

	-- for carry look ahead 0
	U_CLA20: entity work.cla2 port map(

		cin => cin, --recieves overall system carry in 
		x => x(1 downto 0),
		y => y(1 downto 0),
		s => s(1 downto 0), 
		BP => prop_CLA0,
		BG => gen_CLA0,
		cout => open

		);

	-- for carry look ahead 1
	U_CLA21: entity work.cla2 port map(
		
		cin => car_CLA, --intermediate carry 
		x => x(3 downto 2),
		y => y(3 downto 2),
		s => s(3 downto 2), 
		BP => prop_CLA1,
		BG => gen_CLA1,
		cout => open

		);


end HIERARCHY; 

