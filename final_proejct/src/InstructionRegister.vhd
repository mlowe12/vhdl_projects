library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity InstructionRegister is

  generic(
      WIDTH: positive := 32
  );

  port(
    Memory_Address: in std_logic_vector(WIDTH-1 downto 0);
    IRWrite: in std_logic;
    clk: in std_logic;
    rst: in std_logic;
    out_0_to_15: out std_logic_vector(15 downto 0);
    out_11_to_15: out std_logic_vector(4 downto 0);
    out_16_to_20: out std_logic_vector(4 downto 0);
    out_21_to_25: out std_logic_vector(4 downto 0);
    out_26_to_31: out std_logic_vector(5 downto 0);
    out_0_to_25: out std_logic_vector(25 downto 0)
  );

end InstructionRegister;


architecture struct of InstructionRegister is
begin

  process(clk,Memory_Address,IRWrite)
  begin

    if(rst = '1') then
      out_26_to_31 <= (others => '0');
      out_21_to_25 <= (others =>  '0');
      out_16_to_20 <= (others => '0');
      out_11_to_15 <= (others => '0');
      out_0_to_15  <= (others => '0');
      out_0_to_25  <= (others => '0');

    elsif(clk'event and clk = '1') then
      if(IRWRite  = '1') then
        out_26_to_31 <= Memory_Address(WIDTH-1 downto 26);
        out_21_to_25 <= Memory_Address(25 downto 21);
        out_16_to_20 <= Memory_Address(20 downto 16);
        out_11_to_15 <= Memory_Address(15 downto 11);
        out_0_to_15  <= Memory_Address(15 downto 0);
        out_0_to_25  <= Memory_Address(25 downto 0);
      end if;
    end if;
  end process;

end struct;
