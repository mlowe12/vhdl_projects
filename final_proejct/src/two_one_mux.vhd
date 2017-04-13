library ieee;
use ieee.std_logic_1164.all;


entity two_one_mux is
  generic(
      WIDTH: positive := 8
  );

  port(
      input1: in std_logic_vector(WIDTH-1 downto 0);
      input2: in std_logic_vector(WIDTH-1 downto 0);
      sel_line: in std_logic;
      output: out std_logic_vector(WIDTH-1 downto 0)
  );
end two_one_mux;


architecture BHV of two_one_mux is
begin
    process(sel_line, input1, input2)
    begin
      case sel_line is
        when '0' =>
          output <= input1;
        when '1' =>
          output <= input2;
        when others => null;
      end case;
    end process;
end BHV;
