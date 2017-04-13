library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity REG is
  generic(WIDTH: positive  := 32);

  port(
        clk: in std_logic;
        rst: in std_logic;
        en: in std_logic;
        input: in std_logic_vector(WIDTH-1 downto 0);
        output: out std_logic_vector(WIDTH-1 downto 0)
  );

end REG;

architecture struct of REG is

  signal temp: std_logic_vector(WIDTH-1 downto 0);

  begin
    process(clk,rst, input)
    begin
      if(rst = '1') then
        temp <= (others => '0');
      elsif(clk'event and clk = '1') then
        temp <= input;
      end if;
  end process;

end struct;
