library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_UNSIGNED.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity clk_div is
    generic(clk_in_freq  : natural;
            clk_out_freq : natural);
    port (
        clk_in  : in  std_logic;
        clk_out : out std_logic;
        rst     : in  std_logic);
end clk_div;

architecture BHV of clk_div is

--signal cnt: std_logic_vector(23 downto 0) := (others => '0'); -- 50MHz has 24-bit length
signal cnt: natural := 0;
constant ratio : natural :=  (((clk_in_freq/clk_out_freq)/2) - 1);
signal temp : std_logic;

begin 

	process(clk_in, rst)
	begin

		if rst = '1'
		then
			 cnt <= 0;
			 temp <= '0'; 


		elsif clk_in'event and clk_in = '1'
		then

			if(ratio = cnt)
			then 
				temp <= not (temp);
				cnt <= 0;  

			else 
				cnt <= cnt + 1;

			end if; 

		end if;

		
	end process;

	clk_out <= temp; 

end BHV;









