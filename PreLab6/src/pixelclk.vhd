library ieee;
use ieee.std_logic_1164.all;

entity pixelclk is
    port(
          clk: in std_logic;
          reset: in std_logic;
          pixel_clock: out std_logic
    );

end pixelclk;

-- enable architecture to cut 50Mhz clock in half to 25Mhz

architecture BHV of pixelclk is
signal temp: std_logic;
begin
        process(clk,reset)
        begin

          if reset = '1' then
            temp <= '0';

          elsif(clk'event and clk = '1') then
               temp <= not temp;
           end if;
         end process;

         pixel_clock <= temp;


end BHV;
