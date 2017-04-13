library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pixelclk_tb is
end pixelclk_tb;

architecture tb of pixelclk_tb is
    signal clock: std_logic := '0';
    signal pixclk: std_logic;
    signal reset: std_logic := '0';

    begin
      UUT: entity work.pixel_clock
      port map(
        clk => clock,
        reset => reset,
        pixel_clock => pixle_clock
      );

      process
      begin
        reset <= '1';
        wait for 40 ns;
        reset <= '0';
          for i in 0 to 1000 loop
            clock <= not clock;
            wait for 10 ns;
          end loop;

          wait;
        end process;

end tb;
