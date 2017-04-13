library ieee;
use ieee.std_logic_1164.all;


entity four_one_mux is
  generic(
      WIDTH: positive := 8
  );

  port(
      input1: in std_logic_vector(WIDTH-1 downto 0);
      input2: in std_logic_vector(WIDTH-1 downto 0);
      input3: in std_logic_vector(WIDTH-1 downto 0);
      input4: in std_logic_vector(WIDTH-1 downto 0);
      sel_line: in std_logic_vector(1 downto 0);
      output: out std_logic_vector(WIDTH-1 downto 0)
  );
end four_one_mux;


architecture BHV of four_one_mux is
begin
  process(sel_line, input1, input2, input3, input4)
  begin
    case sel_line is
      when "00" =>
        output <= input1;
      when "01" =>
        output <= input2;
      when "10" =>
        output <= input3;
      when "11" =>
        output <= input4;
      when others => null;
    end case;
  end process;
end BHV;
