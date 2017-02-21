library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        up_n   : in  std_logic;         -- active low
        load_n : in  std_logic;         -- active low
        input  : in  std_logic_vector(3 downto 0);
        output : out std_logic_vector(3 downto 0));

end counter;


architecture BHV of counter is

signal cnt: unsigned(3 downto 0);
--signal temp: unsigned(3 downto 0); 

begin
process(rst,clk)
begin

	if(rst = '1')
	then
		cnt <= (others => '0');

	elsif(clk'event and clk = '1')
	then 

		if(load_n = '0')
		then 
			cnt <= unsigned(input);  

		elsif(up_n = '0')
		then

			cnt <= cnt + 1;
			--temp <= std_logic_vector(cnt);

		else

			cnt <= cnt  -1; 
			--temp <= std_logic_vector(cnt); 

		end if;
	end if;  

end process;

output <= std_logic_vector(cnt);

end BHV;  






